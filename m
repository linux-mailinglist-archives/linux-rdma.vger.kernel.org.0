Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A522859FCD5
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiHXOLA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbiHXOK7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 10:10:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09B083BC2;
        Wed, 24 Aug 2022 07:10:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z8so1603999edb.0;
        Wed, 24 Aug 2022 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=kqPUQCej5vuqxvtj8Chlk3T/0EwQ6MX8daIfGCr7o8M=;
        b=jTVBzq0qwP/Jiix3oxmDZ7+wYfTBhEWTauZQdu8hOviYHBGCplvf/sjEo/RV5EynDV
         F/3igCTqIWBw9y1M+Tz1KtUNZJ/Vc7vYsDCQckxSEEaEAATSUMLMhhZM/uRvXPKJwTID
         JFPXKVME1YPvW3AWEEt8IY1tnflEl6+s2+VTI3lNdEf9I2/bpW1ED4ELRE0sMfvAneeH
         /StlMvl5hA5f4v6Ub32YqKj3011/RpihmCQ/mxpFLVUJNkoTI8bwaIrfE8kqKCGPv4z9
         I+UIpLo6Qj3px/bXQ4vWO4iPykWOgMwW3vwWBjvKVJT+EdtLeVH/fQX5AFSNWc9Rj8ry
         Hsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kqPUQCej5vuqxvtj8Chlk3T/0EwQ6MX8daIfGCr7o8M=;
        b=PIq1m0AObAVPzXc5Bm/EmFVor99DdopRmqrlkATiJ6KNOKqdd0ln+wKD0uWHxjj9ho
         e+o2TfrOLCXfni3kXnELBqansXdxRLrp6VALzT1CIYFZ5UEnnSTYwAJq5/X+B7OUCM7w
         d7w36lHqXDOrDHJ/aGhoyd+vzzItdjnkJbmVBF6AP5798CjhQAaUR9RNN4EySSdDjKkj
         fta9mBXIc8ioGIpeCMncZf1tJGsSIEoy8g4f+EXCcpX1B84K1MBFW8qmLGCFhR8QdND+
         J5onhcP8PPkAhhp8DhSNtKlqS2VI0uQ7oHXh3Eys0Kd39ifwWNWRrsUZQ+Y0Kl2bJo32
         3zew==
X-Gm-Message-State: ACgBeo29ZjQ15BHKiV12CrLk9Rnmi6fNX4Wg482Dqy7Z0xlU+jE0PRtM
        b8b9R/zr9vZOrpu63Med8l8=
X-Google-Smtp-Source: AA6agR4FhXaC9pbWpsAk9+dYxjrSjwUKJso4IGx0zPGDwcQGaUM8T/17R/PS2YwW53RL5Bz2crZ4pw==
X-Received: by 2002:a05:6402:358a:b0:446:da94:e68c with SMTP id y10-20020a056402358a00b00446da94e68cmr7682224edc.356.1661350256435;
        Wed, 24 Aug 2022 07:10:56 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:62ca:57d9:b533:6057? ([2a02:908:1256:79a0:62ca:57d9:b533:6057])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b0073d6d760daesm1229270ejh.60.2022.08.24.07.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 07:10:55 -0700 (PDT)
Message-ID: <abb7842a-ca07-59db-927b-06c3dc17974c@gmail.com>
Date:   Wed, 24 Aug 2022 16:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 9/9] dma-buf: Remove internal lock
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
 <20220824102248.91964-10-dmitry.osipenko@collabora.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220824102248.91964-10-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Am 24.08.22 um 12:22 schrieb Dmitry Osipenko:
> The internal dma-buf lock isn't needed anymore because the updated
> locking specification claims that dma-buf reservation must be locked
> by importers, and thus, the internal data is already protected by the
> reservation lock. Remove the obsoleted internal lock.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/dma-buf/dma-buf.c | 14 ++++----------
>   include/linux/dma-buf.h   |  9 ---------
>   2 files changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 696d132b02f4..a0406254f0ae 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -656,7 +656,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>   
>   	dmabuf->file = file;
>   
> -	mutex_init(&dmabuf->lock);
>   	INIT_LIST_HEAD(&dmabuf->attachments);
>   
>   	mutex_lock(&db_list.lock);
> @@ -1503,7 +1502,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_mmap_unlocked, DMA_BUF);
>   int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
>   {
>   	struct iosys_map ptr;
> -	int ret = 0;
> +	int ret;
>   
>   	iosys_map_clear(map);
>   
> @@ -1515,28 +1514,25 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
>   	if (!dmabuf->ops->vmap)
>   		return -EINVAL;
>   
> -	mutex_lock(&dmabuf->lock);
>   	if (dmabuf->vmapping_counter) {
>   		dmabuf->vmapping_counter++;
>   		BUG_ON(iosys_map_is_null(&dmabuf->vmap_ptr));
>   		*map = dmabuf->vmap_ptr;
> -		goto out_unlock;
> +		return 0;
>   	}
>   
>   	BUG_ON(iosys_map_is_set(&dmabuf->vmap_ptr));
>   
>   	ret = dmabuf->ops->vmap(dmabuf, &ptr);
>   	if (WARN_ON_ONCE(ret))
> -		goto out_unlock;
> +		return ret;
>   
>   	dmabuf->vmap_ptr = ptr;
>   	dmabuf->vmapping_counter = 1;
>   
>   	*map = dmabuf->vmap_ptr;
>   
> -out_unlock:
> -	mutex_unlock(&dmabuf->lock);
> -	return ret;
> +	return 0;
>   }
>   EXPORT_SYMBOL_NS_GPL(dma_buf_vmap, DMA_BUF);
>   
> @@ -1578,13 +1574,11 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map)
>   	BUG_ON(dmabuf->vmapping_counter == 0);
>   	BUG_ON(!iosys_map_is_equal(&dmabuf->vmap_ptr, map));
>   
> -	mutex_lock(&dmabuf->lock);
>   	if (--dmabuf->vmapping_counter == 0) {
>   		if (dmabuf->ops->vunmap)
>   			dmabuf->ops->vunmap(dmabuf, map);
>   		iosys_map_clear(&dmabuf->vmap_ptr);
>   	}
> -	mutex_unlock(&dmabuf->lock);
>   }
>   EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap, DMA_BUF);
>   
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d48d534dc55c..aed6695bbb50 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -326,15 +326,6 @@ struct dma_buf {
>   	/** @ops: dma_buf_ops associated with this buffer object. */
>   	const struct dma_buf_ops *ops;
>   
> -	/**
> -	 * @lock:
> -	 *
> -	 * Used internally to serialize list manipulation, attach/detach and
> -	 * vmap/unmap. Note that in many cases this is superseeded by
> -	 * dma_resv_lock() on @resv.
> -	 */
> -	struct mutex lock;
> -
>   	/**
>   	 * @vmapping_counter:
>   	 *

