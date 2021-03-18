Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487AE3402A8
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 11:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCRKDQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 06:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhCRKDP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Mar 2021 06:03:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9943E64F38;
        Thu, 18 Mar 2021 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616061795;
        bh=Y/zho4pO/HrvXMC2z788pqM+I0PtlEGD9khRdFhixBA=;
        h=From:To:Cc:Subject:Date:From;
        b=cjb+OD0qlseE3PZxPmt6qVaS8TEdR170Kx0d6qs43JoMzhbtyRYFf+YwcyKa6OEsu
         lz+Hh5KxxbJeY5/L27qm5m+7IcHitBspRVufjmO/BOWrx128IaiS0gCEWyd1HrK8d7
         Zuuztdhv5eC4a/1WICq637mYyZYw2GbUpXe2/6ZzVoVDRlgAIkaJ3AnvHzQVexL+7M
         R7dPVu4oMDSs3Kzkv7BG+x57PO2NRF4wMdL+DYRZ5gDqREQRIQXsCiUvlm7V/9qZoA
         zz3JvKyUmAeO9k8IZd8akIxdZgadEbRA4JWMdtaiLfsy5CeMHdN5+eD6P5zrCYrmmu
         z9qo8n7lWM9mg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 0/6] Fix memory corruption in CM
Date:   Thu, 18 Mar 2021 12:03:03 +0200
Message-Id: <20210318100309.670344-1-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series from Mark fixes long standing bug in CM migration logic,
reported by Ryan [1].

Thanks

[1] https://lore.kernel.org/linux-rdma/CAFMmRNx9cg--NUnZjFM8yWqFaEtsmAWV4EogKb3a0+hnjdtJFA@mail.gmail.com/

Mark Zhang (6):
  Revert "IB/cm: Mark stale CM id's whenever the mad agent was
    unregistered"
  IB/cm: Remove "mad_agent" parameter of ib_cancel_mad
  IB/cm: Remove "mad_agent" parameter of ib_modify_mad
  IB/cm: Clear all associated AV's ports when remove a cm device
  IB/cm: Add lock protection when access av/alt_av's port of a cm_id
  IB/cm: Initialize av before acquire the spin lock in cm_lap_handler

 drivers/infiniband/core/cm.c       | 359 ++++++++++++++++-------------
 drivers/infiniband/core/mad.c      |  17 +-
 drivers/infiniband/core/sa_query.c |   4 +-
 include/rdma/ib_mad.h              |  27 ++-
 4 files changed, 222 insertions(+), 185 deletions(-)

--
2.30.2

