Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA827AC1B4
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Sep 2023 14:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjIWMJa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Sep 2023 08:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjIWMJa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Sep 2023 08:09:30 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80D81AC
        for <linux-rdma@vger.kernel.org>; Sat, 23 Sep 2023 05:09:23 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-76c64da0e46so137954739f.0
        for <linux-rdma@vger.kernel.org>; Sat, 23 Sep 2023 05:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1695470963; x=1696075763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAvg21g6nbbw1h+/pTYxIjGaQhk7mPIWAIow3O+el8w=;
        b=DLxn7//6yHMxeoMVTrr0qYfohGScaeS52o7/UDk+9PW6VThFl68e7D6/DbtAvdd89d
         j4tPcCOJdhW7AV9sEMT1a9YVpIa+LScQn5xrcjXeP37Wdw/wFTi6kNGdSm+uvfNLea7h
         iXPnp5mpMKN8gLjueJl3kO8wLSx9cueoTjppc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695470963; x=1696075763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAvg21g6nbbw1h+/pTYxIjGaQhk7mPIWAIow3O+el8w=;
        b=dlf8szewigB+TFeE3VmSE50dl/KEbUmsJmriYDi6oEWm/95k06h9eJWBFAYHMhlRYy
         ZAxGQlm8gNVf77a2NHxdtm59LeCO+vnupHKISkTW7kGQOZbDR6DzNPVk0TppgEStZ8SI
         HQJ5Q6U5dK8jxNhOnk9g2+whynLlRrGZebu1CVxxGF93/Cipz32G1pujFuQIDpyZejfz
         XoTFUEMLwzrCeEDTtVA3GU/y9BHBM53u2zDYx0SB9NhGdOSQsgbvYYuczjL46728lJqD
         eVVQH26soWCJ8Bk12mCvE8QM9kyFSSUqXU3V5rIVXr/q/03jRFs7CZ5mgi3suoklNTa8
         ekEw==
X-Gm-Message-State: AOJu0YzAuqeNO79CzVqPcERr6XNA/alidexAWq9cqxwcCLrStHxBFaqs
        4o9HFVQO1L1NZILq709WpJn+aw==
X-Google-Smtp-Source: AGHT+IFsU/+zIHTFsRo6MskEzPa2bwVmahshwKY2z15uRkbrNeJwUhIadfi6G6UMDY5d9luXaBJ4hQ==
X-Received: by 2002:a5e:8d0c:0:b0:790:f866:d71b with SMTP id m12-20020a5e8d0c000000b00790f866d71bmr2106815ioj.13.1695470963122;
        Sat, 23 Sep 2023 05:09:23 -0700 (PDT)
Received: from [10.211.55.3] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id ft16-20020a056638661000b0043a21abd491sm1610905jab.120.2023.09.23.05.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 05:09:21 -0700 (PDT)
Message-ID: <6f52f36c-be16-2427-c19f-0e8b3dd2ff5f@ieee.org>
Date:   Sat, 23 Sep 2023 07:09:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 08/14] net: ipa: Annotate struct ipa_power with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc:     Alex Elder <elder@kernel.org>,
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
References: <20230922172449.work.906-kees@kernel.org>
 <20230922172858.3822653-8-keescook@chromium.org>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20230922172858.3822653-8-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/23 12:28 PM, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ipa_power.

Looks good, thanks.

Reviewed-by: Alex Elder <elder@linaro.org>

Note that there is some interaction between struct ipa_power_data
and struct ipa_power (the former is used to initialize the latter).
Both of these contain flexible arrays counted by another field in
the structure.  It seems possible that the way these are initialized
might need slight modification to allow the compiler to do its
enforcement; if that's the case, please reach out to me.

					-Alex


> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Alex Elder <elder@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/net/ipa/ipa_power.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
> index 0eaa7a7f3343..e223886123ce 100644
> --- a/drivers/net/ipa/ipa_power.c
> +++ b/drivers/net/ipa/ipa_power.c
> @@ -67,7 +67,7 @@ struct ipa_power {
>   	spinlock_t spinlock;	/* used with STOPPED/STARTED power flags */
>   	DECLARE_BITMAP(flags, IPA_POWER_FLAG_COUNT);
>   	u32 interconnect_count;
> -	struct icc_bulk_data interconnect[];
> +	struct icc_bulk_data interconnect[] __counted_by(interconnect_count);
>   };
>   
>   /* Initialize interconnects required for IPA operation */

