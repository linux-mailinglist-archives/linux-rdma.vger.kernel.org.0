Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29DBE184C94
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 17:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCMQdq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 12:33:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41411 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMQdq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 12:33:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so4496469plr.8
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mDviUkJKfVVqxdYCADiTLGumJyFHa/+aS4eSULi6pmg=;
        b=WaS4P+1Bk0daGzTu92Z3N/pz/ss4b/Evl//bkAVmc7hsB+a57PVUuQwPmeQWmWsbQY
         BBZaJdlWqg8ME1zlloSaCk8iMqLhfS0Wh0ZleQhcjQyP+SbiZzBVwMWcYuQuIZdBpy85
         IeX5e3+f3Ukom3RTdLepu85v4k4qi4GQ4UkgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mDviUkJKfVVqxdYCADiTLGumJyFHa/+aS4eSULi6pmg=;
        b=J4UaGrjq1JpAMy2vtbk0U11ladujzebIrnv6owwfTM1t/ozXdcyDgyqoE0+VpDOTlW
         NrM6aMbtIPEnAT6zSWSDE8lxXfaOQHgGJFMbC3dtu4GcBrLhL6xZ7JQUCsHeZIZ/AH+M
         WiBg18E6mXIjQDyyrVxigdw+HpoQvoHYDQ3Wmp/4JrFNYITAKl+sa7Mtv2olO5B0uEnZ
         GmEUCkMMGyNyYmLDdlAxdzOV/s3H1lNFvVdQiD2017XXowEuIY2s2jRv4xwzmDv6UvAN
         6d+nJVlQS5dXoJEjJI6WzvprpgLymCQzm1OBje+6tl2Ft5Ao9YO5IJxOUi32K3VJwm0G
         3pWA==
X-Gm-Message-State: ANhLgQ0ckkx/1Epv7WBRNL/OeoSeyCi77QT5WH3K8EznmMD7HXkMyPlb
        Vdfq0UNJrSTdYWxU//kU43ZJFA==
X-Google-Smtp-Source: ADFU+vtYEg+LOvIoc8P9xNmxLozV3VST2h3eD06fOoTdQf4FR/H0IHiMNglYVOpwMBclC4Tvj7siFA==
X-Received: by 2002:a17:902:fe83:: with SMTP id x3mr14282016plm.310.1584117225298;
        Fri, 13 Mar 2020 09:33:45 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id v5sm2338344pjn.2.2020.03.13.09.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 09:33:44 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-next 2/3] RDMA/bnxt_re: Fix lifetimes in bnxt_re_task
Date:   Fri, 13 Mar 2020 09:33:26 -0700
Message-Id: <1584117207-2664-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1584117207-2664-1-git-send-email-selvin.xavier@broadcom.com>
References: <1584117207-2664-1-git-send-email-selvin.xavier@broadcom.com>
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
index 885127c..c494e11 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1670,6 +1670,7 @@ static void bnxt_re_task(struct work_struct *work)
 	smp_mb__before_atomic();
 	atomic_dec(&rdev->sched_count);
 exit:
+	put_device(&rdev->ibdev.dev);
 	kfree(re_work);
 }
 
@@ -1735,6 +1736,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		/* Allocate for the deferred task */
 		re_work = kzalloc(sizeof(*re_work), GFP_ATOMIC);
 		if (re_work) {
+			get_device(&rdev->ibdev.dev);
 			re_work->rdev = rdev;
 			re_work->event = event;
 			re_work->vlan_dev = (real_dev == netdev ?
-- 
2.5.5

