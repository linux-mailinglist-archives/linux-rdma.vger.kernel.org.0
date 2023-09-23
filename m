Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9BA7ABE0A
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Sep 2023 08:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjIWGDj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Sep 2023 02:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWGDi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Sep 2023 02:03:38 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 23:03:31 PDT
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC021A7
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 23:03:31 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jvcTqd9qqGc65jvcTqO2V0; Sat, 23 Sep 2023 07:55:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695448558;
        bh=X+CtKcB78+yvu8ZZawbK0NDtaqDQpwnaiaMKGnIwB/U=;
        h=From:To:Cc:Subject:Date;
        b=C2HhcJ+R6sDDIHtYI2gXorhU6B3gVMn9SuoGR3X5rIh+wNYt/hPC9jn5cSqBv6Za3
         vIomc5Wzz6nbuyiGZj1/xfCA09+GMJvzSEacyyi4ya7gK1yfbkboYwJpsZr8xqnOLR
         qHbgNE74BI6omSY5SVeN1nk35LHdKEAlWR/SpSG33ivD5XAl/zVNuZVPGvjc53bkRE
         Vtem4eY3t6/oM+zcOhWmlBIlU2YuxQ7pv0ThCUbyldHA+NpmB/xW/iCd8P5wzG/2sB
         2ObQl0jD+Vs83a5Fz1BODZbAEGG3nKOxe5Yr+EK2+oJpUz6Gbv2CHQNVOtNBB38YTZ
         uXdZxlta2XWKA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 23 Sep 2023 07:55:58 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Roland Dreier <roland@purestorage.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] IB/mlx4: Fix the size of a buffer in add_port_entries()
Date:   Sat, 23 Sep 2023 07:55:56 +0200
Message-Id: <0bb1443eb47308bc9be30232cc23004c4d4cf43e.1695448530.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to be sure that 'buff' is never truncated, its size should be
12, not 11.

When building with W=1, this fixes the following warnings:

  drivers/infiniband/hw/mlx4/sysfs.c: In function ‘add_port_entries’:
  drivers/infiniband/hw/mlx4/sysfs.c:268:34: error: ‘sprintf’ may write a terminating nul past the end of the destination [-Werror=format-overflow=]
    268 |                 sprintf(buff, "%d", i);
        |                                  ^
  drivers/infiniband/hw/mlx4/sysfs.c:268:17: note: ‘sprintf’ output between 2 and 12 bytes into a destination of size 11
    268 |                 sprintf(buff, "%d", i);
        |                 ^~~~~~~~~~~~~~~~~~~~~~
  drivers/infiniband/hw/mlx4/sysfs.c:286:34: error: ‘sprintf’ may write a terminating nul past the end of the destination [-Werror=format-overflow=]
    286 |                 sprintf(buff, "%d", i);
        |                                  ^
  drivers/infiniband/hw/mlx4/sysfs.c:286:17: note: ‘sprintf’ output between 2 and 12 bytes into a destination of size 11
    286 |                 sprintf(buff, "%d", i);
        |                 ^~~~~~~~~~~~~~~~~~~~~~

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
We could also use snprintf(), but it would just lead to a bigger patch for
no additional benefit.
This patch is already certainly more a clean-up than a fix.
---
 drivers/infiniband/hw/mlx4/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index 24ee79aa2122..88f534cf690e 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -223,7 +223,7 @@ void del_sysfs_port_mcg_attr(struct mlx4_ib_dev *device, int port_num,
 static int add_port_entries(struct mlx4_ib_dev *device, int port_num)
 {
 	int i;
-	char buff[11];
+	char buff[12];
 	struct mlx4_ib_iov_port *port = NULL;
 	int ret = 0 ;
 	struct ib_port_attr attr;
-- 
2.34.1

