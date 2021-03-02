Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1515732A814
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351615AbhCBRGQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:06:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376806AbhCBH5c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Mar 2021 02:57:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 713E46186A;
        Tue,  2 Mar 2021 07:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614670947;
        bh=NCab0pXS7gaLeLwWFsIsv3nhGwXRBDMkS2GeHpCQveg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nA79AaxtP4wSTe1qJ6vjpZhpbtcW9bcQwRTXD+GpciP6wql41PiT+su24oovy6oT4
         G+OwghhnZeX745YcI4f5Mrlm9C46HvefAIYtr+rtjZlisdp5M9i5SyRPKwrRuu1pda
         y/KNR1fkIGhilRNdwW+yghQCfPx0wZMW0ik/B8bjqBMYA+wBU2j6aB9NQ4Lg2gMxNu
         lqaXiloRDOOxcqSFYTtcJkFMrrwTEn/k+2zFLGoLon6xoEKhKAtqsZHnab1GpnlLe8
         tr0OPpxPH9AWwiIkx+GL9MRhYZoI3cvYxWfU7kFl72kbqP7vp/84VUEPvD/gdwHdTv
         EyWWzNWPtbyFw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 1/2] RDMA/mlx5: Set correct kernel-doc identifier
Date:   Tue,  2 Mar 2021 09:42:13 +0200
Message-Id: <20210302074214.1054299-2-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302074214.1054299-1-leon@kernel.org>
References: <20210302074214.1054299-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The W=1 allmodconfig build produces the following warning:
drivers/infiniband/hw/mlx5/odp.c:1086: warning: wrong kernel-doc identifier on line:
  * Parse a series of data segments for page fault handling.

Fix it by changing /** to be /* as it is written in kernel-doc documentation.

Fixes: 5e769e444d26 ("RDMA/hw/mlx5/odp: Fix formatting and add missing descriptions in 'pagefault_data_segments()'")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 374698186662..b103555b1f5d 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1082,7 +1082,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	return ret ? ret : npages;
 }

-/**
+/*
  * Parse a series of data segments for page fault handling.
  *
  * @dev:  Pointer to mlx5 IB device
--
2.29.2

