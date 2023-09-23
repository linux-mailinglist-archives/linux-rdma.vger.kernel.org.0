Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9007ABE15
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Sep 2023 08:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjIWGPg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Sep 2023 02:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjIWGPf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Sep 2023 02:15:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10E11A6
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 23:15:28 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jvvKqieqFqQHijvvKqqbog; Sat, 23 Sep 2023 08:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695449727;
        bh=G7tAIoMWyx5SK/7lnnnDHZQxV+76Lbl3kc2YAXhhFds=;
        h=From:To:Cc:Subject:Date;
        b=MGzImVvYYc5cHEX3tVkaysSdw4wuTrxD6R7sWHjIOZ2qws4JYxELVTHhdQ4eNkF+Y
         FSRNHfwED57IwVmOLTRF9Jfe4ckoQ5aYFsB8IOx6mhkvSeTpNkEL0Qk9NpdkInRH4k
         xL920sfyYWK6wUVTAY1hCvKm+Lx2oND0wzQM9br3tNBn0l8hmSb9WbbmPThSL6NBI8
         6QWE3aRnarN3FP4mEBH+G6AgJZ9k6rzZGNRX3qjNowyYmX8ZyEVtqJ01UyQ/xHjVo4
         S/UKjvIG4UCmOcp47MV3BK29U2pJvgV7P/rhm7tFO2jlJXDvNDRHdb+9oHdNdr6Hid
         ntKvus+7XzSxQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 23 Sep 2023 08:15:27 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Matan Barak <matanb@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/cma: Fix the size of a buffer in add_port_entries()
Date:   Sat, 23 Sep 2023 08:15:25 +0200
Message-Id: <91395b73a64c13dfe45c3fd3b088b216ba0c9332.1695449697.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to be sure that 'buff' is never truncated, its size should be
11, not 10.

When building with W=1, this fixes the following warnings:

  drivers/infiniband/core/cma_configfs.c: In function ‘make_cma_ports’:
  drivers/infiniband/core/cma_configfs.c:223:57: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
    223 |                 snprintf(port_str, sizeof(port_str), "%u", i + 1);
        |                                                         ^
  drivers/infiniband/core/cma_configfs.c:223:17: note: ‘snprintf’ output between 2 and 11 bytes into a destination of size 10
    223 |                 snprintf(port_str, sizeof(port_str), "%u", i + 1);
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 045959db65c67 ("IB/cma: Add configfs for rdma_cm")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/core/cma_configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 7b68b3ea979f..f2fb2d8a6597 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -217,7 +217,7 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
 		return -ENOMEM;
 
 	for (i = 0; i < ports_num; i++) {
-		char port_str[10];
+		char port_str[11];
 
 		ports[i].port_num = i + 1;
 		snprintf(port_str, sizeof(port_str), "%u", i + 1);
-- 
2.34.1

