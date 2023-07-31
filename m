Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41F76A078
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGaSdT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGaSdT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:33:19 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40FE1B1
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:33:17 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a3b7fafd61so3653360b6e.2
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690828397; x=1691433197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xy+3Dw4EFeQNSx/mu2OTUCMR5qrZDc203+ss7SYw+I4=;
        b=mU2fDO3bEyL7npMoc3CL1Dzl7JPzMPzaiv4VV+T16bQ80NAlLI9twwoZWyi5ZqHtKf
         OVLxJKmn5RPX6kbOW5xjvr0cqwb/8iBz/fxViknEtY0V3yN5cTspaWqYTmIhqPx4ZlY1
         9740DUrjNoMi7BYZ2tgwTR419OyKA0whS7/SF7um7oi7Kz/WyJHSdr36t7Aa6ZCLATgj
         5KX1s8GC0l6+s/zW2CTV+08DMqypbIWHyw57W+L5/rhmiqxAo7So9Tw9fagOSTM4d8Y2
         ldNTF572S8Mq+8lTE8+287y07Edtcex8ozKDXwfbxSDlibKO0hUH4Qq6HcEPGGxISpR8
         4hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690828397; x=1691433197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xy+3Dw4EFeQNSx/mu2OTUCMR5qrZDc203+ss7SYw+I4=;
        b=ALL7pyzjvyhBqK/KN2G1caA/V72rEYB3KTEOb34OKiDtEQKGAnvt4X+JHR+Uvqbm8S
         sQ2WebzjFIGhM/934PzAWKCDUZfufIXaYbgcpBKIdTO5ZmnhfXc37Noi2F0VFtPDNvH2
         x7XC7n1yqI/GLHFEC55vybV8/z8avEcFKRc4PdBfQJq4658fAd3fkwUSEXHj+sHJ2Fjr
         p3+LIeW6OF0mCjCWch+Pu5FbGRYLZpmnW8AlbpbAb/DIqEdlgzlpWXwYfFgeKc1QYJLE
         nm/9eA5Uo2pQ+f9TwtscSRpjCsq5vwiBQ3qT1EnhmDGvLHgStdgRCGedObUaaOszUTLI
         ducg==
X-Gm-Message-State: ABy/qLbVgb7T4Xltax1rT/OvlXqgpjIvIHosljOzxzVYAo7jN/a4TzJO
        VwMOq5d4auRWZj72VtFJa6siKAUeR1o=
X-Google-Smtp-Source: APBJJlH6uodxXq0WkcQ0XsXTLDc3deszVoYHSCatFgY1Sl5woGr+uFwMabXVBJmFyYFrNfYzGAGFpQ==
X-Received: by 2002:a54:4815:0:b0:3a3:e6eb:9c53 with SMTP id j21-20020a544815000000b003a3e6eb9c53mr10074472oij.23.1690828397201;
        Mon, 31 Jul 2023 11:33:17 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8206:c67a:f41a:8567? (2603-8081-140c-1a00-8206-c67a-f41a-8567.res6.spectrum.com. [2603:8081:140c:1a00:8206:c67a:f41a:8567])
        by smtp.gmail.com with ESMTPSA id e22-20020a05680809b600b003a1dfa93903sm4348325oig.12.2023.07.31.11.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:33:16 -0700 (PDT)
Message-ID: <0cfb222c-ff48-daca-d512-3083878100fa@gmail.com>
Date:   Mon, 31 Jul 2023 13:33:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 4/9] RDMA/rxe: Fix delayed send packet handling
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-5-rpearsonhpe@gmail.com> <ZMf5qhbrgx0lBv20@nvidia.com>
 <f38c7db0-e613-f840-e979-76383460fd7e@gmail.com>
 <ZMf8H4GtL4EZKGd2@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZMf8H4GtL4EZKGd2@nvidia.com>
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

On 7/31/23 13:23, Jason Gunthorpe wrote:
> On Mon, Jul 31, 2023 at 01:20:35PM -0500, Bob Pearson wrote:
>> On 7/31/23 13:12, Jason Gunthorpe wrote:
>>> On Fri, Jul 21, 2023 at 03:50:17PM -0500, Bob Pearson wrote:
>>>> In cable pull testing some NICs can hold a send packet long enough
>>>> to allow ulp protocol stacks to destroy the qp and the cleanup
>>>> routines to timeout waiting for all qp references to be released.
>>>> When the NIC driver finally frees the SKB the qp pointer is no longer
>>>> valid and causes a seg fault in rxe_skb_tx_dtor().
>>>>
>>>> This patch passes the qp index instead of the qp to the skb destructor
>>>> callback function. The call back is required to lookup the qp from the
>>>> index and if it has been destroyed the lookup will return NULL and the
>>>> qp will not be referenced avoiding the seg fault.
>>>
>>> And what if it is a different QP returned?
>>>
>>> Jason
>>
>> Since we are using xarray cyclic alloc you would have to create 16M QPs before the
>> index was reused. This is as good as it gets I think.
> 
> Sounds terrible, why can't you store the QP pointer instead and hold a
> refcount on it?

The goal here was to make packet send semantics to be 'fire and forget' i.e. once we
send the packet not have any dependencies hanging around. But we still wanted to count
the packets pending to avoid overrunning the send queue.

This allows lustre to do its normal error recovery and destroy the qp and try to create
a new one when it times out.

Bob
> 
> Jason

