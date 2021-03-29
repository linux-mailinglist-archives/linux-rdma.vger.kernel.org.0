Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E634D1EF
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhC2Nzm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:42 -0400
Received: from mail-mw2nam10on2117.outbound.protection.outlook.com ([40.107.94.117]:39169
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231506AbhC2NzK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsqeyCuWgYPbeDjEWk3cu6szKlLV5YDJExxDhaarEygdJe9an/Kk2qQhkPqqUNrq4q2sTDQuB5UfLqzPDMgzKDp5Th/ObUQNAsr1jDtwhoZd4cueuUMUjH0kwwzKDDBD+ipicNl0lgvw0umWm8LuK6iYIgo29voQMTK/IeXUWDVFF9mVuAx8G/W7sIG5SjHedUBgEKRTuc3JJcTguwvhu+bvWt/IQdutkfNp2jr1+sVkiOWegwkwXsZ7xipFuyxi/uRG9lNFzrOY/WLqJH47jwT4TkOGWzdamC7XeY1atc2b3/TIlXJ7BDah7RFzHzaujDTNqJS5b0qw4w8sP3IrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2BOkRYdoz9V1U9MKdWuTN5zyFBUcDFL+1Op7U84bwg=;
 b=DgYIoM8FaZNceKMP+O9zqSb4XuoRPwUi5FkvU7K2BAMSLCUsPe1EDl7vcBUMwwWedYPHCXfZi2Cu9mpKjVyFCLHnSRHo2tzPFrnPtbVN3zkgfwtqEN2D6Q1qtLJl3mq0KtaMIK7Hf+NK015xsR5oR0rN1HBkTXqRjEzC2vgJYI/E+4OfYeu6UzkpmS1XHr15jA4uElqTUnkeX2XxYy1Z9lz8LosMLfOmeFIthK6CJFB/gA33iPOglE1/cIn4D5E1h4edLkmvIgfe6bzCLKmKVsVzgQz4NXnrFBELMRdr3rghpVO2KH+b9n2jD564D+rb0Lzh2L20nKt6w4dwNnx53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2BOkRYdoz9V1U9MKdWuTN5zyFBUcDFL+1Op7U84bwg=;
 b=WNHSPvmwjc4w1xavylN1yLCiof1fNvp8nPUJ0/paA7RjW/zLtungGqPbJYefnyDZ6JfBTPbfFhqIjpyn9y1pL8GL3sfpSU9TZ5xyW1+uG7/Njk5Ek+ObXd+x8hxR+3kZhq7fRmPZJgRzvyYYzoNdgj75sAp/p4/huYBKb1x8LvwBwBn5FXJaXIy6m1+PB1srb81BQ/r3fSk0sB04v/JwtBAEI7jwQs8E4pcSonH1f47Kf21ECmyYxDzxWvJ3siFq4ZO4gGM2a2aXCGwEGVDXGfwC9pXFyRFTPoEy7zQVAANeumi/owrs2Dox4cteQT+4ZzeCLFgRNZzGE5SMJAtolQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6604.prod.exchangelabs.com (2603:10b6:510:79::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Mon, 29 Mar 2021 13:55:07 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:55:06 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 07/10] IB/hfi1: Add additional usdma traces
Date:   Mon, 29 Mar 2021 09:54:13 -0400
Message-Id: <1617026056-50483-8-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:55:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9773d67-c90a-4f15-0f3c-08d8f2ba4281
X-MS-TrafficTypeDiagnostic: PH0PR01MB6604:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6604639C3C2DD0CBCA1E8716F47E9@PH0PR01MB6604.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:274;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gC5D01Fhhz6g69eB+nkCemVJA26EIziursbodHmYWN0tuYPXOV+VvkqJtoQwzRyi3lC5TLjEw3LeBCdKmJksiXsJUAa9PlonD24eeVX1VO+7GNw9giryOWfOqw5Smc2iUpPEvBh9JhH8i9LhTkc/JPHO7SOLjtGiwLqJT80Id/IHeJSOTY0MOIy0HbTeg+bMJjEXW0MCs6sYT3btei5YSSan4jReVLjjme8IqzSU1UYRmGaqh5Mo4Jlkfph8+YAMA6G3TGUj/DvechRVX38jDOtUSttxutCzcpJDlA0O5n8bfH7YSN+weqAu3K9fZEFTL5OnGZvtOxyM0GvI2bo+DwQZygexXTKDRcXE21NimeIYmVZimj/UX9AVVE+KLJKY1erBoXaOkTdNMI2u/5WZGyZTcHiayiF2qCsxEWeL+TNr9VdC2MpxjhV4VlEDxsEQ9uFk+1ykHR+lJc7Mo8nUqDtKMYF5jVWfZ/iQu0XeQ2O75/LX5Ca5j2EU/SpXGPCMK4fGH6SrjuGPGAKDA2SPZiVE7r+xrgAf6Eh7nKBrgRDeGYs3Swh4r4Z0jqbPqNkIWgGN7sOrIIoyOfE9JDG/FPRE17M/LANjCBG9l8Z7P/0r3RNxS5XbDspQ7n2rI//RjKhnDol4+746TfLqLrZlBSUJBVHDbxCPoGcNYrot9s/RzNcm4j60tDHgYChyNfQwMsdJxJFUzHmFvedahGuyrMwewbA5LcBiwEPTLdon2xI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39830400003)(366004)(136003)(956004)(2616005)(186003)(66556008)(66476007)(66946007)(36756003)(26005)(83380400001)(5660300002)(316002)(16526019)(54906003)(9686003)(52116002)(7696005)(6666004)(2906002)(86362001)(4326008)(966005)(6486002)(8676002)(107886003)(38100700001)(8936002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?T0gcTIguBEoI9CyoYn1L79qYSfpeF3bD1afs/7mk0NsMAgpkaDkiSlu8dPIN?=
 =?us-ascii?Q?RUSmmH/ECxNil4FQ9CzUeGxtDDNuyWIToDQJi8Uz/4ND8sYu7L8AUnVYYhL8?=
 =?us-ascii?Q?xAOGPSBPjYUnnyp3ojYTpy6XCnB/dqvkhHOMrM+M0EVptVRYj6rlOva028yx?=
 =?us-ascii?Q?FxQRquzpLiW7gawqgcSBvp4iXGX44b9ZVAKODhoTupelowwrDCP5v7XPhvNx?=
 =?us-ascii?Q?I9kTdEJl9SslG1j/nbjf/LrANpbSJpzMGAFyBMrshArEnq9SBkUnkvrVwR4V?=
 =?us-ascii?Q?5Dh8HPeFeKKOkPwAN+XTzKZw5klwistnpGSAYywKIULI+2LO7vwMig/d1G6D?=
 =?us-ascii?Q?8EPnSCXxzMJXHN1qboYbpuKPsOPRdmOD79CpQtnp6jkamCg5zoii9OSTc6wc?=
 =?us-ascii?Q?3APqY0LnsDmr18BJscyY5gqQxK9vVnnnyA8Qw9AcozMg5gfCuXGqDInkklkO?=
 =?us-ascii?Q?tTNeIoQsPcyjsds3rmn9yvoJ9j4gn2rVUM+GgVtgDfcAt1OkAQAqYLrwOk0w?=
 =?us-ascii?Q?JBu0QjDWvB1n0tuogGkpL9TkGzGnajUtg3fQ8EAkA5bOWQlaurON6Ub2b8/1?=
 =?us-ascii?Q?945uAl3qAFparYt3tB5HMSL1X2wvf4pASciplOlAcNjTxOIxheS+8FTYu5f2?=
 =?us-ascii?Q?sO7C3hGkconqDS4mmgEBn/zmcrBPevdmafQ0Bx8G3ip5yU5/UiJXkboVf447?=
 =?us-ascii?Q?DWcJc8Nj6MTTAOgmaOSFBcaI2V4txzU5bQ/9DHyB+EBLfzbPkCPu0ufjo3A/?=
 =?us-ascii?Q?dtPGykMFfuiSVaj5CtxM2FSPW9uxXHpID5RjvdnaKIaxMKBGSQ7RPrzf2R2S?=
 =?us-ascii?Q?ZvwrBOAf8jOMeW/O/8bgrbqsFY37JK7+YGdz2arj/CIlrjFMzbUyFvuqehrh?=
 =?us-ascii?Q?byXQb3tjnhpxJm8VAwcJbGbts2mogLUnXp3bmTZIjT+V7aHpJReCkAOml2ca?=
 =?us-ascii?Q?XdiFkhDPoyRzCAl/FFDnb/HxWqGnVvLRx54KHxr1ns0ZlwnM9S/ASTshKa4t?=
 =?us-ascii?Q?xaDbyDgPBTlaVSebMPhLlhu8JoVnuHORULQtDZ0WnyjSvClU8O24s2xhlHvK?=
 =?us-ascii?Q?uw+DYWhii4ixHa2WmTWyI+cO0UvqKOkg58bTAOfC6b8hu4OzgA5ZMmKoXwgf?=
 =?us-ascii?Q?trTW2ju4zfiONbejuVM0vgsjUtRl+rfFeKzBXOxRgxWjeJPzHRt9Z0uDGXYb?=
 =?us-ascii?Q?hlQ55f4YN07/QSCrMu4MxEfsuVIYYRwA12QaWzRaHYlJGg08qAX5b149BTIf?=
 =?us-ascii?Q?xWuaDvQnV2kvjhWv76KzohrPjl7dTcgrTqlM3p9Vb8Ck5yRUkqyBzOqSyNlf?=
 =?us-ascii?Q?sJha/ViZ90RsSyY0tD+Uzu+1?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9773d67-c90a-4f15-0f3c-08d8f2ba4281
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:55:06.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43bVqqNO2jMNKxceMwXyFlJQ2VYkb/AeStk+uYC0rOUleWXjvSD3dqKyyVIkT4OgquQ9hLFdEC7SxT3PXW+oMUXDeTTQXl/g9xvzzAvMsb/jc6R/IFcBGSNaQxaqF1nJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6604
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

Add traces that were vital in isolating an issue with pq waitlist.  See
URL below.

Reviewed-by: Kaike Wan <kaike.wan@intel.com>
URL: https://lore.kernel.org/linux-rdma/20200504130917.175613.43231.stgit@awfm-01.aw.intel.com/
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/trace_tx.h  | 75 ++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/user_sdma.c | 12 ++++--
 drivers/infiniband/hw/hfi1/user_sdma.h |  1 +
 3 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/trace_tx.h b/drivers/infiniband/hw/hfi1/trace_tx.h
index 8476541..d44fc54 100644
--- a/drivers/infiniband/hw/hfi1/trace_tx.h
+++ b/drivers/infiniband/hw/hfi1/trace_tx.h
@@ -54,6 +54,7 @@
 #include "mad.h"
 #include "sdma.h"
 #include "ipoib.h"
+#include "user_sdma.h"
 
 const char *parse_sdma_flags(struct trace_seq *p, u64 desc0, u64 desc1);
 
@@ -654,6 +655,80 @@
 		      __entry->code)
 );
 
+TRACE_EVENT(hfi1_usdma_defer,
+	    TP_PROTO(struct hfi1_user_sdma_pkt_q *pq,
+		     struct sdma_engine *sde,
+		     struct iowait *wait),
+	    TP_ARGS(pq, sde, wait),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(pq->dd)
+			     __field(struct hfi1_user_sdma_pkt_q *, pq)
+			     __field(struct sdma_engine *, sde)
+			     __field(struct iowait *, wait)
+			     __field(int, engine)
+			     __field(int, empty)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(pq->dd);
+			    __entry->pq = pq;
+			    __entry->sde = sde;
+			    __entry->wait = wait;
+			    __entry->engine = sde->this_idx;
+			    __entry->empty = list_empty(&__entry->wait->list);
+			    ),
+	     TP_printk("[%s] pq %llx sde %llx wait %llx engine %d empty %d",
+		       __get_str(dev),
+		       (unsigned long long)__entry->pq,
+		       (unsigned long long)__entry->sde,
+		       (unsigned long long)__entry->wait,
+		       __entry->engine,
+		       __entry->empty
+		)
+);
+
+TRACE_EVENT(hfi1_usdma_activate,
+	    TP_PROTO(struct hfi1_user_sdma_pkt_q *pq,
+		     struct iowait *wait,
+		     int reason),
+	    TP_ARGS(pq, wait, reason),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(pq->dd)
+			     __field(struct hfi1_user_sdma_pkt_q *, pq)
+			     __field(struct iowait *, wait)
+			     __field(int, reason)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(pq->dd);
+			    __entry->pq = pq;
+			    __entry->wait = wait;
+			    __entry->reason = reason;
+			    ),
+	     TP_printk("[%s] pq %llx wait %llx reason %d",
+		       __get_str(dev),
+		       (unsigned long long)__entry->pq,
+		       (unsigned long long)__entry->wait,
+		       __entry->reason
+		)
+);
+
+TRACE_EVENT(hfi1_usdma_we,
+	    TP_PROTO(struct hfi1_user_sdma_pkt_q *pq,
+		     int we_ret),
+	    TP_ARGS(pq, we_ret),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(pq->dd)
+			     __field(struct hfi1_user_sdma_pkt_q *, pq)
+			     __field(int, state)
+			     __field(int, we_ret)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(pq->dd);
+			    __entry->pq = pq;
+			    __entry->state = pq->state;
+			    __entry->we_ret = we_ret;
+			    ),
+	     TP_printk("[%s] pq %llx state %d we_ret %d",
+		       __get_str(dev),
+		       (unsigned long long)__entry->pq,
+		       __entry->state,
+		       __entry->we_ret
+		)
+);
+
 const char *print_u32_array(struct trace_seq *, u32 *, int);
 #define __print_u32_hex(arr, len) print_u32_array(p, arr, len)
 
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 4a4956f9..da5b2e3 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -133,6 +133,7 @@ static int defer_packet_queue(
 		container_of(wait->iow, struct hfi1_user_sdma_pkt_q, busy);
 
 	write_seqlock(&sde->waitlock);
+	trace_hfi1_usdma_defer(pq, sde, &pq->busy);
 	if (sdma_progress(sde, seq, txreq))
 		goto eagain;
 	/*
@@ -157,7 +158,8 @@ static void activate_packet_queue(struct iowait *wait, int reason)
 {
 	struct hfi1_user_sdma_pkt_q *pq =
 		container_of(wait, struct hfi1_user_sdma_pkt_q, busy);
-	pq->busy.lock = NULL;
+
+	trace_hfi1_usdma_activate(pq, wait, reason);
 	xchg(&pq->state, SDMA_PKT_Q_ACTIVE);
 	wake_up(&wait->wait_dma);
 };
@@ -599,13 +601,17 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 	while (req->seqsubmitted != req->info.npkts) {
 		ret = user_sdma_send_pkts(req, pcount);
 		if (ret < 0) {
+			int we_ret;
+
 			if (ret != -EBUSY)
 				goto free_req;
-			if (wait_event_interruptible_timeout(
+			we_ret = wait_event_interruptible_timeout(
 				pq->busy.wait_dma,
 				pq->state == SDMA_PKT_Q_ACTIVE,
 				msecs_to_jiffies(
-					SDMA_IOWAIT_TIMEOUT)) <= 0)
+					SDMA_IOWAIT_TIMEOUT));
+			trace_hfi1_usdma_we(pq, we_ret);
+			if (we_ret <= 0)
 				flush_pq_iowait(pq);
 		}
 	}
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index 1e8c02f..fabe581 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -53,6 +53,7 @@
 #include "common.h"
 #include "iowait.h"
 #include "user_exp_rcv.h"
+#include "mmu_rb.h"
 
 /* The maximum number of Data io vectors per message/request */
 #define MAX_VECTORS_PER_REQ 8
-- 
1.8.3.1

