Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558BD75DD7F
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Jul 2023 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjGVQrd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Jul 2023 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjGVQrc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Jul 2023 12:47:32 -0400
X-Greylist: delayed 244 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Jul 2023 09:47:31 PDT
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113CB10FA
        for <linux-rdma@vger.kernel.org>; Sat, 22 Jul 2023 09:47:30 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id NFlNqftgEZWkDNFlOqjnql; Sat, 22 Jul 2023 18:47:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690044449;
        bh=IQyaExm2W+hWmqxwBEcF/S4pavhj7DW1iV5TthHyYq0=;
        h=From:To:Cc:Subject:Date;
        b=bv6jFkyPyNTJAMS45ucOXR0aal1IV5W56+H6O/egzxKIDCJmW9IbSNtvYllo84heK
         kKUxEWgD0UzOCdCp8ckbb5dtvYxgyLrPNbHN/QivomcO3XgGtKLmno54hYOQ6SXbbo
         w/cK/Z9ZpGlRH0uTMjoRvlTwITZaW5ReuzffE6nwszpSH3t6Em6LY8D8IDhatmJi91
         r7bTnzCQnRiq4+ct1gyt5lODJcKAHXe5B3YrSeHQVUnZ8gQlkqakffCDHc5qYRO4MM
         +7Wk6XlzyjnH34PqzYxEgMsrG7lvf1uyLXp2cE+nDcOkDKwKSL3pPTH0wkLELackOL
         K7t9XNqvKmegw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jul 2023 18:47:29 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH v2] IB/hfi1: Use struct_size()
Date:   Sat, 22 Jul 2023 18:47:24 +0200
Message-Id: <f4618a67d5ae0a30eb3f2b4558c8cc790feed79a.1690044376.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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


Change in v2: use struct_size() in another place just a few line below.
---
 drivers/infiniband/hw/hfi1/pio.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 62e7dc9bea7b..dfea53e0fdeb 100644
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
@@ -1910,9 +1908,8 @@ int pio_map_init(struct hfi1_devdata *dd, u8 port, u8 num_vls, u8 *vl_scontexts)
 			int sz = roundup_pow_of_two(vl_scontexts[i]);
 
 			/* only allocate once */
-			newmap->map[i] = kzalloc(sizeof(*newmap->map[i]) +
-						 sz * sizeof(struct
-							     send_context *),
+			newmap->map[i] = kzalloc(struct_size(newmap->map[i],
+							     ksc, sz),
 						 GFP_KERNEL);
 			if (!newmap->map[i])
 				goto bail;
-- 
2.34.1

