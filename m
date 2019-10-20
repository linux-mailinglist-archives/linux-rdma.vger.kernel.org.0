Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53044DDD23
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfJTHQF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 03:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJTHQF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 03:16:05 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B94D921744;
        Sun, 20 Oct 2019 07:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571555764;
        bh=lZKO8/rrDNjNFY+eGP7R8bBlBvd+P+Qa9j53eiVznag=;
        h=From:To:Cc:Subject:Date:From;
        b=FSNcHcMW6hSKRs2vnqBF90SNSnFaJjrewNIl2X7xke9qUHJ/kXt4rWEzM7a0m9lbU
         i4xt+eSBNbj1IUKFrJ9aToAXMmuOvXkwvMm0G+ZvFkYOgaqv2vrFr59UQ5N/bsMFu3
         yJTZZkNf6U4rArZDu+0pW1RMF+oUoY1YBxPCzQRs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH rdma-next 0/6] CM cleanup
Date:   Sun, 20 Oct 2019 10:15:53 +0300
Message-Id: <20191020071559.9743-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is first part of CM cleanup series needed to effectively
add IBTA Enhanced Connection Establishment (ECE) spec changes.

In this series, we don't do anything major, just small code cleanup
with small change in srpt. This change will allow us to provide
general getter and setter for all CM structures.

Thanks

Leon Romanovsky (6):
  RDMA/cm: Delete unused cm_is_active_peer function
  RDMA/cm: Use specific keyword to check define
  RDMA/cm: Update copyright together with SPDX tag
  RDMA/cm: Delete useless QPN masking
  RDMA/cm: Provide private data size to CM users
  RDMA/srpt: Use private_data_len instead of hardcoded value

 drivers/infiniband/core/cm.c          | 51 ++++++++-------------------
 drivers/infiniband/core/cm_msgs.h     | 32 ++---------------
 drivers/infiniband/core/cma.c         | 31 ++--------------
 drivers/infiniband/ulp/srpt/ib_srpt.c |  2 +-
 include/rdma/ib_cm.h                  | 33 +++--------------
 5 files changed, 24 insertions(+), 125 deletions(-)

--
2.20.1

