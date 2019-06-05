Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883BC3635F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFESdB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 14:33:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43355 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfFESdA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 14:33:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id z24so12020242qtj.10
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRtV0mgpo7T2rKXmfCFo6tzDF0S3b1JUl1Rw1sAqsV4=;
        b=cOMrVFwHbMTtNZvT9IZqUp9nnAKHvNrbWnB36ZMuSw2l6K0L6fC592FN9l2Tup2mfA
         GdNBvKue0GI6wdneGJ79IX+GpWnUaYRpP3zuxoLz8xGfsu5D24JhSyT5OzNjet+VjqAq
         t81HPgn8AI3XeCSEVkum7cNXKorQbSrdkP8R/tTzViTFvo0YsEMuajffGDklWdpFiOE0
         PVYsv3d5L9wZGDvNtKkwd68+hmkd4x0om6B5TVXhM9xTqbSN0G8XsKJNHCHm9zr3H4jj
         PQIBAoGOLUxd7INearwIn5V+a1PEbdHULpXR9Fc7HAqFdVYDDt75VX4FuxjdTINhveoN
         WTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRtV0mgpo7T2rKXmfCFo6tzDF0S3b1JUl1Rw1sAqsV4=;
        b=bHKY96C7X+Ae3Tn8/cSbL1DGALPEc1GrsvDW9EYMhtydNzszNN2js0dJVuNkGvoulv
         nn5Qns4kyYd34w7FlgFmT60KUgvGP48MlAPdWSVA+YXHtKTSWNaKPL7cU4paQFF0DDw8
         dygJEqqWv+ly46mKJTavS/f6TdeoTD/we8GOJAJw7W+Hj0Dt7XSTOMP5QM9sLzIH3Nko
         nPtiukNH5hy45kmewO/yEehUAPxZOe9zrXB2M2OBx3m+yv1IE9RdbS86CDuJc+hE6LAa
         b4i0pEktOkxiYp0mAeu0AWaLmsJoaO4bUUsacLXn8dw3lkDWR/4GT7JI30AM0y45eYnS
         BbvA==
X-Gm-Message-State: APjAAAXDeuq67WpRtDu4kx6Ltc4NW/qhezLPYvmKo+Ng1JuHiHE9S6NU
        2kqgaudAeplEB8giuLGLHH73jk+mi25g2g==
X-Google-Smtp-Source: APXvYqyGrctUDjSEmqtq+Bhjczzb/ZyM0GyFgf+1dgEJVPeeg5UDEHOxxBm3Z7i6NrCf8C9SDZPCYA==
X-Received: by 2002:ac8:2537:: with SMTP id 52mr36007428qtm.5.1559759578279;
        Wed, 05 Jun 2019 11:32:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e63sm10746702qkd.57.2019.06.05.11.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 11:32:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYaiX-0001q1-8i; Wed, 05 Jun 2019 15:32:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 0/3] Add RDMA_NLDEV_GET_CHARDEV
Date:   Wed,  5 Jun 2019 15:32:49 -0300
Message-Id: <20190605183252.6687-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This allows userspace to ask the kernel for information on a specific char
device implemented under the RDMA subsytem. For instance the kernel can ask
for details on the uverbs0 chardev related to the mlx5_0 device.

The resulting information is enough for libibverbs/etc to connect to the
device without having to rely on sysfs.

By using netlink this also supports automatic module loading. When userspace
requests for a chardev that is not yet loaded, the kernel will load it, bind
it to the device, and then return back.

For uverbs the DRIVER_ID is returned in the GET_CHARDEV response. This allows
libibverbs to bind drivers by ID instead of using modalias, or worse, the
device name. This also fixes the problem where siw and rxe devices cannot be
renamed.

Only three drivers do not support this mechanism because their probe in
userspace is too complicated (hns, mthca, cxgb3). As only hns is a current
product, it should be revised to support DRIVER_ID matching.

While the kernel side is fairly simple, the userspace is big and needs some
more time to test:

https://github.com/linux-rdma/rdma-core/pull/539

Jason Gunthorpe (3):
  RDMA: Move rdma_node_type to uapi/
  RDMA: Add NLDEV_GET_CHARDEV to allow char dev discovery and autoload
  RDMA: Report available cdevs through RDMA_NLDEV_CMD_GET_CHARDEV

 drivers/infiniband/core/core_priv.h          |  9 ++
 drivers/infiniband/core/device.c             | 91 ++++++++++++++++++++
 drivers/infiniband/core/nldev.c              | 91 ++++++++++++++++++++
 drivers/infiniband/core/ucma.c               | 23 +++++
 drivers/infiniband/core/user_mad.c           | 51 ++++++++++-
 drivers/infiniband/core/uverbs_main.c        | 32 ++++++-
 drivers/infiniband/core/verbs.c              |  2 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c  |  1 +
 drivers/infiniband/hw/hns/hns_roce_main.c    |  1 +
 drivers/infiniband/hw/mthca/mthca_provider.c |  1 +
 include/rdma/ib_verbs.h                      | 18 ++--
 include/rdma/rdma_netlink.h                  |  2 +
 include/uapi/rdma/rdma_netlink.h             | 23 +++++
 13 files changed, 327 insertions(+), 18 deletions(-)

-- 
2.21.0

