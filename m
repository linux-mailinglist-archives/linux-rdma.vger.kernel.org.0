Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D83759B25
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 18:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjGSQnu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGSQnt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 12:43:49 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8DE1FFA
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 09:43:31 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bac0e25891so1318687fac.2
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689785011; x=1692377011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/NK5JawK46LksCCVJM+iGc3slVkELcryrDa4ESYEis=;
        b=pc666q3hu1MfDZC4raNXLFXmwtdacInTGodg9EDimAi++Ma3ieQBL0KCRo2uHEQEbr
         4L8Y58N4jrCyW0440muzUPPGYf87oiZkfhM58svz58rz9V0i7Dv4WCHW+pt4J7J1OZ0m
         +l5cb2MWAqhfXGB9LGyyXR26g00MDLvrFjOmJx+uBBbbVteHYs/eWr4yJX+WYREWLWrS
         xz7OOculkjo8VXueIOCDC4R4UewHB+zXyMYgmKg3CjqWWVs+aqDisMXG4jSSpgz/Qp1c
         pNJylxTRSjJsDnnpjunFNHaQrTAo+Fg2kStkzvYpamGOzxh+zv1LHVc/DsRESx3Rzh9b
         Abow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785011; x=1692377011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/NK5JawK46LksCCVJM+iGc3slVkELcryrDa4ESYEis=;
        b=lfs0EEUv8Ts6bnderY5TkZkg0Dgw8GM1kVzQKxq5aL0LwWV3BeUwKpdtcQBaQWZMj1
         9Vmx5QRuUwHhuF6TIIXmz3mmzUF9k94lOGL3dBK07+/f2evjlp8suXFUlaQymZ8NNv6y
         wsOGB5U/VsCaxnlT4aBhgQp+4XSaxYfG/mALK0OLGVHpSMnpqMDUEHmfgxr5Aq1Jtt/g
         qaXcbP3SjsoNUIrKyShO95lqKEL2ZJUOdLNsCKU4q3B1qD5s/PGhj8xgy5EvhUkRCo98
         99Ylc7se0aoVMHYssrtuOoaluj8/HMvW+elluKu/SkIGPVAE4bf3r1UJmMlbTa2c0KOL
         Oueg==
X-Gm-Message-State: ABy/qLZ6ThtHpp3Oh03Us7BRjmV2XsR1q/NHjw1yLpwMowpFbbSU2vmk
        LtaQDqXO+hBnPKNCeGcdrWI=
X-Google-Smtp-Source: APBJJlFM8K5YTMV/9z6hQBG4B+Ayjg7URZ7En+3c+IN9aZ+Hle8xE2519r/LkeN46n/OMEfvZGCR8Q==
X-Received: by 2002:a05:6870:8a10:b0:1ad:3647:1fd0 with SMTP id p16-20020a0568708a1000b001ad36471fd0mr2852143oaq.22.1689785011075;
        Wed, 19 Jul 2023 09:43:31 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6b28:6b74:44a5:2cfa? (2603-8081-140c-1a00-6b28-6b74-44a5-2cfa.res6.spectrum.com. [2603:8081:140c:1a00:6b28:6b74:44a5:2cfa])
        by smtp.gmail.com with ESMTPSA id t7-20020a056870048700b001962e45f0d4sm2093775oam.24.2023.07.19.09.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 09:43:30 -0700 (PDT)
Message-ID: <4450c401-2a02-d66d-5615-22f65e291a04@gmail.com>
Date:   Wed, 19 Jul 2023 11:43:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 2/2] RDMA/rxe: Enable rcu locking of indexed
 objects
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
References: <20230718175943.16734-1-rpearsonhpe@gmail.com>
 <20230718175943.16734-3-rpearsonhpe@gmail.com> <20230719074904.GH8808@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230719074904.GH8808@unreal>
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

On 7/19/23 02:49, Leon Romanovsky wrote:
> On Tue, Jul 18, 2023 at 12:59:44PM -0500, Bob Pearson wrote:
>> Make rcu_read locking of critical sections with the indexed
>> verbs objects be protected from early freeing of those objects.
>> The AH, QP, MR and MW objects are looked up from their indices
>> contained in received packets or WQEs during I/O processing.
>> Make these objects be freed using kfree_rcu to avoid races.
> 
> Sorry, how use of RCU avoid races?
> 
> Thanks

The races are between destroy/deallocate/dereg verbs API calls and packets arriving or completing send
or deferred processing of wqes. Packets and wqes contain indices/keys/numbers that refer to objects.
The rxe driver maintains xarrays for each type of object that allow to lookup the address of the object
from its index and then take a reference to protect the pointer. The destroy verbs defer completion
until the reference count falls to zero and then removes the entry in the xarray. These operations
need to be atomic. One alternative is to use spinlocks to protect them but that places a load on
performance under heavy load which is typically dominated by the lookup function since objects tend
to have a long lifetime. rcu readlocks are a better alternative but depend on the deferred destruction
of the objects used in the rcu critical section. In certain benchmarks the use of rcu locking has
a very large performance advantage over spinlocks. For example 100s of QPs running over a 200 gbit/s
network.

Bob
