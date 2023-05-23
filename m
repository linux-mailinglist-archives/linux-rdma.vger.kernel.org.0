Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EDA70E49A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbjEWSZr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 14:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjEWSZn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 14:25:43 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 11:25:33 PDT
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA49B18E
        for <linux-rdma@vger.kernel.org>; Tue, 23 May 2023 11:25:33 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 1Wa2qKmmo8aX91Wa2qCkXv; Tue, 23 May 2023 20:17:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684865876;
        bh=xOjN030f+KivSx43oy6ENyMrMHsfizHgf8zgnaV+c+4=;
        h=From:To:Cc:Subject:Date;
        b=aDKiYuO8+10YmMH1IU69GSOhnG5Fn+PgSBg6glntAZ+sc3eVkGzE+xPs9s33q7MWd
         QivsqPba4wkHoVOBLp4UFvElk742rEW64go+mrjnhmycUPgRt6GdDepa7Dkc9PZX8s
         Ts+ZUH9uls0NF9rMYJfEuf34fDM3e3DnBt8di/dpQ1G9A8G5EaZabUclcdtVlnG8ct
         dS1jPsbIFTooru+9weUFNViCcdnZCD3hzZePzTv/hHUFWJnWMKLKFSn1/QFzp97jP/
         PNlqKmGddvNzsfVGqJJWlJWeZcXJ0p7aNFjYP7xZ4cVqDaiXFJMmuKnaa5vKz/VxlV
         T4nKQSvRIFCng==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 23 May 2023 20:17:56 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH net-next] net/mlx4: Use bitmap_weight_and()
Date:   Tue, 23 May 2023 20:17:52 +0200
Message-Id: <a29c2348a062408bec45cee2601b2417310e5ea7.1684865809.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use bitmap_weight_and() instead of hand writing it.

This saves a few LoC and is slightly faster, should it mater.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/mellanox/mlx4/main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 277738c50c56..28c435ce98d8 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -1374,16 +1374,13 @@ static int mlx4_mf_bond(struct mlx4_dev *dev)
 	int nvfs;
 	struct mlx4_slaves_pport slaves_port1;
 	struct mlx4_slaves_pport slaves_port2;
-	DECLARE_BITMAP(slaves_port_1_2, MLX4_MFUNC_MAX);
 
 	slaves_port1 = mlx4_phys_to_slaves_pport(dev, 1);
 	slaves_port2 = mlx4_phys_to_slaves_pport(dev, 2);
-	bitmap_and(slaves_port_1_2,
-		   slaves_port1.slaves, slaves_port2.slaves,
-		   dev->persist->num_vfs + 1);
 
 	/* only single port vfs are allowed */
-	if (bitmap_weight(slaves_port_1_2, dev->persist->num_vfs + 1) > 1) {
+	if (bitmap_weight_and(slaves_port1.slaves, slaves_port2.slaves,
+			      dev->persist->num_vfs + 1) > 1) {
 		mlx4_warn(dev, "HA mode unsupported for dual ported VFs\n");
 		return -EINVAL;
 	}
-- 
2.34.1

