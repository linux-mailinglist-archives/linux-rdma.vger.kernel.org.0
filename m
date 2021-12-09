Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B147A46E8E5
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 14:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhLINTv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 08:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhLINTu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 08:19:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CF2C061746;
        Thu,  9 Dec 2021 05:16:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 70343CE25B2;
        Thu,  9 Dec 2021 13:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB726C341C7;
        Thu,  9 Dec 2021 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055773;
        bh=tKDqFndosYlg/gxG8Z3KUlPjUsHWxfnjuNALsq+WMe8=;
        h=From:To:Cc:Subject:Date:From;
        b=i9t+e/beVjWLmnedzUY4WUuWorraVp3zGbDsEOF+jGc4CgtSmwhLbag+WPX3C0xxT
         nsNkK8wGYb7Ii+TnUkrtuvqC0TSxmIQ5GidJAwvY2in0qdPzgfKkBovk5TFqfoznjM
         rGCN1GNMrOCr2xiBHZvOVgChcTPG+GjfQNaTmJ/EE8UTZ/xlqMpLuGc30eDxNXNHNT
         JDZ9QIjmCulQZRyOD+WamkvVGyDOVUKeIfAOpNYu3SIh0lSRhWDSz3NebF5LgYQAS7
         AWnpiUlcMIdaVrBX5G+yW/kZEebZor+G8K/CZ6tWPY4RqiOgeX7Kke9bafCFVklHVR
         67HaDNbSAFzgQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v1 0/3] Skip holes in GID table
Date:   Thu,  9 Dec 2021 15:16:04 +0200
Message-Id: <cover.1639055490.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Removed variable assignment in rdma_query_gid
 * Changed special error code handling of return value from
   rdma_query_gid to continue search.
v0: https://lore.kernel.org/all/cover.1637581778.git.leonro@nvidia.com

---------------------------------------------------------------------

Hi,

This short series extends rdma_query_gid() callers to skip holes
in GID tables.

Thanks

Avihai Horon (3):
  RDMA/core: Modify rdma_query_gid() to return accurate error codes
  RDMA/core: Let ib_find_gid() continue search even after empty entry
  RDMA/cma: Let cma_resolve_ib_dev() continue search even after empty
    entry

 drivers/infiniband/core/cache.c  | 12 +++++++++---
 drivers/infiniband/core/cma.c    | 12 +++++++++---
 drivers/infiniband/core/device.c |  3 ++-
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.33.1

