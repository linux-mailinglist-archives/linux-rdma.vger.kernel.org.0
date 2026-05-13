Return-Path: <linux-rdma+bounces-20609-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAXFIZzbBGrYPwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20609-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 22:14:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2129953A621
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 22:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59B5E300DEEC
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274D3B635F;
	Wed, 13 May 2026 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="QTcXYiCr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610623A9DAB
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703257; cv=none; b=dRtyo6o56yfPXHHdvW5JJBaZUUtuMbTXx0VWKEw7VuMDvqfWsd1F6fttzmm0QcataQOhsjD3y9Te3y9euakF5e1DUdwo8oT0CaDD7zyEVEb/EHcJiMwtbVdLMlogVp09PEvpxTZoEK2E/qVKfQ1Tn1dWcA23q5uD622Bvj7iuy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703257; c=relaxed/simple;
	bh=hhpxUq9rPLhNloJtiC5AovllM+wmddLSE2cEjnBXYbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnGE6hudON0GP8KvS+toD6TmKC83Er5R4a68o1iO+jS7YgBXwmH6GixGqDkR4VoTqfytvuit1A5Z8gTURDokxC4dwHexqyavdSL2cKPv/zQBXuMJKlOWXl1cnC7h2QcvgbDzo0ztV0gpvqitCHo4Zh7larqvHAfbZqy26URN50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=QTcXYiCr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48896199cbaso63256475e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778703253; x=1779308053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSxikRBERCKaj6Ug1RvtV8/Dt2YJWo4PpMWO4hRzzKE=;
        b=QTcXYiCrM1TQy7iB3/BDLRIHA02iOeW1mLPTB/nAERNs0lKF9tJv7fdwyoO/crPsFI
         d91skp1IiMeINkfPBd+5lTl38gioaEd5nxNqm1/WGIWFFtgfu33T1uN0BpPooRRrY55E
         OO2sN0XPauSkDQsXF+saPJieYGg2aDzsVldzUQrjQJ5jrTP0mUVC98toQkvCCP98CDHx
         yrZEqqV40/sodyX8QS1taxf2q0Lt0rPADOWUsF0vR/KV/5LliBdMwU5zJtIKj3n7qa+3
         YSfQMCGeXxintE+46hSBjmK3TQV+CdA8IP5nJ3+h3wRHedODLU3UNMOYN/YxzdHUqUSp
         octQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778703253; x=1779308053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSxikRBERCKaj6Ug1RvtV8/Dt2YJWo4PpMWO4hRzzKE=;
        b=OzF2P5dj55aUpfzxpFDdjcD8496zzGHKIiGde6Ia6R+ASwgmEJXe7R7KCtATmt0e5F
         Bupk+ZGRqoFxYvum8Xhoi7NGOtVOmrmse53MsYQN8ibaS7+cOC4gIUIPhpzE8AnBtUhS
         Y1zvLEBQjgVGzCleYFaDAG8gOl77nw4XTlSxpy5bjD2iGh6SrmPzzlOqH9s5rCR4vIJg
         YmvoY/yjxGQ/0hg9IAnD/sNVZPV+Cg8GgZmvNDD/q7KeQC9LW+Kmi4AKuJQEGsBVhQkq
         mJhmyZNBro+ungavm0+fT5ednW6f7+iOf/JDXbtMabfuCkztvlpCzxRgv2o5Ol2jfllM
         fpkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wQt4Zz/M3l0xWwTAjKXd67vHYbNELSWBEr4MWZvUpIBj/+uZfA9Dlvj8DrKqE57bPB3WdOyqrMIFy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5WU1I1APfxRrSdfsDlh69I5EpopSns5T1j/PoymxR6G6vl4D
	uH4l1Uu7dztsseDFeBqPS/Dxxf673qI346KKLAlDuQiCa1Qg7So/PetVQuav1WT5a/vD+4uyhoX
	TTFXAfhfEoA==
X-Gm-Gg: Acq92OEn+0C2se3DyCLxzIExmJS25oeO4zDimP1aqRpDRKARguQTe3/V0t6a4HGalQX
	8CxIAuZXWyon3XJcOameFVJy1R/hS2KueGsQx5KBxtzpYoaQ6wATiSC5l+deZf5H4AGeNRBTrxF
	NU7fH14FT7LpVLVD1IvcSoffeKC8qbQFat0nec21HbsiprVw2zOPc9z90byI4zBXWTTH0GgOkiY
	jqIio/5AiloG4xoNDvAzumWnNLSQp+DrSJQ1JgKVIkvLTCieosw77YWy7TS8xVcX7vA6zJhguqf
	d3h3yojJDRCVltcwNmKWaPhbG9dkh2zctWqhFMWbRD/eyyjLgQdApphaBk2b54f7jVSuQtkTpzf
	63gwKNzsXW0I/uUvXh2HGVVsZPIa32PhQjOuUTEnjkT77j6VJyIfjzgRjWvnu+Zs4fUL95AD3D6
	Hy30kGAWK5KtT1+gAiNvoDHJF52yZ+
X-Received: by 2002:a05:600c:4e0e:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-48fc9a3bc7cmr75894655e9.20.1778703253621;
        Wed, 13 May 2026 13:14:13 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fd649a21asm14484955e9.6.2026.05.13.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 13:14:13 -0700 (PDT)
Date: Wed, 13 May 2026 22:14:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Chengchang Tang <tangchengchang@huawei.com>, 
	Junxian Huang <huangjunxian6@hisilicon.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMS/hns: Use named initializer for pci_device_id array
Message-ID: <agTbe0HM9hb1Irek@monoceros>
References: <20260507075437.2669363-2-u.kleine-koenig@baylibre.com>
 <177869828038.2371282.17935591061454741759.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="it67e2pmqpstt2gs"
Content-Disposition: inline
In-Reply-To: <177869828038.2371282.17935591061454741759.b4-ty@kernel.org>
X-Rspamd-Queue-Id: 2129953A621
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-20609-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action


--it67e2pmqpstt2gs
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] RDMS/hns: Use named initializer for pci_device_id array
MIME-Version: 1.0

On Wed, May 13, 2026 at 02:51:20PM -0400, Leon Romanovsky wrote:
>=20
> On Thu, 07 May 2026 09:54:37 +0200, Uwe Kleine-K=F6nig (The Capable Hub) =
wrote:
> > While being more verbose using a named initializer yields easier to
> > understand code and doesn't rely on the two hidden zeros in the
> > PCI_VDEVICE macro.
> >=20
> > While at it, also drop the explicit zero in the terminating entry.
> >=20
> > This doesn't introduce any changes to the compiled result of the array,
> > which was confirmed on x86 and arm64.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/1] RDMS/hns: Use named initializer for pci_device_id array
>       https://git.kernel.org/rdma/rdma/c/9dd3e17173bfb8

Thanks for picking the patch up and also for the typo fix!

Best regards
Uwe

--it67e2pmqpstt2gs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoE25AACgkQj4D7WH0S
/k6xrggAs8xFIEGEePepHHXtTLnN4mP37fwnhbQjQ8l/lPwDOAGkQNvzikbIHn1y
mRYiv0GTcEE2iCypGftfOz7UIHCP2Pbuujei5z2xpEoo294ojC9DFkIB5ilDrRsG
abYFVNdFBILeemoikCsMeGF85Zdssuy0GN2x2PqfsZQwFBc++Xumpmopf7vmsSSY
/MtJ25EmiVNTlgWRDo36KTmfvPWYqQN7sDfQ+C5Gqv23KFuboQu6KCmAaswJEA8o
IFFLyloAnZxjUrYqy+TyBMIdTrLflHPgbJzxihtV4/Ct7pbhuQyzjn+uoRWdvXs/
zzM2ONCe3KOP+9XKUg5dfVYrDygHJw==
=Fj+R
-----END PGP SIGNATURE-----

--it67e2pmqpstt2gs--

