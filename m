Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F406023275F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 00:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgG2WKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 18:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WKy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 18:10:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC8DC061794;
        Wed, 29 Jul 2020 15:10:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so4016561wmj.5;
        Wed, 29 Jul 2020 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VRmXX22Ht9Ug7pe7RoctKCZnQAxX1VH0Ou5Q8SMIejk=;
        b=Xt2cZ1tWt2tIeIk0lGFPYBvi2AJQmiptaxJ/IrqrJHsJP0XcurZ7xsprx89qWRSeas
         euW6FnIpxp07vyK+XaFIVryYYhIAN1YBPz3zm3lqJADQ5omnUDX0NP6grbTBUtPnhsdF
         J3TU+Tk7qY+yTiPGhkvo5ja7npziNhpk/3uANV7RSJ0qhUSFxcZcaFPS9YVbbb3ZWKzz
         kC+nHw97kt9XnnF0enP57i1SXtmprwiM9sDxXIHlr2UdMmazSH55332PFuAEcA8lGpD2
         HUsRWoWlUt/ckjME1OdX86A+vCEj4oTXxTKGCUYxq/u3kAikEIkm045zrIeEm5tnz0pe
         lZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VRmXX22Ht9Ug7pe7RoctKCZnQAxX1VH0Ou5Q8SMIejk=;
        b=tit934V84zYlMimy2FfkTSPgm0mZRhMDeCgr17dNYH92hb4/Z0vzngh/ztHLiolRIZ
         rPqo9GfCZjfiEeN3ijINl9EtGALT+OdVOaADJq44BBT/C3BkeN4mGQiglp25OU4gKxkZ
         7NcaFkG0QQhLzc6uT2XzINXPbEwxw9e5WBM5fgwhgrxo9ywR8CaqdnYHoQ6L0yUlGjZ4
         uSD3NwWAKtn/7Ctu++oH3uFruUsJPi9dGh6t10LkRV3mSHVkAMqxk7LhrfSBfCs5J8P3
         tZV9UCJ2PB2C1erGl7y1PC1pnCIpyipicI4pjotnpS9u/PDREUvzVxu50q9SxUwY4YHj
         ZWrQ==
X-Gm-Message-State: AOAM533nhKBdeVbRUJYD00H/+gNwRv3jexFr3Ilby2HtbqKe1Eban3pi
        GKZC0ySVdn6pzXFRqteIvsm33TA905Skr5JD2MM=
X-Google-Smtp-Source: ABdhPJy8ks1gVFBsd4+PvZ7RcVx+rmeF3fW3P6eru07cUIBqON0J65m9pkCTSrgJ1mggZhfdeqSwdUdDfuQuzzSeZtw=
X-Received: by 2002:a1c:2:: with SMTP id 2mr10843270wma.79.1596060652954; Wed,
 29 Jul 2020 15:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200727213017.852589-1-daniel.vetter@ffwll.ch> <d4e687e9-cf0b-384f-5982-849d0fa11147@amd.com>
In-Reply-To: <d4e687e9-cf0b-384f-5982-849d0fa11147@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Jul 2020 18:10:42 -0400
Message-ID: <CADnq5_OdpSD3xRufctNedeiehiA80XcN1YOA7d58nMFcrp8vhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: Stop dma_resv_lock inversion in commit_tail
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Jul 28, 2020 at 2:56 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 27.07.20 um 23:30 schrieb Daniel Vetter:
> > Trying to grab dma_resv_lock while in commit_tail before we've done
> > all the code that leads to the eventual signalling of the vblank event
> > (which can be a dma_fence) is deadlock-y. Don't do that.
> >
> > Here the solution is easy because just grabbing locks to read
> > something races anyway. We don't need to bother, READ_ONCE is
> > equivalent. And avoids the locking issue.
> >
> > v2: Also take into account tmz_surface boolean, plus just delete the
> > old code.
> >
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> > DC-folks, I think this split out patch from my series here
> >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.kernel.org%2Fdri-devel%2F20200707201229.472834-1-daniel.vetter%40ffwll.ch=
%2F&amp;data=3D02%7C01%7Cchristian.koenig%40amd.com%7C8a4f5736682a4b5c943e0=
8d832747ab1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637314823145521840=
&amp;sdata=3Dqd7Nrox62Lr%2FXWbJJFVskg9RYL4%2FoRVCFjR6rUDMA5E%3D&amp;reserve=
d=3D0
> >
> > should be ready for review/merging. I fixed it up a bit so that it's no=
t
> > just a gross hack :-)
> >
> > Cheers, Daniel
> >
> >
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++------------=
-
> >   1 file changed, 6 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 21ec64fe5527..a20b62b1f2ef 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -6959,20 +6959,13 @@ static void amdgpu_dm_commit_planes(struct drm_=
atomic_state *state,
> >                       DRM_ERROR("Waiting for fences timed out!");
> >
> >               /*
> > -              * TODO This might fail and hence better not used, wait
> > -              * explicitly on fences instead
> > -              * and in general should be called for
> > -              * blocking commit to as per framework helpers
> > +              * We cannot reserve buffers here, which means the normal=
 flag
> > +              * access functions don't work. Paper over this with READ=
_ONCE,
> > +              * but maybe the flags are invariant enough that not even=
 that
> > +              * would be needed.
> >                */
> > -             r =3D amdgpu_bo_reserve(abo, true);
> > -             if (unlikely(r !=3D 0))
> > -                     DRM_ERROR("failed to reserve buffer before flip\n=
");
> > -
> > -             amdgpu_bo_get_tiling_flags(abo, &tiling_flags);
> > -
> > -             tmz_surface =3D amdgpu_bo_encrypted(abo);
> > -
> > -             amdgpu_bo_unreserve(abo);
> > +             tiling_flags =3D READ_ONCE(abo->tiling_flags);
> > +             tmz_surface =3D READ_ONCE(abo->flags) & AMDGPU_GEM_CREATE=
_ENCRYPTED;
>
> Yeah, the abo->flags are mostly fixed after creation, especially the
> encrypted flag can't change or we corrupt page table tables. So that
> should work fine.
>
> Anybody who picks this up feel free to add an Reviewed-by: Christian
> K=C3=B6nig <christian.koenig@amd.com>.
>
> Regards,
> Christian.
>
> >
> >               fill_dc_plane_info_and_addr(
> >                       dm->adev, new_plane_state, tiling_flags,
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
