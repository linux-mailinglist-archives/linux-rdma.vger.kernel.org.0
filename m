Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7525718CD90
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 13:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCTMRF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 08:17:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53892 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgCTMRF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 08:17:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so6257693wmk.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 05:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PE0xCP/YldjBqal9u3IvK3D+Ap2jsQmYbSPkKDPiuBs=;
        b=RURARdoHLWJhlcqA4PGUxmKsA1WnU1gjp4I5mVWAGQAbeCKachmWlTMSoW41HuGbBd
         iCAwWLW8PiQ0/DJa0mkuFubKgea+OGLg276aHzExdPgoGGkcCeApfhePSIxwa/DzHwXM
         2Iongtg4zecxgge+IaukJbm2vv/abTGBUXVFFoWogf3BQ0w8O4K4pk17meGbLINVFYRF
         ArWiFBKYbAWIfPxOYDUja9ZiSgiWw3D59QzOwq1UahQES0V3HedzOU8F+JhWtrVKGZQe
         9YkaZLHinV+JhHCYP2QwCCODJqSwk62RVmFS6PXRy89zcElurEyCfyp7Wm8652yrda6+
         7HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PE0xCP/YldjBqal9u3IvK3D+Ap2jsQmYbSPkKDPiuBs=;
        b=jIED5GtKFYHIFxP8GsY34Jswmew0uUPA7pSiIRcYkxzFOkSbIqVwUaJ/9hX3QzQWFi
         JlxUbFTqfIQpbm++vFY8agdZ9bYDj8/arzwnMfI2uf2fjNQcYgCOienI2Wavmm9nEAyT
         N8l1UmROGVXuWsucMixH07L0HBT7RWKg/Me/PmbZTOqCCKw/7fwS2/hEhP003OliZRo5
         aiWezpAIxelwRG+9lZ0UFuU2BLWOqUc+6CzQ1/Gzn2mZzRlSHHaY1DELFRR9rh5dtOy4
         kTXPfja20rN5p+0PG7eLAxBDR2Mxrq4uGlBHEkCo2cClgn2tmMObou1agDHvZgUcQ/ui
         TjPA==
X-Gm-Message-State: ANhLgQ0oCFvqbkJdin6AL38ctmJU6nUGI6cVCvXxG+S1ZQlFlZA3NIu7
        vpLq9FniF5uJuxD1v6OWuQsEYQ==
X-Google-Smtp-Source: ADFU+vsKq9UcpprQpxnQcostRJ5qfoz+PKsDqa7VgD+MsrC/897xeeLqDSPaJNF8e5wXEbkbP2KqQw==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr9703226wmf.135.1584706622112;
        Fri, 20 Mar 2020 05:17:02 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:01 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 01/26] sysfs: export sysfs_remove_file_self()
Date:   Fri, 20 Mar 2020 13:16:32 +0100
Message-Id: <20200320121657.1165-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Function is going to be used in transport over RDMA module
in subsequent patches, so export it to GPL modules.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
[jwang: extend the commit message]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/sysfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 130fc6fbcc03..1ff4672d7746 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -492,6 +492,7 @@ bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr)
 	kernfs_put(kn);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sysfs_remove_file_self);
 
 void sysfs_remove_files(struct kobject *kobj, const struct attribute * const *ptr)
 {
-- 
2.17.1

