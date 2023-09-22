Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457257AB73B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjIVR3P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjIVR3M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136D1A1
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690f9c787baso2126330b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403744; x=1696008544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMdpD2QebNkOsgnE+B1fw20Xf2QOBM+P6FhfFtclzIg=;
        b=BB/I1Q483yevgKb8WaZQteCVUrqAF5hbtfEQvNG3tzr88AvV1Y9i0Lwv1fnsn7tWHT
         /FsF83Xy9hAAZxfHWyLdkx3GS8GLXkD3BvfHaZBlrPmEXdg4tAWdo9Y664sH/deKzSox
         lhJRawa1np+IXCRxUSlYPuapCOdz8lDqtBHHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403744; x=1696008544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMdpD2QebNkOsgnE+B1fw20Xf2QOBM+P6FhfFtclzIg=;
        b=BvwMRVnWE5WCX5mqC/PPCbAiZ4HTUhTfH/3GTgfl8ClrRPfsq2I1xNwAbfUM3m5S7m
         DHLsX6hecq0xytU9HZAG/Jk7nqb1Mu+DKzM4uH/bQUNDuOOAawWj0NygGTBmRZkShUVe
         B/J7WRjq6ctCwmVCicTpZbu/oxcBDgV/ENScOGW4KADqKMuxHPhdWtea9fas2TXHdS+S
         UNVJJqD5EVUeTu4Oc29eJQySUE/6uDE0J0JkS/jwTcTXtSXs9BQfuJS3+/KXS945ohRj
         6D8b+AcPdt6LbrgZcRBkRYOsIh02MPHmZLY4jMTtdREqZ1487wwpkU6BRpdb7rbRSA9W
         3xpA==
X-Gm-Message-State: AOJu0YyitpLLNEi77sn2Z5qsmfiW8EJpWkKGRf9lBX+S9nQ8VAkWX4e+
        cJR8LVB1ts10ARAWO52ib/YbmA==
X-Google-Smtp-Source: AGHT+IE7SiO3xmHQebRTeKr6u2llRvZefk5GbDgDG8FNiA6+zRP8f3eqt7sS8yR1NszsLLOzc2SOaQ==
X-Received: by 2002:a05:6a00:1a0e:b0:692:822a:2250 with SMTP id g14-20020a056a001a0e00b00692822a2250mr28989pfv.17.1695403744255;
        Fri, 22 Sep 2023 10:29:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x17-20020aa793b1000000b0068fb43a72c3sm3467049pff.20.2023.09.22.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:29:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        dev@openvswitch.org, Jamal Hadi Salim <jhs@mojatatu.com>,
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
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-parisc@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH 12/14] net: openvswitch: Annotate struct dp_meter with __counted_by
Date:   Fri, 22 Sep 2023 10:28:54 -0700
Message-Id: <20230922172858.3822653-12-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=keescook@chromium.org;
 h=from:subject; bh=BiU4XzbiAmb0MDODFTqS+z9raCbhz1/gL/I9iNWiJeo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7XW5+OhlRV9ltztIVdWSZfQphqd+6c9qMdL
 7vc0r03kUuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1wAKCRCJcvTf3G3A
 Jo45EACgakJgI+sZnaQ9PKs7A9coyV/LfTrR7Tn0iFc54pO3XUL1r/z9PwrqOMnwgg56WgY+x/A
 6wFtA4SvikdsEw+xxq96vPUVGo15juErm8BPenaa6w7xcVox6lBW3DHkk6dKBlnngG/e/l5dzFX
 b9M05s5ZS1B4lBNxV3ahit+iBwnkpz5YJ8yqXyzRSXafim1Yze4lLaYBb814XrbLfGFD8vKvK5B
 zJtL0DY0TP92fqKFSbxZUhgUj4gnHDyn42YLSh6fpDiX102rTfPlTwL9GdrVCY/S8v6iMch83ev
 h3fqxds51Iz0pQoMO1yA7cjhwvntVVp8f+0u9ZpNiGv9ABUD53tLaooQiqGxCsUieaH8pKCX3Pe
 ZvbmdRRr64tiiwGpP7qpIJhpd0x0o3tBG+KW/6VpsGTUi8WO0e2/naRltFUeYszXsrfaox0Lmx/
 0g+KLMPDqCrPljPQX1rq/q0g0O3YvtBRFf6n0Vj1BGXjiPFDnDZTMBbmROt6gmu02tH3QmI10KT
 SKkI5QfmIvHyeZlB1c5uxIXSgrcW6W2LX/N+L8zKFpsuAfpqLQzRv7eL2TrstY6mOzOLjCekBP9
 wTZVKBfYr3rKfwrThTcEzg4kju0sWqQXCmWR2DFa0SBDvCWjr5+FL24z85HcEv9ne8TmjWy3eXc LALPKshX4VtbROA==
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

As found with Coccinelle[1], add __counted_by for struct dp_meter.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Pravin B Shelar <pshelar@ovn.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: dev@openvswitch.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/openvswitch/meter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/meter.h b/net/openvswitch/meter.h
index 013de694221f..ed11cd12b512 100644
--- a/net/openvswitch/meter.h
+++ b/net/openvswitch/meter.h
@@ -39,7 +39,7 @@ struct dp_meter {
 	u32 max_delta_t;
 	u64 used;
 	struct ovs_flow_stats stats;
-	struct dp_meter_band bands[];
+	struct dp_meter_band bands[] __counted_by(n_bands);
 };
 
 struct dp_meter_instance {
-- 
2.34.1

