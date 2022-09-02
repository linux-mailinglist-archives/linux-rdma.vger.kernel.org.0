Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E75AACA1
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Sep 2022 12:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiIBKig (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Sep 2022 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiIBKif (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Sep 2022 06:38:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5410BD08E;
        Fri,  2 Sep 2022 03:38:34 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b19so1800080ljf.8;
        Fri, 02 Sep 2022 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zb5JB4hN023tPDYi3X8LwwwxfrMO5eJ6HDfLqyKNUp4=;
        b=b+3QDVeZ8R7VkX5Bf/lQ/zM5cKpssDiy6sioxY3jw9J59uDY2aLPinjOd5/AfzMPSF
         F25cqjiDBi0zlLf8NewvQzjGLBKLLwe77dGjcGOssNv9QG7GD4v9Y7R5vUVBkwhzJqAt
         W+NgPvhc+LGHFoczAHcg6Xd3RZE5aY0kB0c6sHOthdo2C6I6KgqGlMNMjWhr5LBa7hEJ
         PF8PoWJrMQEbxEgzwwdfZOe63pnK6yiDDUckqcBXrJcCgoCnkkMNTICwsyuKzCch5zAF
         oZnume/cpTmEe8YMT0zAnJRdyZ8FX7N+NEVx+V/5rqxYqoL28d0bRVzC4c7nr4HeYJuG
         nuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zb5JB4hN023tPDYi3X8LwwwxfrMO5eJ6HDfLqyKNUp4=;
        b=OGNnZ0tVAQj3uSE5zdnk6UhqMQybX46sjIc6EGPZr8IToZkewv+PbDVQaGkjoWePiV
         nCiZ4Nlen8ND762kWoGARZUU6LtXn6IsoHfGOe4KTJGApUYcWpJ761wAzjCe9YLqWVEr
         WI9BihvLuZPsHD0z1SREwEBrg0wPPhk2o/QjNWFsv3+SullpPwZC/rOb2yEq48Zj32cj
         INpwM80RCUut8ruLLEz6mSxucvSzLzOsf0v7YMf5sus3n5Vv5syR4jh+mPp2gof8KDpd
         iOwtTrd6wqISvHogqNdMGX1kkFM3JTmP54tnNOqV8zdHFtbieqxOojQigwggh5e4cWzr
         7RQg==
X-Gm-Message-State: ACgBeo08SLKmT8bDY2ynmoV+1T1NmnTPcsfeqQgR/OtcEqWb/NdxfEB9
        3rnTtXMoS12aj0ogOuYBMiM=
X-Google-Smtp-Source: AA6agR40LFWSHSrrETgLqAmkw4fHaA4WAaccG4Nn66YZ/3AUuSYYBeJUuN4jK3ma7gFMPZa8TWb1KQ==
X-Received: by 2002:a2e:bf07:0:b0:261:cafb:d4a8 with SMTP id c7-20020a2ebf07000000b00261cafbd4a8mr10289818ljr.268.1662115113077;
        Fri, 02 Sep 2022 03:38:33 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru. [109.252.119.13])
        by smtp.googlemail.com with ESMTPSA id 5-20020a2eb945000000b00267232d0652sm147092ljs.46.2022.09.02.03.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 03:38:32 -0700 (PDT)
Message-ID: <c89680d0-30ee-f5d7-be68-fa84458df04d@gmail.com>
Date:   Fri, 2 Sep 2022 13:38:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 06/21] drm/i915: Prepare to dynamic dma-buf locking
 specification
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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
In-Reply-To: <760b999f-b15d-102e-8bc7-c3e69f07f43f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

02.09.2022 13:31, Dmitry Osipenko пишет:
> 01.09.2022 17:02, Ruhl, Michael J пишет:
> ...
>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>>> @@ -331,7 +331,19 @@ static void __i915_gem_free_objects(struct
>>> drm_i915_private *i915,
>>> 			continue;
>>> 		}
>>>
>>> +		/*
>>> +		 * dma_buf_unmap_attachment() requires reservation to be
>>> +		 * locked. The imported GEM shouldn't share reservation lock,
>>> +		 * so it's safe to take the lock.
>>> +		 */
>>> +		if (obj->base.import_attach)
>>> +			i915_gem_object_lock(obj, NULL);
>>
>> There is a lot of stuff going here.  Taking the lock may be premature...
>>
>>> 		__i915_gem_object_pages_fini(obj);
>>
>> The i915_gem_dmabuf.c:i915_gem_object_put_pages_dmabuf is where
>> unmap_attachment is actually called, would it make more sense to make
>> do the locking there?
> 
> The __i915_gem_object_put_pages() is invoked with a held reservation
> lock, while freeing object is a special time when we know that GEM is
> unused.
> 
> The __i915_gem_free_objects() was taking the lock two weeks ago until
> the change made Chris Wilson [1] reached linux-next.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2826d447fbd60e6a05e53d5f918bceb8c04e315c
> 
> I don't think we can take the lock within
> i915_gem_object_put_pages_dmabuf(), it may/should deadlock other code paths.

On the other hand, we can check whether the GEM's refcount number is
zero in i915_gem_object_put_pages_dmabuf() and then take the lock if
it's zero.

Also, seems it should be possible just to bail out from
i915_gem_object_put_pages_dmabuf() if refcount=0. The further
drm_prime_gem_destroy() will take care of unmapping. Perhaps this could
be the best option, I'll give it a test.
