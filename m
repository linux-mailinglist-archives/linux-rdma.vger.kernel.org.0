Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022CA76A03F
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGaSUs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGaSUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:20:39 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72976119
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:20:37 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9e478e122so4207376a34.1
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690827636; x=1691432436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cnvyU4e13xSagrELSx+gtDYQTWOC3hk2AMOy/3rH6U=;
        b=n3ojw2SUVGcK/EZwgOfUhj1Mbel7MOPmu3zMyVYnT1fyuNgSvR8sMvd934GMDxF7Qj
         CXk4ypchx+WJlZdvQLGVyBV8KpsNOfvv5acL0S+qO0J+ZJDmWaK627VcFu2jXDfEQhol
         uw8NqbpRwgIU8vkhqXDiTtSAgxjyeWxJ+Pd845919XJLQTTZ5QBK/y89j7+p8bFmOMMN
         hiWI5xy7m3qTNvyzpHSNWy9l+yvJqEQ35DTNGfLjxYZvHeACUAjMXwE1Ze5PNKG59kGA
         vq4jKHPIrrLIfufsS34HsWQa8a6WnIqnFFrfqKgWpo8wkdU/b3zV/DGH+7y4qKf1LZCh
         qyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827636; x=1691432436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cnvyU4e13xSagrELSx+gtDYQTWOC3hk2AMOy/3rH6U=;
        b=lubAwoY5zjbjOEZ6Q7z/yhuXDUdDUA8m5NIIiIBvgwjNJPzRkaTYAXPlnTowO/ObL5
         Pu5PDWWw8kBzKrXZ9UDCyDtG4RgV0vJNTFzopC0/reFrnFIDCNjfXTXHBoKVsWriuefq
         ZenX3SLLdiPt0G+GpPcV+A0aqMHaGGuTUH7ZjV+BXkKhPER/JPzba8XqGKzvTxu0oq3b
         vf9Jl1stgpGNZnbc60chOSiPif13AQPtT2e6ngebMf5VR/I3SdXObyXfICTTD1IC0B+d
         CMXszSx0RlWXCLx27IepJRCVnyfdn3hhYNwdsGNm/Jcsj6iuBEACV9e0rB5xE118xSJT
         RdtA==
X-Gm-Message-State: ABy/qLbKvs2hykvxPWW5/IhwVH2SuYQmGkQL1Stl0o0MeuoWvFxFSVzq
        mHXrbSPknyZVHMQfsXfdUbI=
X-Google-Smtp-Source: APBJJlFDhaPB/Tdyi8mG3lyG9aAF+D65hSf2zjqyvxYwSjbKOwofW/89tdeJqyo9JPSh0CMGVjvb6Q==
X-Received: by 2002:a9d:6956:0:b0:6b8:f588:2c75 with SMTP id p22-20020a9d6956000000b006b8f5882c75mr11604717oto.21.1690827636738;
        Mon, 31 Jul 2023 11:20:36 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8206:c67a:f41a:8567? (2603-8081-140c-1a00-8206-c67a-f41a-8567.res6.spectrum.com. [2603:8081:140c:1a00:8206:c67a:f41a:8567])
        by smtp.gmail.com with ESMTPSA id y7-20020a0568301d8700b006b96aee5195sm4294474oti.11.2023.07.31.11.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:20:36 -0700 (PDT)
Message-ID: <f38c7db0-e613-f840-e979-76383460fd7e@gmail.com>
Date:   Mon, 31 Jul 2023 13:20:35 -0500
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
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZMf5qhbrgx0lBv20@nvidia.com>
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

On 7/31/23 13:12, Jason Gunthorpe wrote:
> On Fri, Jul 21, 2023 at 03:50:17PM -0500, Bob Pearson wrote:
>> In cable pull testing some NICs can hold a send packet long enough
>> to allow ulp protocol stacks to destroy the qp and the cleanup
>> routines to timeout waiting for all qp references to be released.
>> When the NIC driver finally frees the SKB the qp pointer is no longer
>> valid and causes a seg fault in rxe_skb_tx_dtor().
>>
>> This patch passes the qp index instead of the qp to the skb destructor
>> callback function. The call back is required to lookup the qp from the
>> index and if it has been destroyed the lookup will return NULL and the
>> qp will not be referenced avoiding the seg fault.
> 
> And what if it is a different QP returned?
> 
> Jason

Since we are using xarray cyclic alloc you would have to create 16M QPs before the
index was reused. This is as good as it gets I think.

Bob
