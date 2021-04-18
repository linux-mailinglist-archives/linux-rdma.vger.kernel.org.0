Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABD4363596
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhDRNiJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhDRNiI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:38:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9EDD61057;
        Sun, 18 Apr 2021 13:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618753060;
        bh=G+CIfJqnHSg3NUJzA2MFq2hTmt570oY7G218LSnLKXc=;
        h=From:To:Cc:Subject:Date:From;
        b=PPbdpANvHZoK5v/aml4su68ZMhNZ3kkrE8wTrSA2Kz0rv3Gxt1mG/wkCaWJiH0nDe
         pGdtIJK9w+bmQC9VJvx+KfUKW7OCJkrpkoElc3M6uTen228S5BduYHmgsnVMFake45
         AieSf9XO/dQ9QnWJeLCfb/DnqQfiiQa6WMgT5EP+uaKpadi3QM9kMru0hSei84M9W3
         WT0+PZqaKqf/6sXXzDFnkLspk1Y/8kvacMzgL3w15iYVXRYsFGvQTgGAonzpkt029x
         jW1jHirkU0r4nG/nGzFRs071TKBfDhVBwFyb4fPSJCB2dlU/94jxnCfvPtsG6clS0o
         R1XEFBSGH3dJQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all users are gone
Date:   Sun, 18 Apr 2021 16:37:35 +0300
Message-Id: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

Currently, in case of QP, the following use-after-free is possible:

	cpu0				cpu1
	----				----
 res_get_common_dumpit()
 rdma_restrack_get()
 fill_res_qp_entry()
				ib_destroy_qp_user()
				 rdma_restrack_del()
				 qp->device->ops.destroy_qp()
  ib_query_qp()
  qp->device->ops.query_qp()
    --> use-after-free-qp

This is because rdma_restrack_del(), in case of QP, isn't waiting until
all users are gone.

Fix it by making rdma_restrack_del() wait until all users are gone for
QPs as well.

Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/restrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index ffabaf327242..def0c5b0efe9 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -340,7 +340,7 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 	rt = &dev->res[res->type];
 
 	old = xa_erase(&rt->xa, res->id);
-	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
+	if (res->type == RDMA_RESTRACK_MR)
 		return;
 	WARN_ON(old != res);
 
-- 
2.30.2

