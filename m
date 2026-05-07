Return-Path: <linux-rdma+bounces-20164-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLz1AlWo/Gn5SQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20164-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 16:57:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3FE4EAAD3
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A003730AEC78
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3843B3B27D0;
	Thu,  7 May 2026 14:49:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E0371D0F
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165363; cv=none; b=tFz7Ahw9KaZdT7I4Uy5FWNk+4ywy8iPtFQExDXw9+1xQFUhynzh3r4H0C+Ur65M45DBP+0RaVNsAw1bfvCbiV9tina7xsJekOb9FD9jzWzAk2XsCMqiElt3A7jhoHSOX7yYrzbaGBQLixwbj/YvwnOq2rTWyU3u0IC+gJtrVtW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165363; c=relaxed/simple;
	bh=0UEQFqnl250j7u4bGJcBxutylZ1Mf5pF7DjU6CUdE8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGI+2Yvg4zl/8MIEmAljHFZFDGzabc+1qfHKEp2BxeYTPGeD/eUNsucYOLN1PFU9hArP6Kwk1DVx6sFHXijkVmGQNIX6ZsVZv8xxe/Ra0DBHHpHRbTXfrAuEjYBfcZDeKx4Z4hqwvOxpz7lRc/PffowN4LB3L//KA2iaS8P6Jm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wL01i-0001Vq-3i; Thu, 07 May 2026 16:48:34 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wL01Z-000wEM-1k;
	Thu, 07 May 2026 16:48:26 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 264265306B3;
	Thu, 07 May 2026 14:48:25 +0000 (UTC)
Date: Thu, 7 May 2026 16:48:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Michael Grzeschik <mgr@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vincent Mailhol <mailhol@kernel.org>, 
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
Subject: Re: [PATCH net-next v2 1/2] net: Consistently define pci_device_ids
 using named initializers
Message-ID: <20260507-dangerous-manipulative-guan-bfd474-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <cover.1778149923.git.u.kleine-koenig@baylibre.com>
 <76da4f44d48bdde84580963862bf9616bee5c9e9.1778149923.git.u.kleine-koenig@baylibre.com>
 <20260507-healthy-gainful-fox-500552-mkl@pengutronix.de>
 <afyfa4E4rNbkMYTk@monoceros>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3r5cznssyoe7scuq"
Content-Disposition: inline
In-Reply-To: <afyfa4E4rNbkMYTk@monoceros>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rdma@vger.kernel.org
X-Rspamd-Queue-Id: 5F3FE4EAAD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,pm.waw.pl,sipsolutions.net,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,amazon.com,infradead.org,ti.com,infineon.com,cypress.com,baylibre.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-20164-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[81];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Action: no action


--3r5cznssyoe7scuq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v2 1/2] net: Consistently define pci_device_ids
 using named initializers
MIME-Version: 1.0

On 07.05.2026 16:23:43, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> Hello Marc,
>
> On Thu, May 07, 2026 at 12:55:45PM +0200, Marc Kleine-Budde wrote:
> > > +	}, {
> > >  		/* ASEM Dual CAN raw -new model */
> > > -		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> > > -		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS,
> > > -		0, 0,
> > > -		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
> > > +		PCI_DEVICE_SUB(ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> > > +			       ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS=
),
> > > +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_asem_dual_can,
> > >  	},
> > > -	{ 0,}
> > > +	{ }
> >
> > Nitpick: can you convert the terminating entry to follow the same style
> > as the rest of the driver:
> >
> > diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja100=
0/plx_pci.c
> > index a03553b80a5d..d69ff0ccfd94 100644
> > --- a/drivers/net/can/sja1000/plx_pci.c
> > +++ b/drivers/net/can/sja1000/plx_pci.c
> > @@ -353,8 +353,8 @@ static const struct pci_device_id plx_pci_tbl[] =3D=
 {
> >                  PCI_DEVICE_SUB(ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DE=
VICE_ID,
> >                                 ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CA=
N_SUB_DEVICE_ID_BIS),
> >                  .driver_data =3D (kernel_ulong_t)&plx_pci_card_info_as=
em_dual_can,
> > -        },
> > -        { }
> > +        }, {
> > +        }
> >  };
> >  MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
>
> After the conversation in the v1 thread it was unclear to me if you
> stand by your opinion, so I kept the format as it was. I interpret your
> repetition of the nitpick as request to rework the can drivers for the
> next revision (if that happens).

Doh - Yes, right, we discussed this already. Keep it as is and add my:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for drivers/net/can

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3r5cznssyoe7scuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCafymNgAKCRDMOmT6rpmt
0nq+AQDxBatA6k3wbRiLlE0iYqFi1UszWzbE6VspAxP9GaL27AEAvpxnHmYAF7Ba
NGRZfHI9sLbcPJXvBj/FLuPCtchoBwQ=
=GAHD
-----END PGP SIGNATURE-----

--3r5cznssyoe7scuq--

