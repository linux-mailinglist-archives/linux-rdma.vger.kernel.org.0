Return-Path: <linux-rdma+bounces-868-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F78E84714C
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 14:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21D3B21C8D
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8046B9B;
	Fri,  2 Feb 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkPKUEK/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E4210FE;
	Fri,  2 Feb 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881160; cv=none; b=o1wEbZwoGI0TQmiUjrJ83iIf7iZ6nF9E51Rbs0Zcd19oRx1YTzMQwaEeOZ2gDwckvSnChJ8T+i2sLbWvWuOQ2yM2C6gX/CV9UQimaWmEpGj/ey18mpgpgCy4u0HKuJ/n+rk2DQjixsUL0iUuKFU3gkiRYks8sf6nYS0GS/MmIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881160; c=relaxed/simple;
	bh=jAZS6kQqC7iWRNRHd05hlbPihlq3lcnIBzvwAd+MfLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP884BZ/8R3qSFPpZLwHuBpnA2lii3jnIfHTSNAQkGIujJIvoT3d9jEIohswNWLi4VHJm4s/1lGyi0nHvU2RB2qSw4mrMVfZdnytp3dX8YFOHcZDNCjUbu8CQ5YJAV+rvNTaWmfsGhxyDX/XD9o/JGF77k5CPzPGRWt/rUvFJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkPKUEK/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7354ba334so18008945ad.1;
        Fri, 02 Feb 2024 05:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706881159; x=1707485959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YBhDobq9w/DAQfNUSCc6FsdphQ197GjWcooXtvaTzM0=;
        b=EkPKUEK/Am3QxorhJDHGhkzQkhqJ/nXjSORQU+6w74LA8Odgs52cFjilyCAVHmUH0B
         IwQaQwHhTyDRLOChmYWCQBHUuSs5KLrC7AVr6NaRsuYZxZ9gWqnFpyMl+T6tU/RoPjZm
         vWXpqIY6BxMs+jnkvmBhiiifUTaaNRMOWOVLPf7sRwMcx2q1buBat/G5HZmx6d9/Y2zB
         X0T5090bFxOnAt57rbTryeeUVtk+ATHyW0MvtD3qDgKpAcWwBRYv+olwRZyoVZiGFuZf
         ENgDC9NvehYbDECPXJAC8/a2WxKxAC+45mat5PdOdUvCYT4UYgvs4v5z1iggQm0tFd6Z
         7Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706881159; x=1707485959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBhDobq9w/DAQfNUSCc6FsdphQ197GjWcooXtvaTzM0=;
        b=Zg5JId6SgJ8Ah5HjnV8m/5PBxsezw7jbE4Y2OMdiDrN29EYaqEd9MgqN/dI7s9NdkI
         bZm/IyhZPH0/jkYY/s954b1G/YjyBqjReNNLUsUCXejQVLJtStiL56WmjKLWTg/iMRtL
         AxEIzjGepbRSwjHP1HGOtEy97XlSs/itXe9FACNOAGRDECDhDPYuCvOGrQF38c/8D32/
         AbRfgZin7tL9CQilfkgcKv9guEFER84M377DkjFnDQep39+uSEW9JshMqubz89cCyu69
         5btJY+xbHEKlHlmY9cPPD5EXLP9pUjr3onWOUA4uLe5ZRlH9YZuwxY0m11kZeg4gTyeW
         8nbw==
X-Gm-Message-State: AOJu0YynaO1h3JAMJILFRY3w72Dw9a/96o7PaTYGl5WW5iDP20HBn6qa
	P92NWdE0VevqMLh1r5fGG3f+Ph0p0Xw20RhLs/blHRES2FV69Yie
X-Google-Smtp-Source: AGHT+IFVLX293B7sI5qgfo1DA7afu/pZSCek1vgU1NT6b+uUAZ4XDMVBNMCyipcfSN/NHGqidzcOsQ==
X-Received: by 2002:a17:902:e548:b0:1d8:d56e:5dee with SMTP id n8-20020a170902e54800b001d8d56e5deemr11059423plf.1.1706881158766;
        Fri, 02 Feb 2024 05:39:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUh9yCMNH0gDFH9awgcYOWNYBe8pMhV21EndijaIectbLofwMp4+h8gAr7Ktd+qxv2HYRJhLIUEhnyNzJGGP9BYRu+ivJHdoGfcHt/bGBbFvy1jf7so1Al5rcIxiz/RuSJkpTY0wflHUXuTBPHbcirLIHNwCrm4PjS4fEv8vmRVWqY7jmfF5EUIMf8Pp8pS0TIsXqd8PcZh83sUMpjED/QxwAdF9ge5USB7HrXr5Tto76V6zH13mflLcf7PQT/KwAG/dm2t3B4mtPwJl4foVmtzTayCKFat+l+/nK9rHYkz1IdZT79tU2zQ400=
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001d70c6d40f3sm1589059plb.237.2024.02.02.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:39:17 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 72512180F4986; Fri,  2 Feb 2024 20:39:14 +0700 (WIB)
Date: Fri, 2 Feb 2024 20:39:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: =?utf-8?Q?Micha=C5=82?= Jakubowski <kajanos@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux RDMA <linux-rdma@vger.kernel.org>, shravankr@nvidia.com
Subject: Re: Kernel - 6.7.3 - failed to compile the module
Message-ID: <ZbzwgtGUHK2Dj5eo@archie.me>
References: <CAHOGJipx37tUoiSp87Np4b0qzREj60+FEkdi_0X0_JoQW8cYeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2H0O5bwuegTRqnJ6"
Content-Disposition: inline
In-Reply-To: <CAHOGJipx37tUoiSp87Np4b0qzREj60+FEkdi_0X0_JoQW8cYeA@mail.gmail.com>


--2H0O5bwuegTRqnJ6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[also Cc: mellanox maintainers]

On Fri, Feb 02, 2024 at 08:55:47AM +0100, Micha=C5=82 Jakubowski wrote:
> Regarding: https://bugzilla.kernel.org/show_bug.cgi?id=3D218445
>=20
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp1_execut=
ion.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp1_transi=
tion.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp2_execut=
ion.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp2_transi=
tion.o
>   LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
>   MODPOST Module.symvers
> ERROR: modpost: "sched_numa_hop_mask"
> [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[1]: *** [/usr/src/linux-6.7.3-gentoo/Makefile:1863: modpost] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

Do you have above build failure on vanilla v6.7.3? Can you also check curre=
nt
mainline (v6.8-rc2)?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--2H0O5bwuegTRqnJ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZbzwfQAKCRD2uYlJVVFO
o3D4AP9Wwb4ESi2Hud4/VUMqMIWi4ansSXjFCnt3x3PPkFnELQD/c2QSp3GXg/rp
92nKuhBsW+IcC76ebRltiEJYlORgwg4=
=No5w
-----END PGP SIGNATURE-----

--2H0O5bwuegTRqnJ6--

