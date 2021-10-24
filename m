Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0D438716
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Oct 2021 08:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhJXGKt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Oct 2021 02:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhJXGKr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 24 Oct 2021 02:10:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7227E60EE3;
        Sun, 24 Oct 2021 06:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635055707;
        bh=rX8g7hF9JG7n21Emw/iPYVIxS89I8lqxeDkZ0/kqq8k=;
        h=From:To:Cc:Subject:Date:From;
        b=nbMevpZJ8+nA1Xpfj9p7t8Zd//8DVTvtLLMGgo8hWnc6n3jfEIbYRKMCAWLseo+n9
         SBQqvxUrIRsb7EA8i8JKNd/whGM1JNzWprbffFHgc5kUcJ+ZKD+ayvU8RWH02M1VoI
         XT9xdQKZBGrpbRdoOpsDpuyutouugbJnJ0+dPnXLUeP+y+0TViaV/2CxgWiJ7KObF6
         D0CaWgMQEuht5EhRxekxZVmYrsQqf5pZLY0RLXnvAg/1glAzfbBcGup0dymY5Ohwg6
         y04hlHf7Xp1LMCcf8PjswIHyqFNAUJtfx8n7Xdsb5WBBQNQAswC5RxWrQc9xydztyV
         5c4aKmPliACnA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Fleck <john.fleck@intel.com>,
        Kaike Wan <kaike.wan@intel.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <markb@mellanox.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-rc 0/2] Two IB/core fixes 
Date:   Sun, 24 Oct 2021 09:08:19 +0300
Message-Id: <cover.1635055496.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Two IB/core fixes from Mark.

Mark Zhang (2):
  RDMA/sa_query: Use strscpy_pad instead of memcpy to copy a string
  RDMA/core: Initialize lock when allocate a rdma_hw_stats structure

 drivers/infiniband/core/sa_query.c | 5 +++--
 drivers/infiniband/core/sysfs.c    | 2 --
 drivers/infiniband/core/verbs.c    | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.31.1

