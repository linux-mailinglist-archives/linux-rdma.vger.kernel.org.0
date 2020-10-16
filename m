Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0FB290CB7
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 22:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393607AbgJPU2H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 16:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393595AbgJPU2H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 16:28:07 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A3C061755
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 13:28:07 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 16so3860211oix.9
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0greDqDTdACsJoVqPHvEX9Kc8Dy45S7TEfGTawjEXEI=;
        b=DZGMzsjRE6ETQCrpENXmxMhP0vLyfHWtMxpKu0V8m5HyyslBQWfCbGINfzVlJ1T6gh
         aED/AT7lSUQ1dxhWCTekKtCbgCT9nrEM0N5Qxkc4xjxpES4BqArbXj2KsZApO6YP2pXG
         PgG8E+OdT21a0Axkgvheewd1agI+Lf6kNiB3m+mgpVLmZW2szHgWY/fY7Jud4VepFF9a
         MQfLLgclD9xwTVfYz8Ak3Euhjlr+M9CwvqtXShDKJeItfbGzrpTeZTEr9icwiPtlwOxP
         Vet38JlNcq1cQXeuTuOyJXBeVSWKEjdcoczLjU5D5fmIhJuFY3EHOZungIuB1+zwYzR8
         Mt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0greDqDTdACsJoVqPHvEX9Kc8Dy45S7TEfGTawjEXEI=;
        b=mYV4Ba76WWjPty5sCAvRGf5+xd/dl+oX2KoEAeT25g42eOlDJkR393m5M43/AW7/MI
         eoXgVFtlpYWLyI6ZeAaHb8Pbge+cGM+ZxCctwbF5rhHMqvDxevNn32GH3sIZI8aQ8fmQ
         FkSZNnxjat2Bh3orGoGsOBGsNApHMNDI/PYlwD1cjU3ir0smMuRZshAy/qoPFpAKw0KB
         UFcfYz+c1XbFFRB5DNAJszfmjD5n5kRHoUuFzkYnmJYag/8Fj0BH7rBrX9upRPE5CLIS
         iyRsm+s3WIUP+JZIvogT6Z6deEedxY8jJv8anpmZkUw/obIAJJX7IeC/V2rbRgt/V/OK
         G0ZA==
X-Gm-Message-State: AOAM533OzXnrHg5AEtyQnoU+iMYfiKonxKAcw71WOjQwBxqg1+ZKE1ts
        hGyxckU49OxhHkGDVX2bV+o=
X-Google-Smtp-Source: ABdhPJwW8n8cfWwwFZynoJM6Lc5rXqbhzT8XqHSDe9xVe+f8mclUoo/7dG/19M6345gjZjy98QB/9g==
X-Received: by 2002:aca:f5cf:: with SMTP id t198mr3757773oih.22.1602880086500;
        Fri, 16 Oct 2020 13:28:06 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3929-4284-f7ac-4bbd.res6.spectrum.com. [2603:8081:140c:1a00:3929:4284:f7ac:4bbd])
        by smtp.gmail.com with ESMTPSA id l62sm1385243oif.18.2020.10.16.13.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 13:28:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for next] RDMA/rxe: Fix small problem in network_type patch
Date:   Fri, 16 Oct 2020 15:26:46 -0500
Message-Id: <20201016202645.17819-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The patch referenced below has a typo that results in using the wrong
L2 header size for outbound traffic. (V4 <-> V6).

It also breaks RC traffic because they use AVs that use RDMA_NETWORK_XXX
enums instead of RXE_NETWORK_TYPE_XXX enums. Fis this by making the
encodings the same between these different types.

Fixes: e0d696d201dd ("RDMA/rxe: Move the definitions for rxe_av.network_type to
		       uAPI")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
 include/uapi/rdma/rdma_user_rxe.h   | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 575e1a4ec821..34bef7d8e6b4 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -442,7 +442,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	if (IS_ERR(attr))
 		return NULL;
 
-	if (av->network_type == RXE_NETWORK_TYPE_IPV6)
+	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
 			sizeof(struct iphdr);
 	else
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index e591d8c1f3cf..ce430d3dceaf 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -40,8 +40,9 @@
 #include <linux/in6.h>
 
 enum {
-	RXE_NETWORK_TYPE_IPV4 = 1,
-	RXE_NETWORK_TYPE_IPV6 = 2,
+	/* good reasons to make same as RDMA_NETWORK_XXX */
+	RXE_NETWORK_TYPE_IPV4 = 2,
+	RXE_NETWORK_TYPE_IPV6 = 3,
 };
 
 union rxe_gid {
-- 
2.25.1

