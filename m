Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50DE58F1EB
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Aug 2022 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiHJRuC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Aug 2022 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJRuB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Aug 2022 13:50:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B0C86C06;
        Wed, 10 Aug 2022 10:50:00 -0700 (PDT)
Received: from [192.168.2.145] (unknown [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D62E36601B74;
        Wed, 10 Aug 2022 18:49:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660153798;
        bh=pDHN4Gq67YC5dkFkOigxG5qVuMpoiLudRbA2dlJSe60=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dx5zUXAvOHpPG48aUabRl4+njgRCDMJzHPNbYmdwo/RrQaYohgnMXvlpCz6ESzyKs
         ngzi4Hf9SaHlQm+ddXoAVN+akYwgvtFkSA20LqsgtGm2i+fN5LnbRUM12j66sGvfut
         405XDLhmATvxt75b00LbDt5bM7vhAV59hvardycmuItJ28RJJs57P9QBEwm4ARIJ4N
         Xr4LNfrsIBiE9revYn9VBAzA/V28mbhwQUOxsElunyWLFP9ZQpPw69GpUcbMWFAEk2
         z8VCIqgHR6yyvRNwNJ57VkSQ1xch+gMPcB/ET5a4BOPLluJFgFU8esaLMJAfvVlpuY
         Juvao4qkUCZIQ==
Message-ID: <562fbacf-3673-ff3c-23a1-124284b4456c@collabora.com>
Date:   Wed, 10 Aug 2022 20:49:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Linaro-mm-sig] [PATCH v2 3/5] dma-buf: Move all dma-bufs to
 dynamic locking specification
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
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
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220725151839.31622-1-dmitry.osipenko@collabora.com>
 <20220725151839.31622-4-dmitry.osipenko@collabora.com>
 <6c8bded9-1809-608f-749a-5ee28b852d32@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <6c8bded9-1809-608f-749a-5ee28b852d32@gmail.com>
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

On 8/10/22 14:30, Christian König wrote:
> Am 25.07.22 um 17:18 schrieb Dmitry Osipenko:
>> This patch moves the non-dynamic dma-buf users over to the dynamic
>> locking specification. The strict locking convention prevents deadlock
>> situation for dma-buf importers and exporters.
>>
>> Previously the "unlocked" versions of the dma-buf API functions weren't
>> taking the reservation lock and this patch makes them to take the lock.
>>
>> Intel and AMD GPU drivers already were mapping imported dma-bufs under
>> the held lock, hence the "locked" variant of the functions are added
>> for them and the drivers are updated to use the "locked" versions.
> 
> In general "Yes, please", but that won't be that easy.
> 
> You not only need to change amdgpu and i915, but all drivers
> implementing the map_dma_buf(), unmap_dma_buf() callbacks.
> 
> Auditing all that code is a huge bunch of work.
Hm, neither of drivers take the resv lock in map_dma_buf/unmap_dma_buf.
It's easy to audit them all and I did it. So either I'm missing
something or it doesn't take much time to check them all. Am I really
missing something?

https://elixir.bootlin.com/linux/latest/A/ident/map_dma_buf

-- 
Best regards,
Dmitry
