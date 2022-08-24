Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB05459FE3A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiHXPZR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiHXPY5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 11:24:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6154F80507;
        Wed, 24 Aug 2022 08:24:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so5226406ejy.5;
        Wed, 24 Aug 2022 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9U4CYfoKFbj/AbZbuQemN6t37DkLSjqF7Rv/8Cv5uYU=;
        b=STBN0JJgkuT3Ub+zYNS6zXzJzUof3fSvR5hRMgMDAP9LbKzaTA+MK+TD1Iu+aZIyF+
         dPLXPApvrqDjAwDRySZ2fJKiO9PGndETwtfPLVzBT5LerqrNC/Be6i+lMALU0K108vbd
         VMJmSTgAFNY/28eY9lJfUXAaUTenkpB1N206PZf+6DmSTDGPlaoOf4b0iz9mIoQfeZQh
         GYv2v+ZA5XTaibilAf2aJJKPDFaNmL+I5g6VwE005y++27gyMKOa36tO264DTvYaPjQ4
         /8S4W7w+D1jYkRNzi+JbYmqm5H7HHOBLVJ5oz4nyJsRPIaXxO+rsnrd4YpgVCqZX3bUO
         Hfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9U4CYfoKFbj/AbZbuQemN6t37DkLSjqF7Rv/8Cv5uYU=;
        b=FUnoE17EjeyR0cbsgOAdstgqRS9kXiNI7QGhnsQzJfKH9YLI+Nt28lnZ0Z8DiX9UoW
         9Vm1OlYn2L6KxKv0c+SRlurRBHOZh0zttQSGHgpmbLb/2qyXF/cXL5lTf92op+4utp3e
         37uG0VwOGWjYA4cLPMhIBxvosYTov+3KnpQWUt1swZcyHU3u8IMbB2UCus/r8etJR/Re
         XvFy4hm8Z2JgXiAgv8L1doEOKewTXwYH06+jBa4Hp0vtWYyD0AiBm+Ay2GoC7aaxam0v
         VEcI278hXmiWnnEUiUkEyDwhc6HwU6CjUjI3kttFxgtWuASfyikR+CaIEoG7EGN1YkNl
         b3Rg==
X-Gm-Message-State: ACgBeo0ReFaHMUudUjXtwA0UMMaKS9MffA0PD3BA4I2z0jfqggABDwfW
        PIfrPehDzeitQisAp+mtKBw=
X-Google-Smtp-Source: AA6agR6JZHUpcJdflHSbU0zmzoCMtOWs6CQCJkWREoFWqr/qdr1+zI9s3gboxNWeA+opNqBc+NbqAA==
X-Received: by 2002:a17:907:2816:b0:73d:7884:a399 with SMTP id eb22-20020a170907281600b0073d7884a399mr3187172ejc.125.1661354692356;
        Wed, 24 Aug 2022 08:24:52 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:53f0:102e:8337:712f? ([2a02:908:1256:79a0:53f0:102e:8337:712f])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b0073d05a03347sm1272698ejx.89.2022.08.24.08.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 08:24:51 -0700 (PDT)
Message-ID: <055c3c05-ac4c-430e-f2b9-08f000acf435@gmail.com>
Date:   Wed, 24 Aug 2022 17:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Linaro-mm-sig] [PATCH v3 6/9] dma-buf: Move dma-buf attachment
 to dynamic locking specification
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        Qiang Yu <yuq825@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lima@lists.freedesktop.org
References: <20220824102248.91964-1-dmitry.osipenko@collabora.com>
 <20220824102248.91964-7-dmitry.osipenko@collabora.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220824102248.91964-7-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 24.08.22 um 12:22 schrieb Dmitry Osipenko:
> Move dma-buf attachment API functions to the dynamic locking specification.
> The strict locking convention prevents deadlock situations for dma-buf
> importers and exporters.
>
> Previously, the "unlocked" versions of the attachment API functions
> weren't taking the reservation lock and this patch makes them to take
> the lock.
>
> Intel and AMD GPU drivers already were mapping the attached dma-bufs under
> the held lock during attachment, hence these drivers are updated to use
> the locked functions.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   drivers/dma-buf/dma-buf.c                  | 115 ++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |   4 +-
>   drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c |   8 +-
>   drivers/gpu/drm/i915/gem/i915_gem_object.c |  12 +++
>   include/linux/dma-buf.h                    |  20 ++--
>   5 files changed, 110 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 4556a12bd741..f2a5a122da4a 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -559,7 +559,7 @@ static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
>    * 2. Userspace passes this file-descriptors to all drivers it wants this buffer
>    *    to share with: First the file descriptor is converted to a &dma_buf using
>    *    dma_buf_get(). Then the buffer is attached to the device using
> - *    dma_buf_attach().
> + *    dma_buf_attach_unlocked().

Now I get why this is confusing me so much.

The _unlocked postfix implies that there is another function which 
should be called with the locks already held, but this is not the case 
for attach/detach (because they always need to grab the lock themselves).

So I suggest to drop the _unlocked postfix for the attach/detach 
functions. Another step would then be to unify attach/detach with 
dynamic_attach/dynamic_detach when both have the same locking convention 
anyway.

Sorry that this is going so much back and forth, it's really complicated 
to keep all the stuff in my head at the moment :)

Thanks a lot for looking into this,
Christian.

>    *
>    *    Up to this stage the exporter is still free to migrate or reallocate the
>    *    backing storage.
> @@ -569,8 +569,8 @@ static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
>    *    dma_buf_map_attachment() and dma_buf_unmap_attachment().
>    *
>    * 4. Once a driver is done with a shared buffer it needs to call
> - *    dma_buf_detach() (after cleaning up any mappings) and then release the
> - *    reference acquired with dma_buf_get() by calling dma_buf_put().
> + *    dma_buf_detach_unlocked() (after cleaning up any mappings) and then
> + *    release the reference acquired with dma_buf_get() by calling dma_buf_put().
>    *
>    * For the detailed semantics exporters are expected to implement see
>    * &dma_buf_ops.
> @@ -802,7 +802,7 @@ static struct sg_table * __map_dma_buf(struct dma_buf_attachment *attach,
>    * @importer_priv:	[in]	importer private pointer for the attachment
>    *
>    * Returns struct dma_buf_attachment pointer for this attachment. Attachments
> - * must be cleaned up by calling dma_buf_detach().
> + * must be cleaned up by calling dma_buf_detach_unlocked().
>    *
>    * Optionally this calls &dma_buf_ops.attach to allow device-specific attach
>    * functionality.
> @@ -858,8 +858,8 @@ dma_buf_dynamic_attach_unlocked(struct dma_buf *dmabuf, struct device *dev,
>   	    dma_buf_is_dynamic(dmabuf)) {
>   		struct sg_table *sgt;
>   
> +		dma_resv_lock(attach->dmabuf->resv, NULL);
>   		if (dma_buf_is_dynamic(attach->dmabuf)) {
> -			dma_resv_lock(attach->dmabuf->resv, NULL);
>   			ret = dmabuf->ops->pin(attach);
>   			if (ret)
>   				goto err_unlock;
> @@ -872,8 +872,7 @@ dma_buf_dynamic_attach_unlocked(struct dma_buf *dmabuf, struct device *dev,
>   			ret = PTR_ERR(sgt);
>   			goto err_unpin;
>   		}
> -		if (dma_buf_is_dynamic(attach->dmabuf))
> -			dma_resv_unlock(attach->dmabuf->resv);
> +		dma_resv_unlock(attach->dmabuf->resv);
>   		attach->sgt = sgt;
>   		attach->dir = DMA_BIDIRECTIONAL;
>   	}
> @@ -889,8 +888,7 @@ dma_buf_dynamic_attach_unlocked(struct dma_buf *dmabuf, struct device *dev,
>   		dmabuf->ops->unpin(attach);
>   
>   err_unlock:
> -	if (dma_buf_is_dynamic(attach->dmabuf))
> -		dma_resv_unlock(attach->dmabuf->resv);
> +	dma_resv_unlock(attach->dmabuf->resv);
>   
>   	dma_buf_detach_unlocked(dmabuf, attach);
>   	return ERR_PTR(ret);
> @@ -927,7 +925,7 @@ static void __unmap_dma_buf(struct dma_buf_attachment *attach,
>    * @dmabuf:	[in]	buffer to detach from.
>    * @attach:	[in]	attachment to be detached; is free'd after this call.
>    *
> - * Clean up a device attachment obtained by calling dma_buf_attach().
> + * Clean up a device attachment obtained by calling dma_buf_attach_unlocked().
>    *
>    * Optionally this calls &dma_buf_ops.detach for device-specific detach.
>    */
> @@ -937,21 +935,19 @@ void dma_buf_detach_unlocked(struct dma_buf *dmabuf,
>   	if (WARN_ON(!dmabuf || !attach))
>   		return;
>   
> +	dma_resv_lock(attach->dmabuf->resv, NULL);
> +
>   	if (attach->sgt) {
> -		if (dma_buf_is_dynamic(attach->dmabuf))
> -			dma_resv_lock(attach->dmabuf->resv, NULL);
>   
>   		__unmap_dma_buf(attach, attach->sgt, attach->dir);
>   
> -		if (dma_buf_is_dynamic(attach->dmabuf)) {
> +		if (dma_buf_is_dynamic(attach->dmabuf))
>   			dmabuf->ops->unpin(attach);
> -			dma_resv_unlock(attach->dmabuf->resv);
> -		}
>   	}
> -
> -	dma_resv_lock(dmabuf->resv, NULL);
>   	list_del(&attach->node);
> +
>   	dma_resv_unlock(dmabuf->resv);
> +
>   	if (dmabuf->ops->detach)
>   		dmabuf->ops->detach(dmabuf, attach);
>   
> @@ -1011,7 +1007,7 @@ void dma_buf_unpin(struct dma_buf_attachment *attach)
>   EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, DMA_BUF);
>   
>   /**
> - * dma_buf_map_attachment_unlocked - Returns the scatterlist table of the attachment;
> + * dma_buf_map_attachment - Returns the scatterlist table of the attachment;
>    * mapped into _device_ address space. Is a wrapper for map_dma_buf() of the
>    * dma_buf_ops.
>    * @attach:	[in]	attachment whose scatterlist is to be returned
> @@ -1030,10 +1026,11 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, DMA_BUF);
>    *
>    * Important: Dynamic importers must wait for the exclusive fence of the struct
>    * dma_resv attached to the DMA-BUF first.
> + *
> + * Importer is responsible for holding dmabuf's reservation lock.
>    */
> -struct sg_table *
> -dma_buf_map_attachment_unlocked(struct dma_buf_attachment *attach,
> -				enum dma_data_direction direction)
> +struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
> +					enum dma_data_direction direction)
>   {
>   	struct sg_table *sg_table;
>   	int r;
> @@ -1043,8 +1040,7 @@ dma_buf_map_attachment_unlocked(struct dma_buf_attachment *attach,
>   	if (WARN_ON(!attach || !attach->dmabuf))
>   		return ERR_PTR(-EINVAL);
>   
> -	if (dma_buf_attachment_is_dynamic(attach))
> -		dma_resv_assert_held(attach->dmabuf->resv);
> +	dma_resv_assert_held(attach->dmabuf->resv);
>   
>   	if (attach->sgt) {
>   		/*
> @@ -1059,7 +1055,6 @@ dma_buf_map_attachment_unlocked(struct dma_buf_attachment *attach,
>   	}
>   
>   	if (dma_buf_is_dynamic(attach->dmabuf)) {
> -		dma_resv_assert_held(attach->dmabuf->resv);
>   		if (!IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY)) {
>   			r = attach->dmabuf->ops->pin(attach);
>   			if (r)
> @@ -1099,10 +1094,38 @@ dma_buf_map_attachment_unlocked(struct dma_buf_attachment *attach,
>   #endif /* CONFIG_DMA_API_DEBUG */
>   	return sg_table;
>   }
> +EXPORT_SYMBOL_NS_GPL(dma_buf_map_attachment, DMA_BUF);
> +
> +/**
> + * dma_buf_map_attachment_unlocked - Returns the scatterlist table of the attachment;
> + * mapped into _device_ address space. Is a wrapper for map_dma_buf() of the
> + * dma_buf_ops.
> + * @attach:	[in]	attachment whose scatterlist is to be returned
> + * @direction:	[in]	direction of DMA transfer
> + *
> + * Unlocked variant of dma_buf_map_attachment().
> + */
> +struct sg_table *
> +dma_buf_map_attachment_unlocked(struct dma_buf_attachment *attach,
> +				enum dma_data_direction direction)
> +{
> +	struct sg_table *sg_table;
> +
> +	might_sleep();
> +
> +	if (WARN_ON(!attach || !attach->dmabuf))
> +		return ERR_PTR(-EINVAL);
> +
> +	dma_resv_lock(attach->dmabuf->resv, NULL);
> +	sg_table = dma_buf_map_attachment(attach, direction);
> +	dma_resv_unlock(attach->dmabuf->resv);
> +
> +	return sg_table;
> +}
>   EXPORT_SYMBOL_NS_GPL(dma_buf_map_attachment_unlocked, DMA_BUF);
>   
>   /**
> - * dma_buf_unmap_attachment_unlocked - unmaps and decreases usecount of the buffer;might
> + * dma_buf_unmap_attachment - unmaps and decreases usecount of the buffer;might
>    * deallocate the scatterlist associated. Is a wrapper for unmap_dma_buf() of
>    * dma_buf_ops.
>    * @attach:	[in]	attachment to unmap buffer from
> @@ -1110,31 +1133,51 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_map_attachment_unlocked, DMA_BUF);
>    * @direction:  [in]    direction of DMA transfer
>    *
>    * This unmaps a DMA mapping for @attached obtained by dma_buf_map_attachment().
> + *
> + * Importer is responsible for holding dmabuf's reservation lock.
>    */
> -void dma_buf_unmap_attachment_unlocked(struct dma_buf_attachment *attach,
> -				       struct sg_table *sg_table,
> -				       enum dma_data_direction direction)
> +void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
> +			      struct sg_table *sg_table,
> +			      enum dma_data_direction direction)
>   {
>   	might_sleep();
>   
> -	if (WARN_ON(!attach || !attach->dmabuf || !sg_table))
> -		return;
> -
> -	if (dma_buf_attachment_is_dynamic(attach))
> -		dma_resv_assert_held(attach->dmabuf->resv);
> +	dma_resv_assert_held(attach->dmabuf->resv);
>   
>   	if (attach->sgt == sg_table)
>   		return;
>   
> -	if (dma_buf_is_dynamic(attach->dmabuf))
> -		dma_resv_assert_held(attach->dmabuf->resv);
> -
>   	__unmap_dma_buf(attach, sg_table, direction);
>   
>   	if (dma_buf_is_dynamic(attach->dmabuf) &&
>   	    !IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY))
>   		dma_buf_unpin(attach);
>   }
> +EXPORT_SYMBOL_NS_GPL(dma_buf_unmap_attachment, DMA_BUF);
> +
> +/**
> + * dma_buf_unmap_attachment_unlocked - unmaps and decreases usecount of the buffer;might
> + * deallocate the scatterlist associated. Is a wrapper for unmap_dma_buf() of
> + * dma_buf_ops.
> + * @attach:	[in]	attachment to unmap buffer from
> + * @sg_table:	[in]	scatterlist info of the buffer to unmap
> + * @direction:	[in]	direction of DMA transfer
> + *
> + * Unlocked variant of dma_buf_unmap_attachment().
> + */
> +void dma_buf_unmap_attachment_unlocked(struct dma_buf_attachment *attach,
> +				       struct sg_table *sg_table,
> +				       enum dma_data_direction direction)
> +{
> +	might_sleep();
> +
> +	if (WARN_ON(!attach || !attach->dmabuf || !sg_table))
> +		return;
> +
> +	dma_resv_lock(attach->dmabuf->resv, NULL);
> +	dma_buf_unmap_attachment(attach, sg_table, direction);
> +	dma_resv_unlock(attach->dmabuf->resv);
> +}
>   EXPORT_SYMBOL_NS_GPL(dma_buf_unmap_attachment_unlocked, DMA_BUF);
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index ac1e2911b727..b1c455329023 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -885,7 +885,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>   			struct sg_table *sgt;
>   
>   			attach = gtt->gobj->import_attach;
> -			sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
> +			sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
>   			if (IS_ERR(sgt))
>   				return PTR_ERR(sgt);
>   
> @@ -1010,7 +1010,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
>   		struct dma_buf_attachment *attach;
>   
>   		attach = gtt->gobj->import_attach;
> -		dma_buf_unmap_attachment_unlocked(attach, ttm->sg, DMA_BIDIRECTIONAL);
> +		dma_buf_unmap_attachment(attach, ttm->sg, DMA_BIDIRECTIONAL);
>   		ttm->sg = NULL;
>   	}
>   
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> index cc54a5b1d6ae..276a74bc7fd1 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> @@ -241,8 +241,8 @@ static int i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
>   
>   	assert_object_held(obj);
>   
> -	pages = dma_buf_map_attachment_unlocked(obj->base.import_attach,
> -						DMA_BIDIRECTIONAL);
> +	pages = dma_buf_map_attachment(obj->base.import_attach,
> +				       DMA_BIDIRECTIONAL);
>   	if (IS_ERR(pages))
>   		return PTR_ERR(pages);
>   
> @@ -270,8 +270,8 @@ static int i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
>   static void i915_gem_object_put_pages_dmabuf(struct drm_i915_gem_object *obj,
>   					     struct sg_table *pages)
>   {
> -	dma_buf_unmap_attachment_unlocked(obj->base.import_attach, pages,
> -					  DMA_BIDIRECTIONAL);
> +	dma_buf_unmap_attachment(obj->base.import_attach, pages,
> +				 DMA_BIDIRECTIONAL);
>   }
>   
>   static const struct drm_i915_gem_object_ops i915_gem_object_dmabuf_ops = {
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> index 389e9f157ca5..9fbef3aea7b1 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> @@ -331,7 +331,19 @@ static void __i915_gem_free_objects(struct drm_i915_private *i915,
>   			continue;
>   		}
>   
> +		/*
> +		 * dma_buf_unmap_attachment() requires reservation to be
> +		 * locked. The imported GEM should share reservation lock,
> +		 * so it's safe to take the lock.
> +		 */
> +		if (obj->base.import_attach)
> +			i915_gem_object_lock(obj, NULL);
> +
>   		__i915_gem_object_pages_fini(obj);
> +
> +		if (obj->base.import_attach)
> +			i915_gem_object_unlock(obj);
> +
>   		__i915_gem_free_object(obj);
>   
>   		/* But keep the pointer alive for RCU-protected lookups */
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index da2057569101..d48d534dc55c 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -46,7 +46,7 @@ struct dma_buf_ops {
>   	/**
>   	 * @attach:
>   	 *
> -	 * This is called from dma_buf_attach() to make sure that a given
> +	 * This is called from dma_buf_attach_unlocked() to make sure that a given
>   	 * &dma_buf_attachment.dev can access the provided &dma_buf. Exporters
>   	 * which support buffer objects in special locations like VRAM or
>   	 * device-specific carveout areas should check whether the buffer could
> @@ -74,7 +74,7 @@ struct dma_buf_ops {
>   	/**
>   	 * @detach:
>   	 *
> -	 * This is called by dma_buf_detach() to release a &dma_buf_attachment.
> +	 * This is called by dma_buf_detach_unlocked() to release a &dma_buf_attachment.
>   	 * Provided so that exporters can clean up any housekeeping for an
>   	 * &dma_buf_attachment.
>   	 *
> @@ -94,7 +94,7 @@ struct dma_buf_ops {
>   	 * exclusive with @cache_sgt_mapping.
>   	 *
>   	 * This is called automatically for non-dynamic importers from
> -	 * dma_buf_attach().
> +	 * dma_buf_attach_unlocked().
>   	 *
>   	 * Note that similar to non-dynamic exporters in their @map_dma_buf
>   	 * callback the driver must guarantee that the memory is available for
> @@ -509,10 +509,10 @@ struct dma_buf_attach_ops {
>    * and its user device(s). The list contains one attachment struct per device
>    * attached to the buffer.
>    *
> - * An attachment is created by calling dma_buf_attach(), and released again by
> - * calling dma_buf_detach(). The DMA mapping itself needed to initiate a
> - * transfer is created by dma_buf_map_attachment() and freed again by calling
> - * dma_buf_unmap_attachment().
> + * An attachment is created by calling dma_buf_attach_unlocked(), and released
> + * again by calling dma_buf_detach_unlocked(). The DMA mapping itself needed to
> + * initiate a transfer is created by dma_buf_map_attachment() and freed
> + * again by calling dma_buf_unmap_attachment().
>    */
>   struct dma_buf_attachment {
>   	struct dma_buf *dmabuf;
> @@ -626,6 +626,12 @@ void dma_buf_unmap_attachment_unlocked(struct dma_buf_attachment *,
>   				       struct sg_table *,
>   				       enum dma_data_direction);
>   
> +struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
> +					enum dma_data_direction);
> +void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
> +			      struct sg_table *sg_table,
> +			      enum dma_data_direction direction);
> +
>   void dma_buf_move_notify(struct dma_buf *dma_buf);
>   int dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
>   			     enum dma_data_direction dir);

