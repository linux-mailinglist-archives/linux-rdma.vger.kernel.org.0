Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744534959DF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jan 2022 07:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378682AbiAUGXa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jan 2022 01:23:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51365 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343580AbiAUGX3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jan 2022 01:23:29 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AFh6DxKK0GVwcOpaxFE+RG5clxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDq0z921TMByDNOCmzUP/vcajekeYp2OoXk8RkGv5LcyYNqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkjPvRHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToySAmd9hjtdcnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gkZfMbp++ecBBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjiHiuWw6LG2UO9hgoIkNsaDFIcevGxwiCvVCP8OX5/OWePJ6MVe0?=
 =?us-ascii?q?TN2gdpBdd7caMUxeztidBmGaBQnB7u9IPrSh8/x3j+mLWIe8wnT+MIKD6Ho5FQ?=
 =?us-ascii?q?Z+NDQ3BD9K7Rmnfloo3s=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AtMY0cKnqt5R8YaQ+ljJ3NZ2qqLTpDfLG3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fxl6iV/cjzsiWE7wr5OUtQ/+xoV5PwIk80maQb3WBzB8bHYOCFgh?=
 =?us-ascii?q?rLEGgK1+KLqFeMdxEWndQ86U4PScZD4aXLfD1HZNjBkXOFOudl0N+a67qpmOub?=
 =?us-ascii?q?639sSDthY6Zm4xwRMHfiLmRGABlBGYEiFIeRou5Opz+bc3wRacihQlYfWeyrna?=
 =?us-ascii?q?yxqLvWJQ4BGwU86BSDyReh6LvBGRCe2RsEFxNjqI1SiFT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,304,1635177600"; 
   d="scan'208";a="120657819"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Jan 2022 14:23:25 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 4412F4D146E8;
        Fri, 21 Jan 2022 14:23:22 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 21 Jan 2022 14:23:22 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 21 Jan 2022 14:23:21 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 21 Jan 2022 14:23:12 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <rpearsonhpe@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH rdma-core v2] providers/rxe: Replace '%' with '&' in check_qp_queue_full()
Date:   Fri, 21 Jan 2022 14:22:22 +0800
Message-ID: <20220121062222.2914007-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4412F4D146E8.A4DA6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The expression "cons == ((qp->cur_index + 1) % q->index_mask)" doesn't
check the state of queue (full or empty) correctly.  For example:
If cons and qp->cur_index are 0 and q->index_mask is 1, the queue is actually
empty but check_qp_queue_full() reports full (ENOSPC).

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



