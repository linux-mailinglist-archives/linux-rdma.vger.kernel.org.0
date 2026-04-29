Return-Path: <linux-rdma+bounces-19727-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCPyGOzc8WnKkwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19727-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 12:26:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D62E0492DF9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 12:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8EC73028005
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684023D16EC;
	Wed, 29 Apr 2026 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Js30MjQk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F303BED37
	for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458399; cv=none; b=HEBEFyTtJUmaaoByJ4mFksJ6lMBh19alct0m/uii1KPpiU+gPM+H649qZPd95zdjoKEGwBU4fciNiqLj1XS04A8xYI9jva7YiSJp1hqlhPtQ9PkXBzbsMOAgh2cCJGC42BO/p02En4Vxhl/6AUsuVytrFb59eQ71YYcSHwSk3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458399; c=relaxed/simple;
	bh=G1W/SI+R62/Tf87Hp2bXOJ+Uw+JF2EHw6TW2eBuH8Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7nx+5wdfWtxFXIx/44YiDNfvrIzpP2JE0dPg4T4cwAAoNSd84d3QqYatj9mri7GoIbLMu8I/+a52tcXH6nfZ5y+MAFDMR6tRg7ix/62llO7tr4kXp06owNAT6lq7zpur9cf7BuK1tiU9/ywOV1pxh13BaUa0EN0ZYQm3w8AJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Js30MjQk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso94946955e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 03:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777458395; x=1778063195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfvKfJJPf0ASmalSXv+63KXtxyjY0rmQCt/O1qy7v1U=;
        b=Js30MjQkSNinhyHsnP1tkLeQTG/iIF/TT5f0UsCVWGg/eQtCeQ5ZuidcebKvZHmMCc
         kvRUw2qysu5LiOakI1H8A6NbbH6hgyu98qtgV0UG/fSw5ZUN/E4/lYDNk51Bq9NYyC4N
         49gjKk98coWgt6BL1jiauqJhyIdwRqo4xwih7iigAoNtInXhWhX1X2kIMZg4GtQXGQJU
         mvxYYS31ygiufuijVxwEjPBF2fVNbDQdUlGJRAy/0wzLjsSfW4ULoGUPgb9ZAWBWDusM
         asQok7GJ1q+NUm1ajtPRTl7ZODlHMHtvS4f0sOdtdwdPhzJICrBfHcptdZtu2f4JqzM2
         3LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458395; x=1778063195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfvKfJJPf0ASmalSXv+63KXtxyjY0rmQCt/O1qy7v1U=;
        b=PxmNCj9VCyt09EkP0N0ElUDbfQmjSFgIQpmxchNxN/2IoSXYk8dIhONUzCKBrhCcST
         Ym7+CifixnOa8kad6R0W5n9v26aNT7hnxrcIDjmEHwLR1y1cYaI6Ajnn5xZ2GhhTvQQH
         Y5WCQ53tFDWuB8UQUhrEb9CHR5g7TeoJOpKwfKuLVQQUfCX5Y3RmKWp3ZLPkWDIMYy68
         CrL0Tfm1TKSvFmejFKNRRcAeWf9rTrYNSmTaK+VNLmXYBb0y3BPac7ZPVdBu/b2p2nEA
         knCQPsa2fOaFcYPr4j9oP6qhOjhuGi6XrJsiMdHWv68We6Jbl3cFwXbf+rFEmYLXwPFj
         9Ejg==
X-Forwarded-Encrypted: i=1; AFNElJ9Qg0ABbJ4abI/WVuuO4wWIKuCImE3QJrA9FiADWXNi2dFPylDHUMTT+ibK6xocTvALJ9xZ6Zbqa1Ac@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf5ckzfX2cHGLdtv3cB2zAlGQ060g8XRETv0meWP2qYNoga5b0
	Qw+Q4e4Ni1MsffwkyhhXd8+Rf4GbhEQOh803OT5cfRuyT6scsauUTIiiTdKOWq0uAhI=
X-Gm-Gg: AeBDievlRMdIs7l1NmQGA+w2HMV38dMyOtVqWi6GdwQTDXifU1yAbgZDh26llwrDzgy
	wd26GoYdrPQWCtijDTQlv6i5fyVt7CEgi+bOOYPEqA9jMBPkMFUBH+NEYRWsxUdGkkdiqiZqmrr
	TPZnAZmtbvFSNq2wOdTEIJep+HCGCC5X/Mo771ddEQ9Qbugd6RgBmPNQD5+IRJwgMIrZBke1Bi4
	20SSsVE5pKuyDxg+Va6kHMIgKDSoITFWPmT2fUtlLM9kpfQplnGgFmMBCFAkFgHnKRGjhSYzYIe
	c6svSDCobwFc0KvoXc/DAc1IsU+1Wbok+6xbapVaMNV+JyEmFeiTmKEZ7rNjAHY31VgfrvBzUhR
	trdf0wLRi2kmNqcBTHqwD48qQB+LgEQtYT2DWREMyRynRBQiQUYT3j7q9x4phd2AF2a7zPBszuQ
	TT+kiSCBifeCSbCF+wHogUJSgsuRztm1PBmCI7F690iuYwkTiJ1fLF+pS7pYVUqg0ZosuYiS+YK
	n1qXwmUvzGFYj2LcywKXAPDkQ==
X-Received: by 2002:a05:600d:8402:b0:489:149a:f9e7 with SMTP id 5b1f17b1804b1-48a77b25340mr88922285e9.27.1777458393898;
        Wed, 29 Apr 2026 03:26:33 -0700 (PDT)
Received: from localhost (p200300f65f114e08936c55da887fa426.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:936c:55da:887f:a426])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a7b912ee3sm28053445e9.2.2026.04.29.03.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:26:33 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:26:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>, 
	Johannes Berg <johannes@sipsolutions.net>, Markus Schneider-Pargmann <msp@baylibre.com>, 
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
	Petr Machata <petrm@nvidia.com>, Yibo Dong <dong100@mucse.com>, Simon Horman <horms@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>, 
	Francois Romieu <romieu@fr.zoreil.com>, Daniele Venzano <venza@brownhat.org>, 
	Samuel Chessman <chessman@tux.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Kevin Curtis <kevin.curtis@farsite.co.uk>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Stanislav Yakovlev <stas.yakovlev@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Thomas Fourier <fourier.thomas@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Kory Maincent <kory.maincent@bootlin.com>, Zilin Guan <zilin@seu.edu.cn>, 
	Marco Crivellari <marco.crivellari@suse.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Jacob Keller <jacob.e.keller@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Yeounsu Moon <yyyynoom@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>, Yonglong Liu <liuyonglong@huawei.com>, 
	Yicong Hui <yiconghui@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	MD Danish Anwar <danishanwar@ti.com>, Nathan Chancellor <nathan@kernel.org>, 
	Sai Krishna <saikrishnag@marvell.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>, Double Lo <double.lo@cypress.com>, 
	Colin Ian King <colin.i.king@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-parisc@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
Message-ID: <afHbcwzVucHRYmDW@monoceros>
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
 <afGrPvUeZ-DjWbC8@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k4r3nmtfjdpszuus"
Content-Disposition: inline
In-Reply-To: <afGrPvUeZ-DjWbC8@ashevche-desk.local>
X-Rspamd-Queue-Id: D62E0492DF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19727-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pm.waw.pl,sipsolutions.net,baylibre.com,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--k4r3nmtfjdpszuus
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

[I dropped a few addresses from Cc: that bounced for me before.]

Hello Andy,

On Wed, Apr 29, 2026 at 09:54:54AM +0300, Andy Shevchenko wrote:
> On Tue, Apr 28, 2026 at 07:18:44PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > ... and PCI device helpers.
> >=20
> > The various struct pci_device_id arrays were initialized mostly by one
> > the PCI_DEVICE macros and then list expressions. The latter isn't easily
> > readable if you're not into PCI. Using named initializers is more
> > explicit and thus easier to parse.
> >=20
> > Also use PCI_DEVICE* helper macros to assign .vendor, .device,
> > .subvendor and .subdevice where appropriate and skip explicit
> > assignments of 0 (which the compiler takes care of).
> >=20
> > The secret plan is to make struct pci_device_id::driver_data an
> > anonymous union (similar to
> > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylib=
re.com/)
> > and that requires named initializers. But it's also a nice cleanup on
> > its own.
> >=20
> > This change doesn't introduce changes to the compiled pci_device_id
> > arrays. Tested on x86 and arm64.
>=20
> ...
>=20
> > -	{0,}						/* 0 terminated list. */
> > +	{ }						/* 0 terminated list. */
>=20
> The comments like these are just noises.

Agreed, but I'd consider it out of scope for this patch to drop these
comments. That might also be subjective.

> The rule of thumb is to play with a
> trailing comma:
> - always drop it in the terminator entry
> - always keep it in the normal initialisers when semantically it's not a
> terminator

That was my intention. Will rework.

> >  static const struct pci_device_id liquidio_pci_tbl[] =3D {
> >  	{       /* 68xx */
> > -		PCI_VENDOR_ID_CAVIUM, 0x91, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
> > +		PCI_VDEVICE(CAVIUM, 0x91)
>=20
> Use full fixed-width device id value(s). 0x0091 here and so on...

Sounds fair.

> >  	},
>=20
> Also seems that you may decrease number of LoC here putting it as
>=20
> 	{ PCI_VDEVICE(CAVIUM, 0x0091) }, /* 68xx */
>=20
> and so on...

Agreed if all lines of an array can be compressed like that.

> >  	{       /* 66xx */
> > -		PCI_VENDOR_ID_CAVIUM, 0x92, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
> > +		PCI_VDEVICE(CAVIUM, 0x92)
> >  	},
> >  	{       /* 23xx pf */
> > -		PCI_VENDOR_ID_CAVIUM, 0x9702, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
> > +		PCI_VDEVICE(CAVIUM, 0x9702)
> >  	},
> > -	{
> > -		0, 0, 0, 0, 0, 0, 0
> > -	}
> > +	{ }
> >  };
>=20
> ...
>=20
> >  #define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
> > -		{ 0, } \
> > +		{ } \
> >  	}
>=20
> Why do we have this macro at all?

Over engineering? Reworking that also seems to be out of scope for this
patch to me.

> Also I somehow managed to remove, but I remember you had an inner comma i=
n some
> cases after the .driver_data, when the full ID entry is located on a sing=
le
> line. I.o.w. do
>=20
> 	{ PCI_...(), .driver_data =3D ... // no trailing comma here! },

That was also my intention. Will rework.

Best regards
Uwe

--k4r3nmtfjdpszuus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnx3NUACgkQj4D7WH0S
/k7M1wf/QelV4pupjiZbLcg8qPVRzGgZ0AKqDUMY0oLZjH5ck6W8VSMONm3Ln4fu
Tbzeul8HVUK14PBHvYKQiDU7OCUzVwfgAgM2qs9BuyfAmX3mBr2SaZI1M1DtYNUv
3FRPKSiDWXcbe5sguySJb0BKepJc6DdUYzpRBrF5m90mvuM2dZALWRiO3lFvMYlS
Kls/wTkony/O5uB/oAAHI7y91nhHIw++GuY0fge4rmRUISKTZ+G1/Lz8VrcUzt+p
8iTGVh5MpStGQuFRrjho2JzPcrXxcOYiI6Z3rRBMCu5qZbVlrzaKcVvwCMd7n4gc
gbcV922oXzCW/OtCAcZtPNggcidTXA==
=we79
-----END PGP SIGNATURE-----

--k4r3nmtfjdpszuus--

