Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C68CE11C8E2
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfLLJMT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:12:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbfLLJMT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:12:19 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCAD2465A;
        Thu, 12 Dec 2019 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576141939;
        bh=R4l1q5GFdQUk2MrMMkjMHBDQ3F30Td8SWqJyonIioIg=;
        h=From:To:Cc:Subject:Date:From;
        b=tzQDwrlZHojsugkFrhOZ8CIreGTNXfDPXC43mDShJh32Ro/Bd5K++HIepcTvZi1mA
         b3RTYMXDP+sed4ZpemQ6swhgrAYbLxLRcFgF1HkJsKQczNQig9Mm66cw8TfWOqnqHQ
         N1zdhJ8Td1M8ipnzpqS44xnMtIXadEBdLzdYmtpM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eli Cohen <eli@mellanox.co.il>, Ido Kalir <idok@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Raed Salem <raeds@mellanox.com>
Subject: [PATCH rdma-rc 0/3] Fixes for 5.5
Date:   Thu, 12 Dec 2019 11:12:11 +0200
Message-Id: <20191212091214.315005-1-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

Three unrelated fixes packed together.

Thanks

Maor Gottlieb (1):
  IB/mlx5: Fix steering rule of drop and count

Mark Zhang (1):
  RDMA/counter: Prevent auto-binding a QP which are not tracked with res

Parav Pandit (1):
  IB/mlx4: Follow mirror sequence of device add during device removal

 drivers/infiniband/core/counters.c |  3 +++
 drivers/infiniband/hw/mlx4/main.c  |  9 +++++----
 drivers/infiniband/hw/mlx5/main.c  | 13 ++++++-------
 3 files changed, 14 insertions(+), 11 deletions(-)

--
2.20.1

