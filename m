Return-Path: <linux-rdma+bounces-15925-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKpJIlOLc2l0xAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15925-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 15:53:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB37744E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 15:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A3FE301DC15
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E6032C326;
	Fri, 23 Jan 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VsHFGsVK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C31FDA61;
	Fri, 23 Jan 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179982; cv=none; b=SQ0f8MMuea9vQqOAFboD4gwfSb1eg4ySXWnGqrkouTmOtrC9FX90qj7yvY4jkkLTMQ8jZAQPMLtYCioyJZ0+l4V9mK2mOD0Ymqwf+AdY4IWKTx+wleH16Nbhu0gEsHYgHRYdwJs1ayndQ2lziwdmTmYMolqdLtFiwVJeKqRoB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179982; c=relaxed/simple;
	bh=W/pk2ulrpAE1itNWaDpBWnFA3W0hBLs7SnrgSRbXbRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkgldHoqbdi9mjTloLp72aBwJ6udKMhMgmgblbDOBHyWu+OmA0QwrnGsca7PXPpkczkn3CM8LjNfx/9wysMFXDR83hl6ux7B6y0vv2jdLo4QloeFo3iXnvMJ1DmcLSWEBaT32sgGQOZgeC7xjk3c+sRxbd40GZuP6PUd+sIOyk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VsHFGsVK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TVBzXQDCNtWSpdK/QWdp6QSI2UdQKR8SCDM6cMQe39s=; b=VsHFGsVK6hUiHl50ePEEJNfJwI
	Q9FZzvpVnrQEDS+3XYydQiRg3XZhM/MyiOWb167G24p70Xd7cdEZhJW/KDI1od3ZDTaQ36mBJQ/2m
	lFLqxp83xfWJnN1COIAjXR9A8d4ROwl96zt0vuCJ8SABO1R8EQLUbWnTYX5bCMuwlauRGxL4es1i4
	ujdBsbu9Faabk8HoDout9uhkNMZ1Ud+vWXbV5/Iza2SoYCANmtvG4WzGs/9IJkF4MWR8FcrV/NuS9
	XydARRtea5nppURoXWHEMGxCS1fjUH+9i19SNBKCEV8BRzPEXzYdlyBwrkFeiFhUR77YOmBldLj/y
	2/9ZYpdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjIWt-000000093tO-1KWh;
	Fri, 23 Jan 2026 14:52:55 +0000
Date: Fri, 23 Jan 2026 06:52:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 3/3] net/smc: optimize MTTE consumption for
 SMC-R buffers
Message-ID: <aXOLR9GxwuNz3Ddc@infradead.org>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-4-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123082349.42663-4-alibuda@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15925-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,kernel.org,redhat.com,linux.ibm.com,gmail.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13EB37744E
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 04:23:49PM +0800, D. Wythe wrote:
> +static inline int smc_buf_get_vm_page_order(struct smc_buf_desc *buf_slot)
> +{
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
> +	struct vm_struct *vm;
> +
> +	vm = find_vm_area(buf_slot->cpu_addr);
> +	return vm ? vm->page_order : 0;
> +#else
> +	return 0;
> +#endif

You might want to encapsulate this logic in a vmalloc_order or similar
helper in vmalloc.c.


