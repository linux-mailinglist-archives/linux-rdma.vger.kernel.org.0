Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E14615333
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiKAUYm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiKAUYL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:24:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740DC17052
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:24:05 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso9139618otr.9
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm9xmAep6vmB6XfIEYzr2NGYXLxYsPR4rvmMeyBVmRY=;
        b=Tt2hooTr6H9TG+OOHxT29v4kXRQ30h8KkE66lsofXG9nFD0EzEKIKNj2/36WVEGEmZ
         uxRmjl97G5F7Kb2tM9EU4deax4NoKm1zJWxdgvRinNrJIGiSP5in1U+ZOlOnuAi8jHoM
         /B+BB5BxgcJiiB6EFyIZvekdHeCaa3DrNU1iHpb8t2S7/HeBphwr353LorA2LOJx4nAZ
         P5EFijPau4D67hx7Q6NbSuL6yyoQ9IjpZv0JmZgDmgLjJeOt3sP5YoyIfkC+xxJpMKuP
         5ht0t3gdNnZIArVg9tb16W/TVNbnFzi1wiUjXGhBTO4QK+he6DqjRpIoScIKugBMrFzS
         2RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wm9xmAep6vmB6XfIEYzr2NGYXLxYsPR4rvmMeyBVmRY=;
        b=lqHYFgN+VolErk7yapDAMLJ9xui8AIJGw07pDCXm/ynlinIj6K+2/fiPT5TmDBQEa0
         AnnvUZ+UdVPMHIW5ExfzGX02imyYwD1t+JpWiL8w7AGkUyT+Lu/2VpZC/6o9SIQGmjYg
         JcV05bfnLViVqm3A/JItw92S0YHqh/az6B4Ua9LBQqXN33kDiDoF8DbMVfDuwtspO3Ns
         zzzhTAlj2M5Kxy2rLUdVR4NJl8Kxv0q2+ThRAliOK3VQ59Dydx8cUJJFRnOD9L3rJkmg
         x38lVMjjVG3gcWSp1okcM8XE3lM4Dr8gVzrh45kCCEhO0FTKu5Jz5f8pEzYDI4w04Moz
         f9rg==
X-Gm-Message-State: ACrzQf1Ik6ZAsSxS+MsPLgK9fGhhiKkFtLEyYOUfsjosUC5/6QPOhFiK
        eYO+B47p0hx2SAHoE4uRK6F85XTHu/0=
X-Google-Smtp-Source: AMsMyM4rGVXYeSjq6M3hx3+PT6WaJrlOqE9iiS4qk4V0okCwFBQArg47F4Ccd3Nd7uWlKtu4cWAuRg==
X-Received: by 2002:a05:6830:12cb:b0:66c:6dd9:d983 with SMTP id a11-20020a05683012cb00b0066c6dd9d983mr1959577otq.349.1667334244679;
        Tue, 01 Nov 2022 13:24:04 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:24:04 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 16/16] RDMA/rxe: Replace pr_xxx by rxe_dbg in rxe_mmap.c
Date:   Tue,  1 Nov 2022 15:22:41 -0500
Message-Id: <20221101202238.32836-17-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace calls to rxe_err/warn in rxe_mmap.c with rxe_dbg().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index 9149b6095429..a47d72dbc537 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -79,7 +79,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 		/* Don't allow a mmap larger than the object. */
 		if (size > ip->info.size) {
-			pr_err("mmap region is larger than the object!\n");
+			rxe_dbg(rxe, "mmap region is larger than the object!\n");
 			spin_unlock_bh(&rxe->pending_lock);
 			ret = -EINVAL;
 			goto done;
@@ -87,7 +87,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 		goto found_it;
 	}
-	pr_warn("unable to find pending mmap info\n");
+	rxe_dbg(rxe, "unable to find pending mmap info\n");
 	spin_unlock_bh(&rxe->pending_lock);
 	ret = -EINVAL;
 	goto done;
@@ -98,7 +98,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 	ret = remap_vmalloc_range(vma, ip->obj, 0);
 	if (ret) {
-		pr_err("err %d from remap_vmalloc_range\n", ret);
+		rxe_dbg(rxe, "err %d from remap_vmalloc_range\n", ret);
 		goto done;
 	}
 
-- 
2.34.1

