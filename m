Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF43B3B6E61
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhF2GwG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 02:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF2GwF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 02:52:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52C1561D05;
        Tue, 29 Jun 2021 06:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624949379;
        bh=geUkSje1bwQGUcGQakAxM6zh1cxYS7g/E3AbxwqPG0g=;
        h=From:To:Cc:Subject:Date:From;
        b=YF/lXZANbzZNcsA5eQJ5ZTFRzIec5NmcL5eb3oiosqexuqAyAb6CSE80Joy/Ca/bS
         ACCcEDK+SdeNkjRgE0PH9FyzrtZhsD1O0kkBlCxt7UOteVgpcJhwp1ucrX+hSZOFUx
         TiV+z8wvCjxJ9E8d66e1CeHnkoSGhXxQHka0V2Ff5VtTAAXEad/V5yXMNxsdiuJSHF
         5QlBbfwaDKvy1EADImq269QtmsD6L1qb+Au+6y2IfBKXuFh6uq68z4XdgZotC4dDlB
         ZIg3EUU5L3LaGDlkOpstI9bfEso4g2xn1GcCrDO48GyYIR2UIyAae6sQ3TI517KQf1
         DkmfPh6Me2WcQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc v3] RDMA/core: Always release restrack object
Date:   Tue, 29 Jun 2021 09:49:33 +0300
Message-Id: <073ec27acb943ca8b6961663c47c5abe78a5c8cc.1624948948.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Change location of rdma_restrack_del() to fix the bug where
task_struct was acquired but not released, causing to resource leak.

  ucma_create_id() {
    ucma_alloc_ctx();
    rdma_create_user_id() {
      rdma_restrack_new();
      rdma_restrack_set_name() {
        rdma_restrack_attach_task.part.0(); <--- task_struct was gotten
      }
    }
    ucma_destroy_private_ctx() {
      ucma_put_ctx();
      rdma_destroy_id() {
        _destroy_id()                       <--- id_priv was freed
      }
    }
  }

Fixes: 889d916b6f8a ("RDMA/core: Don't access cm_id after its destruction")
Reported-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
---
Changelog:
v3:
 * Dropped controversial hunks and updated commit message respectively
v2: https://lore.kernel.org/lkml/e2eed941f912b2068e371fd37f43b8cf5082a0e6.1623129597.git.leonro@nvidia.com
 * Added bug report analysis
v1: https://lore.kernel.org/linux-rdma/f72e27d5c82cd9beec7670141afa62786836c569.1622956637.git.leonro@nvidia.com/T/#u
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index ab148a696c0c..6d103c42bbec 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1852,6 +1852,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 {
 	cma_cancel_operation(id_priv, state);
 
+	rdma_restrack_del(&id_priv->res);
 	if (id_priv->cma_dev) {
 		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
 			if (id_priv->cm_id.ib)
@@ -1861,7 +1862,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 				iw_destroy_cm_id(id_priv->cm_id.iw);
 		}
 		cma_leave_mc_groups(id_priv);
-		rdma_restrack_del(&id_priv->res);
 		cma_release_dev(id_priv);
 	}
 
-- 
2.31.1

