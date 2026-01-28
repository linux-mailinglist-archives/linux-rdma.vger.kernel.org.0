Return-Path: <linux-rdma+bounces-16166-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH2wI9ROemnk5AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16166-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 19:00:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A3FA766A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 19:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3A96303D648
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EDF36F41A;
	Wed, 28 Jan 2026 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pPiY8flD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B29329E52
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623128; cv=none; b=ooBNrGx/M8F4mkvSTmjUFjastD+mFTm+HPGfW4I0GeLSaMRfaXF01+mfcRrrd9fFGbeTRbmIxpLbkmg0j3byUWA5hnWdix9pEm8HA2yj7wWHbREILsGHLZZZ08dph1bzoH5gmdP/oOHkXyu41crbbXsRlTUIJsqBttxxbsERkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623128; c=relaxed/simple;
	bh=3HHjNowU7cQwCrgwGUwA7ZpzrvvlfUYIpJXEwKynB5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWO6DAP//aNPeoSlzcRHaWQOIfmyfEzB4Bz6imtVjGHjpdre7cUqqLuBVeBPNquwDtcVBt2EOprdMjVnZYEiKNS0+aMKhr6OLSGkY2wIEXgUlT3bXukWSiYyPI4DT90omeDWJbN7Is3OP61OUBZpRXVnPmB/WQXLTv0Mo9BsxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pPiY8flD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c5389c3cd2so17485885a.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769623125; x=1770227925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eQ3doipnfUEIp00TFZchHSNHH6LpRf2iukh9157pJNI=;
        b=pPiY8flDT+VFq0TNywBQHecxzS+7oKo8IRcH8YJ9zDZU5HuG/2G87G4S6VsB3kz915
         /YmI00lDQe0uZI4nVHpWSqBxb1K+3sBbjvvchEOXat0X9RNd5EtWNvbtoZPeWA+UBhas
         sLXksrZatK28g1e5OkZVZL7AEplAJHlX3V/ae0V4JRzc/b54xK4SfM2L2TW3PkAkQCo/
         qI5+tb10GYJYXHMW+EbPaXqMK+AAiYLPb2nlbQWWlHjNBRkKDPAdqT2GRFfmmcJg20XR
         cgaMPQuXvCKOC1Dqix+5GuNqFWuLaCB9YifQLrvDG8CuXpff6SkMhvG8X9tousXQe9Fd
         BaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769623125; x=1770227925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQ3doipnfUEIp00TFZchHSNHH6LpRf2iukh9157pJNI=;
        b=o3ZZ2ePxVw6zUYxHiPVfhJ3GojtBhk4Ex7ch2He44Nao+bKQDuym8w8LP4LbcQw4x+
         lRbU3V5X24hkPlje2bw6W0BIHRKyTDJvEsHMvlYKAVsXlzjj+bQDADnB5U3Mis9LlhhT
         fjsJ0skts9YcQ0BZ5bGO/w1wkKzn/33bY1gt1PvBP5n3l3/z4M3G9IlAzRJKJsemcy0m
         1ALiRh6ATZmwMa2jvuSgLUEQSdBMhAhLMo3USkRvT86S/i671MqEgJtBbQ4IGtQyDg8P
         Cf2rFduBvIv05JeaMNCXcnflzs5OJaZZ3GVTKMM7+z/1ubSD5pTLcbjFkqIuTEGTngX3
         M6sw==
X-Forwarded-Encrypted: i=1; AJvYcCXbfwlBJYaDzmKfIBDzKn2DrCRM7oCx0RMRGCo33LmkrngCp5vNspoV42uEQrRE5wLNm0jywiqa4OYD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6SNUTSnenGMAvPmYYRNEC3kOd2wYXWL6KrTEuDr+PV5vgS03
	2oW7FLAGicupjLMJw7lGAk+uQW+V0DnUHeoRFz6lqSxAclyOH6WetR3+dWhO15D3xl4=
X-Gm-Gg: AZuq6aKez3dYzb72C18uvdcmAVh0fgjDTsjp03eelTNS85EhTqpq/EDPIWsz1xhUkMk
	K2ZfzcI7KM9SZhRzSfSmngE+JeirhYQccjzinB0XFQU1+5mJP4lAuN7kV/TpCALcLbMRVNdxwm7
	cQqy/2GKq1mEWDgHoGJ0bLcdNuws+U/rRIIguwaYWQczGR92Y9B0cRv3r8F7crpZfxs9PhlBpog
	HRo4v2SaymO36vs4mcXBny+3THbbtZS3G3EDkkQ5396H0dDQNLhOhDQi0JjeUT7PlfBAPq/7kIA
	UeeyNoqZuKHWivYE6pSbc0EevwWX60Xga2ftHQX21O/+RFyKTmv+V9O/SNR9W2iZvMQv/9vzedr
	VxDsd8Nx1OWoPTt1R89QlDbbX63tbOzNyeNIuTcr6Emi9G7ZSzNn/F41ySOJHPtituw/ZHcqTbe
	SZfsVmOxYGcAWEtA/Jba+4hvw5Ug6oQMflSE6M//Aea1u6FAxArdEo/ZMNuoD9fgCVyZ0=
X-Received: by 2002:a05:620a:4713:b0:8c7:17b3:ae1a with SMTP id af79cd13be357-8c717b3b606mr259995185a.45.1769623125318;
        Wed, 28 Jan 2026 09:58:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7c789sm232191085a.7.2026.01.28.09.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 09:58:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl9oS-00000009ZlW-1kUH;
	Wed, 28 Jan 2026 13:58:44 -0400
Date: Wed, 28 Jan 2026 13:58:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260128175844.GS1641016@ziepe.ca>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
 <20260128153248.GK1641016@ziepe.ca>
 <CAHHeUGVLi8ZxK3qpJ+nk6DcDd8365fdru-vPmkKtF6k-P4FAcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGVLi8ZxK3qpJ+nk6DcDd8365fdru-vPmkKtF6k-P4FAcw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16166-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: B5A3FA766A
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:24:44PM +0530, Sriharsha Basavapatna wrote:
> On Wed, Jan 28, 2026 at 9:02 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jan 27, 2026 at 04:01:09PM +0530, Sriharsha Basavapatna wrote:
> >
> > >  struct bnxt_re_cq_resp {
> > > @@ -121,6 +124,7 @@ struct bnxt_re_resize_cq_req {
> > >
> > >  enum bnxt_re_qp_mask {
> > >       BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
> > > +     BNXT_RE_QP_DV_SUPPORT = 0x2,
> > >  };
> >
> > This is set on the response but there are no new response fields? That seems
> > backwards?
> This is set on the response field so that the library can figure out
> if its request for DV QP creation (set through req->comp_mask), was
> successfully executed by the kernel driver or not. If there is an
> older kernel, the resp->comp_mask bit for DV would be 0 and so the new
> library would know its request failed.

It's backwards, we expect old kernels to EOPNOTSUPP when presented
with something that only a new kernel understands. Failing that we
expect that userspace knows to never send something new to an old
kernel with a global flag.

> > How does compatablity work here? Old userspace will send a short
> > structure, the new kernel should effectively see 0 at all these fields
> > is that OK? Sizes of 0 sound bad don't they?
>
> New kernel won't even look at the new fields if the DV bit is not set
> in req->comp_mask, since bnxt_re_dv_create_qp() won't be called; i.e
> if the request comes from old userspace.

Ok
 >
> > New userspace will send a long structure and old kernels will ignore
> > the new bits. Is that OK?
>
> Yes, this is ok, since these new fields are added specifically for the
> DV use-case and a new kernel is required for this functionality.

This does not seem OK, but I guess userspace can detect the resp comp mask
and convert it to a failure. It is not following the design pattern.

> > I would expect you to set QP_REQ_MASK_SIZES in the *req* comp_mask. If
> > old kernel then the kernel fails the creation and userspace can do
> > something else.
> >
> > If the userspace passes QP_REQ_MASK_SIZES and the ioctl succeeds then
> > everthing is OK. Delete the comp_maks in the rep structure.
> As decisions are made based on DV bit in comp_mask (explained above),
> this is not needed right?

It is, the point is to have a comp mask in the input saying which
values of the input are populated and need to be processed by the
kernel.

I think it is not a big change from what you have here, just check the
comp_mask and add a global bit that this kernel checks those
comp_masks properly. Ideally audit all the structs and make sure all
comp_masks work right so the bit includes everything.

comp_mask should be checked against the list of bits this kernel
supports and if other bits are set return EOPNOTSUPP.

Jason

