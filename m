Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF1257B63E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiGTMSs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiGTMSq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 08:18:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA262C108;
        Wed, 20 Jul 2022 05:18:45 -0700 (PDT)
Received: from [192.168.2.145] (unknown [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 81CE666015BE;
        Wed, 20 Jul 2022 13:18:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658319523;
        bh=B4ji8JwW8eJ3XP1EGK6JbA9JDbvoYbqvHvRf2nsb7zM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MVHTQFYSrRMdyliP4QT0X5TFtmh9JA+mHFJhAYOmZzsKwZwQzRnJK87cEcwpnFUZL
         arJbnBaTGOQX2kUp2P8Ds7zfCZI6wmWngKny0rJieNPqAqpzGaEqCxk12yhpR9bWZ3
         8o5aU0IRsGM53Utp7m+HQQ/mpoTgDM/dxR2xvu4IKhpYf00S9yfaCe6giBFGwuwUpT
         s/4/8aBfsMBpZ0suxVilFqlaueL5Lc3v2jWW47REkJ3EOO9mFKe033EiupjZaH2QvJ
         dKC8LfBq+innrk6YwjrjXyl3SZy47EYje/qG+yyAu8lC6YaalCpVJ+SnqsNOsPKo8P
         7PYwHi0AyYdZw==
Message-ID: <ab6252bb-50d4-1fd6-589e-1c956f058a5b@collabora.com>
Date:   Wed, 20 Jul 2022 15:18:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 4/6] dma-buf: Acquire wait-wound context on attachment
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220715005244.42198-1-dmitry.osipenko@collabora.com>
 <20220715005244.42198-5-dmitry.osipenko@collabora.com>
 <5ec9313e-8498-2838-0320-331c347ce905@amd.com>
 <1ce233a2-36c9-3698-59f0-c4ff902bec60@collabora.com>
 <43446124-b99a-32d8-f797-7ec0cdca9ee4@collabora.com>
 <163d3271-e1e9-c325-185d-adb4391023e1@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <163d3271-e1e9-c325-185d-adb4391023e1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/20/22 11:29, Christian König wrote:
> Am 19.07.22 um 22:05 schrieb Dmitry Osipenko:
>> On 7/15/22 09:59, Dmitry Osipenko wrote:
>>> On 7/15/22 09:50, Christian König wrote:
>>>> Am 15.07.22 um 02:52 schrieb Dmitry Osipenko:
>>>>> Intel i915 GPU driver uses wait-wound mutex to lock multiple GEMs
>>>>> on the
>>>>> attachment to the i915 dma-buf. In order to let all drivers utilize
>>>>> shared
>>>>> wait-wound context during attachment in a general way, make dma-buf
>>>>> core to
>>>>> acquire the ww context internally for the attachment operation and
>>>>> update
>>>>> i915 driver to use the importer's ww context instead of the
>>>>> internal one.
>>>>>
>>>>>   From now on all dma-buf exporters shall use the importer's ww
>>>>> context
>>>>> for
>>>>> the attachment operation.
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>> ---
>>>>>    drivers/dma-buf/dma-buf.c                     |  8 +++++-
>>>>>    drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |  2 +-
>>>>>    .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |  2 +-
>>>>>    drivers/gpu/drm/i915/gem/i915_gem_object.h    |  6 ++---
>>>>>    drivers/gpu/drm/i915/i915_gem_evict.c         |  2 +-
>>>>>    drivers/gpu/drm/i915/i915_gem_ww.c            | 26
>>>>> +++++++++++++++----
>>>>>    drivers/gpu/drm/i915/i915_gem_ww.h            | 15 +++++++++--
>>>>>    7 files changed, 47 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>>>> index 0ee588276534..37545ecb845a 100644
>>>>> --- a/drivers/dma-buf/dma-buf.c
>>>>> +++ b/drivers/dma-buf/dma-buf.c
>>>>> @@ -807,6 +807,8 @@ static struct sg_table * __map_dma_buf(struct
>>>>> dma_buf_attachment *attach,
>>>>>     * Optionally this calls &dma_buf_ops.attach to allow
>>>>> device-specific attach
>>>>>     * functionality.
>>>>>     *
>>>>> + * Exporters shall use ww_ctx acquired by this function.
>>>>> + *
>>>>>     * Returns:
>>>>>     *
>>>>>     * A pointer to newly created &dma_buf_attachment on success, or a
>>>>> negative
>>>>> @@ -822,6 +824,7 @@ dma_buf_dynamic_attach_unlocked(struct dma_buf
>>>>> *dmabuf, struct device *dev,
>>>>>                    void *importer_priv)
>>>>>    {
>>>>>        struct dma_buf_attachment *attach;
>>>>> +    struct ww_acquire_ctx ww_ctx;
>>>>>        int ret;
>>>>>          if (WARN_ON(!dmabuf || !dev))
>>>>> @@ -841,7 +844,8 @@ dma_buf_dynamic_attach_unlocked(struct dma_buf
>>>>> *dmabuf, struct device *dev,
>>>>>        attach->importer_ops = importer_ops;
>>>>>        attach->importer_priv = importer_priv;
>>>>>    -    dma_resv_lock(dmabuf->resv, NULL);
>>>>> +    ww_acquire_init(&ww_ctx, &reservation_ww_class);
>>>>> +    dma_resv_lock(dmabuf->resv, &ww_ctx);
>>>> That won't work like this. The core property of a WW context is that
>>>> you
>>>> need to unwind all the locks and re-quire them with the contended one
>>>> first.
>>>>
>>>> When you statically lock the imported one here you can't do that any
>>>> more.
>>> You're right. I felt that something is missing here, but couldn't
>>> notice. I'll think more about this and enable
>>> CONFIG_DEBUG_WW_MUTEX_SLOWPATH. Thank you!
>>>
>> Christian, do you think we could make an excuse for the attach()
>> callback and make the exporter responsible for taking the resv lock? It
>> will be inconsistent with the rest of the callbacks, where importer
>> takes the lock, but it will be the simplest and least invasive solution.
>> It's very messy to do a cross-driver ww locking, I don't think it's the
>> right approach.
> 
> So to summarize the following calls will require that the caller hold
> the resv lock:
> 1. dma_buf_pin()/dma_buf_unpin()
> 2. dma_buf_map_attachment()/dma_buf_unmap_attachment()
> 3. dma_buf_vmap()/dma_buf_vunmap()
> 4. dma_buf_move_notify()
> 
> The following calls require that caller does not held the resv lock:
> 1. dma_buf_attach()/dma_buf_dynamic_attach()/dma_buf_detach()
> 2. dma_buf_export()/dma_buf_fd()
> 3. dma_buf_get()/dma_buf_put()
> 4. dma_buf_begin_cpu_access()/dma_buf_end_cpu_access()
> 
> If that's correct than that would work for me as well, but we should
> probably document this.

Looks good, thank you. I'll try this variant.

> Or let me ask the other way around: What calls exactly do you need to
> change to solve your original issue? That was vmap/vunmap, wasn't it? If
> yes then let's concentrate on those for the moment.

Originally, Daniel Vetter asked to sort out the dma-buf lockings across
all drivers, so we could replace custom locks in DRM-SHMEM with the resv
lock, otherwise there were no guarantees that we won't have deadlocks in
the dma-buf code paths.

The vmap/vunmap is one of the paths that needs to be sorted out, there
is no particular issue with it, just need to specify the convention. The
mmaping was the other questionable path and we concluded that it's
better to prohibit dma-buf mappings for DRM entirely. Lastly, there is
i915 attach() that uses the ww locking.

-- 
Best regards,
Dmitry
