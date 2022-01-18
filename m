Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50669492063
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 08:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbiARHfV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 02:35:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42036 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbiARHfU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jan 2022 02:35:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B1D9613C5;
        Tue, 18 Jan 2022 07:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF06C340E1;
        Tue, 18 Jan 2022 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642491318;
        bh=8pHzTYuyAsn63ZzuNcB6jStefbvJPsDwbXo7zfeaKc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FsTlmWV0eh5Crc3H/wOj7YTs/unaKz68pYVYdavUQPyFhb3QtBqRhZ9vx7QShZaWF
         3nwiPCwDyNS254/9fHk7unsJbVeslVq2LlasyQmAbAQK6A/QaoE/PYjyPIX+U+NiA0
         jKqti6bcrIGABxJeaS8H4onk1A3uk8rR9xmgk/reHTJlI13p2T5sPKVR5Atll4vtdh
         fSgVXchSU+5Dz2dEy9ae9wga+ukin/Yp67elB+77NSUvI5glKExo/PCPajnFATtLlB
         lVYsdHacqEvbhhe/0xCSSvstAncJXgyVsLxNey2H8jWUKEXFAGsd8O1Siz0Pu+dntF
         DQayCf/R4KyAg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/3] RDMA/core: Set MR type in ib_reg_user_mr
Date:   Tue, 18 Jan 2022 09:35:02 +0200
Message-Id: <be2e91bcd6e52dc36be289ae92f30d3a5cc6dcb1.1642491047.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642491047.git.leonro@nvidia.com>
References: <cover.1642491047.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Add missing assignment of MR type to IB_MR_TYPE_USER.

Fixes: 33006bd4f37f ("IB/core: Introduce ib_reg_user_mr")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index c18634bec212..e821dc94a43e 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2153,6 +2153,7 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		return mr;
 
 	mr->device = pd->device;
+	mr->type = IB_MR_TYPE_USER;
 	mr->pd = pd;
 	mr->dm = NULL;
 	atomic_inc(&pd->usecnt);
-- 
2.34.1

