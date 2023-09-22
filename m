Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995D17AB739
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjIVR3M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjIVR3K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6AB1B4
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c328b53aeaso21860205ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403742; x=1696008542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8x7bQDxEJ+vAEVTZtm+5duUGDbyuhOyRqLHGlsgE3Ss=;
        b=Ywnen8g2tiuhXANVYCzELEjXyAfBdmz7wrxzvByFd4e+cAlvTetJU/gEUkd0usSnOS
         mKtOg5Rtl9rPoysu7p3c0KeVLFNv+yA52V1KHH3XQFxzdjlCDkGbeG7TKnBR3Erv/+65
         wHMgkQdjjlI0MZdp8enNYnhCgGIt60vTo1bpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403742; x=1696008542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8x7bQDxEJ+vAEVTZtm+5duUGDbyuhOyRqLHGlsgE3Ss=;
        b=uyhbDXdouUKj0Xt3kag7hy+ljS1zI6rq1zM9/wHBNQ+Ucp93sJLEr9Qno2hzJXldVe
         wbZnGUq/PJAP0IBENWPVD+Uw7u/INV1nXjLvUSf5mE/Aoz2LYaSWvCKKtgtCXWnPqPMB
         0UrrTC+GLBypov+N/FuA+TYyoL4MMNHapDEUPQOHGoMKoRRuSCQUf52nd88Pv+OCmuTC
         9Y72Niq9gEaMhBCQmEhmxuwWie7hqdwPy7sDBYJ2OUKb/oeBoRtza83q8mJgx4ZQwz8H
         aW0Cu/IUQTbmCAk8gM3wjI3PLnqD9YDP9VpgvTp8cS4rOIlVrz38jwEyyhulsq0vvYIY
         fQwA==
X-Gm-Message-State: AOJu0YyvjfEA2V4b4bxkqxOTrn22ZpbHFRVGMgDzzvgST8M6WKYnLHB1
        VSmOXpOA/aP80d1xmy2CmCtDIg==
X-Google-Smtp-Source: AGHT+IFzSMnvDIESRN4yrkqhjLkFIKKbSE7NjQEASQLGImnZEz1ARsCxE5ryuRl4UpC2Wrwek2xicg==
X-Received: by 2002:a17:902:eb53:b0:1c3:df77:3159 with SMTP id i19-20020a170902eb5300b001c3df773159mr114541pli.50.1695403741978;
        Fri, 22 Sep 2023 10:29:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902ee5300b001bc59cd718asm3748963plo.278.2023.09.22.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:28:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Jamal Hadi Salim <jhs@mojatatu.com>,
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
Subject: [PATCH 01/14] ipv4: Annotate struct fib_info with __counted_by
Date:   Fri, 22 Sep 2023 10:28:43 -0700
Message-Id: <20230922172858.3822653-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=keescook@chromium.org;
 h=from:subject; bh=dITmoQTmuhgzCLWCT8goEHfc7A830wvh1pihCZiDgng=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7W581CiX0BzIe+nRF4lrrgJ1mImWjZxMUky
 lhl45FPgwCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1gAKCRCJcvTf3G3A
 JkxgD/9FJt5i+12b1FsimGOC4rvZuSOh0fD5qHoltugSaCw499cKIkWY4qGZeYvZrUk/VYa+HZI
 Y1E1zplO4VIUWFc80b9mGipW2Q54e6MVVeAovzcraatq2BSOVpOWRAbSUY281k44af6Gtf+2mBs
 WOWy65xHdw0hvyD8jqTd8MMpVfq9wUgJiUSRlTX2yvNlUL0CUR9xPOI9i9pvWG4C+OnvabSctpb
 ixyKCTDUXy3+CJoyEA5Sit5mwYWRoegNNcPDJNKvMhzUEKMeyEEhoOPDDaPF8pRrfeQVX5KV756
 E4KlQi7c9BlvkTwUI6fnYnOoxKi+4OS+60VRBt0svnxPupKqu0zr+DNDORx0bln3OZmq528yFTh
 8ZontT0IXYdHSjmkO+UEJKCl/88D5e2LgwJRoj5gYxKcE9JqS9WQffGYcokW51pOUfGKBT12r4m
 dX2Hb24VXL3BJb5d3Gn1VmDidQgp50eEBiimYRKDfH4ItKrIyLysiwe6PcDNknkDIbAcjQF9Irc
 35iHi4lgvDHPBz6mDA4C6ARaURw/bvc7EtRzuRePO38phoNlzDwep1XxUQiBgjfK12Pm9o80j79
 SNVi44GUOM1o9BuXUhT0KUHCOh+ALyuSPWw3T8gMYKvOu+OU341Y5Tjavk2KgvxyGjew6YnyYDs ylWk8JpcjP0A8zw==
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

As found with Coccinelle[1], add __counted_by for struct fib_info.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/ip_fib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index f0c13864180e..84b0a82c9df4 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -156,7 +156,7 @@ struct fib_info {
 	bool			nh_updated;
 	struct nexthop		*nh;
 	struct rcu_head		rcu;
-	struct fib_nh		fib_nh[];
+	struct fib_nh		fib_nh[] __counted_by(fib_nhs);
 };
 
 
-- 
2.34.1

