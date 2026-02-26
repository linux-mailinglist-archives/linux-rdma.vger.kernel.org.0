Return-Path: <linux-rdma+bounces-17202-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMkOLqTsn2nYewQAu9opvQ
	(envelope-from <linux-rdma+bounces-17202-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 07:48:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE82C1A16C5
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 07:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A484C301779C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 06:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537D2F12A5;
	Thu, 26 Feb 2026 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfG+LL7m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490882DEA74
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088480; cv=none; b=Go3L+g8WzfVT5S0NN6Nu7z8uToGJYijtYimPKyQj26gc1oWsv5+mBpyUGenNyT33QsntUfPEzm6tb1fLy6Lpn+ebqpjoYfEBVphcHwSiUgjiJYqAAYxbHlL5XxAqK+5Kvk4GL4fz7xoXDVGG4ks2XYEnU3KdauJb3+ipzC5vZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088480; c=relaxed/simple;
	bh=t4wESATMOo20qCJVgdgP6ow7wDQIV3HPJGyoZtHI9Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnjBjwxutZB9nwolrk7dBuOc4BBzOrSK0shnAsOukgwsiny0UlWIrn0WIJ8wEXZgwoeSlQKQJ3KzdAx568HG161GNRSX3JJ4kz5bQUEILJWLpagNnoaXxE5bc+Jqp0gR/eyFpAVdj+IynDATXrQ1mLNGwuIDyLwcG0pphebqonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfG+LL7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F11CC19422;
	Thu, 26 Feb 2026 06:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772088479;
	bh=t4wESATMOo20qCJVgdgP6ow7wDQIV3HPJGyoZtHI9Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfG+LL7maETOZ/eso8enPNMH9ldclghGUfJuL0GO68XduJtEnbRZRKPenoW6KPGXj
	 CrR1clHUwMNLue58EaD2Ugw80TkpLW6M0d0XyR5P+FHG9l95VLhwijIsYDtKeKuOW/
	 OYkmdkAvCEEsk8154exgA2Wd1q85idQEMcEu5UnlooqD7nizsG9RMTRAistKbCHl80
	 xp6smuoKSv/thoeUkeY0WRkiucwlx5I8EjoHAfKqpXuvCXXU2qrDrjXr1IMhUh8coZ
	 AEeLR0o8/HYbSz1BSqxcMHyyAT3irx5lUAhOQvpVJN7QzdJ7ZqFm0c+31KGdyI/Qwi
	 z44o3/ctXF88Q==
Date: Thu, 26 Feb 2026 08:47:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Add network namespace support
Message-ID: <20260226064755.GA12611@unreal>
References: <20260225172622.7589-1-dsahern@kernel.org>
 <e87e7871-d35e-4b91-a00f-1491ac5b6dab@linux.dev>
 <18ecbd06-baac-43ee-a455-6b34c716fdfe@kernel.org>
 <88b82e8b-40da-46cf-bb41-2c346bd28c70@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88b82e8b-40da-46cf-bb41-2c346bd28c70@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17202-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE82C1A16C5
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 01:07:12PM -0800, yanjun.zhu wrote:
> On 2/25/26 10:50 AM, David Ahern wrote:
> > On 2/25/26 11:14 AM, yanjun.zhu wrote:
> > > On 2/25/26 9:26 AM, David Ahern wrote:
> > > > Allow rxe to work across network namespaces by making the sockets
> > > > per namespace using net_generic. Defer socket initialization until
> > > > a device is created in the namespace.
> > > 
> > > https://github.com/zhuyj/linux/tree/upstream/6.14-net-namespace
> > > 
> > > Do you make tests with the above link?
> > 
> > no. I had no knowledge of that branch until this moment. It is almost 12
> > months old, so not sure the relevance if it is not being actively fixed
> > on top of tree.
> > 
> > > 
> > > Compared with the net namespace in the above link, what is the
> > > difference between this commit and the above link?
> > > 
> > 
> > no idea. This patch was in our tree at enfabrica dating back to 2021.
> > Someone started looking into automated tests with rxe, so I pulled it
> > from the tree, rebased to 7.0 and sent it out.
> > 
> 
> https://patchwork.kernel.org/project/linux-rdma/cover/20230624073927.707915-1-yanjun.zhu@intel.com/
> 
> In the above link, there is some testcases for the link
> https://github.com/zhuyj/linux/tree/upstream/6.14-net-namespace.
> 
> I am wondering if this commit can pass all the testcases or not.

Zhu,

It is a bit unreasonable to expect a random RXE contributor to compare
against something that lives out‑of‑tree. Please feel free to pick up that
patch and run it through your tests.

Thanks

> 
> Thanks a lot.
> Zhu Yanjun
> 
> 

