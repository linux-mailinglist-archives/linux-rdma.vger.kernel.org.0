Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC07CE34
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 22:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfGaUZN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 16:25:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36101 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfGaUZM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 16:25:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so56877028wme.1
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhflY6KOgUYoZDp8KcUY34NuVXJP2j04Q+hUXCOeAGM=;
        b=KhEwJh8g8VuRBwmXWNavpYUMt0d4d/6qVE6hLP1OyHDa88o6ydNtivxNH8t4wrsdix
         GYR7Ka3GCEkDuf5Zm7LeJQNu9gBTrM06orUHxtS2pzGEG+Yy6fub2tkXwRnfbLxonj+2
         3RX+2oJ1lEWxGK1JvPwk031CareKIXazRWFWNVdiyfbQ1r1mU85tcJDbpvJGT2OS0NJf
         PthKk/DzGl/03Aw8jHP5PscBrPULWevxLvOsg+5NAOBf3soJ/MqE8v9r7xx5gMua7qwB
         ntp0qKAnD4CSs0S0kXZ2Tewkc7L3lRqaLekrnSLJV7JgfyZa2idb19GzL5+a/SXXxPHC
         /nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhflY6KOgUYoZDp8KcUY34NuVXJP2j04Q+hUXCOeAGM=;
        b=qmwSFrr2BrwvAM1gwhCYBQ94nFEeCEAsuDBZkmu342QdVgXY8TcaCdJsulXk+6/xk1
         b7Jb0jpCC9zn7qwQBMxaNvEF1hlV6srYfrx0dZ/8AQGb6zJg5VTgnoqEjpTBHjfVJvnN
         CUvo+tQSFMz8YuRzwwt+metdlJTIAgWc1rvjW6dxB2IwXBar4LSCSL6SKD4gvojcRLnS
         +NPoyxCCbzB98BY0Vpk4KUXzz6Ak/GsLruGNBqYv0k6jRZVqQMaC2oBFsxSuPmLG/+2D
         sWAA3oj1HrxB8dXcMm+sPlyd05pHmlCkaXhHkBZJTsxfs6nSKZdPPtKN+qtf7s2hNy6U
         zAjg==
X-Gm-Message-State: APjAAAWBapvC2MjRlFRecyDJbVnxykipi34YPOZ12zE93a1Yd2ak5qF1
        7IWNXAVANxUfMaqDC5FyOUWQ6CD9
X-Google-Smtp-Source: APXvYqxD9sP4zVtJ7eFYQnxocV1qtHo606gLluzoag3Htsu1q0GRDDUk+1vPodNSJaW+YKoy4b+ALg==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr69459173wmg.65.1564604710248;
        Wed, 31 Jul 2019 13:25:10 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id c4sm54496930wrt.86.2019.07.31.13.25.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 13:25:09 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next V2 0/4] RDMA: Cleanups and improvements
Date:   Wed, 31 Jul 2019 23:24:55 +0300
Message-Id: <20190731202459.19570-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series includes few cleanups and improvements, the first patch
introduce a new enum for describing the physical state values and use it
instead of using the magic numbers, patch 2-4 add support for a common
query port for iWARP drivers and remove the common code from the iWARP
drivers.

Changes from v1 :
- Patch #3:
-- Delete __ prefix.
-- Add missing dev_put(netdev);
-- Initilize gid to {}.
-- Return error code directly.

Kamal Heib (4):
  RDMA: Introduce ib_port_phys_state enum
  RDMA/cxgb3: Use ib_device_set_netdev()
  RDMA/core: Add common iWARP query port
  RDMA/{cxgb3, cxgb4, i40iw}: Remove common code

 drivers/infiniband/core/device.c             | 87 ++++++++++++++++----
 drivers/infiniband/core/sysfs.c              | 24 ++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c  | 45 +++++-----
 drivers/infiniband/hw/cxgb4/provider.c       | 24 ------
 drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 11 ---
 drivers/infiniband/hw/mlx5/main.c            |  4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  4 +-
 drivers/infiniband/hw/qedr/verbs.c           |  4 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  7 +-
 drivers/infiniband/sw/rxe/rxe.h              |  4 -
 drivers/infiniband/sw/rxe/rxe_param.h        |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  6 +-
 drivers/infiniband/sw/siw/siw_verbs.c        |  3 +-
 include/rdma/ib_verbs.h                      | 10 +++
 16 files changed, 136 insertions(+), 105 deletions(-)

-- 
2.20.1

