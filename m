Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D31B20504F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 13:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbgFWLPl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 07:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732444AbgFWLPl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 07:15:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73EEF20768;
        Tue, 23 Jun 2020 11:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592910940;
        bh=sSEBg7BS4y97VRPaHvgWbcjFCc8lTAXrVTlmmCEIUkY=;
        h=From:To:Cc:Subject:Date:From;
        b=QFGkKOfHyz681beKaAD5o5TugB8sHaSA6CJ3p3bIfbR79l0J8B6VPADlLkG37Vr0c
         SsJcLxae+pp7HqEkUWkEPQtf5HExZBkoSRMvdJEZZExycIybnk8n/4iJ9Dmqfbd4WA
         ntWBxw4B1EXkCBwvxaTtOWtbg7aimwCMi+XVf1eI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 0/2] Convert XRC to use xarray
Date:   Tue, 23 Jun 2020 14:15:29 +0300
Message-Id: <20200623111531.1227013-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
v1: Changed ib_dealloc_xrcd_user() do not iterate over tgt list, because
it is expected to be empty.
v0: https://lore.kernel.org/lkml/20200621104110.53509-1-leon@kernel.org
Two small patches to simplify and improve XRC logic.

Thanks

Maor Gottlieb (2):
  RDMA: Clean ib_alloc_xrcd() and reuse it to allocate XRC domain
  RDMA/core: Optimize XRC target lookup

 drivers/infiniband/core/uverbs_cmd.c | 12 ++---
 drivers/infiniband/core/verbs.c      | 76 +++++++++++++---------------
 drivers/infiniband/hw/mlx5/main.c    | 24 +++------
 include/rdma/ib_verbs.h              | 27 +++++-----
 4 files changed, 59 insertions(+), 80 deletions(-)

--
2.26.2

