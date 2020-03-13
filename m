Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7EE1846E8
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 13:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCMMb6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 08:31:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35055 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMb6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 08:31:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id m3so10101308wmi.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fZ06S74IYkYkRjrkuuFKendcHkbTRbvoDuSHTPbfnHE=;
        b=WYuLlkuI3IIxiGJKUeac/HUXInGwcuM36GCf45iCKeI43No31JWpqeZdcN8A3JvPOp
         eopHIvxrw0RUEtZy0Z6EFll5yJX5a8wHwyhxrz704K14PldCAW/KbMMnE4C2Q/NHt4MO
         u9zeoyK+H6x+AogwYjf+LRYehPAX8DP3/Wm4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fZ06S74IYkYkRjrkuuFKendcHkbTRbvoDuSHTPbfnHE=;
        b=OAVkB5w788Po7PboCn2WjwZce48iUxOKsDLYpLaKFIOxLkIduojCEaMHTLwfOwNs8C
         iG7kAW7aOvoeBTW/3TJbzMQ/FBOs1HcmPSK0AemQ9XD0OcPxAmzy5Y2jOp6vEUQv3GOz
         BEMsJfL4n/abM87dM6kIove8j+YmLNTI6K/vqDGWiqmzWAwz9N/kPQ6x1DfNJc0JkvYz
         bmgfaEp1SytgDmM10ysF1ydbI0nVJt7nouxb3BL0/XxTJ/ZCvtCXsMi8rOjDaH7R6s+J
         RwYTaq9Kn1WBD07sjS3EB4btspTPDx05m8utoulP+D7S7D490GMtAtmW6gSeIVj0tPuQ
         rjJw==
X-Gm-Message-State: ANhLgQ0J6LEyYVUNkRHkA5bbUw5gNLin1jGLP0gsuJlQT6LXnL2wkSGA
        nCvUQ+Yf9/wwbiBAwKRW/8MJcA==
X-Google-Smtp-Source: ADFU+vuT//SaJE53odHcCmi79PDGqsSJf4n9/swPjqxcuvAsoszHVXkzp84JUrdVsgo+rQRlbqX/MA==
X-Received: by 2002:a1c:2d4f:: with SMTP id t76mr10542312wmt.60.1584102716103;
        Fri, 13 Mar 2020 05:31:56 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g129sm18015910wmg.12.2020.03.13.05.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:31:55 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/3] RDMA/bnxt_re: Fix lifetimes in bnxt_re_task
Date:   Fri, 13 Mar 2020 05:31:33 -0700
Message-Id: <1584102694-32544-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1584102694-32544-1-git-send-email-selvin.xavier@broadcom.com>
References: <1584102694-32544-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

A work queue cannot just rely on the ib_device not being freed, it must
hold a kref on the memory so that the BNXT_RE_FLAG_IBDEV_REGISTERED check
works.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index d5019b3..82062d8 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1672,6 +1672,7 @@ static void bnxt_re_task(struct work_struct *work)
 	smp_mb__before_atomic();
 	atomic_dec(&rdev->sched_count);
 exit:
+	put_device(&rdev->ibdev.dev);
 	kfree(re_work);
 }
 
@@ -1737,6 +1738,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		/* Allocate for the deferred task */
 		re_work = kzalloc(sizeof(*re_work), GFP_ATOMIC);
 		if (re_work) {
+			get_device(&rdev->ibdev.dev);
 			re_work->rdev = rdev;
 			re_work->event = event;
 			re_work->vlan_dev = (real_dev == netdev ?
-- 
2.5.5

