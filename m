Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039932E78C8
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Dec 2020 14:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgL3NCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Dec 2020 08:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgL3NCS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Dec 2020 08:02:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91EBF2222A;
        Wed, 30 Dec 2020 13:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609333298;
        bh=OyRCMcoPxe+G3qz8BjscJxHcQpXy6RLIQoizg8wpUZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRTIW4iNgqwGBjoRwUfwhz1VTcv1kd56PNho6ZhRFVozPSELdtvPSsVe59xXUJAJd
         xngYjPGAz+uBKE0nXyq5edpTk/DJN7xp2obdD501ghRRUZdcMfsamWbs8NVdkVaMND
         KJwrPQPwzs1J4o4s3hsQuqXspkdWJqg0bIao0+taus83x8TA8a3jQTH3/Ri+ShLUsO
         F0EPGtxjSmBHszWvgVzE23HGYiHozO3I2jFYoa9wfY/3Nx61PhUBy9b6GMzJUW6X+g
         QXrPjghHHR4cC/PnhkCuhPeF8PHxIcvTQO6Inz0maOfuPhE1hpaslFS81FTgfAkTyT
         hcGqlNwvt3Ifg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 2/3] net/mlx5: Expose ifc bits for query modify header
Date:   Wed, 30 Dec 2020 15:01:20 +0200
Message-Id: <20201230130121.180350-3-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230130121.180350-1-leon@kernel.org>
References: <20201230130121.180350-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@nvidia.com>

Expose ifc bits for query_modify_header_context_in to be used by DEVX.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 3f68dbf18c61..8c5d5fe58051 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -5908,6 +5908,18 @@ struct mlx5_ifc_dealloc_modify_header_context_in_bits {
 	u8         reserved_at_60[0x20];
 };

+struct mlx5_ifc_query_modify_header_context_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         modify_header_id[0x20];
+
+	u8         reserved_at_60[0xa0];
+};
+
 struct mlx5_ifc_query_dct_out_bits {
 	u8         status[0x8];
 	u8         reserved_at_8[0x18];
--
2.29.2

