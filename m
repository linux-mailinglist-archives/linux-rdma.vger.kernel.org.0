Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2104E162D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 11:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390717AbfJWJcV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 05:32:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52473 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390380AbfJWJcV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 05:32:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so20427675wmh.2
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EwzJlitg6ojpTgAu/CD7TkQAOGgugVP58FFyv2RoWtw=;
        b=rVZ4tg4I22VQyUArQiihwBc10IhXwEssWDf1EaFeaIXqsGC6JfdVQ3m8a/+eFez/uv
         cBI5tmVKmRe5xwC2hsqoyWkcMnEwVvJMzguUqKhiylze81YYpUjxlJGmahgktbdYGMF3
         7stesmV/VO9FsVwh0xa64s1wOLimS1Yr1zQaK49meIOcg2FOzdWsFrqVWuNkJZMA9ler
         J6m58AAFZyFWE0TN2mMV8z2LWcUCEKPX/BZHda4GtmP9hHo+s6q4FeIosOmGcNkqUI4R
         06UI7jOr184MX3RX6QI8HFxtm2ezvjUTDRQxyx419bdvk6QI/kKmCCrZJGIzpz5QWD0Q
         1T9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EwzJlitg6ojpTgAu/CD7TkQAOGgugVP58FFyv2RoWtw=;
        b=TcvEAeYcXj5mtOThO1ieKXs+U4Ucc7dN6kCJb0iqHJGw0zMYmlCfotgllEtnEppa3J
         XwzGxfpgW+kzOaVRoIcTJWGGcnJ2hNeZG/QH3Sw5Ez4cLAlB/pUoI2Q8EA4fitWwSIA2
         TbQYotOavz/j5nrECZndDSoEkvXSm07FIjVwBCIfmAfZieZWCRRm8p0IYCjrxmr8v16j
         SoqhQOz9c16RX0Tw2HfAgMXBh09pzhmkAZ5XimhNltoT2orS9ly3oser4eL+OOWZjDQ6
         aq+bManOgYME466ZHggoUb6MM7Ekq4TpAHSBgolpdeHbYvxVwLQC5gHYJXMU11Gl51kS
         6D1A==
X-Gm-Message-State: APjAAAXXFRRBGqXJois/XWF8yorBeK4XqsghJsmkEdM4BBsJfe+gjgJi
        X0aZgyWzXf6BCeckYjB+ZIGtDXfG
X-Google-Smtp-Source: APXvYqy8pbfED4xFpipcpITgTxdfhElPA191PjQR1rjhPeOrBaay791F3suidtz4fnnlrOK6oWHG4g==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr6789042wmf.63.1571823138669;
        Wed, 23 Oct 2019 02:32:18 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id h17sm22678474wme.6.2019.10.23.02.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 02:32:17 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
To:     Jason Gunthorpe <jgg@mellanox.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
References: <2df298e2-ee91-ef40-5da9-2bc1af3a17be@gmail.com>
 <2046e0b4-ba05-0683-5804-e9bbf903658d@amd.com>
 <d6bcbd2a-2519-8945-eaf5-4f4e738c7fa9@amd.com>
 <20191018203608.GA5670@mellanox.com>
 <f7e34d8f-f3b0-b86d-7388-1f791674a4a9@amd.com>
 <20191021135744.GA25164@mellanox.com>
 <e07092c3-8ccd-9814-835c-6c462017aff8@amd.com>
 <20191021151221.GC25164@mellanox.com>
 <20191022075735.GV11828@phenom.ffwll.local>
 <20191022150109.GF22766@mellanox.com>
 <20191023090858.GV11828@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <13edf841-421e-3522-fcec-ef919c2013ef@gmail.com>
Date:   Wed, 23 Oct 2019 11:32:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023090858.GV11828@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 23.10.19 um 11:08 schrieb Daniel Vetter:
> On Tue, Oct 22, 2019 at 03:01:13PM +0000, Jason Gunthorpe wrote:
>> On Tue, Oct 22, 2019 at 09:57:35AM +0200, Daniel Vetter wrote:
>>
>>>> The unusual bit in all of this is using a lock's critical region to
>>>> 'protect' data for read, but updating that same data before the lock's
>>>> critical secion. ie relying on the unlock barrier to 'release' program
>>>> ordered stores done before the lock's own critical region, and the
>>>> lock side barrier to 'acquire' those stores.
>>> I think this unusual use of locks as barriers for other unlocked accesses
>>> deserves comments even more than just normal barriers. Can you pls add
>>> them? I think the design seeems sound ...
>>>
>>> Also the comment on the driver's lock hopefully prevents driver
>>> maintainers from moving the driver_lock around in a way that would very
>>> subtle break the scheme, so I think having the acquire barrier commented
>>> in each place would be really good.
>> There is already a lot of documentation, I think it would be helpful
>> if you could suggest some specific places where you think an addition
>> would help? I think the perspective of someone less familiar with this
>> design would really improve the documentation
> Hm I just meant the usual recommendation that "barriers must have comments
> explaining what they order, and where the other side of the barrier is".
> Using unlock/lock as a barrier imo just makes that an even better idea.
> Usually what I do is something like "we need to order $this against $that
> below, and the other side of this barrier is in function()." With maybe a
> bit more if it's not obvious how things go wrong if the orderin is broken.
>
> Ofc seqlock.h itself skimps on that rule and doesn't bother explaining its
> barriers :-/
>
>> I've been tempted to force the driver to store the seq number directly
>> under the driver lock - this makes the scheme much clearer, ie
>> something like this:
>>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
>> index 712c99918551bc..738fa670dcfb19 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
>> @@ -488,7 +488,8 @@ struct svm_notifier {
>>   };
>>   
>>   static bool nouveau_svm_range_invalidate(struct mmu_range_notifier *mrn,
>> -                                        const struct mmu_notifier_range *range)
>> +                                        const struct mmu_notifier_range *range,
>> +                                        unsigned long seq)
>>   {
>>          struct svm_notifier *sn =
>>                  container_of(mrn, struct svm_notifier, notifier);
>> @@ -504,6 +505,7 @@ static bool nouveau_svm_range_invalidate(struct mmu_range_notifier *mrn,
>>                  mutex_lock(&sn->svmm->mutex);
>>          else if (!mutex_trylock(&sn->svmm->mutex))
>>                  return false;
>> +       mmu_range_notifier_update_seq(mrn, seq);
>>          mutex_unlock(&sn->svmm->mutex);
>>          return true;
>>   }
>>
>>
>> At the cost of making the driver a bit more complex, what do you
>> think?
> Hm, spinning this further ... could we initialize the mmu range notifier
> with a pointer to the driver lock, so that we could put a
> lockdep_assert_held into mmu_range_notifier_update_seq? I think that would
> make this scheme substantially more driver-hacker proof :-)

Going another step further.... what hinders us to put the lock into the 
mmu range notifier itself and have _lock()/_unlock() helpers?

I mean having the lock in the driver only makes sense when the driver 
would be using the same lock for multiple things, e.g. multiple MMU 
range notifiers under the same lock. But I really don't see that use 
case here.

Regards,
Christian.

>
> Cheers, Daniel

