Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFAE21CBD5
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2020 00:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGLW1V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jul 2020 18:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGLW1U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jul 2020 18:27:20 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5AC061794;
        Sun, 12 Jul 2020 15:27:20 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w27so8615409qtb.7;
        Sun, 12 Jul 2020 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WS4czs1S7z/S4i1CeSrQi39XH87K6UhLeLrvORLLGds=;
        b=bv2MpgsaTGH2o45aR1J0SJ7DwGg+Ovy7LF253JrxTHMYLlEfhgFhgVh2dQTvBpi2fN
         1Lywsn9gbR8KPmplzbe+wQjpC32bGsnBzua2XhmGBGkFrHsxPVPO6HI6omyo4Z+XVMKQ
         pwmTFM/5N1GwRsTiF661tb19+zIGI73c8VEhHwNyGVSIjS30JdEb6s4dqFbtryabzK1l
         gzilnNQCK1yaAt1K94d5zvD7UehrWgno8GzjkYh9oxlJSPFjllbRqJmqCGEEYCH07ps4
         qkgUssUzPKYaM0MlDf30AKFcuW6p9RjQ0yh1fAMNVCaTys+BcvbUnS6hwOuYs9+oU0vd
         I0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WS4czs1S7z/S4i1CeSrQi39XH87K6UhLeLrvORLLGds=;
        b=Z4g14TFGh8/GbzdoQln5SVqh3a9xcuPco0wkjEAH/09zIHcIzvsWp6GDydsFIG5ort
         TJ3qwbbpKM6tJ6YMqbKOTi2imM6VGDrEhSZtODYF1mTo39QHNDSuS4Etk5BCtOIRf6IQ
         aAHBRM5w81F0DN44vwdzSU288JMSf+vYNnmSmg0rkaU9nlLtQlhCFL287DzZBYeaV8Is
         Rgfo49lWwwoc1Id2CJVNMdzCAh0iuhYPzmwzC1k9gAQKkYfMANlQxJUMDnKqjpA/6JCJ
         m2uvKO/WtgEhmVC83Q90CSiVemVmBJB/NMASWFAeH1OeMJ+LOXeh51fmXqWZZp+FhZUi
         L+7g==
X-Gm-Message-State: AOAM532v35WZsbx6fanCF/j3yw1OuUrUcXYbeuOjH47QDdcRV7/KxuCD
        1z7n/M/KSm6roH2Ft5AxXlnILg61C4w=
X-Google-Smtp-Source: ABdhPJy52PZBv0zWblkDW5dp8wKcBJnMAwMVHXh05rklPXhNddZJ2Qs404D1UqB3Upk5t7kdYVRiNw==
X-Received: by 2002:ac8:5691:: with SMTP id h17mr80166131qta.35.1594592839889;
        Sun, 12 Jul 2020 15:27:19 -0700 (PDT)
Received: from smtp.gmail.com ([2607:fea8:56a0:8440::b10e])
        by smtp.gmail.com with ESMTPSA id e203sm16257002qkb.87.2020.07.12.15.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 15:27:19 -0700 (PDT)
Date:   Sun, 12 Jul 2020 18:27:16 -0400
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Melissa Wen <melissa.srw@gmail.com>,
        Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH 04/25] drm/vkms: Annotate vblank timer
Message-ID: <20200712222716.4rhvj7hryiecjthv@smtp.gmail.com>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-5-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s3o5eamueeyjdnal"
Content-Disposition: inline
In-Reply-To: <20200707201229.472834-5-daniel.vetter@ffwll.ch>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--s3o5eamueeyjdnal
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Everything looks fine to me, I just noticed that the amdgpu patches did
not apply smoothly, however it was trivial to fix the issues.

Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Melissa,
Since you are using vkms regularly, could you test this patch and review
it? Remember to add your Tested-by when you finish.

Thanks

On 07/07, Daniel Vetter wrote:
> This is needed to signal the fences from page flips, annotate it
> accordingly. We need to annotate entire timer callback since if we get
> stuck anywhere in there, then the timer stops, and hence fences stop.
> Just annotating the top part that does the vblank handling isn't
> enough.
>=20
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms=
_crtc.c
> index ac85e17428f8..a53a40848a72 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
> =20
> +#include <linux/dma-fence.h>
> +
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_probe_helper.h>
> @@ -14,7 +16,9 @@ static enum hrtimer_restart vkms_vblank_simulate(struct=
 hrtimer *timer)
>  	struct drm_crtc *crtc =3D &output->crtc;
>  	struct vkms_crtc_state *state;
>  	u64 ret_overrun;
> -	bool ret;
> +	bool ret, fence_cookie;
> +
> +	fence_cookie =3D dma_fence_begin_signalling();
> =20
>  	ret_overrun =3D hrtimer_forward_now(&output->vblank_hrtimer,
>  					  output->period_ns);
> @@ -49,6 +53,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct=
 hrtimer *timer)
>  			DRM_DEBUG_DRIVER("Composer worker already queued\n");
>  	}
> =20
> +	dma_fence_end_signalling(fence_cookie);
> +
>  	return HRTIMER_RESTART;
>  }
> =20
> --=20
> 2.27.0
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--s3o5eamueeyjdnal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl8LjjsACgkQWJzP/com
vP/qCQ//VX54bTnpR0wsE6qMjBDXqGJZtsOc04CystIQ37mW+onGPy7yyfYy/YUQ
5gQ4ZfyflcnwHTZZrBciXCxvtSmFucki/3EqHkzZcQ9f4Z6/NRVQrwZea6Ff2B7r
5Ob9tL4NBU4+TDaGJ3szQ89NY87cEDx4lfR5oM3y/Oo2kSk5dl5wvEmnwmu/Tizv
goVPRu8hsRgZtNImREh9mdGtF340jkn4osozLGd5fm9MtcL8U4IeWGtcOlFB2iYQ
meLWRuepZaf1yYJrZ/4wtYWtr+b6/Vpvp+vXLuZOIzhpRqt9FItweQDaY3kPFqWf
Cw1WbDrbx/6er3Up5JfN3+Stvsf0/5Ar62GGlng/dHiz5dcV/OA5Ybfgs9WryiKb
JbgdJ1619CmL5BELMk3+Yp8Ldwo+rQYdoyBx0yLYOK4jXjYYCsZOZtB9FZOSnr0r
2oFVObJ6ZZ5XTdiFa6/wioCuES/HDAWabIJofZByTtf6MTN3HLSnqvaJBmCKsz67
469KEtuiPTRbFIqdyy4I0OH8sXfG+3El8oNbZsYn5iaYyInX7kUngimK0J8FsgL/
AIMS9rVcessTIiRrMoPOj2h10uJzkEtcK4O9+8XaIA8ur/4WAjdvw7qWdLTtp9Jr
Gie0jIZIIJaJ3vYrC4AIeukVVMxOFJvF1YfROSiAfJU/YxZZutE=
=G0js
-----END PGP SIGNATURE-----

--s3o5eamueeyjdnal--
