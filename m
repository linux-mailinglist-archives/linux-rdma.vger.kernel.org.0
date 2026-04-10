Return-Path: <linux-rdma+bounces-19211-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLxzGP0a2Wk1mQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19211-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 17:45:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4363D99F1
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 17:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF123274503
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0093E5EDC;
	Fri, 10 Apr 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="krNtHcbe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4E3DDDB1
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834875; cv=none; b=LF4fU6h+A4jI+LGHwI/dFLQ9CJ6F/rSJuTd4cM1A+44FLKxi8l9uo8gFIi6eU97CqXeAsqumpDWG7ic498Sk/oM7+57kXg4eBwTqnMWIRQ1yqSSQ9pF2A0WHfgbDgRuPt89X5al8UBMbnrYoqCW9kGR5UD6Z5ngT1ihwrljEQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834875; c=relaxed/simple;
	bh=g1EHn2haVpLFVq0NhPySS9r8/ZjFG2hnVokbvlmdR7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ims8G2FPKY3iev5gPOZK/p0GMte1A7MivjfdkPSlvtMDfPHDS7jdUrNtW+H2S+hKYZT28BCZh/9FEjsVlbLSzdBT65cS+VphpRx7qYwdKuBNqrxoJriPuG/e2Z792DlqDcNmCxAQ4BfTcppGtWwn7oSon30tQpJuHqqi3vGRa4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=krNtHcbe; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb40149037so205670685a.2
        for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775834873; x=1776439673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiKEzImhwPC7G9dqI2/pJ0hR8ONuEEzbiqNwnjYhY7Y=;
        b=krNtHcbeyJNBJOqzTkpZYGQAHIsM1FmNoaSu9+2kYNebi3dbMxuJmlILQh+GNpqqi/
         zHElSWUj/iHSZnaknkcmveAaBRbzLOJMXbw6v19Q0xwHWeLfNGg2vemGxlvuVN4+m/i1
         43zQLnt0eY9ESC/d42wEXYshjagMPUe0X57rAD9xu1KAawH2qcSGSwth59E202XhE6yI
         nKxwp4kDtR/JiD8j/QocMxKt9wFAL/YhR/GvcIVROir2RszlCBmZZXXaepnd9PCbJ8bE
         btdP63gD4y3GlhX7MhRtBQQmifNquz+rJtDuQ9vPrKCEfAvp0VyTZHw2dRHggCmF4rwo
         E6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775834873; x=1776439673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiKEzImhwPC7G9dqI2/pJ0hR8ONuEEzbiqNwnjYhY7Y=;
        b=rVGh6xsa8XbqRMvMCvSlDH/w422AZprhcbg4oj8Gi9uAu9nQyIHEdKalCysud9yVR7
         9Qnd++gkaob2/Bla8w6U12TS8lwNdKVw45WD4JZTksaqgrNiGYCXVxEQNXQXU48OGR/K
         hDANggNC0ZecUT1bzVTV9gmxU4VgfPp/DhfHZ+qVy5tgfdfA8oqqN7Aw0FIawaSwnk4y
         JdmS1CvI5oHAdYvg8bdjmHuRBrVeYfkvIno2p8PL6M9lTspeKsZB/Q8R5dMJSba+5d2w
         MX+HRbAmv87pyYeMHydBBQ7PPCY0rCBiHgiHBb/uZ0vgIiepFGa7I0Zh+jxDgyUWoV/4
         kUWg==
X-Forwarded-Encrypted: i=1; AJvYcCUABdChAPp3NzqRwMzLAc8qRHmrzaoMkIQ5B8jJzjm6JDjf6gKWnOAuQ9bwhONa+YVoKgxmPYmBQZNk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4NZVzlQ7jkglhejQJisiGGW2cmqxqnihn7A3oPnC3SKrteRT
	jdigUDGk7n6J6XlbF7ZVes+3yz5HY9J6dLOij51i7AEBi8aJ4YD4Z0vPazrYe2+rnUs=
X-Gm-Gg: AeBDies6Of/qeC7xYSnxB27vEosP35GHmM3hXKUgPESQDD9EhAVPNblLicOZ+bLh5b+
	YJAOcGCtJpF1n+nZiP/wss37kq7hFUGhrjH6mfI/cFOd46QcHRM/1lWbHf9SgeW8p49SbKp+D64
	w29RSSudnIV40AZeifW7nRJGh9BMJtb16INQ+TBTxWK479zA620Ub4buEFCSjxruQBOf8hc6tVW
	34xyIRT1k5/WSHujCnsn3HtGR1O72FEQi6uJpTOiDAQjRtVm1eycHhkJ9Olwe4AAQ0+1ZswfwEB
	K//lwDw2ag/0s8307TNaP0cwEde7JkqnxbGiwJ19pNqP+LsmM0Xapix9BClniAssc6xr7/iBx+j
	SaT+8X7ZsyMfArukgfgqmAOEirs0824Fe9i3VE0rPxR/4TxhYJercu8L/8D17Cu+ZJXb6iYmTrD
	IyKK+137zwbBDup0Y6Cx7dSqtPjw+blLS/yNKJLDv/dXnb6DxbsaZ/+LYW8vNXTVxm1w+OyA==
X-Received: by 2002:a05:620a:4041:b0:8c6:ca70:68ac with SMTP id af79cd13be357-8ddcfbaef3amr492767085a.46.1775834873011;
        Fri, 10 Apr 2026 08:27:53 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb66587e4sm242030785a.19.2026.04.10.08.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:27:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBDlw-0000000EeIV-0Ln4;
	Fri, 10 Apr 2026 12:27:52 -0300
Date: Fri, 10 Apr 2026 12:27:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v2 8/8] RDMA/bnxt_re: Enable app allocated QPs
Message-ID: <20260410152752.GY2551565@ziepe.ca>
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
 <20260327091755.47754-9-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327091755.47754-9-sriharsha.basavapatna@broadcom.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19211-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: BF4363D99F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 02:47:55PM +0530, Sriharsha Basavapatna wrote:
> The driver supports a new comp_mask: APP_ALLOCATED_QP_ENABLE.
> The application sets this comp_mask bit in the CREATE_QP ureq
> to indicate direct control of the QP. The driver goes through
> the required processing for app allocated QPs. Only variable
> WQE mode is supported for these QPs.

I thought we talked about this, no weird names like this.

> @@ -1734,6 +1734,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
>  		return qptype;
>  	qplqp->type = (u8)qptype;
>  	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
> +	if (app_qp && qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
> +		return -EOPNOTSUPP;

Give a sensible name for whatever this is and use it only for this.

I kind of thinking you can just fully drop it? What is the point in
checking userspace set VARIABLE? It isn't signalling HW and it isn't
protecting anything.

> -		attrs = rdma_udata_to_uverbs_attr_bundle(udata);
> -		if (uverbs_attr_is_valid(attrs,
> -					 BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE)) {
> -			dbr_obj = uverbs_attr_get_obj(attrs,
> -						      BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE);
> -			if (IS_ERR(dbr_obj))
> -				return PTR_ERR(dbr_obj);
> -			atomic_inc(&dbr_obj->usecnt);
> -			qp->dbr_obj = dbr_obj;
> +		if (ureq.comp_mask & BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP_ENABLE) {
> +			attrs = rdma_udata_to_uverbs_attr_bundle(udata);

And don't do this, BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE is perfectly fine
to be signaled by attribute and it looks like it is fully orthogonal
to the other features.

Jason

