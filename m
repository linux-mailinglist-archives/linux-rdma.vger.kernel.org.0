Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A021E16D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2020 22:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgGMUba (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jul 2020 16:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGMUba (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jul 2020 16:31:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF0EC061755;
        Mon, 13 Jul 2020 13:31:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a8so14935182edy.1;
        Mon, 13 Jul 2020 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HnzQkPBt2OC+k9du8OZiIZUdaNF8CWZvobQFWZtz7PY=;
        b=nL2QSyRF4VdhkxgtyvoDIeRb4RfXopS6tkMpm+IFtrPuzigJardjBCFktXQ//PRpIJ
         bqFBi+hg+kUy5bDekzDKXUyylgLe3CHHJG2ppWdO/NS+ljwhP3heCpJdh4lk2NnMEUfU
         ddiMB88lFu0EW/lhkvLbxvu1bX74yl9SAZxy9VD+XJIZZm5g3+WyjM+H36R+72nSUcMz
         hc2JzL2X+Qo8w0sxB69fJLfnqx/NUH8RQtLqZrOAgD/3Ui26wZjCVvHKl4TO8elowm48
         XFQilIER6Vwww/OgWOMYlYRXQ6cLge8urHT9+cBR2T8i9MGj0F5ZMoR7SyOYMpB3H1Yz
         A2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HnzQkPBt2OC+k9du8OZiIZUdaNF8CWZvobQFWZtz7PY=;
        b=Dz1OJ05n5mzrMrjK//4F37WOfR+xnP9VVkmwug7Ah4ChIqvpCo/uWflmg3KdbhXGdw
         +YO0fFEpVMkQtRy3BmhnkvMNYGLNALVtK4lml17zx6YeJzn+yAVKTmVLu9fNLlOC22t3
         yG/yjNQbhww+TCCIRAl0hD8hfEgD+X6tuyLT9ImqvYJAXTu8maCHXCcF7MKIHNa1Nu5J
         87e6PXRVGGQGVw4ZanDbEINtMpFBkHmISW5recf1o1mhtWk/E5E7VTIqxdYVrWe6yGaM
         jrnVo+WIfbVpIrA7y1DCv/bUVGPR3gyyqiGWQ5F6E0Me6SIWf6tVZVtyOkKRoPoQ/9yn
         eglA==
X-Gm-Message-State: AOAM533XnyWY+2NaUfrwUQY8AVEq1qCSyZygTvz5kf1ki3MfR8CKxvdY
        rbTPJkrPuiOFznIIJtR8+UFixBakO3DjCxFkkCU=
X-Google-Smtp-Source: ABdhPJxPAYikRaQY/XMVDWezfOW6Iwk/c5G8BcDCGjjzvlG6bojjnVvJlH11+w5rhFd3jK7dVcdAJfhqlzC5TvPI8KA=
X-Received: by 2002:a50:ee8a:: with SMTP id f10mr1094484edr.383.1594672287315;
 Mon, 13 Jul 2020 13:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-2-daniel.vetter@ffwll.ch> <20c0a95b-8367-4f26-d058-1cb265255283@amd.com>
 <20200713162610.GS3278063@phenom.ffwll.local> <e9e838fb-ec83-f7e0-e978-b57d8892b3f0@amd.com>
In-Reply-To: <e9e838fb-ec83-f7e0-e978-b57d8892b3f0@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 14 Jul 2020 06:31:15 +1000
Message-ID: <CAPM=9tyTd0OqtdX+pGhGm3K1odNkG5EEL+0DZwL=NiVkogOujQ@mail.gmail.com>
Subject: Re: [PATCH 01/25] dma-fence: basic lockdep annotations
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, linux-rdma@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@intel.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 14 Jul 2020 at 02:39, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 13.07.20 um 18:26 schrieb Daniel Vetter:
> > Hi Christian,
> >
> > On Wed, Jul 08, 2020 at 04:57:21PM +0200, Christian K=C3=B6nig wrote:
> >> Could we merge this controlled by a separate config option?
> >>
> >> This way we could have the checks upstream without having to fix all t=
he
> >> stuff before we do this?
> > Discussions died out a bit, do you consider this a blocker for the firs=
t
> > two patches, or good for an ack on these?
>
> Yes, I think the first two can be merged without causing any pain. Feel
> free to add my ab on them.
>
> And the third one can go in immediately as well.

Acked-by: Dave Airlie <airlied@redhat.com> for the first 2 +
indefinite explains.

Dave.
