Return-Path: <linux-rdma+bounces-16234-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGmfJCFxfGlIMwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16234-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 09:51:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCBDB8A60
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 09:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A37ED3002F68
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6C313E3F;
	Fri, 30 Jan 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ul6c6DoD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CDA2E0926;
	Fri, 30 Jan 2026 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763098; cv=none; b=PnPs3xJsgw62GWn5GPtTkEFab96mfBowQdRgkW4v8QtvYvLniT2MDU4roaXQNl2c1NpswD7oLDn9AIpHg+WzV2j5p5Gpv+6HwF0mxU3tucItlfpOHYPW6lTk02gvRScbw6IRrmhuiEe3I0jKIlSuDK4Cg5xVswodprL+rGFVnHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763098; c=relaxed/simple;
	bh=FaoWFuc8Lf1DLkdGOsvF+wLgIPVDLi4pj2Mq/rs7om4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih+ALsAnzySpt4h0aMysaf8HYa8nooLDZtO9uE/z5suHkKwpVY+2sxDj8epWbHL+Pc2hoKCfeFXRT0eQFFkGoldWLyDbEsT39GggG9TrZFJIEIpoSA5OnFiTdrvLpH18mwk26l8Ic47MGYPCyO1dfI2R64jeGay1sxnlAAfVkvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ul6c6DoD; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769763093; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=DkUtsb7QwZdL+LDizpsEkBxaLkE/G58Yn4o4w4mhoyg=;
	b=Ul6c6DoDuXzMooXfYNPtaJhBlLlbpvZ6/7jTSiQSyYEGLv7thskdKquSRQLXNTRtVtEXKIvyyxbOWyJa6EH8Q9R0euJGHj1KZvCNRA4MP4Cm0ugQ+CP66Q2YSKWrt0Ds7s9tL4IC8kygseKotFddSw0UQxP32sdRr6185WjuJus=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WyACWjW_1769763091 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Jan 2026 16:51:32 +0800
Date: Fri, 30 Jan 2026 16:51:31 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	Leon Romanovsky <leon@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <20260130085131.GA122673@j66a10360.sqa.eu95>
References: <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
 <20260128180629.GT1641016@ziepe.ca>
 <20260129113609.GA37734@j66a10360.sqa.eu95>
 <20260129132058.GC2307128@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129132058.GC2307128@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16234-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com,davemloft.net,linux-foundation.org,google.com,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[j66a10360.sqa.eu95:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDCBDB8A60
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 09:20:58AM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 29, 2026 at 07:36:09PM +0800, D. Wythe wrote:
> 
> > > From there you can check the resulting scatterlist and compute the
> > > page_size to pass to ib_map_mr_sg().
> 
> I should clarify this is done after DMA mapping the scatterlist. dma
> mapping can improve the page size.
> 
> And maybe the core code should be helping compute the MR's target page
> size for a scatterlist.. We already have code to do this in umem, and
> it is a pretty bit tricky considering the IOVA related rules.
>

Hi Jason,

After a deep dive into ib_umem_find_best_pgsz(), I have to say it is
much more subtle than it first appears. The IOVA-to-PA relative offset
rules, in particular, make it quite easy to get wrong.

While SMC could duplicate this logic, it is certainly not ideal for
maintenance. Are there any plans to refactor this into a generic RDMA
core helper—for instance, one that can determine the best page size
directly from an sg_table or scatterlist?

Best regards,
D. Wythe


