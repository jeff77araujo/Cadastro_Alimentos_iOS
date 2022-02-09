import UIKit

protocol AdicionaRefeicaoDelegate {
    func adicionar(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //    MARK: IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet weak var felicidadeTextField: UITextField?
    @IBOutlet weak var tableView: UITableView?
    
    //    MARK: Atributos
    
    var delegate: AdicionaRefeicaoDelegate?
    var itensSelecionados: [Item] = []
    var itens = [Item(nome: "Pizza", calorias: 200),
                 Item(nome: "Bolo", calorias: 140)]
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        let botaoAddItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItem))
        navigationItem.rightBarButtonItem = botaoAddItem
        recuperaItens()
    }
    
    func recuperaItens() {
        itens = ItemDao().recupera()
    }
    
    @objc func adicionarItem() {
        let rootVC = AdicionarItemsViewController(delegate: self)
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    //    MARK: IBActions
    
    @IBAction func adicionar(_ sender: Any) {
        guard let refeicao = recuperaRefeicao() else { return }
        delegate?.adicionar(refeicao)
        navigationController?.popViewController(animated: true)
    }
    
    func recuperaRefeicao() -> Refeicao? {
        guard let nomeDaRefeicao = nomeTextField?.text else { return nil }
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else { return nil }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        return refeicao
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let item = itens[indexPath.row].nome
        cell.textLabel?.text = item
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            cell.tintColor = .systemGreen
            
            itensSelecionados.append(itens[indexPath.row])
        } else {
            cell.accessoryType = .none
            guard let position = itensSelecionados.index(of: itens[indexPath.row]) else { return }
            itensSelecionados.remove(at: position)
        }
        return tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: AdicionarItemsViewControllerDelegate {
    func addItemList(_ item: Item) {
        itens.append(item)
        ItemDao().save(itens)
        if let table = tableView {
            table.reloadData()
        } else {
            Alerta(controller: self).exibe(mensagem: "Erro ao atualizar a tabela.")
        }
    }
}
