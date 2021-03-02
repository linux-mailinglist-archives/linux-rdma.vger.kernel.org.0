Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF7E32A812
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351567AbhCBRES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376805AbhCBH5c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Mar 2021 02:57:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32DA461477;
        Tue,  2 Mar 2021 07:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614670939;
        bh=opB9CqRjyVc0zlEx9mmefFIRZ3tUYuEZJ5pZJEaidJw=;
        h=From:To:Cc:Subject:Date:From;
        b=jlK2riWjrt33/DwMCmbw4Le9ojXcZ3Nz4UDXGQUDxKMUEppnp2Y2gJFeLv+J2cF5t
         gapiDeDKXQOgTBdXJN+uW4siolQDdYKeK/qke163GLiq755cba0Vjyi4ILG8smT96i
         8OCx3Yhb01inZgoyRI/voofEkGf/92+HDncWK45m60mxAVlvwkWOwVWzJDt05C4Bjj
         jhHxnzvoJpYHmRHibq+/mVmYeu6NLU9NPvAzO6gt5GuY7tI/In38PxTkP4foYUWjP0
         htH1ilHNvIGxxd+UXrzdMbYVdu2iu8TKPfE515cLa92bAItdL1O+QCSDfN88QmH/9a
         Wl2O818m9ePQA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 0/2] W=1 compilation fixes leftovers
Date:   Tue,  2 Mar 2021 09:42:12 +0200
Message-Id: <20210302074214.1054299-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Two extra fixes that were missed in Lee's W=1 cleanup.

Leon Romanovsky (2):
  RDMA/mlx5: Set correct kernel-doc identifier
  RDMA/uverbs: Fix kernel-doc warning of _uverbs_alloc

 drivers/infiniband/core/uverbs_ioctl.c | 4 ++--
 drivers/infiniband/hw/mlx5/odp.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--
2.29.2

