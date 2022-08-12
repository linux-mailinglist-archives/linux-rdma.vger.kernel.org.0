Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450BC591050
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Aug 2022 13:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiHLLqd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Aug 2022 07:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbiHLLqb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Aug 2022 07:46:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E47A88DF1;
        Fri, 12 Aug 2022 04:46:28 -0700 (PDT)
Received: from [192.168.2.145] (unknown [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD19E66016F2;
        Fri, 12 Aug 2022 12:46:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660304786;
        bh=C5rdDWAQ0gULbYpYsWO6A2mmdZ/uxYEqrEknr4MoOf8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f3cXPfNXtZHtoSYE1rfxtQ30MUhUVhGrG/NArO1c7kQB8/Xy+FmlqaaOTXT5gVdlP
         JQXrT9UtGLSc+oBaf/E/efq95t8eHa3wW8rsdseitQlUvtaI4DwUh/ptuZTZ+7D4oa
         7gYb8ygLDMwAttTQiJt/HYS3piyRQe36Z1IpIZJqOFl16YT77Eqw1UGF1vppI4t/Vf
         GlTMr5So6lTOFJQj6bSYwIN6RamDBXBlbOMkDkPHaJHbuvpX0ALyNVMapf4xI3a4LC
         uDEbP9wEVI4gkRbHJNZkFWXDO04u0wVdnPFCF2dEImetIe9dBjI0qKFkC2Wjrvs/O9
         MpZiQvPIhyRKg==
Message-ID: <b7bc8c98-d613-a50d-454c-06ca76d707e1@collabora.com>
Date:   Fri, 12 Aug 2022 14:46:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Linaro-mm-sig] [PATCH v2 3/5] dma-buf: Move all dma-bufs to
 dynamic locking specification
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, David Airlie <airlied@linux.ie>,
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
References: <20220725151839.31622-1-dmitry.osipenko@collabora.com>
 <20220725151839.31622-4-dmitry.osipenko@collabora.com>
 <6c8bded9-1809-608f-749a-5ee28b852d32@gmail.com>
 <562fbacf-3673-ff3c-23a1-124284b4456c@collabora.com>
 <87724722-b9f3-a016-c25c-4b0415f2c37f@amd.com>
 <0863cafa-c252-e194-3d23-ef640941e36e@collabora.com>
 <93484389-1f79-b364-700f-60769fc5f8a5@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <93484389-1f79-b364-700f-60769fc5f8a5@gmail.com>
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

On 8/12/22 14:34, Christian König wrote:
> 
> 
> Am 10.08.22 um 20:53 schrieb Dmitry Osipenko:
>> On 8/10/22 21:25, Christian König wrote:
>>> Am 10.08.22 um 19:49 schrieb Dmitry Osipenko:
>>>> On 8/10/22 14:30, Christian König wrote:
>>>>> Am 25.07.22 um 17:18 schrieb Dmitry Osipenko:
>>>>>> This patch moves the non-dynamic dma-buf users over to the dynamic
>>>>>> locking specification. The strict locking convention prevents
>>>>>> deadlock
>>>>>> situation for dma-buf importers and exporters.
>>>>>>
>>>>>> Previously the "unlocked" versions of the dma-buf API functions
>>>>>> weren't
>>>>>> taking the reservation lock and this patch makes them to take the
>>>>>> lock.
>>>>>>
>>>>>> Intel and AMD GPU drivers already were mapping imported dma-bufs
>>>>>> under
>>>>>> the held lock, hence the "locked" variant of the functions are added
>>>>>> for them and the drivers are updated to use the "locked" versions.
>>>>> In general "Yes, please", but that won't be that easy.
>>>>>
>>>>> You not only need to change amdgpu and i915, but all drivers
>>>>> implementing the map_dma_buf(), unmap_dma_buf() callbacks.
>>>>>
>>>>> Auditing all that code is a huge bunch of work.
>>>> Hm, neither of drivers take the resv lock in map_dma_buf/unmap_dma_buf.
>>>> It's easy to audit them all and I did it. So either I'm missing
>>>> something or it doesn't take much time to check them all. Am I really
>>>> missing something?
>>> Ok, so this is only changing map/unmap now?
>> It also vmap/vunmap and attach/detach: In the previous patch I added the
>> _unlocked postfix to the func names and in this patch I made them all to
>> actually take the lock.
> 
> 
> Take your patch "[PATCH v2 2/5] drm/gem: Take reservation lock for
> vmap/vunmap operations" as a blueprint on how to approach it.
> 
> E.g. one callback at a time and then document the result in the end.

Yeah, I'll do it for v3. I'm vaguely recalling that there was a problem
when I wanted to split this patch in the past, but don't remember what
it was.. maybe that problem is gone now, will see :)

-- 
Best regards,
Dmitry
