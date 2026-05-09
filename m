Return-Path: <linux-rdma+bounces-20282-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Dw6FGrX/mlrxAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20282-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 08:42:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 340EB4FE4A0
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 08:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 859423008C18
	for <lists+linux-rdma@lfdr.de>; Sat,  9 May 2026 06:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3182337B01A;
	Sat,  9 May 2026 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LBwtehCn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DF337B81
	for <linux-rdma@vger.kernel.org>; Sat,  9 May 2026 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778308965; cv=none; b=aHo1RULLg+kb3FyFbrqP4ozljn19hawfFimPJCrx3GcVXLwZSef/eKWXK36nncI5pgt/9MKY/0CldiEWV5Qf1GyzmGq7/YZOXGcOKejC1xFFplSRMgVpUy/4wuYWm9ahbKkOTl2oNj13AGo2bCs5/H6utcdNciZ/7sft/WHHCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778308965; c=relaxed/simple;
	bh=GEoZHVYUfoQ2POcefbZ30StKEf4EcthVZSlNu+ybULg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbqDZGoW7GA+l3Tzfb5rEpVv3YMlvexqzhm+M16XoZTctlyQWGHlYp/khTgGTaaQSZzCTWFmmc14F48/y4BW1BANXN5GIIYJVWcwe40D7noY0hNdCRXXDfeMasdFIM+uEd4O4UIrYFJFbCVfEXw0Rxb4wK3ZsiWP4YEUtfP8JHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=LBwtehCn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso31992855e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778308961; x=1778913761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4fgHjlyy8GzHWAXn0Fq+FtEi3bvrm+LBlHiRLm/LF+E=;
        b=LBwtehCnVnt1LSPaLhGBjUpvt9AHuJe++D8N1GND9y9fEeQUrbT08NsgDWrjMRiCZX
         Oai69xD2ujhjI5AGxRONa7dRZZ9r9/b49t0H3OtMwCIdc4Geb5hg9wBUlLqh+aCaQcmo
         molnJ7cw8fli9tHj1rhGx+8I0SwAWMyw2nY1QphfZbkbxQ13gDBfO+WX0mEfmU2DVqyt
         0mY4jhMzSAnZaIUepB1EvkNlXFQBW0m35cuADjp+A/YIrSruos8i7WOavVxAey+KBokR
         TCq0lYtrQ7DZPmL8opIKozyqd8Tc+XwaS7S56i84XbhMTg6q7OYEeoqU44yS6aRlFEnf
         2PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778308961; x=1778913761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fgHjlyy8GzHWAXn0Fq+FtEi3bvrm+LBlHiRLm/LF+E=;
        b=enuLgpDeVpojipGWfV3CN2rgg2C7pj9gty70yUzlIPfZPiUN5fSoRfHV/Q0GNahGFv
         zzbEr47g7MuiiML9F2g9eEyhkbRlxBQ/wVl79WMuTahD57DMDgX+YNGlQem6Qg2TZAr+
         9YaU4cyxX+1OVVkk3FWNsG85bQrCCM/dS+dqJbX3/s1GhOI1Ubqd/q8Wns7iNGALASEo
         v/wpQt8kxPW4oHv9k6IMPBJhqGQOKudOjmqN2+bF9KfMFuXXszbh2JNmCXmjjNSYVLHc
         kH0aUrdJe0yt+Cg7aTnNy1XBr9gkB1bZuf2udfosFXd2lIxMpMRZDsizwYdhzhpXxU33
         FDJw==
X-Forwarded-Encrypted: i=1; AFNElJ8hpzXSCBOxDy9PBGvCjnk0NiwcvQWSEbzmA8h7d5n3vSbOAmDTOdTIQMfl04T25qm/oxQ9NqP1V74m@vger.kernel.org
X-Gm-Message-State: AOJu0YynoTZyBQw8vRxqCFwZsQVGvgG3SDBfN3WR52CYFbTxB/wkAFrA
	1bOW7mNTsZqxxW3IMNo+MvZeIuPXpzRxbgo0//KA5+4+iDjoWS0fl2/RO6BPG7AOrNU=
X-Gm-Gg: Acq92OH2gloHGIPj1MPazWybrTya2NqwjvQJftEgcvVdkmJte/eyBKLG2T1P4fUTj02
	L43IW/Yss3oc4mZAfE6cO86rwgPgb+oG9dnBVQeUer2nnRSrdB2b4CEbXF3yKx1rgPUmvlPx4bc
	m33Knb7w2cqPa9rFO+8vXYw7eLxqblMUPUspkF/9CPg5gMCaxk4+679AERqum8qrwScIXAcMHdt
	57vG0rD8NGFma6xqLCMIhB0zSkOSA9clT7zXwYEMpnZVM5Qrty9lXe6FGwkWV1Forx95Nfdiwa1
	8RdtMTAynt4fT8G2I9E1X46N9LVVsyMgnO2eqwKOoRJ/ht5XBH6wfVw6gxOZ/r/eKeZ2WHQ0iAh
	4gQN0C2wIdYAxk0Aob+RSWQ7BvZb50jCY2mAb+Bnr1Kh2iRxkrjog7DGW1qrXeopevjUEmxKaST
	/MWskUUcsrhg1lJZdX3FFXAlPF+7OVM/3pZocZUWg=
X-Received: by 2002:a05:600c:4f51:b0:48d:1a94:56c with SMTP id 5b1f17b1804b1-48e51f3054cmr269055545e9.18.1778308960358;
        Fri, 08 May 2026 23:42:40 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e6db1e1a1sm15355095e9.34.2026.05.08.23.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 23:42:38 -0700 (PDT)
Date: Sat, 9 May 2026 08:42:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Grzeschik <mgr@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Krzysztof Halasa <khc@pm.waw.pl>, Johannes Berg <johannes@sipsolutions.net>, 
	Steffen Klassert <klassert@kernel.org>, David Dillow <dave@thedillows.org>, 
	Ion Badulescu <ionut@badula.org>, Mark Einon <mark.einon@gmail.com>, 
	Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Manish Chopra <manishc@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
	Denis Kirjanov <kirjanov@gmail.com>, Jijie Shao <shaojijie@huawei.com>, 
	Jian Shen <shenjian15@huawei.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
	Fan Gong <gongfan1@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Yibo Dong <dong100@mucse.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>, 
	Francois Romieu <romieu@fr.zoreil.com>, Daniele Venzano <venza@brownhat.org>, 
	Samuel Chessman <chessman@tux.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Kevin Curtis <kevin.curtis@farsite.co.uk>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Stanislav Yakovlev <stas.yakovlev@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Kees Cook <kees@kernel.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Thomas Fourier <fourier.thomas@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>, 
	Zilin Guan <zilin@seu.edu.cn>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Marco Crivellari <marco.crivellari@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Arinzon <darinzon@amazon.com>, Yeounsu Moon <yyyynoom@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>, Yonglong Liu <liuyonglong@huawei.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Yicong Hui <yiconghui@gmail.com>, MD Danish Anwar <danishanwar@ti.com>, 
	Nathan Chancellor <nathan@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Ian Lin <ian.lin@infineon.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Double Lo <double.lo@cypress.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-parisc@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, oss-drivers@corigine.com, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH net-next v2 0/2] Rework pci_device_id initialisation
Message-ID: <af7WyUi8jEzInj5z@monoceros>
References: <cover.1778149923.git.u.kleine-koenig@baylibre.com>
 <20260508153452.6a1a9044@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pa3si5htqwvg7uxg"
Content-Disposition: inline
In-Reply-To: <20260508153452.6a1a9044@kernel.org>
X-Rspamd-Queue-Id: 340EB4FE4A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20282-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,pengutronix.de,pm.waw.pl,sipsolutions.net,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,amazon.com,infradead.org,ti.com,infineon.com,cypress.com,baylibre.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_GT_50(0.00)[81];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action


--pa3si5htqwvg7uxg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v2 0/2] Rework pci_device_id initialisation
MIME-Version: 1.0

On Fri, May 08, 2026 at 03:34:52PM -0700, Jakub Kicinski wrote:
> On Thu,  7 May 2026 12:50:18 +0200 Uwe Kleine-K=F6nig (The Capable Hub)
> wrote:
> >   net: Consistently define pci_device_ids using named initializers
> >   net: nfp: Drop PCI class entries with .class_mask =3D 0
>=20
> There's a transient build failure between these two patches,
> you should probably reorder them?

I did build test with the first patch only, using gcc on x86 and arm64.
I guess this is about the ambiguity I mentioned in the cover letter and
maybe using clang? I'll try to reproduce and fix.

Best regards
Uwe

--pa3si5htqwvg7uxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmn+11kACgkQj4D7WH0S
/k623gf/Q5yF7db6dzmHCyOj113/GHbgzci3Yxu4CEcdvsPNimdU2fG1YgBtP6nM
r1i/YnPw6mQRQh4Qq7870HLsc/WC4sNLH9xZ3NjusUle3e5XMEkpB3mxW2hH/UzB
b0H3xhJvSgiMvib07RqvaVi8kUtsRwkCSR/2zVeSQ2EsMZxwRzV2P09lA/wTiPhB
Hxl7XbIAvVTsDMnnDW4UcyR/xqwsoEjLpTqPSymYwgE9A7kCU1/JD8EO+CNKisYk
AXjQUXekCwI/z5gR4lWMD0xqU7WtNMVfI48Bi7t3gVYPaJTnyY/z0PJuUfKvA8BP
Ar9LmlMuhzaJTsnOdLsr4fzHOJuHdg==
=2L5C
-----END PGP SIGNATURE-----

--pa3si5htqwvg7uxg--

