Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB91C6A52
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgEFHrL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgEFHrK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:47:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70AE020714;
        Wed,  6 May 2020 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751230;
        bh=YVEevpk37mTn26RsWusk6TwowkgYyo5YfuLvRtaxaDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1NIj/np3t+TVdHUzZVAwwo3gVgpIQIh6bxJ2oku6nbE9K7MXAOESQ+2NeTmSknLBq
         MMXgUzG/Blu/a6fYqnhOSaSlcVjvuwsJU7zuPYmtdRew7wl5QKKT3LykDvO6mJNlvM
         Kyfq5oZ/S3M4Qtb5eNrpwGSfBZqo1Psz20OQWmvo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 02/10] RDMA/cm: Remove return code from add_cm_id_to_port_list
Date:   Wed,  6 May 2020 10:46:53 +0300
Message-Id: <20200506074701.9775-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506074701.9775-1-leon@kernel.org>
References: <20200506074701.9775-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This cannot happen, all callers pass in one of the two pointers. Use
a WARN_ON guard instead.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index e77e01b03622..78c9acc9393a 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -478,24 +478,19 @@ static int cm_init_av_for_response(struct cm_port *port, struct ib_wc *wc,
 				       grh, &av->ah_attr);
 }
 
-static int add_cm_id_to_port_list(struct cm_id_private *cm_id_priv,
-				  struct cm_av *av,
-				  struct cm_port *port)
+static void add_cm_id_to_port_list(struct cm_id_private *cm_id_priv,
+				   struct cm_av *av, struct cm_port *port)
 {
 	unsigned long flags;
-	int ret = 0;
 
 	spin_lock_irqsave(&cm.lock, flags);
-
 	if (&cm_id_priv->av == av)
 		list_add_tail(&cm_id_priv->prim_list, &port->cm_priv_prim_list);
 	else if (&cm_id_priv->alt_av == av)
 		list_add_tail(&cm_id_priv->altr_list, &port->cm_priv_altr_list);
 	else
-		ret = -EINVAL;
-
+		WARN_ON(true);
 	spin_unlock_irqrestore(&cm.lock, flags);
-	return ret;
 }
 
 static struct cm_port *
@@ -576,12 +571,7 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 		return ret;
 
 	av->timeout = path->packet_life_time + 1;
-
-	ret = add_cm_id_to_port_list(cm_id_priv, av, port);
-	if (ret) {
-		rdma_destroy_ah_attr(&new_ah_attr);
-		return ret;
-	}
+	add_cm_id_to_port_list(cm_id_priv, av, port);
 	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
 	return 0;
 }
-- 
2.26.2

