Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B58737272
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 19:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjFTRQZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjFTRQY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 13:16:24 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D035DC
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 10:16:23 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39ecbb4c7d3so2057606b6e.3
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281383; x=1689873383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePLSKz7QzxdJpEacV5rCwFDw6/S9ozsc/tbB5xXeQnU=;
        b=ewsipbLIAsTU/9qNjbVyWgC1+YTNTaYJYdVq4cxMKapfvmzvj+U32G/+Svt39zwD3s
         xWvBZbt879mcLsm68SB/9FCAKSSPX3+lSEDH06v6nzmtYIa6cdyyEmlEPTTf6U1Jvcrv
         ZNKutRWzcN20D+4g12lkRqq1UVaSCf9GplesK1CQoDncSPSTRTEdyi6xFlhCqqFhgdJm
         di7VRyGJnpgkReJTxcgSe0gaBn/a3Op8n8RK65LpEzDjGZtTsNPHFW6IC5kXg2bmMXEq
         tYRBf+9NYoKBPxg6mvo1hTyf9ar86Y62sVau4SVLcnOBHC7JnS6UWtOJRea/JhIKeHJd
         AAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281383; x=1689873383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePLSKz7QzxdJpEacV5rCwFDw6/S9ozsc/tbB5xXeQnU=;
        b=AyN5QSzq3I3ATFFNfklvogLjpj221isijkRzxOQb0ro5Tggm1LOjvSnpwosfMdO8P+
         JWzeaoOpNqRmIjZXMdzJ4ZV/ZCS6zoq3cpO4WFzdD/Z5k3fzXJ392EiPuUVfwloU3cTX
         D7WlfyYz3VxMLqHGNbfUEiGKI2C2OP+iNZk7R8A5/PiNbaWKigs8W8bmAyaw85E97+cE
         KuyBrOJuv0mFCxhkp72Wc/zKz1KcgsCeJEdYDxbvpwrKuaHPhsS8RlgyUfl1Ri1hN2Qg
         LUpOC//D06nDyMC9Q+r7ZozDIe1flijfcuEahPFwfZk8j4+jGB38C38twl5SUKjSZ1Qy
         BgsQ==
X-Gm-Message-State: AC+VfDyxe9KHKL3LXjUNzjnT8k1ORPxGVThpPC7EkNPjB0/xgS0KJmj2
        MFUqB21onMdPIwfkV8xCRgUV45F1SFE=
X-Google-Smtp-Source: ACHHUZ6n1tIEPgVQ9ilPLaSJUgpJqIdzhpcSMQH2wH3lzlSFWhHDBrSw36uQypDIjcI/fhN76uQ2dg==
X-Received: by 2002:aca:2109:0:b0:39c:9173:31f1 with SMTP id 9-20020aca2109000000b0039c917331f1mr13532716oiz.28.1687281382787;
        Tue, 20 Jun 2023 10:16:22 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ba53:355d:2a89:4598? (2603-8081-140c-1a00-ba53-355d-2a89-4598.res6.spectrum.com. [2603:8081:140c:1a00:ba53:355d:2a89:4598])
        by smtp.gmail.com with ESMTPSA id bd26-20020a056808221a00b003923ef75a3dsm1315378oib.4.2023.06.20.10.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 10:16:22 -0700 (PDT)
Message-ID: <677fb641-4b48-48d0-f4de-e42707e7eae3@gmail.com>
Date:   Tue, 20 Jun 2023 12:16:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6.4-rc1 v5 1/8] RDMA/rxe: Creating listening sock in
 newlink function
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
References: <20230508075636.352138-1-yanjun.zhu@intel.com>
 <20230508075636.352138-2-yanjun.zhu@intel.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230508075636.352138-2-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8
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

On 5/8/23 02:56, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Originally when the module rdma_rxe is loaded, the sock listening on udp
> port 4791 is created. Currently moving the creating listening port to
> newlink function.
> 
> So when running "rdma link add" command, the sock listening on udp port
> 4791 is created.
> 
> Tested-by: Rain River <rain.1986.08.12@gmail.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 7a7e713de52d..89b24bc34299 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -194,6 +194,10 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>  		goto err;
>  	}
>  
> +	err = rxe_net_init();
> +	if (err)
> +		return err;
> +
If you put this here you cannot create more than one rxe device.
E.g. if you type

sudo rdma link add rxe0 type rxe netdev enp6s0
sudo rdma link add rxe1 type rxe netdev lo

the second call will fail. This worked before this patch. Maybe you will fix later but
by itself this patch breaks the driver.

Bob
>  	err = rxe_net_add(ibdev_name, ndev);
>  	if (err) {
>  		rxe_err("failed to add %s\n", ndev->name);
> @@ -210,12 +214,6 @@ static struct rdma_link_ops rxe_link_ops = {
>  
>  static int __init rxe_module_init(void)
>  {
> -	int err;
> -
> -	err = rxe_net_init();
> -	if (err)
> -		return err;
> -
>  	rdma_link_register(&rxe_link_ops);
>  	pr_info("loaded\n");
>  	return 0;

