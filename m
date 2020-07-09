Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C03219A18
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgGIHg4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 03:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgGIHg4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 03:36:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2619C08C5CE
        for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2020 00:36:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so1216789wrp.7
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2020 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKtQly4ao6B6nwRWEDkHlPwVhDZwmTFzlBzK230IGUs=;
        b=q1a8xJM/Q9Wj785BtNlEuDFVR1eQk54JebnUrlGorLvEHVMtqdFOuaGKrTYCsphJ1h
         jdn7d6bEOoYqm6Dc8k5LjNzJMPs7sqOYl93W/0yr7CIrm1h2/Lv3g+fhNpsEY21yKMZh
         ju/lEovQ160zqDVi53k34kcqcJLZdTHFacxSS0a8W4cpfdDptcuxHSPlubyxOMMuaSBC
         zAyYruzxGOJbmMUqmjN2Chf/XWhBZgAcu1tmI7ShCPPddj04M/M8Yf8LAduuKxgJQlTV
         rIzd0KYtUf5G7qRV/73bX9CHJ9uhQaanPFGitTqRJCgzv1EMfeBg/7UHJHVTRmYqPihB
         A8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKtQly4ao6B6nwRWEDkHlPwVhDZwmTFzlBzK230IGUs=;
        b=CaSPvT6cPOl7vsy0mjW+VbQKpXQGo7GKy16cGKrslpaZrSXzpmaXOV2GcdHlSmhfEs
         0If9caun9pwvrc+RLVx2WFnwVtJDlPCAgTPfEc/U8EA4uWAi3Tm1kDD0iUUyZPcVuab6
         LhWhEwBP/9plVvfdr1hJ86/fh45bcWuCfjm/C37kvfvo3UuNFb7n3381Uh1BxeJ5xBlp
         aPDmnQXDAH6maixTfBrWTXV1/rL24Kp2KDKTSZTHELk8DxLZcKXOfAL5/BpCoFBYRfV8
         TP9fRRy50d5E/OEN0tOAkeQdOh2yK2VNZM93KrQpCai5eTWkRXgNNmeyMgCwBG7gFacW
         V4aw==
X-Gm-Message-State: AOAM532UF6w/kUuB9yLzPew6twQPXpOM/7zy2cLEVMbWF6hEly50dDsO
        PH4NekKdYsuBvBmYuX8PtnCtSZaBkccNDSA5eKc5kQ==
X-Google-Smtp-Source: ABdhPJwOIE8GoaZZk1aSRinMLKGhWIbTpQIZ0IBDLoLaRN5k6dzJvrX8BOXeDjMLQXA3ybdstuq5y6Y6MSCOm3lN/7s=
X-Received: by 2002:adf:f9c8:: with SMTP id w8mr60764235wrr.354.1594280214366;
 Thu, 09 Jul 2020 00:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch> <20200707201229.472834-4-daniel.vetter@ffwll.ch>
In-Reply-To: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 9 Jul 2020 08:36:43 +0100
Message-ID: <CAPj87rO4mm-+sQbP07cgM8-=b6Q8Jbh5G0FsV8rwYx2hnEzPkA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/25] dma-buf.rst: Document why idenfinite
 fences are a bad idea
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        Jesse Natalie <jenatali@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On Tue, 7 Jul 2020 at 21:13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Comes up every few years, gets somewhat tedious to discuss, let's
> write this down once and for all.

Thanks for writing this up! I wonder if any of the notes from my reply
to the previous-version thread would be helpful to more explicitly
encode the carrot of dma-fence's positive guarantees, rather than just
the stick of 'don't do this'. ;) Either way, this is:
Acked-by: Daniel Stone <daniels@collabora.com>

> What I'm not sure about is whether the text should be more explicit in
> flat out mandating the amdkfd eviction fences for long running compute
> workloads or workloads where userspace fencing is allowed.

... or whether we just say that you can never use dma-fence in
conjunction with userptr.

Cheers,
Daniel
