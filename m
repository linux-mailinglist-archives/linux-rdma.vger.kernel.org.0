Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7992074C1D8
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jul 2023 12:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGIKSl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Jul 2023 06:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGIKSk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Jul 2023 06:18:40 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AA9D7;
        Sun,  9 Jul 2023 03:18:38 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so39280901fa.2;
        Sun, 09 Jul 2023 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688897917; x=1691489917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xk2m3eHHg5+WopAG9c1J4W9MrnyvygLtozQpKMScTFo=;
        b=RRrEkLYFOnIueZb+jlwBNOJq3kxO8jMPoe426E09fImJI0qTLwTNTJVbE2xdiCQleX
         dzZAyCeTN98xnTgM431CW3zLBrRHUxLAcKxlZcqSygkfbHMwCEQfll83fIh/O151omru
         2Mu6Z5ZOzAp0dhPGWk/MO0popmI4rCSjqMvW2ZQGknjfLoTA+uJHnQnTf4IxD3B2YJh6
         iX8GycpTUKy+s/RDG6iIR27M07+T3aUn4nR76u/7UMpaNG1Uci8jsbgncgxdYKeTMQSc
         LFk3xBFX52X2S5e3RQDOzmq33Eaw7eMsAPM+bEs8VBAsFM49KQqeZbFwegI2SZjf7QMz
         xsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688897917; x=1691489917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xk2m3eHHg5+WopAG9c1J4W9MrnyvygLtozQpKMScTFo=;
        b=Kctj9iFXKJ7N93AvPBKG6jNlfv2SBf5Ve1BS0s6Q9V/d571ZNMo4vD7XXry4nwAFgB
         ggOavFb0cPkk5NqCPQAjEDbj8WTgsUnnCpgrZEg3S0LEgAKANqgG+2BDtgoqnJ4lKcOM
         zxhATtyaiUv0PG6lCPYHqOFg3K9r4FBjR5RL01PqGvTnMPaFI6klLOjqmJr+3TvMyFhM
         Bd1/hPBRMm3MghjKz18byBpKUXgw+jd6z4uj/YjRh28JR3VS7ITLwgoL22lE1Y2jIFtg
         L4TaUWB3KBp14Mn+zlTrticuHuzGVqHOnvSPkuVcC6shOeUSt2xSMp6VIL1yVQDPK+Sr
         fbCw==
X-Gm-Message-State: ABy/qLbySOaoSJZOmftY45NQT7N6r9fEd90TIxlP0kY7LcOds99G9F49
        lTl3lORSY4h7WqqlOmI9VIw=
X-Google-Smtp-Source: APBJJlEBQPPjBt8sE9ybUNfyT1TX5y/I8L3AqziJjP83MpIMRG6iC/bVUpw5cGYBL3gt4Vq9CvzS/Q==
X-Received: by 2002:a2e:854f:0:b0:2b6:e76b:1e50 with SMTP id u15-20020a2e854f000000b002b6e76b1e50mr6677741ljj.41.1688897916836;
        Sun, 09 Jul 2023 03:18:36 -0700 (PDT)
Received: from [192.168.0.107] ([77.126.161.239])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906b18e00b00992ca779f42sm4625305ejy.97.2023.07.09.03.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 03:18:36 -0700 (PDT)
Message-ID: <a70fa545-8690-0d8a-cb04-421b04c67a61@gmail.com>
Date:   Sun, 9 Jul 2023 13:18:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] net/mlx5: fix potential memory leak in
 mlx5e_init_rep_rx
Content-Language: en-US
To:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     saeedm@nvidia.com, leon@kernel.org, lkayal@nvidia.co,
        weiyongjun1@huawei.com, yuehaibing@huawei.com,
        Tariq Toukan <tariqt@nvidia.com>
References: <20230708071307.149100-1-shaozhengchao@huawei.com>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230708071307.149100-1-shaozhengchao@huawei.com>
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



On 08/07/2023 10:13, Zhengchao Shao wrote:
> The memory pointed to by the priv->rx_res pointer is not freed in the error
> path of mlx5e_init_rep_rx, which can lead to a memory leak. Fix by freeing
> the memory in the error path, thereby making the error path identical to
> mlx5e_cleanup_rep_rx().
> 
> Fixes: af8bbf730068 ("net/mlx5e: Convert mlx5e_flow_steering member of mlx5e_priv to pointer")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Thanks for your patch.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


