Return-Path: <linux-rdma+bounces-19561-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCneFBsQ7mndqQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19561-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 15:16:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57206469EA9
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CE0A3004050
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A873624BC;
	Sun, 26 Apr 2026 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ic6KsYgG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03D19CD0A
	for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777209361; cv=none; b=tE7ejCscPjtocNybbLSVvG0lz6+dDV41K3ze5Fj959ndmIjj4Q+2YOlhG+iaU5J/c8ksFg98bS8hTZDOJ3J/q9Y7f3/vUQeRqDO50kfEeTpFVmPoT7kLWq2u8fOvwyGiRc7v6TRRqHsXWW5rzh2x5dfx8BxZ0zQIbVP0/nM3KPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777209361; c=relaxed/simple;
	bh=eyKjK9DnmrMAk5/TDuX9Ob6Z7Uj0pC06AmilCu18QOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onmd1ZGyj4oyTNM0GWJumALw6/XhOB4Nos0/GV15fzuGsw6eNg7oCVIGM521UssRh8ir/cBST0quKOYGrL9+emRzZdExELixGtrdacprczJRFRtbrQ2Yy+x4vuhGVzQreYjRvtBuHN67ZOV5gPyP0QbDk8uMUuP8qFtQhEmJWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ic6KsYgG; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e5c5033f6so64915551cf.0
        for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777209357; x=1777814157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hWkzkPAt0w9C0nxCrWB+8VxSXZOrmsyO57QsFIVVZU=;
        b=ic6KsYgGNoeG6h9tCNcjsbujNQzxJJBdQFLVtrq4uoMrBDZjWv4JVPLONCdaeiADlL
         d2dXIARFaE48OewbCK18Vo5kc0zTHnjp6AlG++XxlvzhaRBQqNyZusZDZRKxXFsxjWIB
         EJGCXedGJQqWW7fuG4QkW/ut1csHnFgCj9KZC8cpMKbdCMVpfjJv0W1vcLp3c7IQmsVF
         YPoIwmb4i58PrtblLxH/L3OzmRo37Fy+Dckpw5L8GeyT72YVEcqvv+30B/HGQjFcQDKj
         QuFHyhZMUqKiCqE70G+gCI0XZtLleBbo+WAg0HJwsZnbAAMMB/70WEZJtLFk9rlfnj8j
         1mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777209357; x=1777814157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hWkzkPAt0w9C0nxCrWB+8VxSXZOrmsyO57QsFIVVZU=;
        b=O236i5hz4760khQlKdOY96pkkyoZGO8T/1TU4/aEVXYGdP7bprLKndnVqWRuHN6PKR
         P1EMW58Z+7pOjjqNLAx6Y5MgGeC1JyXLyVO4/mrqCdK9OOUPp6uoTrOHR5BVr12rPuAL
         6vvgwhGz24e7tag4lAQNYNL/7TNiUbSRlpmeguJTLLrO4HGhF6/iIvPi7USZfrQnKPKw
         JglU65wmp2kdPCJiO2WL5SNXV9R5VbwJswgnzhUS9xN5e3FSBn4+0/t8DQNTcxyC/09Q
         wF0bXqUiHkp4Ge9FViT4KXXyHwwScW8gA8jKngV6pZpk6JCZtxL0oFclDH2yQiYiSoWt
         Wc9w==
X-Forwarded-Encrypted: i=1; AFNElJ/lmhT5OCeDl6fzLsRUzL8a/LPiFxm1dSmXdjoPzbqvr9HmQ6WRYLqc5vqIvw44enVi6mRKCHC/mb9e@vger.kernel.org
X-Gm-Message-State: AOJu0YznboDMmJpZ1OS/xK5YnWraGLw0mu/V628TlZyPy8V9Rndh6Mof
	4XH0OJmZkgsfjDHAMnH5Gckxp8mvEkLr7bW+iXfVs23M3rxKrpTf7nXCgG6qjb+8qck=
X-Gm-Gg: AeBDieuEofUCibKJSKuTFjwQekXlrUokHoHSwiIsy4cZlO6ufm7cnr7599bXC5Neb23
	/Fh0B8+OkHyimLBvkBQGwjcWmj4BIBecZn//FHSEFqYxGvVdmS87utxo4ZSaqGbs1WafIanohNP
	ChCUEpx7y8/LqvsTbNcV8nl/xu81KGNCWQyyQSsyUaE4g7zTfbSD/uJrXz0LB/Gq6NflDfmVW/Y
	UKtNv68aE3czxUVcrZpVBuKtEp//iP5MexpWZuco7uxhljVnqydNMfUEGEXzHDlbgOXLknuEbNY
	lSn5r21Mqohc8GtjJdq/6cxgu7sYWfCTJoorfM4MVsIxnOcqa6z33C1bZ9rb3k8H0gmFD89wRJ1
	bRUPiEhAWjpY9Ig4G99ypjpvcbbqtViTHve8nWGSGqOyoNItcBOK2hwgHn+aE6DmFePFLlX4hCI
	t0FoXpieVjUyv7CzqpnE24LXf3AokUxwJpRejIDICY+8dDyDW9CEythL42RZa8mS+FVBZ9hpuCJ
	WsEjQjhew8FAv7I
X-Received: by 2002:a05:622a:1189:b0:50d:84a7:72d0 with SMTP id d75a77b69052e-50e36e9c0c7mr584902211cf.36.1777209357541;
        Sun, 26 Apr 2026 06:15:57 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39487921sm230305001cf.24.2026.04.26.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 06:15:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGzL1-0000000Ejbg-22WN;
	Sun, 26 Apr 2026 10:15:55 -0300
Date: Sun, 26 Apr 2026 10:15:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	jacob.e.keller@intel.com, dipayanroy@microsoft.com,
	leitao@debian.org, kees@kernel.org, john.fastabend@gmail.com,
	hawk@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: Re: [PATCH net] net: mana: hardening: Validate SHM offset from BAR0
 register to prevent crash due to alignment fault
Message-ID: <20260426131555.GA3501894@ziepe.ca>
References: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Queue-Id: 57206469EA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19561-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 09:16:28AM -0700, Dipayaan Roy wrote:
> During Function Level Reset recovery, the MANA driver reads
> hardware BAR0 registers that may temporarily contain garbage values.
> The SHM (Shared Memory) offset read from GDMA_REG_SHM_OFFSET is used
> to compute gc->shm_base, which is later dereferenced via readl() in
> mana_smc_poll_register(). If the hardware returns an unaligned or
> out-of-range value, the driver must not blindly use it, as this would
> propagate the hardware error into a kernel crash.

It is not what we are calling "hardening" if you are hitting actual
crashes in actual real systems.

"hardening" is the driver defending against actively malicious
hardware, operating in ways that will never be seen in real systems,
attempting to compromise the kernel.

Drivers working around real world broken/buggy/malfunctioning HW is
just entirely normal stuff.

> @@ -73,10 +74,25 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
>  	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
>  
>  	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
> +	if (sriov_base_off >= gc->bar0_size ||
> +	    !IS_ALIGNED(sriov_base_off, sizeof(u32))) {
> +		dev_err(gc->dev,
> +			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
> +			sriov_base_off, (u64)gc->bar0_size);
> +		return -EPROTO;
> +	}

.. and if it is entirely normal and something that happens is EPROTO
really the right way to deal with this race, or should the driver be
looping somehow until the device stabilizes??

Jason

