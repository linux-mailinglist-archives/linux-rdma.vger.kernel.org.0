Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3DE7678EF
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Jul 2023 01:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjG1XXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jul 2023 19:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjG1XXK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jul 2023 19:23:10 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE8F3AB1;
        Fri, 28 Jul 2023 16:23:04 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SLWQZL030879;
        Fri, 28 Jul 2023 16:22:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=QGtK1Bu72K9353KWb4CtyTdltYEVr3bTU5rSatg9PpA=;
 b=E68Z8u8IRG1wJE0zlPuD90fF7DSjY2dDTIQG2FjGmIWG31lrVZxZWGreAZpJeX04Bh7s
 8Sd59vI0WXzoUccEAYte3ZJLNT84SzMTQA2fIt3odQyCdr2yJhDJdeF/JMlE29Lxh1+W
 ImNns2x8FqQ6DOGNKqIo5xzz3OImsjghScJlNu+CDguRxB9JB4NNYa6+IGFN9d6DDVBS
 ZIvj66lVdPUk5dZDcvWWAZ4yt4/Ev1B84ajpHA70DD6KlYq04hJfkVA/PTp9C2baPsQs
 Hb3+CnFDXr3s+TSKVAy+gbKHuXKfbv2pqY2f8E1RyzlcDXln22L68T+DG5m94so5L+OF sw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s4bd3jh0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 16:22:39 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jul
 2023 16:22:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 28 Jul 2023 16:22:37 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id B932C3F7090;
        Fri, 28 Jul 2023 16:22:17 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vladimir.oltean@nxp.com>, <claudiu.manoil@nxp.com>,
        <alexandre.belloni@bootlin.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <olteanv@gmail.com>, <michael.chan@broadcom.com>,
        <rajur@chelsio.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <taras.chornyi@plvision.eu>,
        <saeedm@nvidia.com>, <leon@kernel.org>, <idosch@nvidia.com>,
        <petrm@nvidia.com>, <horatiu.vultur@microchip.com>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <simon.horman@corigine.com>,
        <aelior@marvell.com>, <manishc@marvell.com>,
        <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
        <peppe.cavallaro@st.com>, <alexandre.torgue@foss.st.com>,
        <joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
        <pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>,
        <muhammad.husaini.zulkifli@intel.com>, <coreteam@netfilter.org>,
        <ioana.ciornei@nxp.com>, <wojciech.drewek@intel.com>,
        <gerhard@engleder-embedded.com>, <oss-drivers@corigine.com>,
        <shenjian15@huawei.com>, <wentao.jia@corigine.com>,
        <linux-net-drivers@amd.com>, <huangguangbin2@huawei.com>,
        <hui.zhou@corigine.com>, <linux-rdma@vger.kernel.org>,
        <louis.peens@corigine.com>, <zdoychev@maxlinear.com>,
        <intel-wired-lan@lists.osuosl.org>, <wenjuan.geng@corigine.com>,
        <grygorii.strashko@ti.com>, <kurt@linutronix.de>,
        <UNGLinuxDriver@microchip.com>, <netfilter-devel@vger.kernel.org>,
        <lanhao@huawei.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <shmulik.ladkani@gmail.com>, <d-tatianin@yandex-team.ru>,
        <linux-stm32@st-md-mailman.stormreply.com>, <jdamato@fastly.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v3 net-next] net: flow_dissector: Use 64bits for used_keys
Date:   Sat, 29 Jul 2023 04:52:15 +0530
Message-ID: <20230728232215.2071351-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: d80cyBjSa4t3bzFQWewM-oOKqS0Syu8W
X-Proofpoint-ORIG-GUID: d80cyBjSa4t3bzFQWewM-oOKqS0Syu8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As 32bits of dissector->used_keys are exhausted,
increase the size to 64bits.

This is base change for ESP/AH flow dissector patch.
Please find patch and discussions at
https://lore.kernel.org/netdev/ZMDNjD46BvZ5zp5I@corigine.com/T/#t

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Reviewed-by: Petr Machata <petrm@nvidia.com> # for mlxsw
Tested-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>

---
ChangeLog

v2 -> v3: commit message subject line fix as per comment of Petr Machata
v1 -> v2: Commit message typo fix.
v0 -> v1: Fix errors reported by kernel test robot
---
 drivers/net/dsa/ocelot/felix_vsc9959.c        |  8 +--
 drivers/net/dsa/sja1105/sja1105_flower.c      |  8 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c  |  6 +-
 .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  | 18 ++---
 .../freescale/dpaa2/dpaa2-switch-flower.c     | 22 +++---
 .../net/ethernet/freescale/enetc/enetc_qos.c  |  8 +--
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 16 ++---
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 18 ++---
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 18 ++---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 44 ++++++------
 drivers/net/ethernet/intel/igb/igb_main.c     |  8 +--
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 18 ++---
 .../marvell/prestera/prestera_flower.c        | 20 +++---
 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     | 25 ++++---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 44 ++++++------
 .../ethernet/mellanox/mlxsw/spectrum_flower.c | 22 +++---
 .../microchip/lan966x/lan966x_tc_flower.c     |  4 +-
 .../microchip/sparx5/sparx5_tc_flower.c       |  4 +-
 drivers/net/ethernet/microchip/vcap/vcap_tc.c | 18 ++---
 drivers/net/ethernet/microchip/vcap/vcap_tc.h |  2 +-
 drivers/net/ethernet/mscc/ocelot_flower.c     | 28 ++++----
 .../ethernet/netronome/nfp/flower/conntrack.c | 43 ++++++------
 .../ethernet/netronome/nfp/flower/offload.c   | 64 +++++++++---------
 .../net/ethernet/qlogic/qede/qede_filter.c    | 12 ++--
 drivers/net/ethernet/sfc/tc.c                 | 67 ++++++++++---------
 .../stmicro/stmmac/stmmac_selftests.c         |  6 +-
 drivers/net/ethernet/ti/am65-cpsw-qos.c       |  6 +-
 drivers/net/ethernet/ti/cpsw_priv.c           |  6 +-
 include/net/flow_dissector.h                  |  5 +-
 net/core/flow_dissector.c                     |  2 +-
 net/ethtool/ioctl.c                           | 16 ++---
 net/netfilter/nf_flow_table_offload.c         | 22 +++---
 net/netfilter/nf_tables_offload.c             | 13 ++--
 net/netfilter/nft_cmp.c                       |  2 +-
 34 files changed, 317 insertions(+), 306 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 1c113957fcf4..7e7489321170 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1745,10 +1745,10 @@ static int vsc9959_stream_identify(struct flow_cls_offload *f,
 	struct flow_dissector *dissector = rule->match.dissector;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS)))
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS)))
 		return -EOPNOTSUPP;
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
diff --git a/drivers/net/dsa/sja1105/sja1105_flower.c b/drivers/net/dsa/sja1105/sja1105_flower.c
index fad5afe3819c..9e8ca182c722 100644
--- a/drivers/net/dsa/sja1105/sja1105_flower.c
+++ b/drivers/net/dsa/sja1105/sja1105_flower.c
@@ -205,10 +205,10 @@ static int sja1105_flower_parse_key(struct sja1105_private *priv,
 	u16 pcp = U16_MAX;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS))) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Unsupported keys used");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index d8afcf8d6b30..38d89d80b4a9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -373,9 +373,9 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
 	struct flow_dissector *dissector = rule->match.dissector;
 
 	/* KEY_CONTROL and KEY_BASIC are needed for forming a meaningful key */
-	if ((dissector->used_keys & BIT(FLOW_DISSECTOR_KEY_CONTROL)) == 0 ||
-	    (dissector->used_keys & BIT(FLOW_DISSECTOR_KEY_BASIC)) == 0) {
-		netdev_info(bp->dev, "cannot form TC key: used_keys = 0x%x\n",
+	if ((dissector->used_keys & BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL)) == 0 ||
+	    (dissector->used_keys & BIT_ULL(FLOW_DISSECTOR_KEY_BASIC)) == 0) {
+		netdev_info(bp->dev, "cannot form TC key: used_keys = 0x%llx\n",
 			    dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index d3541159487d..72ac4a34424b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -313,15 +313,15 @@ static int cxgb4_validate_flow_match(struct net_device *dev,
 	u16 ethtype_key = 0;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_KEYID) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_IP))) {
-		netdev_warn(dev, "Unsupported key used: 0x%x\n",
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP))) {
+		netdev_warn(dev, "Unsupported key used: 0x%llx\n",
 			    dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
index c39b866e2582..4798fb7fe35d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
@@ -17,14 +17,14 @@ static int dpaa2_switch_flower_parse_key(struct flow_cls_offload *cls,
 	struct dpsw_acl_fields *acl_h, *acl_m;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_IP) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS))) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Unsupported keys used");
 		return -EOPNOTSUPP;
@@ -539,9 +539,9 @@ static int dpaa2_switch_flower_parse_mirror_key(struct flow_cls_offload *cls,
 	int ret = -EOPNOTSUPP;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN))) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Mirroring is supported only per VLAN");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 270cbd5e8684..2513b44056c1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -483,13 +483,13 @@ struct enetc_psfp {
 static struct actions_fwd enetc_act_fwd[] = {
 	{
 		BIT(FLOW_ACTION_GATE),
-		BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS),
+		BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS),
 		FILTER_ACTION_TYPE_PSFP
 	},
 	{
 		BIT(FLOW_ACTION_POLICE) |
 		BIT(FLOW_ACTION_GATE),
-		BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS),
+		BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS),
 		FILTER_ACTION_TYPE_PSFP
 	},
 	/* example for ACL actions */
@@ -1069,8 +1069,8 @@ static int enetc_psfp_hw_set(struct enetc_ndev_priv *priv,
 	return err;
 }
 
-static struct actions_fwd *enetc_check_flow_actions(u64 acts,
-						    unsigned int inputkeys)
+static struct actions_fwd *
+enetc_check_flow_actions(u64 acts, unsigned long long inputkeys)
 {
 	int i;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index bf675c15fbb9..83ab89f44250 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7315,14 +7315,14 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 	struct flow_dissector *dissector = flow->match.dissector;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS))) {
-		dev_err(&hdev->pdev->dev, "unsupported key set: %#x\n",
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS))) {
+		dev_err(&hdev->pdev->dev, "unsupported key set: %#llx\n",
 			dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 982ae70c51e8..3d0d6974c2a7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8525,15 +8525,15 @@ static int i40e_parse_cls_flower(struct i40e_vsi *vsi,
 	u8 field_flags = 0;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_KEYID))) {
-		dev_err(&pf->pdev->dev, "Unsupported key used: 0x%x\n",
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID))) {
+		dev_err(&pf->pdev->dev, "Unsupported key used: 0x%llx\n",
 			dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3a88d413ddee..09b492472408 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3743,15 +3743,15 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 	struct virtchnl_filter *vf = &filter->f;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_KEYID))) {
-		dev_err(&adapter->pdev->dev, "Unsupported key used: 0x%x\n",
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID))) {
+		dev_err(&adapter->pdev->dev, "Unsupported key used: 0x%llx\n",
 			dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 4a34ef5f58d3..38547db1ec4e 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -1343,24 +1343,24 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 	dissector = rule->match.dissector;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_CVLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_KEYID) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_OPTS) |
-	      BIT(FLOW_DISSECTOR_KEY_IP) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_IP) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_PPPOE) |
-	      BIT(FLOW_DISSECTOR_KEY_L2TPV3))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CVLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_OPTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PPPOE) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_L2TPV3))) {
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported key used");
 		return -EOPNOTSUPP;
 	}
@@ -1382,10 +1382,10 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		 */
 		headers = &fltr->inner_headers;
 	} else if (dissector->used_keys &
-		  (BIT(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
-		   BIT(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
-		   BIT(FLOW_DISSECTOR_KEY_ENC_KEYID) |
-		   BIT(FLOW_DISSECTOR_KEY_ENC_PORTS))) {
+		  (BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS))) {
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Tunnel key used, but device isn't a tunnel");
 		return -EOPNOTSUPP;
 	} else {
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 9a2561409b06..9f63a10c6f80 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2615,10 +2615,10 @@ static int igb_parse_cls_flower(struct igb_adapter *adapter,
 	struct netlink_ext_ack *extack = f->common.extack;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN))) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Unsupported key used, only BASIC, CONTROL, ETH_ADDRS and VLAN are supported");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 1e6fc23eca4f..71daff86f775 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -454,15 +454,15 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	dissector = rule->match.dissector;
 
 	if ((dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_IP))))  {
-		netdev_info(nic->netdev, "unsupported flow used key 0x%x",
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP))))  {
+		netdev_info(nic->netdev, "unsupported flow used key 0x%llx",
 			    dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
index 3e20e71b0f81..8b9455d8a4f7 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
@@ -202,16 +202,16 @@ static int prestera_flower_parse(struct prestera_flow_block *block,
 	int err;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_META) |
-	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_ICMP) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_META) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ICMP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN))) {
 		NL_SET_ERR_MSG_MOD(f->common.extack, "Unsupported key");
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
index 2b80fe73549d..8c531f4ec912 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
@@ -221,16 +221,21 @@ mlx5_ct_fs_smfs_destroy(struct mlx5_ct_fs *fs)
 }
 
 static inline bool
-mlx5_tc_ct_valid_used_dissector_keys(const u32 used_keys)
+mlx5_tc_ct_valid_used_dissector_keys(const u64 used_keys)
 {
-#define DISS_BIT(name) BIT(FLOW_DISSECTOR_KEY_ ## name)
-	const u32 basic_keys = DISS_BIT(BASIC) | DISS_BIT(CONTROL) | DISS_BIT(META);
-	const u32 ipv4_tcp = basic_keys | DISS_BIT(IPV4_ADDRS) | DISS_BIT(PORTS) | DISS_BIT(TCP);
-	const u32 ipv6_tcp = basic_keys | DISS_BIT(IPV6_ADDRS) | DISS_BIT(PORTS) | DISS_BIT(TCP);
-	const u32 ipv4_udp = basic_keys | DISS_BIT(IPV4_ADDRS) | DISS_BIT(PORTS);
-	const u32 ipv6_udp = basic_keys | DISS_BIT(IPV6_ADDRS) | DISS_BIT(PORTS);
-	const u32 ipv4_gre = basic_keys | DISS_BIT(IPV4_ADDRS);
-	const u32 ipv6_gre = basic_keys | DISS_BIT(IPV6_ADDRS);
+#define DISS_BIT(name) BIT_ULL(FLOW_DISSECTOR_KEY_ ## name)
+	const u64 basic_keys = DISS_BIT(BASIC) | DISS_BIT(CONTROL) |
+				DISS_BIT(META);
+	const u64 ipv4_tcp = basic_keys | DISS_BIT(IPV4_ADDRS) |
+				DISS_BIT(PORTS) | DISS_BIT(TCP);
+	const u64 ipv6_tcp = basic_keys | DISS_BIT(IPV6_ADDRS) |
+				DISS_BIT(PORTS) | DISS_BIT(TCP);
+	const u64 ipv4_udp = basic_keys | DISS_BIT(IPV4_ADDRS) |
+				DISS_BIT(PORTS);
+	const u64 ipv6_udp = basic_keys | DISS_BIT(IPV6_ADDRS) |
+				 DISS_BIT(PORTS);
+	const u64 ipv4_gre = basic_keys | DISS_BIT(IPV4_ADDRS);
+	const u64 ipv6_gre = basic_keys | DISS_BIT(IPV6_ADDRS);
 
 	return (used_keys == ipv4_tcp || used_keys == ipv4_udp || used_keys == ipv6_tcp ||
 		used_keys == ipv6_udp || used_keys == ipv4_gre || used_keys == ipv6_gre);
@@ -247,7 +252,7 @@ mlx5_ct_fs_smfs_ct_validate_flow_rule(struct mlx5_ct_fs *fs, struct flow_rule *f
 	struct flow_match_tcp tcp;
 
 	if (!mlx5_tc_ct_valid_used_dissector_keys(flow_rule->match.dissector->used_keys)) {
-		ct_dbg("rule uses unexpected dissectors (0x%08x)",
+		ct_dbg("rule uses unexpected dissectors (0x%016llx)",
 		       flow_rule->match.dissector->used_keys);
 		return false;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 8d0a3f69693e..842952e7b540 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2593,29 +2593,29 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 	match_level = outer_match_level;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_META) |
-	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_CVLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_KEYID) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_PORTS)	|
-	      BIT(FLOW_DISSECTOR_KEY_ENC_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_TCP) |
-	      BIT(FLOW_DISSECTOR_KEY_IP)  |
-	      BIT(FLOW_DISSECTOR_KEY_CT) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_IP) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_OPTS) |
-	      BIT(FLOW_DISSECTOR_KEY_ICMP) |
-	      BIT(FLOW_DISSECTOR_KEY_MPLS))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_META) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CVLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS)	|
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP)  |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CT) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_OPTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ICMP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_MPLS))) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported key");
-		netdev_dbg(priv->netdev, "Unsupported key used: 0x%x\n",
+		netdev_dbg(priv->netdev, "Unsupported key used: 0x%llx\n",
 			   dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 8329100479b3..af3f57d017ec 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -558,17 +558,17 @@ static int mlxsw_sp_flower_parse(struct mlxsw_sp *mlxsw_sp,
 	int err;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_META) |
-	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
-	      BIT(FLOW_DISSECTOR_KEY_TCP) |
-	      BIT(FLOW_DISSECTOR_KEY_IP) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_META) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN))) {
 		dev_err(mlxsw_sp->bus_info->dev, "Unsupported key\n");
 		NL_SET_ERR_MSG_MOD(f->common.extack, "Unsupported key");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
index 96b3def6c474..d696cf9dbd19 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
@@ -75,7 +75,7 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 			goto out;
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_CONTROL);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
 
 	return err;
 
@@ -172,7 +172,7 @@ lan966x_tc_flower_handler_basic_usage(struct vcap_tc_flower_parse_usage *st)
 		}
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_BASIC);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_BASIC);
 	return err;
 out:
 	NL_SET_ERR_MSG_MOD(st->fco->common.extack, "ip_proto parse error");
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 3f87a5285a6d..906299ad8425 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -126,7 +126,7 @@ sparx5_tc_flower_handler_basic_usage(struct vcap_tc_flower_parse_usage *st)
 		}
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_BASIC);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_BASIC);
 
 	return err;
 
@@ -175,7 +175,7 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 			goto out;
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_CONTROL);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
 
 	return err;
 
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_tc.c b/drivers/net/ethernet/microchip/vcap/vcap_tc.c
index 09abe7944af6..27e2dffb65e6 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_tc.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_tc.c
@@ -50,7 +50,7 @@ int vcap_tc_flower_handler_ethaddr_usage(struct vcap_tc_flower_parse_usage *st)
 			goto out;
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS);
 
 	return err;
 
@@ -86,7 +86,7 @@ int vcap_tc_flower_handler_ipv4_usage(struct vcap_tc_flower_parse_usage *st)
 		}
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS);
 
 	return err;
 
@@ -124,7 +124,7 @@ int vcap_tc_flower_handler_ipv6_usage(struct vcap_tc_flower_parse_usage *st)
 				goto out;
 		}
 	}
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS);
 	return err;
 out:
 	NL_SET_ERR_MSG_MOD(st->fco->common.extack, "ipv6_addr parse error");
@@ -158,7 +158,7 @@ int vcap_tc_flower_handler_portnum_usage(struct vcap_tc_flower_parse_usage *st)
 			goto out;
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_PORTS);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_PORTS);
 
 	return err;
 
@@ -201,7 +201,7 @@ int vcap_tc_flower_handler_cvlan_usage(struct vcap_tc_flower_parse_usage *st)
 			goto out;
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_CVLAN);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CVLAN);
 
 	return 0;
 out:
@@ -238,7 +238,7 @@ int vcap_tc_flower_handler_vlan_usage(struct vcap_tc_flower_parse_usage *st,
 	if (mt.mask->vlan_tpid)
 		st->tpid = be16_to_cpu(mt.key->vlan_tpid);
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_VLAN);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_VLAN);
 
 	return 0;
 out:
@@ -313,7 +313,7 @@ int vcap_tc_flower_handler_tcp_usage(struct vcap_tc_flower_parse_usage *st)
 			goto out;
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_TCP);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_TCP);
 
 	return err;
 
@@ -376,7 +376,7 @@ int vcap_tc_flower_handler_arp_usage(struct vcap_tc_flower_parse_usage *st)
 			goto out;
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_ARP);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_ARP);
 
 	return 0;
 
@@ -401,7 +401,7 @@ int vcap_tc_flower_handler_ip_usage(struct vcap_tc_flower_parse_usage *st)
 			goto out;
 	}
 
-	st->used_keys |= BIT(FLOW_DISSECTOR_KEY_IP);
+	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_IP);
 
 	return err;
 
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_tc.h b/drivers/net/ethernet/microchip/vcap/vcap_tc.h
index 071f892f9aa4..49b02d032906 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_tc.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_tc.h
@@ -14,7 +14,7 @@ struct vcap_tc_flower_parse_usage {
 	u16 l3_proto;
 	u8 l4_proto;
 	u16 tpid;
-	unsigned int used_keys;
+	unsigned long long used_keys;
 };
 
 int vcap_tc_flower_handler_ethaddr_usage(struct vcap_tc_flower_parse_usage *st);
diff --git a/drivers/net/ethernet/mscc/ocelot_flower.c b/drivers/net/ethernet/mscc/ocelot_flower.c
index e0916afcddfb..33b438c6aec5 100644
--- a/drivers/net/ethernet/mscc/ocelot_flower.c
+++ b/drivers/net/ethernet/mscc/ocelot_flower.c
@@ -581,14 +581,14 @@ ocelot_flower_parse_key(struct ocelot *ocelot, int port, bool ingress,
 	int ret;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_META) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_META) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS))) {
 		return -EOPNOTSUPP;
 	}
 
@@ -641,12 +641,12 @@ ocelot_flower_parse_key(struct ocelot *ocelot, int port, bool ingress,
 		 * then just bail out
 		 */
 		if ((dissector->used_keys &
-		    (BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-		     BIT(FLOW_DISSECTOR_KEY_BASIC) |
-		     BIT(FLOW_DISSECTOR_KEY_CONTROL))) !=
-		    (BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-		     BIT(FLOW_DISSECTOR_KEY_BASIC) |
-		     BIT(FLOW_DISSECTOR_KEY_CONTROL)))
+		    (BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+		     BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+		     BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL))) !=
+		    (BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+		     BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+		     BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL)))
 			return -EOPNOTSUPP;
 
 		flow_rule_match_eth_addrs(rule, &match);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 73032173ac4e..2643c4b3ff1f 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -61,7 +61,7 @@ bool is_pre_ct_flow(struct flow_cls_offload *flow)
 	struct flow_match_ct ct;
 	int i;
 
-	if (dissector->used_keys & BIT(FLOW_DISSECTOR_KEY_CT)) {
+	if (dissector->used_keys & BIT_ULL(FLOW_DISSECTOR_KEY_CT)) {
 		flow_rule_match_ct(rule, &ct);
 		if (ct.key->ct_state)
 			return false;
@@ -94,7 +94,7 @@ bool is_post_ct_flow(struct flow_cls_offload *flow)
 	struct flow_match_ct ct;
 	int i;
 
-	if (dissector->used_keys & BIT(FLOW_DISSECTOR_KEY_CT)) {
+	if (dissector->used_keys & BIT_ULL(FLOW_DISSECTOR_KEY_CT)) {
 		flow_rule_match_ct(rule, &ct);
 		if (ct.key->ct_state & TCA_FLOWER_KEY_CT_FLAGS_ESTABLISHED)
 			return true;
@@ -236,10 +236,11 @@ static bool nfp_ct_merge_check_cannot_skip(struct nfp_fl_ct_flow_entry *entry1,
 static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			      struct nfp_fl_ct_flow_entry *entry2)
 {
-	unsigned int ovlp_keys = entry1->rule->match.dissector->used_keys &
-				 entry2->rule->match.dissector->used_keys;
+	unsigned long long ovlp_keys;
 	bool out, is_v6 = false;
 	u8 ip_proto = 0;
+	ovlp_keys = entry1->rule->match.dissector->used_keys &
+			entry2->rule->match.dissector->used_keys;
 	/* Temporary buffer for mangling keys, 64 is enough to cover max
 	 * struct size of key in various fields that may be mangled.
 	 * Supported fields to mangle:
@@ -257,7 +258,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 	/* Check the overlapped fields one by one, the unmasked part
 	 * should not conflict with each other.
 	 */
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_CONTROL)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL)) {
 		struct flow_match_control match1, match2;
 
 		flow_rule_match_control(entry1->rule, &match1);
@@ -267,7 +268,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_BASIC)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_BASIC)) {
 		struct flow_match_basic match1, match2;
 
 		flow_rule_match_basic(entry1->rule, &match1);
@@ -289,7 +290,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 	 * will be do merge check when do nft and post ct merge,
 	 * so skip this ip merge check here.
 	 */
-	if ((ovlp_keys & BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS)) &&
+	if ((ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS)) &&
 	    nfp_ct_merge_check_cannot_skip(entry1, entry2)) {
 		struct flow_match_ipv4_addrs match1, match2;
 
@@ -311,7 +312,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 	 * will be do merge check when do nft and post ct merge,
 	 * so skip this ip merge check here.
 	 */
-	if ((ovlp_keys & BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS)) &&
+	if ((ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS)) &&
 	    nfp_ct_merge_check_cannot_skip(entry1, entry2)) {
 		struct flow_match_ipv6_addrs match1, match2;
 
@@ -333,7 +334,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 	 * will be do merge check when do nft and post ct merge,
 	 * so skip this tport merge check here.
 	 */
-	if ((ovlp_keys & BIT(FLOW_DISSECTOR_KEY_PORTS)) &&
+	if ((ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_PORTS)) &&
 	    nfp_ct_merge_check_cannot_skip(entry1, entry2)) {
 		enum flow_action_mangle_base htype = FLOW_ACT_MANGLE_UNSPEC;
 		struct flow_match_ports match1, match2;
@@ -355,7 +356,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		struct flow_match_eth_addrs match1, match2;
 
 		flow_rule_match_eth_addrs(entry1->rule, &match1);
@@ -371,7 +372,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_VLAN)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_VLAN)) {
 		struct flow_match_vlan match1, match2;
 
 		flow_rule_match_vlan(entry1->rule, &match1);
@@ -381,7 +382,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_MPLS)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_MPLS)) {
 		struct flow_match_mpls match1, match2;
 
 		flow_rule_match_mpls(entry1->rule, &match1);
@@ -391,7 +392,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_TCP)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_TCP)) {
 		struct flow_match_tcp match1, match2;
 
 		flow_rule_match_tcp(entry1->rule, &match1);
@@ -401,7 +402,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_IP)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_IP)) {
 		struct flow_match_ip match1, match2;
 
 		flow_rule_match_ip(entry1->rule, &match1);
@@ -413,7 +414,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_ENC_KEYID)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID)) {
 		struct flow_match_enc_keyid match1, match2;
 
 		flow_rule_match_enc_keyid(entry1->rule, &match1);
@@ -423,7 +424,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS)) {
 		struct flow_match_ipv4_addrs match1, match2;
 
 		flow_rule_match_enc_ipv4_addrs(entry1->rule, &match1);
@@ -433,7 +434,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS)) {
 		struct flow_match_ipv6_addrs match1, match2;
 
 		flow_rule_match_enc_ipv6_addrs(entry1->rule, &match1);
@@ -443,7 +444,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_ENC_CONTROL)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL)) {
 		struct flow_match_control match1, match2;
 
 		flow_rule_match_enc_control(entry1->rule, &match1);
@@ -453,7 +454,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_ENC_IP)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP)) {
 		struct flow_match_ip match1, match2;
 
 		flow_rule_match_enc_ip(entry1->rule, &match1);
@@ -463,7 +464,7 @@ static int nfp_ct_merge_check(struct nfp_fl_ct_flow_entry *entry1,
 			goto check_failed;
 	}
 
-	if (ovlp_keys & BIT(FLOW_DISSECTOR_KEY_ENC_OPTS)) {
+	if (ovlp_keys & BIT_ULL(FLOW_DISSECTOR_KEY_ENC_OPTS)) {
 		struct flow_match_enc_opts match1, match2;
 
 		flow_rule_match_enc_opts(entry1->rule, &match1);
@@ -589,7 +590,7 @@ static int nfp_ct_check_meta(struct nfp_fl_ct_flow_entry *post_ct_entry,
 	int i;
 
 	ct_met = get_flow_act(nft_entry->rule, FLOW_ACTION_CT_METADATA);
-	if (ct_met && (dissector->used_keys & BIT(FLOW_DISSECTOR_KEY_CT))) {
+	if (ct_met && (dissector->used_keys & BIT_ULL(FLOW_DISSECTOR_KEY_CT))) {
 		u32 *act_lbl;
 
 		act_lbl = ct_met->ct_metadata.labels;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index 18328eb7f5c3..c153f0575b92 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -24,43 +24,43 @@
 	 FLOW_DIS_FIRST_FRAG)
 
 #define NFP_FLOWER_WHITELIST_DISSECTOR \
-	(BIT(FLOW_DISSECTOR_KEY_CONTROL) | \
-	 BIT(FLOW_DISSECTOR_KEY_BASIC) | \
-	 BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) | \
-	 BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) | \
-	 BIT(FLOW_DISSECTOR_KEY_TCP) | \
-	 BIT(FLOW_DISSECTOR_KEY_PORTS) | \
-	 BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) | \
-	 BIT(FLOW_DISSECTOR_KEY_VLAN) | \
-	 BIT(FLOW_DISSECTOR_KEY_CVLAN) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_KEYID) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_CONTROL) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_PORTS) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_OPTS) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_IP) | \
-	 BIT(FLOW_DISSECTOR_KEY_MPLS) | \
-	 BIT(FLOW_DISSECTOR_KEY_CT) | \
-	 BIT(FLOW_DISSECTOR_KEY_META) | \
-	 BIT(FLOW_DISSECTOR_KEY_IP))
+	(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_TCP) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_CVLAN) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_OPTS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_MPLS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_CT) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_META) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_IP))
 
 #define NFP_FLOWER_WHITELIST_TUN_DISSECTOR \
-	(BIT(FLOW_DISSECTOR_KEY_ENC_CONTROL) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_KEYID) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_OPTS) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_PORTS) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_IP))
+	(BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_OPTS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP))
 
 #define NFP_FLOWER_WHITELIST_TUN_DISSECTOR_R \
-	(BIT(FLOW_DISSECTOR_KEY_ENC_CONTROL) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS))
+	(BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS))
 
 #define NFP_FLOWER_WHITELIST_TUN_DISSECTOR_V6_R \
-	(BIT(FLOW_DISSECTOR_KEY_ENC_CONTROL) | \
-	 BIT(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS))
+	(BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL) | \
+	 BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS))
 
 #define NFP_FLOWER_MERGE_FIELDS \
 	(NFP_FLOWER_LAYER_PORT | \
@@ -1303,7 +1303,7 @@ static bool offload_pre_check(struct flow_cls_offload *flow)
 	struct flow_dissector *dissector = rule->match.dissector;
 	struct flow_match_ct ct;
 
-	if (dissector->used_keys & BIT(FLOW_DISSECTOR_KEY_CT)) {
+	if (dissector->used_keys & BIT_ULL(FLOW_DISSECTOR_KEY_CT)) {
 		flow_rule_match_ct(rule, &ct);
 		/* Allow special case where CT match is all 0 */
 		if (memchr_inv(ct.key, 0, sizeof(*ct.key)))
diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 3010833ddde3..a5ac21a0ee33 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1827,12 +1827,12 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	memset(tuple, 0, sizeof(*tuple));
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS))) {
-		DP_NOTICE(edev, "Unsupported key set:0x%x\n",
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS))) {
+		DP_NOTICE(edev, "Unsupported key set:0x%llx\n",
 			  dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 15ebd3973922..4dc881159246 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -201,23 +201,23 @@ static int efx_tc_flower_parse_match(struct efx_nic *efx,
 		}
 	}
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_CVLAN) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_KEYID) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_IP) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_PORTS) |
-	      BIT(FLOW_DISSECTOR_KEY_ENC_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_TCP) |
-	      BIT(FLOW_DISSECTOR_KEY_IP))) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported flower keys %#x",
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CVLAN) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP))) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported flower keys %#llx",
 				       dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
@@ -228,12 +228,13 @@ static int efx_tc_flower_parse_match(struct efx_nic *efx,
 	    !(match->value.eth_proto == htons(ETH_P_IP) ||
 	      match->value.eth_proto == htons(ETH_P_IPV6)))
 		if (dissector->used_keys &
-		    (BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
-		     BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-		     BIT(FLOW_DISSECTOR_KEY_PORTS) |
-		     BIT(FLOW_DISSECTOR_KEY_IP) |
-		     BIT(FLOW_DISSECTOR_KEY_TCP))) {
-			NL_SET_ERR_MSG_FMT_MOD(extack, "L3/L4 flower keys %#x require protocol ipv[46]",
+		    (BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+		     BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+		     BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+		     BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
+		     BIT_ULL(FLOW_DISSECTOR_KEY_TCP))) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "L3/L4 flower keys %#llx require protocol ipv[46]",
 					       dissector->used_keys);
 			return -EINVAL;
 		}
@@ -281,9 +282,10 @@ static int efx_tc_flower_parse_match(struct efx_nic *efx,
 	if ((match->value.ip_proto != IPPROTO_UDP &&
 	     match->value.ip_proto != IPPROTO_TCP) || !IS_ALL_ONES(match->mask.ip_proto))
 		if (dissector->used_keys &
-		    (BIT(FLOW_DISSECTOR_KEY_PORTS) |
-		     BIT(FLOW_DISSECTOR_KEY_TCP))) {
-			NL_SET_ERR_MSG_FMT_MOD(extack, "L4 flower keys %#x require ipproto udp or tcp",
+		    (BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+		     BIT_ULL(FLOW_DISSECTOR_KEY_TCP))) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "L4 flower keys %#llx require ipproto udp or tcp",
 					       dissector->used_keys);
 			return -EINVAL;
 		}
@@ -344,12 +346,13 @@ static int efx_tc_flower_parse_match(struct efx_nic *efx,
 		MAP_ENC_KEY_AND_MASK(PORTS, ports, enc_ports, dst, enc_dport);
 		MAP_ENC_KEY_AND_MASK(KEYID, enc_keyid, enc_keyid, keyid, enc_keyid);
 	} else if (dissector->used_keys &
-		   (BIT(FLOW_DISSECTOR_KEY_ENC_KEYID) |
-		    BIT(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
-		    BIT(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
-		    BIT(FLOW_DISSECTOR_KEY_ENC_IP) |
-		    BIT(FLOW_DISSECTOR_KEY_ENC_PORTS))) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "Flower enc keys require enc_control (keys: %#x)",
+		   (BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
+		    BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
+		    BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
+		    BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP) |
+		    BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS))) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Flower enc keys require enc_control (keys: %#llx)",
 				       dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 687f43cd466c..f9e43fc32ee8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1355,7 +1355,7 @@ static int __stmmac_test_l3filt(struct stmmac_priv *priv, u32 dst, u32 src,
 		goto cleanup_rss;
 	}
 
-	dissector->used_keys |= (1 << FLOW_DISSECTOR_KEY_IPV4_ADDRS);
+	dissector->used_keys |= (1ULL << FLOW_DISSECTOR_KEY_IPV4_ADDRS);
 	dissector->offset[FLOW_DISSECTOR_KEY_IPV4_ADDRS] = 0;
 
 	cls = kzalloc(sizeof(*cls), GFP_KERNEL);
@@ -1481,8 +1481,8 @@ static int __stmmac_test_l4filt(struct stmmac_priv *priv, u32 dst, u32 src,
 		goto cleanup_rss;
 	}
 
-	dissector->used_keys |= (1 << FLOW_DISSECTOR_KEY_BASIC);
-	dissector->used_keys |= (1 << FLOW_DISSECTOR_KEY_PORTS);
+	dissector->used_keys |= (1ULL << FLOW_DISSECTOR_KEY_BASIC);
+	dissector->used_keys |= (1ULL << FLOW_DISSECTOR_KEY_PORTS);
 	dissector->offset[FLOW_DISSECTOR_KEY_BASIC] = 0;
 	dissector->offset[FLOW_DISSECTOR_KEY_PORTS] = offsetof(typeof(keys), key);
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index eced87fa261c..9ac2ff05d501 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -624,9 +624,9 @@ static int am65_cpsw_qos_clsflower_add_policer(struct am65_cpsw_port *port,
 	int ret;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS))) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Unsupported keys used");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index e966dd47e2db..ae52cdbcf8cc 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -1396,9 +1396,9 @@ static int cpsw_qos_clsflower_add_policer(struct cpsw_priv *priv,
 	int ret;
 
 	if (dissector->used_keys &
-	    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
-	      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS))) {
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS))) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Unsupported keys used");
 		return -EOPNOTSUPP;
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 8664ed4fbbdf..830f06b2f36d 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -370,7 +370,8 @@ struct flow_dissector_key {
 };
 
 struct flow_dissector {
-	unsigned int used_keys; /* each bit repesents presence of one key id */
+	unsigned long long  used_keys;
+		/* each bit represents presence of one key id */
 	unsigned short int offset[FLOW_DISSECTOR_KEY_MAX];
 };
 
@@ -430,7 +431,7 @@ void skb_flow_get_icmp_tci(const struct sk_buff *skb,
 static inline bool dissector_uses_key(const struct flow_dissector *flow_dissector,
 				      enum flow_dissector_key_id key_id)
 {
-	return flow_dissector->used_keys & (1 << key_id);
+	return flow_dissector->used_keys & (1ULL << key_id);
 }
 
 static inline void *skb_flow_dissector_target(struct flow_dissector *flow_dissector,
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 85a2d0d9bd39..ed5dfa376024 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -40,7 +40,7 @@
 static void dissector_set_key(struct flow_dissector *flow_dissector,
 			      enum flow_dissector_key_id key_id)
 {
-	flow_dissector->used_keys |= (1 << key_id);
+	flow_dissector->used_keys |= (1ULL << key_id);
 }
 
 void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4a51e0ec295c..10fa880047ac 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3207,7 +3207,7 @@ ethtool_rx_flow_rule_create(const struct ethtool_rx_flow_spec_input *input)
 		if (v4_m_spec->ip4src ||
 		    v4_m_spec->ip4dst) {
 			match->dissector.used_keys |=
-				BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS);
+				BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS);
 			match->dissector.offset[FLOW_DISSECTOR_KEY_IPV4_ADDRS] =
 				offsetof(struct ethtool_rx_flow_key, ipv4);
 		}
@@ -3222,7 +3222,7 @@ ethtool_rx_flow_rule_create(const struct ethtool_rx_flow_spec_input *input)
 		if (v4_m_spec->psrc ||
 		    v4_m_spec->pdst) {
 			match->dissector.used_keys |=
-				BIT(FLOW_DISSECTOR_KEY_PORTS);
+				BIT_ULL(FLOW_DISSECTOR_KEY_PORTS);
 			match->dissector.offset[FLOW_DISSECTOR_KEY_PORTS] =
 				offsetof(struct ethtool_rx_flow_key, tp);
 		}
@@ -3259,7 +3259,7 @@ ethtool_rx_flow_rule_create(const struct ethtool_rx_flow_spec_input *input)
 		if (!ipv6_addr_any((struct in6_addr *)v6_m_spec->ip6src) ||
 		    !ipv6_addr_any((struct in6_addr *)v6_m_spec->ip6dst)) {
 			match->dissector.used_keys |=
-				BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS);
+				BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS);
 			match->dissector.offset[FLOW_DISSECTOR_KEY_IPV6_ADDRS] =
 				offsetof(struct ethtool_rx_flow_key, ipv6);
 		}
@@ -3274,7 +3274,7 @@ ethtool_rx_flow_rule_create(const struct ethtool_rx_flow_spec_input *input)
 		if (v6_m_spec->psrc ||
 		    v6_m_spec->pdst) {
 			match->dissector.used_keys |=
-				BIT(FLOW_DISSECTOR_KEY_PORTS);
+				BIT_ULL(FLOW_DISSECTOR_KEY_PORTS);
 			match->dissector.offset[FLOW_DISSECTOR_KEY_PORTS] =
 				offsetof(struct ethtool_rx_flow_key, tp);
 		}
@@ -3282,7 +3282,7 @@ ethtool_rx_flow_rule_create(const struct ethtool_rx_flow_spec_input *input)
 			match->key.ip.tos = v6_spec->tclass;
 			match->mask.ip.tos = v6_m_spec->tclass;
 			match->dissector.used_keys |=
-				BIT(FLOW_DISSECTOR_KEY_IP);
+				BIT_ULL(FLOW_DISSECTOR_KEY_IP);
 			match->dissector.offset[FLOW_DISSECTOR_KEY_IP] =
 				offsetof(struct ethtool_rx_flow_key, ip);
 		}
@@ -3306,7 +3306,7 @@ ethtool_rx_flow_rule_create(const struct ethtool_rx_flow_spec_input *input)
 		break;
 	}
 
-	match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_BASIC);
+	match->dissector.used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_BASIC);
 	match->dissector.offset[FLOW_DISSECTOR_KEY_BASIC] =
 		offsetof(struct ethtool_rx_flow_key, basic);
 
@@ -3339,7 +3339,7 @@ ethtool_rx_flow_rule_create(const struct ethtool_rx_flow_spec_input *input)
 		if (ext_m_spec->vlan_etype ||
 		    ext_m_spec->vlan_tci) {
 			match->dissector.used_keys |=
-				BIT(FLOW_DISSECTOR_KEY_VLAN);
+				BIT_ULL(FLOW_DISSECTOR_KEY_VLAN);
 			match->dissector.offset[FLOW_DISSECTOR_KEY_VLAN] =
 				offsetof(struct ethtool_rx_flow_key, vlan);
 		}
@@ -3354,7 +3354,7 @@ ethtool_rx_flow_rule_create(const struct ethtool_rx_flow_spec_input *input)
 		       ETH_ALEN);
 
 		match->dissector.used_keys |=
-			BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS);
+			BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS);
 		match->dissector.offset[FLOW_DISSECTOR_KEY_ETH_ADDRS] =
 			offsetof(struct ethtool_rx_flow_key, eth_addrs);
 	}
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 1c26f03fc661..a010b25076ca 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -34,7 +34,7 @@ static void nf_flow_rule_lwt_match(struct nf_flow_match *match,
 {
 	struct nf_flow_key *mask = &match->mask;
 	struct nf_flow_key *key = &match->key;
-	unsigned int enc_keys;
+	unsigned long long enc_keys;
 
 	if (!tun_info || !(tun_info->mode & IP_TUNNEL_INFO_TX))
 		return;
@@ -43,8 +43,8 @@ static void nf_flow_rule_lwt_match(struct nf_flow_match *match,
 	NF_FLOW_DISSECTOR(match, FLOW_DISSECTOR_KEY_ENC_KEYID, enc_key_id);
 	key->enc_key_id.keyid = tunnel_id_to_key32(tun_info->key.tun_id);
 	mask->enc_key_id.keyid = 0xffffffff;
-	enc_keys = BIT(FLOW_DISSECTOR_KEY_ENC_KEYID) |
-		   BIT(FLOW_DISSECTOR_KEY_ENC_CONTROL);
+	enc_keys = BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL);
 
 	if (ip_tunnel_info_af(tun_info) == AF_INET) {
 		NF_FLOW_DISSECTOR(match, FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS,
@@ -55,7 +55,7 @@ static void nf_flow_rule_lwt_match(struct nf_flow_match *match,
 			mask->enc_ipv4.src = 0xffffffff;
 		if (key->enc_ipv4.dst)
 			mask->enc_ipv4.dst = 0xffffffff;
-		enc_keys |= BIT(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS);
+		enc_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS);
 		key->enc_control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
 	} else {
 		memcpy(&key->enc_ipv6.src, &tun_info->key.u.ipv6.dst,
@@ -70,7 +70,7 @@ static void nf_flow_rule_lwt_match(struct nf_flow_match *match,
 			   sizeof(struct in6_addr)))
 			memset(&mask->enc_ipv6.dst, 0xff,
 			       sizeof(struct in6_addr));
-		enc_keys |= BIT(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS);
+		enc_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS);
 		key->enc_control.addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
 	}
 
@@ -163,14 +163,14 @@ static int nf_flow_rule_match(struct nf_flow_match *match,
 		return -EOPNOTSUPP;
 	}
 	mask->control.addr_type = 0xffff;
-	match->dissector.used_keys |= BIT(key->control.addr_type);
+	match->dissector.used_keys |= BIT_ULL(key->control.addr_type);
 	mask->basic.n_proto = 0xffff;
 
 	switch (tuple->l4proto) {
 	case IPPROTO_TCP:
 		key->tcp.flags = 0;
 		mask->tcp.flags = cpu_to_be16(be32_to_cpu(TCP_FLAG_RST | TCP_FLAG_FIN) >> 16);
-		match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_TCP);
+		match->dissector.used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_TCP);
 		break;
 	case IPPROTO_UDP:
 	case IPPROTO_GRE:
@@ -182,9 +182,9 @@ static int nf_flow_rule_match(struct nf_flow_match *match,
 	key->basic.ip_proto = tuple->l4proto;
 	mask->basic.ip_proto = 0xff;
 
-	match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_META) |
-				      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
-				      BIT(FLOW_DISSECTOR_KEY_BASIC);
+	match->dissector.used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_META) |
+				      BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+				      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC);
 
 	switch (tuple->l4proto) {
 	case IPPROTO_TCP:
@@ -194,7 +194,7 @@ static int nf_flow_rule_match(struct nf_flow_match *match,
 		key->tp.dst = tuple->dst_port;
 		mask->tp.dst = 0xffff;
 
-		match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_PORTS);
+		match->dissector.used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_PORTS);
 		break;
 	}
 
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 910ef881c3b8..12ab78fa5d84 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -35,12 +35,12 @@ void nft_flow_rule_set_addr_type(struct nft_flow_rule *flow,
 	struct nft_flow_key *mask = &match->mask;
 	struct nft_flow_key *key = &match->key;
 
-	if (match->dissector.used_keys & BIT(FLOW_DISSECTOR_KEY_CONTROL))
+	if (match->dissector.used_keys & BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL))
 		return;
 
 	key->control.addr_type = addr_type;
 	mask->control.addr_type = 0xffff;
-	match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_CONTROL);
+	match->dissector.used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
 	match->dissector.offset[FLOW_DISSECTOR_KEY_CONTROL] =
 		offsetof(struct nft_flow_key, control);
 }
@@ -59,7 +59,7 @@ static void nft_flow_rule_transfer_vlan(struct nft_offload_ctx *ctx,
 		.mask	= match->mask.basic.n_proto,
 	};
 
-	if (match->dissector.used_keys & BIT(FLOW_DISSECTOR_KEY_VLAN) &&
+	if (match->dissector.used_keys & BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) &&
 	    (match->key.vlan.vlan_tpid == htons(ETH_P_8021Q) ||
 	     match->key.vlan.vlan_tpid == htons(ETH_P_8021AD))) {
 		match->key.basic.n_proto = match->key.cvlan.vlan_tpid;
@@ -70,8 +70,9 @@ static void nft_flow_rule_transfer_vlan(struct nft_offload_ctx *ctx,
 		match->mask.vlan.vlan_tpid = ethertype.mask;
 		match->dissector.offset[FLOW_DISSECTOR_KEY_CVLAN] =
 			offsetof(struct nft_flow_key, cvlan);
-		match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_CVLAN);
-	} else if (match->dissector.used_keys & BIT(FLOW_DISSECTOR_KEY_BASIC) &&
+		match->dissector.used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CVLAN);
+	} else if (match->dissector.used_keys &
+		   BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) &&
 		   (match->key.basic.n_proto == htons(ETH_P_8021Q) ||
 		    match->key.basic.n_proto == htons(ETH_P_8021AD))) {
 		match->key.basic.n_proto = match->key.vlan.vlan_tpid;
@@ -80,7 +81,7 @@ static void nft_flow_rule_transfer_vlan(struct nft_offload_ctx *ctx,
 		match->mask.vlan.vlan_tpid = ethertype.mask;
 		match->dissector.offset[FLOW_DISSECTOR_KEY_VLAN] =
 			offsetof(struct nft_flow_key, vlan);
-		match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_VLAN);
+		match->dissector.used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_VLAN);
 	}
 }
 
diff --git a/net/netfilter/nft_cmp.c b/net/netfilter/nft_cmp.c
index 6eb21a4f5698..cd4652259095 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -162,7 +162,7 @@ static int __nft_cmp_offload(struct nft_offload_ctx *ctx,
 	memcpy(key + reg->offset, data, reg->len);
 	memcpy(mask + reg->offset, datamask, reg->len);
 
-	flow->match.dissector.used_keys |= BIT(reg->key);
+	flow->match.dissector.used_keys |= BIT_ULL(reg->key);
 	flow->match.dissector.offset[reg->key] = reg->base_offset;
 
 	if (reg->key == FLOW_DISSECTOR_KEY_META &&
-- 
2.25.1

