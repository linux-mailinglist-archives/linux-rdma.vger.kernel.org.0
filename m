Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40C2407318
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Sep 2021 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbhIJVv3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Sep 2021 17:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhIJVv3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Sep 2021 17:51:29 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF89C061574
        for <linux-rdma@vger.kernel.org>; Fri, 10 Sep 2021 14:50:17 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso4168553ota.8
        for <linux-rdma@vger.kernel.org>; Fri, 10 Sep 2021 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tnW0JbuHwARcXQ5UxjiJDKO5kKEjnIA8CEG3EeEGmhc=;
        b=ZTQTK+gwjXYLZZG3IXsVlguQ39PoK2zdEy4vEvYVUO+9ffYpYJQEfi2e4rO+DR+rXq
         EKz89hJtgIWd4oudJ/Dqs/JrtMfbJV6h4RUxCRKSQUZqU5sv6I57Ks3uTEoBC7vqs3BS
         v7mWEjrrR4tgqKAvdBx+EQ2P8WKTogeBAEfnRNwYaEtbs+SVR/LUyJgd0YVfLSG6clwm
         iM+VqkuN6i+hsGYpq9/iOD1l6tTi7QYgTZ1nGiaKqIm+pWseZCcosPlM0D5aH3k6LkqX
         +m9kQPbXyns1fF1OOOT47jwXPFrlnITuWV7Je02IV4ckDWtpN7r5BYDpkvnhAY8TJVmM
         Bvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tnW0JbuHwARcXQ5UxjiJDKO5kKEjnIA8CEG3EeEGmhc=;
        b=DFfzu3mNgks47/D7yCeuQ4O8GepeEdhE0GFupRb0+4j8JsY3LB9AXQUTJ+e8pk4Xna
         +eyd6g+rXXxHzBmVDkSRqABX2yhskY5JFpXWe4M0l4lroN8h4jdmS54kFf1leXe4v1U7
         VZ1VqDFiGllq9Epli7AskzFaqnQrYVnZ07ooFnCyMZlTuP1jKdkEjGQ4r0Vf3gyV2KOH
         p/U+r4DaAWLbzIosMQhBcLRmul+DbaXOQSNyQpVPdneVPBhdjgwVfMk4n3OgGrJyCmFD
         m/oDPdOo7zsUHuS+5VhsUe2/f/JPAqKSxkZgITG43kUWZRpQbHXA6HpQMy0ewRJIaE5s
         SP+A==
X-Gm-Message-State: AOAM531h/QMrE8k2qcKosn6ONo4OWDeckDQlv4VHQ+OdZy5zBDtOCai7
        Aiy4POxDBh7luNSPc90Ug0U=
X-Google-Smtp-Source: ABdhPJxjRAZX53Fh31r/691h/hoHQ5iXhPxdZWBIN1L13kKXLAwjMay7uE6f+8tw8WSoIXmUeBLoYQ==
X-Received: by 2002:a05:6830:4411:: with SMTP id q17mr6620477otv.48.1631310617370;
        Fri, 10 Sep 2021 14:50:17 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4191:9245:1adc:b45? (2603-8081-140c-1a00-4191-9245-1adc-0b45.res6.spectrum.com. [2603:8081:140c:1a00:4191:9245:1adc:b45])
        by smtp.gmail.com with ESMTPSA id u15sm1453804oor.34.2021.09.10.14.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 14:50:17 -0700 (PDT)
Subject: Re: [PATCH for-rc v3 0/6] RDMA/rxe: Various bug fixes.
From:   Bob Pearson <rpearsonhpe@gmail.com>
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
 <cf358367-5cb8-0482-28e6-993a4f6bb047@gmail.com>
Message-ID: <598ffc9f-1971-0b46-f2fc-68ed21fb2f1c@gmail.com>
Date:   Fri, 10 Sep 2021 16:50:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cf358367-5cb8-0482-28e6-993a4f6bb047@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/10/21 4:47 PM, Bob Pearson wrote:
> On 9/10/21 3:23 PM, Bart Van Assche wrote:
>> On 9/10/21 12:38 PM, Pearson, Robert B wrote:
>>> 1. Which rdma-core are you running? Out of box or the github tree?
>>
>> I'm using the rdma-core package included in openSUSE Tumbleweed. blktests
>> pass with that rdma-core package against older kernel versions so I think
>> the rdma-core package is fine. The version number of the rdma-core package
>> I'm using is as follows:
>> $ rpm -q rdma-core
>> rdma-core-36.0-1.1.x86_64
>>
>> The rdma tool comes from the iproute2 package:
>> $ rpm -qf /sbin/rdma
>> iproute2-5.13-1.1.x86_64
>>
>>> 3. Where did you get the kernel bits? Which git tree? Which branch?
>>
>> Hmm ... wasn't that mentioned in my previous email? I mentioned a commit
>> SHA and these SHA numbers are unique and unambiguous. Anyway: commit
>> 2169b908894d comes from the for-rc branch of the following git repository:
>> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git.
>>
>> Bart.
>>
>>
> 
> OK I checked out the kernel with the SHA number above and applied the patch series
> and rebuilt and reinstalled the kernel. I checked out v36.0 of rdma-core and rebuilt
> that. rdma is version 5.9.0 but I doubt that will have any effect. My startup script
> is
> 
>     export LD_LIBRARY_PATH=/home/bob/src/rdma-core/build/lib/:/usr/local/lib:/usr/lib
> 
> 
> 
>     sudo ip link set dev enp0s3 mtu 8500
> 
>     sudo ip addr add dev enp0s3 fe80::0a00:27ff:fe94:8a69/64
> 
>     sudo rdma link add rxe0 type rxe netdev enp0s3
> 
> 
> I am running on a Virtualbox VM instance of Ubuntu 21.04 with 20 cores and 8GB of RAM.
> 
> The test looks like
> 
>     sudo ./check -q srp/001
> 
>     srp/001 (Create and remove LUNs)                             [passed]
> 
>         runtime  1.174s  ...  1.236s
> 
> There were no issues. 
> 
> Any guesses what else to look at?
> 
> Thanks,
> 
> Bob
> 

The 8500 is not required. It runs fine with 4K MTU just as well.
