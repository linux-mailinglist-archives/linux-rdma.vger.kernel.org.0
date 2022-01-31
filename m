Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E74A3F7C
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 10:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiAaJpf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 04:45:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43806 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241929AbiAaJpc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 04:45:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED9F61344
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 09:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E092C340ED;
        Mon, 31 Jan 2022 09:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643622331;
        bh=5utfV9FQI9V3Q4bU+GQVcZsWKjr0AAUGN+MzL5OCLjU=;
        h=From:To:Cc:Subject:Date:From;
        b=gp9pFDqYX4ORsmDthkwDDVbay3w4oxSP5JMLO0WpEPk6KGsqoZ8emuUPsrAofimcM
         IhzL/+dBCFoRYXWRZbo92WY2fYREVzijnrShkLFFknIWE6zkXmzkDZUYbabV2SzC2/
         8dXpMWQgOfKtxCSKrnFaXD+/C4gdwmkA28EqDfhAxq+7fPZ/hz/Jd68In2NvOwlm0x
         fE7iS12E0D3AEhhMNZB+YcAU5w4Wm4nlgESVyq6Ty8cy0+GoJRa2268VR9qQqk+ILh
         erWxckHTPOzWqwjTLoItvZHfxMeCftZJZlYLtx+r6lN4RnjX3FDPgdOV3ensESXSL3
         MwoIQxTmxcbRA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx4: Don't continue event handler after memory allocation failure
Date:   Mon, 31 Jan 2022 11:45:26 +0200
Message-Id: <12a0e83f18cfad4b5f62654f141e240d04915e10.1643622264.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The failure to allocate memory during MLX4_DEV_EVENT_PORT_MGMT_CHANGE
event handler will cause skip the assignment logic, but ib_dispatch_event()
will be called anyway.

Fix it by calling to return instead of break after memory allocation
failure.

Fixes: 00f5ce99dc6e ("mlx4: Use port management change event instead of smp_snoop")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 1c3d97229988..93b1650eacfa 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -3237,7 +3237,7 @@ static void mlx4_ib_event(struct mlx4_dev *dev, void *ibdev_ptr,
 	case MLX4_DEV_EVENT_PORT_MGMT_CHANGE:
 		ew = kmalloc(sizeof *ew, GFP_ATOMIC);
 		if (!ew)
-			break;
+			return;
 
 		INIT_WORK(&ew->work, handle_port_mgmt_change_event);
 		memcpy(&ew->ib_eqe, eqe, sizeof *eqe);
-- 
2.34.1

