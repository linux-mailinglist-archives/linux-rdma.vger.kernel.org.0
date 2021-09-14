Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8540B06A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhINOTz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 10:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhINOTx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 10:19:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8920C061574
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 07:18:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x6so20481707wrv.13
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=kpn+M1bqQCPZctbXT2rMFocOAVoHTOH/YHoMT77kaXA=;
        b=KB4MNAxhrmlbX59MwAQZ6hLhzSFEWzYdMbFTOohpBg3/xVF58nlidY6zi0qGimEhqm
         Jl6OCNnnQMIFIqi85bkucA2jwEyap/QQOUngnGS5sFkRXOcZpJV0qG67XAOWE7gBHPBL
         dZ2GY6mBv3tc5NBbWhoYZ9ImG68TbT4LJGvgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=kpn+M1bqQCPZctbXT2rMFocOAVoHTOH/YHoMT77kaXA=;
        b=QbsEJaVSgbgZUOeKbksz94XYEnkapC7FoGgL2D5YDNRsWbAUM8DKSdIt4p24jw255+
         m27CgRPXbhR16fy01FHmZK72lc9RLRbNM4W6rPpe5N4WU0MoGVaijCaIjvmE9XHT+EdY
         O6qViUwz2A2ZwLyhX7mj7s5rzXkQSTAml1t98Tw+tdl+EFcomeYdLAPhjl5/XrqAd6Yk
         ZTxkzlkryeiWE2Uuy0xYjvH/rB73GoF60XHi23pwkMseH9NcOR1YWmMvN/8VbyfuS6rJ
         STfScv0KTsYnqlzU3swR6wRV43dm5A/znu1aAEf+TmeDMDUSWPLtqyCMtpwhEmsV2PrU
         wPbQ==
X-Gm-Message-State: AOAM533Z/ALPxkSbeP4xbx+pWWLz+/vVQs9SCTiTzJpGnfBaFPWe03au
        yPN82ww4nnEWAdGemyFksKJhBA==
X-Google-Smtp-Source: ABdhPJwKQcZFGHqC1jw8lf4RoQcxifPnrx41rU4gRLMHuOSauY9GY+Cp86a0hl31Z0tdwkoEknt34g==
X-Received: by 2002:adf:f183:: with SMTP id h3mr13825816wro.32.1631629114235;
        Tue, 14 Sep 2021 07:18:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l15sm1251759wme.42.2021.09.14.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:18:33 -0700 (PDT)
Date:   Tue, 14 Sep 2021 16:18:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jgg@ziepe.ca, christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, dledford@redhat.com,
        airlied@gmail.com, alexander.deucher@amd.com, leonro@nvidia.com,
        hch@lst.de, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <YUCvNzpyC091KeaJ@phenom.ffwll.local>
Mail-Followup-To: Oded Gabbay <ogabbay@kernel.org>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jgg@ziepe.ca, christian.koenig@amd.com, galpress@amazon.com,
        sleybo@amazon.com, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
        leonro@nvidia.com, hch@lst.de, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
References: <20210912165309.98695-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912165309.98695-1-ogabbay@kernel.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 07:53:07PM +0300, Oded Gabbay wrote:
> Hi,
> Re-sending this patch-set following the release of our user-space TPC
> compiler and runtime library.
> 
> I would appreciate a review on this.

I think the big open we have is the entire revoke discussions. Having the
option to let dma-buf hang around which map to random local memory ranges,
without clear ownership link and a way to kill it sounds bad to me.

I think there's a few options:
- We require revoke support. But I've heard rdma really doesn't like that,
  I guess because taking out an MR while holding the dma_resv_lock would
  be an inversion, so can't be done. Jason, can you recap what exactly the
  hold-up was again that makes this a no-go?

- The other option I discussed is a bit more the exlusive device ownership
  model we've had for gpus in drm of the really old kind. Roughly this
  would work like this, in terms of drm_device:
  - Only the current owner (drm_master in current drm code, but should
    probably rename that to drm_owner) is allowed to use the accel driver.
    So all ioctl would fail if you're not drm_master.
  - On dropmaster/file close we'd revoke as much as possible, e.g.
    in-flight commands, mmaps, anything really that can be revoked.
  - For non-revokable things like these dma-buf we'd keep a drm_master
    reference around. This would prevent the next open to acquire
    ownership rights, which at least prevents all the nasty potential
    problems.
  - admin (or well container orchestrator) then has responsibility to
    shoot down all process until the problem goes away (i.e. until you hit
    the one with the rdma MR which keeps the dma-buf alive)

- Not sure there's another reasonable way to do this without inviting some
  problems once we get outside of the "single kernel instance per tenant"
  use-case.

Wrt implementation there's the trouble of this reinventing a bunch of drm
stuff and concepts, but that's maybe for after we've figured out
semantics.

Also would be great if you have a pull request for the userspace runtime
that shows a bit how this all gets used and tied together. Or maybe some
pointers, since I guess retconning a PR in github is maybe a bit much.

Cheers, Daniel

> 
> Thanks,
> Oded
> 
> Oded Gabbay (1):
>   habanalabs: define uAPI to export FD for DMA-BUF
> 
> Tomer Tayar (1):
>   habanalabs: add support for dma-buf exporter
> 
>  drivers/misc/habanalabs/Kconfig             |   1 +
>  drivers/misc/habanalabs/common/habanalabs.h |  22 +
>  drivers/misc/habanalabs/common/memory.c     | 522 +++++++++++++++++++-
>  drivers/misc/habanalabs/gaudi/gaudi.c       |   1 +
>  drivers/misc/habanalabs/goya/goya.c         |   1 +
>  include/uapi/misc/habanalabs.h              |  28 +-
>  6 files changed, 570 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
