Return-Path: <linux-rdma+bounces-3465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADC1915DC4
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 06:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3451F2291B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 04:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D613C9CB;
	Tue, 25 Jun 2024 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHl6SKSJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047245023;
	Tue, 25 Jun 2024 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290837; cv=none; b=gqdKoHbvAT0F5kYUmUK8dK2vuNx2fkOUpQ8FdOahVID8zZ1LWPz8SU58z8dU0GC8TZT7FWppiMTSYoRTT9ot3f9340hQVUqMilrzypR0c6Cl6fruVqu9cgPK3VGk+fPektWTKIlsonAcO7lBSHbr7sjEBvK+M9QLeVLWaA+vba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290837; c=relaxed/simple;
	bh=Qq60K9uBm/y/DS9p0kw9MthIKTXDk3frdtVp/7N7oSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ownVohDwX64EKc34qdbzB7n71XgR0ymjKLGyGjoDncrHMcryaa4J7IlnZHx9e/9zfGyOQr8qR+/H1tjCBZgqh5FsaJStiChZuOpsKyhH/CEOVUamwvi2N2oDHKOG5x1NnXgKoM+hF0W02dGlFFMh7VhiN6KW7zv2mXhnJYkPhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHl6SKSJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-681ad26f4a5so3022852a12.2;
        Mon, 24 Jun 2024 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719290835; x=1719895635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ET8p4ZwbaktWKrn1b5eMaR4bScMUPPuup2Ir2dcizeY=;
        b=fHl6SKSJ5x2BN34pluT7MKrWHc+wG21ErHtfJdzAbFG8PIXc8m5CVW0hdkcR5miJlg
         EjqxaykDPw20gkuWJZCSqFIxdCgHRspOZ2OAI6F9VvldjY21oXc9ytnImu0nU2vqmj/I
         nr2jevhIm6cD8z7TANSa4pD1+muO8aJ1iLH/kj9ikdpKFZB3AApY5TsqNdnBc+uFnkfH
         5nO5k3ChKICrgYbhyxjURQKP0+LEMten9YireaZyUz7bpH8YjNhUKI+sG4eGfdkaxyrb
         d+N1wjQ8DibGKFYge+SDaEVu0KymmSBjtVFVzkhogaSyNbpMgouR7rX6k/wSHJ+DNbaW
         LGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719290835; x=1719895635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ET8p4ZwbaktWKrn1b5eMaR4bScMUPPuup2Ir2dcizeY=;
        b=VTnsET3iQ1D6lY/s+bV87alCcz4/T84dW1/izFtJ1gPW7xq/+706QF/9dPJbq/xtt7
         TYlE5oWLY7C1d8bbogR/M+TS4Y/Nva7cJ5dnx/aNv06xbUtQeDqYgpZQ6J5e6CPqsw+u
         X2tJY7yNmTsZyxlhzpaJNT0I/Ncve53KhYSevyPh/wAMXFLvROeXzz0b8gwCeIsDNp8N
         UKGs5BgY7k0Qe2/g26/DcKuaazpDBshxu/74D6o41y6jg1lvz3U7bNi+J6avRZjpFSuH
         1PtOouSYiWVYcN/SZxT1t6/uONopBvtmrXWy9wE8u17v5fVl32X0En1Q5d5FxM8biqih
         XQMg==
X-Forwarded-Encrypted: i=1; AJvYcCVXEqobsh29J2akSOyViNdZ1C9cEIV6Q44RZAmHXRPLgl6pqjNowUT1ft1sQdMAwJor5RP8qx3ffxR4of2+fDt81sED8vrm+1MaC/HGfNDgGnw3cH5dvh926lmunZmTv2+OERA5hulrZpBShRiifzWktA537ALIA+udyal2BXeifs9O3BhTVCilDbVNBqADXRyeJU9VlryW3w==
X-Gm-Message-State: AOJu0YxBqu/LAh/K/BJo58zSOSl73OqzUvE+oYEpSGXMgT6dkFa4KiKq
	anQvn7Y58D6Ni9rxD4GCrB7Ib6r1s1/tZiJ4ajgeTlFJeaJNkPoj
X-Google-Smtp-Source: AGHT+IG0sebUeJQpuk9+1T7kODbDmbzQzYQvAA+fXGNUTHhxYQMrZTAru7EJUh2kkRifOwgpdBBbcA==
X-Received: by 2002:a17:90a:1286:b0:2a4:b831:5017 with SMTP id 98e67ed59e1d1-2c861435644mr5105992a91.48.1719290835238;
        Mon, 24 Jun 2024 21:47:15 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e64a2bc8sm9674004a91.54.2024.06.24.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 21:47:14 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 47CFA195E2806; Tue, 25 Jun 2024 11:47:12 +0700 (WIB)
Date: Tue, 25 Jun 2024 11:47:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 1/8] fwctl: Add basic structure for a class subsystem
 with a cdev
Message-ID: <ZnpLz_w0sKmYNVFt@archie.me>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <1-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6pUg5LYy9ZFeyzko"
Content-Disposition: inline
In-Reply-To: <1-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>


--6pUg5LYy9ZFeyzko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 07:47:25PM -0300, Jason Gunthorpe wrote:
> +/**
> + * fwctl_alloc_device - Allocate a fwctl
> + * @parent: Physical device that provides the FW interface
> + * @ops: Driver ops to register
> + * @drv_struct: 'struct driver_fwctl' that holds the struct fwctl_device
> + * @member: Name of the struct fwctl_device in @drv_struct
> + *
> + * This allocates and initializes the fwctl_device embedded in the drv_s=
truct.
> + * Upon success the pointer must be freed via fwctl_put(). Returns NULL =
on
> + * failure. Returns a 'drv_struct *' on success, NULL on error.
> + */

Sphinx reports htmldocs warning:

Documentation/userspace-api/fwctl:195: ./include/linux/fwctl.h:72: WARNING:=
 Inline emphasis start-string without end-string.

I have to escape the pointer (while also cleaning up redundant wordings on
error case):

---- >8 ----
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 294cfbf63306a2..ddadbe15189b45 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -70,8 +70,8 @@ struct fwctl_device *_fwctl_alloc_device(struct device *p=
arent,
  * @member: Name of the struct fwctl_device in @drv_struct
  *
  * This allocates and initializes the fwctl_device embedded in the drv_str=
uct.
- * Upon success the pointer must be freed via fwctl_put(). Returns NULL on
- * failure. Returns a 'drv_struct *' on success, NULL on error.
+ * Upon success the pointer must be freed via fwctl_put(). Returns a
+ * 'drv_struct \*' on success, NULL on error.
  */
 #define fwctl_alloc_device(parent, ops, drv_struct, member)               =
   \
 	container_of(_fwctl_alloc_device(                                    \

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6pUg5LYy9ZFeyzko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZnpLzAAKCRD2uYlJVVFO
o1kVAQCH1QHvokEmFRkQR2mgHs8K7Dlhtwzt3YYY/nU5W7068gD8CRCDUZcTmGzG
DoBud1vig/RrySo6o0mtkufVgkx1qA8=
=WNas
-----END PGP SIGNATURE-----

--6pUg5LYy9ZFeyzko--

