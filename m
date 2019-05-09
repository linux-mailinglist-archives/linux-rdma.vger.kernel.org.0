Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA7E18820
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2019 12:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfEIKEG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 May 2019 06:04:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:43382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbfEIKEG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 May 2019 06:04:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 031C9AB87;
        Thu,  9 May 2019 10:04:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH] infiniband/core: zero out bind_list pointer in cma_release_port()
Date:   Thu,  9 May 2019 12:03:58 +0200
Message-Id: <20190509100358.114974-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After calling kfree() on the bind_list we should be zeroing out
the pointer, otherwise a second call to cma_release_port() will
crash.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/infiniband/core/cma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 68c997be2429..2a0010eddb33 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1770,6 +1770,7 @@ static void cma_release_port(struct rdma_id_private *id_priv)
 	if (hlist_empty(&bind_list->owners)) {
 		cma_ps_remove(net, bind_list->ps, bind_list->port);
 		kfree(bind_list);
+		id_priv->bind_list = NULL;
 	}
 	mutex_unlock(&lock);
 }
-- 
2.16.4

