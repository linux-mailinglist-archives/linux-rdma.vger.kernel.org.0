Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE9017C03C
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 13:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfGaLk2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 07:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbfGaLk1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 07:40:27 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4DE2089E;
        Wed, 31 Jul 2019 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564573227;
        bh=nfkmVZjbiklD7mauA11uZuNUYB6Rf9S0xfeDzFGI3eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWWeBXQuve7KP61y3YhgCQmwG9BrgWrQ8ouFPPlxbn1KZ8oMDrC5YHKfAy8Bu6axo
         OELyJ0EJQ3uCLVnTOWxM/MngkhBtoGBYfCjKrbcGDMFqSr/jsTibtwzXq8/YWLCbdz
         pkBfsA/TdkEYfaQH6JVxe2K1gOQyYumIM8lammqM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH mlx5-next 1/2] net/mlx5: Fix mlx5_ifc_query_lag_out_bits
Date:   Wed, 31 Jul 2019 14:40:13 +0300
Message-Id: <20190731114014.4786-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731114014.4786-1-leon@kernel.org>
References: <20190731114014.4786-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

Remove the "reserved_at_40" field to match the device specification.

Fixes: 84df61ebc69b ("net/mlx5: Add HW interfaces used by LAG")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/linux/mlx5/mlx5_ifc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 5eae8d734435..726790d9ef25 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -9572,8 +9572,6 @@ struct mlx5_ifc_query_lag_out_bits {

 	u8         syndrome[0x20];

-	u8         reserved_at_40[0x40];
-
 	struct mlx5_ifc_lagc_bits ctx;
 };

--
2.20.1

