Return-Path: <linux-rdma+bounces-19719-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JFlLGSr8WkAjgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19719-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 08:55:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0E549007D
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 08:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B104300EDAE
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20DF39DBC7;
	Wed, 29 Apr 2026 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRYNGpKk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D339BFE7;
	Wed, 29 Apr 2026 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445716; cv=none; b=iCNcOo5r1JhTh9JhfmXjBcSbNMiIiNydzesToF6qZ1vKlr1PlYTTAS3LoB75+wGqXyAnnJqssvTxr+AiT2sGx5K77xbBPs17VL6idN28vz0FZvddLHAiLzI4VcSgyDgqcJoVsp/5Y3RukPV1i8R/HUsNbhLk73CMyvBBrc2y4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445716; c=relaxed/simple;
	bh=kYYeufPkRyGcr0hiIW6bKGaXhz8Q+nnaSSo0fxSS6co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWdJy73NlEUWD1wNquPzln6IAf1BxlgxtcCXILsqpY95sYe3/5GW/kE0JsNUNgU6v30G/L9/8w49Fv+EzvvAWmozlyMm/Q8FGg3RbU5L8t6CaZdbofQtmzpKrHX/PS6Xv9LZtO8h/Qk5m6d0Ewbimrh13p9H1ZFG1nNlSGR/XhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRYNGpKk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777445715; x=1808981715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kYYeufPkRyGcr0hiIW6bKGaXhz8Q+nnaSSo0fxSS6co=;
  b=mRYNGpKkdPZn92Js4w44vvHbhSgXVXy1f8mAr+/9W1FABmA43BvjO7EP
   GVD0J2RI12BQWLSVn+4pSjmpK3tJLexJPN1TP7IkIGvcp1XQ3/d//xFrS
   CJp3WQFbkvgN16LA4psH1fQ+t2XLRziSgU91OeRpokNK6AaSQAq0gdaSG
   uvWDZk0FksjFnREON71yB0shU5ojBgYqTUbdKAnKCfQpfx76Fc62Dnd3u
   WaBINNRZ0vVuN8peK/uponY/3gyaThgUpnevzRqr5fFlkDu/NtPvnOYcD
   K8l9VlBFLlOf6aC4AUDY9hYTH3ZFoMnxoSpVTUBBdaTPfOlQyc0M39ger
   w==;
X-CSE-ConnectionGUID: UupN5YIITw+bGaoBrMuS9g==
X-CSE-MsgGUID: BFAAvPR8QBqruOecGbaejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89456642"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="89456642"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 23:55:14 -0700
X-CSE-ConnectionGUID: NWCIGupGRW+k5c69AnHXJQ==
X-CSE-MsgGUID: 5oHPhrg7Q1iV2x0zLMtPhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="235958719"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 23:54:56 -0700
Date: Wed, 29 Apr 2026 09:54:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Johannes Berg <johannes@sipsolutions.net>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Steffen Klassert <klassert@kernel.org>,
	David Dillow <dave@thedillows.org>,
	Ion Badulescu <ionut@badula.org>, Mark Einon <mark.einon@gmail.com>,
	Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Sudarsana Kalluru <skalluru@marvell.com>,
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
	Yibo Dong <dong100@mucse.com>, Simon Horman <horms@kernel.org>,
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
	Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Yicong Hui <yiconghui@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sai Krishna <saikrishnag@marvell.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>,
	Double Lo <double.lo@cypress.com>,
	Chi-hsien Lin <chi-hsien.lin@cypress.com>,
	Colin Ian King <colin.i.king@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	linux-parisc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
Message-ID: <afGrPvUeZ-DjWbC8@ashevche-desk.local>
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 7E0E549007D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pm.waw.pl,sipsolutions.net,baylibre.com,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-19719-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[84];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,ashevche-desk.local:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 07:18:44PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
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

...

> -	{0,}						/* 0 terminated list. */
> +	{ }						/* 0 terminated list. */

The comments like these are just noises. The rule of thumb is to play with a
trailing comma:
- always drop it in the terminator entry
- always keep it in the normal initialisers when semantically it's not a
terminator

...

>  static const struct pci_device_id liquidio_pci_tbl[] = {
>  	{       /* 68xx */
> -		PCI_VENDOR_ID_CAVIUM, 0x91, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
> +		PCI_VDEVICE(CAVIUM, 0x91)

Use full fixed-width device id value(s). 0x0091 here and so on...

>  	},

Also seems that you may decrease number of LoC here putting it as

	{ PCI_VDEVICE(CAVIUM, 0x0091) }, /* 68xx */

and so on...

>  	{       /* 66xx */
> -		PCI_VENDOR_ID_CAVIUM, 0x92, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
> +		PCI_VDEVICE(CAVIUM, 0x92)
>  	},
>  	{       /* 23xx pf */
> -		PCI_VENDOR_ID_CAVIUM, 0x9702, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
> +		PCI_VDEVICE(CAVIUM, 0x9702)
>  	},
> -	{
> -		0, 0, 0, 0, 0, 0, 0
> -	}
> +	{ }
>  };

...

>  #define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
> -		{ 0, } \
> +		{ } \
>  	}

Why do we have this macro at all?


> -#define CH_PCI_DEVICE_ID_TABLE_DEFINE_END { 0, } }
> +#define CH_PCI_DEVICE_ID_TABLE_DEFINE_END { } }

Ditto.

...

>  static const struct pci_device_id de_pci_tbl[] = {
> -	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TULIP,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> -	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TULIP_PLUS,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
> +	{ PCI_VDEVICE(DEC, PCI_DEVICE_ID_DEC_TULIP), .driver_data = 0 },
> +	{ PCI_VDEVICE(DEC, PCI_DEVICE_ID_DEC_TULIP_PLUS), .driver_data = 1 },
>  	{ },

Drop comma. I.o.w. please make sure you also unify the style of the ID tables,
including terminator entries.

>  };

...

>  static const struct pci_device_id sis190_pci_tbl[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x0190), 0, 0, 0 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x0191), 0, 0, 1 },
> -	{ 0, },
> +	{ PCI_VDEVICE(SI, 0x0190), .driver_data = 0 },
> +	{ PCI_VDEVICE(SI, 0x0191), .driver_data = 1 },
> +	{ },

Ditto and so on...

>  };

...

Also I somehow managed to remove, but I remember you had an inner comma in some
cases after the .driver_data, when the full ID entry is located on a single
line. I.o.w. do

	{ PCI_...(), .driver_data = ... // no trailing comma here! },

When it's a single line trailing comma inside helps nothing and just makes
lines longer and harder to read.

-- 
With Best Regards,
Andy Shevchenko



