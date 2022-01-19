Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E749366B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 09:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245153AbiASIiD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 03:38:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54760 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiASIiD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jan 2022 03:38:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 926D261489;
        Wed, 19 Jan 2022 08:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226A4C004E1;
        Wed, 19 Jan 2022 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642581482;
        bh=TfHEw7No77uXjwjAF/HjijJhq/fZ1zmb2Jg0zAB8NJk=;
        h=From:To:Cc:Subject:Date:From;
        b=fzdWxcCmuIFQjRsscecP1dA7KZeOOtfoOJir6zeWb17I5LzD2oKX1J2NkiHGVD6Sf
         3kMn9MP8OxDo8GldippkQhzJCUQj8nAve9ycwLP2Q5CkVvzh484kqRivmjZnulfNkt
         F1FXca2u1Cq8UcygFR+Pztb93klN5itcx3uy3ezgKU1GF6+M4eXyDRLHLx7stBN6Fe
         OgdKmZzj4/1ZQ76zWZxhfPAn2Ca7GVmmSkdPyl5C2GK+HvPrbvg4ZGxedqw+D9Z5be
         BppgugerZx9Qajctyj6jRdSIGRc9SOs/8DojFq7U944VlUIxqwNoZE8nZwa6l4bq9O
         okr8wHZbbg9NA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] IB/cm: Release previously acquired reference counter in the cm_id_priv
Date:   Wed, 19 Jan 2022 10:37:55 +0200
Message-Id: <7615f23bbb5c5b66d03f6fa13e1c99d51dae6916.1642581448.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

In failure flow, the reference counter acquired was not released,
and the following error was reported:

  drivers/infiniband/core/cm.c:3373 cm_lap_handler() warn: inconsistent
			refcounting 'cm_id_priv->refcount.refs.counter':

Fixes: 7345201c3963 ("IB/cm: Improve the calling of cm_init_av_for_lap and cm_init_av_by_path")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index c903b74f46a4..35f0d5e7533d 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3322,7 +3322,7 @@ static int cm_lap_handler(struct cm_work *work)
 	ret = cm_init_av_by_path(param->alternate_path, NULL, &alt_av);
 	if (ret) {
 		rdma_destroy_ah_attr(&ah_attr);
-		return -EINVAL;
+		goto deref;
 	}
 
 	spin_lock_irq(&cm_id_priv->lock);
-- 
2.34.1

