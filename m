Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF773669FF
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 13:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbhDULlS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 07:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235269AbhDULlS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 07:41:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 592A76143D;
        Wed, 21 Apr 2021 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619005245;
        bh=poA2P4x8C+8J0ecOX5vbS9XCYlOs5tlreN5uXovLSso=;
        h=From:To:Cc:Subject:Date:From;
        b=aNa67FK+YPof4nHt4L45S5AZQRy48vbJjrpeazwsC3hganGMSCiKtAJ2lZvMGb+HD
         +OEpuLcB6+iE0MqOCwh+j20tQ9caPv0yRERvOaCIL0VFUZZ/khyOyRcxfgbWKO0+hP
         lqjuJIcK9cMNXzJsvbaWxpMIC1TXoftJA8Xt/2M1cLbh0og6SoMG4Wd2W6eiIs4LxH
         6LQ7sSkf2wcCtIPxpXdBWX+XEhiW+6SGghWj8/nex0SmPZBrVb7oH/pTMp/YRtHULj
         reqjGUV+XoB+xtfnvshOYPjDj6Mt3GqaaSjcxM35DXkJu0aX4+KFG5VS3ezoe+QfUj
         oQHQvzwoDqm/Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v2 0/9] Fix memory corruption in CM
Date:   Wed, 21 Apr 2021 14:40:30 +0300
Message-Id: <cover.1619004798.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v3:
 * Included Jason's patches in this series
v1: https://lore.kernel.org/linux-rdma/20210411122152.59274-1-leon@kernel.org
 * Squashed "remove mad_agent ..." patches to make sure that we don't
   need to check for the NULL argument.
v0: https://lore.kernel.org/lkml/20210318100309.670344-1-leon@kernel.org

-------------------------------------------------------------------------------

Hi,

This series from Mark fixes long standing bug in CM migration logic,
reported by Ryan [1].

Thanks

[1] https://lore.kernel.org/linux-rdma/CAFMmRNx9cg--NUnZjFM8yWqFaEtsmAWV4EogKb3a0+hnjdtJFA@mail.gmail.com/

Jason Gunthorpe (4):
  IB/cm: Pair cm_alloc_response_msg() with a cm_free_response_msg()
  IB/cm: Split cm_alloc_msg()
  IB/cm: Call the correct message free functions in cm_send_handler()
  IB/cm: Tidy remaining cm_msg free paths

Mark Zhang (5):
  Revert "IB/cm: Mark stale CM id's whenever the mad agent was
    unregistered"
  IB/cm: Simplify ib_cancel_mad() and ib_modify_mad() calls
  IB/cm: Clear all associated AV's ports when remove a cm device
  IB/cm: Add lock protection when access av/alt_av's port of a cm_id
  IB/cm: Initialize av before aquire the spin lock in cm_lap_handler

 drivers/infiniband/core/cm.c       | 621 ++++++++++++++++-------------
 drivers/infiniband/core/mad.c      |  17 +-
 drivers/infiniband/core/sa_query.c |   4 +-
 include/rdma/ib_mad.h              |  27 +-
 4 files changed, 368 insertions(+), 301 deletions(-)

-- 
2.30.2

