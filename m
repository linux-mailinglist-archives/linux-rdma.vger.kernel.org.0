Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C1B59FDCA
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiHXPDz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiHXPDy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 11:03:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C3898A5D;
        Wed, 24 Aug 2022 08:03:48 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B8806601E8F;
        Wed, 24 Aug 2022 16:03:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661353426;
        bh=ss7Re+WGJ6gPDf+07fuRLgmV2oF07ngUyzhkLngogMo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oAR0YvOOYSafNUGMl1oNd0JDpIq3FDAHC3HSFM85TQLAtdUKWV9S7/KMulX1yzdJU
         ynpYz4YtIeU371JqvKb8/c29/d8CPVp3PGsQrb8kJYYp7JpoSNHveANuXdDGoXqRHL
         p9edkNfznNFe0vL1B7KsPf3EQ1iqD0q15Jh9BVqB7qaGinbAx23HtsmgAfze7Sezsa
         5eCHp4KjFs2i46CRc/qn7EZjWd/w/c9qg+8YOKS0kgwlBEA5uFkOiS4rzy8gfpu2eT
         /NbO6kk31WXQ6hWLjRcZaGob2toZeqNH+aU5AQGrgKbdtAC0glWaondyOLmCNSr5lf
         VJAAXcJe1ilqw==
Message-ID: <4af793fd-eccc-ad70-65c3-de78dced71f0@collabora.com>
Date:   Wed, 24 Aug 2022 18:03:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 6/9] dma-buf: Move dma-buf attachment to dynamic
 locking specification
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
 <17181951-1b40-cd39-48df-58b43cad117d@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <17181951-1b40-cd39-48df-58b43cad117d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/24/22 17:08, Christian König wrote:
> Am 24.08.22 um 12:22 schrieb Dmitry Osipenko:
>> Move dma-buf attachment API functions to the dynamic locking
>> specification.
>> The strict locking convention prevents deadlock situations for dma-buf
>> importers and exporters.
>>
>> Previously, the "unlocked" versions of the attachment API functions
>> weren't taking the reservation lock and this patch makes them to take
>> the lock.
> 
> Didn't we concluded that we need to keep the attach and detach callbacks
> without the lock and only move the map/unmap callbacks over?
> 
> Otherwise it won't be possible for drivers to lock multiple buffers if
> they have to shuffle things around for a specific attachment.

We did conclude that. The attach/detach dma-buf ops are unlocked, but
the map_dma_buf/unmap_dma_buf must be invoked under lock and
dma_buf_dynamic_attach_unlocked() maps dma-buf if either importer or
exporter can't handle the dynamic mapping [1].

[1]
https://elixir.bootlin.com/linux/v6.0-rc2/source/drivers/dma-buf/dma-buf.c#L869

Hence I re-arranged the dma_resv_lock() in
dma_buf_dynamic_attach_unlocked() to move both pinning and mapping under
the held lock.

-- 
Best regards,
Dmitry
