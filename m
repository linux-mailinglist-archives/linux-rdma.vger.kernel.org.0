Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BDA59F7D5
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiHXKcu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 06:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiHXKcr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 06:32:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B57F106;
        Wed, 24 Aug 2022 03:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F196B8239F;
        Wed, 24 Aug 2022 10:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52C3C433C1;
        Wed, 24 Aug 2022 10:32:35 +0000 (UTC)
Message-ID: <0609dbe4-5596-ee9d-abeb-3c126e7ba755@xs4all.nl>
Date:   Wed, 24 Aug 2022 12:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 8/9] media: videobuf2: Stop using internal dma-buf lock
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
 <20220824102248.91964-9-dmitry.osipenko@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220824102248.91964-9-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Nice!

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

On 24/08/2022 12:22, Dmitry Osipenko wrote:
> All drivers that use dma-bufs have been moved to the updated locking
> specification and now dma-buf reservation is guaranteed to be locked
> by importers during the mapping operations. There is no need to take
> the internal dma-buf lock anymore. Remove locking from the videobuf2
> memory allocators.
> 
> Acked-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-dma-contig.c | 11 +----------
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c     | 11 +----------
>  drivers/media/common/videobuf2/videobuf2-vmalloc.c    | 11 +----------
>  3 files changed, 3 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index de762dbdaf78..2c69bf0470e7 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -382,18 +382,12 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
>  	struct dma_buf_attachment *db_attach, enum dma_data_direction dma_dir)
>  {
>  	struct vb2_dc_attachment *attach = db_attach->priv;
> -	/* stealing dmabuf mutex to serialize map/unmap operations */
> -	struct mutex *lock = &db_attach->dmabuf->lock;
>  	struct sg_table *sgt;
>  
> -	mutex_lock(lock);
> -
>  	sgt = &attach->sgt;
>  	/* return previously mapped sg table */
> -	if (attach->dma_dir == dma_dir) {
> -		mutex_unlock(lock);
> +	if (attach->dma_dir == dma_dir)
>  		return sgt;
> -	}
>  
>  	/* release any previous cache */
>  	if (attach->dma_dir != DMA_NONE) {
> @@ -409,14 +403,11 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
>  	if (dma_map_sgtable(db_attach->dev, sgt, dma_dir,
>  			    DMA_ATTR_SKIP_CPU_SYNC)) {
>  		pr_err("failed to map scatterlist\n");
> -		mutex_unlock(lock);
>  		return ERR_PTR(-EIO);
>  	}
>  
>  	attach->dma_dir = dma_dir;
>  
> -	mutex_unlock(lock);
> -
>  	return sgt;
>  }
>  
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> index 39e11600304a..e63e718c0bf7 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -424,18 +424,12 @@ static struct sg_table *vb2_dma_sg_dmabuf_ops_map(
>  	struct dma_buf_attachment *db_attach, enum dma_data_direction dma_dir)
>  {
>  	struct vb2_dma_sg_attachment *attach = db_attach->priv;
> -	/* stealing dmabuf mutex to serialize map/unmap operations */
> -	struct mutex *lock = &db_attach->dmabuf->lock;
>  	struct sg_table *sgt;
>  
> -	mutex_lock(lock);
> -
>  	sgt = &attach->sgt;
>  	/* return previously mapped sg table */
> -	if (attach->dma_dir == dma_dir) {
> -		mutex_unlock(lock);
> +	if (attach->dma_dir == dma_dir)
>  		return sgt;
> -	}
>  
>  	/* release any previous cache */
>  	if (attach->dma_dir != DMA_NONE) {
> @@ -446,14 +440,11 @@ static struct sg_table *vb2_dma_sg_dmabuf_ops_map(
>  	/* mapping to the client with new direction */
>  	if (dma_map_sgtable(db_attach->dev, sgt, dma_dir, 0)) {
>  		pr_err("failed to map scatterlist\n");
> -		mutex_unlock(lock);
>  		return ERR_PTR(-EIO);
>  	}
>  
>  	attach->dma_dir = dma_dir;
>  
> -	mutex_unlock(lock);
> -
>  	return sgt;
>  }
>  
> diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> index 7831bf545874..41db707e43a4 100644
> --- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> +++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> @@ -267,18 +267,12 @@ static struct sg_table *vb2_vmalloc_dmabuf_ops_map(
>  	struct dma_buf_attachment *db_attach, enum dma_data_direction dma_dir)
>  {
>  	struct vb2_vmalloc_attachment *attach = db_attach->priv;
> -	/* stealing dmabuf mutex to serialize map/unmap operations */
> -	struct mutex *lock = &db_attach->dmabuf->lock;
>  	struct sg_table *sgt;
>  
> -	mutex_lock(lock);
> -
>  	sgt = &attach->sgt;
>  	/* return previously mapped sg table */
> -	if (attach->dma_dir == dma_dir) {
> -		mutex_unlock(lock);
> +	if (attach->dma_dir == dma_dir)
>  		return sgt;
> -	}
>  
>  	/* release any previous cache */
>  	if (attach->dma_dir != DMA_NONE) {
> @@ -289,14 +283,11 @@ static struct sg_table *vb2_vmalloc_dmabuf_ops_map(
>  	/* mapping to the client with new direction */
>  	if (dma_map_sgtable(db_attach->dev, sgt, dma_dir, 0)) {
>  		pr_err("failed to map scatterlist\n");
> -		mutex_unlock(lock);
>  		return ERR_PTR(-EIO);
>  	}
>  
>  	attach->dma_dir = dma_dir;
>  
> -	mutex_unlock(lock);
> -
>  	return sgt;
>  }
>  
