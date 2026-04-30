Return-Path: <linux-rdma+bounces-19789-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DF8O6hW82mLzgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19789-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 15:18:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6518A4A3519
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 15:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C782C3060DB9
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBB942189A;
	Thu, 30 Apr 2026 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ZcxvhIgY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511640F8E6
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554913; cv=none; b=QZVa2tsUz4tPgJ9AQdpaxKCFUxm5xv17/qBoNdoowlm7KGsqAeKpnpnIC6E2KnVXNue+KO1e1AmD1axeXwrfFsXDvKqAOQn/D3X1s6ajhDyy7lzAfGM9M54bil++13AOefx8zgXMhEL5FKeOLZ1u7MOtdmcxnBS7qfmVEAxF6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554913; c=relaxed/simple;
	bh=k6Ky8SekzqlEMWe2IfF4o9e521vL5c/R7nKtlYixpPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1yc1VvPetGT9ekRpUWRyUKbUn2slEMfhYGVhfbjMMRgC16fxInlCT2I0/lVXnfCFpV+K4k89+ABkL1HYqLD3hLs4Rl3BmKeL3+6UNZcIWSy39Nmk3QJW6Od6xe6+i83HxU/rEm6w+4FjVIw2sZgCQvcRgWBIqbYtbsPhqdcBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ZcxvhIgY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso11340955e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777554910; x=1778159710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q14Nfv+UEqF4wGTpTXYwRmNvMzztXWMPU3JKrPL0wNU=;
        b=ZcxvhIgYSB2FjP+0ja//gHRzj0S/DjUT2vV7ujd1DIAIMDat4t6ICYdT1a+tsUH42b
         JVNnKNPGZCu6M3GPd5DH5VqgCKC/ofDpGehGjrbG+nKzDQQDHPkMrlFjdw0HYqpGAf6D
         GtykEVIZKTFCt7Y6Lu+uEzP9bxlwp+3zJu1sI5jwJu9YmaPLq4ozuRnBtV+eqjLTABs/
         rCdCeEa8ZTY2ZB9TZ2WgVvKJX/vRIcGD5IHnKPwXCqdYG1KiedfYzTBnjswAIo6zlLrd
         ktLvWZ/vyddbrfcIGCpBKJldcrnCRmf0nr/uuIdEBqQxjHMyJa3zNWk8QlR9WAUryMRL
         Qc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554910; x=1778159710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q14Nfv+UEqF4wGTpTXYwRmNvMzztXWMPU3JKrPL0wNU=;
        b=rUy9na4oEsomiLESJCDS6wSGPzadMSTwYjEXJBfb/jQ243kNkVQM+2xKBdko/JM6nJ
         s+dBd8J6dju3aLZcfLeIczBAeP/Ydzpv0XqvBJgZEqTZWDXqezhz/8vBV0WrS2RibvlD
         3NNUw+EUyXKkBhQVwv3eKg5A/0NlDqQpfY5Ua7MyTlW+Z2FmyB+1il4CepBTIizmSLHr
         GpYHz9e3tSkWJ7dHJkE9PXdN2HtSHCQMeOTcK73htov0uyciNt04udlNzgOyKedwL8oz
         OfTbo9vC87NRjHGdVxppuoy1XFw4Gsy5gAb5QCs3BcZlH7IqRNpkfDxMsuyottdGkYRl
         mogA==
X-Forwarded-Encrypted: i=1; AFNElJ+Io2DoTu5kLpskR8u2ziLxLMTF7JZyp8Il4X1PbhuxD1PVGkzm0izYBRnQ5OpmrRadU3HbV5HGBW6U@vger.kernel.org
X-Gm-Message-State: AOJu0YxuBlmUPK4ogj2X3PJzDkxA7bhEIrVwZU5KuJIjbI9FPOXmIz8r
	e5E3kQMHaBPcF4jcnLPD1X3YGBYoOhamt2jz2DZFK3el0cCV/0kka5dFM8cZNA3r+o8=
X-Gm-Gg: AeBDietwrL8tv4q+vN2eoVXOlBs7zaVpGMChNVQajXQ1KY8COkUsLIUD8pwutTO6NBj
	1FPWiQEe8WbD9tGb76afhQx5JJi0vgerZR5bLi2ugJ4GZlN3UqcAR4Oe4pkxiBIDaJVm/mcRt4I
	7yCLWYizIGAzQH99JguWkZ/7YIKi6OE252flmWwzonGaJxaNMSj54il9hrSDIom9+hF4zMRqtOy
	Ks2m1ETWpO0ftDNh2onbikYKWCts0rZxbutKiZtFsFRy4GEc6JqfT3dmoDai/yam5VQXZEHzCYA
	bDJ82O7ASqHoM6tAPdsK6g+m88oJt9JcK88dUEe4fqkkPJsqsk0dn+jFy9cLq2G2WfdfB2aIDSZ
	ZZNRt46zt1YgNxmXesGbQijr2K37dAu1UGJJNpSn5YbabRiwbTlJg5+2eZmVWGbSNDHHaNBPbx+
	cPEilUsRoHVTnfaN119xb4B51FY84eOxbrgDvWmu3FPqCuGoAdR3fTs/vPBeyvOeS8/QSHBUP5G
	dSJsIJH+iSUKvvrQdpePVeV1Q==
X-Received: by 2002:a05:600c:c0db:b0:489:284:44ab with SMTP id 5b1f17b1804b1-48a83f6b306mr35501805e9.12.1777554909754;
        Thu, 30 Apr 2026 06:15:09 -0700 (PDT)
Received: from localhost (p200300f65f114e0859f76ff87a50eb14.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:59f7:6ff8:7a50:eb14])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-447b3d47ff1sm13921904f8f.6.2026.04.30.06.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:15:08 -0700 (PDT)
Date: Thu, 30 Apr 2026 15:15:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>, 
	Johannes Berg <johannes@sipsolutions.net>, Steffen Klassert <klassert@kernel.org>, 
	David Dillow <dave@thedillows.org>, Ion Badulescu <ionut@badula.org>, 
	Mark Einon <mark.einon@gmail.com>, Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
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
	Andy Shevchenko <andriy.shevchenko@intel.com>, Yicong Hui <yiconghui@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, MD Danish Anwar <danishanwar@ti.com>, 
	Nathan Chancellor <nathan@kernel.org>, Sai Krishna <saikrishnag@marvell.com>, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	Joe Damato <joe@dama.to>, Double Lo <double.lo@cypress.com>, 
	Colin Ian King <colin.i.king@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-parisc@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
Message-ID: <afNVhCLPqPf-OKK3@monoceros>
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
 <DI6D3JVJ6JG6.8V4XUVGJA2D4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6b5ffjhgb6zy7r2y"
Content-Disposition: inline
In-Reply-To: <DI6D3JVJ6JG6.8V4XUVGJA2D4@baylibre.com>
X-Rspamd-Queue-Id: 6518A4A3519
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19789-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pm.waw.pl,sipsolutions.net,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]


--6b5ffjhgb6zy7r2y
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

Hello Markus,

On Thu, Apr 30, 2026 at 10:55:14AM +0200, Markus Schneider-Pargmann wrote:
> On Tue Apr 28, 2026 at 7:18 PM CEST, Uwe Kleine-K=F6nig (The Capable Hub)=
 wrote:
> > diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/=
m_can_pci.c
> > index eb31ed1f9644..cb9335c1d3ea 100644
> > --- a/drivers/net/can/m_can/m_can_pci.c
> > +++ b/drivers/net/can/m_can/m_can_pci.c
> > @@ -183,9 +183,9 @@ static SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
> >  			 m_can_pci_suspend, m_can_pci_resume);
> > =20
> >  static const struct pci_device_id m_can_pci_id_table[] =3D {
> > -	{ PCI_VDEVICE(INTEL, 0x4bc1), M_CAN_CLOCK_FREQ_EHL, },
> > -	{ PCI_VDEVICE(INTEL, 0x4bc2), M_CAN_CLOCK_FREQ_EHL, },
> > -	{  }	/* Terminating Entry */
> > +	{ PCI_VDEVICE(INTEL, 0x4bc1), .driver_data =3D M_CAN_CLOCK_FREQ_EHL, =
},
> > +	{ PCI_VDEVICE(INTEL, 0x4bc2), .driver_data =3D M_CAN_CLOCK_FREQ_EHL, =
},
> > +	{ }	/* terminating entry */
>=20
> M_CAN_CLOCK_FREQ_EHL is basically hardcoded for all PCI devices since
> 2020. I don't think we need this driver data at all and can just drop it
> and use M_CAN_CLOCK_FREQ_EHL directly in the code for the frequency.
> Once a real new PCI device gets added we can see if and what driver_data
> is needed.

Sounds like a nice *separate* change, right?

Best regards
Uwe

--6b5ffjhgb6zy7r2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnzVdgACgkQj4D7WH0S
/k4x3Af/edtfz9YYPFE6xum2g4TegCtLIvKw++0KDUAoyqpgkttjiVhQP2pkII1I
bwoXEDLgA701tfOm6K4xaBwmjr22fTEMmwqGBUUV9kbxJkZTOYaAvGL9vZUhumqW
aON4lzwvfmfJ4n1Nk/YWjSE0QmjI9PG7aoUCczzIPsEamTrS3xLh7OpHvF2bshFv
8t879m4kyInFizFXvDm3Pb+7WfqIwJHbJBKFtf3yy5ZlAf4JxFccVoOC3ygeZaz7
2S+yew8q9RxoAdReZzT/aUjlxkf0z4CmHidC1JcBK8qT/tAsE7w86uaDZOy5/ZKz
gpkzwoU/cOxmGkcr+S/smN1/kcOCJg==
=Kvic
-----END PGP SIGNATURE-----

--6b5ffjhgb6zy7r2y--

