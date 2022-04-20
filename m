Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C27509328
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 00:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382983AbiDTWu2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 18:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382964AbiDTWu1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 18:50:27 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DC827CEA
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 15:47:40 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w194so3711913oiw.11
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 15:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zT3PkG27ieh1lyGqcl7f1cX83CsnCaZ0J3Z9vO6RJX8=;
        b=Qujs2frNndpUYhOvsh36/5rMWCyEmruuK2jn5+IvioQIfCKDymjKeU+qo/wMaIU3sh
         OfqcVnHL4xLA1KoawM2dfsBoYLzk/xsp3L869E4RXyAQ/MQNWJVGd5zAUOjnvtyNHfNc
         AQeE4FMozmE6/247Kw5UlollsrGzC21HriP+Fh/hU/ytvW6O+Pu3F+H9v5kbZdMx3DLu
         LdKvUq2uxueLYc4YZMm15/iAwcjRvyNLuDHdSd/yoH0Poxd5aI6RWTMcTZ0FxalgjU7g
         1wH4kCenaDhJ/LOIqyAYxD9n0gyDfDk1ecDpDOivc1RwiU9SlQ+qx10viSUN2CoIlqiK
         RfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zT3PkG27ieh1lyGqcl7f1cX83CsnCaZ0J3Z9vO6RJX8=;
        b=4YcyymMzzhL668Wu48FsCNNcmZnp+Tldj3xYiPUBNOX6VaCG+Za5YttIjgKkv9MZNn
         wVydO4eaFjEpgJ4EX1SsZf0PSJOyI/4xONoWKqgpWWyV4Vb6k/KLFoNUv+UWg7d13aXu
         Umt0SSzyooJNrVjoEGkE5YuW8aWOKVImDIPUGkbOxlX9zhtEZB7b/CmvqUf5ZfER6E5W
         28h2VBwyU3s1VMLt5da6YFVksVLsoA9q91vSKPtMBEfR3FrJHQHGRDpXvTjohE9cHs3n
         H1Rycefo3ChFSTbBZmBkAMzJtAM6enB+LaAp2B20ijJGC+QTnMvGagoCza4YlTnskaTk
         tb9Q==
X-Gm-Message-State: AOAM5325+Z796NHoVircXQMBt6hKGt5V6KhEUTc4RjJVSXkX1njjtr9x
        reP+25lLR7gaBKy5kTlsSIk=
X-Google-Smtp-Source: ABdhPJyH9DYzbxHuQ5M7bqlTViEeCeZKmH7oyHBCWw8J63b+L5vmX8VwiMqAaDAa+8JEnb4t111RAQ==
X-Received: by 2002:a05:6808:103:b0:322:6d3f:dfe0 with SMTP id b3-20020a056808010300b003226d3fdfe0mr2850590oie.207.1650494859499;
        Wed, 20 Apr 2022 15:47:39 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:fa82:7fab:b7a7:9932? (2603-8081-140c-1a00-fa82-7fab-b7a7-9932.res6.spectrum.com. [2603:8081:140c:1a00:fa82:7fab:b7a7:9932])
        by smtp.gmail.com with ESMTPSA id m126-20020aca3f84000000b002ef895f4bf8sm6719284oia.24.2022.04.20.15.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 15:47:39 -0700 (PDT)
Message-ID: <7100b58c-80e5-486c-eadd-5d082f4f6142@gmail.com>
Date:   Wed, 20 Apr 2022 17:47:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH for-next v13 03/10] RDMA/rxe: Check rxe_get() return value
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
 <20220404215059.39819-4-rpearsonhpe@gmail.com>
 <20220408175251.GA3644777@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220408175251.GA3644777@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/8/22 12:52, Jason Gunthorpe wrote:
> On Mon, Apr 04, 2022 at 04:50:53PM -0500, Bob Pearson wrote:
>> In the tasklets (completer, responder, and requester) check the
>> return value from rxe_get() to detect failures to get a reference.
>> This only occurs if the qp has had its reference count drop to
>> zero which indicates that it no longer should be used. This is
>> in preparation to an upcoming change that will move the qp cleanup
>> code to rxe_qp_cleanup().
> 
> These need some comments explaining how this is safe..
> 
> It looks to me like it works because the 0 ref keeps the memory alive
> while a work queue triggers rxe_cleanup_task() (though who fences the
> responder task?)
> 
> At least after the next patch, I'm a little unclear how this works
> at this moment..
> 
> Jason

I started writing the comment (here)

    If rxe_get() fails qp is not going to be around for long

    because its ref count has gone to zero and rxe_complete()

    is cleaning up and returning to rdma-core which will

    free the qp. However rxe_do_qp_cleanup() has to finish first

    and it will wait for the tasklets to finish running.

    This fixes a hard bug to solve since the code calling

    rxe_run_task() will hold a valid reference on qp but the

    tasklet can be deferred until later and that reference may

    be gone when the tasklet starts.
 


but I realized that at the end of the day there isn't a problem because
complete/wait_for_completion together with qp cleanup code shutting down
the tasklets means that the race won't happen once the series is all in
place. So I will just drop that patch.

Bob
