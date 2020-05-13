Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534D01D096B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 09:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgEMHCn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMHCm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 03:02:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43542C061A0C;
        Wed, 13 May 2020 00:02:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so27110529wmc.5;
        Wed, 13 May 2020 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Dy8Jhh6UuIjYdQgEuvO0u3h8Ch6uEM4eGbltcbsMang=;
        b=BT0cJHsc3Glo8geXjfBR1S4oNEPaYEYyYfD3Fau2YdIjGM7ikkS2Yp8bW6BmW78ySv
         FXKIBBNHt6TesiqyZ/GvDSQniFIwcbeKCK1JVcDSYQ+jYamLlVdglqyVNuJC6i3ZTlHY
         kcTh16jbw/mvGfumpngFq8fr+MTZuoQJ0a/nbkV4tPJlQApEr/+BCs29SAv0Nefz6JB7
         8kcYmJaJalkvbqt7284kR0rVzX08/YZEpWJ1Q4MPa/wHRqsovOxwgHqlJ0ekZWMLXMWg
         NHPpWfyfcKeosm8FB4O4Ml3+dFPot5/A9L15EtzWHexWDd7WJOeiTutT2dggdpouK7Pp
         bHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Dy8Jhh6UuIjYdQgEuvO0u3h8Ch6uEM4eGbltcbsMang=;
        b=CRMpaISGw9ywmyIBF+k+J+jav4mMUTfUN1yTR9NOcpAnHl2JyGQcwZrHR/lSPq8doK
         LEmFzy9hCNvAc4VItXpamWAFTwj55xqbWTX9pAhgmJxZd4+2UpHEFXdOlRDYUXpD6xuf
         S2B25iMA9R09NOGvAxbCHRplNQiraCWcva8a5QR8sukPueXeSOfw8SLVrmGURpxTQY9q
         i5M3oWC9oC/xIZ9VZKJNs5V5049BCqosCymkFTev5TIGPDvVn1KIqqxTTCwR5EgMXylK
         ccguQYqPRZAIZmlycBjI4dAmKkwfTxNc/w2tA3BjiTXx/gX6PgDx/Wzc5uqFI4j1+FSc
         jC5g==
X-Gm-Message-State: AGi0Puahu9E0UnMdNX5gyt2fDubIPstyTknyRlvyJY546cF8+MjqrExn
        Gg6QXF2gUYLqKP3680fp9hG5L25J
X-Google-Smtp-Source: APiQypL6H5LiHY+WHN2lUhR0xRgoqcNlS21mxYwDK4aftjSqKO9Mfp2AQiBafBotsWqxQRILrAhvwQ==
X-Received: by 2002:a1c:9ad1:: with SMTP id c200mr19199796wme.147.1589353360875;
        Wed, 13 May 2020 00:02:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id x17sm1053434wrp.71.2020.05.13.00.02.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 00:02:40 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [RFC 09/17] drm/amdgpu: use dma-fence annotations in cs_submit()
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-rdma@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linaro-mm-sig@lists.linaro.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-10-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6cfd324e-0443-3a12-6a2c-25a546c68643@gmail.com>
Date:   Wed, 13 May 2020 09:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200512085944.222637-10-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 12.05.20 um 10:59 schrieb Daniel Vetter:
> This is a bit tricky, since ->notifier_lock is held while calling
> dma_fence_wait we must ensure that also the read side (i.e.
> dma_fence_begin_signalling) is on the same side. If we mix this up
> lockdep complaints, and that's again why we want to have these
> annotations.
>
> A nice side effect of this is that because of the fs_reclaim priming
> for dma_fence_enable lockdep now automatically checks for us that
> nothing in here allocates memory, without even running any userptr
> workloads.
>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 7653f62b1b2d..6db3f3c629b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1213,6 +1213,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	struct amdgpu_job *job;
>   	uint64_t seq;
>   	int r;
> +	bool fence_cookie;
>   
>   	job = p->job;
>   	p->job = NULL;
> @@ -1227,6 +1228,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	 */
>   	mutex_lock(&p->adev->notifier_lock);
>   
> +	fence_cookie = dma_fence_begin_signalling();
> +
>   	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
>   	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
>   	 */
> @@ -1264,12 +1267,14 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>   
>   	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> +	dma_fence_end_signalling(fence_cookie);

Mhm, this could come earlier in theory. E.g. after pushing the job to 
the scheduler.

Christian.

>   	mutex_unlock(&p->adev->notifier_lock);
>   
>   	return 0;
>   
>   error_abort:
>   	drm_sched_job_cleanup(&job->base);
> +	dma_fence_end_signalling(fence_cookie);
>   	mutex_unlock(&p->adev->notifier_lock);
>   
>   error_unlock:

