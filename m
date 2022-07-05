Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490CE56718E
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiGEOwX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiGEOwX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 10:52:23 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 486F013E29
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 07:52:22 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Agsiu1a5hzzpnuGZSAeU94wxRtNjFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1DMPmGRMC2COOviMYzHyLdAgPIq/ox8EuceEm4c3Hgc5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hgwdNCpdqyW?=
 =?us-ascii?q?C8nI6/NhP8AFRJfFkmSOIUfouCdcSLl65z7I0ruNiGEL+9VJFsuMIQC4eFxAXl?=
 =?us-ascii?q?D3fMdITEJKBuEgoqe0qO5WPhu3Jx7dOHkOYoevjdryjSxJfIrRpbrQKjQ49Jcm?=
 =?us-ascii?q?jAqiahmGffYetpcczZqZTzebBBVfFQaEpQzmKGvnHaXWz9Xp3qHpKcv7i7YxWR?=
 =?us-ascii?q?MPBLFWDbOUoXSA5wLwQDD/SSbl1kVyyoybLS3oQdpOFr27gMXoR7GZQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A8KZURquQ3YX0nc2xg+9oV3gz7skDktV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxra6TdZMgpHnJYVcqKQgdcL+7WJVoLUmxyXcx2/h1AV7AZniAhI?=
 =?us-ascii?q?LLFvAA0WKK+VSJcEeSygce79YFT0EUMrzN5DZB4voSmDPIcerI3uP3jZyAtKPP?=
 =?us-ascii?q?yWt3VwF2Z+VF5wd9MAySFUp7X2B9dOEEPavZ9sxavCChZHhSSsy6A0MOV+/Fq8?=
 =?us-ascii?q?aOu4nhZXc9dmQawTjLnTW186T7DhTd+h8fVglEybAk/XOAsyGR3NTaj82G?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="127282228"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Jul 2022 22:52:21 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 52BFE4D17179;
        Tue,  5 Jul 2022 22:52:20 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 5 Jul 2022 22:52:18 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 5 Jul 2022 22:52:21 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <jgg@ziepe.ca>, <rpearsonhpe@gmail.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2 2/2] RDMA/rxe: Rename rxe_atomic_reply to atomic_reply
Date:   Tue, 5 Jul 2022 22:52:12 +0800
Message-ID: <20220705145212.12014-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705145212.12014-1-yangx.jy@fujitsu.com>
References: <20220705145212.12014-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 52BFE4D17179.A72C9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's better to use the unified naming format.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5536582b8fe4..265e46fe050f 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -595,7 +595,7 @@ static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
 /* Guarantee atomicity of atomic operations at the machine level. */
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
-static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
+static enum resp_states atomic_reply(struct rxe_qp *qp,
 					 struct rxe_pkt_info *pkt)
 {
 	u64 *vaddr;
@@ -1333,7 +1333,7 @@ int rxe_responder(void *arg)
 			state = read_reply(qp, pkt);
 			break;
 		case RESPST_ATOMIC_REPLY:
-			state = rxe_atomic_reply(qp, pkt);
+			state = atomic_reply(qp, pkt);
 			break;
 		case RESPST_ACKNOWLEDGE:
 			state = acknowledge(qp, pkt);
-- 
2.34.1



