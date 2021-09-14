Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD740A768
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 09:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbhINHcn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 03:32:43 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55634 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240691AbhINHcm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 03:32:42 -0400
IronPort-Data: =?us-ascii?q?A9a23=3Ainci0a78AIzg3VIGK4iSGQxRtADFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0GYEm2IWWW+OaPuNNjDzKN9/OY+z8EkC6pXdnNVqTAc5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9b9ANkVEmjfvRHuulVLa?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hgwdNCpdqyW?=
 =?us-ascii?q?C8nI6/NhP8AFRJfFkmSOIUfoeObfCbg7Zf7I0ruNiGEL+9VJFMnP58J+LwvWTl?=
 =?us-ascii?q?m+vkRKTRLZReG78qywbSmWqx2isEqBNfkMZlZuXx6yzzdS/E8TvjrQarFzc1Z0?=
 =?us-ascii?q?S89wMtHdcsyzeJxhSFHNUyGOkMQfAxMTs9WoQthvVGnGxUwlb5fjfFfD7Dv8TF?=
 =?us-ascii?q?M?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Alv3RRKPS/5hlc8BcT1L155DYdb4zR+YMi2TD?=
 =?us-ascii?q?iHoedfUFSKOlfp6V8MjztSWVtN4QMEtQ/+xoHJPwPE80kqQFnbX5XI3SJjUO3V?=
 =?us-ascii?q?HIEGgM1/qG/9SNIVybygcZ79YeT0EcMqyBMbEZt7eD3ODQKb9Jq7PrgcPY55as?=
 =?us-ascii?q?854ud3AQV0gJ1XYJNu/xKDwOeOApP+tfKHLKjfA32QZINE5nIviTNz0gZazutt?=
 =?us-ascii?q?fLnJXpbVovAAMm0hCHiXeN5KThGxaV8x8CW3cXqI1Sv1Ttokjc3OGOovu7whjT?=
 =?us-ascii?q?2yv66IlXosLozp9mCNaXgsYYBz3wgkKDZZhnWZeFoDcpydvfp2oCoZ3pmVMNLs?=
 =?us-ascii?q?5z43TeciWcpgbs4RDp1HIU53rr2Taj8DDeiP28YAh/J9tKhIpffBecwVEnpstA?=
 =?us-ascii?q?3KVC2H/cn4ZLDDvb9R6NpOTgZlVPrA6ZsHAimekcgzh0So0FcoJcqoQZ4Qd8DI?=
 =?us-ascii?q?oAJiTn84oqedMeTP003MwmNG9yUkqp+lWGmLeXLzMO91a9Mwk/U/WuonprdCsT?=
 =?us-ascii?q?9Tpf+CQd9k1wvK7VBaM0vtgtn8xT5cZzp/QtHNdA7dE6MIKK41z2MGDx2V2pUC?=
 =?us-ascii?q?Da/YE8SjjwQs3MkfgIDN/DQu1/8HJ1ouWYbG9l?=
X-IronPort-AV: E=Sophos;i="5.85,292,1624291200"; 
   d="scan'208";a="114456743"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Sep 2021 15:31:24 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5B4114D0D9DF;
        Tue, 14 Sep 2021 15:31:21 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Sep 2021 15:31:15 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Sep 2021 15:31:14 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 1/3] RDMA/rxe: Add new RXE_READ_OR_WRITE_MASK
Date:   Tue, 14 Sep 2021 16:02:51 +0800
Message-ID: <20210914080253.1145353-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914080253.1145353-1-yangx.jy@fujitsu.com>
References: <20210914080253.1145353-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5B4114D0D9DF.A848F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1) Replace (RXE_READ_MASK | RXE_WRITE_MASK) with RXE_READ_OR_WRITE_MASK.
2) Change (RXE_READ_MASK | RXE_WRITE_OR_SEND) to RXE_READ_OR_WRITE_MASK
   because we don't need to check RETH for RXE_SEND_MASK.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.h | 1 +
 drivers/infiniband/sw/rxe/rxe_resp.c   | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index e02f039b8c44..bbeccb1dcec7 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -84,6 +84,7 @@ enum rxe_hdr_mask {
 
 	RXE_READ_OR_ATOMIC	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
 	RXE_WRITE_OR_SEND	= (RXE_WRITE_MASK | RXE_SEND_MASK),
+	RXE_READ_OR_WRITE_MASK	= (RXE_READ_MASK | RXE_WRITE_MASK),
 };
 
 #define OPCODE_NONE		(-1)
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5501227ddc65..74fb06df4c6c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -429,7 +429,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	enum resp_states state;
 	int access;
 
-	if (pkt->mask & (RXE_READ_MASK | RXE_WRITE_MASK)) {
+	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
 		if (pkt->mask & RXE_RETH_MASK) {
 			qp->resp.va = reth_va(pkt);
 			qp->resp.offset = 0;
@@ -450,7 +450,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	}
 
 	/* A zero-byte op is not required to set an addr or rkey. */
-	if ((pkt->mask & (RXE_READ_MASK | RXE_WRITE_OR_SEND)) &&
+	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
 	    (pkt->mask & RXE_RETH_MASK) &&
 	    reth_len(pkt) == 0) {
 		return RESPST_EXECUTE;
-- 
2.23.0



