Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB2F6313C4
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Nov 2022 12:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKTLw2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Nov 2022 06:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiKTLw2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Nov 2022 06:52:28 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9220D10F4;
        Sun, 20 Nov 2022 03:52:26 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id a14so16075863wru.5;
        Sun, 20 Nov 2022 03:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv/kPwEPZf5qxkCsBWsD5GkXFDRY2F4kx4WY5S1gXGI=;
        b=vFDhUWlzV5KPVG5X8qXLYL0nkOvtXtlyJMZWZHxu8iufU6XwoJKhQ35oUDQxHAuSCM
         ZPKXjBbRCJoN/fRAQbxWkPKAthnWaOdQT5NgN7C/KS9HuqyK7G5G2hq2J83Ep3syDnuF
         f7NqQv8TyXzGi93q2hDf+d5G/RVZ/GyUmjODWmtHTpcabU04Q6uDXvHD8cXP1pjPZih+
         CiyxOOs+Zujx2dG8/Hjvqe448GnS7OgCf1Ge06f6lj4KqIrlKedvjLbr2RVRvFOvWf4R
         o7ATnAcxb8V2iyDnUzfzC78aPZ/uOqzDicQc98hfUsljdsO7D4MaR/3JTKmrKlLnIEcY
         q/pQ==
X-Gm-Message-State: ANoB5plXvzacRPAD08mHkimXXfOVaoLESuVMFlP8f9p+C+qxIeqybnd2
        Pwmm7vswxbQNkE03dA5LOZOyXfEgDjM=
X-Google-Smtp-Source: AA0mqf4/cc8iyaPEMJLojDHcGU4F0Qlikda6MvuZTsrZp7lkmHQfU9Jq8qbzb8XEZtckuu+YlvezJg==
X-Received: by 2002:adf:e402:0:b0:236:ae0d:e833 with SMTP id g2-20020adfe402000000b00236ae0de833mr1495267wrm.155.1668945145069;
        Sun, 20 Nov 2022 03:52:25 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y15-20020a1c4b0f000000b003cf7292c553sm10331633wma.13.2022.11.20.03.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 03:52:24 -0800 (PST)
Message-ID: <56a99d68-eaed-7f8a-8371-a2f6a1f2acd3@grimberg.me>
Date:   Sun, 20 Nov 2022 13:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] infiniband: use the ISCSI_LOGIN_CURRENT_STAGE macro
Content-Language: en-US
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20221116094535.138298-1-mlombard@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221116094535.138298-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


title prefix should be:
iser-target: use the...

> Use the proper macro to get the current_stage value.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/infiniband/ulp/isert/ib_isert.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index b360a1527cd1..75404885cf98 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -993,9 +993,8 @@ isert_rx_login_req(struct isert_conn *isert_conn)
>   		 * login request PDU.
>   		 */
>   		login->leading_connection = (!login_req->tsih) ? 1 : 0;
> -		login->current_stage =
> -			(login_req->flags & ISCSI_FLAG_LOGIN_CURRENT_STAGE_MASK)
> -			 >> 2;
> +		login->current_stage = ISCSI_LOGIN_CURRENT_STAGE(
> +				login_req->flags);
>   		login->version_min	= login_req->min_version;
>   		login->version_max	= login_req->max_version;
>   		memcpy(login->isid, login_req->isid, 6);

Acked-by: Sagi Grimberg <sagi@grimberg.me>
