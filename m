Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1541661FB9A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 18:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiKGRh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 12:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiKGRh6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 12:37:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED682126C;
        Mon,  7 Nov 2022 09:37:57 -0800 (PST)
Received: from [192.168.2.123] (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB1B366023A6;
        Mon,  7 Nov 2022 17:37:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667842676;
        bh=UMRS4vM/GE6IwT0ij75XZK2yxYOoTzS0D0RuPVqVLQ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=miwcwDXpS7Bbvd1kg8ufWW8EYMDu/fgcPle5PVDEc/B45ktlgqIx4KYYA7QJIH0/S
         by6GLLPhco/tY89MPdmT/s8ECZUVpumdsyezUNadhVFrBlk2dKSnpRR4YYHs5ifRqx
         kuVjLNaEObN6eE/lFu1N0kKKLb+Hg6OZXx6pYEFM8ctFWBT+AgibmceYq8kqFMCEG5
         kowqpdeAKxf0CNu91SEfqgK2XcDJWq/xRLM5BkdsTv9wWssGJ9nsGOSCQkZma8qL+/
         vHXhwraRJ7N/LdEZD26enrecVwg8djUWKheSt++aa2448mbVzh/odGXyBvPK2wEDIp
         kG1p1Gc0TCNDw==
Message-ID: <daebe990-6032-15a1-175a-84e9e1ce2ca0@collabora.com>
Date:   Mon, 7 Nov 2022 20:37:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v7 18/21] dma-buf: Move dma_buf_mmap() to dynamic locking
 specification
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
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
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Ruhl Michael J <michael.j.ruhl@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221017172229.42269-1-dmitry.osipenko@collabora.com>
 <20221017172229.42269-19-dmitry.osipenko@collabora.com>
 <CAKMK7uFFwTfNYT2BrubYvUMrH4fEmtF=yJshUck3-gKYLGqxCg@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAKMK7uFFwTfNYT2BrubYvUMrH4fEmtF=yJshUck3-gKYLGqxCg@mail.gmail.com>
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

On 11/7/22 20:25, Daniel Vetter wrote:
>> Move dma_buf_mmap() function to the dynamic locking specification by
>> taking the reservation lock. Neither of the today's drivers take the
>> reservation lock within the mmap() callback, hence it's safe to enforce
>> the locking.
>>
>> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Just noticed this while reading code ... this patch seems to have
> missed dma_buf_mmap_internal()?
> 
> Might be good if at least some drivers gain a dma_resv_assert_held in
> that path to make sure we're not quite this bad, together with fixing
> this issue.

Good catch! I'll prepare the patches.

-- 
Best regards,
Dmitry

