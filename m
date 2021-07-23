Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACD33D3DAF
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 18:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhGWP41 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 11:56:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:2252 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhGWP41 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 11:56:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="275729976"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="gz'50?scan'50,208,50";a="275729976"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 09:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="gz'50?scan'50,208,50";a="434159579"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jul 2021 09:36:55 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6yAQ-00025Z-Th; Fri, 23 Jul 2021 16:36:54 +0000
Date:   Sat, 24 Jul 2021 00:36:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        mustafa.ismail@intel.com
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        shiraz.saleem@intel.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] RDMA/irdma: Fix missing error code in
 irdma_modify_qp_roce()
Message-ID: <202107240029.sV8Wi0E0-lkp@intel.com>
References: <1627036373-69929-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <1627036373-69929-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiapeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on v5.14-rc2 next-20210723]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jiapeng-Chong/RDMA-irdma-Fix-missing-error-code-in-irdma_modify_qp_roce/20210723-183422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: x86_64-randconfig-a003-20210723 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 9625ca5b602616b2f5584e8a49ba93c52c141e40)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # https://github.com/0day-ci/linux/commit/c4d5794806c724fafed155d5d1186fc7cecba055
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiapeng-Chong/RDMA-irdma-Fix-missing-error-code-in-irdma_modify_qp_roce/20210723-183422
        git checkout c4d5794806c724fafed155d5d1186fc7cecba055
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/irdma/verbs.c:1347:5: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                                   goto exit;
                                   ^
   drivers/infiniband/hw/irdma/verbs.c:1345:4: note: previous statement is here
                           if (iwqp->iwarp_state == IRDMA_QP_STATE_SQD)
                           ^
   1 warning generated.


vim +/if +1347 drivers/infiniband/hw/irdma/verbs.c

b48c24c2d710cf Mustafa Ismail 2021-06-02  1106  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1107  /**
b48c24c2d710cf Mustafa Ismail 2021-06-02  1108   * irdma_modify_qp_roce - modify qp request
b48c24c2d710cf Mustafa Ismail 2021-06-02  1109   * @ibqp: qp's pointer for modify
b48c24c2d710cf Mustafa Ismail 2021-06-02  1110   * @attr: access attributes
b48c24c2d710cf Mustafa Ismail 2021-06-02  1111   * @attr_mask: state mask
b48c24c2d710cf Mustafa Ismail 2021-06-02  1112   * @udata: user data
b48c24c2d710cf Mustafa Ismail 2021-06-02  1113   */
b48c24c2d710cf Mustafa Ismail 2021-06-02  1114  int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1115  			 int attr_mask, struct ib_udata *udata)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1116  {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1117  	struct irdma_pd *iwpd = to_iwpd(ibqp->pd);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1118  	struct irdma_qp *iwqp = to_iwqp(ibqp);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1119  	struct irdma_device *iwdev = iwqp->iwdev;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1120  	struct irdma_sc_dev *dev = &iwdev->rf->sc_dev;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1121  	struct irdma_qp_host_ctx_info *ctx_info;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1122  	struct irdma_roce_offload_info *roce_info;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1123  	struct irdma_udp_offload_info *udp_info;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1124  	struct irdma_modify_qp_info info = {};
b48c24c2d710cf Mustafa Ismail 2021-06-02  1125  	struct irdma_modify_qp_resp uresp = {};
b48c24c2d710cf Mustafa Ismail 2021-06-02  1126  	struct irdma_modify_qp_req ureq = {};
b48c24c2d710cf Mustafa Ismail 2021-06-02  1127  	unsigned long flags;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1128  	u8 issue_modify_qp = 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1129  	int ret = 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1130  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1131  	ctx_info = &iwqp->ctx_info;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1132  	roce_info = &iwqp->roce_info;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1133  	udp_info = &iwqp->udp_info;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1134  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1135  	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1136  		return -EOPNOTSUPP;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1137  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1138  	if (attr_mask & IB_QP_DEST_QPN)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1139  		roce_info->dest_qp = attr->dest_qp_num;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1140  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1141  	if (attr_mask & IB_QP_PKEY_INDEX) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1142  		ret = irdma_query_pkey(ibqp->device, 0, attr->pkey_index,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1143  				       &roce_info->p_key);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1144  		if (ret)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1145  			return ret;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1146  	}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1147  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1148  	if (attr_mask & IB_QP_QKEY)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1149  		roce_info->qkey = attr->qkey;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1150  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1151  	if (attr_mask & IB_QP_PATH_MTU)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1152  		udp_info->snd_mss = ib_mtu_enum_to_int(attr->path_mtu);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1153  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1154  	if (attr_mask & IB_QP_SQ_PSN) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1155  		udp_info->psn_nxt = attr->sq_psn;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1156  		udp_info->lsn =  0xffff;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1157  		udp_info->psn_una = attr->sq_psn;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1158  		udp_info->psn_max = attr->sq_psn;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1159  	}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1160  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1161  	if (attr_mask & IB_QP_RQ_PSN)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1162  		udp_info->epsn = attr->rq_psn;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1163  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1164  	if (attr_mask & IB_QP_RNR_RETRY)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1165  		udp_info->rnr_nak_thresh = attr->rnr_retry;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1166  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1167  	if (attr_mask & IB_QP_RETRY_CNT)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1168  		udp_info->rexmit_thresh = attr->retry_cnt;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1169  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1170  	ctx_info->roce_info->pd_id = iwpd->sc_pd.pd_id;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1171  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1172  	if (attr_mask & IB_QP_AV) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1173  		struct irdma_av *av = &iwqp->roce_ah.av;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1174  		const struct ib_gid_attr *sgid_attr;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1175  		u16 vlan_id = VLAN_N_VID;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1176  		u32 local_ip[4];
b48c24c2d710cf Mustafa Ismail 2021-06-02  1177  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1178  		memset(&iwqp->roce_ah, 0, sizeof(iwqp->roce_ah));
b48c24c2d710cf Mustafa Ismail 2021-06-02  1179  		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1180  			udp_info->ttl = attr->ah_attr.grh.hop_limit;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1181  			udp_info->flow_label = attr->ah_attr.grh.flow_label;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1182  			udp_info->tos = attr->ah_attr.grh.traffic_class;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1183  			irdma_qp_rem_qos(&iwqp->sc_qp);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1184  			dev->ws_remove(iwqp->sc_qp.vsi, ctx_info->user_pri);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1185  			ctx_info->user_pri = rt_tos2priority(udp_info->tos);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1186  			iwqp->sc_qp.user_pri = ctx_info->user_pri;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1187  			if (dev->ws_add(iwqp->sc_qp.vsi, ctx_info->user_pri))
b48c24c2d710cf Mustafa Ismail 2021-06-02  1188  				return -ENOMEM;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1189  			irdma_qp_add_qos(&iwqp->sc_qp);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1190  		}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1191  		sgid_attr = attr->ah_attr.grh.sgid_attr;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1192  		ret = rdma_read_gid_l2_fields(sgid_attr, &vlan_id,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1193  					      ctx_info->roce_info->mac_addr);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1194  		if (ret)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1195  			return ret;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1196  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1197  		if (vlan_id >= VLAN_N_VID && iwdev->dcb)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1198  			vlan_id = 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1199  		if (vlan_id < VLAN_N_VID) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1200  			udp_info->insert_vlan_tag = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1201  			udp_info->vlan_tag = vlan_id |
b48c24c2d710cf Mustafa Ismail 2021-06-02  1202  				ctx_info->user_pri << VLAN_PRIO_SHIFT;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1203  		} else {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1204  			udp_info->insert_vlan_tag = false;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1205  		}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1206  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1207  		av->attrs = attr->ah_attr;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1208  		rdma_gid2ip((struct sockaddr *)&av->sgid_addr, &sgid_attr->gid);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1209  		rdma_gid2ip((struct sockaddr *)&av->dgid_addr, &attr->ah_attr.grh.dgid);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1210  		roce_info->local_qp = ibqp->qp_num;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1211  		if (av->sgid_addr.saddr.sa_family == AF_INET6) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1212  			__be32 *daddr =
b48c24c2d710cf Mustafa Ismail 2021-06-02  1213  				av->dgid_addr.saddr_in6.sin6_addr.in6_u.u6_addr32;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1214  			__be32 *saddr =
b48c24c2d710cf Mustafa Ismail 2021-06-02  1215  				av->sgid_addr.saddr_in6.sin6_addr.in6_u.u6_addr32;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1216  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1217  			irdma_copy_ip_ntohl(&udp_info->dest_ip_addr[0], daddr);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1218  			irdma_copy_ip_ntohl(&udp_info->local_ipaddr[0], saddr);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1219  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1220  			udp_info->ipv4 = false;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1221  			irdma_copy_ip_ntohl(local_ip, daddr);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1222  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1223  			udp_info->arp_idx = irdma_arp_table(iwdev->rf,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1224  							    &local_ip[0],
b48c24c2d710cf Mustafa Ismail 2021-06-02  1225  							    false, NULL,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1226  							    IRDMA_ARP_RESOLVE);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1227  		} else {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1228  			__be32 saddr = av->sgid_addr.saddr_in.sin_addr.s_addr;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1229  			__be32 daddr = av->dgid_addr.saddr_in.sin_addr.s_addr;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1230  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1231  			local_ip[0] = ntohl(daddr);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1232  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1233  			udp_info->ipv4 = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1234  			udp_info->dest_ip_addr[0] = 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1235  			udp_info->dest_ip_addr[1] = 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1236  			udp_info->dest_ip_addr[2] = 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1237  			udp_info->dest_ip_addr[3] = local_ip[0];
b48c24c2d710cf Mustafa Ismail 2021-06-02  1238  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1239  			udp_info->local_ipaddr[0] = 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1240  			udp_info->local_ipaddr[1] = 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1241  			udp_info->local_ipaddr[2] = 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1242  			udp_info->local_ipaddr[3] = ntohl(saddr);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1243  		}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1244  		udp_info->arp_idx =
b48c24c2d710cf Mustafa Ismail 2021-06-02  1245  			irdma_add_arp(iwdev->rf, local_ip, udp_info->ipv4,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1246  				      attr->ah_attr.roce.dmac);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1247  	}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1248  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1249  	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1250  		if (attr->max_rd_atomic > dev->hw_attrs.max_hw_ord) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1251  			ibdev_err(&iwdev->ibdev,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1252  				  "rd_atomic = %d, above max_hw_ord=%d\n",
b48c24c2d710cf Mustafa Ismail 2021-06-02  1253  				  attr->max_rd_atomic,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1254  				  dev->hw_attrs.max_hw_ord);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1255  			return -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1256  		}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1257  		if (attr->max_rd_atomic)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1258  			roce_info->ord_size = attr->max_rd_atomic;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1259  		info.ord_valid = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1260  	}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1261  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1262  	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1263  		if (attr->max_dest_rd_atomic > dev->hw_attrs.max_hw_ird) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1264  			ibdev_err(&iwdev->ibdev,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1265  				  "rd_atomic = %d, above max_hw_ird=%d\n",
b48c24c2d710cf Mustafa Ismail 2021-06-02  1266  				   attr->max_rd_atomic,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1267  				   dev->hw_attrs.max_hw_ird);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1268  			return -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1269  		}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1270  		if (attr->max_dest_rd_atomic)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1271  			roce_info->ird_size = attr->max_dest_rd_atomic;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1272  	}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1273  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1274  	if (attr_mask & IB_QP_ACCESS_FLAGS) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1275  		if (attr->qp_access_flags & IB_ACCESS_LOCAL_WRITE)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1276  			roce_info->wr_rdresp_en = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1277  		if (attr->qp_access_flags & IB_ACCESS_REMOTE_WRITE)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1278  			roce_info->wr_rdresp_en = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1279  		if (attr->qp_access_flags & IB_ACCESS_REMOTE_READ)
b48c24c2d710cf Mustafa Ismail 2021-06-02  1280  			roce_info->rd_en = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1281  	}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1282  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1283  	wait_event(iwqp->mod_qp_waitq, !atomic_read(&iwqp->hw_mod_qp_pend));
b48c24c2d710cf Mustafa Ismail 2021-06-02  1284  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1285  	ibdev_dbg(&iwdev->ibdev,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1286  		  "VERBS: caller: %pS qp_id=%d to_ibqpstate=%d ibqpstate=%d irdma_qpstate=%d attr_mask=0x%x\n",
b48c24c2d710cf Mustafa Ismail 2021-06-02  1287  		  __builtin_return_address(0), ibqp->qp_num, attr->qp_state,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1288  		  iwqp->ibqp_state, iwqp->iwarp_state, attr_mask);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1289  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1290  	spin_lock_irqsave(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1291  	if (attr_mask & IB_QP_STATE) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1292  		if (!ib_modify_qp_is_ok(iwqp->ibqp_state, attr->qp_state,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1293  					iwqp->ibqp.qp_type, attr_mask)) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1294  			ibdev_warn(&iwdev->ibdev, "modify_qp invalid for qp_id=%d, old_state=0x%x, new_state=0x%x\n",
b48c24c2d710cf Mustafa Ismail 2021-06-02  1295  				   iwqp->ibqp.qp_num, iwqp->ibqp_state,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1296  				   attr->qp_state);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1297  			ret = -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1298  			goto exit;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1299  		}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1300  		info.curr_iwarp_state = iwqp->iwarp_state;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1301  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1302  		switch (attr->qp_state) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1303  		case IB_QPS_INIT:
b48c24c2d710cf Mustafa Ismail 2021-06-02  1304  			if (iwqp->iwarp_state > IRDMA_QP_STATE_IDLE) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1305  				ret = -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1306  				goto exit;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1307  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1308  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1309  			if (iwqp->iwarp_state == IRDMA_QP_STATE_INVALID) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1310  				info.next_iwarp_state = IRDMA_QP_STATE_IDLE;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1311  				issue_modify_qp = 1;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1312  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1313  			break;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1314  		case IB_QPS_RTR:
b48c24c2d710cf Mustafa Ismail 2021-06-02  1315  			if (iwqp->iwarp_state > IRDMA_QP_STATE_IDLE) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1316  				ret = -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1317  				goto exit;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1318  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1319  			info.arp_cache_idx_valid = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1320  			info.cq_num_valid = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1321  			info.next_iwarp_state = IRDMA_QP_STATE_RTR;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1322  			issue_modify_qp = 1;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1323  			break;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1324  		case IB_QPS_RTS:
b48c24c2d710cf Mustafa Ismail 2021-06-02  1325  			if (iwqp->ibqp_state < IB_QPS_RTR ||
b48c24c2d710cf Mustafa Ismail 2021-06-02  1326  			    iwqp->ibqp_state == IB_QPS_ERR) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1327  				ret = -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1328  				goto exit;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1329  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1330  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1331  			info.arp_cache_idx_valid = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1332  			info.cq_num_valid = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1333  			info.ord_valid = true;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1334  			info.next_iwarp_state = IRDMA_QP_STATE_RTS;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1335  			issue_modify_qp = 1;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1336  			if (iwdev->push_mode && udata &&
b48c24c2d710cf Mustafa Ismail 2021-06-02  1337  			    iwqp->sc_qp.push_idx == IRDMA_INVALID_PUSH_PAGE_INDEX &&
b48c24c2d710cf Mustafa Ismail 2021-06-02  1338  			    dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1339  				spin_unlock_irqrestore(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1340  				irdma_alloc_push_page(iwqp);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1341  				spin_lock_irqsave(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1342  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1343  			break;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1344  		case IB_QPS_SQD:
b48c24c2d710cf Mustafa Ismail 2021-06-02  1345  			if (iwqp->iwarp_state == IRDMA_QP_STATE_SQD)
c4d5794806c724 chongjiapeng   2021-07-23  1346  				ret = -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02 @1347  				goto exit;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1348  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1349  			if (iwqp->iwarp_state != IRDMA_QP_STATE_RTS) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1350  				ret = -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1351  				goto exit;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1352  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1353  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1354  			info.next_iwarp_state = IRDMA_QP_STATE_SQD;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1355  			issue_modify_qp = 1;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1356  			break;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1357  		case IB_QPS_SQE:
b48c24c2d710cf Mustafa Ismail 2021-06-02  1358  		case IB_QPS_ERR:
b48c24c2d710cf Mustafa Ismail 2021-06-02  1359  		case IB_QPS_RESET:
b48c24c2d710cf Mustafa Ismail 2021-06-02  1360  			if (iwqp->iwarp_state == IRDMA_QP_STATE_RTS) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1361  				spin_unlock_irqrestore(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1362  				info.next_iwarp_state = IRDMA_QP_STATE_SQD;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1363  				irdma_hw_modify_qp(iwdev, iwqp, &info, true);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1364  				spin_lock_irqsave(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1365  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1366  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1367  			if (iwqp->iwarp_state == IRDMA_QP_STATE_ERROR) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1368  				spin_unlock_irqrestore(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1369  				if (udata) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1370  					if (ib_copy_from_udata(&ureq, udata,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1371  					    min(sizeof(ureq), udata->inlen)))
b48c24c2d710cf Mustafa Ismail 2021-06-02  1372  						return -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1373  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1374  					irdma_flush_wqes(iwqp,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1375  					    (ureq.sq_flush ? IRDMA_FLUSH_SQ : 0) |
b48c24c2d710cf Mustafa Ismail 2021-06-02  1376  					    (ureq.rq_flush ? IRDMA_FLUSH_RQ : 0) |
b48c24c2d710cf Mustafa Ismail 2021-06-02  1377  					    IRDMA_REFLUSH);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1378  				}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1379  				return 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1380  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1381  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1382  			info.next_iwarp_state = IRDMA_QP_STATE_ERROR;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1383  			issue_modify_qp = 1;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1384  			break;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1385  		default:
b48c24c2d710cf Mustafa Ismail 2021-06-02  1386  			ret = -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1387  			goto exit;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1388  		}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1389  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1390  		iwqp->ibqp_state = attr->qp_state;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1391  	}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1392  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1393  	ctx_info->send_cq_num = iwqp->iwscq->sc_cq.cq_uk.cq_id;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1394  	ctx_info->rcv_cq_num = iwqp->iwrcq->sc_cq.cq_uk.cq_id;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1395  	irdma_sc_qp_setctx_roce(&iwqp->sc_qp, iwqp->host_ctx.va, ctx_info);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1396  	spin_unlock_irqrestore(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1397  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1398  	if (attr_mask & IB_QP_STATE) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1399  		if (issue_modify_qp) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1400  			ctx_info->rem_endpoint_idx = udp_info->arp_idx;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1401  			if (irdma_hw_modify_qp(iwdev, iwqp, &info, true))
b48c24c2d710cf Mustafa Ismail 2021-06-02  1402  				return -EINVAL;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1403  			spin_lock_irqsave(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1404  			if (iwqp->iwarp_state == info.curr_iwarp_state) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1405  				iwqp->iwarp_state = info.next_iwarp_state;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1406  				iwqp->ibqp_state = attr->qp_state;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1407  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1408  			if (iwqp->ibqp_state > IB_QPS_RTS &&
b48c24c2d710cf Mustafa Ismail 2021-06-02  1409  			    !iwqp->flush_issued) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1410  				iwqp->flush_issued = 1;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1411  				spin_unlock_irqrestore(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1412  				irdma_flush_wqes(iwqp, IRDMA_FLUSH_SQ |
b48c24c2d710cf Mustafa Ismail 2021-06-02  1413  						       IRDMA_FLUSH_RQ |
b48c24c2d710cf Mustafa Ismail 2021-06-02  1414  						       IRDMA_FLUSH_WAIT);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1415  			} else {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1416  				spin_unlock_irqrestore(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1417  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1418  		} else {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1419  			iwqp->ibqp_state = attr->qp_state;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1420  		}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1421  		if (udata && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1422  			struct irdma_ucontext *ucontext;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1423  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1424  			ucontext = rdma_udata_to_drv_context(udata,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1425  					struct irdma_ucontext, ibucontext);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1426  			if (iwqp->sc_qp.push_idx != IRDMA_INVALID_PUSH_PAGE_INDEX &&
b48c24c2d710cf Mustafa Ismail 2021-06-02  1427  			    !iwqp->push_wqe_mmap_entry &&
b48c24c2d710cf Mustafa Ismail 2021-06-02  1428  			    !irdma_setup_push_mmap_entries(ucontext, iwqp,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1429  				&uresp.push_wqe_mmap_key, &uresp.push_db_mmap_key)) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1430  				uresp.push_valid = 1;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1431  				uresp.push_offset = iwqp->sc_qp.push_offset;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1432  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1433  			ret = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp),
b48c24c2d710cf Mustafa Ismail 2021-06-02  1434  					       udata->outlen));
b48c24c2d710cf Mustafa Ismail 2021-06-02  1435  			if (ret) {
b48c24c2d710cf Mustafa Ismail 2021-06-02  1436  				irdma_remove_push_mmap_entries(iwqp);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1437  				ibdev_dbg(&iwdev->ibdev,
b48c24c2d710cf Mustafa Ismail 2021-06-02  1438  					  "VERBS: copy_to_udata failed\n");
b48c24c2d710cf Mustafa Ismail 2021-06-02  1439  				return ret;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1440  			}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1441  		}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1442  	}
b48c24c2d710cf Mustafa Ismail 2021-06-02  1443  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1444  	return 0;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1445  exit:
b48c24c2d710cf Mustafa Ismail 2021-06-02  1446  	spin_unlock_irqrestore(&iwqp->lock, flags);
b48c24c2d710cf Mustafa Ismail 2021-06-02  1447  
b48c24c2d710cf Mustafa Ismail 2021-06-02  1448  	return ret;
b48c24c2d710cf Mustafa Ismail 2021-06-02  1449  }
b48c24c2d710cf Mustafa Ismail 2021-06-02  1450  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
atVbwbMorZYRLyQRGSdEoFCYOAmpsCkFh7VFMVDPNoCrheRvNFQBeR92kTVM0g+Cr7+Ts8Ws
4DLUjr5sFT4kXeEVchcOZq1nMp6zwrTdnF1bhPIgZ50l4upctv1/X9+ev9z9BsleVAz5v3/h
y+fzf++ev/z2/Anssn5RVO84UwouaP/ARSZwPpk3PyDSjBWHWsZFuhbXw6R1RAkBsqzKzpSE
DDjVBAMyymA8Rf3eSFwjTjPxeG6OMj8MyAaj6ammxHQa1LY1l9FP/+TH81fOO3GaX+QOfVKm
beQcTSHE0ZLuY3jaFpZGotDm7Xd51KgStRlEFjtwZMnjytEV9WY+ypSwujWh87wx1jGdlVOg
SnRPzyAVdxX3UGIg9iwX063tKwNcOZ+zFhI4NG+QWEHftQ4TfQxooyJGh8tBSaSY4O8KVgTh
VlMlHfWoS0cRTXG5QKX2i+m5HWeDUAH+/AJBXvVZPooQSDHtZ9C2RCT2vuXlfPv4B2VcyZGj
t4mi0eJg5HIW3qh30lb+DozF6qy/NJ2wiBZcEmf2K0gocvf2jX/2fMeXKl/xn0SmI74NRMWv
/6snvbTbM7PSRQ2ixbKIOECyCxoB/0vTa6m0YAti7pmcflUkxbdLjIhj8MUEVknrB2wVYdW2
ibUxbPA2K6QimDD7+LHv4oK2SZiIOPPZdY/nIqNdIiey8pHL0Q0dPnGiMZxq596WnCks4/vM
Ru27Zuj16Alzq+KaS3XiIxuXcUmPH573VJ/TrOZymcuyaaLKyvsjKC94+Vf6k1VV0bP9qTtQ
NR2yqqiLG0VwyYruxPuYtWpUvhCjzeF5kZGH6kyTXYqpceaSONVdwTIzD6vC9sVhng+Z6Or5
6/Pr0+vd95evH99+fEbn/JQXyEFiLVMQAGK7zoStt+VO44Dg7kS+MArA71PWQ7z8sSz46P+6
8XydYsTZHKaPiu5B+eGinYivbPG9DCmLYYmREGIGjmeKJxRodQoYJQnzvdUibMjcIV+evn/n
fI4wbrRuZNmrKm17o6z0ErfG+CxnzxSyBqMLnVGVDdpHIdsOJjSrP6DXdzk0RTMYoPMQbTbG
x8BJ58p+apJO3P2U1wE/cd8pLOjjjZHAA59vvSiitHCyi31ktdvqNYcEnjdYc3op6n3jSJwj
CZgXJuuIvL2vdmJmeAX0+c/v/N4iplla/hrtV1Cc4lFbTisK6tu9U3AoxzV6Qg4NzOWgoEQD
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
T1R4CF4cAgA=

--k+w/mQv8wyuph6w0--
