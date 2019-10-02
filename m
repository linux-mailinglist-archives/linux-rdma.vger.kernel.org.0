Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92BC88A4
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfJBMcv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 08:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfJBMcv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 08:32:51 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE8852133F;
        Wed,  2 Oct 2019 12:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570019570;
        bh=9JUbmWs2EbB4XAaxNInWcTcs0QUUk/S+EZqnBvJNGHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=TlcpSzXETrPhQ/i7X5XdanojRoazryQw5U9gccEQ97sR99Dg6Gkan+Df4CkgCF6yy
         GY/vwQaqNqaYflB30Ha6spDERNARQw/mZjYmXV6UynpFgCI3FEKAubaks9wMB2krUP
         cUBOXktuks3QdtsGbA1qKELahQKqxdF/RWDaq174=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 0/2] Remove PID namespaces support from restrack
Date:   Wed,  2 Oct 2019 15:32:43 +0300
Message-Id: <20191002123245.18153-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

Please see individual commit messages for more details.

Thanks

Leon Romanovsky (2):
  RDMA/restrack: Remove PID namespace support
  RDMA/core: Check that process is still alive before sending it to the
    users

 drivers/infiniband/core/counters.c | 28 ++++++++-----------
 drivers/infiniband/core/nldev.c    | 44 ++++++++++++++++--------------
 drivers/infiniband/core/restrack.c | 20 +-------------
 drivers/infiniband/core/restrack.h |  1 -
 4 files changed, 37 insertions(+), 56 deletions(-)

--
2.20.1

