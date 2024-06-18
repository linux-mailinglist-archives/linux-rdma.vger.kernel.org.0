Return-Path: <linux-rdma+bounces-3251-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1064590C02C
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 02:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5141F2300E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95736B;
	Tue, 18 Jun 2024 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iORyRVYl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3BEC0
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669490; cv=fail; b=TrYpRvGShTcbNSTlI2KNSO9/gg9Au6rCCPzSd28sodBzoR0KylGv0Hc6crMbaVr+mwx+5r70axtmJzKakNqWBgiXxBNoJ6QGx/BV8JqvPi4z86POiieZB9oYMjMAGBZGZdzZjpsPeOMXohelCp/8BRGnCdOKY/1QF8Dv7ZcwfaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669490; c=relaxed/simple;
	bh=jEA3DL6kOho/Apceyp4mIIeXVaoVFCysgsfHsvx5mM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h22wOQCEo0KQPBpx9xruWduI7ADgM8M88Ci8GW+TJkGVgYgiOMkdYgThINOUCUMOW8z4nSdlgrDJ5flU1pofDDbyV4nYcbvqAHQgdfMUMsXNLdSh6JYSWGOCzAoxP+Xxj6k+kKIX69asF3EdJyQdsRGIgPtOBQFVlX8c2pLfMvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iORyRVYl; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyM7so9qpkKVVBIjADmntjRhTkv6ciSwPdwbxcKg+mTWEOuNHqs3B7kqaqIyLmdH9FaBYVEYvyDtZwquiVvJ3Pk6iuMzo9HZcQL3zlOaLL7eYUvRWvghXC/97hM8X3GLKVmuVRYtHSis1iUTW/lJUS4QXiJPBlfwi5GNdYRtTo1zi8nwITE/iVgABAcV5tJR2QQFNZvC8nuMAvkdno8r2EHeNa1sPLplidNRLTKCBYnST2w1PUkARgYXnbH0um66CnKE70Q3we84BTHwCpehsWiiqPqscny2QKdN56hPg5XeKZjONClZQLacxH/gtNqOVXIAkCAjbORSsIVXiPQUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk3CkK/FLqpzgGWwd0+Htl86hXqhHKAXdjbwIrb839k=;
 b=eQgKb3RV4Vs9EyA7JOJHLUakkTLGZXxVHeBlfql8arbJDCOAA4ActQTIemU88WZxI/6Im9GSyD5QX5aDORuBndvhi2rvarTP/zzWSe0SBtCvbVqMMSlX2J8i4KDQPfQR18dKgIcl9HFQpyKrRsDAL8mQiIiwN3zhi5rivbKMPL1/L4Eqkp6FNTd1AogQOIb3ZeDeZBIPNWYK7fpBlI3LnuUiJ1FWKpOpokca4aEnnHfyuOKczTh3numwEQwLwxj40cOrS1umU0gb3QMVJzeNr1Z5r0OkeJ4g+pcqRZoxkfoIND/Lf7tGlgAVPWJ0EzSZJTGlnUS3Ti3B9UkjcmseDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk3CkK/FLqpzgGWwd0+Htl86hXqhHKAXdjbwIrb839k=;
 b=iORyRVYlbJjycZMfa5ZzlfKhGLYZA2Y+ic5IsUEVimv4opwkKThlPjQ3Ql46InkbP08up9oY4cmuxkU0XOHQGcFnxcevNDDEpB4lWXjZs1WosUWAHG3IHv3gR050+5HuupcTJzmj1f711HwMvT+Wh47yW7dl7WcTcowKy0huEtFGZugrpPtkRFQb2sbLkLKXuCDkiXGJNLEuAsaAdqw1/mBMTmIKaZA4gkhdThiCVvVw5amodFX5ncaicgQdk8kfcxjMGx2X4H/dQB0Q9KVl2XyCOnYBxCajRN1jsHgXlB2cP4tSfg+lYImRhpx/Ie51YE8YGxrIYJ6H7JrDYVP9ag==
Received: from SA9P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::6) by
 PH7PR12MB6612.namprd12.prod.outlook.com (2603:10b6:510:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 00:11:22 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::2) by SA9P221CA0001.outlook.office365.com
 (2603:10b6:806:25::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 00:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 00:11:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:11:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:11:03 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 17:11:00 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <chuck.lever@oracle.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <maorg@nvidia.com>,
	<yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 6/6] RDMA/IPoIB: remove the handling of last WQE reached event
Date: Tue, 18 Jun 2024 03:10:34 +0300
Message-ID: <20240618001034.22681-7-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240618001034.22681-1-mgurtovoy@nvidia.com>
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|PH7PR12MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: c9514193-e4e1-46ba-8c96-08dc8f2b2f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X7IGNXOHsWSX+OXHSwxku5dy9VewbJhvw8S+QfteVjixs17N1jMcL44zSm/P?=
 =?us-ascii?Q?qyFqa4bhyiV5NuFymAFb64PEKeG1vb80RMsM+2z1zFUlGPLBK2fW5Gt5iSc8?=
 =?us-ascii?Q?iVB25J1SGM3HNR+pYiQetUlgRknHHOreMT30+ryjVRQT7NbdKYQqr9p7r8IF?=
 =?us-ascii?Q?BQMO631sDPW5xMZk/XAiiwI3PLvuw5LqQHL+Ved3K/KsjXy5udyanos66htC?=
 =?us-ascii?Q?wjSKw+fuJS3bmhxuhF+48qURzvvrXZvG2eRTXULtjpHjZTdfgweKQTteXA+S?=
 =?us-ascii?Q?AeK98Zi++NHEBsSN0PmmigBmvjLuuQWDAqkLAYuExRB3Uaq4DArXcvuR8h9y?=
 =?us-ascii?Q?jDn+yG5pdk4r5VPSGZsT+wOS9gTouKEPPVrdFzFpOEL6Q0h8a2ariTBI1BYk?=
 =?us-ascii?Q?OssuZOFXb6U7d4L1vOLYodxdK9lNB9tNV+RXB65MDqrB0LwFJfSsKCN027N8?=
 =?us-ascii?Q?0gr21K9RcN4KEMmfnkKTBMx0DAl9bMdB7ERKOm1hCuqArgsk+Ury2pI0ZbV7?=
 =?us-ascii?Q?opLDq8NS5Wltp4Y/3hL1vt0cwy+3GZDiylXuNYh9rcJRlIBT7wxNkoDqSv2B?=
 =?us-ascii?Q?o9PKJpvBxFSLpJ25NMZxocvu2kvHUHdURRqv4UleRgsxpFibow4DK8unKJcl?=
 =?us-ascii?Q?2h218Av8fvlaAbl8FMcIBXHC8C8V6W4vxgx5WWFGF5NMUthL2v0+rGj21LNY?=
 =?us-ascii?Q?T0eeD5pe94nvFDnFY4bo4EB2uSgJO2vSOBYPeUGfYDBdy3zt+XBM20VECcw/?=
 =?us-ascii?Q?lpc9fKfmKYZWZuWJ0Y5z+xb51PHMX1Y4MGijbgvO0OFWU3WmhxZwdR6eECdH?=
 =?us-ascii?Q?hVh7HGiyPDTdeVJS2f79eHraGlz0/5+HOxJNpEPPLBE3X0LKbyBinG2kAWqi?=
 =?us-ascii?Q?WK0tkW5ToeMBkK1gPsvD7tmnfbcHbD7dgQUVuZ3Xy9hqZwTItOm2TvSK67co?=
 =?us-ascii?Q?fAIVRxgrqihdiaoLdVL7TYYXGWqseaczNcvTklrWoDhyRB74PpRWGBXHFV7X?=
 =?us-ascii?Q?nap4iqhyuC1fiPDpSMZU7LtzWEp1yRZQBMvuNjd+UmJBCR5AhLMZwVpbhMEw?=
 =?us-ascii?Q?jF+9dy7oBdHCLNrLzpg0VoMhVEYhHg6tlTx5Qf9Fw73xzNqHpGLAv3/EtetQ?=
 =?us-ascii?Q?ZmY90jJJG27x0nDil9z0mhYQgRsYYj61lH2Mv+pprH4IYYz9wlgmZMvP2+Cf?=
 =?us-ascii?Q?B8HQZfohZKfRy/NuuuWcpPFvgC48oFlCgifcA8lrmJetKwhNlDzDvF/hOfix?=
 =?us-ascii?Q?8eNVuzBoJ8PYswH+IV0chl5ldxqMmyC7P6e0anVxsAko5OGJjjOg99gQjDDG?=
 =?us-ascii?Q?xRfEU6FfQEAbXpSbRNpACg2BpLC22SqRLElyaS4LEIEptVxVTEo1fN6w+VfN?=
 =?us-ascii?Q?9d5GJFfD3RCBtqn9GHFCjR4WRYTZD64hchVtIptR9fmZz/MTVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:11:22.0909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9514193-e4e1-46ba-8c96-08dc8f2b2f79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612

This event is handled by the RDMA core layer.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib.h    | 33 +-----------
 drivers/infiniband/ulp/ipoib/ipoib_cm.c | 71 +++----------------------
 2 files changed, 8 insertions(+), 96 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 963e936da5e3..0f1e4b431af4 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -198,37 +198,10 @@ struct ipoib_cm_data {
 	__be32 mtu;
 };
 
-/*
- * Quoting 10.3.1 Queue Pair and EE Context States:
- *
- * Note, for QPs that are associated with an SRQ, the Consumer should take the
- * QP through the Error State before invoking a Destroy QP or a Modify QP to the
- * Reset State.  The Consumer may invoke the Destroy QP without first performing
- * a Modify QP to the Error State and waiting for the Affiliated Asynchronous
- * Last WQE Reached Event. However, if the Consumer does not wait for the
- * Affiliated Asynchronous Last WQE Reached Event, then WQE and Data Segment
- * leakage may occur. Therefore, it is good programming practice to tear down a
- * QP that is associated with an SRQ by using the following process:
- *
- * - Put the QP in the Error State
- * - Wait for the Affiliated Asynchronous Last WQE Reached Event;
- * - either:
- *       drain the CQ by invoking the Poll CQ verb and either wait for CQ
- *       to be empty or the number of Poll CQ operations has exceeded
- *       CQ capacity size;
- * - or
- *       post another WR that completes on the same CQ and wait for this
- *       WR to return as a WC;
- * - and then invoke a Destroy QP or Reset QP.
- *
- * We use the second option and wait for a completion on the
- * same CQ before destroying QPs attached to our SRQ.
- */
-
 enum ipoib_cm_state {
 	IPOIB_CM_RX_LIVE,
 	IPOIB_CM_RX_ERROR, /* Ignored by stale task */
-	IPOIB_CM_RX_FLUSH  /* Last WQE Reached event observed */
+	IPOIB_CM_RX_FLUSH
 };
 
 struct ipoib_cm_rx {
@@ -267,9 +240,7 @@ struct ipoib_cm_dev_priv {
 	struct ib_cm_id	       *id;
 	struct list_head	passive_ids;   /* state: LIVE */
 	struct list_head	rx_error_list; /* state: ERROR */
-	struct list_head	rx_flush_list; /* state: FLUSH, drain not started */
-	struct list_head	rx_drain_list; /* state: FLUSH, drain started */
-	struct list_head	rx_reap_list;  /* state: FLUSH, drain done */
+	struct list_head	rx_reap_list;  /* state: FLUSH */
 	struct work_struct      start_task;
 	struct work_struct      reap_task;
 	struct work_struct      skb_task;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index b610d36295bb..18ead80b5756 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -71,12 +71,6 @@ static struct ib_qp_attr ipoib_cm_err_attr = {
 	.qp_state = IB_QPS_ERR
 };
 
-#define IPOIB_CM_RX_DRAIN_WRID 0xffffffff
-
-static struct ib_send_wr ipoib_cm_rx_drain_wr = {
-	.opcode = IB_WR_SEND,
-};
-
 static int ipoib_cm_tx_handler(struct ib_cm_id *cm_id,
 			       const struct ib_cm_event *event);
 
@@ -208,50 +202,11 @@ static void ipoib_cm_free_rx_ring(struct net_device *dev,
 	vfree(rx_ring);
 }
 
-static void ipoib_cm_start_rx_drain(struct ipoib_dev_priv *priv)
-{
-	struct ipoib_cm_rx *p;
-
-	/* We only reserved 1 extra slot in CQ for drain WRs, so
-	 * make sure we have at most 1 outstanding WR. */
-	if (list_empty(&priv->cm.rx_flush_list) ||
-	    !list_empty(&priv->cm.rx_drain_list))
-		return;
-
-	/*
-	 * QPs on flush list are error state.  This way, a "flush
-	 * error" WC will be immediately generated for each WR we post.
-	 */
-	p = list_entry(priv->cm.rx_flush_list.next, typeof(*p), list);
-	ipoib_cm_rx_drain_wr.wr_id = IPOIB_CM_RX_DRAIN_WRID;
-	if (ib_post_send(p->qp, &ipoib_cm_rx_drain_wr, NULL))
-		ipoib_warn(priv, "failed to post drain wr\n");
-
-	list_splice_init(&priv->cm.rx_flush_list, &priv->cm.rx_drain_list);
-}
-
-static void ipoib_cm_rx_event_handler(struct ib_event *event, void *ctx)
-{
-	struct ipoib_cm_rx *p = ctx;
-	struct ipoib_dev_priv *priv = ipoib_priv(p->dev);
-	unsigned long flags;
-
-	if (event->event != IB_EVENT_QP_LAST_WQE_REACHED)
-		return;
-
-	spin_lock_irqsave(&priv->lock, flags);
-	list_move(&p->list, &priv->cm.rx_flush_list);
-	p->state = IPOIB_CM_RX_FLUSH;
-	ipoib_cm_start_rx_drain(priv);
-	spin_unlock_irqrestore(&priv->lock, flags);
-}
-
 static struct ib_qp *ipoib_cm_create_rx_qp(struct net_device *dev,
 					   struct ipoib_cm_rx *p)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	struct ib_qp_init_attr attr = {
-		.event_handler = ipoib_cm_rx_event_handler,
 		.send_cq = priv->recv_cq, /* For drain WR */
 		.recv_cq = priv->recv_cq,
 		.srq = priv->cm.srq,
@@ -479,8 +434,7 @@ static int ipoib_cm_req_handler(struct ib_cm_id *cm_id,
 	spin_lock_irq(&priv->lock);
 	queue_delayed_work(priv->wq,
 			   &priv->cm.stale_task, IPOIB_CM_RX_DELAY);
-	/* Add this entry to passive ids list head, but do not re-add it
-	 * if IB_EVENT_QP_LAST_WQE_REACHED has moved it to flush list. */
+	/* Add this entry to passive ids list head. */
 	p->jiffies = jiffies;
 	if (p->state == IPOIB_CM_RX_LIVE)
 		list_move(&p->list, &priv->cm.passive_ids);
@@ -574,15 +528,8 @@ void ipoib_cm_handle_rx_wc(struct net_device *dev, struct ib_wc *wc)
 		       wr_id, wc->status);
 
 	if (unlikely(wr_id >= ipoib_recvq_size)) {
-		if (wr_id == (IPOIB_CM_RX_DRAIN_WRID & ~(IPOIB_OP_CM | IPOIB_OP_RECV))) {
-			spin_lock_irqsave(&priv->lock, flags);
-			list_splice_init(&priv->cm.rx_drain_list, &priv->cm.rx_reap_list);
-			ipoib_cm_start_rx_drain(priv);
-			queue_work(priv->wq, &priv->cm.rx_reap_task);
-			spin_unlock_irqrestore(&priv->lock, flags);
-		} else
-			ipoib_warn(priv, "cm recv completion event with wrid %d (> %d)\n",
-				   wr_id, ipoib_recvq_size);
+		ipoib_warn(priv, "cm recv completion event with wrid %d (> %d)\n",
+			   wr_id, ipoib_recvq_size);
 		return;
 	}
 
@@ -603,6 +550,7 @@ void ipoib_cm_handle_rx_wc(struct net_device *dev, struct ib_wc *wc)
 		else {
 			if (!--p->recv_count) {
 				spin_lock_irqsave(&priv->lock, flags);
+				p->state = IPOIB_CM_RX_FLUSH;
 				list_move(&p->list, &priv->cm.rx_reap_list);
 				spin_unlock_irqrestore(&priv->lock, flags);
 				queue_work(priv->wq, &priv->cm.rx_reap_task);
@@ -912,6 +860,7 @@ static void ipoib_cm_free_rx_reap_list(struct net_device *dev)
 	spin_unlock_irq(&priv->lock);
 
 	list_for_each_entry_safe(rx, n, &list, list) {
+		ib_drain_qp(rx->qp);
 		ib_destroy_cm_id(rx->id);
 		ib_destroy_qp(rx->qp);
 		if (!ipoib_cm_has_srq(dev)) {
@@ -952,21 +901,15 @@ void ipoib_cm_dev_stop(struct net_device *dev)
 	/* Wait for all RX to be drained */
 	begin = jiffies;
 
-	while (!list_empty(&priv->cm.rx_error_list) ||
-	       !list_empty(&priv->cm.rx_flush_list) ||
-	       !list_empty(&priv->cm.rx_drain_list)) {
+	while (!list_empty(&priv->cm.rx_error_list)) {
 		if (time_after(jiffies, begin + 5 * HZ)) {
 			ipoib_warn(priv, "RX drain timing out\n");
 
 			/*
 			 * assume the HW is wedged and just free up everything.
 			 */
-			list_splice_init(&priv->cm.rx_flush_list,
-					 &priv->cm.rx_reap_list);
 			list_splice_init(&priv->cm.rx_error_list,
 					 &priv->cm.rx_reap_list);
-			list_splice_init(&priv->cm.rx_drain_list,
-					 &priv->cm.rx_reap_list);
 			break;
 		}
 		spin_unlock_irq(&priv->lock);
@@ -1589,8 +1532,6 @@ int ipoib_cm_dev_init(struct net_device *dev)
 	INIT_LIST_HEAD(&priv->cm.reap_list);
 	INIT_LIST_HEAD(&priv->cm.start_list);
 	INIT_LIST_HEAD(&priv->cm.rx_error_list);
-	INIT_LIST_HEAD(&priv->cm.rx_flush_list);
-	INIT_LIST_HEAD(&priv->cm.rx_drain_list);
 	INIT_LIST_HEAD(&priv->cm.rx_reap_list);
 	INIT_WORK(&priv->cm.start_task, ipoib_cm_tx_start);
 	INIT_WORK(&priv->cm.reap_task, ipoib_cm_tx_reap);
-- 
2.18.1


