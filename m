Return-Path: <linux-rdma+bounces-19690-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFR0DzwM8Wn1cAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19690-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 21:36:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB9848B30A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 21:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AFB130511D3
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D67437D12F;
	Tue, 28 Apr 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="t+YbivMk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF0F3B1B3;
	Tue, 28 Apr 2026 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404975; cv=none; b=ngrnt32KvkDR8AEuA12UXc2Lv18e7sB+HufuvDYC90jhGgSF/ZXbYOdM7CqUyi2Lk1b/1jZ0n1t+b0PwXKkCBOx8+Py4Sggt+ZCT0soSi9owxVAGNzurVEwyRvwwpJsClQ6Ffr5bjH/p33F4PFRn8zbny97j2BDs9HSrdMleYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404975; c=relaxed/simple;
	bh=zOwN+vmm3V4wCA7oDAuZ2hRwBkdC1xOrDBkrylXjsvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sWLGRSEGmjVjN7Zc6pp50MGizj9y36eSnTQZS+PtqChxYO/KyQCtxRcc1b/fUcefD4NNYErExX9/wIy7E1C1Et0ZkVaWJ/+ststDvJ8DIwijn3WAHexfzOuP34S12QmxOpk9fokRB0cHUDw8gx1iFYi1cot/AJcWRo7gmaFQSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=t+YbivMk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iRxzu9RmmpZ7pX5zdGly9rKj0q1oCfBMxB/0kO0YbvI=;
	t=1777404973; x=1778614573; b=t+YbivMkCOBXHDISxOHwFmEUIC0Y6eWvuf49xCGssvytXbg
	2eqlx6U6uPI0KA9ly22HmpHQgh4rhAKrGczdwB7wUYg6TEifmJMXzG0dofIo9WAP15IGx1h+wvnbv
	sGBy9xcf9IMtb0yv1Vmnn1x9StBEJ1IymD/VuT8C2xKVunmhs3c5YH89W8a3gWUncbP/hptzM2vlR
	o/gg3KGfPIYf2Lq2QKDBlkEP9vG5CTpzrB/48fiIMIiLUEzyfjOrTEDYK6dCFivqja61tr6CK9uxv
	YwklkW82Al9ZfZxoGPcSd+PdBhAwzF5+JgYw0DwV/7+zf1z6mUI3oxhqWGptP4RQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHoD6-0000000154Q-0Yr2;
	Tue, 28 Apr 2026 21:35:08 +0200
Message-ID: <54d6fd70b123bf7c158e8e97817b0b3a033205b2.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
From: Johannes Berg <johannes@sipsolutions.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= "(The Capable Hub)"	
 <u.kleine-koenig@baylibre.com>, Michael Grzeschik
 <m.grzeschik@pengutronix.de>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol	 <mailhol@kernel.org>,
 Krzysztof Halasa <khc@pm.waw.pl>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Steffen Klassert	
 <klassert@kernel.org>, David Dillow <dave@thedillows.org>, Ion Badulescu	
 <ionut@badula.org>, Mark Einon <mark.einon@gmail.com>, Rasesh Mody	
 <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Sudarsana Kalluru	
 <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Potnuri Bharat
 Teja <bharat@chelsio.com>, Denis Kirjanov <kirjanov@gmail.com>, Jijie Shao	
 <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, Cai Huoqing	
 <cai.huoqing@linux.dev>, Fan Gong <gongfan1@huawei.com>, Tony Nguyen	
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Tariq Toukan <tariqt@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,  Mark
 Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>,  Yibo Dong <dong100@mucse.com>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>, Francois Romieu	
 <romieu@fr.zoreil.com>, Daniele Venzano <venza@brownhat.org>, Samuel
 Chessman	 <chessman@tux.org>, Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan
 Lou	 <mengyuanlou@net-swift.com>, Kevin Curtis
 <kevin.curtis@farsite.co.uk>,  Arend van Spriel
 <arend.vanspriel@broadcom.com>, Stanislav Yakovlev
 <stas.yakovlev@gmail.com>, Richard Cochran	 <richardcochran@gmail.com>,
 Kees Cook <kees@kernel.org>, Thomas Gleixner	 <tglx@kernel.org>, Thomas
 Fourier <fourier.thomas@gmail.com>, Ingo Molnar	 <mingo@kernel.org>, Kory
 Maincent <kory.maincent@bootlin.com>, Zilin Guan	 <zilin@seu.edu.cn>, Marco
 Crivellari <marco.crivellari@suse.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Jacob Keller <jacob.e.keller@intel.com>,
 Philipp Stanner	 <phasta@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Yeounsu Moon	 <yyyynoom@gmail.com>, Denis Benato
 <benato.denis96@gmail.com>, Peiyang Wang	 <wangpeiyang1@huawei.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Yicong Hui <yiconghui@gmail.com>, Randy
 Dunlap	 <rdunlap@infradead.org>, MD Danish Anwar <danishanwar@ti.com>,
 Nathan Chancellor <nathan@kernel.org>, Sai Krishna
 <saikrishnag@marvell.com>, Ethan Nelson-Moore	 <enelsonmoore@gmail.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Joe Damato	 <joe@dama.to>,
 Double Lo <double.lo@cypress.com>, Chi-hsien Lin	
 <chi-hsien.lin@cypress.com>, Colin Ian King <colin.i.king@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, 	linux-parisc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, 	linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, 	linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, 	brcm80211-dev-list.pdl@broadcom.com
Date: Tue, 28 Apr 2026 21:35:05 +0200
In-Reply-To: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com> (sfid-20260428_191919_544927_6ED8AE93)
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
	 (sfid-20260428_191919_544927_6ED8AE93)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: DBB9848B30A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19690-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,google.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[84];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:email,sipsolutions.net:dkim,sipsolutions.net:mid]

On Tue, 2026-04-28 at 19:18 +0200, Uwe Kleine-K=C3=B6nig (The Capable Hub)
wrote:
>=20
> I handled all of drivers/net/ in a single patch, please tell me if I
> should split by subsystem.

I guess wireless would be the one not in net-next initially normally,
but

>  .../broadcom/brcm80211/brcmfmac/pcie.c        |  17 +-
>  drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  52 +-

Nobody has been touching *that* code, so from my perspective this is
fine.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

