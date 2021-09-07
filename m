Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD1402D1D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Sep 2021 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbhIGQtF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Sep 2021 12:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345059AbhIGQtF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Sep 2021 12:49:05 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5933C061757
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 09:47:58 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id g4-20020a4ab044000000b002900bf3b03fso3107044oon.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p5ZZ5leAZpSkD9SMWgt2Uu7TNcU6df/2TvdWtF5N/S4=;
        b=c+yRvFjz3qDK/NS0DrX7aMNp43X0u7IG0lID8yNpQvPzRYkfbefO5OUGhp3zY+AYEM
         mQsVNJ/9892WAvSand2ar2uaPAbBSg/xwnYY89K0Ct5mA6qQzVuF3mH3rfY8SnHmQz5a
         8+Tsrc0uOQJnWWviHGOQnmRbyp/k+BiQSLJHqabjxXG3ZpscKkdLGEAMo2xkZev6rDfS
         Tlje+hE6tA1Jb7y8C9pl/mphbia1BbErI2790azs4B0U1guurP/J7nhfNRT6CmlC7k7E
         GPQSNy1TthF2anMnycaCAW+usoiS3IV1TC9XHpJvN5nL8oNeS1WTNIl8poFEMmRupeML
         Pw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p5ZZ5leAZpSkD9SMWgt2Uu7TNcU6df/2TvdWtF5N/S4=;
        b=nW4RHsBvvghH7hpKcXmcdSPwxyl9Hz9QrTLzWqFexrrE59bt2j9VgiT0bCLeYRiEES
         ijQjuspCsuk7s4vAZ2TLzgvMaJg7NAKlPd/4fLDsXKzJ0iLzxIXzBQa1/8WJR2GzLEHc
         P25m2Dog9ypC1GOxbLbZedlwXloWK/O7jP2UVhMKC+WvjRHPnM4IuKCVZeqMhQ2w7Znz
         1nPMWma2B+wuaf6DbNqFTeubw/V5PBl8KBuPXz+jbju68BDTUc0592gO+DXa6KSXvj4L
         TowopZV2fdeCtKbim9jAvugHFIh389m45i+WO4Y5VaRd1k3G6jKX82Lnv27TB/uXTPt2
         r74A==
X-Gm-Message-State: AOAM532CNegeBTVl8+taZjf9sGxCi+zb1qrXoiNwVobARAbZHcokMYLh
        /iyM0IPZ3ituTKiFy1faMtI75HUxBfs=
X-Google-Smtp-Source: ABdhPJyMY542dLz3ZFPJ+QLgTHYWR3H/GdqTAJ5900/AFABFJC7zYyHrrWAMrpG2Mq52WxLgy73OFQ==
X-Received: by 2002:a4a:3c5c:: with SMTP id p28mr662921oof.82.1631033277947;
        Tue, 07 Sep 2021 09:47:57 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:bc73:7f2:84bb:9731? (2603-8081-140c-1a00-bc73-07f2-84bb-9731.res6.spectrum.com. [2603:8081:140c:1a00:bc73:7f2:84bb:9731])
        by smtp.gmail.com with ESMTPSA id x1sm2478870otu.8.2021.09.07.09.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 09:47:57 -0700 (PDT)
Subject: Re: blktest/rxe almost working
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
 <20210902233853.GB2505917@nvidia.com>
 <1610313b-e5d0-a687-a409-d1275baf7f95@gmail.com>
 <711c089d-ce66-63e8-4d80-0bd19f22607c@acm.org>
 <20210904223056.GC2505917@nvidia.com>
 <fcf6f57e-972b-f88e-84bf-d1618fd3e23e@gmail.com>
 <20210907120156.GV1200268@ziepe.ca>
 <9e6783d0-554c-17de-c72f-fae766099480@gmail.com>
 <20210907163939.GW1200268@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <69f9746e-6989-179e-6fdf-6920722bb712@gmail.com>
Date:   Tue, 7 Sep 2021 11:47:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907163939.GW1200268@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/7/21 11:39 AM, Jason Gunthorpe wrote:
> On Tue, Sep 07, 2021 at 11:35:17AM -0500, Bob Pearson wrote:
> 
>> Interesting. But if that is the case the bigger problem is the ib_map_mr_sg() call which updates the
>> mapping. rxe definitely does look at the mr->rkey value but we could fix that. It also looks at the
>> mapping which is updated by ib_map_mr_sg(). My impression is that HW also uses this mapping or does
>> HW also copy all the FMRs into SRAM?
> 
> Yes, real HW has a copy of the DMA list. The sg in the mr struct is
> for CPU use only.
> 
> It is not OK to use the CPU SG list inside the MR for DMA by HW, it
> has to be synchronized with the WR.
> 
>> There seems to be an assumption that users will be looking at CQE.
> 
> Yes, the kernel has to be driven by CQE, not only for data transfer
> but the DMA unmap of the SGL cannot be until after the invalidation
> CQE is observed.
> 
> Ie the CPU should have two DMA lists active during the invalidation
> cycle.
> 
> Jason
> 

OK. Not 100% sure what that implies for SRP. SRP does *not* look at the CQE for invalidate and register
WQEs. I can fix the rkey and DMA list semantics, making a copy of the list which is installed by the
register WQE.
