Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F59A3635C1
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhDRN41 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhDRN41 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:56:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8ECA061278;
        Sun, 18 Apr 2021 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618754159;
        bh=SXlb86Bwtf3yK5dvUTLBvq0yc2SThnd7/EjKGW5Mw1s=;
        h=From:To:Cc:Subject:Date:From;
        b=BCVz9VikUzrF47EW7Vttc7g6y6bIuETyt3fW5ZeRCOeLeF4yW13JGTBsjKaZOb/kc
         tejpZlcZOaDuNiEl3e4B9qqzgEoaEssAr3I7Re9fyD+UGDIbkMkrz1+n014Biod/xA
         PISDgXMPQNU9FippZoJAU69njjsR6+q3Q/MatwR2Vpp5MOlL31bmEQ72osjgB/LHrt
         s9aD20yrf9cs5a5tcU/0wQvvrr/gRoNMP5rYb4f0nWYyjy1/upfu8uqad3Hcep5MqI
         i0hL6nTtQcpj630t77b4yPxPvUXA+b5TOO1XLq0UjvGaoKS0Lx4WKLxqpSQjvyBE9r
         zjlUmnJjV61dg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Krishna Kumar <krkumar2@in.ibm.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-next 0/3] CMA fixes
Date:   Sun, 18 Apr 2021 16:55:51 +0300
Message-Id: <cover.1618753862.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Another round of fixes to cma.c

Parav Pandit (1):
  RDMA/cma: Skip device which doesn't support CM

Shay Drory (2):
  RDMA/core: Fix check of device in rdma_listen()
  RDMA/core: Add CM to restrack after successful attachment to a device

 drivers/infiniband/core/cma.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

-- 
2.30.2

