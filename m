Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9223B164F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 10:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFWI74 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFWI74 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Jun 2021 04:59:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92EFC061574;
        Wed, 23 Jun 2021 01:57:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l12so995986wrt.3;
        Wed, 23 Jun 2021 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZDxBkMAz03P8f+aMbelwxHltUcPmaJQiAy762htmSOw=;
        b=gKPDCYXud3/Ny6GugpuD8PxV3Af5S6G9njiquRSYdnYuIyUPc5d4pP41bLP8IncC+b
         q0G+HGYLvTHmPkI8X4/wi97s/dtCDFf49XbHlQi3Y8XHCnuItPph3HC8KyweTZ73ISLS
         6U70DcSwpJUikE7mrhXsZVWSIjwXeGdbOwnc7Gqoc2QWpTyRWMdjNrQM48WmgKKpatH8
         rBMNFlxNEU7ReMuigAM0E6MsLA5W/Uz06GOd1A8ft0Tyi8xffgc2Iz9N5ULy5mLXvBvT
         cN+ZLDZs6oxy0wovyiU+HR9yKzaIKdGhpmY80/A/dYDf/wFVdMrbAX+Lqv+PElUMYYoR
         h9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZDxBkMAz03P8f+aMbelwxHltUcPmaJQiAy762htmSOw=;
        b=EJzwHO47YKP74yDVa9fSBN3uf1jV+CvYs+8PEpUfW7UidRV6tYPJnejmOCQPRSfukh
         MrpoVbuHpUU8dX/l1ujsZNtkskbXrxdgzqYAYc1AQOoNfCGKIafKSWFFBaAcSCnRlPeM
         g25s6lJ9yq4K46kzvoXFgYsPdHPdywZF87CQBEjW5eIsf2ebeZu1iNSjENb3K/q5oLI1
         w1BFPsuP1C5aZr+gmQ+2t9mQ1b42B7TUUodxXic4m8+51GiNSt3aEIi086nv8kyuyPIS
         dmWixNurW+AUPxa6LZ015nnZ0In+h7EMFeyLaA3jZn4Uwi0IhS5UcdKN/eUk8c5fq3U3
         Rjkw==
X-Gm-Message-State: AOAM533SOrnYayiCUajFGGwiY97A2exfCwdh4XC4jnWdhkBqlphJ1wUU
        sjQpFxCBsj6BVaoG+c7IMhRY68hW4vo=
X-Google-Smtp-Source: ABdhPJyO8408BeqPk1gg6ZvXlAibkwfvIR/i0k8QSdflfw+3uxptNWJCkjKtYAdDMMiuTI3v4KYHDw==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr9929193wra.223.1624438657460;
        Wed, 23 Jun 2021 01:57:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:69e4:a619:aa86:4e9c? ([2a02:908:1252:fb60:69e4:a619:aa86:4e9c])
        by smtp.gmail.com with ESMTPSA id u12sm2195254wrr.40.2021.06.23.01.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 01:57:36 -0700 (PDT)
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Doug Ledford <dledford@redhat.com>,
        Tomer Tayar <ttayar@habana.ai>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
References: <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca>
 <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
 <20210622154027.GS1096940@ziepe.ca>
 <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
 <20210622160538.GT1096940@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
Date:   Wed, 23 Jun 2021 10:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622160538.GT1096940@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 22.06.21 um 18:05 schrieb Jason Gunthorpe:
> On Tue, Jun 22, 2021 at 05:48:10PM +0200, Christian König wrote:
>> Am 22.06.21 um 17:40 schrieb Jason Gunthorpe:
>>> On Tue, Jun 22, 2021 at 05:29:01PM +0200, Christian König wrote:
>>>> [SNIP]
>>>> No absolutely not. NVidia GPUs work exactly the same way.
>>>>
>>>> And you have tons of similar cases in embedded and SoC systems where
>>>> intermediate memory between devices isn't directly addressable with the CPU.
>>> None of that is PCI P2P.
>>>
>>> It is all some specialty direct transfer.
>>>
>>> You can't reasonably call dma_map_resource() on non CPU mapped memory
>>> for instance, what address would you pass?
>>>
>>> Do not confuse "I am doing transfers between two HW blocks" with PCI
>>> Peer to Peer DMA transfers - the latter is a very narrow subcase.
>>>
>>>> No, just using the dma_map_resource() interface.
>>> Ik, but yes that does "work". Logan's series is better.
>> No it isn't. It makes devices depend on allocating struct pages for their
>> BARs which is not necessary nor desired.
> Which dramatically reduces the cost of establishing DMA mappings, a
> loop of dma_map_resource() is very expensive.

Yeah, but that is perfectly ok. Our BAR allocations are either in chunks 
of at least 2MiB or only a single 4KiB page.

Oded might run into more performance problems, but those DMA-buf 
mappings are usually set up only once.

>> How do you prevent direct I/O on those pages for example?
> GUP fails.

At least that is calming.

>> Allocating a struct pages has their use case, for example for exposing VRAM
>> as memory for HMM. But that is something very specific and should not limit
>> PCIe P2P DMA in general.
> Sure, but that is an ideal we are far from obtaining, and nobody wants
> to work on it prefering to do hacky hacky like this.
>
> If you believe in this then remove the scatter list from dmabuf, add a
> new set of dma_map* APIs to work on physical addresses and all the
> other stuff needed.

Yeah, that's what I totally agree on. And I actually hoped that the new 
P2P work for PCIe would go into that direction, but that didn't 
materialized.

But allocating struct pages for PCIe BARs which are essentially 
registers and not memory is much more hacky than the dma_resource_map() 
approach.

To re-iterate why I think that having struct pages for those BARs is a 
bad idea: Our doorbells on AMD GPUs are write and read pointers for ring 
buffers.

When you write to the BAR you essentially tell the firmware that you 
have either filled the ring buffer or read a bunch of it. This in turn 
then triggers an interrupt in the hardware/firmware which was eventually 
asleep.

By using PCIe P2P we want to avoid the round trip to the CPU when one 
device has filled the ring buffer and another device must be woken up to 
process it.

Think of it as MSI-X in reverse and allocating struct pages for those 
BARs just to work around the shortcomings of the DMA API makes no sense 
at all to me.


We also do have the VRAM BAR, and for HMM we do allocate struct pages 
for the address range exposed there. But this is a different use case.

Regards,
Christian.

>
> Otherwise, we have what we have and drivers don't get to opt out. This
> is why the stuff in AMDGPU was NAK'd.
>
> Jason

