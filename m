Return-Path: <linux-rdma+bounces-16162-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MpBNK8yeml+4gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16162-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 17:00:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6ECA4EA3
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 17:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F071F3073328
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA79A2EA172;
	Wed, 28 Jan 2026 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q22ifWuG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457B2DF155
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615465; cv=none; b=UKIj87cdqyEqwkt7xmxvLRar1wi02QnJLuQd18zDpKOuIfHVnZkU3AZUjGndcXpuEHpPlXmfs3XII6cdu5Gfg0JOgvDhiA2PbO2tKeW+WxNVuhv7ILCNtSdJgN+kRW3QP6XMJei1v3d3kEsJiabwCtb3P/S9CjRoMz4p9vKv5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615465; c=relaxed/simple;
	bh=8PlBHui/8ICrXj92k9BqLh5jogdbSGJVGsIpSxIUP8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0dqRagEgU1lAEwrk+Ym/Crrr1QwOZ9w3UbYh/rZbx22zfyeANCRr5kDkVNzcaklFDoEvkMAYTFoO/9i/E9H8l8la/H0xBfySjq9sORxJYFGajKLn5MZWet9gGrW6L2zHT9AyW7Z/vDcCBAu2tu/c+Oy8LiV4DqajjtLJSlGen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q22ifWuG; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c7199e7f79so4703685a.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769615463; x=1770220263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=diUSKb5+7hw5//HDLhhvVls5PAX27IpbbwghzjaRLoI=;
        b=Q22ifWuGZbXKbAIuZCd7MXv6+LB6cTG1TlXOUsyWXyrqvvBdVVfppF/UNq6tQKR7dF
         PeKfh6qfhZ7jHNzOAikNVa/9fyGAbKmqVslOMtCmw7SSsX1jBP0fF1HJIOjrvJtk6H1W
         s8dIAymvcX+DoircqEVtlN6dl3LsGfJ0eg0h+DZ97qCqgSQcuw8j4lqmUpxGPqcVGwi+
         ENJR+5yoRvvc6yqKWsWwDOtbdkZHbXjD6zR/XhMkYq3EU9agPUn7u14YqlVwnMnWM/ON
         zO7R+3L1CoD0B53Dld+25DcBvHt157jPNjGck2bKKhh9otrZ4BhCIFWSAX5iDuz6SAt5
         4PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769615463; x=1770220263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diUSKb5+7hw5//HDLhhvVls5PAX27IpbbwghzjaRLoI=;
        b=AiXXIuwBKdP+ZnwRQo9NaB9ziHbDHGoBdqew7XnilpjXprFC8XpEax6CcH6K5Z+R2r
         3TY8c0d6lIp1gktyMVOLSS0mrDnJMY+R/pyMrrtdelAaxcqgj3OWGXbv1pbio4vlAqH5
         EXEj00gtDM6Ro7x194E9h7/dmPV5fxkF5BRmm3K3jZT3nbvHhYMHyXi91icvKaOSRYoU
         aDrLW0vfpFeKmlR1eOFkMDAkXdIPjuZDNNaeAYbVSjnJ+RA/VG/i4kt82nL/tfPEkp6t
         nDB2fdktc5ennBZU1JaW//aSDSy1UceMIcMj5faUgvAU+RZmacwJxN8HQlzALSYyvzc1
         Km1g==
X-Forwarded-Encrypted: i=1; AJvYcCURM6V3AqRtKXv8wRPReg/XgW50/BgtIgg4F0TVIlYcZJvD45Vnf4j66Y5eHaFXreBazIA48EyLocDf@vger.kernel.org
X-Gm-Message-State: AOJu0YzKF28svBR2DUM2Ef6sS/zbh3Rrmux/AARKhvmBo2ZQxlmrxQWY
	my1ChUk71G379Nsxd+pCT0mT3GM1ClwAmTUogSxxFPFJ7qTSltzd7BEuYZ9TzDmQxa4=
X-Gm-Gg: AZuq6aI33pKFbOuf9VvR2D/RNC4opoBX5S7BX6T9Hl02eka5xvzU9RErQ4zvIeY5RF3
	2EIUteMIio/G1xPskUo1oqKp8RvINihJNLN6D5BtNjzq3jy2vRYwXg9GEkwWFZtn68J2IPpGBCt
	uBV1YMLV9VTBvfqDYIEIyh9fHtrT0H6QAzm+VN9ng/t+JMFghGVkl2CiWZSvGF2Rer++bb4ZX7L
	/0l2/Lv3HKEwubiZDkRowxx8oCnY8UzGL+WOkOtMZzkS1RcfQ+kvapo0STG39in0grivcMNG3C+
	IoMC64uFIjkh13mP0jnkZ1PQy4fZTpeLpD5jyZPqj5mLu4ad1gA+f7IqijebD4XosK+kJGBMANO
	9AqscCXW9WEunPdSJgu2GTCpWHFjRQtLPbJX27EsKV3WXT4WNFHkIL2iR5zRcNRAFEMX5eWFc/Y
	W2zbepHAae6YwX/pgJSTL/C2J2R15JRl0DlHS79sdNb6fBEX+Ucmb5SepjY7jgvfr21CE=
X-Received: by 2002:a05:620a:3947:b0:8c6:a5b4:e01e with SMTP id af79cd13be357-8c70b85c18fmr695201185a.16.1769615463050;
        Wed, 28 Jan 2026 07:51:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d35d6763sm20063526d6.0.2026.01.28.07.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:51:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl7or-00000009K31-3MOD;
	Wed, 28 Jan 2026 11:51:01 -0400
Date: Wed, 28 Jan 2026 11:51:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260128155101.GN1641016@ziepe.ca>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
 <20260128153248.GK1641016@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128153248.GK1641016@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16162-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	RSPAMD_URIBL_FAIL(0.00)[ziepe.ca:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 8B6ECA4EA3
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:32:48AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 27, 2026 at 04:01:09PM +0530, Sriharsha Basavapatna wrote:
> 
> >  struct bnxt_re_cq_resp {
> > @@ -121,6 +124,7 @@ struct bnxt_re_resize_cq_req {
> >  
> >  enum bnxt_re_qp_mask {
> >  	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
> > +	BNXT_RE_QP_DV_SUPPORT = 0x2,
> >  };
> 
> This is set on the response but there are no new response fields? That seems
> backwards?
>   
> >  struct bnxt_re_qp_req {
> > @@ -129,11 +133,22 @@ struct bnxt_re_qp_req {
> >  	__aligned_u64 qp_handle;
> >  	__aligned_u64 comp_mask;
> >  	__u32 sq_slots;
> > +	__u32 pd_id;
> > +	__u32 sq_wqe_sz;
> > +	__u32 sq_psn_sz;
> > +	__u32 sq_npsn;
> > +	__u32 rq_slots;
> > +	__u32 rq_wqe_sz;
> > +};
> 
> How does compatablity work here? Old userspace will send a short
> structure, the new kernel should effectively see 0 at all these fields
> is that OK? Sizes of 0 sound bad don't they?
> 
> New userspace will send a long structure and old kernels will ignore
> the new bits. Is that OK?
> 
> I would expect you to set QP_REQ_MASK_SIZES in the *req* comp_mask. If
> old kernel then the kernel fails the creation and userspace can do
> something else.

ugh, WTF, this driver isn't doing comp_mask *at all* !?!

BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS isn't even referenced!? Why is it
there?

According to clangd nothing reads bnxt_re_qp_req.comp_mask, so nothing
today will fail if it is !0.

So you need to add a flag to the init/ucontext create path that says
"I support QP comp_mask", and user space cannot send a non-zero comp
mask without that flag, then check comp_mask for supported bits *like
it should have been done* and follow the above remarks.

CQ has the same issue, if you add comp_mask nothing in current kernels
will check it and nothing will check the sizes either. So you need the
same global flag to say the kernel supports comp_mask for cq before
userspace can inject a non-zero comp_mask.

Jason

