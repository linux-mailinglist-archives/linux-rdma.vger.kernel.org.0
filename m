Return-Path: <linux-rdma+bounces-18242-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAXkC10puWkAtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18242-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:13:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885042A7A66
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6480D3141236
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC653914EC;
	Tue, 17 Mar 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEGvNJZV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB03A5E77
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742073; cv=none; b=NwiV2/UCWu5iEW3rBoWimWDDYH8rNTE6MhOKuSBKKZEfaxA74FTA0TYWWfJwm8vyPb6h6onqVC0e48y9ddfpZUMZPQIz0dITT54+3J1XjPqm6h5IetOtJB4mLsmmdGQepk77kLcrhFsLlYm7KgND1aDhU47tkOeH6UM0m5u4B4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742073; c=relaxed/simple;
	bh=lB3wgXiLb0Km5WtM7mz6w6pLaxh2+JDeYervSdDYszM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK/qCeUlfMOoVxxdpyMFaIZmTMBeJJxWZ9SL2Gck8uQr34AoC4ez4yg+EmT20d5o1ydMvpwzJEqS0qcx+GkLbFxjCi3Jb1RHYrcVd1Zsap0V5rMDXdiq0jaswXF7u2t1ZHZTp9IrkqGEwNRYbLVh7/RPJN5oUcoOFX4ZGTGZgro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEGvNJZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B42BC4CEF7;
	Tue, 17 Mar 2026 10:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773742073;
	bh=lB3wgXiLb0Km5WtM7mz6w6pLaxh2+JDeYervSdDYszM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEGvNJZVLoNV6LOPDhKVejpCU6UiMHHVGayntEv+R7t7BN/lJbfsMVFegqoYdKmKX
	 lbOWv/wBm+iuvg9+LFNqILCJZPVMM6jR3RXdcVrMw97+NHxT11oR/by/78c0eNs9yY
	 xwlc9e2QfkU6vT2GFtfliPdzXZbYv26I8WDQ7LBYP4JKQH/a2/3szWn9tPc5p1Ar/j
	 FpCbfNy9z2kjrcGdc78HaOq6kBuer1PmQVarntac1/t57otJH6S3tjp3A5WQ1T+f9f
	 MVSGlF2N8KTAXo6914jDUCy4fjzQ/AfCAk6NqoI2tUVx5m8rfI693XwWLqIiXwYWd9
	 P+Uw0rNxUM0lg==
Date: Tue, 17 Mar 2026 12:07:49 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	Douglas Miller <doug.miller@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next resend 01/24] RDMA/hfi2: Start hfi2 driver by
 basing off of hfi1
Message-ID: <20260317100749.GU61385@unreal>
References: <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
 <177325163046.57064.2112731243866122444.stgit@awdrv-04.cornelisnetworks.com>
 <20260316155141.GC61385@unreal>
 <1954a5ec-2a77-4713-b20f-6a6c09b7f18a@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1954a5ec-2a77-4713-b20f-6a6c09b7f18a@cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18242-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 885042A7A66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 06:00:22PM -0400, Dennis Dalessandro wrote:
> On 3/16/26 11:51 AM, Leon Romanovsky wrote:

<...>

> > 
> > > +	void (*setextled)(struct hfi2_pportdata *ppd, u32 on);
> > > +	void (*start_led_override)(struct hfi2_pportdata *ppd,
> > > +				   unsigned int timeon,
> > > +				   unsigned int timeoff);
> > > +	void (*shutdown_led_override)(struct hfi2_pportdata *ppd);
> > > +	void (*read_guid)(struct hfi2_devdata *dd);
> > > +	int (*early_per_chip_init)(struct hfi2_devdata *dd);
> > > +	int (*mid_per_chip_init)(struct hfi2_devdata *dd);
> > > +	void (*init_other)(struct hfi2_devdata *dd);
> > > +	int (*late_per_chip_init)(struct hfi2_devdata *dd);
> > > +	void (*start_port)(struct hfi2_pportdata *ppd);
> > > +	void (*stop_port)(struct hfi2_pportdata *ppd);
> > > +	void (*put_tid)(struct hfi2_ctxtdata *rcd, u32 index,
> > > +			u32 type, unsigned long pa, u16 order, bool flush);
> > > +	void (*rcv_array_wc_fill)(struct hfi2_ctxtdata *rcd, u32 index,
> > > +				  u32 type);
> > > +	void (*set_port_tid_config)(struct hfi2_devdata *dd, int pidx, u16 ctxt,
> > > +				    u32 eager_base, u16 alloced,
> > > +				    u32 expected_base, u32 expected_count);
> > > +	void (*set_port_max_mtu)(struct hfi2_pportdata *ppd, u32 maxvlmtu);
> > > +	void (*update_rcv_hdr_size)(struct hfi2_pportdata *ppd, u16 ctxt,
> > > +				    u32 size);
> > > +	bool (*check_synth_status)(struct hfi2_devdata *dd);
> > > +	void (*update_synth_status)(struct hfi2_devdata *dd);
> > > +	u64 (*create_pbc)(struct hfi2_pportdata *ppd, bool loopback, u64 flags,
> > > +			  int srate_mbs, u32 vl, u32 dw_len, u32 l2, u32 dlid, u32 sctxt);
> > > +	void (*set_pio_integrity)(struct hfi2_devdata *dd, u32 pidx, u32 ctxt, int type,
> > > +				  enum spi_cmds cmd);
> > > +	int (*find_used_resources)(struct hfi2_devdata *dd);
> > > +	void (*read_link_quality)(struct hfi2_pportdata *ppd, u8 *link_quality);
> > > +	void (*set_rheq_addr)(struct hfi2_devdata *dd, u16 ctxt, u64 dma_addr);
> > > +	void (*handle_link_bounce)(struct work_struct *work);
> > > +	void (*enable_rcv_context)(struct hfi2_pportdata *ppd, u16 ctxt,
> > > +				   u64 *kctxt_ctrl, bool enable);
> > 
> > Do you really need function pointers inside driver? It makes possible refactoring harder.
> 
> We do use function pointers in a number of places because of performance
> reasons. However these are more for abstracting away the differences between
> the different chips. I'll consult with the team and see if we can clean this
> up any.

BTW, function pointers generally perform worse than direct calls, since  
they always require an indirect jump, which is harder for the branch  
predictor to handle.

Their main purpose is to allow the invoked function to be changed  
dynamically.


<...>

> > > +static inline int valid_opa_max_mtu(unsigned int mtu)
> > > +{
> > > +	return mtu >= 2048 &&
> > > +		(valid_ib_mtu(mtu) || mtu == 8192 || mtu == 10240);
> > > +}
> > 
> > No to module parameter.
> 
> Why? This has been a long standing knob available to users. Same with many
> of the others below. We can look into whittling them down if they are not
> being used regularly. Some of these are important for tuning performance and
> are meant to be tuned driver wide at init time, not per hfi instance which
> generally is my litmus test for if something can be a module paramter.
> 
> Perhaps it would be better dealt with as a follow on patch to this series to
> refine the whole set?

Yes, please remove the module parameters from the initial submission.
We can address them afterward. There is also a possibility that these
parameters could be useful for other drivers.

> 
> Thanks for the detailed review.

I'm continuing the review today as well.

Thanks

> 
> -Denny
> 

