Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905217B096C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjI0P5k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Sep 2023 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjI0P5j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Sep 2023 11:57:39 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1444F139
        for <linux-rdma@vger.kernel.org>; Wed, 27 Sep 2023 08:57:38 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ae55c2e12bso2049187b6e.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 Sep 2023 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695830257; x=1696435057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U12JJAnjiahk1YYSHY2AOK7uoafy6UzrARbQWR95I14=;
        b=bf2cz5qAyxBKuen4poe4AulrKtPhVsoYbGpbG87L6/WPrnH2OUdWaQMyL1qFw2LJFV
         PGxYn/tUIqrbHPLFOCSTCOhB3IU1f2Yml2KnwFGBQGhQs4abfsooawFYQcKD1xPigsYM
         UH9PDmXrOq3W4PL856fvR58aZd65waeoseMzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830257; x=1696435057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U12JJAnjiahk1YYSHY2AOK7uoafy6UzrARbQWR95I14=;
        b=IeaLQTX7z2yMmMP/OHgLPV+UP98xplZ57nw4gKBpKD+5ueoCsZrAjmZVR3FP49KyBK
         J5yHsrhaafa2JgvsPVYpmzOmSCqW0Rgg5LfeZLUpAfpckG3v5ZwqqMxSqrDPQjn3Otzc
         Ukmx1+ScyLMJpUTROWigmv0I1zcANWzCox/XayBB+Sy+glPGVicCdg5VKyIXpfDAWgXL
         UvGr9CMZ+u5B50SPysranmvTIvSnwGZMBIv7ANALm59KgnYNOIYgFzVmZcU7uTC6WdBa
         jxJntKZY1lW78RsYUnY/GwdHLt5ttiga+nfx1vvIBIRdzmD1tST5OR8XJ5I+PsNxHGh8
         i3qg==
X-Gm-Message-State: AOJu0YzaARbf4V1j+8amVOze1g4KHcV3VQgoTj+Mg1qJ+5q5IkEgXqrU
        hniw4lfnc4yaaFzg6T50Xi4haA==
X-Google-Smtp-Source: AGHT+IEwJW0cXq1CpxTK5Y460G4lfkt5QpcCMRT3yT0/yChvW5lXfO7XfXAcPyN2gr3gGMerxBJmgQ==
X-Received: by 2002:a05:6808:1807:b0:3a0:5e17:4311 with SMTP id bh7-20020a056808180700b003a05e174311mr2931489oib.5.1695830257420;
        Wed, 27 Sep 2023 08:57:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bf25-20020a056a000d9900b00690ca4356f1sm11628516pfb.198.2023.09.27.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:57:36 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:57:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
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
Subject: Re: [PATCH 00/14] Batch 1: Annotate structs with __counted_by
Message-ID: <202309270854.67756EAC2@keescook>
References: <20230922172449.work.906-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 22, 2023 at 10:28:42AM -0700, Kees Cook wrote:
> This is the batch 1 of patches touching netdev for preparing for
> the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by to structs that would
> benefit from the annotation.
> 
> Since the element count member must be set before accessing the annotated
> flexible array member, some patches also move the member's initialization
> earlier. (These are noted in the individual patches.)

Hi, just checking on this batch of changes. Is it possible to take the
1-13 subset:

> Kees Cook (14):
>   ipv4: Annotate struct fib_info with __counted_by
>   ipv4/igmp: Annotate struct ip_sf_socklist with __counted_by
>   ipv6: Annotate struct ip6_sf_socklist with __counted_by
>   net: hns: Annotate struct ppe_common_cb with __counted_by
>   net: enetc: Annotate struct enetc_int_vector with __counted_by
>   net: hisilicon: Annotate struct rcb_common_cb with __counted_by
>   net: mana: Annotate struct mana_rxq with __counted_by
>   net: ipa: Annotate struct ipa_power with __counted_by
>   net: mana: Annotate struct hwc_dma_buf with __counted_by
>   net: openvswitch: Annotate struct dp_meter_instance with __counted_by
>   net: enetc: Annotate struct enetc_psfp_gate with __counted_by
>   net: openvswitch: Annotate struct dp_meter with __counted_by
>   net: tulip: Annotate struct mediatable with __counted_by

I'll respin 14 and add it to the next batch:

>   net: sched: Annotate struct tc_pedit with __counted_by

After these 13, there are  32 more patches to various drivers and
protocols...

Thanks!

-Kees

-- 
Kees Cook
