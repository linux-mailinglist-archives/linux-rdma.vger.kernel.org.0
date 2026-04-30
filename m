Return-Path: <linux-rdma+bounces-19791-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAwFL4J182mt4AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19791-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 17:30:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F784A4C9D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 17:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFFF304D402
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66932C08D4;
	Thu, 30 Apr 2026 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DhiPvYAw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010282E03E4
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562501; cv=none; b=AQCTE+vYyytddIMjiCHtKsiooaTP+90nuQKUZZ/msYBXxjDlzNp7Ns9jAw+hLlV39D2GSOVVsSKTzvkeF3msKvbfsZt2on0HkTNBj+clDe5D+gu1j6q+KAcHSKU9mxubQM2oLlK0VXKqKlXJlpiu6jINtPJPseYwvNXJp+D6UlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562501; c=relaxed/simple;
	bh=jfvurasXyO172rf8RueovQ21HocKi4qC6cmZUk6WC5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYl0l/A0J4X8OPe//bNW54LulntHlLgrcKDDtR2M3ewIMK7q0RaRAeHvyZmc8d+Bb7mmMiMeFKl3vd77wFYEmY5pjY/2CeBL8fZCxY1wAPay4hdz82msDz0J60Hx3xYKef5xBQcJoFci76IoI/N2NS2DSalQOU8o4hFBg+1l0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DhiPvYAw; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-694891f8f75so555563eaf.1
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 08:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562499; x=1778167299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6W7N3TF0u0m9VhuQZcYonFJHVZpaP1eZOWODDM2/uM=;
        b=n+2qpGjtFPunMGKfGtvV3WFwbq4ABg8izRGUQGogJm8j/IGgqtV642ED1clbFMb4c/
         Zl/6ztlRZPIxl9z5NXhFCmuFleocwpJgeKO4M4ggoFrywxt8z6edebS8F+vTKyPvWs99
         ca1GyNF2/mIikVowjmdzf+P0Hr+vE6ujWtcx4kImVijM2cZRen8/pKz7eox1gXOgRtiW
         3J/J6KMHHQ2u2U6Dtn3ZttPZUdHaXISmBWE3UIpbTZAm+fWd4D3+r3Y41+lr+mq/w9NQ
         Xtoik2yASVO7xPg5VSyYe1W/UdQeLoph2Q1ZmA2lAtJ3vl22ki8D7NsTB+3RMBT5QNER
         7frw==
X-Forwarded-Encrypted: i=1; AFNElJ/zDZIMOONncxO9dV/9K+f04Ef9wAonX9w1dOtc0ktILypMgg3vK5IVAE8Cdo1lLISdjqwviK+oWLJM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0KjdBjLL0QKZFIA46ldCfsDtaT09Zu14SkJTALALuqKSgmbBg
	7qY4kJDKCz3knWrbCYoANoS7AuJN5DFuaMy+Db0x6xKNpzipTJbq9Zkt47YKtyVZ3uNjGTNqEOt
	JJJqHKRMzjvHAf+e1sJGOsOcFWb8VUAcWhmACtgofqw0d7UqkeRn0FF9mn564VTXhQwxnyPiTTu
	A+ek6M5VwAZqsDEURtqr9vewbz7FckFCgcwbEpWfrCIlGabYBsLwtsb/2o99rNDragPHWNhwUzu
	e/3YltJ42iOOl1zTN2W2WE=
X-Gm-Gg: AeBDieud3JGPip6vBzZnJ1NDpdu3Nhyt7DMrG6WfS7JB8jBaExKN/jfE9S0n5kQcinQ
	pquSGc5WjIO7H14d2+y7NIPgefATbTWPqTx4WOuzcKPnoTRXUaMRhD6oFu977BvhHoeG4ITRvau
	H2ZOF5oCFEfoLDyCIpebWtMLbDmLdF/Rea/uq2T8RYVs7waL7w6fPcwCnYvUSObR+ngPmUKXVDm
	IVySthdFZ7khjamosQme/xxmgU9avyH+Ehfdcxdq6Gv4bdhDtEeNk86HFwfs3qhjWdk43ymgdR+
	sfZXHVq6FRUdhHgPJXnisf2fOYTR909pPyoVwMWaXe8cPBz/gJFXGSdSrGH03f80kQwYOPXY2pH
	2FmDQQumhAS0v+4EvEMOYmYaqglGavpNBqENtn6dHBL5J+2YeP7oJqRYFRuAeQa325/a5m055ed
	+0rwZl0Ngq90N1d7dXEnWfNK7cysY37qBkPVx+u6Lafhsqqi1YabSMDa0unCGqeUm8e8ocYj8=
X-Received: by 2002:a05:6820:614:b0:696:6c93:e81f with SMTP id 006d021491bc7-6967a5c1912mr1575076eaf.33.1777562498569;
        Thu, 30 Apr 2026 08:21:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6966b9d3ec4sm303721eaf.5.2026.04.30.08.21.38
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2026 08:21:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2cc75e79b97so3009288eec.1
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777562497; x=1778167297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6W7N3TF0u0m9VhuQZcYonFJHVZpaP1eZOWODDM2/uM=;
        b=DhiPvYAwf4d5dCCd0+orXhiXUo9QKfsGKxOV68+k6o3XqvkpwM0WAdAT6w1rqV4J8P
         A0EEeHdfeQSPNTxxybEzh7ijgNSNoN39VOIrVnJbFQO7MlMF500rB8VZSYmB8WmWFSxf
         CU3PZ/oQX+lI8BSfi0rjofT7i0p6zrHNuGBEQ=
X-Forwarded-Encrypted: i=1; AFNElJ8AdSkuO4fCZorXO4qyzV84fL5aDJyCrcLkWux6k/xMOXbU+gv6eXNSuvdaCx5dkWV0c46ecZ+4KGKX@vger.kernel.org
X-Received: by 2002:a05:7300:fd03:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2ed3e386a41mr1602844eec.28.1777562094291;
        Thu, 30 Apr 2026 08:14:54 -0700 (PDT)
X-Received: by 2002:a05:7300:fd03:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2ed3e386a41mr1602745eec.28.1777562093564;
        Thu, 30 Apr 2026 08:14:53 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71ccesm286774eec.10.2026.04.30.08.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 08:14:52 -0700 (PDT)
Message-ID: <f817f781-43d5-40d0-9352-20769d9a6601@broadcom.com>
Date: Thu, 30 Apr 2026 17:14:36 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Steffen Klassert <klassert@kernel.org>, David Dillow <dave@thedillows.org>,
 Ion Badulescu <ionut@badula.org>, Mark Einon <mark.einon@gmail.com>,
 Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
 Ido Schimmel <idosch@nvidia.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Denis Kirjanov <kirjanov@gmail.com>,
 Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Fan Gong <gongfan1@huawei.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Yibo Dong <dong100@mucse.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>,
 Francois Romieu <romieu@fr.zoreil.com>, Daniele Venzano
 <venza@brownhat.org>, Samuel Chessman <chessman@tux.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, Kevin Curtis <kevin.curtis@farsite.co.uk>,
 Stanislav Yakovlev <stas.yakovlev@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Kees Cook <kees@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Thomas Fourier
 <fourier.thomas@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Zilin Guan <zilin@seu.edu.cn>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jacob Keller <jacob.e.keller@intel.com>, Philipp Stanner
 <phasta@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Yeounsu Moon <yyyynoom@gmail.com>, Denis Benato <benato.denis96@gmail.com>,
 Peiyang Wang <wangpeiyang1@huawei.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Yicong Hui <yiconghui@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 MD Danish Anwar <danishanwar@ti.com>, Nathan Chancellor <nathan@kernel.org>,
 Sai Krishna <saikrishnag@marvell.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>,
 Double Lo <double.lo@cypress.com>, Chi-hsien Lin
 <chi-hsien.lin@cypress.com>, Colin Ian King <colin.i.king@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, linux-parisc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 92F784A4C9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,thedillows.org,badula.org,gmail.com,marvell.com,nvidia.com,chelsio.com,huawei.com,linux.dev,intel.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,bootlin.com,seu.edu.cn,suse.com,google.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev,broadcom.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-19791-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[84];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

On 28/04/2026 19:18, Uwe Kleine-König (The Capable Hub) wrote:
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

for brcmfmac change...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
[...]

>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  17 +-
>   drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  52 +-
>   69 files changed, 1308 insertions(+), 1101 deletions(-)

