Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C193FE7F5
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 05:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhIBD0Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 23:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbhIBD0Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Sep 2021 23:26:24 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D403C061575
        for <linux-rdma@vger.kernel.org>; Wed,  1 Sep 2021 20:25:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso837262otp.1
        for <linux-rdma@vger.kernel.org>; Wed, 01 Sep 2021 20:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XxLE+JUPl+6R093qfK2LTkCYzNfex8WFBHcfa2pbhLs=;
        b=DF7H8rEOm6OUt1EjuUYGY82BkFb6W9lV7jJ1cR8ALgoB0MTwdWWX+vRh2HGN8533wx
         /sc0pFrBUz4p01qI9DmpyczVV9hD4zEvQYCW3gTMnZFfbdnQ8TaERAfxd3OZa01wCjKG
         HKGhaArXibFmQlUFZRpZ71A+1iS+Y41DzO3xij7upg7mndF9nEtYzRZMhoOkvKwSycJm
         NLdo5KYp5XApb9Ww9I0ARYNBaSBt8dl2gaftmwkr2FxmdGXQdfB69b3nlzqoO7g9ZWi+
         0FPBbDWW03Whwu+7977ocyZ/Nh9dSrkSWJTZJSpJ8OFs9MtlTfMgbG5SiJxf8gfI0IWp
         Sncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XxLE+JUPl+6R093qfK2LTkCYzNfex8WFBHcfa2pbhLs=;
        b=IoHlf8QCUh7OMUQsktxnGIflHKF5MzElcx2IFLf+PFnoO14t4V6iMRTRfnaQa5rAO9
         ZJF4dNZRK0HV4bj5as/OVp3nGmRlrVRLZk+ePVB65CdH3g68r48OuiByHqK8dOikFK/u
         y0KbZ7AJs+okJ+Dou0MByK8XrW+Y3hKYL+vfKFgnrPrgblRLwYvX+GKELupGsSsuJezV
         V6wDm67HdR1K83v1EbS0X9uO+3pCe33bZF8JL+Qy+vUK6IFtdm/JlbIhI2OmvzYHHwZX
         zPei7TmgD24UCfuFcz94/BgRbCfdDauV4vlKsvk3aPD33jDYmB0RuVnhTQs6/crLgd4S
         JVng==
X-Gm-Message-State: AOAM533XHJCrbH3Bz99+e43unRWwrmV4jNXmfOTm/1YJkS32YKpIjlxo
        7jM7SLfJezM2PiPnysfu1tZIwWUtetA=
X-Google-Smtp-Source: ABdhPJzs7KkwytZHLgwepM3DV42KZBiquLsMn/064oJALnRZrIB+WJ8bqaUrQkN03p2E5+7cpSgPkg==
X-Received: by 2002:a9d:6192:: with SMTP id g18mr848489otk.314.1630553126465;
        Wed, 01 Sep 2021 20:25:26 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:fb7d:2886:9924:bae9? (2603-8081-140c-1a00-fb7d-2886-9924-bae9.res6.spectrum.com. [2603:8081:140c:1a00:fb7d:2886:9924:bae9])
        by smtp.gmail.com with ESMTPSA id s7sm136251ook.8.2021.09.01.20.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 20:25:26 -0700 (PDT)
Subject: Re: rdma link add NAME type rxe netdev IFACE stopped working
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <f1c73298-b37f-8589-bdb1-a727c3b7c844@gmail.com>
Message-ID: <b4a1e866-95ed-7bf1-f9da-bca5700db7e1@gmail.com>
Date:   Wed, 1 Sep 2021 22:25:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f1c73298-b37f-8589-bdb1-a727c3b7c844@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/1/21 10:04 PM, Bob Pearson wrote:
> rdma link has started to fail today reporting an error as follows after working before.
> 
> bob@ubunto-21:~$ sudo rdma link add rxe0 type rxe netdev enp0s3
> 
> error: Invalid argument
> 
> bob@ubunto-21:
> 
> Nothing has changed in the past day or two except I pulled recent changes into rdma-core. This runs after
> typing
> 
> export LD_LIBRARY_PATH=/home/bob/src/rdma-core/build/lib/:/usr/local/lib:/usr/lib
> 
> which is also the same. Any ideas?
> 
> Bob
> 

Update. I then recompiled the kernel after pulling latest changes and now it works. In theory this shouldn't be necessary. The kernel APIs should be beckwards compatible.

Bob
