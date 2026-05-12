Return-Path: <linux-rdma+bounces-20516-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG2QBIN+A2rS6QEAu9opvQ
	(envelope-from <linux-rdma+bounces-20516-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:24:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E37528A05
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F8630ECDAD
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 19:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE0385D77;
	Tue, 12 May 2026 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BObeh3Jc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BAD33BBD9
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613734; cv=none; b=rqbb9G2ryqhNu4PoPX5RumebWmInI3NLmJt57hrTi1L67LEFOhLQK/0twA0Iywdwe5TquIXg8OmXeR3ZoUXejt9E2z55RcMdos2H38n7HzVqfQu2PTKI3UkMjaPYOiBfGvXaRlo/9GQymdPFNTHNyRjqFxlf1kg9JG/fQObHqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613734; c=relaxed/simple;
	bh=7fsfeDD5zsNoYVgje1C07OQIG+0JdbWQD1nkccVjhc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcKEkRviyoP1wZbR6v0io/Fa/TjW4akuDMQhfH0AUYUm1LysvyKRJWCK3ps6o/Wz51zgZyyqHsOs1xNGRKdWoBm6DXlQEVzHlm9adVViHBWHM6AGpO8r1fjxwiEjyzoDvXr4p1sSrlDACLIHSPom/xdDJGyKDDT0XGp0W+3vhng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BObeh3Jc; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ea8563c693so637090185a.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 12:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778613731; x=1779218531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ks/LjlQK/JG7n2hZUU+2VkG9aSuUcSPPQPk8i5p6XOY=;
        b=BObeh3Jc3nZpYmPyeeIy9Kr1gweFviS4e0Bfj1jMqiAOXLkXq+vKxPwx2FgFYnEFZc
         ajwk4bE3U+C4KU1pQHAZxAbqlDTjR54k49Kmqfdb1MO92cN4M8gsSTStFs8qs14wdZUG
         H4X80yjAoDZlO3B/RySF4kbP7c1TAoOa8ud27Au/MRdpRmijjXX/pm+BT9KrhJDo9K92
         TD1HLg9rxSIZobmlcfbVay8gAsBY/eoxp6IbG5IBgRSUW2PDqFQKiA6Wf4Kny678Ng85
         UUKFxiA2Ag0dfFuOFaW09uZ4Tqx1/CjhGRTnfbkGpTAldn/eIqYieqPsIxF3iclEGajV
         rdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613731; x=1779218531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks/LjlQK/JG7n2hZUU+2VkG9aSuUcSPPQPk8i5p6XOY=;
        b=snvomS3cu40wzjljUMucBotEqvT2Tn1Vzq3Fu2+iJmr0gAxMqfqz8HWGxnXgm68GOy
         Uzfw+P4IGRsYidyPDbt2oxhn7/dmvl+wOOpcF1rohoQh9UBqsG+Kl/DS+nyntym/nuvF
         MiwtpM1Ffk2Nf42uQJP0vOMS0hsC8qF15hvU7pfUWGJfLfTuBbDGFVYOOzCKm7m4R/gS
         xxZOdBJVH958QsrSQRnfWO2NKV7mNnt1Rlt2uBu1ZyBryjIPbtLcobqo0qbq4Qx0yU3n
         T+XPwBYSDBLG81OPdounB0wbFRx3R9aqRGwCszqXHMOjI/vCBL55093mwgIyrqpvrKBx
         9EBQ==
X-Gm-Message-State: AOJu0Ywxci2mESKzBMIBl+t09DR2q2JHix+hnJ/Y4ccAdGpo1AGyZaO5
	m7Ms2WHxf6woU/HMlCzovKV1TG7ZmSYUMaWBo786TiAeJToe4Xr8IDVEbFyflThg1vY=
X-Gm-Gg: Acq92OEebyw11ZijhP4lVVhnXd8QtyBbZR364MlMTFBkjAVI7eMg0+OFHXpKZCZz0Bg
	pbOeLh18+CoWz9J8qZpKMipDlp18LygVvBBkGjr4j8cKipUKID5rOEAEZZhpW91HquBla+kWiZH
	1rtv835+oFIpX5SJ8BbJpPXEWsDg3y067kdP6TEdy5RIFlFlQkKOPD0ICmcdZ+rfJRnUHvUgFYd
	JrJhiH8Fx+Y2TUNkEkDqBrt9tFMTt1PceTvGv9QDI+Wm/PD295/7kTICcpiGx+hDiBUrSBDIlH7
	6O7FiVhGu1aNgvTSTyz1CbByKnmeD7q+MhZGqeejAASp5atCmGliYfhkx++ZUErRjeUPi4Nl4iS
	2feJn/1qsYZBUiykOtzU3FvcsJLUJa9Gfz/fkrRCEk+wC/v0skHFG7+TDgmwSK6ENa0b+HmyXBb
	97FimsFo+GyTnPtSZfcE01G890ndlo10u1UOYX1rWHNIH+4ojJ34a0yYTYlNR2eQU1zdMFYBOal
	fVpmw==
X-Received: by 2002:a05:620a:f06:b0:8db:7315:706c with SMTP id af79cd13be357-90f8bb9a781mr41372185a.59.1778613731080;
        Tue, 12 May 2026 12:22:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90d1b651259sm267869585a.21.2026.05.12.12.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:22:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMsgE-00000000wzD-06XY;
	Tue, 12 May 2026 16:22:10 -0300
Date: Tue, 12 May 2026 16:22:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 06/16] RDMA/uverbs: Push out CQ buffer umem
 processing into a helper
Message-ID: <20260512192210.GL7702@ziepe.ca>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-7-jiri@resnulli.us>
 <20260512180342.GI7702@ziepe.ca>
 <agN0Gr4ul-a3DSvg@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agN0Gr4ul-a3DSvg@FV6GYCPJ69>
X-Rspamd-Queue-Id: 63E37528A05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20516-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 08:40:26PM +0200, Jiri Pirko wrote:
> Tue, May 12, 2026 at 08:03:42PM CEST, jgg@ziepe.ca wrote:
> >On Thu, May 07, 2026 at 02:52:21PM +0200, Jiri Pirko wrote:
> >
> >> +static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
> >> +					    struct ib_uverbs_buffer_desc *desc)
> >> +{
> >> +	struct ib_device *ib_dev = attrs->context->device;
> >> +	int ret;
> >> +
> >> +	if (uverbs_attr_is_valid(attrs,
> >> UVERBS_ATTR_CREATE_CQ_BUFFER_VA)) {
> >
> >I know this is just moving code, but I've always disliked this
> >function. I learned a trick using a case statement for this recently:
> >
> >	u32 present_attrs = 0;
> >	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA))
> >		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_VA);
> >	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH))
> >		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
> >	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD))
> >		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_FD);
> >	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET))
> >		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET);
> >
> >	switch (present_attrs) {
> >	case 0:
> >		return -ENODATA;
> >	case BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_VA) |
> >		BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH):
> >[..]
> >		return 0;
> >	case BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_FD) |
> >		BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) |
> >		BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH):
> >[..]
> >		return 0;
> >	default:
> >		return -EINVAL;
> >	}
> >
> >No need to build the complex tests to check in each branch if the
> >other branch attributes are presented.
> 
> As this patch is just moving existing code, could we do this in a
> follow-up? Patchset is already long enough. Will add that to my todo
> list if you are okay with it.

sure, I was just annoyed trying to understand this code again

Jason

