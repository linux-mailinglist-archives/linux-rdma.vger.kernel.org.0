Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8933350C7E
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 04:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhDACTP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 22:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDACS6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 22:18:58 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01897C061574
        for <linux-rdma@vger.kernel.org>; Wed, 31 Mar 2021 19:18:58 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so777321otq.8
        for <linux-rdma@vger.kernel.org>; Wed, 31 Mar 2021 19:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ISdO7Xe9GZPJ1+8Q7Cc0shzku7UBk5iMOcyHlY8Yp4k=;
        b=NInBRxC2H6GuegJ9Ob37+yY7Fqxe4WJY/Q4PLx3bnOHBZAcSeOT+M0k3rpJmWb1PEl
         sttbo0Pebcf3x4jeB3zzHzaZp/0Rv9IrdYBrFGWQ9K82Uih3hSwTgRjs2m3GOuUhK1ib
         pOgN8rlGt4WvGt+4r4zqoUbeDzPBOaPqdqsKDITARyxHFA6OhX4LqE1YXZwwAFDN9qkB
         wOli9Qw8bnTgq4xsNkuSTaLqMs2rrNUoN/LZaqb5uUwPyLxhhqOQj1gjwgZm3QGZkFna
         VXtHOJ1gQYc/22A3zgoJilOP8Ij4ZJnsCjTPq+iutMo6bk+NRpFWYPF0QReFSuv3LYdD
         zFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ISdO7Xe9GZPJ1+8Q7Cc0shzku7UBk5iMOcyHlY8Yp4k=;
        b=McrMLY8sb5tkeQOiuq4TeByvm+Z2SFu8Z9X9r/2gjk9CTD3dUnHY3UIe06LxuBitQh
         VakQE1Hwdsg4CJV3CQsWIDenB+kRgkqbUghYkN8/L9oMlkzDO/IjO/c9Muv5UMpGn3C2
         c5qiiSrJTez22lv+m80mV+F6kH5HzajtNBKBinCejngJwXaSVKnAv2ElgMPgJwJyvhLa
         /jkYyY1H0gLQ4KoFPxkJcRh2AypvxRVz3zormMpDiNcOQTGpanuyqHwQ/7rYB6S+OyqN
         rF4H6Btkef3JTa8pYYULBsuF+e2jom6XuZo0Hp+lklcHoeVmSv8f4CEqcf7MwkMuXwWt
         kGcw==
X-Gm-Message-State: AOAM533+KF5eo6pFWwcHu8oInOzsymBnzr/cyCygnDfLmmO5ckWCJGL6
        hN2P0eKUEQwWTf5LU9VdBIST+E0/xGU=
X-Google-Smtp-Source: ABdhPJwecQdxMZQQBdXKjHCOzSSySZHUesi4u7KmF42ByJA1+fl3fAD//qDM2jAUM6LRXGukhwxY1w==
X-Received: by 2002:a05:6830:140e:: with SMTP id v14mr5052553otp.155.1617243537174;
        Wed, 31 Mar 2021 19:18:57 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:555b:611:3c2d:b176? (2603-8081-140c-1a00-555b-0611-3c2d-b176.res6.spectrum.com. [2603:8081:140c:1a00:555b:611:3c2d:b176])
        by smtp.gmail.com with ESMTPSA id v23sm892336ots.63.2021.03.31.19.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 19:18:56 -0700 (PDT)
Subject: Re: QP reset question
To:     Tom Talpey <tom@talpey.com>, Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <dec67c77-5870-12a9-3308-dd24ffbcfa8b@gmail.com>
 <6ac535d3-ce08-7e00-721e-63529d81c85d@talpey.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <5ad738e9-a2cc-4fce-2279-76793afb0502@gmail.com>
Date:   Wed, 31 Mar 2021 21:18:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <6ac535d3-ce08-7e00-721e-63529d81c85d@talpey.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/31/21 1:23 PM, Tom Talpey wrote:
> On 3/30/2021 5:01 PM, Bob Pearson wrote:
>> Jason,
>>
>> Somewhere in Dotan's blog I saw him say that if you put a QP in the reset state that it
>> - clears the SQ and RQ (if not SRQ) *AND*
>> - also clears the completion queues
> 
> I don't think that second bullet is correct, as you point out the
> CQ may hold other entries, not from this QP.
> 
> The volume 1 spec does say this around QP destroy in section 10.2.4.4:
> 
>>> It is good programming practice to modify the QP into the Error
>>> state and retrieve the relevant CQEs prior to destroying the QP.
>>> Destroying a QP does not guarantee that CQEs of that QP are
>>> deallocated from the CQ upon destruction. Even if the CQEs are
>>> already on the CQ, it might not be possible to retrieve them. It is
>>> good programming practice not to make any assumption on the number
>>> of CQEs in the CQ when destroying a QP. In order to avoid CQ
>>> overflow, it is recommended that all CQEs of the de-stroyed QP are
>>> retrieved from the CQ associated with it before resizing the CQ,
>>> attaching a new QP to the CQ or reopening the QP, if the CQ
>>> ca-pacity is limited.
> 
> There's additional supporting text in 10.3.1 around this. The
> QP is always transitioned to Error, then CQEs drained, then QP
> to Reset.

In https://www.rdmamojo.com/2012/05/05/qp-state-machine/ it says
Reset state
Description

A QP is being created in the Reset state. In this state, all the needed resources of the QP are already allocated.

In order to reuse a QP, it can be transitioned to Reset state from any state by calling to ibv_modify_qp(). If prior to this state transition, there were any Work Requests or completions in the send or receive queues of that QP, they will be cleared from the queues.

Not that he is the final arbiter but it turns out that CX NICs pass these test cases AFAIK. So I am suspicious that
someone is clearing out the CQs somehow. In fact I just found in mlx5: qp.c

if (new_state == IB_QPS_RESET && .... ) {
	mlx5_ib_cq_clean(recv_cq, ....)
	mlx5_ib_cq_clean(send_cq, ....)
}

which seems to be the culprit.

So in order to be compatible with CX NICs it looks like I need to do the same thing for rxe.

Bob
