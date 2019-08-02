Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E027F47C
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2019 12:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391209AbfHBJcX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Aug 2019 05:32:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33948 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391203AbfHBJcX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Aug 2019 05:32:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so76488878wrm.1
        for <linux-rdma@vger.kernel.org>; Fri, 02 Aug 2019 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/LSenS1bWdvoriWhcDksjc9f4pD9PoC8yGdy0BNtbk=;
        b=BeDr4pQ6whBW8wd0A/BKGOmgEwAojiUxt0Zfebit5gLDLvoFYQSSlIiVWouv/mVKXq
         Lkw6hb4dRsXB5QgA0OOg8VwRiFCkZv2LZOcOgJqT2Trr/6b5eRwVkFL0TCQHTfO6EyVN
         HvqYSodTDsoy/mOdtHgZ1RGxwJTNC/A3Vm/D/F5B5NU37LekosQdsldYxEfDlYotunWq
         4SUlaaNO7hR8xGGV5YYbb2dDYs3tx9lFjprrdlPqyIX+edzcdZNLKMXgUFV0ptIV3B69
         WV1vflDkhagpUVfV5/tZaGmWEedlF6GbQGUc6yqgtcF5QRWHN6kLPHKVCRgT2nqupHtF
         Qf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/LSenS1bWdvoriWhcDksjc9f4pD9PoC8yGdy0BNtbk=;
        b=c8meGEPySaRtML2fNca9gVQoTlAmz2JbRaoD/8U1kyETooZR+awBd+9NMpSjc3atEN
         UwzqCaLyKbmNT4afTuAs8teohuiBKsoLCryvmKDra+0xYMvQygMsUuw+hvDi2zD0DNlZ
         Q0ETXqr+sNdQ9vn2DOQvbWQIqyN/EU2avhqucozpQQOO3KP6A0gCuuiT7tYqsNMhQhzr
         uP/g2+O+dKASdAOW67Lzs46rIASh+XYT1iuvxHGty3gmpxj/+BPDK5kDFAny3Z1GCXSB
         3b7idgjfhmPRtYPDdvrVu6VkKNLSSgjnY9JwdVxweC/APulxK8ZnHH5+rOrJFBj/CK/y
         nd+w==
X-Gm-Message-State: APjAAAUy4FkdWJA6NPqRiHfeKC09YAQWHii/vfKJhBfrKN2V5h5kaLE6
        M2ilBJP5md6dJX/dyLCWMeIw/PHT
X-Google-Smtp-Source: APXvYqxq5uJJVCJ8wUBffvb0B3fM8+v9hxpkxHHeMUZiQb5fnZLcOjT9gMHQUgpmkuM8OLVzuY1IhQ==
X-Received: by 2002:adf:e4c6:: with SMTP id v6mr139194933wrm.315.1564738341300;
        Fri, 02 Aug 2019 02:32:21 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id w23sm80651404wmi.45.2019.08.02.02.32.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:32:20 -0700 (PDT)
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
        Andrew Boyer <aboyer@tobark.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next V3 0/4] RDMA: Cleanups and improvements
Date:   Fri,  2 Aug 2019 12:32:06 +0300
Message-Id: <20190802093210.5705-1-kamalheib1@gmail.com>
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

Changes from v2:
- Patch #1:
-- Update mlx4 and hns to use the new ib_port_phys_state enum.
- Patch #3:
-- Use rdma_protocol_iwarp() instead of rdma_node_get_transport().

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
 drivers/infiniband/hw/hns/hns_roce_device.h  | 10 ---
 drivers/infiniband/hw/hns/hns_roce_main.c    |  3 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 11 ---
 drivers/infiniband/hw/mlx4/main.c            |  3 +-
 drivers/infiniband/hw/mlx5/main.c            |  4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  4 +-
 drivers/infiniband/hw/qedr/verbs.c           |  4 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  7 +-
 drivers/infiniband/sw/rxe/rxe.h              |  4 -
 drivers/infiniband/sw/rxe/rxe_param.h        |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  6 +-
 drivers/infiniband/sw/siw/siw_verbs.c        |  3 +-
 include/rdma/ib_verbs.h                      | 10 +++
 19 files changed, 140 insertions(+), 117 deletions(-)

-- 
2.20.1

