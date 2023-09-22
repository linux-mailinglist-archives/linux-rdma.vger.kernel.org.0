Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073E67AB769
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjIVR3n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjIVR3R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15201CD3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-57790939a2bso1704226a12.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403747; x=1696008547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8wcxdgkYAvkCOCoP6EB5xh89rywD8lhufIcjStIsos=;
        b=K9gwfT3q/qgboUPNthyJid9JOGy1mcVoGccSt914InaP28QcC/on0g3lNtGgwcry6p
         ErxmNSrbihsHEelKeNEqYEw+TX37ed7kY1MdLA3fqR4G7GXSkgJ/R4VyeQK2MOBWBF6z
         t9JxmsvJLC0m0ls0rpLgqGLhix9VJIURcN2aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403747; x=1696008547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8wcxdgkYAvkCOCoP6EB5xh89rywD8lhufIcjStIsos=;
        b=K5Zu6vgilIdJ19HUV2OxpbxkSjPKwJiBNhh1J0WtiezRYBkkO6N/XccPx8Wp5VvHeL
         FnTeNzPLXgO/AUACmdMEKp6/LplNRWPHILnuRKUMLivl40k0jmxh61RuQpPPf1CrN/s9
         u62S/Op86yjWnBZYRLSXOG64LwiHyhWNG/OlolfA1EQ7j6crSXTJYtO0/VVKwku39wIC
         yc7xhIc6U0YQn+u/O+R8JD16IfMLzKOmeeI6xPpoipmG0U7fHaSmoYu3pqhPY05YeHOs
         d+ObUh8Yrzf3HZ1ZDgY0jn/Zv3NrdVTl5HhqMtgipBw22nGS35l7gzDNxcVpcdJLnugC
         ARjg==
X-Gm-Message-State: AOJu0YwuAxlL5J8GHtOT0EUO6s825wytaAMKZbjQ3ou9H4zhabGd+Il9
        JW4WJOoYBdi7wkHgVHxD5qqfPw==
X-Google-Smtp-Source: AGHT+IElpZNjY2TGipiQutTff+ugw0APbFwNtO/dCFekhNu4FwvwZxuRlHmJbXr+4aj61TxA1EODzw==
X-Received: by 2002:a17:90b:350a:b0:267:f094:afcf with SMTP id ls10-20020a17090b350a00b00267f094afcfmr382935pjb.12.1695403747365;
        Fri, 22 Sep 2023 10:29:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id on16-20020a17090b1d1000b0026cecddfc58sm5168623pjb.42.2023.09.22.10.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:29:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        David Ahern <dsahern@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH 06/14] net: hisilicon: Annotate struct rcb_common_cb with __counted_by
Date:   Fri, 22 Sep 2023 10:28:48 -0700
Message-Id: <20230922172858.3822653-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=keescook@chromium.org;
 h=from:subject; bh=1a7NieutkFX6AaDPkEeHOZVHEoHBt5bQcCIJutpCWUw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7WrIx18IVUGp+00bkbeA7+GMMa1sOqiyBAN
 /AV74Ua6mWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1gAKCRCJcvTf3G3A
 JtWVD/0YjudsxRE+Gn/6ufjGzrUTJPOLYENG3QXjmKKMjykihDhpS8roKUz2639IJQ3ofG2lpRk
 pXxt1nWBR3nqg+5tD17nHNX5VrKywlSBPf5mb3whcLu+0iyWDcCOXNHRNmjXVj4DsvbXClNK+s2
 axrhXO/7+2urhIqPiZBSj8fZ+gMdMkGrkTBOpVOlpXCI+ALT+DTMX6XrGCT9blczSojxLyMi+fR
 56bjaJ5DQmkfNVF9FbmQqkz1kvtSMt8EJZgAJQvO3Co2nhnYjG6aWv7Co4NraY1+y/uXZ5UM0Wf
 CS3m75U8q7P31UyY0cYZZBAOAGYs7vDBolcGl0mkgZpmulcb2JGvtrCQtJbSX67BqG6ABbzt0ua
 D+v6y10gAogt3nTCEqz+86wi6NATANnhftFkrO/hMg5JH1ULZskFkOHKabuV8Q0h2ZtE5tIcnuJ
 MmFspm4sTsM9Wt/0MPN1VfS0UYoTpeMjQEpZYVztnxaTa4vFLrLf3YCRTllV0iflQJtbLe671v0
 SepA6Jp/5ELNjbuHEwQ3U04XAtLLSsXxaHj9U/t0HrxsKL7gOXQ0lPrqAVCgVPw9PRh/cNTIIky
 mCWwUUCQMoVQOj63jYvTKofBHWWpzbkDdCd6A6q0o3QG3sbwrilQzwD1k6NViARVdu8Js0Qo++i 4um6OXwKgBbqLEA==
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

As found with Coccinelle[1], add __counted_by for struct rcb_common_cb.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Salil Mehta <salil.mehta@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
index a9f805925699..c1e9b6997853 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
@@ -108,7 +108,7 @@ struct rcb_common_cb {
 	u32 ring_num;
 	u32 desc_num; /*  desc num per queue*/
 
-	struct ring_pair_cb ring_pair_cb[];
+	struct ring_pair_cb ring_pair_cb[] __counted_by(ring_num);
 };
 
 int hns_rcb_buf_size2type(u32 buf_size);
-- 
2.34.1

