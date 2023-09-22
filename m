Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27BB7AB72D
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjIVR3J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjIVR3I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98968199
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3f97f2239so22089675ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403740; x=1696008540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQgcIF4PySsFwzeoGRYEtks5LIc34ltXAoSUNKMo2rM=;
        b=mSkhcL9TEa9hydf9ojWyGlsNy28su6oNKnOUyO2feJRC98SbLIqAQ+F0lyRwx1RCdT
         CMEgYQhgmI8GTtZoyKGGjRlQQcNC15aizeCcivLzbu6DO+2XrevmPp859gLuJ8nMNYv+
         IT9U53XPaTbh+qoZkq9cNu/NU7NnBaX4UD2+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403740; x=1696008540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQgcIF4PySsFwzeoGRYEtks5LIc34ltXAoSUNKMo2rM=;
        b=THZuHNiQA3NonZuvu5p7OaW1u3di57LAsEWEzwhxLj5QfQUTEif8V61xU+PG2ja+iZ
         yufefpUkIZkLtTbvDx9akJtcAVYpq4FRgaw81HQdV6RqCqVr1NtB5iluR5ZLxsISBgAz
         S5+mPezQ4PjARCVTeQa9MzwR0BDk9ACaF01HlNyQ0xHv7fpx+LznBGGU/GY60QYkccdn
         CJxyHoyK9rZB7I0Vzyl5CwwUeFHQf3RarlrClVFPKUYizkjtpWGAHq9o8BKtPVnytYG6
         k+LBYSaz0n65cOsCxx283SrmAQWmyJsqiHr8/tOmdyEA1VDDTQLqTBRe3aOJYmoWspFb
         ryDA==
X-Gm-Message-State: AOJu0YxbD/u2gRhGL7C3+nEP9b+8nbUqq5wueKIDu97KQwl9DsQf4xcS
        VKZeUnHqAiIfhhkWZQaUIvdvlQ==
X-Google-Smtp-Source: AGHT+IENmtf+3QgdICsx9sMlPZ8VP9uQ4Oz7vOx980wWikaK8xYczZcDLwgaN7wYl0LqtVWF+L/15A==
X-Received: by 2002:a17:903:1104:b0:1b9:de75:d5bb with SMTP id n4-20020a170903110400b001b9de75d5bbmr129615plh.7.1695403740055;
        Fri, 22 Sep 2023 10:29:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ju4-20020a170903428400b001c5684aed57sm3747496plb.218.2023.09.22.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:28:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Alex Elder <elder@kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
        dev@openvswitch.org, linux-parisc@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH 02/14] ipv4/igmp: Annotate struct ip_sf_socklist with __counted_by
Date:   Fri, 22 Sep 2023 10:28:44 -0700
Message-Id: <20230922172858.3822653-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=keescook@chromium.org;
 h=from:subject; bh=6I/UlxaeVfPSNCQK2wJRk7LvdQNOEqFwEHhj61WBOvM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7WtZKzI4JHFCjzeBDKOaLb2wkieWFO9YYNa
 DG+55LdCDKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1gAKCRCJcvTf3G3A
 Jm8qD/9eheMPlBV345+ln0OsLw143sFPp/IgjC2ffDkvS+vNvlyGKo1pdDfWL/Dy6yQbTqJIKWj
 izxzityDxwVA5CrakAWjh0OUEc71/HYUErA4IzMs7+UoxJbgLn77IWWpyw9Xwj46b3IrmRsWA63
 IRzPhOYgKmjgTZ0/P5uk+86O0fX3UFW7aDBTUCxijuYfhGodNshSKQoHWNQDyR+Runv2Mr5/nrV
 47/zpDx45NGiHVXKH/RB+v83VHSSg0B80AvuKBtrrECHT3uGd0vQxajYOXF6kIdhsnLEojhkSdB
 6hJsvl9SL8mu/kw37S2hPbbF7ZSwyNqtNPXAJwTUX91YRDiwUz/E2Id35bAX6iAYZJPOgqQNlba
 m9sGLSd5M1FNeb7BMZFfkHlvXtRU3lGqmxTCythMv9l5vOFelYrWm3Ed5DsDzUJso4uHqMoeJLG
 abH8O7CdTeYTSBEPqKO+hOU2RbQvGjJSGgpqkNnGadIH7wsREbIh4wpGIoeyjG4AFJkWcJHPW0X
 pclEzg1B6BV3xUvk+Orq3M6MIdEdE7Qeag5HRs3i20O1tA/6Nt5Zg1GDi6PGIU8czPirNy7vi7Z
 1/e6fS4U10TVhrJ0/X1IdhPx94mERDlb73y5W8AJNMIpUO3NKcKwi94OZp7UCYdY6dy+6ShVhDg QMQF1oNmMT1fAvg==
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

As found with Coccinelle[1], add __counted_by for struct ip_sf_socklist.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/igmp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index ebf4349a53af..5171231f70a8 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -39,7 +39,7 @@ struct ip_sf_socklist {
 	unsigned int		sl_max;
 	unsigned int		sl_count;
 	struct rcu_head		rcu;
-	__be32			sl_addr[];
+	__be32			sl_addr[] __counted_by(sl_max);
 };
 
 #define IP_SFBLOCK	10	/* allocate this many at once */
-- 
2.34.1

