Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03E7AB767
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjIVR3m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjIVR3Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF37ACD5
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5dd017b30so16969115ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403748; x=1696008548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUKfzJFWh6q0Ek+m1dIo2wKPPT8An6wcKPyi6NfdY3U=;
        b=F6KsGT/HRj8jgKrpamLsL/JJCdHQJ9PFMm4dMQKPJrZ5EAXXmUuzXDK2gcfX4pBAM6
         r30AqeC0Qs9awrlE/XrmMbt272Z8nfd10dbNVmACToKhxicSMGeM7xxX26D694/C044E
         RjvqiBso+J0c/GsXJHGmEzGuwpvqET1cvb8Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403748; x=1696008548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUKfzJFWh6q0Ek+m1dIo2wKPPT8An6wcKPyi6NfdY3U=;
        b=Nu43gaQfNzR1sjPKSP4exOtMu2RPac0UdcWzmWsV4TuIitmOek8tJK9LYo6QAVqEQE
         XpQu/Z3lY//iVBZGW3kiURCdYlah6Q9hp19Ul0JPqfdBstaPrgYyPTglkgGMICE34Es/
         zFgy8OMgJVAfaiTz95cOYrT/ddMRdOjoBbhfRUeSamA9/Dl9N3kpFDYxzAWQSCORN2Js
         lTX0vBzhtrJFLUp83U2UodxWHqtfB8cGKR4uOLK1s5SJZQnLnfyHUGAaNY38m+FaGjtI
         lZmAj+kjEOpp/ZANIHZVZbyuGTnSyOZpugliFT9JhInA0FSQGGi7XgPp4Skj29ZfMhAX
         G+1Q==
X-Gm-Message-State: AOJu0Yy7DwuO5b/4VC57Qk7IQAZ7bnheMu/X1tkqV9sG4FDAyoi+brpE
        nm6/ITEzMEFPMWVR5pTiwJrxuw==
X-Google-Smtp-Source: AGHT+IGCyibTLjEgm/AfUm0AuDGTL49VzLgFtUqhI5sR77FlJ95ykxsCPbsik8woSx087XzafwMKbg==
X-Received: by 2002:a17:902:d2cc:b0:1b8:8682:62fb with SMTP id n12-20020a170902d2cc00b001b8868262fbmr4313476plc.4.1695403748467;
        Fri, 22 Sep 2023 10:29:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001c5ddd7279csm2886559plg.102.2023.09.22.10.29.02
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
Subject: [PATCH 10/14] net: openvswitch: Annotate struct dp_meter_instance with __counted_by
Date:   Fri, 22 Sep 2023 10:28:52 -0700
Message-Id: <20230922172858.3822653-10-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=keescook@chromium.org;
 h=from:subject; bh=yVCt/dKz5BWMUw1ro5PJjnSBgByAWbtJBqaTXA0zDOM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7X+PfBo/CFrx9CIslwRNLq1g/T6iItdTZ0m
 uEPDF7T57qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1wAKCRCJcvTf3G3A
 JllhD/4/Z02Qh5E1AsWcUQYDgQrJV6EJStKbe3xKeX36WGu7kXLK3ZJpKuVtrBGmuaqCoRuQH0Y
 LIDC+A9fXchOa0+EkyNUrqD3waosen08sYK8DAq7cJKQzorMGHPrYlgpzu0GyVOlgpPrkCkWL25
 ZyGk2egRIlyhXnaIb9K1978aJd4/LRJvbp2eLEs9xM6SR/NhLDTWD5jJuaULAbbDTiZQtQZqlKd
 oMtqMKn3383ruJsFnfdUK6VHz2jwI0d3rX+mqjkfAYYiIXS/pBIA0HndsmNB+moDTpUU/kv9xSr
 7wt89fwD6XfKHZwQrgW7+R473TTXac+28WJVt5R4u+4/JefIjhkKO8bFjpZcn5HQkYA2FqPvgh3
 OnDSqlYgciPAAOYwv/ykxV2mLrT3Kt/1+2yDR5LN0Zo8mPZZwf86knd1fjfedMPIzIg3obs5qbs
 WgVULRJhQzpFo95wfMxZPVrCcC1Zz573EBChjwmvWVfkemiY4pfTusbJe2538Ss+WPKUET1u/WX
 wX+COzhQrmQWby0lKx/Lv8/sfv2es2q4rH13ArqpkAdZzq2EE9DtWh2IFSr6C4MhFofvJTfXkrY
 Y1xMbqGyeFlydg5fHBFEmudern74i1KV4fukhn1fxCHiV49w+Sa2xr5JjnAoCiyw7PzomqYdi+i LVA2tNrfMOr6QdQ==
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

As found with Coccinelle[1], add __counted_by for struct dp_meter_instance.

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
index 0c33889a8515..013de694221f 100644
--- a/net/openvswitch/meter.h
+++ b/net/openvswitch/meter.h
@@ -45,7 +45,7 @@ struct dp_meter {
 struct dp_meter_instance {
 	struct rcu_head rcu;
 	u32 n_meters;
-	struct dp_meter __rcu *dp_meters[];
+	struct dp_meter __rcu *dp_meters[] __counted_by(n_meters);
 };
 
 struct dp_meter_table {
-- 
2.34.1

