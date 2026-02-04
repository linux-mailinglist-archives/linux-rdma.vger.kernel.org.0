Return-Path: <linux-rdma+bounces-16539-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCebIKyHg2niowMAu9opvQ
	(envelope-from <linux-rdma+bounces-16539-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 18:53:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E7EB3E3
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 18:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CCE03004616
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15093A1E8D;
	Wed,  4 Feb 2026 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hQzDNu3k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E82EDD62
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227624; cv=none; b=GOaCqCYKjGs0wwO2IR2hIYPSvg5ql/+8/YC6YB1K7mUhlDY53DSQuMHhUbiUiKB83E3EHrUzsUH09I7de9nilT/2Xts0uWP7DvIxVKKY25b1oGimp8VuQx1pEFAXwqlKEfbO6L1ROGFbZaTKguSiwV7tC7Fe3RPQCRxRWgY/8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227624; c=relaxed/simple;
	bh=hU/hPUHbaVPbDKCwyA5sXpOrCShdPh6A27BiiNS1yj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+YtSNHwTnNraPL+x2J82HljPKUxOo2dwZpdMBSkzJMuXqCyfoSTU2JngT9vOqdCCRER8pgh/b0hKo+5gQMWjPkVJgbTpL0SJKruZ4TkHmAJE+pubJMLIi2pXg8MerK0ax7WUOisrKIBH0vSRlZdMWMWpUomnY01ecLG3X1Gb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hQzDNu3k; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4806f80cac9so515055e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770227620; x=1770832420; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hU/hPUHbaVPbDKCwyA5sXpOrCShdPh6A27BiiNS1yj0=;
        b=hQzDNu3k6L/nEKE2xFD+Y3XWR6YirjAsHxpD2bFRsi7fPFdKiGN0Bn9JJSHjUWOfNd
         4nVre6M5z8idpU6EwyvyjvwQuV0Oc6PvlKjr8IhT3pGZ/kEdgR8yKs8LxVbKSnjjM7iA
         AB9G9wCVnWYZlBrMr1HLCLw0h1x3R3zSZ6wcNJzLh63bm/Js/T4RZGceKIJA/AU1CJTv
         zDFw0c19U2EPCBUgiQAWmQK1JaTc1EHj1bweR8ue1GmkNWCZnHUxYWnwRsbdmspF9W56
         N6O8Dn0/hOnSRmu/46lr0IWxBlRfQIUM82sam1lXEGVnnLqZPvhDRPAMgq8DoKn4SFev
         lCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227620; x=1770832420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hU/hPUHbaVPbDKCwyA5sXpOrCShdPh6A27BiiNS1yj0=;
        b=cm4y64r9m4IkepChoRALdXqio38zMGzUd5l62f5NSaFTIzvZeMx8a7gCvsGuE7Bg3m
         f1Z1YGg2ZnF+SR9bTc2LYg0ShB03YryKupBYYU98pXAr2BIAIbLpPRnS/VrZlvCv9/Qs
         35TywRze36bOBA1vFvspIJkRS7pzYp+tU27YtxIiW5RfeSsDxAAoTtlgQQlg9F88IzHH
         3AY9SVfdTvYEq7ZsmKTD5fpUgUyhzAhFJ1td0Xt/D+TjXLx60N/ZYPVIaMU8X1JwQMVN
         P7GGnpp2xY49StnvwGI+wgjXq3uscCFAU0LVlYjQoUxHZPPLMKLDKc8ut2tviYAd92Ae
         mxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGB9n7oYAN5FlgDX/7hQ5oaeLcgWVTG6Flexs8Z/epEsCQLr8cLNuLOvHSiUIBphGp9r1SJszBvlqs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7TSe+9cSXSW7vSh3TlWTHQTC+By+NoMgziJjBc1sxr/kVNM0
	aDgpFxy6GqRT9baIHwE41KoWBhbU3XPEflsBkPIqK3iFRJ28pSKtBqZC1YwRhehBiEs=
X-Gm-Gg: AZuq6aKyBgdpia9nclcpuEiDlTOjiFHBp7neKv8DLw8sHs9W9wEUli3vXjeawHcxoqY
	YXd2rOsLThKBjy3nNTpobZScg4DGYnDJPeF3CaLw4Bh4i/aCVp57mL1N5xaPNLad90N7M8l8tHk
	XWi5wp+SAAZXTnbBFFO3C1qspUtE2/bJNpGuMRtBb3bhvBHmZZRx3O9nRu4ezEqKcUK9Gi4fLYI
	mniFhwaWSBYrhIxco4l7Sl7kH8eQtVv+4eZE0BATdqLlE6noBqlgALB6IXRyDuPOStiuirCvoZS
	WR+3Xh9fuSbnX9cplus8pCp3SLGtYKtBaqq+ydXCG+P9LwtkTf4Yh4QZOOiFcEauaygjm2cxOsP
	PpEf77qaTyq39eLstTnYDjaF2buccF4po/U4M9DEr0ZVqiHlRePXsnWLDEhoFMh0mGQRvnCnADu
	H4fbQSC9W+YG4yaFoHx5LRw/o=
X-Received: by 2002:a05:600d:19:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-4831403cc8emr23918105e9.6.1770227620232;
        Wed, 04 Feb 2026 09:53:40 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ffae8fbsm23145405e9.15.2026.02.04.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:53:39 -0800 (PST)
Date: Wed, 4 Feb 2026 18:53:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, leon@kernel.org, 
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v10 5/6] RDMA/bnxt_re: Direct Verbs: Support CQ
 verbs
Message-ID: <h2mvy2z6ipibzbzmi6jk2jw4so3x7c5rptm2jhpfavizxmd7c6@olttoocrfgcl>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com>
 <20260204011019.GZ2328995@ziepe.ca>
 <CAHHeUGXky2H8NSWy8ZwCcqKDQEBn=CkMAzsLDT5gBFnZrn0WYg@mail.gmail.com>
 <20260204144313.GG2328995@ziepe.ca>
 <CAHHeUGUeJ6YfB59heJ+PN5NkTOAXFSBLQwhS3Y3jpDSfYROO-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGUeJ6YfB59heJ+PN5NkTOAXFSBLQwhS3Y3jpDSfYROO-A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-16539-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1C8E7EB3E3
X-Rspamd-Action: no action

Wed, Feb 04, 2026 at 05:25:39PM +0100, sriharsha.basavapatna@broadcom.com wrote:
>On Wed, Feb 4, 2026 at 8:13 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Wed, Feb 04, 2026 at 07:25:48PM +0530, Sriharsha Basavapatna wrote:
>> > > Here, I made you a branch that takes care of it all:
>> > >
>> > > https://github.com/jgunthorpe/linux/commits/for-sriharsha/
>> > >
>> > > And makes the required whole flow a lot clearer since it has evolved
>> > > into something that is far too open coded..
>> > >
>> > > Let me know what you think.
>>
>> > Thanks for sharing these changes, it looks great. I certainly missed
>> > the point that you were suggesting a kernel helper function for
>> > structure validation and one that also includes comp_mask validation.
>> > For bnxt_re, it also eliminates the need to have a separate compat
>> > flag in ucontext for each type of ureq.
>>
>> Yeah, after looking at it the state was much worse than I
>> expected.
>>
>> > I applied the draft version of QP-umem support patch (not the series),
>> > followed by bnxt_re DV patch set, updated bnxt_re to use the new
>> > helper for CQ/QP - ib_copy_validate_udata_in_cm(). Tested it and it
>> > works fine.
>>
>> Ok, well let me work on posting this series and you can revise this
>> one to drop this UCTX hunk and use the new helpers for the new
>> structures. I wanted to look at the other uapi parts of this one
>> today too..
>Just to be clear, I will rebase and post my series after you post the
>ureq validation series. Is that right? Also, what about the QP-umem
>support patch?

Reworking it a bit. I will send it most likely on Friday.

>
>>
>> > One question (maybe I'm missing something) is, copy_struct_from_user()
>> > seems to have similar logic to check for trailing bytes when user-size
>> > > kernel-size. Is it also needed in _ib_copy_validate_udata_in()?
>>
>> Yes, that is a mistake to have left it behind, thanks
>Thanks,
>-Harsha
>>
>> Jason
>>



