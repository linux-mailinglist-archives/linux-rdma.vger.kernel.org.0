Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1341F1400B
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfEEOHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 10:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEOHU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 10:07:20 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9177B206DF;
        Sun,  5 May 2019 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557065240;
        bh=WnZnz4BPYqUf/HDRqJBBjNhd8QrmGb5TsLD8DeVU06M=;
        h=From:To:Cc:Subject:Date:From;
        b=O4MLYBOiaiY4WxkbVJyaxo1I6EEPCRPVafNM2TUyrQYSy2GdYcBqJP9lZ5znWAHpt
         sH4CbIJQ2s6g/osVNY/gpcHkBpBaf3iOVz1LXsS8akB8uSxquaa66kAe5HkUKtIzyX
         CMAWezU4ntmEl6xzjacD3iRC93yVO/idtqS7DvNg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-next 0/4] User space steering
Date:   Sun,  5 May 2019 17:07:10 +0300
Message-Id: <20190505140714.8741-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog v0 -> v1:
 * Removed phys_addr dependency from kconfig

-------------------------------------------------------------------------
From Ariel,

This series of patches adds user space managed steering infrastructure
to the mlx5_ib driver.

User space managed steering requires the means to access a dedicated
memory space that is used by the device to store the packet steering
and header modification tables and rules in order to manage them
directly without the device's firmware involvement. This dedicated memory
is part of the ICM memory space.

The changes are introducing the mlx5_ib API to allocate, deallocate and
register this dedicated SW ICM memory via the existing device memory API
using a private attribute which specifies the memory type.

The allocated memory itself is not IO mapped and user can only access it
using remote RDMA operations.

In addition, the series exposed the ICM address of the receive transport
interface (TIR) of Raw Packet and RSS QPs to user since they are
required to properly create and insert steering rules that direct flows
to these QPs.

Thanks

Ariel Levkovich (4):
  IB/mlx5: Support device memory type attribute
  IB/mlx5: Warn on allocated MEMIC buffers during cleanup
  IB/mlx5: Add steering SW ICM device memory type
  IB/mlx5: Device resource control for privileged DEVX user

 drivers/infiniband/hw/mlx5/cmd.c          | 155 +++++++++++--
 drivers/infiniband/hw/mlx5/cmd.h          |   8 +-
 drivers/infiniband/hw/mlx5/devx.c         |   4 +
 drivers/infiniband/hw/mlx5/main.c         | 267 ++++++++++++++++++----
 drivers/infiniband/hw/mlx5/mlx5_ib.h      |  40 +++-
 drivers/infiniband/hw/mlx5/mr.c           |  39 +++-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h  |   1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h |   6 +
 8 files changed, 435 insertions(+), 85 deletions(-)

--
2.20.1

