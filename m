Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7E228C29
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 00:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGUWqG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 18:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGUWqG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 18:46:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20CC061794;
        Tue, 21 Jul 2020 15:46:06 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rk21so178841ejb.2;
        Tue, 21 Jul 2020 15:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9xr1v2W2JnKVVLyTRtwOt/n6iJhD2D3A0fwqKMz4hPs=;
        b=rEZAPXIor3Dz4RHCbGWSYP7bPSEIjpr4PFXwS2Im8j4mhj6ape6iAKrEuKt9/16wJb
         lZpHG0XlEaVhnsqWhDvwzZnhbH2qGMHiCuDZM7WS0KrrZjv8jJcsCna7l+z6N03RSryI
         U8/GUuaiXjjM2Legmhg4UW/y2nxUfiL9rhNEEIH/m+ikMiguNIXPzWp5FcJ8lZyev8PT
         WLWiiHIj1Ebcit0XN21uV4r+cIGcJsECcR3QBWCPN5odx48VmqH3GUnoXIOIUIHYK2TF
         yOJJ06VoDsthqoqZ7vPs3+DXb1cqJV++ZhwSCJu2JFkx6/PDQzDmpkrcwLU4TMBFOJQB
         RSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9xr1v2W2JnKVVLyTRtwOt/n6iJhD2D3A0fwqKMz4hPs=;
        b=epfBJ9O2DLqqEfuQNBC87h1QCObo16TlqRIxc1nQM2gnUjbY8uVJfUtSJtAGU3IGBX
         HAgt+7bzhrS26yCVri0WPR6kMZFAT10FGI11Lwuw3a0GaYmxcCHA8qbCjw9Lw/CIYDOt
         TIqBg5oKowGA4Mg6Lrs/E3gThlS+6RUdsrn5ym/VCivnLxU+Hk7pVEI01Rg1EegNZc/I
         eXVbM4yL9p7MyAqnU7l06AIOfRfYDChiWVp5FiRbYe6xu5CkLmJUhP5/XXX275AZf9l2
         FTOC4wla/K18gjwVGmAQXQv+oTJr5wYAWbI66jz5JrVOgS1/j6ZGIc3ITUaUkq6CvmDU
         D6YQ==
X-Gm-Message-State: AOAM5333wGPItnbpDDIxYyX381r5aMK7d4NT+r78khr4dwEfWw5xXw0R
        gnza/XqLvhD/OnU0c8Ind28dRViB8Gs7ENow/8w=
X-Google-Smtp-Source: ABdhPJwZ3Ot7QKWc1rFSm9ERPUfpZAjcJpv8FnDDuXOOnkUxeoTuK9PsCTyGH0MloHa+IJHrTWbjlRTbPgJrqaOl/nY=
X-Received: by 2002:a17:906:4086:: with SMTP id u6mr3259703ejj.9.1595371564794;
 Tue, 21 Jul 2020 15:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch> <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local> <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
In-Reply-To: <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 22 Jul 2020 08:45:53 +1000
Message-ID: <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 21 Jul 2020 at 18:47, Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
>
>
> On 7/21/20 9:45 AM, Christian K=C3=B6nig wrote:
> > Am 21.07.20 um 09:41 schrieb Daniel Vetter:
> >> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellstr=C3=B6m (Intel=
)
> >> wrote:
> >>> Hi,
> >>>
> >>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
> >>>> Comes up every few years, gets somewhat tedious to discuss, let's
> >>>> write this down once and for all.
> >>>>
> >>>> What I'm not sure about is whether the text should be more explicit =
in
> >>>> flat out mandating the amdkfd eviction fences for long running compu=
te
> >>>> workloads or workloads where userspace fencing is allowed.
> >>> Although (in my humble opinion) it might be possible to completely
> >>> untangle
> >>> kernel-introduced fences for resource management and dma-fences used
> >>> for
> >>> completion- and dependency tracking and lift a lot of restrictions
> >>> for the
> >>> dma-fences, including prohibiting infinite ones, I think this makes
> >>> sense
> >>> describing the current state.
> >> Yeah I think a future patch needs to type up how we want to make that
> >> happen (for some cross driver consistency) and what needs to be
> >> considered. Some of the necessary parts are already there (with like t=
he
> >> preemption fences amdkfd has as an example), but I think some clear do=
cs
> >> on what's required from both hw, drivers and userspace would be really
> >> good.
> >
> > I'm currently writing that up, but probably still need a few days for
> > this.
>
> Great! I put down some (very) initial thoughts a couple of weeks ago
> building on eviction fences for various hardware complexity levels here:
>
> https://gitlab.freedesktop.org/thomash/docs/-/blob/master/Untangling%20dm=
a-fence%20and%20memory%20allocation.odt

We are seeing HW that has recoverable GPU page faults but only for
compute tasks, and scheduler without semaphores hw for graphics.

So a single driver may have to expose both models to userspace and
also introduces the problem of how to interoperate between the two
models on one card.

Dave.
