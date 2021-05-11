Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366F537A216
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 10:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhEKIck (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 04:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhEKIci (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 04:32:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E18DF61466;
        Tue, 11 May 2021 08:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721341;
        bh=yzu85/4xlJKPn9R7vpreP5xgNqD3/5JCWkDrOoww7go=;
        h=From:To:Cc:Subject:Date:From;
        b=th7AUjJHQVTN16usTH7cINOxzQbklOYV53+POmENCXBnQL65mOyauHx/4PKoudxYN
         ap93E4kXyZsIScrr/oeUC/OF91X7ZCihBKPdJqzM2B9++IlqSCNTsT3axL6wOJ8lvL
         pPHAyejU2GBCc35YfWUMRBoLX9ssYknar+Bpf54DKfX2wUqSJVMh25ess0CLTuITYd
         oCh0jHTEnuXX4s9e8hSm00zlZixAB/pp1ris6HD4hVyBsavI2cjvg4P8abrC8S6yoe
         TgwUWYuMW8NePVHXD0a1s4T9GuB66XBAmYMZEf7vW2h4H85+EZfp2Nrd8Eq+i+mUt9
         M1dxHvrYROeig==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v3 0/8] Fix memory corruption in CM
Date:   Tue, 11 May 2021 11:22:04 +0300
Message-Id: <cover.1620720467.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v3:
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

