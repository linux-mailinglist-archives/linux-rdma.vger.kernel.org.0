Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46407AB73A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 19:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjIVR3O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjIVR3L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 13:29:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B140C1B9
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso2274711b3a.0
        for <linux-rdma@vger.kernel.org>; Fri, 22 Sep 2023 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403743; x=1696008543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8+zsDKqPYa5khoeQ/X2KkaY8mmY8r9M3Aj1MNqbUX4=;
        b=PLUE5dDTqFZ7VWtRtpwVm9vtlfkwNL8vm5+TsbEpX4W9qLxjD3SFs+58HPEu/XteGz
         MCx9O7xaoxTNLet5Z4OaiMPRwxAUCBZdQ8DarEJ3GdmPNnwtJBBqEctDmkm4XFTbNqKc
         93hoJPOkUOrgybb0baWj/GLs2XjeIkT5RSgyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403743; x=1696008543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8+zsDKqPYa5khoeQ/X2KkaY8mmY8r9M3Aj1MNqbUX4=;
        b=BwITyHgxn/jsD0AjQvWCimEzClWs14nENKTHvqtWkqNRexx1K0HH9uyfL5xV/BT/G7
         X7xmTgvodjkTTsfgNF5n/EUIi7tUkDc55Faiu2Op4WIrp3gQUmOhAmOobyVRYj6XmDQw
         Dw0EFv8cLCtc/7vBbUdLSyfUiQEvaN+UVnDOexB0qJN0SwndwfOsQ3I39V0V+gBa7xVH
         BfLv1crxTAjU5rZJGNAn/lbzqzCFzhCflYzK4UC+QMuhH1nxBsZji8hM8kHy+7MqYyof
         FPFPuQ7L/pKjMA6uXXIkWx3Xwalimru+Tu19dJ7u8cnQzZSGUJIX4kxekasYekYmYEXy
         5IRQ==
X-Gm-Message-State: AOJu0YxFGjcD61VbtgrJT4wi3B0xqOLnWMjW2Nj55aQzJUXsepqJz/fo
        pJiNvWuR8QjdFVztWqa7pXis7w==
X-Google-Smtp-Source: AGHT+IHy7einxOZJqzMeGrtUp41zCyAYhfTGbgIj6G7ktKqXoRq3UXI9VRRfBIaYo38BL3FmkYPa8A==
X-Received: by 2002:a05:6a00:847:b0:68a:5e5b:e450 with SMTP id q7-20020a056a00084700b0068a5e5be450mr72319pfk.26.1695403743180;
        Fri, 22 Sep 2023 10:29:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y10-20020a056a001c8a00b006926e3dc2besm2777741pfw.108.2023.09.22.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:29:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
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
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
        dev@openvswitch.org, linux-parisc@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH 00/14] Batch 1: Annotate structs with __counted_by
Date:   Fri, 22 Sep 2023 10:28:42 -0700
Message-Id: <20230922172449.work.906-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2504; i=keescook@chromium.org;
 h=from:subject:message-id; bh=tD+5se4WoWIAJwEPLvlJBN6wlUKoasq6Szn6nibv1zQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7Wu+d5o7777Jp53tWR0nER5gmlkAVoVjoqh
 J5JIlgoeMOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1gAKCRCJcvTf3G3A
 JrqqEACeFuiUMDgjhvtyqa9O/ntgqeTDML08nWyLGJ79aRe6YFXyHEddM/LbmREWkrtJUThTPL+
 5cqYB5ebSIzmAdm4jbres07kHLFvt+2wcfmJa92BLomL4uPyqTUFXgn1mSYnLrb14IzV3e88Sx0
 dEDq9SHrXgKyFWkQfaC7RzupSY7nGw1X1Fv3+vLo/ofLr89BRjbc1wH0tOJMrBPr7asUo/F7eG2
 7lxjFPkC1mLDulQotR5dcnl637i1mztV/DHfJlCRJQwcUcE/rH65VJ6UPC1PCNvc+eqL/CMKwKM
 T9iKyVQLU0gOVexJO+FPe5rDRoi/YrXfznJqI0MZx9L7MnZqanTpbTbIIWmdObv8ciWWZz3S8K/
 yHSIfhDofc7jQmUJnSJywpwkeAUyF50SOAkYngCVfxzswzgtYznLShCCbrSr2PLyVIU3xwoNL1F
 GJNRC4AJkef4eAA0hMVt6HF0UypVDq3Kvny+Q0xdl+MznPGBX1NQuKAvUri7Y8KGZ4yVf9N80Lt
 88tUHrZopBg7iXoM1qSKMZPHxRK5nqMN/qqfUi48CEB5SZ8IzvOnLAvs7qd5FBCO4P3/yH8OWBy
 blZo4EB4+EAYhVbu8a/RM7O+YjAH2q2muPkUv7s/sP9KxF8m7FHQgFogan1njOplS3zYEN8SVhu
 HgXxG8g LJHlR5Bg==
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

Hi,

This is the batch 1 of patches touching netdev for preparing for
the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by to structs that would
benefit from the annotation.

Since the element count member must be set before accessing the annotated
flexible array member, some patches also move the member's initialization
earlier. (These are noted in the individual patches.)

-Kees

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci


Kees Cook (14):
  ipv4: Annotate struct fib_info with __counted_by
  ipv4/igmp: Annotate struct ip_sf_socklist with __counted_by
  ipv6: Annotate struct ip6_sf_socklist with __counted_by
  net: hns: Annotate struct ppe_common_cb with __counted_by
  net: enetc: Annotate struct enetc_int_vector with __counted_by
  net: hisilicon: Annotate struct rcb_common_cb with __counted_by
  net: mana: Annotate struct mana_rxq with __counted_by
  net: ipa: Annotate struct ipa_power with __counted_by
  net: mana: Annotate struct hwc_dma_buf with __counted_by
  net: openvswitch: Annotate struct dp_meter_instance with __counted_by
  net: enetc: Annotate struct enetc_psfp_gate with __counted_by
  net: openvswitch: Annotate struct dp_meter with __counted_by
  net: tulip: Annotate struct mediatable with __counted_by
  net: sched: Annotate struct tc_pedit with __counted_by

 drivers/net/ethernet/dec/tulip/tulip.h            | 2 +-
 drivers/net/ethernet/freescale/enetc/enetc.h      | 2 +-
 drivers/net/ethernet/freescale/enetc/enetc_qos.c  | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h | 2 +-
 drivers/net/ipa/ipa_power.c                       | 2 +-
 include/linux/igmp.h                              | 2 +-
 include/net/if_inet6.h                            | 2 +-
 include/net/ip_fib.h                              | 2 +-
 include/net/mana/hw_channel.h                     | 2 +-
 include/net/mana/mana.h                           | 2 +-
 net/openvswitch/meter.h                           | 4 ++--
 net/sched/act_pedit.c                             | 2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.34.1

