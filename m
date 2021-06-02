Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A91398668
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 12:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhFBK24 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 06:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhFBK24 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 06:28:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E745613AA;
        Wed,  2 Jun 2021 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622629633;
        bh=E6SVPVzky9EFJdZ+sn6m8Cl7asDLYsWYrlx32eg/a64=;
        h=From:To:Cc:Subject:Date:From;
        b=mNDBwfmpgqvf2U2easzaQLVZXJ6/Et3GqT93qZX+j8wYwxhjBS9DUVs7MsdLW43fy
         tlTYysNZ3BkXMlzQzG04L7lZKeHVZonXfg6bNtasUN1ptkabcpmIP6Zx7GS6hVX/Y+
         7/63sMF1z7OSwQkcj/73Cqv4O/kqLhZr3o84tlZBgSH/f/epUNdHRuSw57i4fhLv7g
         uG0/zoGgnzkF1j6v/w4+b+BvaACYMZzsbAWX2fmswwH+pFnYNHE3UxNhwTcOqAMiFe
         aNqT1t7Ti9xSaLv49s5+FB3zi3U1FOywqLRj5Rq/37uE/Da0dFKWoH5CfenhdoaCGi
         9EUQJ+S94jkiA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v4 0/8] Fix memory corruption in CM
Date:   Wed,  2 Jun 2021 13:27:00 +0300
Message-Id: <cover.1622629024.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v4:
 * Added comment near cm_destroy_av()
 * Changed "unregistration lock" to be "mad_agent_lock" in the comment
 * Removed unclear comment
v3: https://lore.kernel.org/lkml/cover.1620720467.git.leonro@nvidia.com
 * Removed double unlock
 * Changes in cma_release flow
v2: https://lore.kernel.org/lkml/cover.1619004798.git.leonro@nvidia.com
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

Mark Zhang (4):
  Revert "IB/cm: Mark stale CM id's whenever the mad agent was
    unregistered"
  IB/cm: Simplify ib_cancel_mad() and ib_modify_mad() calls
  IB/cm: Improve the calling of cm_init_av_for_lap and
    cm_init_av_by_path
  IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock

 drivers/infiniband/core/cm.c       | 621 +++++++++++++++--------------
 drivers/infiniband/core/mad.c      |  17 +-
 drivers/infiniband/core/sa_query.c |   4 +-
 include/rdma/ib_mad.h              |  27 +-
 4 files changed, 346 insertions(+), 323 deletions(-)

-- 
2.31.1

