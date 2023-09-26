Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62C27AEA0D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 12:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjIZKLd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjIZKLc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 06:11:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8778BFB;
        Tue, 26 Sep 2023 03:11:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c61acd1285so27943215ad.2;
        Tue, 26 Sep 2023 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695723086; x=1696327886; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZIIam7YXI/p4m2BD04trVXP4C7GhvPtTR3ftfkV7T4=;
        b=JVmJXwKoPfw6ZirpJEjyrUnVdkXK2G0/Q4YPizuvJlMGKraUaDKBMTMQtJslRwTDMh
         EHenHULp1jSg/AoQWPh6UbS864bM0uXaxgwSjhT9lU+vvQlfnEh0C4pfMGha6mLnA4qL
         yioIog5A9aBYgKUe0W/3mnFFkrqqmt98RQ/32GaXjaFs2F5+ncXDRqgt/GAVRJ/NpeTx
         LAuBl2N4gNEttGxza+za+lsC7+PowlavgYyeqHnKOwPRF5wNkZa0v9ZAKHCtRg0SG35i
         0UeCiqn+Jzpx9Dn9KvqqaV5PU+y/aW31sINCIUtr2yiztXKZDVin1qMY7izMVotXmqQK
         HnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695723086; x=1696327886;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZIIam7YXI/p4m2BD04trVXP4C7GhvPtTR3ftfkV7T4=;
        b=IS8kc32OpLAdFo7mRY4lkQ3QFZdEC+km1YnM5EKzuzgLqFrGMnPwKiIRiM6i82rB+p
         xv2lBn03l6ygNZZgAi/T8oJz3OmEVMmCB7QQX6MldDvb/gnf6KvHHJnJPaMXHa9KCZjs
         XHhqWhOulpvsxAX1LFKtjIfAp10FfMaqo/Ej76pADxpVAzQNo2CMAck8VAiT4uNGcw2I
         0Fc9q0i1698p+oo9NgF6IzQpY11ZI8BcWjCjs67+h7KGLG2903lTsVTmDZJ8rHkN9lT0
         S/O9Lrcw4Y78+QrW3B1Pkt/Ux1TSgq4bERBBKnuCNQAXaHy8giUWNWNgUgBzoTzu8TG9
         jSIw==
X-Gm-Message-State: AOJu0YzzQJ2qczmal9ERf/sH61KQVJZddjaNb2Yw2Q8L5jyv8uc+JfCG
        ABUSHVSUd6ZKjfEc5v4HjJM=
X-Google-Smtp-Source: AGHT+IHwev5GCABx9yYhrdR7YlylxBMUfO/2Hpu5MFg0PLZ8qjEuyTQ0YXuLcCJOADLN/40OAOugiA==
X-Received: by 2002:a17:902:934a:b0:1c3:a1a8:969a with SMTP id g10-20020a170902934a00b001c3a1a8969amr7145285plp.8.1695723085804;
        Tue, 26 Sep 2023 03:11:25 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001bc21222e34sm10524702plf.285.2023.09.26.03.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:11:25 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, dean.luick@cornelisnetworks.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] IB/hfi1: Fix potential deadlock on &irq_src_lock and &dd->uctxt_lock
Date:   Tue, 26 Sep 2023 10:11:16 +0000
Message-Id: <20230926101116.2797-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

handle_receive_interrupt_napi_sp() running inside interrupt handler
could introduce inverse lock ordering between &dd->irq_src_lock
and &dd->uctxt_lock, if read_mod_write() is preempted by the isr.

          [CPU0]                                        |          [CPU1]
hfi1_ipoib_dev_open()                                   |
--> hfi1_netdev_enable_queues()                         |
--> enable_queues(rx)                                   |
--> hfi1_rcvctrl()                                      |
--> set_intr_bits()                                     |
--> read_mod_write()                                    |
--> spin_lock(&dd->irq_src_lock)                        |
                                                        | hfi1_poll()
                                                        | --> poll_next()
                                                        | --> spin_lock_irq(&dd->uctxt_lock)
                                                        |
                                                        | --> hfi1_rcvctrl()
                                                        | --> set_intr_bits()
                                                        | --> read_mod_write()
                                                        | --> spin_lock(&dd->irq_src_lock)
<interrupt>                                             |
   --> handle_receive_interrupt_napi_sp()               |
   --> set_all_fastpath()                               |
   --> hfi1_rcd_get_by_index()                          |
   --> spin_lock_irqsave(&dd->uctxt_lock)               |

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch use spin_lock_irqsave()
on &dd->irq_src_lock inside read_mod_write() to prevent the possible
deadlock scenario.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/infiniband/hw/hfi1/chip.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 0814291a0412..9b542f7c6c11 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -13185,15 +13185,16 @@ static void read_mod_write(struct hfi1_devdata *dd, u16 src, u64 bits,
 {
 	u64 reg;
 	u16 idx = src / BITS_PER_REGISTER;
+	unsigned long flags;
 
-	spin_lock(&dd->irq_src_lock);
+	spin_lock_irqsave(&dd->irq_src_lock, flags);
 	reg = read_csr(dd, CCE_INT_MASK + (8 * idx));
 	if (set)
 		reg |= bits;
 	else
 		reg &= ~bits;
 	write_csr(dd, CCE_INT_MASK + (8 * idx), reg);
-	spin_unlock(&dd->irq_src_lock);
+	spin_unlock_irqrestore(&dd->irq_src_lock, flags);
 }
 
 /**
-- 
2.17.1

