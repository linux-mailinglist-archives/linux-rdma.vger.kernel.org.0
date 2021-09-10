Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74F407313
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Sep 2021 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhIJVs0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Sep 2021 17:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhIJVsZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Sep 2021 17:48:25 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E6C061574
        for <linux-rdma@vger.kernel.org>; Fri, 10 Sep 2021 14:47:14 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w144so4861248oie.13
        for <linux-rdma@vger.kernel.org>; Fri, 10 Sep 2021 14:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=abpxKC7dCEgzuUcyOxjWNXNH6dWpFqSlAZ99pTR5MYk=;
        b=GKCVWnlbS6GE2cwLGx2sQgn78tKbwdyLbXQVwN8ju0XSBmrs/lQ3Q1gwmzhyA0T/CL
         KfouF5G6dmmPWIq7HtOnRudIiC9Yy9xxcD9YuVA0C3kKpKEriyQAPP+m08ykFgU+7YtO
         ZK+3sXziaVO80+kj7IRMA2TmcePlMZVyfYneJmfDvgNa/SnLdDKW6c+cr0V5plN4Og5v
         QfUN8n7G4MidRI3Ma/6guRUipSI5XlLtEIW4IJno1wAh/gpwMwC9dnDxVj3xbyCPTLvu
         UoIlGyN684o7Zzo+eLHUigXBbQym6bS1j9rdUIivNzRKAmnL89AM+bboJVAFCvTyHE2s
         z/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=abpxKC7dCEgzuUcyOxjWNXNH6dWpFqSlAZ99pTR5MYk=;
        b=WRzAKuM8HjZZWQtlANkYttdNGFTWYIypFiq8K4qTvDn5GnJVQvYG7rBJFuJm3gXzze
         s3Hp/IlwiIG1MMykvHL8uFfNjhNtFNoeHjVxOFuCTOmSBKZSlwXFl3pbtgTQZqeUmTGX
         bcE+Nox32ses2FPtAiwOKFg/pEq37m/QKtHMFjiB9shGwYqXScXZpDLvicrJ+ahQuqBE
         FzzHfTfofNStHs8nZx0jDdOgM26cH5OGWqK27Y+OiL0ngbyGbpDcOyCnziDDclrPvJMM
         adiroNHZJGepAPpgviv7ZW8QeM9Ndc+qSJ3RDLc1WujhidPA0nDAmZCk4QHgJGZ3C79/
         lp7w==
X-Gm-Message-State: AOAM531lPejxqh1akJCNpSmbAKNrI3QeGIM7kL4keyeG9e7cpW19YdZP
        V6Z7K9kmwg/YQon/gSelmIM=
X-Google-Smtp-Source: ABdhPJzrxISzdxOTev94tnktd9W38/GDm+GLy+wVhelZAt8ADsEKUjsGqEo2AxzO43Ie+IsWj+GPzw==
X-Received: by 2002:a05:6808:604:: with SMTP id y4mr6034790oih.86.1631310433742;
        Fri, 10 Sep 2021 14:47:13 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4191:9245:1adc:b45? (2603-8081-140c-1a00-4191-9245-1adc-0b45.res6.spectrum.com. [2603:8081:140c:1a00:4191:9245:1adc:b45])
        by smtp.gmail.com with ESMTPSA id a6sm1518885oto.36.2021.09.10.14.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 14:47:13 -0700 (PDT)
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
Message-ID: <cf358367-5cb8-0482-28e6-993a4f6bb047@gmail.com>
Date:   Fri, 10 Sep 2021 16:47:12 -0500
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

OK I checked out the kernel with the SHA number above and applied the patch series
and rebuilt and reinstalled the kernel. I checked out v36.0 of rdma-core and rebuilt
that. rdma is version 5.9.0 but I doubt that will have any effect. My startup script
is

    export LD_LIBRARY_PATH=/home/bob/src/rdma-core/build/lib/:/usr/local/lib:/usr/lib



    sudo ip link set dev enp0s3 mtu 8500

    sudo ip addr add dev enp0s3 fe80::0a00:27ff:fe94:8a69/64

    sudo rdma link add rxe0 type rxe netdev enp0s3


I am running on a Virtualbox VM instance of Ubuntu 21.04 with 20 cores and 8GB of RAM.

The test looks like

    sudo ./check -q srp/001

    srp/001 (Create and remove LUNs)                             [passed]

        runtime  1.174s  ...  1.236s

There were no issues. 

Any guesses what else to look at?

Thanks,

Bob
