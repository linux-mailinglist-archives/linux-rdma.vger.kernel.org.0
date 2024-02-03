Return-Path: <linux-rdma+bounces-877-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5EB847FE4
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Feb 2024 04:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492F428813C
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Feb 2024 03:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF5882A;
	Sat,  3 Feb 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER/r5M5r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AAA79F9;
	Sat,  3 Feb 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706930456; cv=none; b=Gv+er1rphhAZGib9E2aakWbWwIDG5xyhSaijA3iAI3tIfbmTgiiYK/eO6QykL9ECSkSB7APNs+E/TTnrl76okoUXh0ftRwS+aMFMxMcZkHlmh7ZFKQjapNY7eKR0zpMeM8wpiw191e+s2P19tP/0Zi1VXK6ycYYRcqWKMDb65xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706930456; c=relaxed/simple;
	bh=hCB8AYgSSbq6DNZj1ZRZk803oP0CfufNdeL7Gko1fYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiLF1aBsoDZmFnsDXTVA3bAoNttG7kX68J0EZWC9HQF4syWttlimV8bgDam70eEXMW9iWTKXIGmI9KRIlqHpGkoDVk06LH+vKbfFST4ni8f/P3zIRGa37auzNGCgBY1ciVy/E7AR6yNGLG/kI7x90YCrzEs14SzAB0i+2q86AJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER/r5M5r; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d7005ea1d0so1046179a12.1;
        Fri, 02 Feb 2024 19:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706930454; x=1707535254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dULR4Q3RpC05Eojzx1RrNDTGijusTCcOzrGWFakXnPU=;
        b=ER/r5M5rjNnlRX3OCRanBb/1/mcG0wYDWEvHL3gUAYqvThnXzbvWHHHt7luaRK0DbE
         +pgA1DhqJAXoqSbaxLPtpjtz9ulBxLSfDDGm7nLJEY9ABjV1sJ3n0eOrC5jXD3VUaqTj
         u5V/y2ASuELRzc6kn4CtkMXV9qy78aIT9y6SEm+lwnUQl1IykLmpYWAkgdEqDE8wr556
         ljptGtWb/5tPPPAANKHlnZU9EOdUDIGmEeZztKSxPcirymXlU8YV9Jz5CwjjOm9paPaz
         G1hR5w9Hr33wHEiFNMSRlVL5k6V6W/vcnUDRzasnIuGUSjM2CHN3wgWdbsbP86lOQV89
         d4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706930454; x=1707535254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dULR4Q3RpC05Eojzx1RrNDTGijusTCcOzrGWFakXnPU=;
        b=B8vOPHRJWcyOKbUmNUHCEzbUgNB86WrRixZQUw49k6OEKKM1u+K2cSkExh33825SYH
         x7D/68cWO9+IRZWQCyYA8YILkfXIr9z9FDqCYCgTWxA9db59j0g3r+VRP6A7AVn5hnYp
         GZLvTSXbCBdD9g5Uq8F2fSu5dbLB97wUb8rrKfeUJu4lZCRjIf643eXbrclmo7NoxLGR
         zHcdc2Li8aRmgieGaIyu/N3wfP70sYaot+8s+H0LagStLFuqhQ8pam3jjT+JKJMpf+6q
         5l3prITzzDSAST5xpfD7XVDMMdz+Hr9LvuffzBg4dydKrqYyRa4hlkPFqlQAaijKbW1t
         j+yA==
X-Gm-Message-State: AOJu0YwpqCreZjjsJehHIm7p2CyRZpbcy/EJqqSXvVMLucVFHnee0xNS
	lE6qk1DVgFkmcn9A54W2xYu8DlwUqIQwxi0spEWjcm14a5NEP/LTDnL8WQygKIY=
X-Google-Smtp-Source: AGHT+IG1QsEB3Ess0MPjp+rbYYo3morcy88EvcGngfo9wfvO1wtdUp0liXYEcSEN991u1sAbDmx1WA==
X-Received: by 2002:a05:6a20:939f:b0:19c:8673:77 with SMTP id x31-20020a056a20939f00b0019c86730077mr750410pzh.2.1706930453977;
        Fri, 02 Feb 2024 19:20:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDZi+nDceimBwN0CAJf6V5HxV+0R2TqggV/ax8ojyjXckgmP6fb+HL9Y14ubHMMJtxWWpKeeKdyj9KDEqn/olPrDYEKU8yd9zPtYXS+b9vQnNvoJKgqAFdze5MqGVkyp/UI6A3UR6LNibZ02xyZ9tHW8HQiykH11XImlD0AI46FCs5vuO9WbmwYs4Rj3re9gmcq9KfGBVWCaOBvGd4FzzSqr/YRjoED3RT/ykPGd52zRi6FRZbvJ2WL9x6vT3eOQwm4FTKkNECJ0cf3QJEq9EOk5OsktIRvHDBT7p0bwR5628+CfpeVepr9H4=
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p13-20020a62ab0d000000b006d977f70cd5sm2370368pff.23.2024.02.02.19.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 19:20:53 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id CBC91183BF657; Sat,  3 Feb 2024 10:20:49 +0700 (WIB)
Date: Sat, 3 Feb 2024 10:20:49 +0700
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
Message-ID: <Zb2xEcMle-TXZwZ9@archie.me>
References: <CAHOGJipx37tUoiSp87Np4b0qzREj60+FEkdi_0X0_JoQW8cYeA@mail.gmail.com>
 <ZbzwgtGUHK2Dj5eo@archie.me>
 <CAHOGJiotQxK7Kdq+MV=bMXku4DehMcWtq1uPeQxf8igEY1Zdxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D1brhLvD4YeQktqi"
Content-Disposition: inline
In-Reply-To: <CAHOGJiotQxK7Kdq+MV=bMXku4DehMcWtq1uPeQxf8igEY1Zdxw@mail.gmail.com>


--D1brhLvD4YeQktqi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[restoring original address list. Please remember to keep it intact
when replying.]

On Fri, Feb 02, 2024 at 03:12:17PM +0100, Micha=C5=82 Jakubowski wrote:
> On vanilla 6.7.3 and git 6.8-rc2 is the same
>=20
>  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp1_executi=
on.o
>  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp1_transit=
ion.o
>  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp2_executi=
on.o
>  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp2_transit=
ion.o
>  LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
>  AR      drivers/gpu/built-in.a
>  AR      drivers/built-in.a
> make[1]: *** [/usr/src/linux-6.8-rc2/Makefile:1921: .] Error 2
> make: *** [Makefile:240: __sub-make] Error 2

Hi Micha=C5=82,

I can't reproduce the build failure on my Arch Linux system (gcc 13.2,
binutils 2.41) with defconfig + CONFIG_MLX5_*. Can you attach full build log
(preferably with V=3D1) and the .config used to bugzilla? And also, what is=
 your
gcc and binutils version?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--D1brhLvD4YeQktqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZb2xDQAKCRD2uYlJVVFO
ozfsAP0YC3oWz/9DAahVxbQos0fQ83zrcquhuNiJPVDlttv+uAD9GqJ+dL58q+DN
RxbZcKMo/rxGfkbuL0mEEiyFgeJPUAM=
=hAET
-----END PGP SIGNATURE-----

--D1brhLvD4YeQktqi--

