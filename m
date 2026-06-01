Return-Path: <linux-rdma+bounces-21569-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIp3MrpPHWoDYwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21569-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 11:24:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A361C5AF
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 11:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4977D301A2A3
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32E38E8CD;
	Mon,  1 Jun 2026 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bgQUYQxs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D16201004
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305438; cv=none; b=IDJ37WOKDYpKchWQ4XT/Fdux5RkfPmPB2h/oSAHk/yBmsIYa4Z+XHCJpBitNfBr5wv6ktTxzva1w0b4OsZ9woxlyA89tuRELys0ov2eMP0iZNhmSPB83RgdyVIODBTLqV5PPv4iUnX06IcgIADaW1ev/5a7rSXbc0eZRPoyR96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305438; c=relaxed/simple;
	bh=WvnuC1vHZomNi0EpGtcCr6xvmyzo3YzazoGmWeqQiBU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8dTNIzl85/GRfA9swbcM4+CVSX70z8aoF7q13Z0G3iyWIUp+7qMiSQPkClLvx+uyOwCc4brbLcoyEucZrwUc3ikz642fM5GvYNdwvLLgLheAbc715TJJv0Nx6bm/HkgD6Eg3rBJTjKpja2Sljq3odSoxpUWHTTncrmko4p+krg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bgQUYQxs; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780305437; x=1811841437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HUvKBOiHaZ+VB0AZfemW/AorttkZfLiQbHGElMJV0R8=;
  b=bgQUYQxs6bfJYrkjKQbkkHDUNrwyN6DVS9H2KZkyVHk+sMJ3Yny0+W7s
   BhRikZXFYTXZn8fA7mpKrkzhil0M7V/c4EUDc+Iu90+oor8r3knXsTQ+i
   SykQNELwpiGBQLhkJhhL9nPrkIjKURjOilGJYzQHchFVlwlvw2+fAJrd9
   AsffFWptkEKR4CDtHMB5YvkA+fwG/k1ZczeOsG9C3OMpxy4w18hZxgUp8
   LPHhuqnaeziq8SCp8EFWS9DnSusqJKs3O9P2fXtHINmHa6CwF7EHwm1WI
   s8TMiO44NR3YS44xcEdaGBwFH75RVV5pWjo3GSggimabXZ+4FTAWyl0XQ
   w==;
X-CSE-ConnectionGUID: 8k/mR1PaSQOpm4ecFqK7NA==
X-CSE-MsgGUID: nO+3LOPxT9G7CWF0DiGmgA==
X-IronPort-AV: E=Sophos;i="6.24,181,1774310400"; 
   d="scan'208";a="20854843"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 09:17:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:19587]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.209:2525] with esmtp (Farcaster)
 id 841376fc-490a-478c-af25-81a5712fa97d; Mon, 1 Jun 2026 09:17:14 +0000 (UTC)
X-Farcaster-Flow-ID: 841376fc-490a-478c-af25-81a5712fa97d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 1 Jun 2026 09:17:12 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 1 Jun 2026
 09:17:10 +0000
Date: Mon, 1 Jun 2026 09:16:57 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>
Subject: Re: [PATCH for-rc] RDMA/efa: Validate SQ ring size against max LLQ
 size
Message-ID: <20260601091657.GA35750@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260526081536.1203553-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260526081536.1203553-1-ynachum@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_FROM(0.00)[bounces-21569-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 409A361C5AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 08:15:36AM +0000, Yonatan Nachum wrote:
> Validate the SQ ring size against the device's max LLQ size. This
> ensures that when using 128-byte WQEs, userspace cannot exceed the queue
> limits.
> 
> On create QP, userspace provides the SQ ring size (depth x WQE size)
> which is validated against the max LLQ size.
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 395290ab0584..aa1a615bb341 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -598,7 +598,8 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
>  }
>  
>  static int efa_qp_validate_cap(struct efa_dev *dev,
> -			       struct ib_qp_init_attr *init_attr)
> +			       struct ib_qp_init_attr *init_attr,
> +			       u32 sq_ring_size)
>  {
>  	if (init_attr->cap.max_send_wr > dev->dev_attr.max_sq_depth) {
>  		ibdev_dbg(&dev->ibdev,
> @@ -607,6 +608,14 @@ static int efa_qp_validate_cap(struct efa_dev *dev,
>  			  dev->dev_attr.max_sq_depth);
>  		return -EINVAL;
>  	}
> +
> +	if (sq_ring_size > dev->dev_attr.max_llq_size) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "qp: requested sq ring size[%u] exceeds the max[%u]\n",
> +			  sq_ring_size, dev->dev_attr.max_llq_size);
> +		return -EINVAL;
> +	}
> +
>  	if (init_attr->cap.max_recv_wr > dev->dev_attr.max_rq_depth) {
>  		ibdev_dbg(&dev->ibdev,
>  			  "qp: requested receive wr[%u] exceeds the max[%u]\n",
> @@ -676,14 +685,6 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
>  	ucontext = rdma_udata_to_drv_context(udata, struct efa_ucontext,
>  					     ibucontext);
>  
> -	err = efa_qp_validate_cap(dev, init_attr);
> -	if (err)
> -		goto err_out;
> -
> -	err = efa_qp_validate_attr(dev, init_attr);
> -	if (err)
> -		goto err_out;
> -
>  	err = ib_copy_validate_udata_in_cm(udata, cmd, driver_qp_type, 0);
>  	if (err)
>  		goto err_out;
> @@ -705,6 +706,14 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
>  		goto err_out;
>  	}
>  
> +	err = efa_qp_validate_cap(dev, init_attr, cmd.sq_ring_size);
> +	if (err)
> +		goto err_out;
> +
> +	err = efa_qp_validate_attr(dev, init_attr);
> +	if (err)
> +		goto err_out;
> +
>  	create_qp_params.uarn = ucontext->uarn;
>  	create_qp_params.pd = to_epd(ibqp->pd)->pdn;
>  
> -- 
> 2.50.1
>

Hi, kind reminder

Thanks

