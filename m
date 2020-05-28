Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479071E5412
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 04:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgE1Ckq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 22:40:46 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58384 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgE1Ckp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 22:40:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49XX4X5C0Dz9vBsJ
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2020 02:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3MO5_r8ceMVL for <linux-rdma@vger.kernel.org>;
        Wed, 27 May 2020 21:40:44 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49XX4X3NZPz9vBqs
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 21:40:44 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49XX4X3NZPz9vBqs
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49XX4X3NZPz9vBqs
Received: by mail-io1-f69.google.com with SMTP id y14so120802ion.11
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ybVEX7PSlMurjHo6h6uiVHqa++JM7m3HwUct2YUWqzM=;
        b=gzewTqIVazU1WNimvBAOHsLzFc0bwR6EBq5xTei1B+uAPHqyQ+nIEF/YSGY2JryaP+
         Lt6o5dL9xAZ1b2yla2W5ztcHf4m/lD4CKyZZr5DXSO50A3kvXjTOMnfLWC8QeL0vPeym
         AMl6L3zqkLKRLmQ6ZrwEZuI2OtgWkHN00ra2QRF/h+cnFofLeGZt3kxRisTms7qbi2UT
         CYdQanA1MyQ6aWSPP5orgCr8GWhWhEsejiQFErQBHfiJzJAWzk46huyex0iZWbkYk3Zo
         QglLBRQqHw8HJGt+/YQYlOe/9tWPwvlI/B/D5Kw/ufxGdVZmAzYoQjW7MlCD5hXm3KFq
         rZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ybVEX7PSlMurjHo6h6uiVHqa++JM7m3HwUct2YUWqzM=;
        b=TXP4azQdFkyq52IQFgVW036I7516dR1PQjYzH8kjuSy1kIEkgZaFxNX6of4TtJp+D5
         n3N6v+I95ndMPPOXhF+Y0VTbACBGfgFlptSYIxvPaD3wrkWhtJbKiyuF/4Dxevjcbi+w
         ycAC5NSiplnLa6Q5+Ou7dI94SHz/CbquA5vz/rbhkZNyWkzRK2ppxcMymIsLqkYjxnsc
         h1zE7+3t/11ex+G5BbY2tXAPfnj7JVVoKUmn1sKeNZ6v0zTPgoT+B8rd88RBR64DaMes
         tgQiU2bDd3EoGK57lCW79AHGBOcysfotFgMx9siduRLK4mWgCpNTCoOaCheE9FR7Qd7I
         wR0g==
X-Gm-Message-State: AOAM53062F7sNt62jcwObmzxROgo3KMM3pntsr4npJ4LwqVTlyjUnumJ
        ima+AWcmDQGwIc7v3syQj6RJt16mcRcUcQbOT1jdWhU5PQ7uo8d5b/yPEjVKf/NVLuk0Yj6Rcwa
        gsNG0T4zSp7tVlKY4qr1u81OErg==
X-Received: by 2002:a92:d88c:: with SMTP id e12mr1109342iln.197.1590633643988;
        Wed, 27 May 2020 19:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY40R37MXlyClg6t19b+U+/ZakWhvOYEAiamlxkpTsbI/OPuZaKCgHJmDVcbcLC7/lG/Y6Ag==
X-Received: by 2002:a92:d88c:: with SMTP id e12mr1109332iln.197.1590633643669;
        Wed, 27 May 2020 19:40:43 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id n17sm2119172ili.1.2020.05.27.19.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:40:42 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/qib: Fix several reference count leak qib_create_port_files
Date:   Wed, 27 May 2020 21:40:36 -0500
Message-Id: <20200528024037.6611-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. To fix these
issues, we correct the jump targets when the calls of
kobject_init_and_add() fail, to make sure they can be handled by
kobject_put(). Previous commit "b8eb718348b8" fixed a similar problem.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/infiniband/hw/qib/qib_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 568b21eb6ea1..017ed82070f9 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -760,7 +760,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8 port_num,
 		qib_dev_err(dd,
 			"Skipping linkcontrol sysfs info, (err %d) port %u\n",
 			ret, port_num);
-		goto bail;
+		goto bail_link;
 	}
 	kobject_uevent(&ppd->pport_kobj, KOBJ_ADD);
 
@@ -770,7 +770,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8 port_num,
 		qib_dev_err(dd,
 			"Skipping sl2vl sysfs info, (err %d) port %u\n",
 			ret, port_num);
-		goto bail_link;
+		goto bail_sl;
 	}
 	kobject_uevent(&ppd->sl2vl_kobj, KOBJ_ADD);
 
@@ -780,7 +780,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8 port_num,
 		qib_dev_err(dd,
 			"Skipping diag_counters sysfs info, (err %d) port %u\n",
 			ret, port_num);
-		goto bail_sl;
+		goto bail_diagc;
 	}
 	kobject_uevent(&ppd->diagc_kobj, KOBJ_ADD);
 
@@ -793,7 +793,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8 port_num,
 		qib_dev_err(dd,
 		 "Skipping Congestion Control sysfs info, (err %d) port %u\n",
 		 ret, port_num);
-		goto bail_diagc;
+		goto bail_cc;
 	}
 
 	kobject_uevent(&ppd->pport_cc_kobj, KOBJ_ADD);
-- 
2.17.1

