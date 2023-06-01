Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD02771F0F9
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjFARkb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 13:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjFARkU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 13:40:20 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F077F1B1
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 10:40:14 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-19f9f11ba3dso1194455fac.2
        for <linux-rdma@vger.kernel.org>; Thu, 01 Jun 2023 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685641214; x=1688233214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5r/b15QTUYvstJHSn/RFTKkbQseFyQ16o0gv6opEiU=;
        b=SzGKS7aFqjbq9V/bcjizYZtY4KKvgkzCnTLTCorzzx8nvt5zZppscjae0lAILfVj86
         Xw3NY3NIyCUvMPZdU8lD5QkDNw0GvST5VEtm+1PlcIz0qMvLR6Ug419X+wEvBxn9KewL
         JSmlhLNrJoJKuAywAv3Ktlw7GVs+YY29TMqEb48oDMmgO7HGzcAp2vWM3iXvFb/T1fpK
         HIBIXMJjaBPGnd7RjRazo6iXHN4tpoS/6YNJG+HR+jQJmKEkcZDkS4l8krXG22Kx5Byx
         se4nFZD/kh1wHCPg7hKwf6F8PwLQTDztKUnJt1cBWzeVGMMocJwRmI+RlXD46A0Erfis
         nNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641214; x=1688233214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5r/b15QTUYvstJHSn/RFTKkbQseFyQ16o0gv6opEiU=;
        b=ffmLPYCOJhb7C0KPWs24m11VXhuuexmoCc3VAFCl7+4G6tOIHcOmBCaYUvTrmHnotq
         kLL672sJXrPQxCnB6QWZv7qdqVUu/UvoTOg3cm6cBNUjej1+O1CEtZ5O1FdFQWGjDO2c
         KlAvKIvSLjUAiRad1syjnJiSS0diw+76K8m3MbbfTwSi9Cf/+6XyryCbUARo9dYY4zD4
         8NtFmsdBSf1A2ETRJ3DRUBB6S/FhOYUXkcA+C4NzqalFWAurl5htS2mbBwbEbESW0707
         FPb8m5ZLZgYgvBCywI7w+ys4xU/cZIo3KfLH2iJl8xHEElqE0VdKLIUPsItzSXGJI6vI
         YA+A==
X-Gm-Message-State: AC+VfDzZ6twmke/o23sdjySFrmiXtQ9mMn7ShHu1MjVb9xnnAcVwMsOR
        kCLV9Kx+iaf1iK8fFb/89Sg=
X-Google-Smtp-Source: ACHHUZ6aujYmd07pjvq1W5HJYAcuICR8ymf0ATFUBE4sAf5SpytkN8IdXDGezLPZ/pNbiYnxc5gj2A==
X-Received: by 2002:a05:6870:76ae:b0:19a:7f42:ee27 with SMTP id dx46-20020a05687076ae00b0019a7f42ee27mr7935977oab.34.1685641213966;
        Thu, 01 Jun 2023 10:40:13 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:808f:9c5:a407:c332? (2603-8081-140c-1a00-808f-09c5-a407-c332.res6.spectrum.com. [2603:8081:140c:1a00:808f:9c5:a407:c332])
        by smtp.gmail.com with ESMTPSA id t2-20020a9d66c2000000b006af99ac5832sm1759207otm.47.2023.06.01.10.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:40:13 -0700 (PDT)
Message-ID: <71dfb7bd-46bd-bac4-947e-c56ab01dad88@gmail.com>
Date:   Thu, 1 Jun 2023 12:40:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ref count error in check_rkey()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
References: <20230517211509.1819998-1-rpearsonhpe@gmail.com>
 <ZHjWZSWem41svcbM@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZHjWZSWem41svcbM@nvidia.com>
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

On 6/1/23 12:33, Jason Gunthorpe wrote:
> On Wed, May 17, 2023 at 04:15:10PM -0500, Bob Pearson wrote:
>> There is a reference count error in error path code and a
>> potential race in check_rkey() in rxe_resp.c. When looking
>> up the rkey for a memory window the reference to the mw from
>> rxe_lookup_mw() is dropped before a reference is taken on the
>> mr referenced by the mw. If the mr is destroyed immediately
>> after the call to rxe_put(mw) the mr pointer is unprotected
>> and may end up pointing at freed memory. The rxe_get(mr) call
>> should take place before the rxe_put(mw) call.
>>
>> All errors in check_rkey() call rxe_put(mw) if mw is not NULL
>> but it was already called after the above. The mw pointer
>> should be set to NULL after the rxe_put(mw) call to prevent
>> this from happening.
>>
>> This patch corrects these errors.
>>
>> Fixes: cdd0b85675ae ("RDMA/rxe: Implement memory access through MWs")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_resp.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Applied to for-rc, thanks
> 
> Jason
thanks
