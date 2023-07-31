Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA81C76A09A
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGaSo7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjGaSo5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:44:57 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E455189
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:44:54 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bca66e6c44so842124a34.0
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690829093; x=1691433893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fU5sBr4rgsj5HpQSLrpOC/Gz0krozeMMw9bbZyMBVC4=;
        b=g13ndpX+6z0jg/6jfRLLvKic4qW4Zx68B9EaXOI5P9dTfUwpA83Ex3PH92mVHXeejf
         GJHqEbkpGJ6rB2uHJS6codCPXecrqI05M6JUTkabg4NTyNH5ZDvgtKYIPyty/BDpdzoy
         oFKL2kSdt0NAo1jnyJMWnjHK5K2HgBR3XBYdW4oDwfmcaIkz758CBOIIH9ETGgThjzkG
         48PHyF/5D+VNMjHJb0eq4EfLdcIVOb0BxdoJK/OmjETymLX4EV1aLtRHc6lpxIairsmJ
         9aK7jqHeiCztb4qQEnmKh2rv69vVZ7c3TC1rFJiF+Vgqpf7ctEFH1gLzaaYPV89Q48+H
         Wz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690829093; x=1691433893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fU5sBr4rgsj5HpQSLrpOC/Gz0krozeMMw9bbZyMBVC4=;
        b=NAuuDCwXeX6YZMmPIa8VTZjznNgnGSCA0jp2hNyTXIDgBJTq9vazRW94xwSsA+GtaP
         PssR9dbaPfApXwhei3+64V25d4vUcX6aiKHe1DMEIgJs9uAb9uiicWrHHPmHbd5A+itB
         dahmQpvHRLHrLKGZzS6+3X5vm+OdV1SjeiCeQUiVC6rObJYsQcRPDpQGGjM/2Vr7Qy6H
         2eCzSRAvcCKSkLtY4Ar2XwKVomqGSp/DRfj1XYUVZDF/zTM6g7GsnXtc/7PWjEQF0/qV
         6fjX22H8drM5Nm56n0UKuQ6HE29257hDsEY5DYKWxJU0WQDQOQHEj6d4lHrBv01VLi7d
         awMw==
X-Gm-Message-State: ABy/qLY5/gkBM9qvA0vpe/pt0g4FM66jIcjFd3lvYsXyR8Nf4HgEYckF
        TRMV9tYX25h8HSI7ouQjJ7o=
X-Google-Smtp-Source: APBJJlF1gWRuZqY3k8FC4+R/uWFxI8OFwhd/FDqX9C9jyAy+gA8Zge3xj5trdZXgRdZ0bQvEHO0gtA==
X-Received: by 2002:a05:6830:18c1:b0:6b9:a84a:a393 with SMTP id v1-20020a05683018c100b006b9a84aa393mr10418212ote.37.1690829093490;
        Mon, 31 Jul 2023 11:44:53 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8206:c67a:f41a:8567? (2603-8081-140c-1a00-8206-c67a-f41a-8567.res6.spectrum.com. [2603:8081:140c:1a00:8206:c67a:f41a:8567])
        by smtp.gmail.com with ESMTPSA id l6-20020a0568301d6600b006b87f593877sm3051212oti.37.2023.07.31.11.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:44:53 -0700 (PDT)
Message-ID: <3156272e-91e9-8253-e09d-8a93af3f3258@gmail.com>
Date:   Mon, 31 Jul 2023 13:44:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 9/9] RDMA/rxe: Protect pending send packets
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-10-rpearsonhpe@gmail.com> <ZMf6xkpicBpXr/B9@nvidia.com>
 <1ee51a2d-3015-3204-33e3-cfcfaac0d80e@gmail.com>
 <ZMf+ILKLjW+09Hhm@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZMf+ILKLjW+09Hhm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/31/23 13:32, Jason Gunthorpe wrote:
> On Mon, Jul 31, 2023 at 01:26:23PM -0500, Bob Pearson wrote:
>> On 7/31/23 13:17, Jason Gunthorpe wrote:
>>> On Fri, Jul 21, 2023 at 03:50:22PM -0500, Bob Pearson wrote:
>>>> Network interruptions may cause long delays in the processing of
>>>> send packets during which time the rxe driver may be unloaded.
>>>> This will cause seg faults when the packet is ultimately freed as
>>>> it calls the destructor function in the rxe driver. This has been
>>>> observed in cable pull fail over fail back testing.
>>>
>>> No, module reference counts are only for code that is touching
>>> function pointers.
>>
>> this is exactly the case here. it is the skb destructor function that
>> is carried by the skb.
> 
> It can't possibly call it correctly without also having the rxe
> ib_device reference too though??

Nope. This was causing seg faults in testing when there was a long network
hang and the admin tried to reload the rxe driver. The skb code doesn't care
about the ib device at all.

Bob
> 
> Jason

