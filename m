Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ECB72239D
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFEKe2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFEKeT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E86E41
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66A7062267
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA80C433EF;
        Mon,  5 Jun 2023 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961248;
        bh=QpFFFlNxWIcnRDAY9hU4W8LNXtFoBTcdlUBVKXO9wm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4OKtRsF6WHA1mS1Ajw3a6Hz3YYVOFYHGm2pjRxUL+FqbwG6MYzqooFM2mcVyGYce
         E8opNuviyY+7PxDMvw4mSqWOEFHyoVF7vCq+ovaEpvlBiEduQe24ZcAQg3m3I4s3hv
         t1ypUNUT3RQGJHY7I69Tq5psOM8hlA/fgcIzoN57Q5x3NIDLOor1nniGOk+rQOcltu
         wtiJziQn6eTfGeGku4qR6y2NQmvCXLiWFjMQ2Xpb60E7IAebOGwkLSuUZoE8w7MCUd
         tEfqKi/TA3xEKFxCVJLy2dJqQF2zPkIwjBwufUE3WBvQBzYEKeqYdGYop7FDnuq6Qh
         D1M1C128u1YYQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 08/10] RDMA/uverbs: Restrict usage of privileged QKEYs
Date:   Mon,  5 Jun 2023 13:33:24 +0300
Message-Id: <c00c809ddafaaf87d6f6cb827978670989a511b3.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

According to the IB specification rel-1.6, section 3.5.3:
"QKEYs with the most significant bit set are considered controlled
QKEYs, and a HCA does not allow a consumer to arbitrarily specify a
controlled QKEY."

Thus, block non-privileged users from setting such a QKEY.

Fixes: bc38a6abdd5a ("[PATCH] IB uverbs: core implementation")
Signed-off-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4796f6a8828c..e836c9c477f6 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1850,8 +1850,13 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		attr->path_mtu = cmd->base.path_mtu;
 	if (cmd->base.attr_mask & IB_QP_PATH_MIG_STATE)
 		attr->path_mig_state = cmd->base.path_mig_state;
-	if (cmd->base.attr_mask & IB_QP_QKEY)
+	if (cmd->base.attr_mask & IB_QP_QKEY) {
+		if (cmd->base.qkey & IB_QP_SET_QKEY && !capable(CAP_NET_RAW)) {
+			ret = -EPERM;
+			goto release_qp;
+		}
 		attr->qkey = cmd->base.qkey;
+	}
 	if (cmd->base.attr_mask & IB_QP_RQ_PSN)
 		attr->rq_psn = cmd->base.rq_psn;
 	if (cmd->base.attr_mask & IB_QP_SQ_PSN)
-- 
2.40.1

