Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32FB32D3DF
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 14:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbhCDNFz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 08:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241081AbhCDNFs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 08:05:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49B8460200;
        Thu,  4 Mar 2021 13:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614863108;
        bh=U5lakB8Tu2t8j6DzJmf/TFwb62k2ztCxfX9BJMN4poU=;
        h=From:To:Cc:Subject:Date:From;
        b=Kk+qQfkI3XdL5yyOEw4MHw5AnKaQeTv2XPBBwUyN8uxp48YF8Kl8deFE0m6bqymCz
         aL2Gv7f8YnAI75pgbH0LLQzbpTWZGCv/DCw5CzRJj5S6px/CRE/yzkjcdl2k9wG3Zj
         f7X3FJJy5UotMncNHp+egp9AGLZWLmlyySmOCqOFktAoFKh9qOKJjF6Tq9+nZITUFR
         5ilyNw5LwOYaWXHukknmx2Eb94ynNbFWjvqDnGC2qUhnjxDxR/EhMKmcyyeUS++w3r
         +pHCc8vs2nzRTp6BQNeNt+W+l4UnGi65LYnFLS+za4LEXbnaoNo48LtSsE8keCns7H
         lzBYuzPogh1Uw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 0/3] Support larger than 4K pages in DevX UMEMs
Date:   Thu,  4 Mar 2021 15:04:58 +0200
Message-Id: <20210304130501.1102577-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series removes existing limitation from DevX UMEM and allows user
space to specify the page sizes which it can accept.

Thanks

Jason Gunthorpe (1):
  RDMA/mlx5: Allow larger pages in DevX umem

Yishai Hadas (2):
  IB/core: Drop WARN_ON() from ib_umem_find_best_pgsz()
  IB/core: Split uverbs_get_const/default to consider target type

 drivers/infiniband/core/umem.c           |  4 --
 drivers/infiniband/core/uverbs_ioctl.c   | 32 ++++++++--
 drivers/infiniband/hw/mlx5/devx.c        | 64 ++++++++++++++++---
 drivers/infiniband/hw/mlx5/main.c        |  1 +
 include/rdma/uverbs_ioctl.h              | 80 ++++++++++++++++++++----
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
 6 files changed, 151 insertions(+), 31 deletions(-)

--
2.29.2

