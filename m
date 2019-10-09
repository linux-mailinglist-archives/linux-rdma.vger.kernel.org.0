Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58BD13AE
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfJIQKH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:07 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:45563 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbfJIQKH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:07 -0400
Received: by mail-qt1-f172.google.com with SMTP id c21so4133037qtj.12
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ylw+pWsGRvtErJySEOY12V4rr2uLBBjbBun3hNXDjcI=;
        b=Rgk8idfrsesGEbxv4e5Ccll/4uB0o6BGvMdegrTTEyxXQEZRmy/pkVcxdjY5RIRNT/
         iC5xEPqPMCR9UkB2tSRRCB0h4RM2YV8GqiDI+59lhhYUgjbDDs6HhsbM2atyqJTJSNdw
         BJuKfRgBFlzwGdjBYltzRdV3NijuxttN0DlyvCrBEBR3BEL8XUCydg4cbvzdFrJ8V847
         W3DCl+YmFt5Yfe9SvDsnb+JahXCFoDRRBLX5G1Vurk6QiVmSDNf3vVZPx0kvAXgfYfdE
         ZGkCMhpQYnyNFuMpDyQ6cuXaQWEbU8hXB5VnocZ1sLKRTW+fKYkbFr8TcvFFekOkF4UK
         D8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ylw+pWsGRvtErJySEOY12V4rr2uLBBjbBun3hNXDjcI=;
        b=n9jNdCEQG0fn0+4GG1G0Z3bCzfSHXs12kJQfqG3tpXaf2yPvZtMi3XLALBTwbp7eti
         LwtZtT/zx1gfhCvnwDI3+eC7IyFuDBIQuQZjODmmjHDQNwlvANvDEQ2ktrrIZcumdBKV
         dkOzTP+iiYWaLNsVQSsYjSqhY+sZAsBu02LC4jLWAjlAbXAUS//JxS5qjBKyCDbioa9x
         jXhtemAzaptltnz9ahpJYesO6aYIz2W10xhi/OH2PJ5ld/uffQRpSyRHsl4TpPrAChTe
         4YQx7H3N93C/Jyfsfo4i2ZcP3DNzm5VkeK1/CaiCoqCM/1XD3hwEmHR+JQkIC3hi96xH
         uDPA==
X-Gm-Message-State: APjAAAXhqa5VP00Mly3hAWvpfIZnCx6Ke8nAfmFOrtc7lODXf2FYTM94
        x54NNXfGJ3YMeDN9g/ZNXtRB0K5qFAY=
X-Google-Smtp-Source: APXvYqzJbFBCWKoiDwyPAZWHi9TLYc6oP39TKmoXXb5nQK0c2HCoVeK8ULNURfeQf3Ym1iTpTXmpsg==
X-Received: by 2002:ac8:fda:: with SMTP id f26mr4544851qtk.34.1570637405759;
        Wed, 09 Oct 2019 09:10:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g19sm1506619qtb.2.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXM-0000qC-K7; Wed, 09 Oct 2019 13:10:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 00/15] Rework the locking and datastructures for mlx5 implicit ODP
Date:   Wed,  9 Oct 2019 13:09:20 -0300
Message-Id: <20191009160934.3143-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

In order to hoist the interval tree code out of the drivers and into the
mmu_notifiers it is necessary for the drivers to not use the interval tree
for other things.

This series replaces the interval tree with an xarray and along the way
re-aligns all the locking to use a sensible SRCU model where the 'update'
step is done by modifying an xarray.

The result is overall much simpler and with less locking in the critical
path. Many functions were reworked for clarity and small details like
using 'imr' to refer to the implicit MR make the entire code flow here
more readable.

This also squashes at least two race bugs on its own, and quite possibily
more that haven't been identified.

Jason Gunthorpe (15):
  RDMA/mlx5: Use SRCU properly in ODP prefetch
  RDMA/mlx5: Split sig_err MR data into its own xarray
  RDMA/mlx5: Use a dedicated mkey xarray for ODP
  RDMA/mlx5: Delete struct mlx5_priv->mkey_table
  RDMA/mlx5: Rework implicit_mr_get_data
  RDMA/mlx5: Lift implicit_mr_alloc() into the two routines that call it
  RDMA/mlx5: Set the HW IOVA of the child MRs to their place in the tree
  RDMA/mlx5: Split implicit handling from pagefault_mr
  RDMA/mlx5: Use an xarray for the children of an implicit ODP
  RDMA/mlx5: Reduce locking in implicit_mr_get_data()
  RDMA/mlx5: Avoid double lookups on the pagefault path
  RDMA/mlx5: Rework implicit ODP destroy
  RDMA/mlx5: Do not store implicit children in the odp_mkeys xarray
  RDMA/mlx5: Do not race with mlx5_ib_invalidate_range during create and
    destroy
  RDMA/odp: Remove broken debugging call to invalidate_range

 drivers/infiniband/core/umem_odp.c            |  38 +-
 drivers/infiniband/hw/mlx5/cq.c               |  33 +-
 drivers/infiniband/hw/mlx5/devx.c             |   8 +-
 drivers/infiniband/hw/mlx5/main.c             |  17 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  22 +-
 drivers/infiniband/hw/mlx5/mr.c               | 139 ++-
 drivers/infiniband/hw/mlx5/odp.c              | 976 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/main.c    |   4 -
 drivers/net/ethernet/mellanox/mlx5/core/mr.c  |  28 +-
 include/linux/mlx5/driver.h                   |   4 -
 include/rdma/ib_umem_odp.h                    |  18 -
 11 files changed, 627 insertions(+), 660 deletions(-)

-- 
2.23.0

