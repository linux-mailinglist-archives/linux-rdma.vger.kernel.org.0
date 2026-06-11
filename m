Return-Path: <linux-rdma+bounces-22105-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S4doJL2WKmpVtAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22105-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 13:06:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143D67125A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 13:06:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TSh4tvWf;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22105-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22105-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1AE93016B81
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 11:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A2E3DCD9B;
	Thu, 11 Jun 2026 11:06:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE53CC310;
	Thu, 11 Jun 2026 11:06:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175977; cv=none; b=XyGOffPCui9bcCIM7BkZkQ/a1Mu0qTlexq1Fw9hQ0w5OSrLAkl//JABi/TgQJFCrAy/NZD1Ezj+/00HjAaLHgrgTRzQnBjpC5zBS50uapiTy3YyOadQyxgdYDvX+YdefKeLGAp3DVcum6i/dfTok720eJyN+cySMqzJdlv4c95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175977; c=relaxed/simple;
	bh=mdIW+noiwpJa24GNvr5S4wvOC9o45W9VwHn1zZyJgiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KA3zq25Er/NF8/UvF9d9E/ptFT3Cm9RywqLUUu59Ksh3YpiKfMpwhukrQ9Y49BfthZUvc1pLpyJtSwL5dQLNKPONky33yC2mxh250cu0khTzOslH4hF5UIkOFqfJ7FcLY418y+zDOK+UoqZ6o8UEEcl/MEJJs5S89OuphOiY6tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSh4tvWf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5F51F00893;
	Thu, 11 Jun 2026 11:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781175976;
	bh=cQMZUur6ePNKgccie7CWwiNLH6GvEcbvGCAzwHXFYWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TSh4tvWfug9njt05DuVqD3pgzpw+i+AMPiQa4wZHkJZpvwWEI6UrHC2bzTNd2BxvT
	 W49TcSgmYN95lcy2VdXrPvnqZboNe9DONM/VAcvCehxZnojj1Kh2C+xCIKWke0n3/C
	 hf+07LTMNsy7LzIVsh4zAOsA1xrODu/fn7yv7QmUwtRsExTFI8OpXGiquz795i32az
	 Cgj5TvPaeFpqBd1h4nIi5esD2hRUZni/YWzIBOsfJZ5Ka1zjoSbNuq9hB/YEappIVu
	 fNGjFP0BBzD8nWzIb+1tdDBIb+jKg/79f9VFWd+hwVVf0k5pN2ybq6ft9cQP08OwKT
	 EknJP/iAZITOQ==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Abhijit Gangurde <abhijit.gangurde@amd.com>, 
 Allen Hubbe <allen.hubbe@amd.com>, Edward Srouji <edwards@nvidia.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>, 
 Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
References: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
Subject: Re: [PATCH rdma-next 0/8] RDMA: Extend packet pacing support to UD
 and UC QPs
Message-Id: <178117597316.3200217.13896844622260724399.b4-ty@kernel.org>
Date: Thu, 11 Jun 2026 07:06:13 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:jgg@ziepe.ca,m:selvin.xavier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:abhijit.gangurde@amd.com,m:allen.hubbe@amd.com,m:edwards@nvidia.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:msanalla@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-22105-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3143D67125A


On Sun, 24 May 2026 18:38:01 +0300, Edward Srouji wrote:
> The primary goal of this series is to extend mlx5 packet pacing (rate
> limit) beyond raw packet QPs to cover UD and UC QPs while keeping the
> IB core free of vendor-specific policy for non-standard modify
> attributes.
> 
> Today, IB_QP_RATE_LIMIT is restricted by the IB core qp_state_table
> to RC QPs only. It is also the only non-standard modify QP attribute,
> but as rate limit support expands across vendors, and as additional
> non-standard attributes are likely to follow, centralizing such policy
> in the core becomes impractical. Each driver is better positioned to
> enforce its own supported QP types and transitions over non-standard
> attributes. The series therefore removes IB_QP_RATE_LIMIT from the
> qp_state_table and modifies the affected vendor drivers to validate the
> attribute locally, preserving their existing behavior.
> 
> [...]

Applied, thanks!

[1/8] net/mlx5: Add UD and UC packet pacing caps
      https://git.kernel.org/rdma/rdma/c/a7b8dac8881dc6
[2/8] RDMA/mlx5: Refactor raw packet QP rate limit handling
      https://git.kernel.org/rdma/rdma/c/e1008f19fa977d
[3/8] RDMA/mlx5: Add support for rate limit in UD and UC QPs
      https://git.kernel.org/rdma/rdma/c/29e0a014ddfbdb
[4/8] RDMA/mlx5: Support deferred rate limit configuration
      https://git.kernel.org/rdma/rdma/c/915bbc8578e3f7
[5/8] RDMA/mlx5: Report packet pacing capabilities when querying device
      https://git.kernel.org/rdma/rdma/c/1f307090e95750
[6/8] RDMA/bnxt_re: Validate rate limit attribute in modify QP
      https://git.kernel.org/rdma/rdma/c/8cca27313636c3
[7/8] RDMA/ionic: Validate rate limit attribute in modify QP
      https://git.kernel.org/rdma/rdma/c/c2cd90ab881c69
[8/8] IB/core: Delegate IB_QP_RATE_LIMIT validation to drivers
      https://git.kernel.org/rdma/rdma/c/8b0c66fa058b34

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


