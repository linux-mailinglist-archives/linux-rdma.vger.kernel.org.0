Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8A5FA3D4
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Oct 2022 20:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJJS5A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Oct 2022 14:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJJS4m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Oct 2022 14:56:42 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E64BA59
        for <linux-rdma@vger.kernel.org>; Mon, 10 Oct 2022 11:56:39 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d13so879924qko.5
        for <linux-rdma@vger.kernel.org>; Mon, 10 Oct 2022 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mfdinePb/h+FQryCI1VnJk1iVMwwW9XbS8GRZ1SXnEM=;
        b=Y1FJnNxKCCmUeBjERypSSpOT5hLZIa3B6ZfL7TmeBlDcYn7G53u+wzaqGztD4xstS6
         H56NjZrTnnAs/mwbv/53uHY1GhzxoFxOLWj+6+255TR+XIgzukZ2wrhnTPfXH4rpl0ll
         x20RYa7gkPKPOAB+2GjUbYRf86UKilK/+RP5mPzo1iTwxgbIcI/NL1hAwcQva+CI+c58
         wXQg1m452/c0qjzqE/xGhDgd9xycIGhUX5tiX7SJhqTWnYftDSAsnXqQ0qceqqSNwxFf
         a0gsQbHVGj7OQXKVN8LpCmOTHmcWT/lMPoHErC7k7GBXJjyyytJ8h/nDzI7STIfMcpme
         CGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfdinePb/h+FQryCI1VnJk1iVMwwW9XbS8GRZ1SXnEM=;
        b=hh5H+cXG+kXt8DV7ruXjtaqtK5c4ogERdzOqxd56mKqpl8qlMKxSsvTB7RXUeoyWKJ
         u3gCGwqBWkuBlEYF2sTBtCDnGC4zTkEoJwv1Q7OdAUzLBTC2ADhafs02wKqqwqtbwWsm
         rzunVVHvByp/ySL/NQ3v+R1AxsMhbURpZcbvFgk0KG/XvPvDnfGgcEyBal4DKbiJ4ys/
         ZOuW5eyCBkDIYh+dn80+2/DmOzXpxbriHFTfMy9kH9R6wJ+cHTmzxVWIh5fOcFqgSQBq
         0pQ7GhJJMelY6SSsYKmvtD4Hx1G5x4Cgj84Svadmw2r3lydFNeE2HqAMZm+QHzlYt1O7
         srLg==
X-Gm-Message-State: ACrzQf1Xi3sxieQ4eTxo0AY0f6rO2cir3d6jNzBURPZyedFkawM0LMkg
        v2Wi7DRwV059y3TOxU22hEPtSQ==
X-Google-Smtp-Source: AMsMyM4cq1ZiSompu2ffs6ddf24dPwkk/2Lnq1GVt1O6/KQn3scUPTnTqdwZ/uWcjL7riJrPyy9iDQ==
X-Received: by 2002:a05:620a:4397:b0:6e1:345a:e080 with SMTP id a23-20020a05620a439700b006e1345ae080mr13783062qkp.677.1665428198984;
        Mon, 10 Oct 2022 11:56:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a288800b006bb2cd2f6d1sm10684472qkp.127.2022.10.10.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:56:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ohxx7-0012V5-CO;
        Mon, 10 Oct 2022 15:56:37 -0300
Date:   Mon, 10 Oct 2022 15:56:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Leon Romanovsky <leon@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
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
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
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
Subject: Re: [PATCH v6 10/21] RDMA/umem: Prepare to dynamic dma-buf locking
 specification
Message-ID: <Y0Rq5Zb9+63++2z/@ziepe.ca>
References: <20220928191600.5874-1-dmitry.osipenko@collabora.com>
 <20220928191600.5874-11-dmitry.osipenko@collabora.com>
 <e3ba146d-8153-add5-2cf4-02fe6519abee@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3ba146d-8153-add5-2cf4-02fe6519abee@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 09, 2022 at 03:08:56AM +0300, Dmitry Osipenko wrote:
> On 9/28/22 22:15, Dmitry Osipenko wrote:
> > Prepare InfiniBand drivers to the common dynamic dma-buf locking
> > convention by starting to use the unlocked versions of dma-buf API
> > functions.
> > 
> > Acked-by: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >  drivers/infiniband/core/umem_dmabuf.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
> > index 04c04e6d24c3..43b26bc12288 100644
> > --- a/drivers/infiniband/core/umem_dmabuf.c
> > +++ b/drivers/infiniband/core/umem_dmabuf.c
> > @@ -26,7 +26,8 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
> >  	if (umem_dmabuf->sgt)
> >  		goto wait_fence;
> >  
> > -	sgt = dma_buf_map_attachment(umem_dmabuf->attach, DMA_BIDIRECTIONAL);
> > +	sgt = dma_buf_map_attachment_unlocked(umem_dmabuf->attach,
> > +					      DMA_BIDIRECTIONAL);
> >  	if (IS_ERR(sgt))
> >  		return PTR_ERR(sgt);
> >  
> > @@ -102,8 +103,8 @@ void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf)
> >  		umem_dmabuf->last_sg_trim = 0;
> >  	}
> >  
> > -	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt,
> > -				 DMA_BIDIRECTIONAL);
> > +	dma_buf_unmap_attachment_unlocked(umem_dmabuf->attach, umem_dmabuf->sgt,
> > +					  DMA_BIDIRECTIONAL);
> >  
> >  	umem_dmabuf->sgt = NULL;
> >  }
> 
> Jason / Leon,
> 
> Could you please ack this patch?

You probably don't need it, for something so simple, but sure

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
