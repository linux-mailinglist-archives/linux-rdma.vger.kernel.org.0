Return-Path: <linux-rdma+bounces-16170-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK4bDcRmemmB5gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16170-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 20:43:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C63FA83A3
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 20:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8803014865
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 19:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820737418A;
	Wed, 28 Jan 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Me+3Rymu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC21371047
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769629377; cv=none; b=JT4nEZ+eYYOj6RqfPPVdisAyDFa1jsh6nKw7eA2yZUuOKUA/S8Gl64wloL+db3OfaLNfOoicf84PnPmV/RnaAMF63KQCp7UBruRwOzPnljhWgE96AA2QwiVwfTHzBIeMrvfSnPaoLGaC+GO0H5Mq3yUeQEPg60FODmjCR4EZUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769629377; c=relaxed/simple;
	bh=64rKKqXnbS80+pPcCMhuMSKv7pQcIjON1QHXQ86K92c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbY6DDBW1ARM6CE3Y+GoyCa/otgf9y7HEtzOhNgYUQGGjP3x1/QCytVfvMTNyGkjsFpCmk/dfWvQJq/+23n5bMonXJ6xszaew9/IB+X/S4WSVS3bYA2FfJcmw7LC9cvZsgYktTgnIE015q76edN7m2rwk2OfATnSsCKWtcviY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Me+3Rymu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-501469b598fso1263651cf.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769629374; x=1770234174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pSSZPEO2o6NYQXN+m2vz4IElalaTESHEE+EpJwvEbzA=;
        b=Me+3RymuhXGBBLYZwbgGqJnlMQzFXwV23pnYJmPthPCIVYVr4MSTxmXKCa25j4XnIs
         ckmqBnAbbNkXszn/h5FqCuSBkE1WVfnacaQ8OenH3YcPhKGpHjA3UU9zkq6KPnyX+KHJ
         Vg+pSNp/zsUnFYMkrVdl7les6OQwxTDdadft/Cd+xWCxKW2PZJvvH5DQWU0zFXaQB/Sj
         JOzOEY4EgdhO3/sR6u3iXLMcVfkBRzqS1Q2AhoWcqs051ohjUaRQRqyOSEnFzcJ0QmFC
         pDlA/tIt2/BrV90Pjb4npajQBnDaC8wmJyvByhIzJ2dbo6egZnEypU//c6vwKpaCraUr
         WAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769629374; x=1770234174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSSZPEO2o6NYQXN+m2vz4IElalaTESHEE+EpJwvEbzA=;
        b=DRVe+gQg1M6vMqIZcPtHZr3G0K9wzRbI9+2XXQUtkX905zMw7xOvHi6it7VP1qWoHW
         uviGHG1KQpcgpSa4Sau3yltQycLNSTWsOgMAYyoIPhbQFjHBvtFvIPio+0tVy+updVXP
         OfnmLwl3xT3fRAP+fojKtJu6GzM4wYVfHW96x/ZjJi4Et5txof+zfFhQhgWAsqfImN/T
         R8zd+4Ue1acJJzbioE58kICkO9ZtSNY2z9x8vPXS6m0o9Stm/B297lBcX0VESg93G2Mg
         znLKXA07AR4VOl013imLUWAbUcb99eLZDFXSNgtXXLz3/skEhyI/YejL1O9OFzSeDQGb
         b7cg==
X-Forwarded-Encrypted: i=1; AJvYcCX0UB0UWQohcdpjkCQI2CiY2zenswy6wX1z2abDrxNTGhKedqyPmTRjQnqjhxACIUh2SBNSLjlBVa1e@vger.kernel.org
X-Gm-Message-State: AOJu0YwKs9C/xOeRXmtyT76ka/IW6gb+jIkSPUJMvTkT8Oed0NZfQ1Rl
	i4YD0RiOhqdXyc7HIjNYRsU3GC6GNfJoYPKBJRYw0c9qHi64m7fvD4HJBYO96BliVAs=
X-Gm-Gg: AZuq6aJNEZcSFQ/N29O0CyIDz4XF1TYuMbtY/ymfQo+cLcsi/iZJFX4xyvD0OxBvkmg
	c7UesZwPLs519XwDEL+IINWFmWb3/ospIUz2cLM8V5qCrbPhXNUhpUFJvvR4QSblUHAkeUhy4hq
	hUBynKsh5cFJycayJ5bs2zQNv9jKpbPvpzn/beeSmDodRcTFO8xz+1mdQzm6rYBpwNlFrmsB8Wz
	rYlYZflKJXUeKuyeFtAT9Ww5JsuogAlWxfQR7UfaXO2nCHVMhSofuZa7QM7JJMGU/Kss9XXfFBJ
	T2Q3BwmJXDo6zVEuDGoPmsnbEWdX9S0LaKfNCEoW5B3VZvVXDteZk2KpSvEXtpAsdFsGYGPrp8J
	fy8W8RncsBGT6dCXv5YXbgQieMK1/JSkyjgNbLPf9U5/r9BAeIZbMhtU1rOgt4Pm4CWQwkesjFH
	P9X7vrDbvvyXA7whBdudplJnBOLUm7/XPhzDTnDh/z3lcf+ajU2rDatQyAtbRhrsH7bDg=
X-Received: by 2002:ac8:7d4f:0:b0:4f1:ab66:7c43 with SMTP id d75a77b69052e-5032fb1d4dbmr80306841cf.74.1769629374565;
        Wed, 28 Jan 2026 11:42:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c5d4sm21993361cf.3.2026.01.28.11.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 11:42:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlBRF-00000009b0I-28Qo;
	Wed, 28 Jan 2026 15:42:53 -0400
Date: Wed, 28 Jan 2026 15:42:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260128194253.GX1641016@ziepe.ca>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
 <20260128153248.GK1641016@ziepe.ca>
 <CAHHeUGVLi8ZxK3qpJ+nk6DcDd8365fdru-vPmkKtF6k-P4FAcw@mail.gmail.com>
 <CAHHeUGVZCojAmjmqm7yPys2N2TYApPnbMN3dcb4dnWDL_sAA0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGVZCojAmjmqm7yPys2N2TYApPnbMN3dcb4dnWDL_sAA0g@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16170-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,ziepe.ca:email,ziepe.ca:dkim,ziepe.ca:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C63FA83A3
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:27:14PM +0530, Sriharsha Basavapatna wrote:
> On Wed, Jan 28, 2026 at 10:24 PM Sriharsha Basavapatna
> <sriharsha.basavapatna@broadcom.com> wrote:
> >
> > On Wed, Jan 28, 2026 at 9:02 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Jan 27, 2026 at 04:01:09PM +0530, Sriharsha Basavapatna wrote:
> > >
> > > >  struct bnxt_re_cq_resp {
> > > > @@ -121,6 +124,7 @@ struct bnxt_re_resize_cq_req {
> > > >
> > > >  enum bnxt_re_qp_mask {
> > > >       BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
> > > > +     BNXT_RE_QP_DV_SUPPORT = 0x2,
> > > >  };
> > >
> > > This is set on the response but there are no new response fields? That seems
> > > backwards?
> > This is set on the response field so that the library can figure out
> > if its request for DV QP creation (set through req->comp_mask), was
> > successfully executed by the kernel driver or not. If there is an
> > older kernel, the resp->comp_mask bit for DV would be 0 and so the new
> > library would know its request failed.
> I will change this to have a separate bit for DV in the response
> comp_mask, instead of reusing the same value from the req comp_mask.
> Is that ok?

No. Do not return anything in the response comp_mask, you must fail
unsupported requests. That is how comp_mask is intended to
work. Userspace uses the uctx to learn if the request can even be
sent.

> > > Also, what is "pd_id"? The other users of pd_id in prior patches seem
> > > to be actual RDMA PDs. Why is something like this being passed here?
> > > The QP already gets a PD from the core interface, why do you need
> > > another pd?
> > Let me take a closer look at this and get back to you.
> Agree, we had this earlier in our design, but it is not needed anymore
> since we are using std QP-extension mechanism now.

Ok great, because you also were not refcounting the PD properly with
that scheme, that is fixed now too.

Jason

