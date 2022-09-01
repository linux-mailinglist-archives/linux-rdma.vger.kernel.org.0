Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABF35A94E2
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 12:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiIAKmC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiIAKld (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 06:41:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DBAA50E2;
        Thu,  1 Sep 2022 03:41:29 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0EC286601DF7;
        Thu,  1 Sep 2022 11:41:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662028888;
        bh=4gRwEeQrpCCNInUGu4Wkln9ZnVQKU6fbLc+GiIs/ids=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oAi2rxSwcnG0bXjo2QlMDHpLcITXazqjTc0dBalx+xOeHafTkvkjyLjXi6A6OOyur
         z7pbNTKLqD/VkqICHbjajAS8k3mrAX9GZO4wHzC1QonWNPPsB+Yz/xNrNkGHiYNqkW
         KkTeNffA7kOX5RP0brCKXhs5fgLYvkel3UkZEKV4IsG5BuPE8jfFljWb4zRoqwCW4G
         seQ5HIQoKzjXqwqMOZEyy+r7MpCNGUMFwnjvSCAObVKOgjJcGMutTDAsM5pfKtEEMm
         0OqK6C+DTZS/pjJwK1O6NhqMYskfUmdtIsJv4b93vGTms4LgyHT3lMm/bHN76TIS0u
         g+wfJ91stbLBw==
Message-ID: <b6d96128-7558-8111-71b0-5fe5502ddf4b@collabora.com>
Date:   Thu, 1 Sep 2022 13:41:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 09/21] drm/etnaviv: Prepare to dynamic dma-buf locking
 specification
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
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
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        Qiang Yu <yuq825@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Tomi Valkeinen <tomba@kernel.org>
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
 <20220831153757.97381-10-dmitry.osipenko@collabora.com>
 <641f372f-4a30-72bb-ec8b-4fd6ff825594@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <641f372f-4a30-72bb-ec8b-4fd6ff825594@amd.com>
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

On 9/1/22 09:50, Christian König wrote:
> Am 31.08.22 um 17:37 schrieb Dmitry Osipenko:
>> Prepare Etnaviv driver to the common dynamic dma-buf locking convention
>> by starting to use the unlocked versions of dma-buf API functions.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Interesting, where is the matching vmap()?
> 
> Anyway, this patch is Acked-by: Christian König <christian.koenig@amd.com>

Etnaviv maps GEM only once and then unmaps it when GEM is destroyed. The
dma-buf vmapping should happen under the reservation lock, hence only
the release function needs to be changed to the unlocked variant.

Lucas/Christian(Gmeiner), could you please check that I haven't missed
anything?

>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> index 3fa2da149639..7031db145a77 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> @@ -65,7 +65,7 @@ static void etnaviv_gem_prime_release(struct
>> etnaviv_gem_object *etnaviv_obj)
>>       struct iosys_map map = IOSYS_MAP_INIT_VADDR(etnaviv_obj->vaddr);
>>         if (etnaviv_obj->vaddr)
>> -        dma_buf_vunmap(etnaviv_obj->base.import_attach->dmabuf, &map);
>> +       
>> dma_buf_vunmap_unlocked(etnaviv_obj->base.import_attach->dmabuf, &map);
>>         /* Don't drop the pages for imported dmabuf, as they are not
>>        * ours, just free the array we allocated:
> 


-- 
Best regards,
Dmitry
