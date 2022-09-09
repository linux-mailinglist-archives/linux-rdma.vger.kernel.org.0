Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1036A5B3E08
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiIIRhA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 13:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIIRg6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 13:36:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039B135D7B;
        Fri,  9 Sep 2022 10:36:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A45E6601FC6;
        Fri,  9 Sep 2022 18:36:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662745015;
        bh=8xgN4e43LGiBPVdQ7GyKB5jQBCWxBspXnT50kSaZfdc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E1pvbfsh4mhx8kHsaeEx5+wdORPcsEFHoldFIWWyXseblN1dtO3m2LKuSoqgihlSa
         mvxWcvwfAY63jSB7DnN7yOeJIhOmHYkexHRg9C30PT7fBMeLWfUKCiYOa08B86oCUs
         ccnMOiQ/eemk3IQI6BMX/oXA+OGKrl0rBatDrO8+JSqXCkTd/fI+qJU/40kfFMc89g
         t0gQ9aaRRLRYPyQEByTuKyml5hlPtBl1GC6RbbKtZL44FqTg2qeA3KCDga5aZ0jHda
         scJFjauo2KMswJRJK5d6rTZTggJc5SFIdfQTgNU1j3sp7y+V1qH4Ha2hAFB1s341R4
         qnfx/6JJNgQIg==
Message-ID: <588ff12e-d030-0db0-e248-1afd0dee4ae1@collabora.com>
Date:   Fri, 9 Sep 2022 20:36:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 06/21] drm/i915: Prepare to dynamic dma-buf locking
 specification
Content-Language: en-US
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
 <20220831153757.97381-7-dmitry.osipenko@collabora.com>
 <DM5PR11MB1324088635FDE00B0D957816C17B9@DM5PR11MB1324.namprd11.prod.outlook.com>
 <760b999f-b15d-102e-8bc7-c3e69f07f43f@gmail.com>
 <c89680d0-30ee-f5d7-be68-fa84458df04d@gmail.com>
 <DM5PR11MB1324EDC7A97DE98C2DC6EDA8C17A9@DM5PR11MB1324.namprd11.prod.outlook.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <DM5PR11MB1324EDC7A97DE98C2DC6EDA8C17A9@DM5PR11MB1324.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/2/22 19:26, Ruhl, Michael J wrote:
>> 02.09.2022 13:31, Dmitry Osipenko пишет:
>>> 01.09.2022 17:02, Ruhl, Michael J пишет:
>>> ...
>>>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>>>> @@ -331,7 +331,19 @@ static void __i915_gem_free_objects(struct
>>>>> drm_i915_private *i915,
>>>>> 			continue;
>>>>> 		}
>>>>>
>>>>> +		/*
>>>>> +		 * dma_buf_unmap_attachment() requires reservation to be
>>>>> +		 * locked. The imported GEM shouldn't share reservation lock,
>>>>> +		 * so it's safe to take the lock.
>>>>> +		 */
>>>>> +		if (obj->base.import_attach)
>>>>> +			i915_gem_object_lock(obj, NULL);
>>>>
>>>> There is a lot of stuff going here.  Taking the lock may be premature...
>>>>
>>>>> 		__i915_gem_object_pages_fini(obj);
>>>>
>>>> The i915_gem_dmabuf.c:i915_gem_object_put_pages_dmabuf is where
>>>> unmap_attachment is actually called, would it make more sense to make
>>>> do the locking there?
>>>
>>> The __i915_gem_object_put_pages() is invoked with a held reservation
>>> lock, while freeing object is a special time when we know that GEM is
>>> unused.
>>>
>>> The __i915_gem_free_objects() was taking the lock two weeks ago until
>>> the change made Chris Wilson [1] reached linux-next.
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-
>> next.git/commit/?id=2826d447fbd60e6a05e53d5f918bceb8c04e315c
>>>
>>> I don't think we can take the lock within
>>> i915_gem_object_put_pages_dmabuf(), it may/should deadlock other code
>> paths.
>>
>> On the other hand, we can check whether the GEM's refcount number is
>> zero in i915_gem_object_put_pages_dmabuf() and then take the lock if
>> it's zero.
>>
>> Also, seems it should be possible just to bail out from
>> i915_gem_object_put_pages_dmabuf() if refcount=0. The further
>> drm_prime_gem_destroy() will take care of unmapping. Perhaps this could
>> be the best option, I'll give it a test.
> 
> i915_gem_object_put_pages() is uses the SG, and the usage for
> drm_prim_gem_destroy()
> 
> from __i915_gem_free_objects() doesn't use the SG because it has been "freed"
> already, I am not sure if that would work...
> 
> Hmm.. with that in mind, maybe moving the base.import_attach check to 
> __i915_gem_object_put_pages with your attach check?

I see you meant __i915_gem_object_pages_fini() here.

> 	atomic_set(&obj->mm.pages_pin_count, 0);
> 	if (obj->base.import)
> 		i915_gem_object_lock(obj, NULL);
> 
> 	__i915_gem_object_put_pages(obj);
> 
> 	if (obj->base.import)
> 		i915_gem_object_unlock(obj, NULL);
> 	GEM_BUG_ON(i915_gem_object_has_pages(obj));
> 
> Pretty much one step up from the dmabuf interface, but we are guaranteed to
> not have any pinned pages?

Importer shouldn't hold pages outside of dma-buf API, otherwise it
should be a bug.

> The other caller of __i915_gem_object_pages_fini is the i915_ttm move_notify
> which should not conflict (export side, not import side).
> 
> Since it appears that not locking during the clean up is desirable, trying to make sure take the lock
> is taken at the last moment might be the right path?

Reducing the scope of locking usually is preferred more. Yours
suggestion works okay, I couldn't spot any problems at least for a
non-TTM code paths.

It's indeed a bit not nice that __i915_gem_object_pages_fini() is used
by TTM, but should be safe for imported objects. Will be great if anyone
from i915 maintainers could ack this variant.

-- 
Best regards,
Dmitry
