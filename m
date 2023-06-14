Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED0572FBDF
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbjFNLD0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjFNLDZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 07:03:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F46DF;
        Wed, 14 Jun 2023 04:03:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so7895594e87.2;
        Wed, 14 Jun 2023 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686740602; x=1689332602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1VvkXnzVixabogAD8Zw9eGZe1OjEhrj4fiOQ3OcleU=;
        b=P9GuYPGCiY9kCbTEN/4T8ubGiLb9P6rACY4uYs7S/BVZ+4g41SXn5HdnfNZUqtcEfE
         GXa0fip3KoNQg4wy/my2Glc6O52ut7gSYwhqaCXyH42nm/BN3g6mNIh9BRV4ecke2TLm
         5ghV2vno12SlPmlMDwyXCRiYEDSFJPGh47hIHgk+PIWiKPPdzemV5qj+QV9MY/mlJ6vL
         OZoOTOt+60EwKtveG1jqOPewF8tqrPrKXmsqSo1tAoCqTr0Xij30HAF28owdBdF+U6MQ
         ERC+E+k4sYFsY9pm/52zD5dtIGplTZFBmmAeRUsokUvxb8x4oEok7R6NgwpjB6s+u6tq
         pmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686740602; x=1689332602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1VvkXnzVixabogAD8Zw9eGZe1OjEhrj4fiOQ3OcleU=;
        b=hlxjpWPRagnMZFvTSTxiQ72uqamQt+/bvEa+Kc+XxGplYG4ElTKlbGT5QuRmmPlxA+
         7bZZ1NH7na+s2UN3SWURQrUVoYs/sXEJfZ8MQ9YGNAZzB5lEz70nnDHSwNne7Z6me9pf
         SPl6gJ53EtcbFyHrGuJtTCdpZ2FG1w2AbGmxahz2/Ij2BuHoidhgg2p/LlwH2bC8MlPP
         XhaK2XxDMC8zImKhJ2jm1R6NsYO4MtGkYr8/APegXEmwODh6n6hKOilu7XnMhIAdhqe9
         cg9lnp4eqD3iIqyLsu9PEU9sCeAwFC2wDGs/QDXC+mvbYU9s5dd7ttcScLm/fEoNeFGt
         QWTA==
X-Gm-Message-State: AC+VfDz87Cmca/SVRaDYDRikfmUobqvOlT5Jn/FZBGwXYC8O6GFHdbf4
        oTfu+QEb79fHCY41R7vf8oM=
X-Google-Smtp-Source: ACHHUZ6BAvqv+lSWcly7Om4NBqx1VNZErtMW21jc6EVv6uVVkPCYxaQzJHBrItRLEfD7JnicckIZbg==
X-Received: by 2002:a19:ab01:0:b0:4f4:ca61:82ba with SMTP id u1-20020a19ab01000000b004f4ca6182bamr7337224lfe.67.1686740601961;
        Wed, 14 Jun 2023 04:03:21 -0700 (PDT)
Received: from [192.168.0.107] ([77.126.161.239])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c22d100b003f8044b3436sm16753813wmg.23.2023.06.14.04.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 04:03:21 -0700 (PDT)
Message-ID: <d51d742f-5ccf-5a24-0cee-b4467fb83ba1@gmail.com>
Date:   Wed, 14 Jun 2023 14:03:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] net: tls: make the offload check helper take skb
 not socket
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        j.vosburgh@gmail.com, andy@greyhouse.net, rajur@chelsio.com,
        ayush.sawal@chelsio.com, dmichail@fungible.com, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, simon.horman@corigine.com,
        john.fastabend@gmail.com, anirudh.venkataramanan@intel.com,
        maxtram95@gmail.com, gal@nvidia.com, raeds@nvidia.com,
        liorna@nvidia.com, louis.peens@corigine.com,
        yinjun.zhang@corigine.com, na.wang@corigine.com,
        linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
        Tariq Toukan <tariqt@nvidia.com>
References: <20230613205006.1995873-1-kuba@kernel.org>
Content-Language: en-US
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230613205006.1995873-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 13/06/2023 23:50, Jakub Kicinski wrote:
> All callers of tls_is_sk_tx_device_offloaded() currently do
> an equivalent of:
> 
>   if (skb->sk && tls_is_skb_tx_device_offloaded(skb->sk))
> 
> Have the helper accept skb and do the skb->sk check locally.
> Two drivers have local static inlines with similar wrappers
> already.
> 
> While at it change the ifdef condition to TLS_DEVICE.
> Only TLS_DEVICE selects SOCK_VALIDATE_XMIT, so the two are
> equivalent. This makes removing the duplicated IS_ENABLED()
> check in funeth more obviously correct.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: j.vosburgh@gmail.com
> CC: andy@greyhouse.net
> CC: rajur@chelsio.com
> CC: ayush.sawal@chelsio.com
> CC: dmichail@fungible.com
> CC: borisp@nvidia.com
> CC: saeedm@nvidia.com
> CC: leon@kernel.org
> CC: simon.horman@corigine.com
> CC: john.fastabend@gmail.com
> CC: anirudh.venkataramanan@intel.com
> CC: maxtram95@gmail.com
> CC: tariqt@nvidia.com

Acked-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.
