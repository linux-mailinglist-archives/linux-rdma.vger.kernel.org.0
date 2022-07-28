Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66030584542
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiG1Ryn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 13:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG1Rym (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 13:54:42 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4E74CF3
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 10:54:38 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10d6ddda695so3615755fac.0
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZGeslIfqrbIGBR8WQSfalxx9XeaawgQGdPKtwVyQLiI=;
        b=IpCPcIEejzQRKT7CPMuZh555HkPRqh782u2NiEY5Vs2c8/1qDvq6jsNMxnTj6rvtME
         YxEGZr6fkx5cVauRG2s1J1CK9+9P1boj0CY52L+JygR7sQWiU+FtcJESLyBr9J39f2p0
         fhghQQonlx+Ul7v9VvQXiiET++5zpkH2pBLuSNqUGkMC8165gQHWZw43HJYSGenYsMUp
         vwKKZm0jrbzgtIZBUizPjm+8sVcLDSbtVzPoBkXFJOchmEalnfnIs183aiRQAYw4eQ4d
         oNlWdQ56Sf/TBpi0re9MGakKwmF5otSxZ0cr/r6ISUE5z5pBvA3iEeaG0ACtEdJArMPd
         F+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZGeslIfqrbIGBR8WQSfalxx9XeaawgQGdPKtwVyQLiI=;
        b=mHMPabpyol48GPxFgC2gqYkJdcinPHG34X1pZfNTnrDcHbigMB5ckZMizjVhH0//Ah
         2xXG50cVnx8hcB4VIPA9krJoy4qiLHTgzh7Qs1rn6MdYXcP1jkPERMTkAwaBBRRTguZ4
         MH2KOMv+FSo9kAF0Bsuts+84EQ4xGeIeMFLpUGI3P/L8xCKcODUYgdxRmP66C8uDfqRn
         5AeUlyR9d46IuQPmSC8NvuuO3re1dFol7zBaci2LkszMmNuQS6PItHxduyYXVgEkECaF
         6FyL9IoEA8xRRxUcBGOGevoMr8q7OTCJdU/UrKNEyX8/uvpSZuU1wMzwp2Ioai4vqPmw
         Wl7w==
X-Gm-Message-State: AJIora/IcUtjxp7ZRrcnJ5gdhDaG/VL/QL9Z4aMidS83q30E4Bf2gkpc
        afSigBg/X1lyfjRzD7cRbN8=
X-Google-Smtp-Source: AGRyM1s5Izkp3cEAyNDDwd6afZYuUgvFeHATK9bBgl0rLB2ovIUwwlFhc7rmP4X3V/tUj7iqTsHWiQ==
X-Received: by 2002:a05:6870:3042:b0:10d:81fe:baa2 with SMTP id u2-20020a056870304200b0010d81febaa2mr298084oau.83.1659030877706;
        Thu, 28 Jul 2022 10:54:37 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:74e9:26b8:3420:6d55? (2603-8081-140c-1a00-74e9-26b8-3420-6d55.res6.spectrum.com. [2603:8081:140c:1a00:74e9:26b8:3420:6d55])
        by smtp.gmail.com with ESMTPSA id a8-20020a056870618800b0010c727a3c79sm632941oah.26.2022.07.28.10.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 10:54:36 -0700 (PDT)
Message-ID: <04e87d78-29a2-735a-b984-d2321a8edc9d@gmail.com>
Date:   Thu, 28 Jul 2022 12:54:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Guard mr state with spin lock
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     lizhijian@fujitsu.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
References: <20220725200114.2666-1-rpearsonhpe@gmail.com>
 <YuK8jXgAncDlppm9@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <YuK8jXgAncDlppm9@nvidia.com>
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

On 7/28/22 11:42, Jason Gunthorpe wrote:
> On Mon, Jul 25, 2022 at 03:01:15PM -0500, Bob Pearson wrote:
>> Currently the rxe driver does not guard changes to the mr state
>> against race conditions which can arise from races between
>> local operations and remote invalidate operations. This patch
>> adds a spinlock to the mr object and makes the state changes
>> atomic.
> 
> This doesn't make it atomic..
> 
>> +	state = smp_load_acquire(&mr->state);
>> +
>>  	if (unlikely((type == RXE_LOOKUP_LOCAL && mr->lkey != key) ||
>>  		     (type == RXE_LOOKUP_REMOTE && mr->rkey != key) ||
>>  		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
>> -		     mr->state != RXE_MR_STATE_VALID)) {
>> +		     state != RXE_MR_STATE_VALID)) {
>>  		rxe_put(mr);
> 
> This is still just differently racy
> 
> The whole point of invalidate is to say that when the invalidate
> completion occurs there is absolutely no touching of the memory that
> MR points to.
> 
> I don't see how this acheives this like this. You need a proper lock
> spanning from the lookup here until all the "dma" is completed.
> 
> Jason

Interesting. Then things are in a bit of a mess. Before this patch of course there
was nothing. And, rxe_resp.c currently looks up an mr from the rkey and saves it
in the qp and then uses it for additional packets as required for e.g. rdma write
operations. A local invalidate before a multipacket write finishes will have the wrong
effect. It will continue to use the mr to perform the data copies. And the data copy
routine does not validate the mr state. We would have to save the rkey instead and
re-lookup the mr for each packet.

For a single packet we complete the dma in a single tasklet call. We would have a choice
of holding a spinlock (for a fairly long time) or marking the mr as busy and deferring a
local invalidate. A remote invalidate would fall between the packets of an rdma op.

Bob
