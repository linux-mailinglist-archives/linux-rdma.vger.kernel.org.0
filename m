Return-Path: <linux-rdma+bounces-16159-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDcVGjwsemnd3gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16159-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 16:33:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00560A3F40
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 16:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9542B3014A2D
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF0248F72;
	Wed, 28 Jan 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NuPiu4Or"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953626ED48
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614372; cv=none; b=g50qejfq2BjAOTvaMFnmVaNlLQJ+cva1L0N1uqPsb4QIvMhrIf6K2SMQPflJcG3jbCvKHbCaBWF9zgVoFvSdVM6ktR3ifbMl6mWGECaPFECG2ZNrFGW8dpoMZYAu1fiA9X87KvaMun+N0BhtZj2LF+/fYi7fCdHLN1pS0vaqFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614372; c=relaxed/simple;
	bh=iNqF3aX0KoOB+sY2Vrf9/1PjJDimbZQmZT7kSoC4Y9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU4XMg6807/c4g2RltDc1TQTTWpA/zo3+i7JsUOf+Aavn+i9WEA5hjuLo0UlvpoPtT0HsUMt5lKWZq04eKSgTSiLI0HPzrT+FVgxYKVEizJr+nUcPtlvk2h+2qvZ2v3HJi4L8Z7hITVWfgFYcm2/BcAPKuclN6PbVVkCJ6tkJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NuPiu4Or; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5014f383df6so58682791cf.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769614369; x=1770219169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7Vh2enN/9kiTKCkuJ9VDZRFEvJGQqTD4fMFUkkpJBY=;
        b=NuPiu4OrveK7TaS9eiWvJBNy35dv+Bl+CdttAIC+woTQEuPnrGEH/hDDMbx0I0P/Vp
         wgxcZ2JYtU7LT0c0OHh8DraNJ2XpuUZstvXJPZq9fadjzPfAjeOp6jtc/uSHQcFsh1HY
         6/bO5/dap7DI/YL4GHvBzw2sFZkTecer3ZSv8SH1LqNiOyrGJXPtslMhFyPwqO5zDVqb
         2UsFAL37ZJdnKgCvxtKcF/tWM9pGedxmSnjy1vYHZG+PDaneFLT/HTE1aHVTbk/hqyWU
         X5SgJd6sNmy0exg3sFkyJJojTLvSOJLBx+mkEHdM0uM1DNDoyA960dz6y7gJEbhBvw3L
         ZeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769614369; x=1770219169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7Vh2enN/9kiTKCkuJ9VDZRFEvJGQqTD4fMFUkkpJBY=;
        b=RyDSU/ThNkw40fqOoBj7oYUn/uUe5f7INi4kzXalDur8/bHMA05+VJw+3xxo/iGxHs
         Fyhrlm9qPAkK/Nrsrdg59Aj/OLJe2f/4Mfef3NTzc9R3XIDNiQhSmjxwEcaYcTqZwJCu
         MEsPr8cgRQ4Geq9X00gMRfRE8JhJrWBrOwDkSZr+T+isglgtKPNZarRY2qOMV4anhfRo
         cvcW95w7tL81KLfJ+tG4akJD3HXHaize9u7JHxMgKROOysw0Qvh3o9T3roCyo/lLjxyF
         N4c/lLg85BfCocGb98U9cw648Jgf8daDjNzhZtMXnvAw/Q9w9BKAFl/2Rv0gmyEAS6Gw
         PDKg==
X-Forwarded-Encrypted: i=1; AJvYcCUAUbqlV38BXRybJTqtlFW8Li5DqQgRsrVvhRzbOPvV6VKg2r6/oG+q9foXkuT90a6FBFrrdSWPbzcZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzuA2si4S7uLaxfWmluv5es3r4vGfu+JzEVXlkVBY4MiFJoHPVn
	42BfDc0iVFvBcrNRs/Pmv6/+OH/9X9smWidmtdUWaPECvBWz20hO9HKVAAB0RBXRk70=
X-Gm-Gg: AZuq6aJA85x2OF/tndmi78tQWhJdN05lUibGe85Ap8HEiG1/vbOcPKqYcnfi1XXmpp1
	D6EWSj4efjkUERg86QGnVWsaXNLadN7aqwPkc0YMpcdEDZ/lhJ5b3nyS9lIMf8U39navxTBSJ0t
	uWF8pmeZJ5xLwVbeqPgKBrr0qaTMeOy/cnz3cAocWQt1kvv9l620razsZD+iamTWrZnB/saogaV
	7F7H70tMCOg8b8wMk+gOdkd8MsNaTgmi/doLNxvkS3WUWtk+8zR8Omm0vkcVAatUiWWAg36sCv8
	kE5Vx/agM0bKHCHU4RUZu5FopW9kNCyvDJn5FnEfTHmF9IGgWSwhQHQaoqvbtD3qwu8XZVB/Dc4
	kNXCXjcA96tdxztCtNoJTn+zJmpdy/OoUD1NqQrQmUzZ9FG1+hBr+zJJ5e0V1F6L4Tp/EJv2o0g
	qhx5D5YeIIVsnR8WVZSzBJohlE17xznQKkPNrXWaLrKsS3ivAHGgg72L+3i4fZrywa2YA=
X-Received: by 2002:a05:622a:14b:b0:502:a2d8:453d with SMTP id d75a77b69052e-5032fb1d7f5mr76054191cf.66.1769614369529;
        Wed, 28 Jan 2026 07:32:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cbdc24sm17670331cf.32.2026.01.28.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:32:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl7XE-00000009JTz-0Gxk;
	Wed, 28 Jan 2026 11:32:48 -0400
Date: Wed, 28 Jan 2026 11:32:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260128153248.GK1641016@ziepe.ca>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16159-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 00560A3F40
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:01:09PM +0530, Sriharsha Basavapatna wrote:

>  struct bnxt_re_cq_resp {
> @@ -121,6 +124,7 @@ struct bnxt_re_resize_cq_req {
>  
>  enum bnxt_re_qp_mask {
>  	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
> +	BNXT_RE_QP_DV_SUPPORT = 0x2,
>  };

This is set on the response but there are no new response fields? That seems
backwards?
  
>  struct bnxt_re_qp_req {
> @@ -129,11 +133,22 @@ struct bnxt_re_qp_req {
>  	__aligned_u64 qp_handle;
>  	__aligned_u64 comp_mask;
>  	__u32 sq_slots;
> +	__u32 pd_id;
> +	__u32 sq_wqe_sz;
> +	__u32 sq_psn_sz;
> +	__u32 sq_npsn;
> +	__u32 rq_slots;
> +	__u32 rq_wqe_sz;
> +};

How does compatablity work here? Old userspace will send a short
structure, the new kernel should effectively see 0 at all these fields
is that OK? Sizes of 0 sound bad don't they?

New userspace will send a long structure and old kernels will ignore
the new bits. Is that OK?

I would expect you to set QP_REQ_MASK_SIZES in the *req* comp_mask. If
old kernel then the kernel fails the creation and userspace can do
something else.

If the userspace passes QP_REQ_MASK_SIZES and the ioctl succeeds then
everthing is OK. Delete the comp_maks in the rep structure.

Also, what is "pd_id"? The other users of pd_id in prior patches seem
to be actual RDMA PDs. Why is something like this being passed here?
The QP already gets a PD from the core interface, why do you need
another pd?

Also the old kernels have a bug:

	struct bnxt_re_qp_req ureq;

		if (ib_copy_from_udata(&ureq, udata,  min(udata->inlen, sizeof(ureq))))
			return -EFAULT;

It should have been "ureq = {};". Those sorts of things must be fixed
or this compatability stuff is really broken/security problem! Please
audit all your ib_copy_from_udata()s!!

Jason

