Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8007C7AB745
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjIVR3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjIVR3Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2BF1A1
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso2212611b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403747; x=1696008547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr7VMeXLJH8XwB+zD35GqBQrsMI4YcQcUPdvZ9TWxzo=;
        b=ETuYqYjpeAxjrAEL1zRFWt/PP3eZI9SgqafdsGPe0j/d0XtACtcZDgyPnDXrcT9zpg
         SRLDJsQMgIu0JAf9ZzHaEFFQcg3D365AXbC8M+qMbbwRlzYFNz7JaxM09Eqa6sXf848/
         PKgIcPnFEOyPaZzEsqh5JXlQ5MB3W96RKtJm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403747; x=1696008547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cr7VMeXLJH8XwB+zD35GqBQrsMI4YcQcUPdvZ9TWxzo=;
        b=CCOiIoVGMqfHy6wTlj73cxQayvy4pmmGzVQwZOCcC5t3pJ+9Ae/qiyBNETTEc+9MHt
         mRqjNpfvifltfzfTfy99ct2BHeIdmmeF0yg1SYMswHekUMpCIj0ds4xYv/oaBt97W7s+
         VURHLWHVtrgogHfBI99ndkY+Eny4UBlHKROnsvvpAf923jfhpEHHKhjd1x2eBqIB9I54
         OMkuxUq/mgT+JxlvCMtR5CHCNkpp7g1c7CNj4mq15vqHAg5XQ1va0sbqWaRWAJTbJx34
         2wSnzuIG31W0B1iYVSCWa3lRzPhEiP6b/DtFztvAOHAgwY1wb45j+bn+btb2OEnRdHpR
         29hg==
X-Gm-Message-State: AOJu0Ywk8AOrCM2EmnWSXOj8IqKCnZrq6m5h6qlCtAPgIaLoCF2iQmAC
        mS46Ikw2N8qrdw4PdXcZNBk3ug==
X-Google-Smtp-Source: AGHT+IE0d9nBIyFO0yR0ORoUWZ7+c+aEOlGAafPRRZOxGS/XkTVczyefdXfk1dF4abqqKQnNPwhUbA==
X-Received: by 2002:a05:6a20:1049:b0:155:1a5a:9e31 with SMTP id gt9-20020a056a20104900b001551a5a9e31mr230381pzc.16.1695403747014;
        Fri, 22 Sep 2023 10:29:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020aa78d05000000b0068fe7e07190sm3461673pfe.3.2023.09.22.10.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:29:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        David Ahern <dsahern@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alex Elder <elder@kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, dev@openvswitch.org,
        linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 09/14] net: mana: Annotate struct hwc_dma_buf with __counted_by
Date:   Fri, 22 Sep 2023 10:28:51 -0700
Message-Id: <20230922172858.3822653-9-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=keescook@chromium.org;
 h=from:subject; bh=jNN2Wh5TqbkzFZoQFHMYTzfDn0UF7zrm9adldOZuxp8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7XoLVZdYuePM97S+7MA9i5iH3sxyTfQSS08
 LJB65B+ZZSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1wAKCRCJcvTf3G3A
 JrxWEACNSgzg8Ycl9Qe1Mp2gIHHXFmJMIrT0z4cUhu6hZZXHD244HpZ8X+SYVMS9HS5syB/r5ZI
 2kNn5pZePHECZBA8CM4/TjgpQPlFRdgxHFFqBbfsYgAQnBkEMCTkFfCaKwzzmXVjLJfnpfOortM
 FaMeXJbItFRrX0Jwcv9cj9UC0k0zGIxwDvhCTpWO0IfrCOoDrV1VzDNtTUJ+XVL78kI1f2l75Ay
 34ksMU9kJrH5ASYCmmlwAZNT7ObZi26q0SKJgrSLWhqtq9swbQKnxy3Ask714ZdqhUI+l79qL6z
 eVDkoz7xmTG/GwFi1Gm0f3aQ4nmQiaJS/EKoN/Moy4R9Pj4PcoP9A6a9JAnbXFsCyfcURk+Xeiu
 7d8SiKimBQYQu1t6iC0rdtnDx9AUg+PH6cO3/7ARrrFcYoi21yLy5erMFvLZ/GdTEGrwiQFoiQ+
 gGAv4IONo4YXXQlC/z8es5uxwPk+UXJ+bvwe+PL8WnXGdKs8QMRXslYTUSIaEP+9YNvPuIawQRM
 erGitteR+N7KlsLaWaaq/z9LavLhnOua7sOCJQ7cDMa/pNWZDzckInyzoUg8Skf4gmjH2fNF9O7
 3+n1k69unddP2rtknBF6q49u18qdd9qXinwaYwqeXq9tyopeLUrF/KsAn9ZP752xrkkWBf6pYiW ZuZJGJuFzQpQdlQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct hwc_dma_buf.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Long Li <longli@microsoft.com>
Cc: Ajay Sharma <sharmaajay@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/mana/hw_channel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mana/hw_channel.h b/include/net/mana/hw_channel.h
index 3d3b5c881bc1..158b125692c2 100644
--- a/include/net/mana/hw_channel.h
+++ b/include/net/mana/hw_channel.h
@@ -121,7 +121,7 @@ struct hwc_dma_buf {
 	u32 gpa_mkey;
 
 	u32 num_reqs;
-	struct hwc_work_request reqs[];
+	struct hwc_work_request reqs[] __counted_by(num_reqs);
 };
 
 typedef void hwc_rx_event_handler_t(void *ctx, u32 gdma_rxq_id,
-- 
2.34.1

