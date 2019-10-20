Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8861DDD29
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 09:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfJTHQ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 03:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJTHQ0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 03:16:26 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200E821744;
        Sun, 20 Oct 2019 07:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571555785;
        bh=G3FnwL06XEW9KDbgsdP5+Z+/JB+Jcp8oSyvgDANAUA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enLUJDIL0sVcxOR0/PUgzbxzxlZyjARTdqinK0k0Nnb1tKJJeiT1fygB2GIQQGnoV
         lGq0SaRhd8mT5452kb4u/e+CJPkff5rNquKfoCAm60MYhdPQBYEVlrp0CnAQhZsf1O
         wRLjWsxR6MxXeJUguLlPz7zLd0OPo44O5cqxS8/I=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH rdma-next 4/6] RDMA/cm: Delete useless QPN masking
Date:   Sun, 20 Oct 2019 10:15:57 +0300
Message-Id: <20191020071559.9743-5-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020071559.9743-1-leon@kernel.org>
References: <20191020071559.9743-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

QPN is supplied by kernel users who controls and creates valid QPs,
such flow ensures that QPN is limited to 24bits and no need to mask
already valid QPN.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 7ffa16ea5fe3..2eb8e1fab962 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2101,7 +2101,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	cm_id_priv->initiator_depth = param->initiator_depth;
 	cm_id_priv->responder_resources = param->responder_resources;
 	cm_id_priv->rq_psn = cm_rep_get_starting_psn(rep_msg);
-	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num & 0xFFFFFF);
+	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num);
 
 out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;
-- 
2.20.1

