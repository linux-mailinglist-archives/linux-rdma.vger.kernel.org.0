Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B88481AF0
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 09:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhL3I5R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 03:57:17 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16059 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229567AbhL3I5O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 03:57:14 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AGNB4laggxJz2r97AmfCpfkzIX161sxIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUDnGRMUD+FPKuJN2T9Kop0OoTn9R5VupaAnd9iTlM+pXw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOOlUrW?=
 =?us-ascii?q?cYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14MREs5OgD?=
 =?us-ascii?q?wU4FqPRmuUBSAQeGCZ7VUFD0OaecCfj7ZHDniUqdFOpmZ2CFnoeJ5UV8/xsBmd?=
 =?us-ascii?q?O7fEwJzUEbxTFjOWzqJqqQ+9um8JlPsn2FIcevGxwiz3UE54OQ5/Ma6PU5NNZ1?=
 =?us-ascii?q?XE7gcUmNfLfYdcJLCBjaR3ofRJCIBEUBYg4kePugWPwGwC0Anr9SbEfujCVlVI?=
 =?us-ascii?q?uluO2doe9RzBDfu0N9m7wm44M1z2R7skmCeGi?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AATQ5UKoEiqzK06VZA8+X1twaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,247,1635177600"; 
   d="scan'208";a="119744589"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Dec 2021 16:57:12 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 78F784D146FB;
        Thu, 30 Dec 2021 16:57:06 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Dec 2021 16:57:07 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 30 Dec 2021 16:57:04 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Remove duplicate WR_ATOMIC_OR_READ_MASK
Date:   Thu, 30 Dec 2021 16:56:10 +0800
Message-ID: <20211230085610.1915014-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 78F784D146FB.A9591
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c   | 4 ++--
 drivers/infiniband/sw/rxe/rxe_opcode.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d771ba8449a1..4afd572b84bd 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -180,7 +180,7 @@ static inline enum comp_state check_psn(struct rxe_qp *qp,
 	diff = psn_compare(pkt->psn, wqe->last_psn);
 	if (diff > 0) {
 		if (wqe->state == wqe_state_pending) {
-			if (wqe->mask & WR_ATOMIC_OR_READ_MASK)
+			if (wqe->mask & WR_READ_OR_WRITE_MASK)
 				return COMPST_ERROR_RETRY;
 
 			reset_retry_counters(qp);
@@ -200,7 +200,7 @@ static inline enum comp_state check_psn(struct rxe_qp *qp,
 			return COMPST_COMP_ACK;
 		else
 			return COMPST_DONE;
-	} else if ((diff > 0) && (wqe->mask & WR_ATOMIC_OR_READ_MASK)) {
+	} else if ((diff > 0) && (wqe->mask & WR_READ_OR_WRITE_MASK)) {
 		return COMPST_DONE;
 	} else {
 		return COMPST_CHECK_ACK;
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 8f9aaaf260f2..06f3cbb0c49f 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -23,7 +23,6 @@ enum rxe_wr_mask {
 
 	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
 	WR_WRITE_OR_SEND_MASK		= WR_WRITE_MASK | WR_SEND_MASK,
-	WR_ATOMIC_OR_READ_MASK		= WR_ATOMIC_MASK | WR_READ_MASK,
 };
 
 #define WR_MAX_QPT		(8)
-- 
2.25.1



