Return-Path: <linux-rdma+bounces-19507-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFVgGvkt6mmVwQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19507-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 16:34:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F9453C0E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 16:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 184F5309DC77
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60830329E44;
	Thu, 23 Apr 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBhgnuvH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D82317150;
	Thu, 23 Apr 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954453; cv=none; b=XudQsDrOdypEErNmRnt1u/OIBsh+J35Thhn7sREDFmkjhxI0YNOdx6SwwlaG6mJXoohkYTOOAzXCKDCJMI1TJztHhlGol1xPbVmf/j4qBm3ZT/wpBNddid4zuXIK5LENGCBO3/HVy3h3Yp+QsgmZAOvLxq1bH6qow5ZhPnhb+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954453; c=relaxed/simple;
	bh=uxLcnyxU+oY9ZFJ7oDqaVldtr9UKvzaY21jcdjJAcks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2upU/JqYPuydVFUCZiOqN+DGiLFh+LgP8bx03V+5AGRdFFm70M2kkHxThyRKoVWMM0+1eZvirUrZd5WjuA0gh/1TvCYns8+0ylOOeNjaOmwdrYNEl064jvGtO3FQ8gMzK/d4YmohRCh4hHICVABjULoHjlI37n6KzrfT74lB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBhgnuvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34987C2BCB3;
	Thu, 23 Apr 2026 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776954452;
	bh=uxLcnyxU+oY9ZFJ7oDqaVldtr9UKvzaY21jcdjJAcks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBhgnuvHle6qFfbnIZp4Qcm/N07GS/oJMboksQriQMBu/EMHw+5UsC5R74XlNlESz
	 ENVR2aecm+aIPCe5sOc36HK7SaOUVYBNwbG+eMuvMjbOhjo601VUappxJoqz/emcZB
	 XSOTq9ODTWZbGRKL5vH36IqmYQOnthFb3juICDbdOboPsJQpQpaIUhZ9uALmkd6y79
	 QDYTsSpIPLCtDrgfU58twz8LQtE0k355t8NMtpLQ529aTZSAv5uyIJd1hcf06v5DQJ
	 FXC9qumXmudyunxD/eLmiTv89U1IMKt4B9cXQ/L7FEFpGoXQ4hZEO9b49dH0VwhuCl
	 Q2hT5Zagw55GA==
Date: Thu, 23 Apr 2026 17:27:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: zhenwei pi <zhenwei.pi@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	zyjzyj2000@gmail.com, jgg@ziepe.ca
Subject: Re: PING: [PATCH v7 0/4] Support PERF MGMT for RXE
Message-ID: <20260423142728.GF172828@unreal>
References: <20260414062948.671658-1-zhenwei.pi@linux.dev>
 <ba50cde9-b26c-4dac-a494-0caa00603928@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba50cde9-b26c-4dac-a494-0caa00603928@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19507-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ziepe.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B8F9453C0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 02:29:35PM +0800, zhenwei pi wrote:
> Greetings! Gentle ping.

We are currently in the merge window and are not accepting new features.

Thanks

