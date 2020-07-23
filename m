Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8604B22A953
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 09:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGWHHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jul 2020 03:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGWHHN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Jul 2020 03:07:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04680206E3;
        Thu, 23 Jul 2020 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595488032;
        bh=RjSqLEO3vk4gAiV2WuS4sc5no/VxW/8OYwuUvP5Zh6A=;
        h=From:To:Cc:Subject:Date:From;
        b=qFuVC05QTjwVxHq6c8/Gugx9yW/gbWBx4KUg3TJf80X5pyqF2w39wxg4UIuJDO/Ut
         oRb+5dtVGo/tAwHVpLORRyWEp7DKwyUrPYGBhBnK/bzfPd/CubiaMznT9JyjqKgcJi
         Bn1Cb8R4VyZLGWRNsUNPJjH7FhCqDoLBPPnbHopU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 0/4] Fix bugs around RDMA CM destroying state
Date:   Thu, 23 Jul 2020 10:07:03 +0300
Message-Id: <20200723070707.1771101-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

From Jason:

This small series simplifies some of the RDMA CM state transitions
connected with DESTROYING states and in the process resolves a bug
discovered by syzkaller.

Thanks

Jason Gunthorpe (4):
  RDMA/cma: Simplify DEVICE_REMOVAL for internal_id
  RDMA/cma: Using the standard locking pattern when delivering the
    removal event
  RDMA/cma: Remove unneeded locking for req paths
  RDMA/cma: Execute rdma_cm destruction from a handler properly

 drivers/infiniband/core/cma.c | 257 ++++++++++++++++------------------
 1 file changed, 123 insertions(+), 134 deletions(-)

--
2.26.2

