Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543C56BBC6E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 19:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjCOSjg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjCOSjO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 14:39:14 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A3F911C3;
        Wed, 15 Mar 2023 11:38:42 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-176261d7f45so22016445fac.11;
        Wed, 15 Mar 2023 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678905513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PBxAqUYC1d2NeePHsywjLI1ZNjzs6EbD+eFasw3hF0=;
        b=jAhjiTdw1S0xLiI98uNO6vWygWmr3Rfjfh0WCXHfEXInbOSXIAejEOsGcBMnnHb/30
         S5b/MTfKUrCyxFnJiFj5026v5kNoxLqJP92/Y9cd2YJERHNU1pFxovqz0hvJSzyTABwW
         P8rCYBl4EQOUZu8ePtWyrRB0wsYBoAsJ7krnij5FkKa6ddqSugUugLGctymzFAC6hBxV
         BxEwyibXu/+6gyead+hj2DNChbcpyz3JxxLLnxzLpq1SYOvZZBPlvIgbLvyKQ5BWJfU/
         CcRrESIrA3oq6NphaUBSGtz8xNGaPEg7bDrCMfuXqyNmEISf8suFF2rinIRdGFy/kiFe
         k4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678905513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PBxAqUYC1d2NeePHsywjLI1ZNjzs6EbD+eFasw3hF0=;
        b=jtY0ywjIGN0Q2m1UXbT3FC+xGQpUujUD4sXFHo0+xjqjg+AHdqtRvrD8AWRAMZZilg
         weiWafxvxeThks5VO6qlvfe8OkZpvvPThYxm07zbUYv8SqbdI4Tqt/AZWAIsnnQDItj5
         +bk5j2InCLplAhEp/e0bC8QfzThP4OSRpHQ6mhe173EXH9lmhmLSJvFw/0fgc7OLmiBG
         MyiUbQcK8EMjm7AooiF3jf/urvlmifIqfznEeK3UosO0loWEoWwFy7Vpx9RkJWRsZIIk
         AZqspK/8TX0Ox4J8OBOPZRpWte99Ib96fyPA04OtpQYbAW5gY5MYYd/6wLEV0kpcncTR
         y1uQ==
X-Gm-Message-State: AO0yUKWNHOi8FZ1jdi2t30Wo9Cdfa4LSQSdb5cpjQ9pEAFXtFDWas4qV
        UvAFp8snEjRnqB9iEBfB8i0=
X-Google-Smtp-Source: AK7set9zWjruvjDfiFFSK0di4SUOkg4iI97Ot8mfFvdX+eFq9YT8MKCyCUUDfPQRGKqRpDzF19KDew==
X-Received: by 2002:a05:6870:588d:b0:177:8991:38f2 with SMTP id be13-20020a056870588d00b00177899138f2mr11664205oab.24.1678905513029;
        Wed, 15 Mar 2023 11:38:33 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ebd0:e160:a3dd:fe9a? (2603-8081-140c-1a00-ebd0-e160-a3dd-fe9a.res6.spectrum.com. [2603:8081:140c:1a00:ebd0:e160:a3dd:fe9a])
        by smtp.gmail.com with ESMTPSA id s44-20020a05687050ec00b001729072f759sm2561065oaf.0.2023.03.15.11.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:38:32 -0700 (PDT)
Message-ID: <e704127e-1bfe-f351-db95-bfea6916e8f9@gmail.com>
Date:   Wed, 15 Mar 2023 13:38:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 13/14] RDMA/rxe: Rename kfree_rcu() to
 kvfree_rcu_mightsleep()
Content-Language: en-US
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Devesh Sharma <devesh.s.sharma@oracle.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-13-joel@joelfernandes.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230315181902.4177819-13-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/15/23 13:19, Joel Fernandes (Google) wrote:
> The k[v]free_rcu() macro's single-argument form is deprecated.
> Therefore switch to the new k[v]free_rcu_mightsleep() variant. The goal
> is to avoid accidental use of the single-argument forms, which can
> introduce functionality bugs in atomic contexts and latency bugs in
> non-atomic contexts.
> 
> There is no functionality change with this patch.
> 
> Link: https://lore.kernel.org/rcu/20230201150815.409582-1-urezki@gmail.com
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Fixes: 72a03627443d ("RDMA/rxe: Remove rxe_alloc()")
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index b10aa1580a64..ae3a100e18fb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  		return -EINVAL;
>  
>  	rxe_cleanup(mr);
> -	kfree_rcu(mr);
> +	kfree_rcu_mightsleep(mr);
>  	return 0;
>  }
>  
Please replace kfree_rcu_mightsleep() by kfree(). There is no need to delay the kfree(mr).

Bob
