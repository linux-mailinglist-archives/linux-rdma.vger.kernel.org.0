Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4BE34072E
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCRNvd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 09:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhCRNv3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Mar 2021 09:51:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B0E564F1B;
        Thu, 18 Mar 2021 13:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616075489;
        bh=rqIOb3PcNph7t8Gjocui5datd/b1QIaQxtIU9gJlPhc=;
        h=From:To:Cc:Subject:Date:From;
        b=OWKk+2cY/aZkTfotbahqGKVxIDlcexBNjlGXJU/OTjUMzoQxmKje6ivZSKEpHHMc4
         cDiIdsOl981SNHfjSm9T3uEAyjhTNAJ9BJMhqUBylOBh6KKXNQ5fJRslw/4aMx3OnQ
         d/usRyKFwV33pOvOzcBeui6w+EkaO3ArhiA9UBAuISBS0M7D0bNSY6HsNSIAU/3SWL
         euMM8rmaCho20EhB260KH/44mo1VoGZ4L8MbAlqlQsCv/u6xUrD9MfjmgqW5zEXLpn
         AbjSJ855PWjb/xU+kHobeP+gAo9FnshvNGD2G3O58Mfm7lb5AMKO69QcVXnqPqIyiL
         zUAI1Z4tZcLJQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Daria Velikovsky <daria@mellanox.com>,
        linux-rdma@vger.kernel.org, Mark Bloch <markb@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Fix drop packet rule in egress table
Date:   Thu, 18 Mar 2021 15:51:23 +0200
Message-Id: <20210318135123.680759-1-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Initial drop action support missed that drop action can be added to
egress flow tables as well. Add the missing support.

This requires making sure that dest_type isn't set to PORT which in
turn exposes a possibility of passing dst while indicating number of
dsts as zero. Explicitly check for number of dsts and pass the appropriate
pointer.

Fixes: f29de9eee782 ("RDMA/mlx5: Add support for drop action in DV steering")
Reviewed-by: Mark Bloch <markb@nvidia.com>
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 25da0b05b4e2..f0af3f1ae039 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -1528,8 +1528,8 @@ static struct mlx5_ib_flow_handler *raw_fs_rule_add(
 		dst_num++;
 	}

-	handler = _create_raw_flow_rule(dev, ft_prio, dst, fs_matcher,
-					flow_context, flow_act,
+	handler = _create_raw_flow_rule(dev, ft_prio, dst_num ? dst : NULL,
+					fs_matcher, flow_context, flow_act,
 					cmd_in, inlen, dst_num);

 	if (IS_ERR(handler)) {
@@ -1885,8 +1885,9 @@ static int get_dests(struct uverbs_attr_bundle *attrs,
 		else
 			*dest_id = mqp->raw_packet_qp.rq.tirn;
 		*dest_type = MLX5_FLOW_DESTINATION_TYPE_TIR;
-	} else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS ||
-		   fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX) {
+	} else if ((fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS ||
+		    fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX) &&
+		   !(*flags & MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DROP)) {
 		*dest_type = MLX5_FLOW_DESTINATION_TYPE_PORT;
 	}

--
2.30.2

