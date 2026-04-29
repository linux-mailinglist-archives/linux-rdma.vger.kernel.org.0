Return-Path: <linux-rdma+bounces-19723-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNP4Ek/L8WlCkgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19723-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 11:11:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D604919B7
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 11:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8120F302EAAA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C813BC69D;
	Wed, 29 Apr 2026 09:11:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B73BD659
	for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453892; cv=none; b=SSoDvfFE4xG9HHYAtjmOe3lC+fDYQc5Zaex53fe+tzyGlc0p5eNtLSqV3HxqbYG0c3Y05MhUsAVGrebrbEP1SPFyF+duF1kn58EttBCUz/vF7jPHlabhcPVilcqMD+JVjDIXyMaUL2GC0/OESslngIj70Uf3U9KSlh4+WohoLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453892; c=relaxed/simple;
	bh=UJ5Ld2S+JHTepWdAusJVua3UcoslO/KbjwgVZRPx2Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWM4jnr1LrTgU/u5Jzg8byu94qUBqdHV2/iaalL9AoEa5wrhYCwW7ny70EQcUSgYiQOifxTZujsW2uSx34OreI3uLEAX41yEU5Z90L5R521TsaUl3tfQY5cmvr1oB0lsAwWg7ZNtQiAlKQDiEFwGw7tDT3ArAsirQzyuO++RG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wI0wA-0006pG-NU; Wed, 29 Apr 2026 11:10:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wI0w3-007oJR-0R;
	Wed, 29 Apr 2026 11:10:23 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 668E3526F68;
	Wed, 29 Apr 2026 09:10:22 +0000 (UTC)
Date: Wed, 29 Apr 2026 11:10:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vincent Mailhol <mailhol@kernel.org>, 
	Krzysztof Halasa <khc@pm.waw.pl>, Johannes Berg <johannes@sipsolutions.net>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Steffen Klassert <klassert@kernel.org>, 
	David Dillow <dave@thedillows.org>, Ion Badulescu <ionut@badula.org>, 
	Mark Einon <mark.einon@gmail.com>, Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Denis Kirjanov <kirjanov@gmail.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Fan Gong <gongfan1@huawei.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
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
	Denis Benato <benato.denis96@gmail.com>, Peiyang Wang <wangpeiyang1@huawei.com>, 
	Yonglong Liu <liuyonglong@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Yicong Hui <yiconghui@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	MD Danish Anwar <danishanwar@ti.com>, Nathan Chancellor <nathan@kernel.org>, 
	Sai Krishna <saikrishnag@marvell.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>, Double Lo <double.lo@cypress.com>, 
	Chi-hsien Lin <chi-hsien.lin@cypress.com>, Colin Ian King <colin.i.king@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-parisc@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, oss-drivers@corigine.com, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
Message-ID: <20260429-responsible-clever-coyote-6b79f1-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v5gtri26mw6juc6y"
Content-Disposition: inline
In-Reply-To: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rdma@vger.kernel.org
X-Rspamd-Queue-Id: B2D604919B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pm.waw.pl,sipsolutions.net,baylibre.com,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19723-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[84];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.320];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]


--v5gtri26mw6juc6y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

On 28.04.2026 19:18:44, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
>  drivers/net/can/m_can/m_can_pci.c             |   6 +-
>  drivers/net/can/sja1000/plx_pci.c             | 167 +++----
[...]
> diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/=
plx_pci.c
> index 08183833c9bc..a03553b80a5d 100644
> --- a/drivers/net/can/sja1000/plx_pci.c
> +++ b/drivers/net/can/sja1000/plx_pci.c
> @@ -272,124 +272,89 @@ static struct plx_pci_card_info plx_pci_card_info_=
asem_dual_can =3D {
>  static const struct pci_device_id plx_pci_tbl[] =3D {
>  	{
>  		/* Adlink PCI-7841/cPCI-7841 */
> -		ADLINK_PCI_VENDOR_ID, ADLINK_PCI_DEVICE_ID,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		PCI_CLASS_NETWORK_OTHER << 8, ~0,
> -		(kernel_ulong_t)&plx_pci_card_info_adlink
> -	},
> -	{
> +		PCI_DEVICE(ADLINK_PCI_VENDOR_ID, ADLINK_PCI_DEVICE_ID),
> +		.class =3D PCI_CLASS_NETWORK_OTHER << 8,
> +		.class_mask =3D ~0,
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_adlink,
> +	}, {
>  		/* Adlink PCI-7841/cPCI-7841 SE */
> -		ADLINK_PCI_VENDOR_ID, ADLINK_PCI_DEVICE_ID,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		PCI_CLASS_COMMUNICATION_OTHER << 8, ~0,
> -		(kernel_ulong_t)&plx_pci_card_info_adlink_se
> -	},
> -	{
> +		PCI_DEVICE(ADLINK_PCI_VENDOR_ID, ADLINK_PCI_DEVICE_ID),
> +		.class =3D PCI_CLASS_COMMUNICATION_OTHER << 8,
> +		.class_mask =3D ~0,
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_adlink_se,
> +	}, {
>  		/* esd CAN-PCI/200 */
> -		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
> -		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI200,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_esd200
> -	},
> -	{
> +		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9050,
> +				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI200),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_esd200,
> +	}, {
>  		/* esd CAN-CPCI/200 */
> -		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
> -		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_CPCI200,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_esd200
> -	},
> -	{
> +		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9030,
> +				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_CPCI200),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_esd200,
> +	}, {
>  		/* esd CAN-PCI104/200 */
> -		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
> -		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI104200,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_esd200
> -	},
> -	{
> +		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9030,
> +				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI104200),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_esd200,
> +	}, {
>  		/* esd CAN-PCI/266 */
> -		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9056,
> -		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI266,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_esd266
> -	},
> -	{
> +		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9056,
> +				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI266),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_esd266,
> +	}, {
>  		/* esd CAN-PMC/266 */
> -		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9056,
> -		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PMC266,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_esd266
> -	},
> -	{
> +		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9056,
> +				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PMC266),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_esd266,
> +	}, {
>  		/* esd CAN-PCIE/2000 */
> -		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9056,
> -		PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCIE2000,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_esd2000
> -	},
> -	{
> +		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9056,
> +				PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCIE2000),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_esd2000,
> +	}, {
>  		/* IXXAT PC-I 04/PCI card */
> -		IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID,
> -		PCI_ANY_ID, IXXAT_PCI_SUB_SYS_ID,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_ixxat
> -	},
> -	{
> +		PCI_DEVICE_SUB(IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID,
> +			       PCI_ANY_ID, IXXAT_PCI_SUB_SYS_ID),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_ixxat,
> +	}, {
>  		/* Marathon CAN-bus-PCI card */
> -		PCI_VENDOR_ID_PLX, MARATHON_PCI_DEVICE_ID,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_marathon_pci
> -	},
> -	{
> +		PCI_VDEVICE(PLX, MARATHON_PCI_DEVICE_ID),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_marathon_pci,
> +	}, {
>  		/* Marathon CAN-bus-PCIe card */
> -		PCI_VENDOR_ID_PLX, MARATHON_PCIE_DEVICE_ID,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_marathon_pcie
> -	},
> -	{
> +		PCI_VDEVICE(PLX, MARATHON_PCIE_DEVICE_ID),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_marathon_pcie,
> +	}, {
>  		/* TEWS TECHNOLOGIES TPMC810 card */
> -		TEWS_PCI_VENDOR_ID, TEWS_PCI_DEVICE_ID_TMPC810,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_tews
> -	},
> -	{
> +		PCI_DEVICE(TEWS_PCI_VENDOR_ID, TEWS_PCI_DEVICE_ID_TMPC810),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_tews,
> +	}, {
>  		/* Connect Tech Inc. CANpro/104-Plus Opto (CRG001) card */
> -		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
> -		PCI_SUBVENDOR_ID_CONNECT_TECH, CTI_PCI_DEVICE_ID_CRG001,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_cti
> -	},
> -	{
> +		PCI_VDEVICE_SUB(PLX, PCI_DEVICE_ID_PLX_9030,
> +				PCI_SUBVENDOR_ID_CONNECT_TECH, CTI_PCI_DEVICE_ID_CRG001),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_cti,
> +	}, {
>  		/* Elcus CAN-200-PCI */
> -		CAN200PCI_VENDOR_ID, CAN200PCI_DEVICE_ID,
> -		CAN200PCI_SUB_VENDOR_ID, CAN200PCI_SUB_DEVICE_ID,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_elcus
> -	},
> -	{
> +		PCI_DEVICE_SUB(CAN200PCI_VENDOR_ID, CAN200PCI_DEVICE_ID,
> +			       CAN200PCI_SUB_VENDOR_ID, CAN200PCI_SUB_DEVICE_ID),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_elcus,
> +	}, {
>  		/* moxa */
> -		MOXA_PCI_VENDOR_ID, MOXA_PCI_DEVICE_ID,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_moxa
> -	},
> -	{
> +		PCI_DEVICE(MOXA_PCI_VENDOR_ID, MOXA_PCI_DEVICE_ID),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_moxa,
> +	}, {
>  		/* ASEM Dual CAN raw */
> -		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> -		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
> -	},
> -	{
> +		PCI_DEVICE_SUB(ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> +			       ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_asem_dual_can,
> +	}, {
>  		/* ASEM Dual CAN raw -new model */
> -		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> -		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS,
> -		0, 0,
> -		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
> +		PCI_DEVICE_SUB(ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> +			       ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS),
> +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_asem_dual_can,
>  	},
> -	{ 0,}
> +	{ }

Nitpick: can you convert the terminating entry to follow the same style
as the rest of the driver:

diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/pl=
x_pci.c
index a03553b80a5d..d69ff0ccfd94 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -353,8 +353,8 @@ static const struct pci_device_id plx_pci_tbl[] =3D {
                 PCI_DEVICE_SUB(ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE=
_ID,
                                ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SU=
B_DEVICE_ID_BIS),
                 .driver_data =3D (kernel_ulong_t)&plx_pci_card_info_asem_d=
ual_can,
-        },
-        { }
+        }, {
+        }
 };
 MODULE_DEVICE_TABLE(pci, plx_pci_tbl);

>  };
>  MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--v5gtri26mw6juc6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCafHK+wAKCRDMOmT6rpmt
0kuPAP4rY0fDutYzl1X17t0y+XEGDgmxOmjPiXuxZCBfayCaXgD7BrMtvC4i+l07
M4r5isb3cwO71VZn6lO9ZL8xNJtpyAo=
=hO9H
-----END PGP SIGNATURE-----

--v5gtri26mw6juc6y--

