Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7687AB76E
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjIVR3p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjIVR3S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FC1A7
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso20120955ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403750; x=1696008550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qbLpDWUwgzzYPCRaxCJqmb/nv0TKtcjFS6rBqkmcgY=;
        b=Rmhof9VCSONI8qKtDgVkygB/9N3WKOhTVZNbN1IpQGHyy1Cm/rnPQH4RrzAL29vhf3
         3xaySxt4zTIVA2CfdsC4DkiOuyIczVoCn/OER7DaWq8UELh5Vzs+H4OBEVxC8Vc/SX5h
         bIHZ4J+TKjAavKK3Ucs071KIMcDVhPmOY1RbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403750; x=1696008550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qbLpDWUwgzzYPCRaxCJqmb/nv0TKtcjFS6rBqkmcgY=;
        b=IbQjsbDQa/i81Kzds0Ef0REWNFTP8LZHnohY9/kjZkdMYpZrcTiThbnYfum4SsCr4f
         rGforn15pMHxfmnqMzQDyvomVT+nAPc99MVWDv3uTcC9t6XRMLs1SPovfyL0SvEJjfsC
         MwNCZSHLKOZ+VwAsj67mHg+YY9sy5AgATLPkT5sqB84rLK355dIKO5rX4keZ9KSHqu9E
         AiMqIx4IcaJ9lSVmkKTAjjK8Z251m7UmN5e2QCorVGnPe6Cth7DEDTRjLeRixYoXogfL
         5uO3zmu9b2eARHjfQsKwqkAtK+4Ue88MFq2uzwXEfaaB/Hp+fGscwTSWRKU+z5ONJvpm
         Sw5A==
X-Gm-Message-State: AOJu0Yx/L+4o4V/CYjcfDwqg4psth0X8mYwQ6dDtEfAKDKWGcuqI3igW
        +xa3LVSQ1pnrIBJl2S5KrptZpg==
X-Google-Smtp-Source: AGHT+IFprIk4Oc3jWBV2j1a3pDx/Ze8ZIDNVrL59U3qfvbK8hQNgJ9g8aEnC5yMh7GVAVWbVI04fiw==
X-Received: by 2002:a17:903:1109:b0:1bb:d59d:8c57 with SMTP id n9-20020a170903110900b001bbd59d8c57mr130556plh.18.1695403750017;
        Fri, 22 Sep 2023 10:29:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ee8200b001b66a71a4a0sm3749961pld.32.2023.09.22.10.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:29:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, dev@openvswitch.org,
        linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 14/14] net: sched: Annotate struct tc_pedit with __counted_by
Date:   Fri, 22 Sep 2023 10:28:56 -0700
Message-Id: <20230922172858.3822653-14-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=keescook@chromium.org;
 h=from:subject; bh=2t/ZxOWEU2viROo1UvEVFxKv5vcCA9cvfvIY7AUZekI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7XaxqapjSBY/SPBC/x04RSUHK/UIttRsNmQ
 BtJyGkw5WiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1wAKCRCJcvTf3G3A
 Jh2RD/0dUjACoTlVEZR/rUTfjAaXcRrjdWj/jRwZhzM+BFjVVrkW2WL4vF8f3OtpT1D37kVC6yt
 5krc2k1SgI9i4EIbbTCTHDKmLHFMdeNJj5yXkZqGe2kQocQH6O2t4MI9L3hpREI1/FZbqJdfIhP
 O0VkQhiYhU7Nivmec62bTZvgzPCuVjj1QbCRx64McRRzIsCOrxiOJVxaLRn8MXUoag8JHHVtq8N
 C0GRweTtJdTEnvySnkIRdOv1aQSe9bmyu3n6UfeVSb99zjCgoSq6MzdIJIykmvV+ipPWiTOAHXF
 hgcx6Nj7vOyb/udVU8Sy2EyA+QKSJGjs4xelXxxAAt5eYBvynuKGDPq+5enCP676vNeK5lYIcdM
 tjR9wL1D90SxMp0k31niGjQQfhd2hZX207yL3hWHrAmFhKgGM58T6wcW6TJM3kyVNhw0Rsgw57I
 3Qs/3XpeZD+0L6Yz/nZiIjHP5q0ZEHd8RaV5+RBsuMFOD4sSxoz2dpbIgFlMC5M6rSM3HYp9QRu
 8bWPWgo4YgaynOSa3gYtVwkMV4winLmyJPRJ1RnvUXpyMWvyDnfoH38MZwyqVEnPdIXXbXejgny
 eDjoni1yyVaDXPOQYroF9Gf+NTE14pE11tfkIsS5+ql+igraxVPAXLcoQzTe5Q1j/7N7pAMKrKE ckNAllL+gDJgldQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct tc_pedit.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/sched/act_pedit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 1ef8fcfa9997..77c407eff3b0 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -515,11 +515,11 @@ static int tcf_pedit_dump(struct sk_buff *skb, struct tc_action *a,
 		spin_unlock_bh(&p->tcf_lock);
 		return -ENOBUFS;
 	}
+	opt->nkeys = parms->tcfp_nkeys;
 
 	memcpy(opt->keys, parms->tcfp_keys,
 	       flex_array_size(opt, keys, parms->tcfp_nkeys));
 	opt->index = p->tcf_index;
-	opt->nkeys = parms->tcfp_nkeys;
 	opt->flags = parms->tcfp_flags;
 	opt->action = p->tcf_action;
 	opt->refcnt = refcount_read(&p->tcf_refcnt) - ref;
-- 
2.34.1

