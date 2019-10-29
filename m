Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA4E8042
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfJ2G2D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfJ2G2C (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:28:02 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70E720862;
        Tue, 29 Oct 2019 06:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330482;
        bh=UUCHaLAyu9zbov1Hmk63VOkkgUwWezRpxDSm7/x9fIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7zqt4W1hPpxmT/xy1YLM6mTe/HAnOD4vZqd1I4AtI4gaAjGbs7sUYhMhyd/mHR8g
         AO9ixMkr3+/sQJvcuHWm39CwII0nLZrYysPF0Mx6e+khcPPTZ+/CCutisVvEoqklx/
         Y/thmhY3CkuZF6Ec0JBl0Vm0yJ+atiH0xgknvokc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 04/16] RDMA/mlx5: Delete redundant zero memset
Date:   Tue, 29 Oct 2019 08:27:33 +0200
Message-Id: <20191029062745.7932-5-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029062745.7932-1-leon@kernel.org>
References: <20191029062745.7932-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

All callers to process_mad() allocate MAD output buffer
with kzalloc, so there is no need to clear memory again.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 348c1df69cdc..0a5eb6e1798c 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -284,8 +284,6 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 			 *out_mad_size != sizeof(*out_mad)))
 		return IB_MAD_RESULT_FAILURE;
 
-	memset(out_mad->data, 0, sizeof(out_mad->data));
-
 	if (MLX5_CAP_GEN(dev->mdev, vport_counters) &&
 	    in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT &&
 	    in_mad->mad_hdr.method == IB_MGMT_METHOD_GET) {
-- 
2.20.1

