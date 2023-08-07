Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502AF771EC5
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjHGKuN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjHGKuN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:50:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DE4F97;
        Mon,  7 Aug 2023 03:50:11 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 0934220861E6; Mon,  7 Aug 2023 03:50:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0934220861E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691405411;
        bh=wlQbnMoNYTIUFTlnlboiUtcBjn9Zi3YpgrgIpoIIo50=;
        h=From:To:Cc:Subject:Date:From;
        b=dlOGbRyrSv17W9cUwr1k3usY+YYbMg3mPLJE1zT5RD0L/qSPnOjkkdorJGTjmpFUE
         oDxf7XE724F1YLxTAtXKtdo790ZfsNo0BZGJVgmPRkR19ukoBa10UADPyXEgVJpJvx
         bRZ3KFICIGTynxws/Kb8wbqVAuEY7SfGkwKLC2dY=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Leon Romanovsky <leon@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH net-next] net: mana: Add gdma stats to ethtool output for mana
Date:   Mon,  7 Aug 2023 03:50:02 -0700
Message-Id: <1691405402-2641-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extended performance counter stats in 'ethtool -S <interface>'
for MANA VF to include GDMA tx LSO packets and bytes count.

Tested-on: Ubuntu22
Testcases:
1. LISA testcase:
PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
2. LISA testcase:
PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV
3. Validated the GDMA stat packets and byte counters
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 40 +++++++++
 .../ethernet/microsoft/mana/mana_ethtool.c    | 15 ++++
 include/net/mana/mana.h                       | 88 +++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ac2acc9aca9d..eb5e4164b9bf 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2234,6 +2234,46 @@ int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
 	return 0;
 }
 
+void mana_query_gf_stats(struct mana_port_context *apc)
+{
+	struct mana_query_gf_stat_req	req = {};
+	struct mana_query_gf_stat_resp resp = {};
+	struct net_device *ndev = apc->ndev;
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_GF_STAT,
+			     sizeof(req), sizeof(resp));
+	req.req_stats = STATISTICS_FLAGS_HC_TX_BYTES |
+			STATISTICS_FLAGS_HC_TX_UCAST_PACKETS |
+			STATISTICS_FLAGS_HC_TX_UCAST_BYTES |
+			STATISTICS_FLAGS_HC_TX_MCAST_PACKETS |
+			STATISTICS_FLAGS_HC_TX_MCAST_BYTES |
+			STATISTICS_FLAGS_HC_TX_BCAST_PACKETS |
+			STATISTICS_FLAGS_HC_TX_BCAST_BYTES;
+
+	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
+				sizeof(resp));
+	if (err) {
+		netdev_err(ndev, "Failed to query GF stats: %d\n", err);
+		return;
+	}
+	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_GF_STAT,
+				   sizeof(resp));
+	if (err || resp.hdr.status) {
+		netdev_err(ndev, "Failed to query GF stats: %d, 0x%x\n", err,
+			   resp.hdr.status);
+		return;
+	}
+
+	apc->eth_stats.hc_tx_bytes = resp.hc_tx_bytes;
+	apc->eth_stats.hc_tx_ucast_pkts = resp.hc_tx_ucast_pkts;
+	apc->eth_stats.hc_tx_ucast_bytes = resp.hc_tx_ucast_bytes;
+	apc->eth_stats.hc_tx_bcast_pkts = resp.hc_tx_bcast_pkts;
+	apc->eth_stats.hc_tx_bcast_bytes = resp.hc_tx_bcast_bytes;
+	apc->eth_stats.hc_tx_mcast_pkts = resp.hc_tx_mcast_pkts;
+	apc->eth_stats.hc_tx_mcast_bytes = resp.hc_tx_mcast_bytes;
+}
+
 static int mana_init_port(struct net_device *ndev)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 0dc78679f620..607150165ab4 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -13,6 +13,19 @@ static const struct {
 } mana_eth_stats[] = {
 	{"stop_queue", offsetof(struct mana_ethtool_stats, stop_queue)},
 	{"wake_queue", offsetof(struct mana_ethtool_stats, wake_queue)},
+	{"hc_tx_bytes", offsetof(struct mana_ethtool_stats, hc_tx_bytes)},
+	{"hc_tx_ucast_pkts", offsetof(struct mana_ethtool_stats,
+					hc_tx_ucast_pkts)},
+	{"hc_tx_ucast_bytes", offsetof(struct mana_ethtool_stats,
+					hc_tx_ucast_bytes)},
+	{"hc_tx_bcast_pkts", offsetof(struct mana_ethtool_stats,
+					hc_tx_bcast_pkts)},
+	{"hc_tx_bcast_bytes", offsetof(struct mana_ethtool_stats,
+					hc_tx_bcast_bytes)},
+	{"hc_tx_mcast_pkts", offsetof(struct mana_ethtool_stats,
+					hc_tx_mcast_pkts)},
+	{"hc_tx_mcast_bytes", offsetof(struct mana_ethtool_stats,
+					hc_tx_mcast_bytes)},
 	{"tx_cq_err", offsetof(struct mana_ethtool_stats, tx_cqe_err)},
 	{"tx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
 					tx_cqe_unknown_type)},
@@ -114,6 +127,8 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 
 	if (!apc->port_is_up)
 		return;
+	/* we call mana function to update stats from GDMA */
+	mana_query_gf_stats(apc);
 
 	for (q = 0; q < ARRAY_SIZE(mana_eth_stats); q++)
 		data[i++] = *(u64 *)(eth_stats + mana_eth_stats[q].offset);
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 024ad8ddb27e..1a751c73e69a 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -347,6 +347,13 @@ struct mana_tx_qp {
 struct mana_ethtool_stats {
 	u64 stop_queue;
 	u64 wake_queue;
+	u64 hc_tx_bytes;
+	u64 hc_tx_ucast_pkts;
+	u64 hc_tx_ucast_bytes;
+	u64 hc_tx_bcast_pkts;
+	u64 hc_tx_bcast_bytes;
+	u64 hc_tx_mcast_pkts;
+	u64 hc_tx_mcast_bytes;
 	u64 tx_cqe_err;
 	u64 tx_cqe_unknown_type;
 	u64 rx_coalesced_err;
@@ -437,6 +444,7 @@ u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq *rxq,
 struct bpf_prog *mana_xdp_get(struct mana_port_context *apc);
 void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
+void mana_query_gf_stats(struct mana_port_context *apc);
 
 extern const struct ethtool_ops mana_ethtool_ops;
 
@@ -578,6 +586,49 @@ struct mana_fence_rq_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW DATA */
 
+/* Query stats RQ */
+struct mana_query_gf_stat_req {
+	struct gdma_req_hdr hdr;
+	u64 req_stats;
+}; /* HW DATA */
+
+struct mana_query_gf_stat_resp {
+	struct gdma_resp_hdr hdr;
+	u64 reported_stats;
+	/* rx errors/discards */
+	u64 discard_rx_nowqe;
+	u64 err_rx_vport_disabled;
+	/* rx bytes/packets */
+	u64 hc_rx_bytes;
+	u64 hc_rx_ucast_pkts;
+	u64 hc_rx_ucast_bytes;
+	u64 hc_rx_bcast_pkts;
+	u64 hc_rx_bcast_bytes;
+	u64 hc_rx_mcast_pkts;
+	u64 hc_rx_mcast_bytes;
+	/* tx errors */
+	u64 err_tx_gf_disabled;
+	u64 err_tx_vport_disabled;
+	u64 err_tx_inval_vport_offset_pkt;
+	u64 err_tx_vlan_enforcement;
+	u64 err_tx_ethtype_enforcement;
+	u64 err_tx_SA_enforecement;
+	u64 err_tx_SQPDID_enforcement;
+	u64 err_tx_CQPDID_enforcement;
+	u64 err_tx_mtu_violation;
+	u64 err_tx_inval_oob;
+	/* tx bytes/packets */
+	u64 hc_tx_bytes;
+	u64 hc_tx_ucast_pkts;
+	u64 hc_tx_ucast_bytes;
+	u64 hc_tx_bcast_pkts;
+	u64 hc_tx_bcast_bytes;
+	u64 hc_tx_mcast_pkts;
+	u64 hc_tx_mcast_bytes;
+	/* tx error */
+	u64 err_tx_gdma;
+}; /* HW DATA */
+
 /* Configure vPort Rx Steering */
 struct mana_cfg_rx_steer_req_v2 {
 	struct gdma_req_hdr hdr;
@@ -657,6 +708,43 @@ struct mana_deregister_filter_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW DATA */
 
+/* Requested GF stats Flags */
+/* Rx discards/Errors */
+#define STATISTICS_FLAGS_RX_DISCARDS_NO_WQE		0x0000000000000001
+#define STATISTICS_FLAGS_RX_ERRORS_VPORT_DISABLED	0x0000000000000002
+/* Rx bytes/pkts */
+#define STATISTICS_FLAGS_HC_RX_BYTES			0x0000000000000004
+#define STATISTICS_FLAGS_HC_RX_UCAST_PACKETS		0x0000000000000008
+#define STATISTICS_FLAGS_HC_RX_UCAST_BYTES		0x0000000000000010
+#define STATISTICS_FLAGS_HC_RX_MCAST_PACKETS		0x0000000000000020
+#define STATISTICS_FLAGS_HC_RX_MCAST_BYTES		0x0000000000000040
+#define STATISTICS_FLAGS_HC_RX_BCAST_PACKETS		0x0000000000000080
+#define STATISTICS_FLAGS_HC_RX_BCAST_BYTES		0x0000000000000100
+/* Tx errors */
+#define STATISTICS_FLAGS_TX_ERRORS_GF_DISABLED		0x0000000000000200
+#define STATISTICS_FLAGS_TX_ERRORS_VPORT_DISABLED	0x0000000000000400
+#define STATISTICS_FLAGS_TX_ERRORS_INVAL_VPORT_OFFSET_PACKETS		\
+							0x0000000000000800
+#define STATISTICS_FLAGS_TX_ERRORS_VLAN_ENFORCEMENT	0x0000000000001000
+#define STATISTICS_FLAGS_TX_ERRORS_ETH_TYPE_ENFORCEMENT			\
+							0x0000000000002000
+#define STATISTICS_FLAGS_TX_ERRORS_SA_ENFORCEMENT	0x0000000000004000
+#define STATISTICS_FLAGS_TX_ERRORS_SQPDID_ENFORCEMENT	0x0000000000008000
+#define STATISTICS_FLAGS_TX_ERRORS_CQPDID_ENFORCEMENT	0x0000000000010000
+#define STATISTICS_FLAGS_TX_ERRORS_MTU_VIOLATION	0x0000000000020000
+#define STATISTICS_FLAGS_TX_ERRORS_INVALID_OOB		0x0000000000040000
+/* Tx bytes/pkts */
+#define STATISTICS_FLAGS_HC_TX_BYTES			0x0000000000080000
+#define STATISTICS_FLAGS_HC_TX_UCAST_PACKETS		0x0000000000100000
+#define STATISTICS_FLAGS_HC_TX_UCAST_BYTES		0x0000000000200000
+#define STATISTICS_FLAGS_HC_TX_MCAST_PACKETS		0x0000000000400000
+#define STATISTICS_FLAGS_HC_TX_MCAST_BYTES		0x0000000000800000
+#define STATISTICS_FLAGS_HC_TX_BCAST_PACKETS		0x0000000001000000
+#define STATISTICS_FLAGS_HC_TX_BCAST_BYTES		0x0000000002000000
+/* Tx error */
+#define STATISTICS_FLAGS_TX_ERRORS_GDMA_ERROR		0x0000000004000000
+
+
 #define MANA_MAX_NUM_QUEUES 64
 
 #define MANA_SHORT_VPORT_OFFSET_MAX ((1U << 8) - 1)
-- 
2.34.1

