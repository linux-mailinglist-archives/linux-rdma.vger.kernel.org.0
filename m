Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0EB7B39A1
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 20:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjI2SFT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 14:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjI2SFG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 14:05:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291FECEE
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso11479927b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010674; x=1696615474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbdv0/nW296h6ChWMtIgFAyyvGlVNRpufvyfuyvShzQ=;
        b=IW5AVcAkiaAj4s7fJRndl3MMjtUWjDjxTQlKnjnaHjAjwt+vUsYxz9JgvlYoaK3M6f
         Ol9y9wATgMc/u+YmhVAdfTUrWxP1HZJ0oPNZltX2EtwlMLEg2h6mTN8CI/YTP0t0yyUe
         dD46nq7X5i+JeJMH2faLvf889/DSNBnZtgr6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010674; x=1696615474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbdv0/nW296h6ChWMtIgFAyyvGlVNRpufvyfuyvShzQ=;
        b=R9kQtSAY/OGISOTIXFdcrPYBV3O6ke94lAwM+dtRU2RXrrL0VgWdeDuP6YREfUnyWa
         jwKck1nTikX9gPwzYp8EkCrTLpmLJhH6VPJy20tKmEkaz2tcJfCYRTMNyvuWX5THvM13
         8sPt/5S2ukV/uRZnZvBHNNC1vR2yjoLedmKQP6IpXalvIgEwGRL0tQt/24D22jyZ9SDr
         tH3o0vB9uHHZAyymtPKmu1O8wwZ7eE440ijcXIpONwCw++iblYrqA1FRwG4ztEC3pKdZ
         ckzkZS5kqqjGHVBnhj/CEpTvczl+Dvtwcz20i48uE7HG0jDG8czbnVssog0/AO/qYXKD
         gECw==
X-Gm-Message-State: AOJu0YwR+Hb9WXuR5y8t8tJ7oHg4v5/ezO6JJSc8Y3WQS71hgo5NerNy
        0guVCKvi8/4iLj5lNFofIqOAXA==
X-Google-Smtp-Source: AGHT+IGy74o21jxyozHb5het0OocJE/38B/v79t1GwFxGzhnGj1DFYoNecBZWdRxEDYr4YXo4bZcjg==
X-Received: by 2002:a05:6a20:6a23:b0:159:cf93:9b50 with SMTP id p35-20020a056a206a2300b00159cf939b50mr5241500pzk.46.1696010674631;
        Fri, 29 Sep 2023 11:04:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s2-20020a639242000000b0057825bd3448sm14577546pgn.51.2023.09.29.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:04:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leon@kernel.org>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        wangjianli <wangjianli@cdjrlc.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 2/7] RDMA/core: Annotate struct ib_pkey_cache with __counted_by
Date:   Fri, 29 Sep 2023 11:04:25 -0700
Message-Id: <20230929180431.3005464-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180305.work.590-kees@kernel.org>
References: <20230929180305.work.590-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=keescook@chromium.org;
 h=from:subject; bh=8qTIqTpqch+dyj739sghT5yZ5j+JjtWjxI1TdxYuFP8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxGtnlN5Fv7CxLg4EAHhoDTEkyA2uohAKbEuJ
 GpqdYgLKF6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcRrQAKCRCJcvTf3G3A
 JsP9EAC0DgrjiUKiy5qvIIyWJvdycEGXOMygwychR18Ef+pgg5+zSsDS92qrEYrYtFz76UNEjXu
 17JwoDffv1yCBXGPdCC533oDBSgVr+TlqtP2MZGJpAFB2jDA29+Dh4hzGUwpMr/6MnWn0bTR+Vf
 CpNLYII3OIAvmJ7tmaGaoHilX1gORNFvw6QXwwBjPqGo4OVFa8kBf1B0rtFRYcv3mAjY6/NICJX
 SHYsUU4Ics30sqUiukI13sfP3+hBHWUsXPfxlfPua60GazyoI3Knfr67AHenGUpiY+IW4aLoKdS
 o2kCcBAN7fkiUfZ1gZ78iamlNXXX0OSwijoe8XxuBtjfZazk6bZ+fvQocUBNAtcWA1GpKYkmzuD
 WZM7ZiZAb+AikXlQapk0bMLGL+lDIHr8vZDe4wCguY0+c2vj7sF53jCbCxvyHROPFaIf6NOF8Sl
 WgTV/v+kMTa9AYlUC/XwuF6+IkQA9oAN3SwwYjVJ8fIpCpFEr2BsgBBh3Ga0GVx1N+voyDpWY3G
 F+h9MTIiqcG9+eMOkNDRxa/356g84qJQVkHabmIondLkPx4Fhxi4sl0Q/z0lMrXCKQWUEiD0CZ+
 EyY/I2qS70/lsYtItOwfyhWLxUvHwRLNmkGx3T7/t7+KYvzbr3n9McTs1R8tzNlYTWrKwQ52ImD 13o2YAgRaZPedeg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ib_pkey_cache.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "Håkon Bugge" <haakon.bugge@oracle.com>
Cc: Avihai Horon <avihaih@nvidia.com>
Cc: Anand Khoje <anand.a.khoje@oracle.com>
Cc: Mark Bloch <mbloch@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/core/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 7acc0f936dad..c02a96d3572a 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -46,7 +46,7 @@
 
 struct ib_pkey_cache {
 	int             table_len;
-	u16             table[];
+	u16             table[] __counted_by(table_len);
 };
 
 struct ib_update_work {
-- 
2.34.1

