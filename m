Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B663408E6A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 15:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbhIMNds (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 09:33:48 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com ([40.107.244.114]:33536
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242697AbhIMN3z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 09:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAwLRjp0eaN8v0MxvsVnJAEfbU8D8STF+nv1ztIVO51Xipl0RbfbM+kR5buVZuJFvTYfeEiFGjU+L3XGZigklti5GK10Yca5SZhyxflbpTfDyw6DFXQ246+HmX/iHqkzSGZg1uB4Pg8fxPus518Q3HsVVwLVh7PLXed6/+WdZrZcp5uKTH9R3oM9g5H0VSqWRwzCyV20Ed5hfEgTVtdcSHXjdvpEl6PGPWI/mi07ZzlN4+3Jod8YKCYfoRZCA7Y+uDvnx5qHuRmzQnsbTbG04exjEbTc+fw9+h9EJcsXWyBJMAvGgLR5tvgpgngManp4b2R3oeSCInLxf7RQLvwiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=azbwXoyBPw4CFbHMQiU41wRCJyZPh/BW/PFkgRFDf10=;
 b=AGbaxQNVR0gXFPrL5ltnX4brYJ8j2N7CXN5Q4/q77V0l33lq7zxqfXtxVfAmvTelpfpnwJX8pHBrxwnrFw4gaLAl+U1qvYldbfRMQSLzAic4qohiZjhvRJgd/DYmL22vGEQ2lb3AappF5vFD3U6PKYU1ekBrxEHRVOQVBpO0ZxoeJ7uheZLUQyLL93D293EOW53kxSm0O92xjsFBHKqIhsNIzLyPzYsrsVNBQ99dhwxg6v6v2/0ETX/nSZyui0XUeG+0eaxD6q7eW7dnaxY97N6WKsDlx2jQenuxBqFSeetJ/A3iT9mp4DDJ6/ru+WGs5HBfbfgMM/fWjbB/bVTAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azbwXoyBPw4CFbHMQiU41wRCJyZPh/BW/PFkgRFDf10=;
 b=SNpR+WBgb/f9sVVQMmNhsGAHfVom4HLJfT/oUVcXPnwRjBcrguOlMahZXsEyTcr7nHJGCkdmIcQj8C7a+CUv0QWX37Bg6PfLIfiaAYqTZ3bJukEUee6VOY5XqB6g2BXM71D6KQAaIA8O/KDQwIxo4KueIWy82WpEbuVjnUmv9nDT7pnEVjeK0HFItC2XPeUcy0x8jQ5UP0/CdYCvWg7myLfoeuIRVNXkI6PR5GYRMC3NsvosRthouDnjqeZG1m4gtBnVcq5EbBikmkyhr2cFYGipHdX8Z9HvWmdJySxCbfEJQQxf03iVq3r+7O/C0Lq+n1wDYYSU+OjL0Y+ndlyYtw==
Received: from BN6PR22CA0054.namprd22.prod.outlook.com (2603:10b6:404:ca::16)
 by PH0PR01MB6261.prod.exchangelabs.com (2603:10b6:510:8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Mon, 13 Sep 2021 13:28:37 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::b4) by BN6PR22CA0054.outlook.office365.com
 (2603:10b6:404:ca::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 13:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 13:28:37 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 18DDSbtJ147395;
        Mon, 13 Sep 2021 09:28:37 -0400
Subject: [PATCH for-next 3/6] IB/hfi1: Get rid of tx priv backpointer
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Mon, 13 Sep 2021 09:28:37 -0400
Message-ID: <20210913132836.131370.89704.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
References: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae925640-62b0-41bf-c6f7-08d976ba64c0
X-MS-TrafficTypeDiagnostic: PH0PR01MB6261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB62612A8DAD167886E2750AACF4D99@PH0PR01MB6261.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpsAbvrHXCc+KQORvP0o40QFYeitAkbKu/ErRhjvNb6xySpA8BwqWrbE895ifSgFsBDctI5H819Y/2E6tNms85z/uCkP1P+OdY8rp5xl3A9l17oIhitDebdp+67H7rTE9xtu2XYl5yNA4MN3RPin5Cp9C60K5ZPyHzRwHsW26kJshMlRgOOz54eSjBfaDsinBcBriAJN9MV1QJ4ZuvfKNqkpW1glQxEniCjN5ZY3I7eWMXDoHQRoQc/UtybsR0sbjmdMcT7Wcj+VPC/1lVWXj2Ofscz3ZrtbjDmyWPndNT8JpzQn5Sq1OWmp7K9ANyW5m0omCeSEPK0DkCP9po2zrnCumbWDTC87fNxGNZxyQDZhefWiNI5x8MiByBoToo4Hg7Vu6x2AHPcBAsPkl6qDeAPPBpBQkaoTJ9tTzKM+//DTqf7LbX90g/On2JFjAZzWgXKGG1aPUrmGITVc9e+GZXZLIKL2c2VtQ/VYZH2X05Hzz2O7vOuPavhLAWmsblukNc2JAuHznO5vBoeYgaQ8OlN/lf87sjWkXRvtDKy2wktG8xM9PgjfAaUpvUu7yPonfHMiBmXsi2+e/aQ1F+bIZpRX+Dq9ZnkyWUvHnYZBQVQh42feDhcB/2P19QiZ/yXil+Vy1X8W2msX+SqztC76UspyyxltCzlBIuzq5howyP781faDIBjdZysTp3fHj3/u31SEcbc/ZFDTtgeYQs/GjlJBIfrZ1EuiX7mJXUhpWg+d2S6sACSHBGAh0mrd+Lpz
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39830400003)(36840700001)(46966006)(336012)(36906005)(103116003)(426003)(8936002)(44832011)(107886003)(8676002)(82310400003)(186003)(81166007)(7126003)(316002)(86362001)(2906002)(26005)(4326008)(478600001)(83380400001)(47076005)(5660300002)(36860700001)(55016002)(356005)(70206006)(70586007)(7696005)(1076003)(26583001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 13:28:37.5606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae925640-62b0-41bf-c6f7-08d976ba64c0
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6261
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The txq has the backpointer, so this is a micro optimization
for the tx path.

Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 053eb43..734b91d 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -133,7 +133,7 @@ static void hfi1_ipoib_check_queue_stopped(struct hfi1_ipoib_txq *txq)
 
 static void hfi1_ipoib_free_tx(struct ipoib_txreq *tx, int budget)
 {
-	struct hfi1_ipoib_dev_priv *priv = tx->priv;
+	struct hfi1_ipoib_dev_priv *priv = tx->txq->priv;
 
 	if (likely(!tx->sdma_status)) {
 		dev_sw_netstats_tx_add(priv->netdev, 1, tx->skb->len);
@@ -273,7 +273,7 @@ static int hfi1_ipoib_build_tx_desc(struct ipoib_txreq *tx,
 static void hfi1_ipoib_build_ib_tx_headers(struct ipoib_txreq *tx,
 					   struct ipoib_txparms *txp)
 {
-	struct hfi1_ipoib_dev_priv *priv = tx->priv;
+	struct hfi1_ipoib_dev_priv *priv = tx->txq->priv;
 	struct hfi1_sdma_header *sdma_hdr = &tx->sdma_hdr;
 	struct sk_buff *skb = tx->skb;
 	struct hfi1_pportdata *ppd = ppd_from_ibp(txp->ibp);
@@ -383,7 +383,6 @@ static struct ipoib_txreq *hfi1_ipoib_send_dma_common(struct net_device *dev,
 
 	/* so that we can test if the sdma descriptors are there */
 	tx->txreq.num_desc = 0;
-	tx->priv = priv;
 	tx->txq = txq;
 	tx->skb = skb;
 	INIT_LIST_HEAD(&tx->txreq.list);
@@ -491,7 +490,7 @@ static int hfi1_ipoib_send_dma_single(struct net_device *dev,
 	ret = hfi1_ipoib_submit_tx(txq, tx);
 	if (likely(!ret)) {
 tx_ok:
-		trace_sdma_output_ibhdr(tx->priv->dd,
+		trace_sdma_output_ibhdr(txq->priv->dd,
 					&tx->sdma_hdr.hdr,
 					ib_is_sc5(txp->flow.sc5));
 		hfi1_ipoib_check_queue_depth(txq);
@@ -554,7 +553,7 @@ static int hfi1_ipoib_send_dma_list(struct net_device *dev,
 
 	hfi1_ipoib_check_queue_depth(txq);
 
-	trace_sdma_output_ibhdr(tx->priv->dd,
+	trace_sdma_output_ibhdr(txq->priv->dd,
 				&tx->sdma_hdr.hdr,
 				ib_is_sc5(txp->flow.sc5));
 

