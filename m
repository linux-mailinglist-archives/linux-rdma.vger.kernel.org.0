Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC342E78C7
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Dec 2020 14:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgL3NCI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Dec 2020 08:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgL3NCI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Dec 2020 08:02:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2F63221FA;
        Wed, 30 Dec 2020 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609333287;
        bh=lohuNvsA20EEbWfx62PlsdV7nDuYbYT1cfoVzP/TNGE=;
        h=From:To:Cc:Subject:Date:From;
        b=k3bmyhWhPLAgLK4S3Ee5kSD4DCgdkmsljPPxw9Rv8N4cSr8ryO+QE+Qpve1lh4d45
         3KIGcOSgAvgxFToz49h+GxqdJXouvfS6cwHyOGO4Ggo7nqfcnnUU4hjJJYaHWkhXA7
         OZKBMlshZvwYin0q20Wioci0dLfZoufW9lQEWsg+tVVkQwwKBGNfCrenHxEKJWgFRS
         0hFc1cfT75hM8b4wQt7SwvfzkildVVD2GDPR0bm7mInm3HeUALNoGdTdcZGzBguDAW
         K/x7GpI6wEZVs0CH7wpFCzzAgjQO8Hm6kp8jkoWvpNHPm507/qI4ekawVsGeekPFlz
         BIZbgX18Vnd6A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH mlx5-next 0/3] Cleanup around DEVX get/set commands
Date:   Wed, 30 Dec 2020 15:01:18 +0200
Message-Id: <20201230130121.180350-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Be more strict with DEVX get/set operations for the obj_id.

Yishai Hadas (3):
  RDMA/mlx5: Use the correct obj_id upon DEVX TIR creation
  net/mlx5: Expose ifc bits for query modify header
  RDMA/mlx5: Use strict get/set operations for obj_id

 drivers/infiniband/hw/mlx5/devx.c | 201 ++++++++++++++++++++++--------
 include/linux/mlx5/mlx5_ifc.h     |  12 ++
 2 files changed, 160 insertions(+), 53 deletions(-)

--
2.29.2

