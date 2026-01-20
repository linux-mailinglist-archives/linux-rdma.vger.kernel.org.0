Return-Path: <linux-rdma+bounces-15782-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L0JI3Ppb2m+UQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15782-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 21:45:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 005834BB3F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 21:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93C4D9881BD
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A2B4534A7;
	Tue, 20 Jan 2026 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ht/NWfNg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE414266BA
	for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935266; cv=none; b=mzWoad0YY9mG61R4SR6AC+u4A7rB2hZUbDnB+pxSgjP8UJE2YSgo54vGTsWhJhImPFJeOh/2B+LASkcLu6u4EdnVrV2EP+mspgSr2NYMBQpYJF1D2PxczVFazr/NcaRouNFQfLYj5Xv162R7Sc8q2UQMtehOMj29ezHcl2dTSBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935266; c=relaxed/simple;
	bh=mTjqkO7SZ9s0C9b5MXyurBFvCsOi/oO13CO7sE9gc90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv/Os1hggsunbYbstDP6jnxtSFXGnIMGPWT1TaPURo7bCntbXGbQ0TR9M9CHgYt0mIYekgXtTUbLLpIuiJ7LjuYrF2Tj8xxtjKLrKylnP0Q5E2qRe6YXtvWQOKLsR6BXSLDgvwP3BYkvhNlYekCpUfEcVEPksgcH/lyVMX9l/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ht/NWfNg; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a3d2f3299so58081566d6.2
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 10:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768935260; x=1769540060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6aY2QAOdBNoJG+ebTfd1NC2n8f/LC3Nk2RXuH9wo8GY=;
        b=Ht/NWfNgSAuTNox1qnV8hAF2aaTT0QPED6L/oUqhmwzs0M0Mrz0czMkwrfmChe+pGg
         6XpZtxsg+OeYoxwq9VakoNVpOcQNyKvHoT+/Qa3knuy3HysA8XNnYETI6JSEEFWE9lhG
         cmVQQvCAA86g1x5QhJmX6sRUqsg8940z0MM9RD2mMAuOznFgnj+QI+bMiL9CTBRUmX9W
         8L05ESQaqgJJ3SMtOlaqSTZ8uXEYZtvmJuMR62+sFgP2UPQlPTo6HtIRHIVwRsFcEqK4
         s/KGMCo/D87qCYQ/XR2HhVP0+HonlXMMxrh2+gN0nj30WTDDtrViR4uZhPp5QAzR8egG
         0iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768935260; x=1769540060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aY2QAOdBNoJG+ebTfd1NC2n8f/LC3Nk2RXuH9wo8GY=;
        b=p/1IlfZalbfjZJO5wVa0HfZwRlSIjARPZNJiFvULOzK3YgkuESpQqvOiUlqlhlgS31
         ij6h1ktYrIoOjQ5IPNaJN2UEQGqNlsjO8jf9ucz713ta/DuNEVDpsCXlu6yrsAodTscv
         sLdt7Gwx2Qobvv6Mg4iP6p8JqFD/bm3DN5E+P840EAst/iCX6PPMklZ1iBoDXaNJGvkR
         1MEgyXZ+3oQGB+t+J39QgRW6YG3RINergCiertvqzKblqm5YUsdQDKQ6/Cy/6Ma+F/jD
         or/0gcp9g5qittNk3MHZkpEcFiO3TJsBs5KyZJnLU6MT98g9z32xu9YUyt5LhqfP9Rx4
         0Ocg==
X-Forwarded-Encrypted: i=1; AJvYcCUqyDf7wmE+e5lNUin1d5yK8PPCxLnvFjVi0AP0eK1MBreakEKIlzmxK/cgG1c+aWUlDYDKAlDWJRBr@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzilHhoNLIA7OCJeHKQaBxQg64cBYVFVaAtWXBfbg7PwdU4Nz
	mcpivzes/5pctDdxlLi6nL484kTCa5yP6o8aEMxy3J/FGZ2Ump1O083emViD3/8RHIk=
X-Gm-Gg: AZuq6aIfjltenI6A02Y2E4sVmUaOVGMFUuSfo1S8Plqvy2Sb25Vz54+a2+zjs+q8kBk
	EhZmeRuevsP0fwFd2WQZDtowldo56K41x1TdHMYMQKAyyCWZgAKGce6XQmWALZ/blBeb8M7vnLo
	zlAiLDuMI0Gk4t0g1YyGrZ3/gyIo3GUSSUR3HXDxSxQ/ZvjMfCSDbYJgv9P368U3L3vtIDQM+Oy
	I1qPHCVeAxScKCzsx1K762eSS+gwiDrBrJvRbDXgyDO8WYOLWaOebTB6HgBiMbZN9tlAS1smq7H
	3HCB5ukPgMAscGdPpRJBOm2Q7og7GBoudCfIG4ni2MvjKiUwsFibmbr68V1tdVjrOQCAqwEnEgS
	PDCFZS9RZ9ZpP/1PbnAl6iQf6W+1f7gXXncYOpqSYT1cba9fRKnDWZCA/FwoRjXte/UcxZfbzyS
	o8N4jyUD2wy5VcBt6vEePcblmFHQqyFCc0eG9+uiqIu554mO41EFDvFw4HKXtRNR1k/NZE/D67I
	3Cyzw==
X-Received: by 2002:a0c:f087:0:10b0:894:5cfc:92a2 with SMTP id 6a1803df08f44-8945cfc92dcmr54946486d6.56.1768935260210;
        Tue, 20 Jan 2026 10:54:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6ffsm108996396d6.27.2026.01.20.10.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:54:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viGrr-00000005bGU-0ncJ;
	Tue, 20 Jan 2026 14:54:19 -0400
Date: Tue, 20 Jan 2026 14:54:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v8 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20260120185419.GU961572@ziepe.ca>
References: <20260117080052.43279-1-sriharsha.basavapatna@broadcom.com>
 <20260117080052.43279-4-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117080052.43279-4-sriharsha.basavapatna@broadcom.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15782-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 005834BB3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Jan 17, 2026 at 01:30:51PM +0530, Sriharsha Basavapatna wrote:
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> index a11f56730a31..33e0f66b39eb 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -164,6 +164,13 @@ struct bnxt_re_user_mmap_entry {
>  	u8 mmap_flag;
>  };
>  
> +struct bnxt_re_dbr_obj {
> +	struct bnxt_re_dev *rdev;
> +	struct bnxt_qplib_dpi dpi;
> +	struct bnxt_re_user_mmap_entry *entry;
> +	atomic_t usecnt; /* QPs using this dbr */
> +};

This added usecnt but it doesn't use it

It is supposed to prevent destroying the object by the user out of sequence.

> +static int bnxt_re_dv_dbr_cleanup(struct ib_uobject *uobject,
> +				  enum rdma_remove_reason why,
> +				  struct uverbs_attr_bundle *attrs)
> +{
> +	struct bnxt_re_dbr_obj *obj = uobject->object;
> +	struct bnxt_re_dev *rdev = obj->rdev;
> +
> +	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
> +	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
> +	return 0;
> +}

For instance CQ did it in the above function:

static int uverbs_free_cq(struct ib_uobject *uobject,
			  enum rdma_remove_reason why,
			  struct uverbs_attr_bundle *attrs)
{
	ret = ib_destroy_cq_user(cq, &attrs->driver_udata);
	if (ret)
		return ret;

int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
{
	if (atomic_read(&cq->usecnt))
		return -EBUSY;

So this patch should be doing the usecnt check as well, otherwise it
won't work right.

Jason

