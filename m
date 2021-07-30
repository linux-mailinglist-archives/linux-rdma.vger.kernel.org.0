Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C03DBC25
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 17:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhG3PXP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbhG3PXO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 11:23:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22055C0613C1
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:10 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so9836763oto.12
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NeigI8aZa+KNtubfGbbxqzXBSdS2WPBug/qsj18eqE0=;
        b=JIu75NiQof9b7pDEY7DvrnZiW5AU8Sftr0Q2kIbvRTqgS6f5HiX1/M/isdeBOVwTfu
         wOE0yJg2Uq3ypq1qCYajoiT+mnMQOuQxDpwtfsr8PjU5NnzP0qza+v+fxwgHXO+1bdgM
         FoEweNmx2zCTuhd694KKiJldbNd2yarwwcXTGDp6VawC1IcYM7h3dILhDEw6W48htoNf
         vNd10MWbVwmz+dzv60liJ7HNkx57H9Zjuq2UJFWf6Lm30bDI1sdW/KrwmItzf/4bv7RB
         jMAiOArGidp3f7mKgrSOGKuMq6njulj86uq0SzZWqVHUY0Rg9q9zxYpB8RdhYBNG3w+J
         ssVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NeigI8aZa+KNtubfGbbxqzXBSdS2WPBug/qsj18eqE0=;
        b=PcF65mcE6Q6of3fgEAt6a6WHyC39YwzbeXw+Jc/Czs2d3kRy3W9rpGeGFp6fwqmkDE
         Sz78qFujR07FJi1B1aKAU/A9frI4tTdRW+l4VYgeyrpz7DWnTcWDWy60bNLS8JstHSDm
         4Zm6scoUoGijscdDxC74fN+WkrCnvssrt14pC6mM8n4uX5q56FqdeyVKaIQwnDBXV24p
         Nd8aFX1fvgZ4bXWoWwSJ22+R1FAkcczWXznMriTRvAfryxPAZTiA9aQyMQVZzbpsMz41
         GyoUh0vu+KsGY+3mwtgkhD5aCZMmPiBvKMIHTM900IbqM4r9nhOhqbNF7MaQIOz2Ab9B
         QBMw==
X-Gm-Message-State: AOAM531akVYsetJEK2Ln7uifO2lT6KI39ss63lIWnL6WPhPEAW/2jsCj
        UA0ejUJO8MTKIU6p3becEFM=
X-Google-Smtp-Source: ABdhPJyMtnU3/qikFxdOsIPcMxJ7xw28yD43cuyplbLLIP6y4EpHkWZuSObbbD3XXfQjVrzE4U5CJg==
X-Received: by 2002:a9d:2208:: with SMTP id o8mr2430552ota.78.1627658589600;
        Fri, 30 Jul 2021 08:23:09 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id c11sm333199otm.37.2021.07.30.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:23:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, xyjxyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 1/5] Update kernel headers
Date:   Fri, 30 Jul 2021 10:21:54 -0500
Message-Id: <20210730152157.67592-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730152157.67592-1-rpearsonhpe@gmail.com>
References: <20210730152157.67592-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/rxe: Enable receiving XRC packets").

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 kernel-headers/rdma/rdma_user_rxe.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index ad7da77d..1d80586c 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -82,6 +82,10 @@ struct rxe_send_wr {
 		__u32		invalidate_rkey;
 	} ex;
 	union {
+		struct {
+			__aligned_u64 pad[4];
+			__u32	srq_num;
+		} xrc;
 		struct {
 			__aligned_u64 remote_addr;
 			__u32	rkey;
@@ -101,7 +105,7 @@ struct rxe_send_wr {
 			__u16	reserved;
 			__u32	ah_num;
 			__u32	pad[4];
-			struct rxe_av av;	/* deprecated */
+			struct rxe_av av;
 		} ud;
 		struct {
 			__aligned_u64	addr;
-- 
2.30.2

