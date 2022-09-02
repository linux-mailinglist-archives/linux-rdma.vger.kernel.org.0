Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3725AAC6C
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Sep 2022 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiIBKcG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Sep 2022 06:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiIBKcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Sep 2022 06:32:03 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABD2AE20F;
        Fri,  2 Sep 2022 03:32:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x10so1805728ljq.4;
        Fri, 02 Sep 2022 03:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oS1FPn188GwYqcEpeAiuLHN0qFHFB655DOQwCXbqud0=;
        b=n3OAhLhYLpZxMnQfsFjiyUnhcv12eKqug64v55vPtpE/UCjJaNIZHCA+Wwv+6WbtT/
         qWkYjCAk4Yjkuctjw0fBnbyysWH+4pCHaxR5XU+s4CKQjBA8zqhlLNk/otAC43pVbwk/
         +Oxsn+VvggqMRnSHBrZ+4CWc9VjYKgT5IxVQ6II8ncEcyJrTjiDJmp2cyMJgIaGZlVbQ
         +Ann9KO6Y/CoglJHcaRMsiN1jERvtH9CBEqaVN6GF/whofd6gb7RHL1HfeSFl8tQ1bkZ
         Wfhpb2x7/mkxuV0CZPD44CTBUcnCyTj5Pbq+/Suo58ul0XAxasomkcmrFrUsPxyLaF5j
         07AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oS1FPn188GwYqcEpeAiuLHN0qFHFB655DOQwCXbqud0=;
        b=FA1bMzFrtY05RO1wuizXTvliyrX39Vtz0FHBlja11kxbZdnkgsfD67a3Nfr2fdlt8p
         aXeEMFfWrvrLWp5QU+CNdTLlIp1oz3kMzfDd+r5EvsVNARa9X+Yy5fD7gecwjgcgDF7S
         WXfHoMNDWw+XHObFUKmfBKvz1IBdkkyxpGAjPmTbSThvRrm9t6t9SJQTLZbs5k9sX/z7
         VbW6smUW2F8rcIdadDK1widVqFAslNpEdXoqlwNe0I4Lt1bZHF4al9O6UfZYin/mL5al
         HkY2qfRNQXb7HvsXvjp9bsZKPRz1LFdbttwmA5hgzyHGUfOinB3h6Gb/dwiO0JINDzoS
         GHFA==
X-Gm-Message-State: ACgBeo0ZBjKyEzkYG9XwbBs6AfJiwWJ+RD3fYxpaHbEWOZv9IQxqdKn+
        aZjiGKejPNDAoAC6Q9X4JHY=
X-Google-Smtp-Source: AA6agR6ou/2uO4ZwPmqiUBrbDeggu1Vc3sPE8fBViDweS453cB4ryN7X8CzDyYJrxfL2DeihrtrS8A==
X-Received: by 2002:a05:651c:4cf:b0:265:3ba8:92f7 with SMTP id e15-20020a05651c04cf00b002653ba892f7mr6302546lji.105.1662114718656;
        Fri, 02 Sep 2022 03:31:58 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru. [109.252.119.13])
        by smtp.googlemail.com with ESMTPSA id u9-20020ac258c9000000b0048b064707ebsm205794lfo.103.2022.09.02.03.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 03:31:58 -0700 (PDT)
Message-ID: <760b999f-b15d-102e-8bc7-c3e69f07f43f@gmail.com>
Date:   Fri, 2 Sep 2022 13:31:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 06/21] drm/i915: Prepare to dynamic dma-buf locking
 specification
Content-Language: en-US
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
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
        Qiang Yu <yuq825@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
 <20220831153757.97381-7-dmitry.osipenko@collabora.com>
 <DM5PR11MB1324088635FDE00B0D957816C17B9@DM5PR11MB1324.namprd11.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR11MB1324088635FDE00B0D957816C17B9@DM5PR11MB1324.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
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

01.09.2022 17:02, Ruhl, Michael J пишет:
...
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> @@ -331,7 +331,19 @@ static void __i915_gem_free_objects(struct
>> drm_i915_private *i915,
>> 			continue;
>> 		}
>>
>> +		/*
>> +		 * dma_buf_unmap_attachment() requires reservation to be
>> +		 * locked. The imported GEM shouldn't share reservation lock,
>> +		 * so it's safe to take the lock.
>> +		 */
>> +		if (obj->base.import_attach)
>> +			i915_gem_object_lock(obj, NULL);
> 
> There is a lot of stuff going here.  Taking the lock may be premature...
> 
>> 		__i915_gem_object_pages_fini(obj);
> 
> The i915_gem_dmabuf.c:i915_gem_object_put_pages_dmabuf is where
> unmap_attachment is actually called, would it make more sense to make
> do the locking there?

The __i915_gem_object_put_pages() is invoked with a held reservation
lock, while freeing object is a special time when we know that GEM is
unused.

The __i915_gem_free_objects() was taking the lock two weeks ago until
the change made Chris Wilson [1] reached linux-next.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2826d447fbd60e6a05e53d5f918bceb8c04e315c

I don't think we can take the lock within
i915_gem_object_put_pages_dmabuf(), it may/should deadlock other code paths.
