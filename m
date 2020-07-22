Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAA0229A1E
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgGVOaR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 10:30:17 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:34246 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgGVOaR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 10:30:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 48E123F4A0;
        Wed, 22 Jul 2020 16:30:13 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=J9tPxlDO;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qxFCURGVkHmS; Wed, 22 Jul 2020 16:30:12 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1A2CA3F418;
        Wed, 22 Jul 2020 16:30:08 +0200 (CEST)
Received: from [192.168.0.100] (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 9A868362551;
        Wed, 22 Jul 2020 16:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1595428209; bh=aSl2HPnj0FsbxHaER8NWcOJP1lNOrY9LWA/Axz0+ARc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J9tPxlDOyXydSD3slE2p0eNPxX3EnMvw3rCZ+KeUxQDcoGObCCmP0ZpThy3LkSLvn
         JFDx/0w+cDSwmSJPVlusn15yK+G3RxeKW7CfFJ53qq7wa1RdTrTaRIDyHU/i04o+R3
         QCfhbTQJ1VJwrsAlbklRs6g9PT7fFz7pDrquF7hI=
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     christian.koenig@amd.com, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
 <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
 <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org>
 <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
 <92393d26-d863-aac6-6d27-53cad6854e13@shipmail.org>
 <CAKMK7uF8jpyuCF8uUbEeJUedErxqRGa8JY+RuURg7H1XXWXzkw@mail.gmail.com>
 <8fd999f2-cbf6-813c-6ad4-131948fb5cc5@shipmail.org>
 <CAKMK7uH0rcyepP2hDpNB-yuvNyjee1tPmxWUyefS5j7i-N6Pfw@mail.gmail.com>
 <df5414f5-ac5c-d212-500c-b05c7c78ce84@shipmail.org>
 <CAKMK7uF27SifuvMatuP2kJPTf+LVmVbG098cE2cqorYYo7UHkw@mail.gmail.com>
 <697d1b5e-5d1c-1655-23f8-7a3f652606f3@shipmail.org>
 <CAKMK7uGSkgdJyyvGe8SF_vWfgyaCWn5p0GvZZdLvkxmrS6tYbQ@mail.gmail.com>
 <c742c557-f48f-1591-1d1d-a5181b408a67@gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <a046ea93-b303-17d4-add4-efd0a709cfd2@shipmail.org>
Date:   Wed, 22 Jul 2020 16:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c742c557-f48f-1591-1d1d-a5181b408a67@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2020-07-22 16:23, Christian König wrote:
> Am 22.07.20 um 16:07 schrieb Daniel Vetter:
>> On Wed, Jul 22, 2020 at 3:12 PM Thomas Hellström (Intel)
>> <thomas_os@shipmail.org> wrote:
>>> On 2020-07-22 14:41, Daniel Vetter wrote:
>>>> I'm pretty sure there's more bugs, I just haven't heard from them yet.
>>>> Also due to the opt-in nature of dma-fence we can limit the scope of
>>>> what we fix fairly naturally, just don't put them where no one cares
>>>> :-) Of course that also hides general locking issues in dma_fence
>>>> signalling code, but well *shrug*.
>>> Hmm, yes. Another potential big problem would be drivers that want to
>>> use gpu page faults in the dma-fence critical sections with the
>>> batch-based programming model.
>> Yeah that's a massive can of worms. But luckily there's no such driver
>> merged in upstream, so hopefully we can think about all the
>> constraints and how to best annotate&enforce this before we land any
>> code and have big regrets.
>
> Do you want a bad news? I once made a prototype for that when Vega10 
> came out.
>
> But we abandoned this approach for the the batch based approach 
> because of the horrible performance.

In context of the previous discussion I'd consider the fact that it's 
not performant in the batch-based model good news :)

Thomas


>
> KFD is going to see that, but this is only with user queues and no 
> dma_fence involved whatsoever.
>
> Christian.
>
>> -Daniel
>>
>>
>>
>> -- 
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
