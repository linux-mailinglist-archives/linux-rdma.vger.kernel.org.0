Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEF659101D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Aug 2022 13:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiHLLeJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Aug 2022 07:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiHLLeI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Aug 2022 07:34:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59990AE9F3;
        Fri, 12 Aug 2022 04:34:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i14so1546105ejg.6;
        Fri, 12 Aug 2022 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2maBmCwKBmigg6muaEXXhf/Ng5GHmKY483ELQvBK7bw=;
        b=WzmVA6wJmViKgJcjJ28fwTes4+4nkLVN3Mx6n7aAByQjaF1kqlO8c/DkZzzNbQ5PMJ
         Q6QRifhtEywKPW0BRycraqPgJbNNV4Fkr0BDi9NwSjofj+/eExHcmIHXfmWBqj8nEM+V
         SJ6yUML0yO8yFd9lLsoNczBtQtybcTMT4WUr1ptuUKBS3/Rda9YC3hjAtXIBeNWzrfQv
         8awekeP8HdFvSg9RwEt6hfJjxWj4IHX4MucvbIt4QDscDPd/6Xe/c8eYLuCx5yo9ewIX
         pCKNLJxEdZn4+tUGCfNxm+c1cgbj7a+b8mhWZ+qT9Wu2+c+9oyIWqC1lkYhae0HgqZSg
         TC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2maBmCwKBmigg6muaEXXhf/Ng5GHmKY483ELQvBK7bw=;
        b=HtOTqfpVgGZB0YfPVKTRsiZ3gcNHF4Z69p5FoBOpfGT1Za4F7mRswRcFAlihpMctKv
         a0Egsq7l/MMAxN2+NpzDJ/3VUSzbfLtecxRW3oAspfsd2UHEdmUXXjH4A3xwG57YORit
         JvOyAWHstK5mICRDXnREStJIhPACjUFI1qrPO3oEamMQExT1UWSWfDNBcgtf+gLQ/1su
         u2t6yjNFPkYH+O+o9bKzb44WzemHWWvgRSPCjJ3/BzgtQDuyMMKmcx0UARWieUExpjZa
         Tcw2hms5QIfXzjiEizX140yGbnC5gdQzgPz3Ej5ncZUK4u17T8bEFAowcT5an+HOJepB
         zfYw==
X-Gm-Message-State: ACgBeo2iKt3GI50L7GhgfyhNgjYElW6Hu8z6SAghtY5HNuoN+UJY/yTz
        10DGu+0Hy8c6PaP4+PkWQZA=
X-Google-Smtp-Source: AA6agR7yLrz2JyTe8JHAoaW31lDloNP6q9ah/gkL0Xj0JLrU44S+nATJXnQ7Xvnv8KPuB3tTB73pJw==
X-Received: by 2002:a17:906:eeca:b0:730:6880:c397 with SMTP id wu10-20020a170906eeca00b007306880c397mr2352637ejb.593.1660304045907;
        Fri, 12 Aug 2022 04:34:05 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id jj23-20020a170907985700b0073151ce7726sm696022ejc.100.2022.08.12.04.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 04:34:05 -0700 (PDT)
Message-ID: <93484389-1f79-b364-700f-60769fc5f8a5@gmail.com>
Date:   Fri, 12 Aug 2022 13:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Linaro-mm-sig] [PATCH v2 3/5] dma-buf: Move all dma-bufs to
 dynamic locking specification
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <0863cafa-c252-e194-3d23-ef640941e36e@collabora.com>
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



Am 10.08.22 um 20:53 schrieb Dmitry Osipenko:
> On 8/10/22 21:25, Christian König wrote:
>> Am 10.08.22 um 19:49 schrieb Dmitry Osipenko:
>>> On 8/10/22 14:30, Christian König wrote:
>>>> Am 25.07.22 um 17:18 schrieb Dmitry Osipenko:
>>>>> This patch moves the non-dynamic dma-buf users over to the dynamic
>>>>> locking specification. The strict locking convention prevents deadlock
>>>>> situation for dma-buf importers and exporters.
>>>>>
>>>>> Previously the "unlocked" versions of the dma-buf API functions weren't
>>>>> taking the reservation lock and this patch makes them to take the lock.
>>>>>
>>>>> Intel and AMD GPU drivers already were mapping imported dma-bufs under
>>>>> the held lock, hence the "locked" variant of the functions are added
>>>>> for them and the drivers are updated to use the "locked" versions.
>>>> In general "Yes, please", but that won't be that easy.
>>>>
>>>> You not only need to change amdgpu and i915, but all drivers
>>>> implementing the map_dma_buf(), unmap_dma_buf() callbacks.
>>>>
>>>> Auditing all that code is a huge bunch of work.
>>> Hm, neither of drivers take the resv lock in map_dma_buf/unmap_dma_buf.
>>> It's easy to audit them all and I did it. So either I'm missing
>>> something or it doesn't take much time to check them all. Am I really
>>> missing something?
>> Ok, so this is only changing map/unmap now?
> It also vmap/vunmap and attach/detach: In the previous patch I added the
> _unlocked postfix to the func names and in this patch I made them all to
> actually take the lock.


Take your patch "[PATCH v2 2/5] drm/gem: Take reservation lock for 
vmap/vunmap operations" as a blueprint on how to approach it.

E.g. one callback at a time and then document the result in the end.

Regards,
Christian.

>
>> In this case please separate this from the documentation change.
> I'll factor out the doc in the v3.
>
>> I would also drop the _locked postfix from the function name, just
>> having _unlocked on all functions which are supposed to be called with
>> the lock held should be sufficient.
> Noted for the v3.
>
>> Thanks for looking into this,
>> Christian.
> Thank you for the review.
>

