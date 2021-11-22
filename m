Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33D2458DE0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 12:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhKVL5K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 06:57:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:32846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhKVL5K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 06:57:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1911560240;
        Mon, 22 Nov 2021 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637582043;
        bh=t+Ihm6CwgYhRN54//Oavc0b+x8n0gFK+7F9LPp//ADw=;
        h=From:To:Cc:Subject:Date:From;
        b=IE1P3YO4hoZJYVVZoZCnWbF/AdrIptfcjFgtgSvuTwzifSWiEXo3iJwf1D4TQwYxd
         nlXnqGj63EEZSJKVVdbAZC8C9i+hnYCSScRnye8rKILly6bCf92yycXePanfhwRgVG
         h+EGTVv1odanBHaEd6LXS2a739Ip/TxTRkMjJkAl88BJ5jChVjIHNrjBJagsifP+D1
         Ka6xY1Y9s/2R5I/r2jxXm2NEL66X9dHZ45rwsAy5d/oOA7g4e+tSJdOKA41CKK4Xf7
         /pVK5ZApaCqsXI3tT7Y9Z/wA7irnY5fNP4CWSgA6D8Js9DupXOlO03aly2O00xvgKQ
         Fc8gZIGg88eKg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 0/3] Skip holes in GID tables
Date:   Mon, 22 Nov 2021 13:53:55 +0200
Message-Id: <cover.1637581778.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This short series extends rdma_query_gid() callers to skip holes
in GID tables.

Avihai Horon (3):
  RDMA/core: Modify rdma_query_gid() to return accurate error codes
  RDMA/core: Let ib_find_gid() continue search even after empty entry
  RDMA/cma: Let cma_resolve_ib_dev() continue search even after empty
    entry

 drivers/infiniband/core/cache.c  |  8 ++++++--
 drivers/infiniband/core/cma.c    | 14 +++++++++++---
 drivers/infiniband/core/device.c |  3 +++
 3 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.33.1

