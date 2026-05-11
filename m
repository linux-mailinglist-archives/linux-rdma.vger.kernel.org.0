Return-Path: <linux-rdma+bounces-20386-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FkILZfEAWqSjgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20386-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 13:59:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA050D3D1
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 13:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD4BF303E114
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 11:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67256377EC2;
	Mon, 11 May 2026 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvjdQJFh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C71E834E;
	Mon, 11 May 2026 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500686; cv=none; b=slMQseFraC212RSeLdIM9p9fvZvxJQ/FtPi+kCKuxANSc9dsZsr96SKRIPWiiCOeUPjmeYCyImHorwrZffh5NML5xmccrSAjmPJgHG04P6bO2R2EZKm4n2843Dgeiat/Gd/u+ywtKCWPuomcH/9vCOuYPEIy15N7D8K8L+2BKyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500686; c=relaxed/simple;
	bh=KF1t/bRGs16yza3DBTgFCMGGOZGbS2ZRe4/jmsnl72o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEE5iAV2SSMvZPOr5ybz+dZwffGpWCLRwkujJSnHj/O7LgeHZTejvl9D2oOPDHrDh+UqpNhoWfL2vS5gM5R/EmkkQ6lqjcTxMayz5+cNPs8s93R6ZXiQEQ5vMhmCdq9UQ5bfGEa5KCAbLMlQ8N05miZbgnd9SMohrzeixg+mQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvjdQJFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD16EC2BCF7;
	Mon, 11 May 2026 11:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500686;
	bh=KF1t/bRGs16yza3DBTgFCMGGOZGbS2ZRe4/jmsnl72o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvjdQJFhfyjs3E/5QNKeFp1jTRAOxDNvz4Mh8U1RxGbjks/gpXVIlmydk3WFacZhD
	 l3f9a2vKk3bOmeWc34go+yHhoRM3iBRq3LZ8M7XZ59udEW1MqdS7mKupb4h1wVV4Do
	 KkvCSR3C+uHG3tH2YS5uwHfM+9OpvFxe4qYtM2DSiMg7qYdP1QRCHem+lUwMYjOqmr
	 X5gNyzzBOvSy7yuBJdyKREHmHjj5av7KbAFq6bfRiAEx+MwwD+2sRATPB1Q8jc1b4u
	 FTEA9GZv56qYWosTkb/DEeuVpP3AGfbpItzeaDDDn/7i4IwntV9jTHGbBse/kGCO8p
	 EO/cNlRqVgdlg==
Date: Mon, 11 May 2026 13:57:49 +0200
From: Michael Grzeschik <mgr@kernel.org>
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Steffen Klassert <klassert@kernel.org>,
	David Dillow <dave@thedillows.org>,
	Ion Badulescu <ionut@badula.org>, Mark Einon <mark.einon@gmail.com>,
	Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Manish Chopra <manishc@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Denis Kirjanov <kirjanov@gmail.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Cai Huoqing <cai.huoqing@linux.dev>, Fan Gong <gongfan1@huawei.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Yibo Dong <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Jiri Pirko <jiri@resnulli.us>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Daniele Venzano <venza@brownhat.org>,
	Samuel Chessman <chessman@tux.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Kevin Curtis <kevin.curtis@farsite.co.uk>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Arinzon <darinzon@amazon.com>,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yicong Hui <yiconghui@gmail.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Ian Lin <ian.lin@infineon.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Double Lo <double.lo@cypress.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	linux-parisc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH net-next v3 2/2] net: Consistently define pci_device_ids
 using named initializers
Message-ID: <agHEPQ5tLFKW0uum@pengutronix.de>
References: <20260511090023.1634387-4-u.kleine-koenig@baylibre.com>
 <20260511090023.1634387-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511090023.1634387-6-u.kleine-koenig@baylibre.com>
X-Rspamd-Queue-Id: 2CCA050D3D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,sipsolutions.net,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,amazon.com,infradead.org,ti.com,infineon.com,cypress.com,baylibre.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-20386-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[80];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgr@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,huawei.com:email,nvidia.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 11:00:24AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> ... and PCI device helpers.
> 
> The various struct pci_device_id arrays were initialized mostly by one
> the PCI_DEVICE macros and then list expressions. The latter isn't easily
> readable if you're not into PCI. Using named initializers is more
> explicit and thus easier to parse.
> 
> Also use PCI_DEVICE* helper macros to assign .vendor, .device,
> .subvendor and .subdevice where appropriate and skip explicit
> assignments of 0 (which the compiler takes care of).
> 
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.
> 
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.
> 
> Reviewed-by: Jijie Shao <shaojijie@huawei.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com> # for mlxsw
> Acked-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> Forwarded: id:76da4f44d48bdde84580963862bf9616bee5c9e9.1778149923.git.u.kleine-koenig@baylibre.com (v2)
> ---
>  drivers/net/arcnet/com20020-pci.c             | 242 +++------

[...]

> diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
> index dbadda08dce2..6474c7be2992 100644
> --- a/drivers/net/arcnet/com20020-pci.c
> +++ b/drivers/net/arcnet/com20020-pci.c
> @@ -459,168 +459,88 @@ static struct com20020_pci_card_info card_info_eae_fb2 = {
>  
>  static const struct pci_device_id com20020pci_id_table[] = {
>  	{
> -		0x1571, 0xa001,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		0,
> +		PCI_DEVICE(0x1571, 0xa001),
> +		.driver_data = 0,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa002),
> +		.driver_data = 0,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa003),
> +		.driver_data = 0,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa004),
> +		.driver_data = 0,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa005),
> +		.driver_data = 0,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa006),
> +		.driver_data = 0,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa007),
> +		.driver_data = 0,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa008),
> +		.driver_data = 0,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa009),
> +		.driver_data = (kernel_ulong_t)&card_info_5mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa00a),
> +		.driver_data = (kernel_ulong_t)&card_info_5mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa00b),
> +		.driver_data = (kernel_ulong_t)&card_info_5mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa00c),
> +		.driver_data = (kernel_ulong_t)&card_info_5mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa00d),
> +		.driver_data = (kernel_ulong_t)&card_info_5mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa00e),
> +		.driver_data = (kernel_ulong_t)&card_info_5mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa201),
> +		.driver_data = (kernel_ulong_t)&card_info_10mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa202),
> +		.driver_data = (kernel_ulong_t)&card_info_10mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa203),
> +		.driver_data = (kernel_ulong_t)&card_info_10mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa204),
> +		.driver_data = (kernel_ulong_t)&card_info_10mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa205),
> +		.driver_data = (kernel_ulong_t)&card_info_10mbit,
> +	}, {
> +		PCI_DEVICE(0x1571, 0xa206),
> +		.driver_data = (kernel_ulong_t)&card_info_10mbit,
> +	}, {
> +		PCI_DEVICE_SUB(0x10B5, 0x9030, 0x10B5, 0x2978),
> +		.driver_data = (kernel_ulong_t)&card_info_sohard,
> +	}, {
> +		PCI_DEVICE_SUB(0x10B5, 0x9050, 0x10B5, 0x2273),
> +		.driver_data = (kernel_ulong_t)&card_info_sohard,
> +	}, {
> +		PCI_DEVICE_SUB(0x10B5, 0x9050, 0x10B5, 0x3263),
> +		.driver_data = (kernel_ulong_t)&card_info_eae_arc1,
> +	}, {
> +		PCI_DEVICE_SUB(0x10B5, 0x9050, 0x10B5, 0x3292),
> +		.driver_data = (kernel_ulong_t)&card_info_eae_ma1,
> +	}, {
> +		PCI_DEVICE_SUB(0x10B5, 0x9050, 0x10B5, 0x3294),
> +		.driver_data = (kernel_ulong_t)&card_info_eae_fb2,
> +	}, {
> +		PCI_DEVICE(0x14BA, 0x6000),
> +		.driver_data = (kernel_ulong_t)&card_info_10mbit,
> +	}, {
> +		PCI_DEVICE(0x10B5, 0x2200),
> +		.driver_data = (kernel_ulong_t)&card_info_10mbit,
>  	},
> -	{
> -		0x1571, 0xa002,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		0,
> -	},
> -	{
> -		0x1571, 0xa003,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		0
> -	},
> -	{
> -		0x1571, 0xa004,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		0,
> -	},
> -	{
> -		0x1571, 0xa005,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		0
> -	},
> -	{
> -		0x1571, 0xa006,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		0
> -	},
> -	{
> -		0x1571, 0xa007,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		0
> -	},
> -	{
> -		0x1571, 0xa008,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		0
> -	},
> -	{
> -		0x1571, 0xa009,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_5mbit
> -	},
> -	{
> -		0x1571, 0xa00a,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_5mbit
> -	},
> -	{
> -		0x1571, 0xa00b,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_5mbit
> -	},
> -	{
> -		0x1571, 0xa00c,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_5mbit
> -	},
> -	{
> -		0x1571, 0xa00d,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_5mbit
> -	},
> -	{
> -		0x1571, 0xa00e,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_5mbit
> -	},
> -	{
> -		0x1571, 0xa201,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_10mbit
> -	},
> -	{
> -		0x1571, 0xa202,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_10mbit
> -	},
> -	{
> -		0x1571, 0xa203,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_10mbit
> -	},
> -	{
> -		0x1571, 0xa204,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_10mbit
> -	},
> -	{
> -		0x1571, 0xa205,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_10mbit
> -	},
> -	{
> -		0x1571, 0xa206,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_10mbit
> -	},
> -	{
> -		0x10B5, 0x9030,
> -		0x10B5, 0x2978,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_sohard
> -	},
> -	{
> -		0x10B5, 0x9050,
> -		0x10B5, 0x2273,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_sohard
> -	},
> -	{
> -		0x10B5, 0x9050,
> -		0x10B5, 0x3263,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_eae_arc1
> -	},
> -	{
> -		0x10B5, 0x9050,
> -		0x10B5, 0x3292,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_eae_ma1
> -	},
> -	{
> -		0x10B5, 0x9050,
> -		0x10B5, 0x3294,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_eae_fb2
> -	},
> -	{
> -		0x14BA, 0x6000,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_10mbit
> -	},
> -	{
> -		0x10B5, 0x2200,
> -		PCI_ANY_ID, PCI_ANY_ID,
> -		0, 0,
> -		(kernel_ulong_t)&card_info_10mbit
> -	},
> -	{ 0, }
> +	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(pci, com20020pci_id_table);

For the com20020 arcnet driver:

Reviewed-by: Michael Grzeschik <mgr@kernel.org>

