Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEB76185E4
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiKCRLv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiKCRKx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:53 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B247110ED
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:51 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id a7-20020a056830008700b0066c82848060so1187364oto.4
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaMckkcWbGrz5gkL7N+lZHQbz01KxlLQHTbEkTzcXcs=;
        b=a8PvjWHXCeM4wAVRLpyyQxyfFi+QPhmedlNbe7h2EFPOUcVdf62S73eT2Sy/sQecUY
         T7SAK3mR6utEVWORt+FS0g28e/9cCDeAGz3tpQyQbKTZRyen5gnfw6kB6Uhvzt+i4eJs
         4wof6+1EpIizG17twR7+KD3yRXrDdrf3NlwO2PklgdapIc0twmnCFRbGq9MzpIoEoa57
         6q9VuMSRJWf2DaMWDiqtqC+BUIolK1huAbfo45A1Y4q+8QOkTrWWjibT4WeUjRQj+UVn
         sk7oul5sSUrCIrRS2hLbu9cpELeOf/OVJ1D0ri5Ynm+lvQ++W+BetchScz8IbqO8Gvwa
         RfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaMckkcWbGrz5gkL7N+lZHQbz01KxlLQHTbEkTzcXcs=;
        b=SuhYb7xaXkP7wBrA4mx+hvVC1iyahr5N967Jg354oQV0U7M20C+pyHPzSTzVVSB2eE
         mRs+oIcYwAyMthpkoxO/6vwvf2T3KY3+udAnWNA9rWAHn+ioxEaRu7hxt4/urFwzfz8Q
         WQgu28GvMs2AgX2dsw+CtCpGQ0ZlszRGEit5ixovdUjPEl+POlFC8d7p4/uRhDIwMnyG
         62lK9emK8AO4r/6aX1O91psmln4tsMdYHCgEJgolHLUHASj9Nnm+SL7qywEXkZJHZwo0
         9TmrP71B1gGe4eTvG1iHD9oK1iHBEo4kE/a562vXOs0LfdS0IuKFcXHqDoExrlIcjDbB
         W12A==
X-Gm-Message-State: ACrzQf1gYKcX8GoD8Xd3C3Hfdkj211ACstHNCwssvsR/PTXvl6j8UDpR
        f/fq+2UtiJfo1rmrVci0cQk=
X-Google-Smtp-Source: AMsMyM5fKuUs2PvQ0CmEtBhDwPJn7AFCcV0IsVZcwRLol22x/PiCq++VH65VXMWKWSahbLk5z4W2qg==
X-Received: by 2002:a9d:4002:0:b0:66c:5acc:ffe6 with SMTP id m2-20020a9d4002000000b0066c5accffe6mr9922484ote.301.1667495451468;
        Thu, 03 Nov 2022 10:10:51 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 16/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mmap.c
Date:   Thu,  3 Nov 2022 12:10:14 -0500
Message-Id: <20221103171013.20659-17-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() in rxe_mmap.c with rxe_dbg_xxx().

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

