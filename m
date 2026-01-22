Return-Path: <linux-rdma+bounces-15892-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL2iCL1ncmmrjwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15892-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 19:09:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B3D6C038
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 19:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9D88315C52B
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B47344D9D;
	Thu, 22 Jan 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GyzpgD4P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C353EBF3D
	for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101810; cv=none; b=G7LRQG1XOVBJKuIvKoj8vd+RO6EGVaXbjaY7/2n9LDPoaQz6O/NcX6AAY/8WA9GIi80C1dkcn0L3Zs1ASA5a0+b8h+CIY5mVcei9d/H4122PR0M4WKTx6zN9OhF/ykCMydBKzzs1HE1Z/hQKym6Hnau1nTbVrhy3ID3KBsQLvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101810; c=relaxed/simple;
	bh=InjV94M9hZGmudvwWkiMkg4m+x4BjkmMac/RvNBa7mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvGmYYczT40MXGMO8OPZulkOsdEbE96dlbMFpKgf7XBS/XkIbHpbX++zPVhKXlVWqS+0x/PHTHB84EDTmHq9ywcCvdosh31t025ygInWx2uB2E/wGzccYRm7j6Tb4lp9+dUDk7aJriauKtzCueOHKlRgYi8s7X2DzNrB3CdcwfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GyzpgD4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AC2C116C6;
	Thu, 22 Jan 2026 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769101809;
	bh=InjV94M9hZGmudvwWkiMkg4m+x4BjkmMac/RvNBa7mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyzpgD4PPVZJ5vWI6gC52eC+dgWT2KFHGS7M5KcyRsoHuHRhsRJRRnO78h16TiLNr
	 ODxNnsTTR6diE2mOGnTWdIFq1K7WauxwcFxvXv7KZy36EMrWk7sMNHxqtpwXCjzG65
	 3ATjhLPyOza9eaS2T1LnDw3Nei0e3W1/g5mRDPWY=
Date: Thu, 22 Jan 2026 18:10:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yi Liu <liuy22@mails.tsinghua.edu.cn>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH 0/1] RDMA/uverbs: Fix missing wqe_size validation in
 ib_uverbs_post_send
Message-ID: <2026012249-huddling-scorn-d194@gregkh>
References: <20260122142900.2356276-1-liuy22@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122142900.2356276-1-liuy22@mails.tsinghua.edu.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15892-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4B3D6C038
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:28:59PM +0800, Yi Liu wrote:
> Given the potential for kernel heap information disclosure, I believe
> the first issue may warrant a CVE assignment. I would appreciate it if
> the security team could evaluate this.

The kernel security team has nothing to do with CVEs, sorry.  Please see
the in-kernel documentation at:
	https://www.kernel.org/doc/html/latest/process/cve.html
for how that works.

And as this is a public issue, the kernel security team doesn't need to
be involved at all :)

thanks,

greg k-h

