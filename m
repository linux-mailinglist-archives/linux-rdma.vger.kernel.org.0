Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FF71C009E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgD3Pmq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 11:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgD3Pmq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 11:42:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1382E20661;
        Thu, 30 Apr 2020 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588261365;
        bh=VJCcJr4N81NQI8G4EjKpUpCGECv/xf0qF/Be5W7q0fs=;
        h=From:To:Cc:Subject:Date:From;
        b=mHC94ElOS/FwEHUKk8gOWom/+nxvs7rxWrCO1nEI8ecdYNHUjz+vhaOm4A/nXan08
         9vRDQA4UTdYyVvsLDVutaoXG0gCan7d5ORPGiiiCePdYuVi/DgepaIo202HbxgxMrV
         jCQhuPvzP98f4zZ7clw0jEamf0VGD5g1QEJpXjvc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 0/4] RDMA-CM unique device identifier
Date:   Thu, 30 Apr 2020 18:42:33 +0300
Message-Id: <20200430154237.78838-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This series extends librdmacm to unique identify the IBV device
connected to the CMA device.

https://github.com/linux-rdma/rdma-core/pull/749

Thanks

Leon Romanovsky (4):
  Update kernel headers
  libibverbs: Fix description of ibv_get_device_guid man page
  libibverbs: Get stable IB device index
  librdmacm: Rely on IB device index if available

 debian/libibverbs1.symbols               |  2 +
 kernel-headers/rdma/rdma_user_cm.h       |  2 +
 libibverbs/CMakeLists.txt                |  2 +-
 libibverbs/device.c                      |  7 ++++
 libibverbs/libibverbs.map.in             |  5 +++
 libibverbs/man/CMakeLists.txt            |  1 +
 libibverbs/man/ibv_get_device_guid.3.md  |  4 +-
 libibverbs/man/ibv_get_device_index.3.md | 40 ++++++++++++++++++
 libibverbs/man/ibv_get_device_list.3.md  |  1 +
 libibverbs/verbs.h                       |  9 ++++
 librdmacm/cma.c                          | 53 +++++++++++++++++++-----
 librdmacm/rdma_cma_abi.h                 |  2 +
 12 files changed, 114 insertions(+), 14 deletions(-)
 create mode 100644 libibverbs/man/ibv_get_device_index.3.md

--
2.26.2

