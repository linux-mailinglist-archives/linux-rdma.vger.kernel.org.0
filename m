Return-Path: <linux-rdma+bounces-13755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C2BB003D
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Oct 2025 12:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB44167707
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Oct 2025 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B175E2BEFE3;
	Wed,  1 Oct 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN4oECF6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8D2BDC0C
	for <linux-rdma@vger.kernel.org>; Wed,  1 Oct 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314606; cv=none; b=Q10LyQFfWIFENjt92VtFlLYS3LYeV3aN8ML05WLQeTosIta50Ei72z6f78I64hYFQ8eXbtAIkfoirS1M4M+XGAdkEY7ebIn5Hu7qf4fJn+ZfMhL+R82Suu2+Eha82ir2q6RJ3vIk8JjYwpTUm+TKALtECaglyO1QQgeQHpG+Has=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314606; c=relaxed/simple;
	bh=lpcbaTnRUfRuUjlxvKbi7MippNxGb5EWhV7oCbjdFdE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=famzGoyBI3q4CeDfpiNasJfLzyEXKBG1OFBJKhOfl2RoRnBAs7CSehrlYoYJGyzQ/k9Y22HudbYoJbbS/VpLyW1UZLj0QcR+dkIQSE+sEmsKRdBkAJVyL3wItPTf+Sno0MxkRbQscdtE1t6hXhIEeCAWOaKUPgHvt5T5p0Be0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN4oECF6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33082aed31dso7770682a91.3
        for <linux-rdma@vger.kernel.org>; Wed, 01 Oct 2025 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759314604; x=1759919404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fvvc2wJV4y/adOnS6TVe7Zorj1unil+xBTIrzA8bkw=;
        b=LN4oECF6HYqrTDe+J/1iFgvvBgpF+ylX/BvnGJ2gzWGqCOLBwZWzVdVZe4YDBcofmA
         WRGYXuZgjyGX4wJyaCo5qH9daAPc+L9Z+dZ0coRPFX88n5596085TpgMmfcSrQ1pr3Rs
         qG07v2FlTmy/4HxWEeme1eptGO9PgQ8Nay2iwYnvZkCGT3tkx3q09RPAibF/iUnJDh/f
         HrnFByyQmiinRkIQTG/Fdk2pxRRbHCBd1HnnJ5w6llR8z+uBoaMMa9xPQ3mpcXhdMtDx
         t9EWKjOEyjBE1uwIVJ3ayJz4Wy4TzVgev76WVQNCUfKGxwCRmivNXvrpXEVfypdWca1/
         9EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759314604; x=1759919404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Fvvc2wJV4y/adOnS6TVe7Zorj1unil+xBTIrzA8bkw=;
        b=qtLbCL+gRRsUqTgF0LtZMFNnawHSjrKTAiCXKrC3PcmrXF2k1paPb12sA8VP7POuiB
         ACIhzSTLNAr+3NFEEBGzCS6vPUl2ikRBy6N+M/xUc6IdhbFPSPr0Uy1aZp5wcEt3YPPb
         p6iYgh6cNnTWwznbHNJglMz5zSmK1i852Tlks9S7gHyEWAAIovJz90wgyJsQLY4gBBul
         XFm8qzAVRwhh9YVORl2dLJtLJ7It4wvYBCiG9IX9KJo3SU88qqFJwWtKjFyq78CIDkdw
         j88iNSifKk0hnuxe64G9uN2V+4ZvXJDn9SLHbUKEbpY4VnFCtJLE3c9dUXsYdh6V5728
         2z5w==
X-Forwarded-Encrypted: i=1; AJvYcCU3M7eFx5nbmFU5LvF7G3J/k3Pa7T90GzDzfZpws5qi4t3MiJv/HOuiBhPTAahAmmcfvLaPHa6R/928@vger.kernel.org
X-Gm-Message-State: AOJu0YygrQjWY0D7e99wSoW70G8XpgsQnsyX6Kz9ZanRHpMvRF8wlJdg
	7U/pdOib40ud6nm6wk0ZcDBz4qOLf3XDLoSNeNy/tlXgdytNrJZUCrW+
X-Gm-Gg: ASbGncv+oiLah9zCYpVBPNILu9x7IIxJDoo59h+hsa12HaL7Mmbgpiv4v+YS5OOWa+d
	UsyRhDca/8KvfMpocHltMxafmrzzi3ECggi2t+M75Gzp+v16FFaKNkdB+S4QbazKGradmF8rVcl
	mIyHIqIH5Gy/dbwexZQYY0bOK42nQ1tdXiqMYaa8RQH/PbVxuOjEpGU+EVPgHgvFJtz52SHnsag
	uH1BYH26s3AveHsHTs77xEeRpzv7pTURMitaWmy19D9P1uVi3VfUKNPfM3RqfFE0N867JoNNEFw
	WhdFq5d510O2SqopsuqsbTD8qOKqvT6ZzVH+0DRJfrrhGnWQG0jgClnF5+TEiNvc1K5ydjpQhFU
	BcNGcfsHkAzD7qRi5wu+OVsj3diiYEMYwlMHjMOSabxA7j3nCaQ==
X-Google-Smtp-Source: AGHT+IGlOP08FechFri9XhBd09rOWOVrXywqRW8pZP7UrkJv21iqrkorW0M3GD4lm+V6u0a1W3KkFQ==
X-Received: by 2002:a17:90b:4d06:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-339a6ea3208mr2952898a91.9.1759314603841;
        Wed, 01 Oct 2025 03:30:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b608f0fe65esm643463a12.0.2025.10.01.03.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 03:30:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E93B544507EC; Wed, 01 Oct 2025 17:29:59 +0700 (WIB)
Date: Wed, 1 Oct 2025 17:29:59 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Halil Pasic <pasic@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <aN0Cpw7mTtLdnBMZ@archie.me>
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
 <20250929000001.1752206-2-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XTnKR8OXozLogMib"
Content-Disposition: inline
In-Reply-To: <20250929000001.1752206-2-pasic@linux.ibm.com>


--XTnKR8OXozLogMib
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 02:00:00AM +0200, Halil Pasic wrote:
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/netw=
orking/smc-sysctl.rst
> index a874d007f2db..5de4893ef3e7 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -71,3 +71,39 @@ smcr_max_conns_per_lgr - INTEGER
>  	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
> =20
>  	Default: 255
> +
> +smcr_max_send_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
        So-called
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can be a bottleneck in a sense that threads
> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the send path used to be hard coded to 16. With this contr=
ol
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physical=
ly
> +	continuous array in which each element is a single buffer and has the s=
ize
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 16
> +
> +smcr_max_recv_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
Ditto.
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can be a bottleneck in a sense that threads
> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the receive path used to be hard coded to 16. With this co=
ntrol
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physical=
ly
> +	continuous array in which each element is a single buffer and has the s=
ize
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 48

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--XTnKR8OXozLogMib
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaN0CowAKCRD2uYlJVVFO
o0wMAQC5im7T2Vp9QlkibFW/54g3imCkfNlm7IUNsqBjTp2m9AEA1GNBLgxsziTy
v2vNJmcJSA7s6ugOR+dFS8j67OYO3Qs=
=jHsY
-----END PGP SIGNATURE-----

--XTnKR8OXozLogMib--

