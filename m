Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC0C228B8A
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 23:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgGUVmm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 17:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbgGUVmm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 17:42:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F017AC0619DB;
        Tue, 21 Jul 2020 14:42:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ga4so2864ejb.11;
        Tue, 21 Jul 2020 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dyi1MVLFGf/8/KPaE1swyyeNErOrv2bGUWjTcVj8gxM=;
        b=vfHhkUH7uUqVuea2i7a2v8nm3GlQGvrejsVXk1dY+oTV5cGgIufTlcUh4U03yDRrO3
         3ZXPq4Kz7VxluI/vXrEjn4UOxXyeDw18jZS0yQLfsEyCCAiuGS09yjqLzQvJBo0gJjzD
         o9IFYUnweCqxm0XNV81CpeVFmCF1svsGMBkarpkK70EJKgJ1ohZtqMuFAyeMgNrM6j8L
         MY+Xde+v4jUiVgl27SGT20e/o7328q9sF+n94T5QfWFwKyoHltzu6agpEi5hm1pXHnph
         vAUoYRh2zp5yOEmbJdevHeUN0BLFZQLxBK1amF/HNbgoFB/AnU6n3ixeTu2aYpGx1bbJ
         scIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dyi1MVLFGf/8/KPaE1swyyeNErOrv2bGUWjTcVj8gxM=;
        b=ghvNLM8t/FBtnlEstWsHby1urjV87BTriviTS0HtSU9wXl9VIyLw1yrWpBzAKC7r+Y
         N4yPsp0o5nehC6h83hxMTE/E9pxOp+TF08/wJdDnE/R4b6Oci6PFlKCOETgNsJeoeIQi
         GxiJEZ1h1TJF9HtOF1rfji+UR/hy2J6zdkH+CKw/7b9py+Cg9Q0nHyDg2+SK4eOjfvHN
         7EpOGlqheiywUmSgc44nPOSgggNdU1YiTIayNBkg2JoXSlwry2X9YVxVireu0W5ATBBW
         Ivc1OjRCt8QuEAJxd9bFHF6PIXwaobVlV8LYsC3mKjvgPXKTcWSQ64v1eVZiqCBvosIt
         vQww==
X-Gm-Message-State: AOAM532Fa0YsQ1BJWSeMTIR8tmfhXto+j8CrP6KnxrIc1uvUMTMf1SUX
        yVWkSFnT3yqw4vsmDsz4OpH1CkdivxjnAyIO3u8=
X-Google-Smtp-Source: ABdhPJwxE240DtGwFEuhHkKMPvfhlukuGNteVSI0paUJJOmdu+Jb46VZVXI0n2iDUJjFfIzHzYH2PLSYSUaSvNNdruQ=
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr26295104ejb.317.1595367760653;
 Tue, 21 Jul 2020 14:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch> <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local> <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org> <2ca2c004-1e11-87f5-4bd8-761e1b44d21f@amd.com>
 <74727f17-b3a5-ca12-6db6-e47543797b72@shipmail.org> <CAKMK7uFfMi5M5EkCeG6=tjuDANH4=gDLnFpxCYU-E-xyrxwYUg@mail.gmail.com>
 <ae4e4188-39e6-ec41-c11d-91e9211b4d3a@shipmail.org> <f8f73b9f-ce8d-ea02-7caa-d50b75b72809@amd.com>
In-Reply-To: <f8f73b9f-ce8d-ea02-7caa-d50b75b72809@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 22 Jul 2020 07:42:28 +1000
Message-ID: <CAPM=9tw7CBu7zm-N5JpjK_P49Td1E9REbBn=1KrK2nAVuX=xxg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>
> >> That's also why I'm not positive on the "no hw preemption, only
> >> scheduler" case: You still have a dma_fence for the batch itself,
> >> which means still no userspace controlled synchronization or other
> >> form of indefinite batches allowed. So not getting us any closer to
> >> enabling the compute use cases people want.
>
> What compute use case are you talking about? I'm only aware about the
> wait before signal case from Vulkan, the page fault case and the KFD
> preemption fence case.

So slight aside, but it does appear as if Intel's Level 0 API exposes
some of the same problems as vulkan.

They have fences:
"A fence cannot be shared across processes."

They have events (userspace fences) like Vulkan but specify:
"Signaled from the host, and waited upon from within a device=E2=80=99s com=
mand list."

"There are no protections against events causing deadlocks, such as
circular waits scenarios.

These problems are left to the application to avoid."

https://spec.oneapi.com/level-zero/latest/core/PROG.html#synchronization-pr=
imitives

Dave.
