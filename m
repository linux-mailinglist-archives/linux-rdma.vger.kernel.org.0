Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FEB75DD84
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Jul 2023 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjGVQu6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Jul 2023 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVQu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Jul 2023 12:50:57 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2211A0
        for <linux-rdma@vger.kernel.org>; Sat, 22 Jul 2023 09:50:56 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id NFhRqde8bqvVSNFhRqwXs7; Sat, 22 Jul 2023 18:43:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690044204;
        bh=EvXOg9Wf3mDu5fhjycUMuKTbOj5nWm5mbNPIU3YSZCs=;
        h=From:To:Cc:Subject:Date;
        b=ly9sn9Y7k3+pn017fd72cAMjcY21k6cvEKg9DI1lB5dU3YAy1Q9aFNVMqbN8EjCie
         /oKCEBDvYSloKacW1ztKu0gPcslzvRmm7qWczny4s68Cx9z7Rxyn52ctyBXGlogx9C
         /ai579TbWtZ2FdzRISLFHVHrV3D1htFgVcURk7TCYTV/exdqq1+yUk3MF77d362vwh
         y6EGeiaaiaGKJc7ERrd0pMhcPIUW2LG7dSVRYmmGipGKxPzhpEgqpWJOJ+2Cx03dOh
         6xT38O32RvD9yTkpTvuvtsNh9i2yvKfnJhDzo3Dd546nAtL7oMxkNLBsvzolxv8t20
         FqCjXkSHQbVlQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jul 2023 18:43:24 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] IB/hfi1: Use struct_size()
Date:   Sat, 22 Jul 2023 18:43:18 +0200
Message-Id: <5631d2f1e20b48b27478275e8d3466e009ca1223.1690044181.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use struct_size() instead of hand-writing it, when allocating a structure
with a flex array.

This is less verbose, more robust and more informative.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It will also be helpful if the __counted_by() annotation is added with a
Coccinelle script such as:
   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/counted_by&id=adc5b3cb48a049563dc673f348eab7b6beba8a9b
---
 drivers/infiniband/hw/hfi1/pio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 62e7dc9bea7b..5053d068399d 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -1893,9 +1893,7 @@ int pio_map_init(struct hfi1_devdata *dd, u8 port, u8 num_vls, u8 *vl_scontexts)
 			vl_scontexts[i] = sc_per_vl + (extra > 0 ? 1 : 0);
 	}
 	/* build new map */
-	newmap = kzalloc(sizeof(*newmap) +
-			 roundup_pow_of_two(num_vls) *
-			 sizeof(struct pio_map_elem *),
+	newmap = kzalloc(struct_size(newmap, map, roundup_pow_of_two(num_vls)),
 			 GFP_KERNEL);
 	if (!newmap)
 		goto bail;
-- 
2.34.1

