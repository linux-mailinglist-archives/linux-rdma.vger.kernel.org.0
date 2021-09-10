Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857C04072D7
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Sep 2021 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhIJVSG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Sep 2021 17:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhIJVSF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Sep 2021 17:18:05 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EEBC061574
        for <linux-rdma@vger.kernel.org>; Fri, 10 Sep 2021 14:16:54 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so4044985otk.9
        for <linux-rdma@vger.kernel.org>; Fri, 10 Sep 2021 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=B6iWj9rP5R9pKZbOpKW2cBDKfth1pDK75Us/Qgtp2fM=;
        b=lDHUAI306zaWOnggFTRrmQXGx2n86m9jC5Ju+bWQpuKKvVF38WHQGaHilWVftMNXRx
         wwkynb+yqlbVhsoS/zA5Xv6P4g633jVaT3VRRDtyrRjGowSnGolUGDGMYuQFRn6+YOX8
         qLmgQxpanW5cNHrP3eukzG40f87tZdKM10twuqJuaU5Fb7FI1FPR0Xn3IH/9MgzVUeGd
         Xaeej7iC0bYeg3EBRlphAtUC6cBbT30Uc+FT69FAsLUvnMbL9zw8h1QlgigNc90rQoWS
         d9ZUYzvMVqe6Xs79i/yNAcHUpcnYrXOZIVYytK6UIY89hTGgmqYRyE/rbwwcDR9TBoh/
         h7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B6iWj9rP5R9pKZbOpKW2cBDKfth1pDK75Us/Qgtp2fM=;
        b=4GwkLJCulN0InB8v9cYE99GV887ifBTXt85ipxsaq+6XY/04EJk1J3SY9Q0XA7oeg5
         Dn4YdaKzq216FUWoABJhfUHVRlAZewGal7n6MsTXHP6hPcWPxUinP0hZyv18clFTaszx
         iq8fGNVYrESH4AOhNeRCTgPIEGe9Scg7RSdtnjSGBdNI43ifbEckeJJXoo5rCwm7j1mg
         DZIjvWnMXj2ZgIOW0pRhJcA0emcSp+/N4TmjLYz+kjugX/WKR9SL6em/Cs1qomN7k1VQ
         IyxVaRnTROHCDiiTq7/BjB9fecxuWmk/H65jw/ocKRgTNjuHrCB9hXyI2z5dlTFmGcP+
         LotQ==
X-Gm-Message-State: AOAM531BAEsgqiNBSBeSLn0umJQ3reJEO5Vh5LjyEqzCVxeV03kH7aEA
        dYxZofzhm+GNb5/DXNvFVCQ=
X-Google-Smtp-Source: ABdhPJzkzVeVgLAPeyX+mg6nyaBvxL+B5m+xQ0SXxpNveIKKFt5ZoJrhxOIpR3Dan8oMARUFmKf5Ug==
X-Received: by 2002:a05:6830:2470:: with SMTP id x48mr6050068otr.103.1631308612630;
        Fri, 10 Sep 2021 14:16:52 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:8a0c:d6d2:db4e:d565? (2603-8081-140c-1a00-8a0c-d6d2-db4e-d565.res6.spectrum.com. [2603:8081:140c:1a00:8a0c:d6d2:db4e:d565])
        by smtp.gmail.com with ESMTPSA id s24sm1563939oic.34.2021.09.10.14.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 14:16:52 -0700 (PDT)
Subject: Re: [PATCH for-rc v3 0/6] RDMA/rxe: Various bug fixes.
To:     Bart Van Assche <bvanassche@acm.org>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "mie@igel.co.jp" <mie@igel.co.jp>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
 <f0d96a3c-d49d-651d-93e0-a33a5eca9f1b@acm.org>
 <CS1PR8401MB10777EEC9CF95C00D1BA62ABBCD69@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
 <2cb4e1cb-4552-9391-164a-88f638dd3acf@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <b1d256ce-93ad-26cb-8aca-6935f9aa620d@gmail.com>
Date:   Fri, 10 Sep 2021 16:16:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2cb4e1cb-4552-9391-164a-88f638dd3acf@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/10/21 3:23 PM, Bart Van Assche wrote:
> On 9/10/21 12:38 PM, Pearson, Robert B wrote:
>> 1. Which rdma-core are you running? Out of box or the github tree?
> 
> I'm using the rdma-core package included in openSUSE Tumbleweed. blktests
> pass with that rdma-core package against older kernel versions so I think
> the rdma-core package is fine. The version number of the rdma-core package
> I'm using is as follows:
> $ rpm -q rdma-core
> rdma-core-36.0-1.1.x86_64
> 
> The rdma tool comes from the iproute2 package:
> $ rpm -qf /sbin/rdma
> iproute2-5.13-1.1.x86_64
> 
>> 3. Where did you get the kernel bits? Which git tree? Which branch?
> 
> Hmm ... wasn't that mentioned in my previous email? I mentioned a commit
> SHA and these SHA numbers are unique and unambiguous. Anyway: commit
> 2169b908894d comes from the for-rc branch of the following git repository:
> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git.
> 
> Bart.
> 
> 

You'd be surprised how much I don't know. I do know the numbers are unique but I
haven't the faintest idea how to decode them into useful strings.

In theory you are correct and rdma-core and kernels are supposed to be forwards and
backwards compatible but that is a goal and sometimes regressions do occur. I can try
to run with that version just to make sure.

There is a problem I have seen where some newer distros do not create the default IPV6
address from the MAC address. They randomize it (Ubuntu does this) and rxe is broken
as a result. I end up having to add a line like 

sudo ip addr add dev enp6s0 fe80::b62e:99ff:fef9:fa2e/64
  (where the MAC address is b4:2e:99:f9:fa:2e) just before the line
sudo rdma link add rxe_1 type rxe netdev enp6s0

But, when this is an issue rxe is really broken and almost nothing works so that may not
be an issue for you.

I will try to recreate your setup and retest.

Thanks,

Bob
