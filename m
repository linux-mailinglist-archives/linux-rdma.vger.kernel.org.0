Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C3CEE2E
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2019 23:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfJGVH7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Oct 2019 17:07:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55177 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGVH6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Oct 2019 17:07:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so900467wmp.4
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2019 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2CZP2FMn/BbNj7lJqYmzi6mz+XmO2mBuBcqedTcs5Q=;
        b=LN/Zh4jYenkA6lsMw00/cpBBB1GA7Y10+QdA8PxXTu+5lCPg3O0t65PvZuFB3OW0DI
         B6LFUkCmdcTEbWb/giC/A6CW6HI8TjzTvllsthBNvS+k70gW9kT27n8dDGsWwcIxHHaj
         HDyFgJvBpeE+6ec0KsUZsPLnWXd27zgoi/qCgUzsZSeX0z0asxOlug8kQf1cA7k61uWK
         8/RIA1601HZlmzyWKvigUwlwOmSgC0Dy/FSLKBeiQFtlOZN+t6Cy7+ejTKlW2vyskLSJ
         sHaWu5jg4S5yWt+ng3FuACQjeQLsXkDjRVAE7yUFEBqjRzndaAhRdDaAwQ/guE5mtJy/
         lOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2CZP2FMn/BbNj7lJqYmzi6mz+XmO2mBuBcqedTcs5Q=;
        b=pzNaNjMhdZxMORZZXj1oG+cJ13Yp9SYLwmfpAK9zcnTm4X5+dpeirGnozFBfGBoSFp
         8UHwrqYyp5/8+CukfVNFpTmatLV9lfp0Edi4gpuldMWalm2Qd28hXzkGyRz8fJH6Zdus
         9WpaOOqEqVHk0GLb/7J4B0Vpdjm+Pv3FDYYcuiJrAzjtu1VpVSXrDGZBpbKIjkcyl1uA
         gXLaYXox+0TfLc8tryB66ZtN98LmBTUZf/otUAQHmLwzZuxz32pp5gfeW+eRqYU+ZamX
         AYxj0ATbZXb69KSsN2S9W1oO6yZNQB3V7cZx4dIZnWdaye0AhpSd1CIDauSjLIDwAf3I
         BKKw==
X-Gm-Message-State: APjAAAX33IYY163m43CjAM/jIkz31mJZtCz1Q/3zUEdsoEKkIc98oDQ+
        bA6245KeUSOlzlq1ybwwSd7neA1g
X-Google-Smtp-Source: APXvYqxCSBA2TzD1sjk9XmSDVD7wxAe0iG/DS10QXaDjqNHeU5YQGTNSgb0Q6VJUau40IJ2u3LMeXQ==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr893840wmh.36.1570482475470;
        Mon, 07 Oct 2019 14:07:55 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id a2sm23001672wrt.45.2019.10.07.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 14:07:54 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/qedr: Fix reported firmware version
Date:   Tue,  8 Oct 2019 00:07:30 +0300
Message-Id: <20191007210730.7173-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove spaces from the reported firmware version string.
Actual value:
$ cat /sys/class/infiniband/qedr0/fw_ver
8. 37. 7. 0

Expected value:
$ cat /sys/class/infiniband/qedr0/fw_ver
8.37.7.0

Fixes: ec72fce401c6 ("qedr: Add support for RoCE HW init")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/qedr/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 5136b835e1ba..dc71b6e16a07 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -76,7 +76,7 @@ static void qedr_get_dev_fw_str(struct ib_device *ibdev, char *str)
 	struct qedr_dev *qedr = get_qedr_dev(ibdev);
 	u32 fw_ver = (u32)qedr->attr.fw_ver;
 
-	snprintf(str, IB_FW_VERSION_NAME_MAX, "%d. %d. %d. %d",
+	snprintf(str, IB_FW_VERSION_NAME_MAX, "%d.%d.%d.%d",
 		 (fw_ver >> 24) & 0xFF, (fw_ver >> 16) & 0xFF,
 		 (fw_ver >> 8) & 0xFF, fw_ver & 0xFF);
 }
-- 
2.20.1

