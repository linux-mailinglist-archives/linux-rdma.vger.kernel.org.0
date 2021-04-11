Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2031E35B414
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Apr 2021 14:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhDKMWO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Apr 2021 08:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKMWN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 11 Apr 2021 08:22:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E81E561006;
        Sun, 11 Apr 2021 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618143717;
        bh=P88pkroc1/e9/y9BNTv6KHGv7VNf0J5LDxf2zNIfM7I=;
        h=From:To:Cc:Subject:Date:From;
        b=mzZ6If9FJ1Ps0ZPrNirFuIkeOhHPmy28woEU+ZlW3xTAUpqA5Cp7DdhoKhQ2ZTZdd
         tx6+1mH3BS2ywe15RvsfF2hYgS6Y/nzT9ZXWQ/YV+h+9J5s5FuMiQZwGMvyMw/XONM
         ebJgFfuCHdQnJ1WF/9pV8u9+C96SIiWBBzp3+sqH920BrS1WMEgWPklEQ0Fdfx7F5D
         Fhi4YT60V7Cxol297RJJsC7R3yH1PqEwkN8PGrQ6s1sLwtQ4M8Mapvc5JqTjYnlQRu
         iy46ZByMyd5OU0qzv+zD+NsCIsioLt2i5q614fd+2Z66AChSu4//zIwBnEL1ElXqUB
         0X/yzmcYjS9FA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v1 0/5] Fix memory corruption in CM
Date:   Sun, 11 Apr 2021 15:21:47 +0300
Message-Id: <20210411122152.59274-1-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Squashed "remove mad_agent ..." patches to make sure that we don't
   need to check for the NULL argument.
v0: https://lore.kernel.org/lkml/20210318100309.670344-1-leon@kernel.org

-------------------------------------------------------------------------------

Hi,

This series from Mark fixes long standing bug in CM migration logic,
reported by Ryan [1].

Thanks

[1] https://lore.kernel.org/linux-rdma/CAFMmRNx9cg--NUnZjFM8yWqFaEtsmAWV4EogKb3a0+hnjdtJFA@mail.gmail.com/


Mark Zhang (5):
  Revert "IB/cm: Mark stale CM id's whenever the mad agent was
    unregistered"
  IB/cm: Simplify ib_cancel_mad() and ib_modify_mad() calls
  IB/cm: Clear all associated AV's ports when remove a cm device
  IB/cm: Add lock protection when access av/alt_av's port of a cm_id
  IB/cm: Initialize av before aquire the spin lock in cm_lap_handler

 drivers/infiniband/core/cm.c       | 398 +++++++++++++++++------------
 drivers/infiniband/core/mad.c      |  17 +-
 drivers/infiniband/core/sa_query.c |   4 +-
 include/rdma/ib_mad.h              |  27 +-
 4 files changed, 250 insertions(+), 196 deletions(-)

-- 
2.30.2

