Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EAA34D1E8
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhC2NzJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:09 -0400
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:33857
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231931AbhC2NzC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wyc+7Iqkel32ym8lwcy1hnzXBHqmeVRzIlzP3PwfRkGddofCuMLZbUGLFzALkxg30IHw+3xPung2BGlvh0+szLMsEbr2RJTXxn2ihJQ3Skdhmukn99DmebeQPXNe8jqwjBxSJVit7uhlmgkpDhYXlzDLQVowq+CCjVr5UQmSYigCHR0N65CVvoXaS5od7NTQ03ICmxl4uVxzURSP2mFckofmrt8a1625vs0AdxRQOjY3l9Y2vkGofT4Zn3ui0V3G8ynDBGck7ZN/ZxHZv7UpWIEEzZPSXYx/w9g2Ws2fCoZrcX7JNtKXk5M6RIrEy9cspKnubOtP6QTnnMS43VmiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih2PmAJ31qovLuWj1GB6hswfaKDNccGVMnm2wfzEzX8=;
 b=IGfkl1BTak3MCdye44m7mK0ksnf405ZqL7Jqw7kPwGGiwWgADZW3XRFFFu9jBYKMiFUfs5PufbJO3k63BkIIYxSLhZ6BT1gV552LQpFgD7FQ94UEZNpZ0OopW0cm/6sITkUfc8iATDbm6ApnFGThFCcyYA4vXr0vsThB3uYaClGNSgxGX8mCFEuSKQZk1MTPcj8rZDRpkG+kugu6VKZNdp1b9ac0/zGK+vWspJIC0HA6CNTnfAEfsFNIFm/mojkf8I4dPq6S376e9lEQXk9fOe0ZERoKaR78IhbsGojhilKTnA1Z/PRn44tPskYZU8qLk5Z+/LynHsCj8jrxwRt7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih2PmAJ31qovLuWj1GB6hswfaKDNccGVMnm2wfzEzX8=;
 b=THT6iHyiVY3ozZE99JC5XopDsCwZHQEkf+vkhVLhoGKl8LnkiM19VTg1Yj/cwzfT053wElIVbkgNkZ8Zr4+YnzpHJT9D7vlgR0j9qq7xL2wUDmp1A/DQBoeeC8Mpa3tA3pb6bPnpI4Wn4HkU9ICG5t5SUMD1EgYytrE8UA4YpBisidoZrBlp5Sn8SA92xiQWRGEx5g3BOg+/vxV4LfhEvmJvZeypVtajQWffJK+6MxFxzafBA4ma/eqxLce7v+a2/hRaVxOUYaofBl2doIfQfZ8L66KKkt2KpShNgX5+OJPJwyFf/uyoZc6hjzW3dCsAS6f+QKyYGCrPe5tYCi7Wqw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6618.prod.exchangelabs.com (2603:10b6:510:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Mon, 29 Mar 2021 13:55:00 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:55:00 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 01/10] IB/hfi1: Add AIP tx traces
Date:   Mon, 29 Mar 2021 09:54:07 -0400
Message-Id: <1617026056-50483-2-git-send-email-dennis.dalessandro@cornelisnetworks.com>
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
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:54:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdae2178-36ad-4f3e-9d25-08d8f2ba3ec7
X-MS-TrafficTypeDiagnostic: PH0PR01MB6618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6618F993DECA11D45B53FF23F47E9@PH0PR01MB6618.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:217;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gFkg72XRoWt2X2x44cZ57Y5qH5HYCQmBGtVA/TeD7Se3eq//lGDy+MOqdi91+3WLz/d78rpailAYAHgz4yebhSi6V9hu29Y/WjYz2RpYvEcRAkgh3PQ6hV9tHNJpUw7jloRcdae3SdaZazq9py6aFmacjb5Ax+TctBQh4uvEXPtAcsrXbis+oAw0RuXngWKEwFf81hpIV7Yqr7gKpBkj63gOwsmaPkXSJKzpeKuc2uZJz3CwCjkIBkQVOEN4Gl2ycHo9gpP+/ML4sMaMRZ9uYYaodCr4C/P0ssEjRp6x2HBs4JaRGFcxpRN1C6r8nXD0XWBFlAnBZAaLy4yzhD9N+MPuMxb8eG4tJTDkdfjDt5+KIOgOw2qqpNtTu/fuPE23uavg9cv5xsVrbOLwG0TyHi9VhrUzTgeYLtGaYW/h2Dfn1EdIQl/cVVU3/Usbbra7A8nrta234x/TiqVh9stj+JmTlWJ5ooVEgyTz9khxk1X0dbCPrYwb5fn5rWegJHDjURJKtnrWzVJDfHxQrrOqvcLpJYuEEkE5F+8Qjq0RKLM83spCDFCvB+Bkuu6p+IfrZ/Y8gFzHxKEQyljQO76eRF9FsfVbHV24IUG7HwR4qJrkglCJGSa1h5QjNdiprJgx2grifXTx+UCwtDsqJjmZSB9Z/aJW6eovUVS6CpfuWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(366004)(346002)(376002)(396003)(86362001)(5660300002)(52116002)(186003)(4326008)(7696005)(2906002)(36756003)(66556008)(8936002)(956004)(66476007)(107886003)(2616005)(478600001)(54906003)(83380400001)(66946007)(6486002)(38100700001)(8676002)(26005)(316002)(9686003)(6666004)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N3BRq2q0kSA8SjYFi7VJfG1aEeU8jgM3NbIKrAcPcc5wUMwxx5vH/vIgINZi?=
 =?us-ascii?Q?kD7g8FGH5m6UAL6lOhXzIlsV+jIlbf4ftbYeeN0ouZekMnykdsKbyqGlAfnV?=
 =?us-ascii?Q?4TApzypeLLjOOCEIQrso/gtOsTx62EAiqZddgYa/IfnIIL7/n1OYtU/6BQSZ?=
 =?us-ascii?Q?kmaR77qgQZFnaquWnh2Wi0g5Byt98KWSbf9p11njEvUJDDDm8mJddmcHEmih?=
 =?us-ascii?Q?Ie8zXPLsxXBnPZbyF+sdC954woORkmqyNj/ZWe3qiYK/0WcUck31jFkqgCxY?=
 =?us-ascii?Q?C3HS52uQS1d3Peeoyw3JProJKk0UwH4xDN0/pAvphL/8Tc/n6pn15QpTajNV?=
 =?us-ascii?Q?O6gNtKbVhvJ+At07fJt47zXErAC/xu4/4x34hFR3k+RJImbyuKOsMcon7Nf6?=
 =?us-ascii?Q?PBzrb62Rg2LUl5aU4dKgVaOLLc4pDPXFDGvNT4PtvfqAdlr24epW/KTdmKhj?=
 =?us-ascii?Q?2aKv4ttxZy2mFwbEPHuN+orFImtjXhavorRNORTCVLi05ejhIJ36Op8Rns6w?=
 =?us-ascii?Q?T74hEXa4NkxplmOf9RBvlJCA0CUtGAx3gD+EfDApo5vW8omm7QVgYSkCss8V?=
 =?us-ascii?Q?6TNVwQqHFJmqPWt35HabH2Flx4AaRtMHPQNdrDy3zvHbrlKNUc1vNdDNyllj?=
 =?us-ascii?Q?RFUSCoimagN3Mf7R+Qiq98d2fBwCRfYT/BnplH8DDSaaIiIymkIkxHjGQz8U?=
 =?us-ascii?Q?78EIyIDs3haAR1si8/p7H4OWNcYTT1LZmcNHHBWZjDeDBHyfTQZHjtX69L0f?=
 =?us-ascii?Q?5w7E78av/G0/i5TZhoz2owxIfQ1Vn8lHcBX+TYgyDRMyIT5i/HeCymeAVXP4?=
 =?us-ascii?Q?i/DvpPH23d47fBlDYt9zUOps68A91OwMgfgxaalP2m5HmQvGK683NeGdqJpi?=
 =?us-ascii?Q?AF+FwUyFcK5eFmk2acDQRkZaW/PXDZGUnrBCNyyqu/1evVdbzitvFjBuTofP?=
 =?us-ascii?Q?vpJZFd4/TLQoMmxkROZOxe+H284NVQOkv9ls+zrVmBkf/PGkswZTNMggdPz4?=
 =?us-ascii?Q?YHtRqloniRl5cJJZAOr5//8JRb+30i1witDvtp0yBnXDwqvfqxxui/hpyPlX?=
 =?us-ascii?Q?QS9r9AIl/Wo1MwY/1iD3wtvDVYpCVbWteXr76tVGcdQXzLBdIGsk9gyJBlGq?=
 =?us-ascii?Q?Znne3hl3UgWNN8xdpVGNHIb/GK1nF+ulG1LZoyXHrATl6DN2+wn1qOcvLqQ4?=
 =?us-ascii?Q?6SWg5yH7Am4YtP2aEE8/ogZ0fgL3k6WhhwJ360K8rBcsrCeyqr6EfvZlJmyU?=
 =?us-ascii?Q?3qp1hVUaLYXGwZJqaU6oDTCUv5/Js8bmGf1qD2x3+FgUaxSwwouc0KvOouyO?=
 =?us-ascii?Q?9ogDPyeYHC/8vd9ozCFLPesQ?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdae2178-36ad-4f3e-9d25-08d8f2ba3ec7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:55:00.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJXZFbBSOGdvZUZ2HQxfpHV4mxNcC+WvreGwp6TxD8v5Gaiog0XIQDH3lJIph37d4iBvg1Ptb9uDti3t3j0gsf7MyvuzHRTlOaJ2466N6VBuKXMU+DzDizEinZqafwFB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6618
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

Add traces to allow for debugging issues with AIP
tx.

Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c |  18 +++++-
 drivers/infiniband/hw/hfi1/trace_tx.h | 104 ++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index edd4eea..5129dc9 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -15,6 +15,7 @@
 #include "verbs.h"
 #include "trace_ibhdrs.h"
 #include "ipoib.h"
+#include "trace_tx.h"
 
 /* Add a convenience helper */
 #define CIRC_ADD(val, add, size) (((val) + (add)) & ((size) - 1))
@@ -63,12 +64,14 @@ static u64 hfi1_ipoib_used(struct hfi1_ipoib_txq *txq)
 
 static void hfi1_ipoib_stop_txq(struct hfi1_ipoib_txq *txq)
 {
+	trace_hfi1_txq_stop(txq);
 	if (atomic_inc_return(&txq->stops) == 1)
 		netif_stop_subqueue(txq->priv->netdev, txq->q_idx);
 }
 
 static void hfi1_ipoib_wake_txq(struct hfi1_ipoib_txq *txq)
 {
+	trace_hfi1_txq_wake(txq);
 	if (atomic_dec_and_test(&txq->stops))
 		netif_wake_subqueue(txq->priv->netdev, txq->q_idx);
 }
@@ -89,8 +92,10 @@ static void hfi1_ipoib_check_queue_depth(struct hfi1_ipoib_txq *txq)
 {
 	++txq->sent_txreqs;
 	if (hfi1_ipoib_used(txq) >= hfi1_ipoib_ring_hwat(txq) &&
-	    !atomic_xchg(&txq->ring_full, 1))
+	    !atomic_xchg(&txq->ring_full, 1)) {
+		trace_hfi1_txq_full(txq);
 		hfi1_ipoib_stop_txq(txq);
+	}
 }
 
 static void hfi1_ipoib_check_queue_stopped(struct hfi1_ipoib_txq *txq)
@@ -112,8 +117,10 @@ static void hfi1_ipoib_check_queue_stopped(struct hfi1_ipoib_txq *txq)
 	 * to protect against ring overflow.
 	 */
 	if (hfi1_ipoib_used(txq) < hfi1_ipoib_ring_lwat(txq) &&
-	    atomic_xchg(&txq->ring_full, 0))
+	    atomic_xchg(&txq->ring_full, 0)) {
+		trace_hfi1_txq_xmit_unstopped(txq);
 		hfi1_ipoib_wake_txq(txq);
+	}
 }
 
 static void hfi1_ipoib_free_tx(struct ipoib_txreq *tx, int budget)
@@ -405,6 +412,7 @@ static struct ipoib_txreq *hfi1_ipoib_send_dma_common(struct net_device *dev,
 				sdma_select_engine_sc(priv->dd,
 						      txp->flow.tx_queue,
 						      txp->flow.sc5);
+			trace_hfi1_flow_switch(txp->txq);
 		}
 
 		return tx;
@@ -525,6 +533,7 @@ static int hfi1_ipoib_send_dma_list(struct net_device *dev,
 	if (txq->flow.as_int != txp->flow.as_int) {
 		int ret;
 
+		trace_hfi1_flow_flush(txq);
 		ret = hfi1_ipoib_flush_tx_list(dev, txq);
 		if (unlikely(ret)) {
 			if (ret == -EBUSY)
@@ -635,8 +644,10 @@ static int hfi1_ipoib_sdma_sleep(struct sdma_engine *sde,
 			/* came from non-list submit */
 			list_add_tail(&txreq->list, &txq->tx_list);
 		if (list_empty(&txq->wait.list)) {
-			if (!atomic_xchg(&txq->no_desc, 1))
+			if (!atomic_xchg(&txq->no_desc, 1)) {
+				trace_hfi1_txq_queued(txq);
 				hfi1_ipoib_stop_txq(txq);
+			}
 			iowait_queue(pkts_sent, wait->iow, &sde->dmawait);
 		}
 
@@ -659,6 +670,7 @@ static void hfi1_ipoib_sdma_wakeup(struct iowait *wait, int reason)
 	struct hfi1_ipoib_txq *txq =
 		container_of(wait, struct hfi1_ipoib_txq, wait);
 
+	trace_hfi1_txq_wakeup(txq);
 	if (likely(txq->priv->netdev->reg_state == NETREG_REGISTERED))
 		iowait_schedule(wait, system_highpri_wq, WORK_CPU_UNBOUND);
 }
diff --git a/drivers/infiniband/hw/hfi1/trace_tx.h b/drivers/infiniband/hw/hfi1/trace_tx.h
index 769e5e4..8476541 100644
--- a/drivers/infiniband/hw/hfi1/trace_tx.h
+++ b/drivers/infiniband/hw/hfi1/trace_tx.h
@@ -53,6 +53,7 @@
 #include "hfi.h"
 #include "mad.h"
 #include "sdma.h"
+#include "ipoib.h"
 
 const char *parse_sdma_flags(struct trace_seq *p, u64 desc0, u64 desc1);
 
@@ -858,6 +859,109 @@
 	TP_ARGS(qp, flag)
 );
 
+DECLARE_EVENT_CLASS(/* AIP  */
+	hfi1_ipoib_txq_template,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(txq->priv->dd)
+		__field(struct hfi1_ipoib_txq *, txq)
+		__field(struct sdma_engine *, sde)
+		__field(ulong, head)
+		__field(ulong, tail)
+		__field(uint, used)
+		__field(uint, flow)
+		__field(int, stops)
+		__field(int, no_desc)
+		__field(u8, idx)
+		__field(u8, stopped)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(txq->priv->dd)
+		__entry->txq = txq;
+		__entry->sde = txq->sde;
+		__entry->head = txq->tx_ring.head;
+		__entry->tail = txq->tx_ring.tail;
+		__entry->idx = txq->q_idx;
+		__entry->used =
+			txq->sent_txreqs -
+			atomic64_read(&txq->complete_txreqs);
+		__entry->flow = txq->flow.as_int;
+		__entry->stops = atomic_read(&txq->stops);
+		__entry->no_desc = atomic_read(&txq->no_desc);
+		__entry->stopped =
+		 __netif_subqueue_stopped(txq->priv->netdev, txq->q_idx);
+	),
+	TP_printk(/* print  */
+		"[%s] txq %llx idx %u sde %llx head %lx tail %lx flow %x used %u stops %d no_desc %d stopped %u",
+		__get_str(dev),
+		(unsigned long long)__entry->txq,
+		__entry->idx,
+		(unsigned long long)__entry->sde,
+		__entry->head,
+		__entry->tail,
+		__entry->flow,
+		__entry->used,
+		__entry->stops,
+		__entry->no_desc,
+		__entry->stopped
+	)
+);
+
+DEFINE_EVENT(/* queue stop */
+	hfi1_ipoib_txq_template, hfi1_txq_stop,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* queue wake */
+	hfi1_ipoib_txq_template, hfi1_txq_wake,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* flow flush */
+	hfi1_ipoib_txq_template, hfi1_flow_flush,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* flow switch */
+	hfi1_ipoib_txq_template, hfi1_flow_switch,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* wakeup */
+	hfi1_ipoib_txq_template, hfi1_txq_wakeup,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* full */
+	hfi1_ipoib_txq_template, hfi1_txq_full,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* queued */
+	hfi1_ipoib_txq_template, hfi1_txq_queued,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* xmit_stopped */
+	hfi1_ipoib_txq_template, hfi1_txq_xmit_stopped,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* xmit_unstopped */
+	hfi1_ipoib_txq_template, hfi1_txq_xmit_unstopped,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
 #endif /* __HFI1_TRACE_TX_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
1.8.3.1

