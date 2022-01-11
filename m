Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFDD48A593
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 03:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbiAKCZB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 21:25:01 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55365 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244236AbiAKCZB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jan 2022 21:25:01 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AN1r/86L5keD24t8QFE+RFZclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC6gjJzgzZWm2MfDWyEOfuJMGL1L911atzgphsHuZTXnYNqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkjPjQHuGU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToySAmd9hjtdcnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gkZfcfouKdfBBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjiHiuWw6LG2UO9hgoIkNsaDFIcevGxwiCvVCP8OX5/OWePJ6MVe0?=
 =?us-ascii?q?TN2gdpBdcsyzeJxhSFHNUyGOkMQfAxMTs9WoQthvVGnGxUwlb5fjfNfD7Dv8TF?=
 =?us-ascii?q?M?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3As9h7zKG6Uu+qeMX/pLqExseALOsnbusQ8zAX?=
 =?us-ascii?q?PhhKOHtomszxra+TdYcgpHnJYVcqKQsdcL+7Scq9qB/nmKKdpLNhWYtKPzOWxV?=
 =?us-ascii?q?dATrsSj7cKqgeIc0aVygce79YET0EUMrPN5C1B7foSlzPYLz9P+rW6GeuT9J7j?=
 =?us-ascii?q?Jj9WPHlXgo9bnnxENjo=3D?=
X-IronPort-AV: E=Sophos;i="5.88,278,1635177600"; 
   d="scan'208";a="120212525"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jan 2022 10:24:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5FB274D15A56;
        Tue, 11 Jan 2022 10:24:57 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 11 Jan 2022 10:24:56 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 11 Jan 2022 10:24:55 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <rpearsonhpe@gmail.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in check_qp_queue_full()
Date:   Tue, 11 Jan 2022 10:24:04 +0800
Message-ID: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5FB274D15A56.A7DAF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The expression "cons == ((qp->cur_index + 1) % q->index_mask)" mistakenly
assumes the queue is full when the number of entires is equal to "maximum - 1"
(maximum is correct).

For example:
If cons and qp->cur_index are 0 and q->index_mask is 1, check_qp_queue_full()
reports ENOSPC.

Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 providers/rxe/rxe_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h
index 6de8140c..708e76ac 100644
--- a/providers/rxe/rxe_queue.h
+++ b/providers/rxe/rxe_queue.h
@@ -205,7 +205,7 @@ static inline int check_qp_queue_full(struct rxe_qp *qp)
 	if (qp->err)
 		goto err;
 
-	if (cons == ((qp->cur_index + 1) % q->index_mask))
+	if (cons == ((qp->cur_index + 1) & q->index_mask))
 		qp->err = ENOSPC;
 err:
 	return qp->err;
-- 
2.25.1



