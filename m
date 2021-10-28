Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9521B43DAEB
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 07:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhJ1F54 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 01:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhJ1F5y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 01:57:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BB576023B;
        Thu, 28 Oct 2021 05:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635400528;
        bh=o/fe+bwdNbfTfLjcJgqgq6U1MhRkgp3LqafkeQMkpkk=;
        h=From:To:Cc:Subject:Date:From;
        b=oZxWZh8qDrBu8XtVIwGAgukRRjOYUuJRGORhRaMcoB3KtJJDHdJbm5W8DVQ2WVkWF
         9eZ+tOWOMlRTm1nKNZ6zp1oYG/H4Dj6uVb2WAveLiMM/lOliv+LFRTub/wG0mes3KR
         yHCMbfX9VuAnZAg32FNdEOWbqix31Irgfl8IVh2bb7EMu8AwJ6R8ZyB6ZarjTmelI7
         xe9Rm8oxn1kGBLmm35sfp2G8qp9uS1gOJiogtkzBDGOtgfucT9hKZKRj1b+ZBjtOmS
         M/WP4BzMGtNROwWGp2bpPsEFsI0A0LwdfDof7egdJMBAZuDbRetPFcpbiicE5kjJ5l
         B7XqIEBq4UfWg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/core: Rely on vendors to set right IOVA
Date:   Thu, 28 Oct 2021 08:55:22 +0300
Message-Id: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

The vendors set the IOVA of newly created MRs in rereg_user_mr, so don't
overwrite it. That ensures that this field is set only if IB_MR_REREG_TRANS
flag is provided.

Fixes: 6e0954b11c05 ("RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 740e6b2efe0e..d1345d76d9b1 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -837,11 +837,8 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 		new_mr->device = new_pd->device;
 		new_mr->pd = new_pd;
 		new_mr->type = IB_MR_TYPE_USER;
-		new_mr->dm = NULL;
-		new_mr->sig_attrs = NULL;
 		new_mr->uobject = uobj;
 		atomic_inc(&new_pd->usecnt);
-		new_mr->iova = cmd.hca_va;
 		new_uobj->object = new_mr;
 
 		rdma_restrack_new(&new_mr->res, RDMA_RESTRACK_MR);
-- 
2.31.1

