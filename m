Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024855F8885
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Oct 2022 02:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJIAJJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Oct 2022 20:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJIAJI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Oct 2022 20:09:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32D237F6;
        Sat,  8 Oct 2022 17:09:06 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-114.nat.spd-mgts.ru [109.252.119.114])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD61E6602303;
        Sun,  9 Oct 2022 01:08:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665274142;
        bh=tRu/AWDhf1iOYLNP6D5ccZEJMnF9oPGtd04+Gk3jRuA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=fH3GVJPP0Agx7FoWitfSeocWjORT1LvnTSnPwSqsxinARwwXtUpOaikNENp0bqUrC
         PEWSWFEjMZP7lDmv6EU2Grv25zWS7RZ/h7CyD+7zKtjl4QAfnnCEScMPlrHhseb+En
         Gz6vFJUxlSWNVwbR41RbruaqwCZ47lCdToK+BcEO9GuR8so0PP/P07QqERBUWyAJVb
         MMo4+FZKLISPnrknOSkksa6Ta/zh2p7kUJ5bKem5cyumvth/JLc9RmmGae3HPvGZFj
         1usDID4w07q/Pi3FDQyJlsU/m9taGaBUzV9f+UEhS80kUisNvUwJDrtVlek5svMZjQ
         SedcaWbpdnMdw==
Message-ID: <e3ba146d-8153-add5-2cf4-02fe6519abee@collabora.com>
Date:   Sun, 9 Oct 2022 03:08:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v6 10/21] RDMA/umem: Prepare to dynamic dma-buf locking
 specification
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
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
        Qiang Yu <yuq825@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Ruhl Michael J <michael.j.ruhl@intel.com>
References: <20220928191600.5874-1-dmitry.osipenko@collabora.com>
 <20220928191600.5874-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20220928191600.5874-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/28/22 22:15, Dmitry Osipenko wrote:
> Prepare InfiniBand drivers to the common dynamic dma-buf locking
> convention by starting to use the unlocked versions of dma-buf API
> functions.
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/infiniband/core/umem_dmabuf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
> index 04c04e6d24c3..43b26bc12288 100644
> --- a/drivers/infiniband/core/umem_dmabuf.c
> +++ b/drivers/infiniband/core/umem_dmabuf.c
> @@ -26,7 +26,8 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
>  	if (umem_dmabuf->sgt)
>  		goto wait_fence;
>  
> -	sgt = dma_buf_map_attachment(umem_dmabuf->attach, DMA_BIDIRECTIONAL);
> +	sgt = dma_buf_map_attachment_unlocked(umem_dmabuf->attach,
> +					      DMA_BIDIRECTIONAL);
>  	if (IS_ERR(sgt))
>  		return PTR_ERR(sgt);
>  
> @@ -102,8 +103,8 @@ void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf)
>  		umem_dmabuf->last_sg_trim = 0;
>  	}
>  
> -	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt,
> -				 DMA_BIDIRECTIONAL);
> +	dma_buf_unmap_attachment_unlocked(umem_dmabuf->attach, umem_dmabuf->sgt,
> +					  DMA_BIDIRECTIONAL);
>  
>  	umem_dmabuf->sgt = NULL;
>  }

Jason / Leon,

Could you please ack this patch?

-- 
Best regards,
Dmitry

