Return-Path: <linux-rdma+bounces-16811-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG9KBLr7jmljGwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16811-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:23:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC81913503F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43BB23043D12
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 10:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBC534F24D;
	Fri, 13 Feb 2026 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jutMZ+Eq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314047E0FF;
	Fri, 13 Feb 2026 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978231; cv=none; b=gqeUmZbktFRQi2y4qGKDbtOhpgbS0nFkF4MYSw6wYiGmMNE3woB2U76nozsfsFlMQlq66Vwq/Hw9udmQQheOET4DYcaM1QevHhEgJJgDjJVS1E+nbWv5QOqYBJJAKbN92UjkqQ4PjiQtf+sPM8u1au0l2xTdxDTuIzdAxB2IVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978231; c=relaxed/simple;
	bh=EmgYNowgzsgngqiwbNGLUCjx8s7jb22/RVygMVlURpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfvLR4JYSnyXx3baEEpXBJpQX7vxzg9B8Taeue53lH7t8OyjFW5akemarSTkX5uzLvrSLappCzTS1Yo0VCG9l32OyUBoQ3kBplEv6gQY9kQNJ5hXnEOGkbnTzlCUfcCn8hERSokG+XHFkqXoRmQQC4tZe5fuIcq/1xUZ7CNe8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jutMZ+Eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901C5C116C6;
	Fri, 13 Feb 2026 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770978231;
	bh=EmgYNowgzsgngqiwbNGLUCjx8s7jb22/RVygMVlURpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jutMZ+EqNAxWieCEWF6QzyL4yOF9XVq5JnDxoUOAZpe9ZwxCRj3CEdkVUn5Ilc8O0
	 BeIGxopvIfGz2i1Jjq+Tjih/dRx5j57wYnEZB/Zb8PmFYwRrw+Q/PP3Zxhbm4Bd0a1
	 /8trhaKFBYFdPclh8sejaZNMNx154Z14vptV5Sztjpmrktg0CyQY104Xl/9GjN9uMC
	 jmdm3R6s9ZjfzskMzTZ1lU74EYUkDApeFJ7aO0hIOZmCnpAK7mM+O6keWPFVQFKL17
	 PeB7OepKWQu49Jeh+ywMxJAEE4NFv+ZsXdfa9AEeCKSPW4Hnd0XeVwbi2XKUG8uzpI
	 bict7tCdLTt+g==
Date: Fri, 13 Feb 2026 12:23:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 05/10] RDMA: Provide documentation about the uABI
 compatibility rules
Message-ID: <20260213102347.GL12887@unreal>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <5-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16811-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: AC81913503F
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 09:45:39PM -0400, Jason Gunthorpe wrote:
> Write down how all of this is supposed to work using the new helpers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  include/rdma/ib_verbs.h | 81 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)

Can we add these rules to Chris's review-prompts?

Thanks

