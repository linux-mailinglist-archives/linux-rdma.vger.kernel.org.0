Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E958F3A258A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 09:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFJHg3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 03:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhFJHg2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 03:36:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1652861359;
        Thu, 10 Jun 2021 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623310472;
        bh=vm2Gl7de5xYeg9+YSJDCcYTIgwbQdRg5LXOXXPhgCyk=;
        h=From:To:Cc:Subject:Date:From;
        b=W8Zgb99SUiXB68aswbczN7KzYuX7dwRm31Izd4LTmr0XbCt1f2zTdBHMpLMOabfkr
         M+aYLdr4IohhirBXPhF5BH0BvWWRm49lRFsKzUvrYDWGgKionOVYRWzReCGCRnS28a
         YFm9A9Th8Y9C8uk545EZA5fOmCAqF5CcEu8RZS92LTPXJ2wrt26WKyUi3VDrp3b/Mi
         e258+KT67kWyUp9Vd37Rj+EBw97k7xV6PYXbABeXZX+AUA7TNklF+XDE7V6TB0Qju1
         GAl6fj2QuS11CNy09D7BoGZRmq/B2um70zKJtxKfb7qLHmCDBw7aTP4f5shj+wP6FK
         hLBkFayKkV3Uw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Alaa Hleihel <alaa@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc 0/3] Collection of small fixes to mlx5_ib
Date:   Thu, 10 Jun 2021 10:34:24 +0300
Message-Id: <cover.1623309971.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This is unrelated batch of fixes to mlx5_ib.

Thanks

Aharon Landau (1):
  RDMA/mlx5: Delete right entry from MR signature database

Alaa Hleihel (1):
  IB/mlx5: Fix initializing CQ fragments buffer

Maor Gottlieb (1):
  RDMA: Verify port when creating flow rule

 drivers/infiniband/core/uverbs_cmd.c | 5 +++++
 drivers/infiniband/hw/mlx4/main.c    | 3 ---
 drivers/infiniband/hw/mlx5/cq.c      | 9 ++++-----
 drivers/infiniband/hw/mlx5/fs.c      | 5 ++---
 drivers/infiniband/hw/mlx5/mr.c      | 4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.31.1

