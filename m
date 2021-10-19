Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092104341A3
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Oct 2021 00:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhJSWxh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 18:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSWxh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Oct 2021 18:53:37 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADEBC06161C
        for <linux-rdma@vger.kernel.org>; Tue, 19 Oct 2021 15:51:24 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so5972693otq.12
        for <linux-rdma@vger.kernel.org>; Tue, 19 Oct 2021 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+FgndK/fJPELjHuVfDTC3JkWr9vKqCMEYi1ei+wlyU4=;
        b=gX6xzexHg8hwOvEWDR6z+yvLNGmIb4TPVN80X/5x4ow/no7wvZ+fV+gS9oLzhk8jUu
         ZgHl+FFLuAt8BWQxWQ3bpbuZCRR5ganqIpifGx+IlNdfldSNME9IigDO/KZT9+lFEuWv
         izi4fv7xzsWaQabtkFT9IA+jPwPEzOuQZ2160h6DSCzRD1teVPCqlMl1ElVeW7OFcaVl
         JKJK7bgisDZnK8DP/fpRW9WMpE153eP9Z3xXoX8yhjI+NSt6V7BU5/ehIrogxl9iJmV5
         j0obwzrmYeAZzNwiBMKVkO7Qdiq4CThPg/lnyoPV76nheN7mWF3halN5huZEg2cGyG3c
         hbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+FgndK/fJPELjHuVfDTC3JkWr9vKqCMEYi1ei+wlyU4=;
        b=sKuPA0y12utc6yh9Z6K0Y0hfCJH9Ud/kLU0ZEBT1oh9bvSg88DuIgS2iuapBUMxyOZ
         YrB9h6oA8b+j7RfGqieBZnoIITiNdc73exY0+PuDwLZIQ3E0j0Az/Fk337SdUcpeHPRq
         cMNhoR5oY6FpS+/wjiS56iTETeSVBHK7uli/+gPsdnGmNzeIzBySO3pJDQVjWsU1VG2s
         RPnNkwDsCJ2rDM2BL9Ef6pJS8DOERm2ZZ0uAX66YPz+kYUchjNDzf4A3C+q/ciZztzz3
         KZWuLfOOX5nK0mfajmA1SwCGRetm1DXjcgOYhG0Z4saFi6HKuK1aLAA2S7u/RXRfHKm8
         cCWw==
X-Gm-Message-State: AOAM531jZZkf7zLyuWeX+NCbI4jIR4yU2lhIs3twJTCc9AmToB/gP03s
        qANSyBpHFPXFPGXXXsIWtojp0m9MtLc=
X-Google-Smtp-Source: ABdhPJzftjcOyLaE5+9gaBr8qa2XTQ12QiMkzH5cQ1h/c/3fR7AWUJufv9UzeVPCiuLaywGQI6QCWw==
X-Received: by 2002:a9d:4616:: with SMTP id y22mr7599970ote.215.1634683883165;
        Tue, 19 Oct 2021 15:51:23 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:cc4:8d22:c1eb:41c4? (2603-8081-140c-1a00-0cc4-8d22-c1eb-41c4.res6.spectrum.com. [2603:8081:140c:1a00:cc4:8d22:c1eb:41c4])
        by smtp.gmail.com with ESMTPSA id x8sm105440otg.31.2021.10.19.15.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 15:51:22 -0700 (PDT)
Subject: Re: [PATCH for-next 0/6] RDMA/rxe: Fix potential races
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <YWUskJBU5ZHrIhhS@unreal> <bfb21e28-2f92-e372-871e-32c5f72338f4@gmail.com>
 <YW7DGrG04eJwbf7d@unreal> <ccdf6ffa-dc14-7b50-7a17-c0d01d9305bf@gmail.com>
 <20211019184327.GX2744544@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <8f8c6aa3-b13e-16b8-a0ac-e68fe327a660@gmail.com>
Date:   Tue, 19 Oct 2021 17:51:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019184327.GX2744544@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/19/21 1:43 PM, Jason Gunthorpe wrote:
> On Tue, Oct 19, 2021 at 11:35:30AM -0500, Bob Pearson wrote:
> 
>> Take a look at the note I copied you on more recently. There is some
>> progress but not complete elimination of rxe_pool. There is another
>> project suggested by Jason which is replacing red black trees by
>> xarrays as an alternative approach to indexing rdma objects.  This
>> would still duplicate the indexing done by rdma-core. A while back I
>> looked at trying to reuse the rdma-core indexing but no effort was
>> made to make that easy.
> 
> I have no expecation that a driver can re-use the various rdma-core
> indexes.. that is not what they are for, and they have a different
> lifetime semantic from wha the driver needs.
> 
>> of the APIs are private to rdma-core. These indices are managed by
>> the rxe driver for use as lkeys/rkeys, qpns, srqns, and more
>> recently address handles. xarrays seem to be more efficient when the
>> indices are fairly compact. There is a suggestion that IB and RoCE
>> should attempt to make indices that are visible on the network more
>> sparse. Nothing will make them secure but they could be a lot more
>> secure than they are currently. I believe mlx5 is now using random
>> keys for this reason.
> 
> Only qpn really benifits from something like this, and it is more
> about maximum lifetime before qpn re-use which is a cyclic allocating
> xarray.
> 
> Jason
> 

Thanks. I had given up long ago on using the rdma-core indices. Leon would like
to get rid of rxe pools. Actually (I just checked) there is only one remaining
object type that is not already allocated in rdma-core and that is MR. (The multicast
groups are a special case and not really in the same league as PD, QP, CQ, etc. They
probably should just be replaced with open coded kzalloc/kfree. They are not shared
or visible to rdma-core.) So with this exception the pools are really just a way to add
indices to objects which can be done cleanly with xarrays (I have a version that
already does this and it works fine. No performance difference with red-black trees
though. Still looking to get rid of the spinlocks and use the rcu locking in xarrays.)

Bob
