Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195F1575646
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiGNUUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiGNUUe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 16:20:34 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E0E65D67
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 13:20:33 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v19-20020a9d69d3000000b0061c78772699so2017252oto.11
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9yW/rhQyiNsXhbwXiyl144xqihZ3MBO+l7nQST6EohE=;
        b=Z38jjxTxWXEKsHHjic5qDLsQKR2kyC9olhvL8g89N0cfq+Ej8VgCNXSj5AwMi1+MA7
         +nCKIEIC/hNhcw/MBxzNKIdgRg+5pyNIt2a0/YgIAmRq1N8DunjCe0i5GT97FDVEWce3
         6WrRR15bjoCQKDmO5BaO6qS4BBjPfs1B59KCyllqf8WHMcn6nduf5FY01jh/GyzzEKHB
         fBoeNmirQbayZDpuHzF6m5I03HLbckXr7nzjj4puIsTO/o8IOVhFMFZI3/Feij5h+wT+
         jGUH69ocnm77nk5rdx7K4CnvMfFenCtPVsq/E7iUJCrPSJJsFAbVsXK3SOBgFCS4jNv3
         huPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9yW/rhQyiNsXhbwXiyl144xqihZ3MBO+l7nQST6EohE=;
        b=lBnFcvzQ0NdjxaiYQoxV9uibc4y5GOiLxv7agb43Qi+Gq0Oob8mcbXGM6Ixo1s+kFB
         k4c3CWXXURB4dWuLr3qVfojBDD+D22PC9O9Qv5QI7TQJlxPqQfojg/IuWdO7+fh0TTe5
         UsB7GxxpuRcQCX4i3Is18eYLVqnvup/39+Ly6T/GcVbd8IRWBMhe4cUn8T+dmR+cz7DC
         HG4AoeBUzoEpR/QfDMKGjumHrTEQMJHUeh5/0c1XYBqh5II3oGIzCDHQP/yF489oVQvI
         mnsKQxk3jwjy5uTmlJApu3zLkCDkxKCnsyud7oOOqNwgdRFPAxoDnMyW71PLisgXLqvi
         Od0g==
X-Gm-Message-State: AJIora8e5T9c/ek6n+5xnOHyslkHl849Tg/xFG6fSu26laOVeOpxPE/w
        rsMzXvZvcpbCFlJEkwmeYIsh7Rf+TcA=
X-Google-Smtp-Source: AGRyM1sGqg0Xnv2GcF1tbcoLGC/fWSXRVn2A0D3XctrLS1MqX/I6p9CvSz8FYqlkEyFZV8g8WVvIQQ==
X-Received: by 2002:a05:6830:6388:b0:61c:80a9:d5b6 with SMTP id ch8-20020a056830638800b0061c80a9d5b6mr601586otb.124.1657830032955;
        Thu, 14 Jul 2022 13:20:32 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id v6-20020a544d06000000b00333f889c9c2sm1012290oix.33.2022.07.14.13.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 13:20:32 -0700 (PDT)
Message-ID: <fb4614e7-4cac-0dc7-3ef7-766dfd10e8f2@gmail.com>
Date:   Thu, 14 Jul 2022 15:20:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-rdma-core v2] pyverbs: Fix wrong rkey in
 test_qp_ex_rc_bind_mw
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     edwards@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
References: <20220519155810.28803-1-rpearsonhpe@gmail.com>
 <20220704132450.GA1420265@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220704132450.GA1420265@nvidia.com>
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

On 7/4/22 08:24, Jason Gunthorpe wrote:
> On Thu, May 19, 2022 at 10:58:11AM -0500, Bob Pearson wrote:
>> The current test_qp_ex_rc_bind_mw in tests/test_qpex.py uses an incorrect
>> value for the new_rkey based on the old mr.rkey. This patch fixes that
>> behavior by basing the new rkey on the old mw.rkey instead.
>>
>> Before this patch the test will fail for the rxe driver about 1 in 256
>> tries since randomly that is the freguency of new_rkeys which have the
>> same 8 bit key portion as the current mw which is not allowed. With
>> this patch those errors do not occur.
> 
> While this patch seems correct, I don't understand these remarks.
> 
> IBA says:
> 
>  After the bind operation completes, the R_Key must consist of the 24
>  bit index associated with the Type 2 Memory Window and the 8 bit key
>  supplied by the Con- sumer in the Post Send Bind Memory Window Work
>  Request.
> 
> Meaning the bind should only be processing the lower variant bits in
> the first place, and there should be no condition where the bind could
> fail since all varient bits are always legal.
> 
> Bind does not allow changing the upper fixed bit - only allocation can
> change those. So if rxe kernel side is changing the upper bits it is
> also buggy. IMHO it would be appropriate to fail the operation if
> given rkey has unmatched upper bits.
> 
> Jason

The root cause of this failure was that the script generated the new mw rkey
from the mr rkey which had nothing to do with it. The current mw implementation
enforces a rule that the new mw rkey have a different key portion than the old
mw rkey. Since the mr rkey is changing independently from the mw rkeys this rule
will randomly cause an error approx 1 out of 256 times. You are questioning the
validity of this rule.

According to the IBA there are two types of mws type 1 and 2. Type 1 mws are bound
through a user space api ibv_bind_mw() while type 2 mws are bound with a sq operation.
In the kernel there is no implementation of the type 1 bind API so it is implemented
by mapping it into a sq operation.

The sq operation has 3 key parameters, the mr lkey, the original mw rkey and the new
key portion of the mw rkey. Only the low order 8 bits of this parameter are used.

For type 1 mws the operation returns a new rkey key portion which is guaranteed to be
different than the original one. According to the man page the user space app must
save the old rkey and if the operation completes with a failure it must fix up the
key to the old value. Checking the key is different in this case is just paranoia since
the rdma-core library is supposed to change it.

For type 2 mws, as you say, the key portion is entirely up to the consumer so any value
is valid. The current test that the key portion is different can be dropped. There is
a slight problem though which is fixed by the test even though it is not proper. C10-68
requires that as soon as a bind operation is complete that no operations referring to
the previous binding shall succeed without error. The problem is how do you know
if the rkey is the same for the new and old bindings are the same. The sane way to do
this is to make sure they are different. This is how all the examples of use cases I
have seen proceed.

Bob
