Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904735AFAB8
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 05:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiIGDlL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 23:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGDlK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 23:41:10 -0400
X-Greylist: delayed 284 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Sep 2022 20:41:09 PDT
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 033E685FBC;
        Tue,  6 Sep 2022 20:41:08 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 82BC31E80D59;
        Wed,  7 Sep 2022 11:35:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yijZSSlu9mkU; Wed,  7 Sep 2022 11:35:10 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C12A41E80D57;
        Wed,  7 Sep 2022 11:35:10 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] rdma/rdmavt_qp: Remove unnecessary 'NULL' values from qp
Date:   Wed,  7 Sep 2022 11:36:04 +0800
Message-Id: <20220907033604.4637-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pointer qp is assigned before it is used, it does not need to be
initialized and assigned.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 include/rdma/rdmavt_qp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 2e58d5e6ac0e..2afc3300d618 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -699,7 +699,7 @@ static inline struct rvt_qp *rvt_lookup_qpn(struct rvt_dev_info *rdi,
 					    struct rvt_ibport *rvp,
 					    u32 qpn) __must_hold(RCU)
 {
-	struct rvt_qp *qp = NULL;
+	struct rvt_qp *qp;
 
 	if (unlikely(qpn <= 1)) {
 		qp = rcu_dereference(rvp->qp[qpn]);
-- 
2.18.2

