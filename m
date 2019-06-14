Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2787450C7
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfFNAiX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:38:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46121 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfFNAiX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:38:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id x18so590514qkn.13
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2T1/SHYBY/tmx3QFdG/Forox7sg04HzY951uGym0cng=;
        b=Dj++BcaEPIPLyqBDNisnTQOxDqE0ZrtUpTktnPPNLtoqM00HA6kGsl0FgKuMwJbaJ7
         nLuvGDzPA5FPBNvTk7xAUJeHH0CE0isD40ifGSwKZhdqIaTepdZMjOnzvlVLMZ05/XUZ
         /kX2wQ0HTLOacoXHhWBc/AWLdRQtq3vct6UAQs6npQpyrtwVO9wCK1VeYMWdokl1IdiS
         87wQI40rbQi74/CJ38qNGfLiWNqIqEvaws5Q5mna7F1zzkt0zI+lladkhWx8mFq0w1yM
         KhcwS0YxGezZ0TgnSZpxBmAe/13b81W4YyUdorl81xJVMDaTQ1AhAc/eNquIj3ic4V4i
         rd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2T1/SHYBY/tmx3QFdG/Forox7sg04HzY951uGym0cng=;
        b=IptPnKuQonCEwcFA3hdRslBvtXW+34JQ/9nr6iUq9df1BMELShEe3enoDzHP0YaoYT
         BBK3lFaLZCFNogjz+L5CWxKWg/V4TgvO7s5lB95RjjwPxQ3nZed8X9ufMqPitNgeQmA6
         172K0xfylcjqPRQdwUZ7/TBEXzjPjTbx/bNCPBUpTfZCxU/YikRcfm6qUguJ7e+YmOk/
         fFJloa1Zo1qpzLSqLu/gBttNVT/0BRsRERvdJtb6kq+kYqLTPUxdj/5veWghoUhr32Xl
         yj3uALNVMysLhx2wQQN/tlio4l2zs9bZvB+4h+g/kiG/NBlBJRi/VtHcFSRAQwmO8+tb
         x0iA==
X-Gm-Message-State: APjAAAWxqgNSpKhE8UwlEcBY7WaH4QSyr6Z+gjlkdrqxCE8t3LXfhGLa
        OIcjZzCYGm3y3++VvH1PrY9ffQJsjYMsgA==
X-Google-Smtp-Source: APXvYqzMKC0xS6zPWfXRrvQbyFvJOZtThWYMQR4GQ16RMVydQ35TsAGANdNdpCDsVHWzzcMh5TfVyg==
X-Received: by 2002:a37:9f12:: with SMTP id i18mr22896353qke.111.1560472701856;
        Thu, 13 Jun 2019 17:38:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i17sm608693qkl.71.2019.06.13.17.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:38:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaEW-0005Du-VC; Thu, 13 Jun 2019 21:38:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 0/3] Add RDMA_NLDEV_GET_CHARDEV
Date:   Thu, 13 Jun 2019 21:38:16 -0300
Message-Id: <20190614003819.19974-1-jgg@ziepe.ca>
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

v2:
- Document some of the netlink types (Leon)
- Split the client list scan into two functions (Leon/Doug)
- Rebase the userspace

Jason Gunthorpe (3):
  RDMA: Move rdma_node_type to uapi/
  RDMA: Add NLDEV_GET_CHARDEV to allow char dev discovery and autoload
  RDMA: Report available cdevs through RDMA_NLDEV_CMD_GET_CHARDEV

 drivers/infiniband/core/core_priv.h          |   9 ++
 drivers/infiniband/core/device.c             | 101 +++++++++++++++++++
 drivers/infiniband/core/nldev.c              |  91 +++++++++++++++++
 drivers/infiniband/core/ucma.c               |  23 +++++
 drivers/infiniband/core/user_mad.c           |  51 +++++++++-
 drivers/infiniband/core/uverbs_main.c        |  32 +++++-
 drivers/infiniband/core/verbs.c              |   2 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c  |   1 +
 drivers/infiniband/hw/hns/hns_roce_main.c    |   1 +
 drivers/infiniband/hw/mthca/mthca_provider.c |   1 +
 include/rdma/ib_verbs.h                      |  18 ++--
 include/rdma/rdma_netlink.h                  |   2 +
 include/uapi/rdma/rdma_netlink.h             |  27 +++++
 13 files changed, 341 insertions(+), 18 deletions(-)

-- 
2.21.0

