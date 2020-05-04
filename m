Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3955D1C3C07
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 16:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEDOCK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 10:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgEDOCK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 10:02:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD074C061A0F
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 07:02:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so2200885wro.12
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=RgbKZmFqtSSkJM6d+r5UTD3fUFXVDRnzQp23TIXzDrRGHn5MpNGi72hvI3l3ubk9pe
         FkVK54x9z/STdAe3z3T2RGXOK1JThD/mhEipCgwbbxX3xuyqDMg9qTbenKhqEkavm0Hz
         VOUTt3Ui/eDvBcnYlmUbAA97xMmIDY0U+Fh2bVom6M+z7pld8bCI5DiPNB7LWx1d1O35
         jwOH1fF9gaeiQMyVcJ1nWVkoAUHZS7wz/ioPvBbOv18aVUPRdK7ymn2VwgkXYNwrhnI9
         u2BdUhEB8cwuuqiLdsR5IOIEcW/XFoH3zhXHWijX5IZYugEMFc18JHAPKbZYktY4XAb+
         qWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=e1NIzMubAGcB21lZ4Oz3e0piA84obc4EG6muw6GJu1DIJ1oxO0VKdgmlARfZvheDys
         XuRnrq1XKeh2Bd4+yQ9bwH3VWG5iaY7Gp0mRWRDuzrk1Bf9ZwKEOrC5k59yKWqszsYpJ
         VieKmraRUz2U5byBcrvM/CmMKFh+ocKCHzdAg9A9JZsH+iZ48vABL+uxDFYKQwUwEVEX
         7qI3AYfIGhWQL5xSz9i9d/Nq+plm6vU7DSJYQZ+OalKkaxPVfzV64YIvoEolGMnZp3rF
         46zVN/aHmUrx935lHnYZ1tIVB1HY5fkFiq4VBq8GLkV1GifMz1eTm5iddOaxj4sLezys
         aVjg==
X-Gm-Message-State: AGi0PuZP9+/OhpvJxdVBhq5CqRGL9D/wtT3B57dWbE4/2D1UagZESLyb
        ElHyDtDxH6nbm5BT6IHZsogc
X-Google-Smtp-Source: APiQypLy9fsA3AOlD+aQ20szdOWFOF/kGVFQDk3EbxnFYMWKjeA+eqFf8HoQV1dGqKGEP3dmF9UdKw==
X-Received: by 2002:adf:bb84:: with SMTP id q4mr18473359wrg.141.1588600927121;
        Mon, 04 May 2020 07:02:07 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:06 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v14 01/25] sysfs: export sysfs_remove_file_self()
Date:   Mon,  4 May 2020 16:00:51 +0200
Message-Id: <20200504140115.15533-2-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

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
index 26bbf960e2a2..d81f9f974a35 100644
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
2.20.1

