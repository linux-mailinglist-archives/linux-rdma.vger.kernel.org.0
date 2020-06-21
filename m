Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089EA202A14
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 12:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgFUKlP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 06:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgFUKlP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 06:41:15 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B662242C;
        Sun, 21 Jun 2020 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592736075;
        bh=BjOf4cqYAWG07YO8m+pgR/OCZcLF4SQkA40ddi8/TwM=;
        h=From:To:Cc:Subject:Date:From;
        b=ujQH0etsNkuF9+a2axrbnFbI4HhdZ+08sqMXqglWfHqKkrJ8xAnir10bj4rnd9eVJ
         rm2PDhUtxjB0Q8SobkI+iCsd3+yrFMXT6afBUCONDN8tbvEUk2ZGvHEh+4x2T4CdRo
         C0BXackgKWqbZGUpaXaBDR0AynQuVMHypdO5tMxI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 0/2] Convert XRC to use xarray
Date:   Sun, 21 Jun 2020 13:41:08 +0300
Message-Id: <20200621104110.53509-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Two small patches to simplify and improve XRC logic.

Maor Gottlieb (2):
  RDMA: Clean ib_alloc_xrcd() and reuse it to allocate XRC domain
  RDMA/core: Optimize XRC target lookup

 drivers/infiniband/core/uverbs_cmd.c | 12 ++---
 drivers/infiniband/core/verbs.c      | 69 ++++++++++++++--------------
 drivers/infiniband/hw/mlx5/main.c    | 24 ++++------
 include/rdma/ib_verbs.h              | 27 +++++------
 4 files changed, 60 insertions(+), 72 deletions(-)

--
2.26.2

