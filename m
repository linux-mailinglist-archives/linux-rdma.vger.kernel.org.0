Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7B67AB73D
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjIVR3M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjIVR3K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434F41AD
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c43b4b02c1so19963215ad.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403741; x=1696008541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Vq50cO/AnizqX6/47UHK+JR2ZlGTPocZM47T7rf36c=;
        b=X3Z5KANWvxS+2EiRKfgJM7+MZxtACYSo3V6zJ7E3dMI4fEx7GrcUwmJz0u6hM3Z5SL
         bJfIxBgdKE0PxdvrvnpzjvMCA+CLJfLoNplE0b+p/NLiTxsaQksasV5Yzy1/frz4sRFu
         R6CCLxm9CupFyFKRlANs6grhAYCZNKdlzBfs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403741; x=1696008541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Vq50cO/AnizqX6/47UHK+JR2ZlGTPocZM47T7rf36c=;
        b=VuiOh+xOjyYek4SFsCy/IDHiPW0yZ4KZf12Ena3vo1Qz74bvEe+EqaMgrHx6mNpY0d
         mqf+lNaPIfnFV/kRLNJrkbfRWlyLxFHKR/beF1smDvmitJwUTPOw8OQmiiWMjLUFUs9e
         cXKjyqytmmtgOi1Wyk4ZR1UDEET5pgq33T1sKESPQu3abnE3NKvLDQWysfgunFggPSd8
         2rCFgQA2diy03FNj1htcSoKLCAsDyzfzehRr2GkIAtIWwtu+PrnByhJx51Uds6fo3+22
         r5vek4rvh/Lza6w38TbFS7/uUGyQ44FyKvNxfUAyX07ZIOeV9XErxJbzoAe6IpjSX0Gw
         5rCA==
X-Gm-Message-State: AOJu0Yz9B00uMlYeITusvhfNbGgCJPF/A4F1TuO6Fpj7wnvPP2W12+GR
        Abc5eHABpco3NLG6D6KpWvnOEA==
X-Google-Smtp-Source: AGHT+IGfIEU2v7UoVK/0pveDwyLLNq/5vlYcu3slD85oe8s/AbnLImt7+ex2Q5RiEHhneFAOOeymow==
X-Received: by 2002:a17:902:ce92:b0:1c5:be64:2c71 with SMTP id f18-20020a170902ce9200b001c5be642c71mr152987plg.8.1695403741464;
        Fri, 22 Sep 2023 10:29:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b001bc35b14c99sm3751035plb.212.2023.09.22.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:28:59 -0700 (PDT)
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
Subject: [PATCH 04/14] net: hns: Annotate struct ppe_common_cb with __counted_by
Date:   Fri, 22 Sep 2023 10:28:46 -0700
Message-Id: <20230922172858.3822653-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=keescook@chromium.org;
 h=from:subject; bh=cTl8c1Nsj5H86YDYuCjzIM6AfXRPvipiHH9wexbSTFs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7W7T7fWYQIhp0VWwCK4vkC2/gAT7GYx0S2a
 rDc3obMtJuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1gAKCRCJcvTf3G3A
 JlguD/43W9S3RVXTT12fwP5xKbgPceVLaoFjLypFqCmF90EoMP0tlys43BbYW9AL/UdsBC/AzDA
 daZjg3W0qJcSKHCfa/fw0KI5T7Ys1zC/WuM6VgF/PnFd90CnKJyFqT9w8APuL7jJuLkioTLXFNm
 KKr/xM/Q6RpBeeCmnOPPla1PC1J7fITAPWboovdEmWaNXJDeaA/cqkuc0O/fl2bK34A2E+YRSX1
 Ga/1u7Et9/vZoGrMjL48CarwhFBgZ/07BX1Vi1ck2cFt3Vgf9vNaMYswfMP2jTL88g1pO9tP+iH
 +PtCE2i0idGsQeCIQpAEjzfUjgiVq6LSuzhhFhZxO+CZpG+ddA6MhWJBLB+OALoPI0/HszPfbQP
 tjDdztTV0Y1ijsgDX5Fo/YENa2cUZXIOSoNxqs3q7ZVixjjXKrjYgplwnqm5Nor2mYpInDP+gRr
 3Y1KSMXIduKLLeC6nxgv7sdqWJffKmjhvFAbpJi86vpkRq8IZ0BFFxHvafq4MKH3bKaPgpR4HJN
 HpHjwpAnZ22Cavskf4a41Tuxb6Vpf/edTeJBdNMHPAAUyCfy1fuc9k9ywm7blE1SvkPrxqwwiHx
 Mm3miLrMAtDE7GIEY1Cp+8oAIBA9+hZbl0or6VFDsIQkuczyrghQ+29chyaUqnLYAEIV2DL78yK qSGI6K6tMv6mcjw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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

As found with Coccinelle[1], add __counted_by for struct ppe_common_cb.

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
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
index 0f0e16f9afc0..7e00231c1acf 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
@@ -92,7 +92,7 @@ struct ppe_common_cb {
 	u8 comm_index;   /*ppe_common index*/
 
 	u32 ppe_num;
-	struct hns_ppe_cb ppe_cb[];
+	struct hns_ppe_cb ppe_cb[] __counted_by(ppe_num);
 
 };
 
-- 
2.34.1

