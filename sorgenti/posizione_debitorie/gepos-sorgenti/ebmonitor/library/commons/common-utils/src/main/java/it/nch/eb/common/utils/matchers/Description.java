/**
 * Created on 22/feb/08
 */
package it.nch.eb.common.utils.matchers;


/**
 * @author gdefacci
 */
public interface Description {

	Description append(SelfDescribing sf);
	Description append(String str);
	Description append(Object obj);
}