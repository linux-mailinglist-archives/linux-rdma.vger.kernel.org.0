Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BDF7AB7C9
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjIVRhX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjIVRhW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:37:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323BB192
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:37:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c5dd017b30so17085625ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695404234; x=1696009034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHy2jcM546mf5Nw3NjJJcdsZQ6G2F/rbr9BMeebO220=;
        b=O5SzPZzR+6krEZXkmLIZZTVGxbfzwGuhhb08vBfcktRzZgV0OhjSFUeS0eNJO58Za8
         5N2zT2pbwLPH6hOkI/uctlcBJBVMrN7HhBgSjMZpbt2EyzJWaVA97YWO/q//rd7zJGMe
         SwlHcfYj/6zlOKAkCMq3llOQu8AA/HYzpgc2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404234; x=1696009034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHy2jcM546mf5Nw3NjJJcdsZQ6G2F/rbr9BMeebO220=;
        b=R67GntF8C9snM5rekZZklmt7bARowJcyNtE33WunykQQBfNySKk5oAb7ezXE68qsLP
         /O8UVGpqfl7N74cCitvu7Ksugnz7v2gOT6kbz3oTy/zWEL5/CoJaoeEeVQRpIumVQkda
         3ZN6m6/rO0l3j6hEBtpp3u6gbShSLnnggEY0khu1oCB7jv1NKecSzs2GkzkzU754Optr
         WMVZHdauPeLrWVZIzDGSCPwbW0Ib7NSXtxXWAQVS+F4lCk6tMzxw03+8Ldcr+P+jSAi7
         JDMLRWjSPjkjJrOYtIBxBVGF8LLR76T02oWpdsOttzpBQfCCXJIda8+yHmf1b459eurI
         XoDA==
X-Gm-Message-State: AOJu0YwSlQIukABRZ4MLLFA56vmHac5qPU8aQwOYPpPICBgseGH7CXGl
        wjDr2/te1CYkPyg7cHL0J89PLA==
X-Google-Smtp-Source: AGHT+IForaNfEngbgYzLn0XvlHSaSBMfd2+hDVPVDP0+7yMW2kQR3T0MzlrjAe6sTlVW6GLIrm0kZg==
X-Received: by 2002:a17:902:dac1:b0:1c3:e4b8:701f with SMTP id q1-20020a170902dac100b001c3e4b8701fmr479521plx.19.1695404234658;
        Fri, 22 Sep 2023 10:37:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709029f8700b001b694140d96sm3771126plq.170.2023.09.22.10.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:37:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
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
Subject: [PATCH 11/14] net: enetc: Annotate struct enetc_psfp_gate with __counted_by
Date:   Fri, 22 Sep 2023 10:28:53 -0700
Message-Id: <20230922172858.3822653-11-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=keescook@chromium.org;
 h=from:subject; bh=UT1ZdosG6thsQKbZuWlvvKtNoMV5v4P0vRQDHVv6AlQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7XSQgN5HFuzDmTQh0kuKGN8VvhxLvLNcFeh
 bt51QZ4mKKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1wAKCRCJcvTf3G3A
 JqYjD/9GzxaHc4IrVjUkBj5/d8FeY4MZoAp8KPJKCM4E/stoQ89RWnkxPvXs2ub51LtTAM7Q8Nq
 952ZRLOpGoccIMFSjcVlpFYlDEZRIMMkg06PGDQs8BLBgRp2Xbo/GI6r0attHGC5ruXY6R1djKy
 TJbXDQFFgVuUfCE3ZiMZG1SgrWkLCsxTlZFBeXY5+pEEWOp6EaAQULbpmh8/N9D4gZE1/vQgF0E
 0nrtThbucWqOv2lWVWoESP8KBQ2hbiP04yjKp5QhnvG9ai5TJ7czKEGFFzfw+6WlMuj3ohAC+V8
 eRoArmKj5/q8DXUTMOGzNsFBobqrSbgfMk+Fu+dvyK+gxTw1urL7a54Rms23bLytd1W3qsH4TdV
 MjqSkdW0hShdhKqJxvRMw9H0OSSv2T/191tK8eFarSmolgQCBqQkjQN3HORH8VsB7NK8Rls+AZZ
 ZNO99qTOvddCRUmOlsJli6YplJtOWudvU5OVaGivwWMqWzCqGnASdsSFHSQlyO0vGgy05UCTaTk
 OlgQNwhDSjtZX7ZovqyZY56wRJXHkVTd8P76Qi0s1d5yI9hxyzGrFnUmCrlF0P8oGHQIJh9h+HQ
 9WKEJyCgyiKmb4+eBOVQnfxP063FQtmEVJl/nVl8B4+NKlYVWjZ0PUztJwDm4Ir6xg+DibLIp2O wM3jkIQFKhrIJvA==
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

As found with Coccinelle[1], add __counted_by for struct enetc_psfp_gate.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 2513b44056c1..b65da49dd926 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -443,7 +443,7 @@ struct enetc_psfp_gate {
 	u32 num_entries;
 	refcount_t refcount;
 	struct hlist_node node;
-	struct action_gate_entry entries[];
+	struct action_gate_entry entries[] __counted_by(num_entries);
 };
 
 /* Only enable the green color frame now
-- 
2.34.1

