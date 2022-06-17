Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D854F613
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jun 2022 13:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381593AbiFQLBl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jun 2022 07:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiFQLBk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Jun 2022 07:01:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D026C0DF;
        Fri, 17 Jun 2022 04:01:37 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPbfJ20Xgz6H6l9;
        Fri, 17 Jun 2022 18:59:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 13:01:34 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 12:01:30 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <hch@lst.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
        <sebaddel@cisco.com>, <kartilak@cisco.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <mpi3mr-linuxdrv.pdl@broadcom.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] blk-mq: Add a flag for reserved requests series
Date:   Fri, 17 Jun 2022 18:55:15 +0800
Message-ID: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In [0] I included "blk-mq: Add a flag for reserved requests" to identify
if a request is 'reserved' for special handling. Doing this is easier than
passing a 'reserved' arg to the blk_mq_ops callbacks. Indeed, only 1x
timeout implementation or blk-mq iter function actually uses the
'reserved' arg (or 3x if you count SCSI core and FNIC SCSI driver). So
this series drops the 'reserved' arg for these timeout and iter functions.
Christoph suggested that I try to upstream now.

About the SCSI changes, I can leave them in place if people prefer.

Based on following:
c13794dbe936 (block/for-5.20/block) block: Directly use ida_alloc()/free()

[0] https://lore.kernel.org/linux-scsi/1654770559-101375-1-git-send-email-john.garry@huawei.com/T/#m22aa9f89e55835edc2e650d43f7e3219a3a1a324

John Garry (5):
  scsi: core: Remove reserved request time-out handling
  blk-mq: Add a flag for reserved requests
  blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
  scsi: fnic: Drop reserved request handling
  blk-mq: Drop 'reserved' member of busy_tag_iter_fn

 block/blk-mq-debugfs.c              |  2 +-
 block/blk-mq-tag.c                  | 13 +++++--------
 block/blk-mq.c                      | 22 +++++++++++++---------
 block/bsg-lib.c                     |  2 +-
 drivers/block/mtip32xx/mtip32xx.c   | 11 +++++------
 drivers/block/nbd.c                 |  5 ++---
 drivers/block/null_blk/main.c       |  2 +-
 drivers/infiniband/ulp/srp/ib_srp.c |  3 +--
 drivers/mmc/core/queue.c            |  3 +--
 drivers/nvme/host/apple.c           |  3 +--
 drivers/nvme/host/core.c            |  2 +-
 drivers/nvme/host/fc.c              |  6 ++----
 drivers/nvme/host/nvme.h            |  2 +-
 drivers/nvme/host/pci.c             |  2 +-
 drivers/nvme/host/rdma.c            |  3 +--
 drivers/nvme/host/tcp.c             |  3 +--
 drivers/s390/block/dasd.c           |  2 +-
 drivers/s390/block/dasd_int.h       |  2 +-
 drivers/scsi/aacraid/comminit.c     |  2 +-
 drivers/scsi/aacraid/linit.c        |  2 +-
 drivers/scsi/fnic/fnic_scsi.c       | 14 ++++----------
 drivers/scsi/hosts.c                | 14 ++++++--------
 drivers/scsi/mpi3mr/mpi3mr_os.c     | 16 ++++------------
 drivers/scsi/scsi_lib.c             | 12 ++----------
 include/linux/blk-mq.h              | 10 ++++++++--
 include/scsi/scsi_host.h            |  2 +-
 26 files changed, 67 insertions(+), 93 deletions(-)

-- 
2.35.3

