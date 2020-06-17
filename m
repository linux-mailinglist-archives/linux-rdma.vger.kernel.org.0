Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D61FCAFF
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 12:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgFQKhl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 06:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQKhk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 06:37:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23B6C061573
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 03:37:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so734782plr.4
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxcWus7DvqskOYAGR2NZgYr+kARItr4Gp9oHt8X2bYQ=;
        b=DAvalicJKwxNB+R2yjh+tvzAUV9aP2YvwGT3GvhFlgEKqR6p633oGngUCz8NHnY3MZ
         mXdAEP7Eze34DV6EiPl7x2mmILT6lhcaLSmLKUo+9qpMBkjIkkDgHwKb8Be3ecANTHBE
         pP27DbiBmcBlzCgOYyuDQmhERdqM5fgqnvT1BYVa1yY8py7kq2OuT4MjJSW4Rw/tObUt
         7WNdFpi+Yfpy/gHEgAaEmwV3bWx5cqLqP+5rLJYxqtF+ilMgh3JimM5sZ6lpbJQdeWBL
         nnflDljq6J7U7ZTnlt0erWQo2+jZIJRjkiDo4pYsijMBYNZppHEwwsK+bUtD3k2hUcFf
         SEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxcWus7DvqskOYAGR2NZgYr+kARItr4Gp9oHt8X2bYQ=;
        b=i6fj6jV7FI/Y/Snv7etsXp2hlR27+dqv1rhilr7h1Gv58AD+PrlvBwbr0jPRY7C69n
         0SjeapS6Ys7c/qs0kQX1UcviQjjkqPpPCDg2q0hVHFkue/blDUemVArDK/evi7yUCf5p
         3PnQnaU7rQrzKXwBlwumAncQtjpd/CQ9EMtAhNpn/OHNLU7E07ErS34/ZJIbT9qzEEmM
         oE9VX/CosKAji7mUcg48uRJrOHDv6IzTBKFYZdg1K7E/JPNbGVIRRImNVKrk3yZqKqtc
         wFwutVcit5HNKqWiv5RlRmD3btP3cigv0yUPjMeoBGf5efMmtDYq9FHJ4QzcJuBB/0c/
         sTOg==
X-Gm-Message-State: AOAM533rrxLqKh0sE2bpSMpZ+6yzWAhLQQ2WQw6XlWRCzO/q2qqvmaQy
        OLK/uA2BwS7GNeUo7jUvddF6zg==
X-Google-Smtp-Source: ABdhPJy99TLE9lDbCycQTII1qX5sKN38XsqTFocwh9E4wMfor21sFsa1gy4qQc4yTWuCu4T+lQiXIA==
X-Received: by 2002:a17:90a:43c5:: with SMTP id r63mr6823061pjg.203.1592390258626;
        Wed, 17 Jun 2020 03:37:38 -0700 (PDT)
Received: from dragon-master.domain.name ([43.224.130.246])
        by smtp.gmail.com with ESMTPSA id u6sm10031776pfc.83.2020.06.17.03.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 03:37:38 -0700 (PDT)
From:   haris.iqbal@cloud.ionos.com
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH] Delay the initialization of rnbd_server module to late_initcall level
Date:   Wed, 17 Jun 2020 16:07:32 +0530
Message-Id: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

The rnbd_server module's communication manager initialization depends on the
registration of the "network namespace subsystem" of the RDMA CM agent module.
As such, when the kernel is configured to load the rnbd_server and the RDMA
cma module during initialization; and if the rnbd_server module is initialized
before RDMA cma module, a null ptr dereference occurs during the RDMA bind
operation.
This patch delays the initialization of the rnbd_server module to the
late_initcall level, since RDMA cma module uses module_init which puts it into
the device_initcall level.
---
 drivers/block/rnbd/rnbd-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 86e61523907b..213df05e5994 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -840,5 +840,5 @@ static void __exit rnbd_srv_cleanup_module(void)
 	rnbd_srv_destroy_sysfs_files();
 }
 
-module_init(rnbd_srv_init_module);
+late_initcall(rnbd_srv_init_module);
 module_exit(rnbd_srv_cleanup_module);
-- 
2.25.1

