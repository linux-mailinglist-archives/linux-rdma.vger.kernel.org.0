Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB347AB72E
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjIVR3J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjIVR3J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7991A1
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c1ff5b741cso22725415ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403740; x=1696008540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnbuNOS48ZNXGx3qE7i6qDaIIscfCr6TPOESNc92Xe4=;
        b=EQTEiUEhu4mw8Yllk6I8iSDL00rrpzzbjxGgHTm48P94Bsy8w9FIcAi0/YNwy/HEiP
         6pkON2YkTTKs/Gz7lVq1+Go/ui3PGl79b/dT3o3wQ5+t1t62piERSDUHsAXph1u7AoDD
         fRH+c1YILqSDofLactDVzr683oaR2NjaiPTVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403740; x=1696008540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnbuNOS48ZNXGx3qE7i6qDaIIscfCr6TPOESNc92Xe4=;
        b=NnZzfU5wlTs3rKG6lirnLSbtQsN60hW6kN4BPmpUOVNo+sTkPhGNxZwrpg37lQxhlD
         vEnsEGRPblO/thxhbXwYuTgAtAmfytaKmnd2QmI4HjP+5OZ5H7ZGsSIVLRFXYbiV8kXg
         hW1b1Qzk2b4xUyPmQ6oDAedBByaVqNXYyDhka9lpovjG8PS14x80w8IrIb50CBgeredm
         9y8vyiMTSn6K0McEfa/FnK1DHP7GCJP8uT1yUorxjmxf2UYUcS/fnND5wHf02w2UQw6+
         pyS+y5HtAQk/edaaqCav0S92CY9WrQKe+NqCkcDqwlX1pNtQ9RcJ2BlYukRC/8ZNVDnZ
         tILg==
X-Gm-Message-State: AOJu0Yx2L4jJfOOUJEQD5p5UC+qa4gUyU+LXwnZi/gVXyKw3malcm59y
        fNtT4oAAST6IY7XpFMInjptYyg==
X-Google-Smtp-Source: AGHT+IFPAYsS+3Q90NdkawUry/4+VPXvQMzxK9xLwfsFu8FD0fPVJMXOGVG1TtOJ8nXpO/v7IB8/lg==
X-Received: by 2002:a17:902:c950:b0:1c5:db4e:bb2c with SMTP id i16-20020a170902c95000b001c5db4ebb2cmr107551pla.64.1695403740357;
        Fri, 22 Sep 2023 10:29:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902a50400b001bc676df6a9sm3728000plq.132.2023.09.22.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:28:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        David Ahern <dsahern@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, dev@openvswitch.org,
        linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 03/14] ipv6: Annotate struct ip6_sf_socklist with __counted_by
Date:   Fri, 22 Sep 2023 10:28:45 -0700
Message-Id: <20230922172858.3822653-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=keescook@chromium.org;
 h=from:subject; bh=2ca9VJgIAhIuAJFgWJCeV9xORJcl3qwKnOZDA8bb15U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7W7yeFnrNv8DYkf6K4e0eMtWV9Ow6AlOLTo
 oQ0W7nV+tuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1gAKCRCJcvTf3G3A
 JuwVD/99skLCWI618iB8ZWCJjHBr86wQXUIEC3QazU9r6E9O7WmV0Ca/Lf4PWUdmKTLzg/NbH/u
 PxF+kuGXZ27LalW2q5dPBeBElEVHRSJvFP2s41TixGzuoc5Xdrd2dEXv1qSLw/Rjy4Xd2e8J+Qz
 buwXxllOFRxP4mw4JWs4lNcQsjzWCGDuY2kxs9HEPNcCaYeWz7/iHab5eXWQPMJa+FdS9adHHsl
 wpkVBE9c0Gr5oR1ONhxCz3l7LLoQvKYOrRcpV3r5cQY2UEhswD9cwAzi1ZMkGsyUi4Afuw9CR1z
 /5Jvu4yVaonNtxPE6LiYgQJA51cSvzH5xESn+y35kK8kyTade6JnWBm5Q4rXdyWk+ugx65LbkwS
 fx9jcKY7HamgjyBzwEkaX9uhOGaXzINDTENvp1r/aTCWmR9YmiE/jDI8aRFXiQljqz29BmXk5k/
 +T4OSX+S7Zp+e3WWMAmyMtg+a07jEi02oypRoZQdmGu7CcKNueojV959YMXDu2dTRVV4M4y1lX0
 WYVzplIFKHsZsjYKtUu9Qd/EBvBXrRNdvkL+Ecy6CzUv47Xmv1U24pUA6t/OG52eSB0WL2c301l
 NVQbrUOCSH9rcq6GuhVo/p+W/5eVeCs+cRKjQFm/pVPZguH2LfFggOeb0jA1vRwuZcXv12dUNlk tsNd0bZ4UfjHBvg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct ip6_sf_socklist.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/if_inet6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
index c8490729b4ae..3e454c4d7ba6 100644
--- a/include/net/if_inet6.h
+++ b/include/net/if_inet6.h
@@ -89,7 +89,7 @@ struct ip6_sf_socklist {
 	unsigned int		sl_max;
 	unsigned int		sl_count;
 	struct rcu_head		rcu;
-	struct in6_addr		sl_addr[];
+	struct in6_addr		sl_addr[] __counted_by(sl_max);
 };
 
 #define IP6_SFBLOCK	10	/* allocate this many at once */
-- 
2.34.1

