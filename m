Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969E66DB0F0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Apr 2023 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDGQwi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Apr 2023 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDGQwh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Apr 2023 12:52:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2122.outbound.protection.outlook.com [40.107.92.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46EA55AE
        for <linux-rdma@vger.kernel.org>; Fri,  7 Apr 2023 09:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdYYKHhMaBbie40XVPKAQpk2uj9RSzwL2heVQJ+W32dMzGO2HOCjHP28rinHcsodXTqTGaZi1ycHnKuDOPGHK+4UgPN+od2nPC9Udb6Dlk+ezbMg2I52iJxE+TSgVcI9XfIJNMRJxUWR8k7jcXwtDEed9Zz+W9Uyq9UwhO2nG47g7nWYZaHwucdPp+E7q29cGRLdpAXaQKZn+Nx4pNxDzm3XnDeArKyMrPeL//UPgUT27Lx1IPiVZkxWvXFHR4bPgSnSlnZJGJ6dsnV7RiHiTKCArB6ZoUwmy8J10aIWsJHtjqY7OxjpYbz1tK950acF55Jx6PV//oFqP+htkd+w+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsBsdWTFxMefyUEAQ/z1I0EvRZ9vHD7gfa015W9deSM=;
 b=hnbgSPmtHMd1P8W9kVX2j+nZ6BauiaWeAadOayXBDJ7zEl3gFs3N53ggJYGD8sYD6tY90uoUKJqb9scwt5GwTgA2jcC2hJ42TsIhaZP8lCpROGJhj3EQ4GhFxxqk7Kpj06siwYlmcmuQncNFoowMKJnkqgccIM0fs+uMydaMERepzyYCbqQEq18n5zfIMdu75pnSYEa07mtvON4iLb1qmHf55WmAC16HiSJVE3abSS8lPBJRiRaEBULHO7TXMAIRAlyJKqFG2q6H1pGcFTvocbowCaqGTkWtbtp6oyjeR3+bB20ivXeooEBX9+cgryAaYCfNIiXPNZ5j+UIeoCBQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsBsdWTFxMefyUEAQ/z1I0EvRZ9vHD7gfa015W9deSM=;
 b=e0nEjd1gS5s5exu4rgyr1AjgcBmP+/JC+V/Hne7mv4lGGWdWBw82sZ7O/hW1t+TqG7+Sz+T25Xo7FZBpyBHGqWIfPqR/FaNlAfKL1UgmkN227HA6/S7Q6svUkiHnhMWKHppnh731qEltxML0Y8+eqQiLfQW0Ng3rU1YXqatm2deD9m/A0kZjq9l5qfHGt/iiUU0CZWieLZaWiGO4JSq7nmXhG3n00NOhfsDHPY0v/wY9E4MxV2NaZZOSSzf570/bqDpoT7mFdW6VV9ln+KANq/e+f6d6S2iS6kZPNyJM3q/3zIrKEgbbsZVlub0+UK6wzHvHzHVBa5cfQ9q4fKF1IA==
Received: from DM6PR07CA0060.namprd07.prod.outlook.com (2603:10b6:5:74::37) by
 BN6PR0101MB2915.prod.exchangelabs.com (2603:10b6:405:2e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.26; Fri, 7 Apr 2023 16:52:30 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::d4) by DM6PR07CA0060.outlook.office365.com
 (2603:10b6:5:74::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Fri, 7 Apr 2023 16:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.31 via Frontend Transport; Fri, 7 Apr 2023 16:52:29 +0000
Received: from 252.162.96.66.static.eigbox.net (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 337GqTkT3027374;
        Fri, 7 Apr 2023 12:52:29 -0400
Subject: [PATCH for-next 1/5] IB/hfi1: Remove trace newlines
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 07 Apr 2023 12:52:29 -0400
Message-ID: <168088634897.3027109.10401662436950683555.stgit@252.162.96.66.static.eigbox.net>
In-Reply-To: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
References: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|BN6PR0101MB2915:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d9ab24-6b93-4437-be8c-08db378879b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9RmYMz8pETCNWmi5NN4rNRGV37swefUmIPsOqcYptoGr5BXvqhpV2qGmjI3wO17bBS2DLyDpXBZ18QupR5HJfXB2wmVYlstZoskT+kE+bwPo/1JWjZGDGtetrKcqdOs+eyFD/EWasahBCXrNz2YjLkJaCztA1sUjuroDoGqDbLQPbBTN1/gHKA/gmNCB/VGBh8kBwwLSpRVWvgSKMbWilfdeW/+qBu6JkLp8qzs8FCpQ2vVlHN4IoJ3YtdXqh0S/zWSnar8wzLoFcudaiDQu4kgkA1qvAQf1jybabNBovtTT7TRteo/qy5ZOdTDnW1qLNUEXGU57NxLEHths1Mwc/ZJ+cfKOwxej3uHUhPPIptKrA/eugcZgL07PVksNPk3pWZJg3knUk41/sQ/n0pYnzMxlYmq7r3BE20RrwccxAsrhXYRaGB/5ofVptxl/cPoLi+I1DNaIjFfdq1X0eN1NpNuopAelvUOyhgpr14Er68+g3LPQPqcoyz01pXIaQTGupUvZg9xplW0KuhjDBG6a1rpEEKGGuiVApXlPCc/VeykfESaC0FxuWzHV31KWJzgMR9QTYYYLglMXiY+wgcsk/FX9fYKGnuv2hxSGpJVttAe60rqlZh+zrqVnM+VPpR3YeHD2RfH/XTHM9QIHWEHR1uCO2MXTlaClRLzbZZNdjDd+ydcwtdqL+tJxppPT/ZCPVD3wDsLs/6GywYO19lc6kKGX6vkTbp9P6SFivxSFsFkXpRRAfBdhzCxwyaszPXrntmITfheZX6gydFcHGO8eA==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39840400004)(451199021)(36840700001)(46966006)(7126003)(47076005)(83380400001)(7696005)(426003)(26005)(9686003)(8936002)(186003)(70586007)(336012)(70206006)(44832011)(8676002)(36860700001)(4326008)(55016003)(5660300002)(478600001)(316002)(2906002)(41300700001)(103116003)(40480700001)(356005)(86362001)(82310400005)(81166007)(9916002)(24686002)(36900700001)(102196002);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 16:52:29.8735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d9ab24-6b93-4437-be8c-08db378879b1
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR0101MB2915
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dean Luick <dean.luick@cornelisnetworks.com>

The hfi1_cdbg trace mechanism appends a newline.  Remove trailing
newlines from all format strings.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/chip.c     |   18 +++++++++---------
 drivers/infiniband/hw/hfi1/driver.c   |    2 +-
 drivers/infiniband/hw/hfi1/file_ops.c |    2 +-
 drivers/infiniband/hw/hfi1/init.c     |   12 ++++++------
 drivers/infiniband/hw/hfi1/pio.c      |    2 +-
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 90b672feed83..9dbb89e9f4af 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -12135,7 +12135,7 @@ void hfi1_rcvctrl(struct hfi1_devdata *dd, unsigned int op,
 		set_intr_bits(dd, IS_RCVURGENT_START + rcd->ctxt,
 			      IS_RCVURGENT_START + rcd->ctxt, false);
 
-	hfi1_cdbg(RCVCTRL, "ctxt %d rcvctrl 0x%llx\n", ctxt, rcvctrl);
+	hfi1_cdbg(RCVCTRL, "ctxt %d rcvctrl 0x%llx", ctxt, rcvctrl);
 	write_kctxt_csr(dd, ctxt, RCV_CTXT_CTRL, rcvctrl);
 
 	/* work around sticky RcvCtxtStatus.BlockedRHQFull */
@@ -12205,10 +12205,10 @@ u32 hfi1_read_cntrs(struct hfi1_devdata *dd, char **namep, u64 **cntrp)
 			hfi1_cdbg(CNTR, "reading %s", entry->name);
 			if (entry->flags & CNTR_DISABLED) {
 				/* Nothing */
-				hfi1_cdbg(CNTR, "\tDisabled\n");
+				hfi1_cdbg(CNTR, "\tDisabled");
 			} else {
 				if (entry->flags & CNTR_VL) {
-					hfi1_cdbg(CNTR, "\tPer VL\n");
+					hfi1_cdbg(CNTR, "\tPer VL");
 					for (j = 0; j < C_VL_COUNT; j++) {
 						val = entry->rw_cntr(entry,
 								  dd, j,
@@ -12216,21 +12216,21 @@ u32 hfi1_read_cntrs(struct hfi1_devdata *dd, char **namep, u64 **cntrp)
 								  0);
 						hfi1_cdbg(
 						   CNTR,
-						   "\t\tRead 0x%llx for %d\n",
+						   "\t\tRead 0x%llx for %d",
 						   val, j);
 						dd->cntrs[entry->offset + j] =
 									    val;
 					}
 				} else if (entry->flags & CNTR_SDMA) {
 					hfi1_cdbg(CNTR,
-						  "\t Per SDMA Engine\n");
+						  "\t Per SDMA Engine");
 					for (j = 0; j < chip_sdma_engines(dd);
 					     j++) {
 						val =
 						entry->rw_cntr(entry, dd, j,
 							       CNTR_MODE_R, 0);
 						hfi1_cdbg(CNTR,
-							  "\t\tRead 0x%llx for %d\n",
+							  "\t\tRead 0x%llx for %d",
 							  val, j);
 						dd->cntrs[entry->offset + j] =
 									val;
@@ -12271,7 +12271,7 @@ u32 hfi1_read_portcntrs(struct hfi1_pportdata *ppd, char **namep, u64 **cntrp)
 			hfi1_cdbg(CNTR, "reading %s", entry->name);
 			if (entry->flags & CNTR_DISABLED) {
 				/* Nothing */
-				hfi1_cdbg(CNTR, "\tDisabled\n");
+				hfi1_cdbg(CNTR, "\tDisabled");
 				continue;
 			}
 
@@ -12513,7 +12513,7 @@ static void do_update_synth_timer(struct work_struct *work)
 
 	hfi1_cdbg(
 	    CNTR,
-	    "[%d] curr tx=0x%llx rx=0x%llx :: last tx=0x%llx rx=0x%llx\n",
+	    "[%d] curr tx=0x%llx rx=0x%llx :: last tx=0x%llx rx=0x%llx",
 	    dd->unit, cur_tx, cur_rx, dd->last_tx, dd->last_rx);
 
 	if ((cur_tx < dd->last_tx) || (cur_rx < dd->last_rx)) {
@@ -12527,7 +12527,7 @@ static void do_update_synth_timer(struct work_struct *work)
 	} else {
 		total_flits = (cur_tx - dd->last_tx) + (cur_rx - dd->last_rx);
 		hfi1_cdbg(CNTR,
-			  "[%d] total flits 0x%llx limit 0x%llx\n", dd->unit,
+			  "[%d] total flits 0x%llx limit 0x%llx", dd->unit,
 			  total_flits, (u64)CNTR_32BIT_MAX);
 		if (total_flits >= CNTR_32BIT_MAX) {
 			hfi1_cdbg(CNTR, "[%d] 32bit limit hit, updating",
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index bcc6bc0540f0..f4492fa407e0 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1597,7 +1597,7 @@ static int hfi1_setup_bypass_packet(struct hfi1_packet *packet)
 
 	return 0;
 drop:
-	hfi1_cdbg(PKT, "%s: packet dropped\n", __func__);
+	hfi1_cdbg(PKT, "%s: packet dropped", __func__);
 	ibp->rvp.n_pkt_drops++;
 	return -EINVAL;
 }
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index b1d6ca7e9708..acbc52bdf841 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -977,7 +977,7 @@ static int allocate_ctxt(struct hfi1_filedata *fd, struct hfi1_devdata *dd,
 		ret = -ENOMEM;
 		goto ctxdata_free;
 	}
-	hfi1_cdbg(PROC, "allocated send context %u(%u)\n", uctxt->sc->sw_index,
+	hfi1_cdbg(PROC, "allocated send context %u(%u)", uctxt->sc->sw_index,
 		  uctxt->sc->hw_context);
 	ret = sc_enable(uctxt->sc);
 	if (ret)
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 62b6c5020039..6de37c5d7d27 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -342,7 +342,7 @@ int hfi1_create_ctxtdata(struct hfi1_pportdata *ppd, int numa,
 		INIT_LIST_HEAD(&rcd->flow_queue.queue_head);
 		INIT_LIST_HEAD(&rcd->rarr_queue.queue_head);
 
-		hfi1_cdbg(PROC, "setting up context %u\n", rcd->ctxt);
+		hfi1_cdbg(PROC, "setting up context %u", rcd->ctxt);
 
 		/*
 		 * Calculate the context's RcvArray entry starting point.
@@ -400,7 +400,7 @@ int hfi1_create_ctxtdata(struct hfi1_pportdata *ppd, int numa,
 			rcd->egrbufs.count = MAX_EAGER_ENTRIES;
 		}
 		hfi1_cdbg(PROC,
-			  "ctxt%u: max Eager buffer RcvArray entries: %u\n",
+			  "ctxt%u: max Eager buffer RcvArray entries: %u",
 			  rcd->ctxt, rcd->egrbufs.count);
 
 		/*
@@ -432,7 +432,7 @@ int hfi1_create_ctxtdata(struct hfi1_pportdata *ppd, int numa,
 		if (rcd->egrbufs.size < hfi1_max_mtu) {
 			rcd->egrbufs.size = __roundup_pow_of_two(hfi1_max_mtu);
 			hfi1_cdbg(PROC,
-				  "ctxt%u: eager bufs size too small. Adjusting to %u\n",
+				  "ctxt%u: eager bufs size too small. Adjusting to %u",
 				    rcd->ctxt, rcd->egrbufs.size);
 		}
 		rcd->egrbufs.rcvtid_size = HFI1_MAX_EAGER_BUFFER_SIZE;
@@ -1920,7 +1920,7 @@ int hfi1_setup_eagerbufs(struct hfi1_ctxtdata *rcd)
 	rcd->egrbufs.size = alloced_bytes;
 
 	hfi1_cdbg(PROC,
-		  "ctxt%u: Alloced %u rcv tid entries @ %uKB, total %uKB\n",
+		  "ctxt%u: Alloced %u rcv tid entries @ %uKB, total %uKB",
 		  rcd->ctxt, rcd->egrbufs.alloced,
 		  rcd->egrbufs.rcvtid_size / 1024, rcd->egrbufs.size / 1024);
 
@@ -1943,13 +1943,13 @@ int hfi1_setup_eagerbufs(struct hfi1_ctxtdata *rcd)
 		rcd->expected_count = MAX_TID_PAIR_ENTRIES * 2;
 
 	rcd->expected_base = rcd->eager_base + egrtop;
-	hfi1_cdbg(PROC, "ctxt%u: eager:%u, exp:%u, egrbase:%u, expbase:%u\n",
+	hfi1_cdbg(PROC, "ctxt%u: eager:%u, exp:%u, egrbase:%u, expbase:%u",
 		  rcd->ctxt, rcd->egrbufs.alloced, rcd->expected_count,
 		  rcd->eager_base, rcd->expected_base);
 
 	if (!hfi1_rcvbuf_validate(rcd->egrbufs.rcvtid_size, PT_EAGER, &order)) {
 		hfi1_cdbg(PROC,
-			  "ctxt%u: current Eager buffer size is invalid %u\n",
+			  "ctxt%u: current Eager buffer size is invalid %u",
 			  rcd->ctxt, rcd->egrbufs.rcvtid_size);
 		ret = -EINVAL;
 		goto bail_rcvegrbuf_phys;
diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 51ae58c02b15..62e7dc9bea7b 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -820,7 +820,7 @@ struct send_context *sc_alloc(struct hfi1_devdata *dd, int type,
 	}
 
 	hfi1_cdbg(PIO,
-		  "Send context %u(%u) %s group %u credits %u credit_ctrl 0x%llx threshold %u\n",
+		  "Send context %u(%u) %s group %u credits %u credit_ctrl 0x%llx threshold %u",
 		  sw_index,
 		  hw_context,
 		  sc_type_name(type),


