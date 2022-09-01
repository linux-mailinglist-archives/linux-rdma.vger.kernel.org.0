Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6775B5A94F5
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 12:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiIAKpE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 06:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiIAKo7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 06:44:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225191155;
        Thu,  1 Sep 2022 03:44:50 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A7B86601E0A;
        Thu,  1 Sep 2022 11:44:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662029088;
        bh=4/2i4aqnQm0eD8QgJbBg2gvDYzIG/ZG1bPLe6WFo/t0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cLbqiE/dnqUzM66LeoPYWJt2ssxBDaSl7PG8koINMEoIuFiNO/S9FSirvSfstFJ7/
         +3XhwZuh6bULact7FUzNWp72rHVbpmo2vfjnT0bf8Qj3J1aisyK0iDijIGVuyPUkDB
         689ZWSP7OUdwJ6ZIL39SHAz6ocxJBaJqGoDfR10OvPmQYhlYOeoFfhDQEJIIzPL5bM
         BWvpDwgsTAnxEDtdvqtdec6MQmmV7eYnMN7pOGy4F132JMmubuV2LOmiSr77PlVDIj
         IQxQiPZ80EOR+8X3A/Gd+GCivXKpjYEhlMm0HDBHJ+PEbywTNtlYeAJTvojNfYCGzX
         QegYZmzerNARQ==
Message-ID: <213eb3d6-53aa-915e-9565-3209491feeee@collabora.com>
Date:   Thu, 1 Sep 2022 13:44:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 06/21] drm/i915: Prepare to dynamic dma-buf locking
 specification
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org,
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
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
 <20220831153757.97381-7-dmitry.osipenko@collabora.com>
 <2463ccb0-6620-8760-fc06-532847835207@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <2463ccb0-6620-8760-fc06-532847835207@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/1/22 09:45, Christian König wrote:
> Am 31.08.22 um 17:37 schrieb Dmitry Osipenko:
>> Prepare i915 driver to the common dynamic dma-buf locking convention
>> by starting to use the unlocked versions of dma-buf API functions
>> and handling cases where importer now holds the reservation lock.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com>, but it's probably
> best if somebody from the Intel guys take a look as well.

+ Chris Wilson, who touched locks of __i915_gem_free_objects() recently

>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c       |  2 +-
>>   drivers/gpu/drm/i915/gem/i915_gem_object.c       | 12 ++++++++++++
>>   .../gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 16 ++++++++--------
>>   3 files changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
>> b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
>> index f5062d0c6333..07eee1c09aaf 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
>> @@ -72,7 +72,7 @@ static int i915_gem_dmabuf_vmap(struct dma_buf
>> *dma_buf,
>>       struct drm_i915_gem_object *obj = dma_buf_to_obj(dma_buf);
>>       void *vaddr;
>>   -    vaddr = i915_gem_object_pin_map_unlocked(obj, I915_MAP_WB);
>> +    vaddr = i915_gem_object_pin_map(obj, I915_MAP_WB);
>>       if (IS_ERR(vaddr))
>>           return PTR_ERR(vaddr);
>>   diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> index 389e9f157ca5..7e2a9b02526c 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> @@ -331,7 +331,19 @@ static void __i915_gem_free_objects(struct
>> drm_i915_private *i915,
>>               continue;
>>           }
>>   +        /*
>> +         * dma_buf_unmap_attachment() requires reservation to be
>> +         * locked. The imported GEM shouldn't share reservation lock,
>> +         * so it's safe to take the lock.
>> +         */
>> +        if (obj->base.import_attach)
>> +            i915_gem_object_lock(obj, NULL);
>> +
>>           __i915_gem_object_pages_fini(obj);
>> +
>> +        if (obj->base.import_attach)
>> +            i915_gem_object_unlock(obj);
>> +
>>           __i915_gem_free_object(obj);
>>             /* But keep the pointer alive for RCU-protected lookups */
>> diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
>> b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
>> index 62c61af77a42..9e3ed634aa0e 100644
>> --- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
>> +++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
>> @@ -213,7 +213,7 @@ static int igt_dmabuf_import_same_driver(struct
>> drm_i915_private *i915,
>>           goto out_import;
>>       }
>>   -    st = dma_buf_map_attachment(import_attach, DMA_BIDIRECTIONAL);
>> +    st = dma_buf_map_attachment_unlocked(import_attach,
>> DMA_BIDIRECTIONAL);
>>       if (IS_ERR(st)) {
>>           err = PTR_ERR(st);
>>           goto out_detach;
>> @@ -226,7 +226,7 @@ static int igt_dmabuf_import_same_driver(struct
>> drm_i915_private *i915,
>>           timeout = -ETIME;
>>       }
>>       err = timeout > 0 ? 0 : timeout;
>> -    dma_buf_unmap_attachment(import_attach, st, DMA_BIDIRECTIONAL);
>> +    dma_buf_unmap_attachment_unlocked(import_attach, st,
>> DMA_BIDIRECTIONAL);
>>   out_detach:
>>       dma_buf_detach(dmabuf, import_attach);
>>   out_import:
>> @@ -296,7 +296,7 @@ static int igt_dmabuf_import(void *arg)
>>           goto out_obj;
>>       }
>>   -    err = dma_buf_vmap(dmabuf, &map);
>> +    err = dma_buf_vmap_unlocked(dmabuf, &map);
>>       dma_map = err ? NULL : map.vaddr;
>>       if (!dma_map) {
>>           pr_err("dma_buf_vmap failed\n");
>> @@ -337,7 +337,7 @@ static int igt_dmabuf_import(void *arg)
>>         err = 0;
>>   out_dma_map:
>> -    dma_buf_vunmap(dmabuf, &map);
>> +    dma_buf_vunmap_unlocked(dmabuf, &map);
>>   out_obj:
>>       i915_gem_object_put(obj);
>>   out_dmabuf:
>> @@ -358,7 +358,7 @@ static int igt_dmabuf_import_ownership(void *arg)
>>       if (IS_ERR(dmabuf))
>>           return PTR_ERR(dmabuf);
>>   -    err = dma_buf_vmap(dmabuf, &map);
>> +    err = dma_buf_vmap_unlocked(dmabuf, &map);
>>       ptr = err ? NULL : map.vaddr;
>>       if (!ptr) {
>>           pr_err("dma_buf_vmap failed\n");
>> @@ -367,7 +367,7 @@ static int igt_dmabuf_import_ownership(void *arg)
>>       }
>>         memset(ptr, 0xc5, PAGE_SIZE);
>> -    dma_buf_vunmap(dmabuf, &map);
>> +    dma_buf_vunmap_unlocked(dmabuf, &map);
>>         obj = to_intel_bo(i915_gem_prime_import(&i915->drm, dmabuf));
>>       if (IS_ERR(obj)) {
>> @@ -418,7 +418,7 @@ static int igt_dmabuf_export_vmap(void *arg)
>>       }
>>       i915_gem_object_put(obj);
>>   -    err = dma_buf_vmap(dmabuf, &map);
>> +    err = dma_buf_vmap_unlocked(dmabuf, &map);
>>       ptr = err ? NULL : map.vaddr;
>>       if (!ptr) {
>>           pr_err("dma_buf_vmap failed\n");
>> @@ -435,7 +435,7 @@ static int igt_dmabuf_export_vmap(void *arg)
>>       memset(ptr, 0xc5, dmabuf->size);
>>         err = 0;
>> -    dma_buf_vunmap(dmabuf, &map);
>> +    dma_buf_vunmap_unlocked(dmabuf, &map);
>>   out:
>>       dma_buf_put(dmabuf);
>>       return err;
> 


-- 
Best regards,
Dmitry
