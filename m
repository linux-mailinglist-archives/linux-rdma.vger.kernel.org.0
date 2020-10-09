Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64BD288F89
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390077AbgJIRCw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 13:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389966AbgJIRCk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 13:02:40 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9CDC0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 10:02:40 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m7so10924330oie.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WrMQxS4NYDrqPwUu1OfZC5/5zhxZJdHkd6QLOIBFsXA=;
        b=ePe7U29raPTGhL4TZAiC7XiUX0rz6bOALpJg9zVAFpXnkzapwuKb4zjP0WA2qIL89F
         sqRtXkv5helDStWXuwKbwfRI3o914c950je6++pxLVklPHehGEueyhfZ8+jyrfyP77Yc
         4EAE89vDWHyASmQ1ssEVz1kRbndkXHi5hdzVag7t8jO7SKFPafw6pSowjQfm3rztIjNh
         Wz0J0iuwRyszeLgLlvUxsZ071uDceS26KgGI8pyyGn1Q4IS9ewNXLL/hP3s5CLo4a3zr
         KHHj6DUiLAglbPSvZuboFWKXHTtbcNV67IywMT2D6wCqP1tGKk053SUPsStWgqSexkPI
         fyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WrMQxS4NYDrqPwUu1OfZC5/5zhxZJdHkd6QLOIBFsXA=;
        b=BH/WfZJQuhTpMtwBmI3Gy7gilSyzXsFxSi2lSHpo0uymalq/tLkG1/DOepz8Sn5HvI
         sgB+cYexh6wwYeoPdTqjVb9suX9/+MfXoPbNvpkC1DWU7wRYKO+UKTj3HXNM1KgqRTl8
         feevdplJ3LVJt1C/2q4nWbKrAovSNfPBBGsIA7DAYfDCQBzeZ5u+iZzDbr03iYzF5FOy
         jzAct9BdaiIxip1Dy+GpZI1Lc2gHvpcF6DvheYinGC3RRNbB93cnBxZ987pLX+S57oKE
         2ZKy8Avw1LSKrPjH00FunTvj63lQAHatVxg5y0izrG6+myAkGj7wnLp1YSpXRNwha1T4
         /x2A==
X-Gm-Message-State: AOAM532lSP6OBYJ8FhUJP90ubntJ2TY6KdddAJo/t4+U1FVVbExj8Y+3
        L5435Wyu/HH0J6+sm1E3tyU=
X-Google-Smtp-Source: ABdhPJxl1KYZNk0FfjYTWXqQsMix8ofV+h/VHjSuc3mNb/UH6AGMxfNSXuB4LxBsR9MEezOrzdVbOA==
X-Received: by 2002:aca:c546:: with SMTP id v67mr3106079oif.24.1602262959677;
        Fri, 09 Oct 2020 10:02:39 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:21af:60b5:ebc7:e8c6? ([2605:6000:8b03:f000:21af:60b5:ebc7:e8c6])
        by smtp.gmail.com with ESMTPSA id x13sm8197539oot.24.2020.10.09.10.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 10:02:39 -0700 (PDT)
Subject: Re: [PATCH for-next] rdma_rxe: fixed bug in rxe_rcv_mcast_pkt
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20201008203651.256958-1-rpearson@hpe.com>
 <20201008233305.GA422633@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <b2bdcc9e-e882-259c-35da-f047a01a070d@gmail.com>
Date:   Fri, 9 Oct 2020 12:02:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008233305.GA422633@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/8/20 6:33 PM, Jason Gunthorpe wrote:
> On Thu, Oct 08, 2020 at 03:36:52PM -0500, Bob Pearson wrote:
>> - The changes referenced below replaced sbk_clone by
>>     taking additional references, passing the skb along and
>>     then freeing the skb. This deleted the packets before
>>     they could be processed and additionally passed bad data
>>     in each packet. Since pkt is stored in skb->cb
>>     changing pkt->qp changed it for all the packets.
>>   - Replace skb_get by sbk_clone in rxe_rcv_mcast_pkt for
>>     cases where multiple QPs are receiving multicast packets
>>     on the same address.
>>   - Delete kfree_skb because the packets need to live until
>>     they have been processed by each QP. They are freed later.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> Fixes: 86af61764151 ("IB/rxe: remove unnecessary skb_clone")
>> Fixes: fe896ceb5772 ("IB/rxe: replace refcount_inc with skb_get")
> 
> Fixes lines go before the Signed-off-by
> 
> Makes sense to me, applied to for-next
> 
> Thanks,
> Jasno
> 
Thanks.
