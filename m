Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDC9211ECC
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGBI3i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 04:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgGBI3i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 04:29:38 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD4C20720;
        Thu,  2 Jul 2020 08:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593678578;
        bh=ik7IY+0XvW3ZlwkTi9uHuQu0b93JWMQwSot4E4oUZ0k=;
        h=From:To:Cc:Subject:Date:From;
        b=EX3+ChMc2eEW4yrbxpS6jGPVVE94p8j0RyQ9GJDQWs7SYS0rBVm2pfD72RAHZWP4T
         rVu++U/3wQfTId60uu59htBwDS8klb7TOpBObI5Ut6SpGSvkgmrxTC1zoVs2X9f5Au
         jbe3EbMUaw4b10qBthNZm0nU7uWpWkpMSZ+9eAIY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Majd Dibbiny <majd@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 0/3] Global per-type support for QP counters
Date:   Thu,  2 Jul 2020 11:29:30 +0300
Message-Id: <20200702082933.424537-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This series from Mark extends netlink interface to allow automatic
binding of QP counters based on their type, in very similar manner
to already existing per-PID ability.

Thanks

Mark Zhang (3):
  RDMA/counter: Add PID category support in auto mode
  RDMA/counter: Only bind user QPs in auto mode
  RDMA/counter: Allow manually bind QPs with different pids to same
    counter

 drivers/infiniband/core/counters.c | 24 +++++++-----------------
 drivers/infiniband/core/nldev.c    |  8 ++++++--
 include/uapi/rdma/rdma_netlink.h   |  1 +
 3 files changed, 14 insertions(+), 19 deletions(-)

--
2.26.2

