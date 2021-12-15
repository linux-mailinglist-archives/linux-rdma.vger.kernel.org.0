Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444274753EA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 08:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhLOHyl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 02:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhLOHyk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Dec 2021 02:54:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79EC061574;
        Tue, 14 Dec 2021 23:54:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B650B817E2;
        Wed, 15 Dec 2021 07:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B5AC34600;
        Wed, 15 Dec 2021 07:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639554877;
        bh=9k3/4zERn3kP2p81IwZivqzv0fiEHv9x8gEAOqTlE+M=;
        h=From:To:Cc:Subject:Date:From;
        b=ejCHZgxBep1Nl0QnmynU9ISL8YkjNzIvLBBX/ilzsu5G5xzVyyDO0GIxVcpRf/IDv
         l7BLjmshNEZi5ysvOmIHO/2J2vOTZXUFzNbRyfdnB1wo1IX+XcilaZuszCGadVnSaF
         VeaOovMKezd7XzTpzoSERP+vhNoa4rgTxSExmzbQPUwj9kGhbLNW8fgGl52OPUszlK
         wohGxp1tDJRUH2owruXv5mdHCIAs3ArrM37sJQJOyrpJDMLBjfQ3gW2vl3q18Uuxeq
         NNFvzucd+iqK1r+a/RllRpypZ6Hcdt23LCJRQd4e25Kdr7losBaLBqvydAFYBI+P9q
         +QyJ7Uox5ODHA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maher Sanalla <msanalla@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next] IB/mlx5: Expose NDR speed through MAD
Date:   Wed, 15 Dec 2021 09:54:31 +0200
Message-Id: <a2ab630d2a634547db9b581faa9d65da2edb9d05.1639554831.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maher Sanalla <msanalla@nvidia.com>

Under MAD query port, Report NDR speed when NDR is supported
in the port capability mask.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mad.c | 5 +++++
 include/rdma/ib_mad.h            | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index ec242a5a17a3..29a888b22789 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -584,6 +584,11 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u32 port,
 			    props->port_cap_flags2 & IB_PORT_LINK_SPEED_HDR_SUP)
 				props->active_speed = IB_SPEED_HDR;
 			break;
+		case 8:
+			if (props->port_cap_flags & IB_PORT_CAP_MASK2_SUP &&
+			    props->port_cap_flags2 & IB_PORT_LINK_SPEED_NDR_SUP)
+				props->active_speed = IB_SPEED_NDR;
+			break;
 		}
 	}
 
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index 465b0d0bdaf8..2e3843b761e8 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -276,6 +276,7 @@ enum ib_port_capability_mask2_bits {
 	IB_PORT_SWITCH_PORT_STATE_TABLE_SUP	= 1 << 3,
 	IB_PORT_LINK_WIDTH_2X_SUP		= 1 << 4,
 	IB_PORT_LINK_SPEED_HDR_SUP		= 1 << 5,
+	IB_PORT_LINK_SPEED_NDR_SUP		= 1 << 10,
 };
 
 #define OPA_CLASS_PORT_INFO_PR_SUPPORT BIT(26)
-- 
2.33.1

