Return-Path: <linux-rdma+bounces-20972-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMFGLpx9DGoSiQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20972-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:11:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D70E58128E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B1A7311A21C
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14F329E7E;
	Tue, 19 May 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+NFsIvX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1A280331
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202574; cv=none; b=IqWISFqdAFFkroerwq9+FsknZFC93iGYX6nWrIeapDxRyj5rz/bI9EHHPWm0lG6fY/Ru5sTeLK6XmrxuJcm8hqR8bLR34YDCr8xv0uCZf/sxidmZ4kkPKXgXbt+ig6sADb8YJGkPpwwd9Bh1sEAd1GxFWmRSY2KPehlBvfMZHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202574; c=relaxed/simple;
	bh=/IOOVswHnGZekbdLeQdYK16fvsenRgw7oQYPLEUaMXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atfdHLV4c/oCcrFPd9IHQJ07NYfryt0vgeppMTlxbGSvB8UP2b1cjWwQ/y74yTNWMs3ljHGDjG50nOVdL44LBsQtS69e2tkjg0nCbd39Y8ECHfRbdD3VUsJWb7jZXisvml8gRXm6/b3McgfTb113qnPU6yE0e0DvD641eKJViQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+NFsIvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E59C2BCB3;
	Tue, 19 May 2026 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779202574;
	bh=/IOOVswHnGZekbdLeQdYK16fvsenRgw7oQYPLEUaMXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+NFsIvXIWxDcez4caLMllFZj6TLbFGN77RlNOfgryDobkh8AVozeDpI2saYqZqGc
	 AjhVNmTRPPNzvxp3LUPcVMNLUUkNxOhNflBjLPW/zsiz510pnyPppIwzFMb/6JFwQu
	 pbG0A5XcDiFQ8g5rjlolqh8deEslYQsFlaE9ap+AmuTPLT8emFK6qy3UTXPAjgB2ec
	 7aV43o4/mKDwJtvxz7E/tahm0ezA4F+Ffw35gw+U1EBf+FWx4uJztpasoaS2DsC+Mo
	 ZtPT5lWNOrD1SNrv1HjqgPnaBPGP/W0fXbGMnU5NnOKrLVvxVSo0p+K/E+o2KhzY7e
	 CZNmTU2ZTVVjw==
Date: Tue, 19 May 2026 17:56:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Tristan Madani <tristmd@gmail.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
Message-ID: <20260519145610.GA33515@unreal>
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
 <0ae59679-5cc9-48e4-87e9-63299684acf8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ae59679-5cc9-48e4-87e9-63299684acf8@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20972-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org,talencesecurity.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 5D70E58128E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 07:03:18PM -0700, Zhu Yanjun wrote:
> 在 2026/5/18 14:50, Tristan Madani 写道:
> > RXE queue buffers are mapped read-write into userspace. The receive
> > path reads WQE fields from these shared buffers, which lets a
> > concurrent userspace thread modify them between validation and use.
> 
> To be honest, can you implement the above? If yes, please show us the steps
> to reproduce this problem.

It is an imaginary problem. One would need to run RXE (development,
virtual RNIC), write a buggy userspace application, and then be
surprised when RXE misbehaves after running it.

Thanks

> 
> Thanks a lot.
> Zhu Yanjun
> 
> > 
> > Patch 1 fixes a heap overflow in the SRQ path where num_sge is
> > validated but then re-read for the memcpy size calculation.
> > 
> > Patch 2 addresses the non-SRQ path by copying the WQE to a
> > kernel-local buffer before processing, preventing TOCTOU on
> > fields used in check_length and copy_data.
> > 
> > Tristan Madani (2):
> >    RDMA/rxe: fix TOCTOU heap overflow in get_srq_wqe
> >    RDMA/rxe: copy WQE to local buffer in non-SRQ receive path
> > 
> >   drivers/infiniband/sw/rxe/rxe_resp.c | 33 ++++++++++++++++++++++++---
> >   1 file changed, 28 insertions(+), 5 deletions(-)
> > 
> 

