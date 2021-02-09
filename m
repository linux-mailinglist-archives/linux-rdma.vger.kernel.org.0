Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA18E314FBE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 14:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhBINFX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 08:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhBINFP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Feb 2021 08:05:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC12B64EBA;
        Tue,  9 Feb 2021 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612875874;
        bh=FXfwD/EFkCUOr/LQ/6TyiEmMI/AkkvSWHIVfhHDzgQg=;
        h=From:To:Cc:Subject:Date:From;
        b=VndzUdYCuEOL2N6Wt2MzomMhROmM6Yqisp4vZQyNpkz61uyXIVVVDrzRqSPXSFbGQ
         PUnnUgWLh6pRvYHRin4dMo0D3CJ/111C8sBnpwZU2v3SY4Ow29Jee3LDJYVLVVaboQ
         M9+d8r7Rg/m1Kv/d/F9kEJdYwG+OSDZK7GoUuH+tcXbS4C1skIW43e7okjSU5tp9s/
         976h3lgvMy3O12Zc+msR48jMBQBFJob3fDiLZ/bRKi5gfD2k6Wkxi8zBK8D0ekmTq1
         Y87nWftuMJvV2J4BQ8Qc6A8sRTUGFMRjhmfqnt1211/2/koD58bmU8+WsMGp96vDwY
         NS9lpRy82OK8A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Support 400Gbps IB rate in mlx5 driver
Date:   Tue,  9 Feb 2021 15:04:29 +0200
Message-Id: <20210209130429.698237-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Support 400Gbps IB rate in mlx5 driver.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 6e88bdc0b30e..38df809a1bd5 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3070,6 +3070,8 @@ static int ib_to_mlx5_rate_map(u8 rate)
 		return 4;
 	case IB_RATE_50_GBPS:
 		return 5;
+	case IB_RATE_400_GBPS:
+		return 6;
 	default:
 		return rate + MLX5_STAT_RATE_OFFSET;
 	}
-- 
2.29.2

