Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7384104ABF
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 07:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUGWs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 01:22:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46959 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKUGWs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Nov 2019 01:22:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so2826627wrs.13
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 22:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MM1ksQi3xrzRFKnnFVS1AWIpvA6hQ0ZeeyO3yxC1wLc=;
        b=UOUA0AIA/n2Hxfy7spmwLgTeRZ0aNXcmra03o6oY3ECsiGh7bSI6E7MxAQqGLp3xfh
         R/gtLjIKw73DERvfnz4fmHk6B5FBqg98EtPPxspd84ghxBqF9hXkibjne10obueTQDsW
         ZSsIKXdwvkshSNuRlNgl1IYA/nNOyjynG8bMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MM1ksQi3xrzRFKnnFVS1AWIpvA6hQ0ZeeyO3yxC1wLc=;
        b=p/qb1bq8pHTCtNirJ0XTHpP/pklsIQEJnriJZUr/RdfJifWqzA+1sEmOde2XE92AvR
         44v4MDbx+e3I5AYx65MiYeF5ZsgMrmoi+ONVlLiKJIZwHMdrBYiWTCjxcxFzxjv1/XN+
         HmYySNXAYYJwpVioEYEzXA26OvhOIKCBR6pJ5HeQ7+i88UVZFYEkuKR65EbQg/goei1u
         empw+MvidOMsEmsCJc6m2eu50RMmjaxmGqRbFm931g1Y2gyKS0Qa7nAJZzisK1sInlIf
         7TQb/SriZFjq4AOD6x50XtBNuHXa1Lx+IqH6rE4e4qSGox+pWT0E7jO05wXLP5+pp3vr
         w+lQ==
X-Gm-Message-State: APjAAAWYprsALnD/aUVJfO2s7T4DCktlj7L9HGBq2ojLaKojZlc9gUcB
        qduzukC2n4LguUNeUyQewrUihA==
X-Google-Smtp-Source: APXvYqwnZ03xgMqF+6DCAB32y4NQdsJyJctUXN6lu3FZFS7PYeJLc7QcaEd6dTE2AOWv4+gOdYnUgQ==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr8024197wrs.86.1574317366126;
        Wed, 20 Nov 2019 22:22:46 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y11sm76377wrq.12.2019.11.20.22.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 22:22:45 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V3 for-next 3/3] RDMA/bnxt_re: fix sparse warnings
Date:   Thu, 21 Nov 2019 01:22:23 -0500
Message-Id: <1574317343-23300-4-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574317343-23300-1-git-send-email-devesh.sharma@broadcom.com>
References: <1574317343-23300-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Making a change to fix following sparse warnings
 CHECK   drivers/infiniband/hw/bnxt_re/main.c
drivers/infiniband/hw/bnxt_re/main.c:1274:18: warning: cast from restricted __le16
drivers/infiniband/hw/bnxt_re/main.c:1275:18: warning: cast from restricted __le16
drivers/infiniband/hw/bnxt_re/main.c:1276:18: warning: cast from restricted __le16
drivers/infiniband/hw/bnxt_re/main.c:1277:21: warning: restricted __le16 degrades to integer

Fixes: 2b827ea1926b ("RDMA/bnxt_re: Query HWRM Interface version from FW")
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a2ac88e..e7e8a0f 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1291,10 +1291,10 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 		return;
 	}
 	rdev->qplib_ctx.hwrm_intf_ver =
-		(u64)resp.hwrm_intf_major << 48 |
-		(u64)resp.hwrm_intf_minor << 32 |
-		(u64)resp.hwrm_intf_build << 16 |
-		resp.hwrm_intf_patch;
+		(u64)le16_to_cpu(resp.hwrm_intf_major) << 48 |
+		(u64)le16_to_cpu(resp.hwrm_intf_minor) << 32 |
+		(u64)le16_to_cpu(resp.hwrm_intf_build) << 16 |
+		le16_to_cpu(resp.hwrm_intf_patch);
 }
 
 static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
-- 
1.8.3.1

