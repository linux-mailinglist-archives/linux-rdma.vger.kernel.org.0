Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62937575E9D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jul 2022 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiGOJbq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jul 2022 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiGOJbp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jul 2022 05:31:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DEAE0B4;
        Fri, 15 Jul 2022 02:31:44 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E29866019A8;
        Fri, 15 Jul 2022 10:31:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657877502;
        bh=TWozmotf+sQwVdZNmn/06hy3nh6q5FZqNEZs2dkO0Xk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ook7FofVSeFu98kzfOW85/NvaqQGYfMlcoQwPYYEf1uM53lI6XEH5r2IfZA5D39YG
         One7B2e3W/fD6MOKVR32mTsfa0F578/RBAeOo8/NotqqijY2/uTpe7t/xwykgVmrPt
         +yavsYIuw7Eo6wCEeOig0kwF08jXCpcKDfKm5bf62mOtUtod68wxkNTfoOrBO2Vigr
         jGGe7rNPzl9ucoy/rbaMWflBdm9lL83CRfG8Nh3DuvKmTusiGl7vlEzXHo8BAnin4h
         VmXp2fNABeQZzflx/SPBJ4BlHwecx5t82vj5mWQ6sz+HwjJh2hV8TUmAiQ8RvCIpsC
         jI9dt2CUipsuA==
Message-ID: <5c98385b-f154-0128-6f4b-5fac89529201@collabora.com>
Date:   Fri, 15 Jul 2022 12:31:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/6] dma-buf: Add _unlocked postfix to function names
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
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220715005244.42198-1-dmitry.osipenko@collabora.com>
 <20220715005244.42198-2-dmitry.osipenko@collabora.com>
 <43c06f53-bad8-af99-0b57-781dbf716768@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <43c06f53-bad8-af99-0b57-781dbf716768@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/15/22 10:19, Christian König wrote:
>> -struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment
>> *attach,
>> -                    enum dma_data_direction direction)
>> +struct sg_table *
>> +dma_buf_map_attachment_unlocked(struct dma_buf_attachment *attach,
>> +                enum dma_data_direction direction)
> 
> The locking state of mapping and unmapping operations depend on if the
> attachment is dynamic or not.
> 
> So this here is not a good idea at all since it suggests that the
> function is always called without holding the lock.

I had the same thought while was working on this patch and initially was
thinking about adding an "unlocked" alias to dma_buf_map_attachment().
In the end I decided that it will create even more confusion and it's
simpler just to rename this func here since there are only two drivers
using the dynamic mapping.

Do you have suggestions how to improve it?

-- 
Best regards,
Dmitry
