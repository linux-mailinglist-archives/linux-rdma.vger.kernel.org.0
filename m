Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3015753D2
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 19:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbiGNRQd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 13:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiGNRQd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 13:16:33 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1CF45998;
        Thu, 14 Jul 2022 10:16:32 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id j3so3142190oif.8;
        Thu, 14 Jul 2022 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uhEv4YSwcCxcXhWvFeqOjhWTxgBTIYrW5s8rWKcWzmU=;
        b=ItL0eFnVB11SXPSXjMU89R674AtggxpXHV/agOLJfMB6wYEGuARbddcbEYLSRFWz8O
         VpmbahSN91O/LiBLRMlPtsb3hEcgHxc/H6xYKT0PRm4fC6kZKFU0+/A5Plrk83XvknAA
         uA+QWtAOQ8Ga52PUCaDXBPK71FO+WJVnJMDeokAyZT+bVXEiEKB4TsVyBouRB6EBofcA
         nZxZQm6c0O4JWtXMJX5J/55+bJ8rlqc9LajvDvYoceWflYBbTPmwTE+DMG7lYDKsk+AM
         Yzluggp6hhmLSQEp+3R+xtv8fuXyhFD74bT0YWopS2g3Lxy5tKREZnhFsPXShUxhCvoV
         IjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uhEv4YSwcCxcXhWvFeqOjhWTxgBTIYrW5s8rWKcWzmU=;
        b=ZdTF8HKDG8HCgshMa2K1Knq/tTqvPKwXV2KmE9LhZawhZAyVuqfI4HUcAfrkYaqhhr
         bXkxFCdLMaX4TiJNmQWVhmPmnF+8fxOCuILwAh2hu6g4o+FtoR5bDdzIQ0wNJQBS9DJ5
         NUNC0fz8FFo2u0oMXcdmMlfjaGEW/Zdgd2ZvMtA9StplIJnsYTTE6kFF2fgYYd0xMbkE
         cTXkvjYJu0i/cwHqSLwlgY3HgJ5fqZoxgfJSUAvVPcvvLWpcALDFpwZodfz316N77xhu
         usCBHufk/8MKUOdKZMCAB+0g6wuOeCRFEDZaseQKD43GVAj4GwyFLRUclBymD9J/ajZg
         Hs4Q==
X-Gm-Message-State: AJIora8Eae4l1IIvFLhq8Y4gULnzmP9WHZKmg452lNohyBdy/OXcumZI
        HpXCOvm8W6H29UTnaxBdZbA=
X-Google-Smtp-Source: AGRyM1vurFHFWHvzQuDrVyPlMqlF0xZTPWoVAsb1/ZLVS5YEMncqwaVpv4UADyYF+aMmxRIdbeezOw==
X-Received: by 2002:a05:6808:1184:b0:322:4c18:2f7e with SMTP id j4-20020a056808118400b003224c182f7emr4948099oil.109.1657818992002;
        Thu, 14 Jul 2022 10:16:32 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id n45-20020a4a9570000000b0042313f42b26sm818999ooi.39.2022.07.14.10.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:16:31 -0700 (PDT)
Message-ID: <47c790e7-ef89-dd9b-76a4-1f2af7976105@gmail.com>
Date:   Thu, 14 Jul 2022 12:16:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Fix typo
Content-Language: en-US
To:     Zhang Jiaming <jiaming@nfschina.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com
References: <20220701080019.13329-1-jiaming@nfschina.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220701080019.13329-1-jiaming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/1/22 03:00, Zhang Jiaming wrote:
> There is a spelling mistake (writeable) in function rxe_check_bind_mw.
> Fix it.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> index 2e1fa844fabf..83b5d2b2ebfd 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -113,7 +113,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>  		      (IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_ATOMIC)) &&
>  		     !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
>  		pr_err_once(
> -			"attempt to bind an writeable MW to an MR without local write access\n");
> +			"attempt to bind an writable MW to an MR without local write access\n");
>  		return -EINVAL;
>  	}
>  

Correct.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
