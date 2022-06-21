Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B65530B5
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jun 2022 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349421AbiFULWc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jun 2022 07:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349157AbiFULWZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jun 2022 07:22:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CF92A274;
        Tue, 21 Jun 2022 04:22:24 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LS3sz4NJLz68778;
        Tue, 21 Jun 2022 19:18:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 13:22:22 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 12:22:17 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <hch@lst.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
        <sebaddel@cisco.com>, <kartilak@cisco.com>
CC:     <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <mpi3mr-linuxdrv.pdl@broadcom.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nbd@other.debian.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 4/6] scsi: fnic: Drop reserved request handling
Date:   Tue, 21 Jun 2022 19:15:41 +0800
Message-ID: <1655810143-67784-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
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

The SCSI core code does not support reserved requests, so drop the
handling in fnic_pending_aborts_iter().

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/fnic/fnic_scsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 3d64877bda8d..e7b7f6d73429 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -2019,8 +2019,6 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc,
 
 	if (sc == iter_data->lr_sc || sc->device != lun_dev)
 		return true;
-	if (reserved)
-		return true;
 
 	io_lock = fnic_io_lock_tag(fnic, abt_tag);
 	spin_lock_irqsave(io_lock, flags);
-- 
2.25.1

