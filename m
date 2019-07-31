Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410017BB62
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 10:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfGaISs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 04:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfGaISs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 04:18:48 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 749DA20693;
        Wed, 31 Jul 2019 08:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564561127;
        bh=LQ0fflhZvW27rN1ekZB67P0w5K5owZL/TpKcqwdjeO4=;
        h=From:To:Cc:Subject:Date:From;
        b=iiFsU5QE3pNH/N3bo9AU7G3+2+J+GO1HSLTdYrAKIO+shTq3m/dKpCKtxyPVSsXWE
         PlmZmizn4tjpH5eVD08H2ibu4Zhvt9g+SJavl2/96HMEnCdpClm2SJ8osNgGRl8l8t
         8C6RVr1KuPeM+qVaIu0YfmFimM/CE+T46zrz5HA4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH rdma-rc 0/2] RDMA fixes for 5.3
Date:   Wed, 31 Jul 2019 11:18:39 +0300
Message-Id: <20190731081841.32345-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

Two lock fixes in device<->client interaction, please see
extensive commit messages for more details.

Thanks

Jason Gunthorpe (2):
  RDMA/devices: Do not deadlock during client removal
  RDMA/devices: Remove the lock around remove_client_context

 drivers/infiniband/core/device.c | 102 ++++++++++++++++++++-----------
 include/rdma/ib_verbs.h          |   4 +-
 2 files changed, 71 insertions(+), 35 deletions(-)

--
2.20.1

