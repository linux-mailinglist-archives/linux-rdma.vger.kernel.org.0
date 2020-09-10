Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4826533C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgIJVaT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730989AbgIJOCp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:02:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC40221E2;
        Thu, 10 Sep 2020 14:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599746472;
        bh=FKhd4ybJxV1wErp2KZudqOkxEUyxFXgZWke6Azncq9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6wfEmOpw1ueWyWj5eLILpu/CmuPFCyjoeiP+26QGBguTlVyTRUSHsk5lu7XTKWkt
         X4nVJwJHbEhYYIpEc64AwAe/TvRA1wK5y1XISRwy9d1bz5UrGpwKgldPWJ1m9SgkjI
         i0Q1dhbBvg3qr2bv3EV3yKm1EFh4AlGvV/R0w8aQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 07/10] RDMA/core: Align write and ioctl checks of QP types
Date:   Thu, 10 Sep 2020 17:00:43 +0300
Message-Id: <20200910140046.1306341-8-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910140046.1306341-1-leon@kernel.org>
References: <20200910140046.1306341-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The ioctl flow checks that the user provides only a supported
list of QP types, while write flow didn't do it and relied on
the driver to check it. Align those flows to fail as early as
possible.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 408a1a4b67f6..b4e383505eda 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1275,8 +1275,21 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	bool has_sq = true;
 	struct ib_device *ib_dev;
 
-	if (cmd->qp_type == IB_QPT_RAW_PACKET && !capable(CAP_NET_RAW))
-		return -EPERM;
+	switch (cmd->qp_type) {
+	case IB_QPT_RAW_PACKET:
+		if (!capable(CAP_NET_RAW))
+			return -EPERM;
+		fallthrough;
+	case IB_QPT_RC:
+	case IB_QPT_UC:
+	case IB_QPT_UD:
+	case IB_QPT_XRC_INI:
+	case IB_QPT_XRC_TGT:
+	case IB_QPT_DRIVER:
+		break;
+	default:
+		return -EINVAL;
+	};
 
 	obj = (struct ib_uqp_object *)uobj_alloc(UVERBS_OBJECT_QP, attrs,
 						 &ib_dev);
-- 
2.26.2

