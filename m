Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24542DD2D4
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgLQOUD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgLQOUC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:02 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5136CC061282
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:22 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id 6so23453478ejz.5
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9TWG8KQ8txS78V+DUzYfWia1D89TVANkKX4YMXo1ZM=;
        b=Zq7bH1Tu00GDsCk0aXQJItNIGk52iM0sSW1YQ0LBgHH846FR/l6QcbE8pDAafTUUKl
         8GZdBfXw+M+/29Oneo09NjOVjgunygKh5XTtZeZL2AYa//8vd9bHDSWssK20Kt9py9tu
         zzVgKrYkX1wEYfyawKtiD6+F+P2bj8GL2huKMddqfHmcijQw9AvBaa9mBXSj0Ly6fjIZ
         oztmY75VoCuQ/iP6qG5xE7UXOHGHcVxrcwJJKztTR8W9+CFs3S6yIeGkTxTPCpUDEpst
         s3hsJwzEysiQCovr1nrd5clirJSvn1FUaKCVqSwduezWp2lluF3KdqXakMWuvMIUyhLF
         +h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9TWG8KQ8txS78V+DUzYfWia1D89TVANkKX4YMXo1ZM=;
        b=j/dV8xpsr2iGv6qiyHTlO876zeBN69RMUQlYznxWg/2Et6Wt4z8cz0jzRYqjcm8kmM
         0Xk5FIXfwypcJCrC4n4ODeqXyuOG59SEWqtF9pGlhmXiZQsPobavIUjfOUUoGeFtJU6o
         JWurOs3f2bAFK5PwhFGN431JMn/F3RuAT37pSJIo40xbh26gz1eG3ReJtWUXiiYg9qEx
         RenTbqjomBjA7QNgK2IEStNBXwkoLinJiHBYkUroi23ltbLo7dhgAgLFHSuHIuUbqKpr
         bY9XNCFm45t/e9cOrHh/Xg4lWe1g2mzGdT+ohOva+xZZhnIi8hyYr8pF4dRrarOYYQRm
         FYxw==
X-Gm-Message-State: AOAM530ZYgcnVmxmPsiFON7la2tMZ0TNUSq71O3Hpe3Ki3DLNWalk8oF
        tEetSuS4Y7MbiYuTTRo3WDGaNBHeX5xAUw==
X-Google-Smtp-Source: ABdhPJzH1t46URpmABcUEc//u5p0knXbhnJvsal/yvvQRvFqHQLUlt6dS4/FWEgVyCgGi8ZkwEjwUw==
X-Received: by 2002:a17:906:ae14:: with SMTP id le20mr36238349ejb.451.1608214760948;
        Thu, 17 Dec 2020 06:19:20 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:20 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Subject: [PATCHv2 for-next 04/19] RDMA/rtrs-srv: Use sysfs_remove_file_self for disconnect
Date:   Thu, 17 Dec 2020 15:19:00 +0100
Message-Id: <20201217141915.56989-5-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove self first to avoid deadlock, we don't want to
use close_work to remove sess sysfs.

Fixes: 91b11610af8d ("RDMA/rtrs: server: sysfs interface functions")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Tested-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index d2edff3b8f0d..cca3a0acbabc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -51,6 +51,8 @@ static ssize_t rtrs_srv_disconnect_store(struct kobject *kobj,
 	sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr, str, sizeof(str));
 
 	rtrs_info(s, "disconnect for path %s requested\n", str);
+	/* first remove sysfs itself to avoid deadlock */
+	sysfs_remove_file_self(&sess->kobj, &attr->attr);
 	close_sess(sess);
 
 	return count;
-- 
2.25.1

