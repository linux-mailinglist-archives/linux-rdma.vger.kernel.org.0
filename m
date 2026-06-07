Return-Path: <linux-rdma+bounces-21914-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MzNAKYJEJWrZFQIAu9opvQ
	(envelope-from <linux-rdma+bounces-21914-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 12:14:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659264F703
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 12:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fsdWPgdM;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21914-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21914-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88E80304C134
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370D30C153;
	Sun,  7 Jun 2026 10:11:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A371E98E3;
	Sun,  7 Jun 2026 10:11:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827063; cv=none; b=n8BZ/lTVPQFUkSMVfFK00cCk0d7f0XgIxYZygVHN4zkxz2SRjM/NCvuESx8flX5I2RIhNaix5WhfDxUpboe5KHD79mm39S4qgZi01vZiR5IZRa6QstLGzW76g/6JWxfCGCnvLGC8L5PnXAnEo0SA9Opv1dElUARba5YH5J9McU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827063; c=relaxed/simple;
	bh=CopSiw+NcfqVh9zee2U6gLhA98twW+OmwOpd2fZVvUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ouD2RR3sFputN5QXlqymn8MRfQe+C2uClPgFmQSveqeR4g7ZaqBPV4C7fKBV6Ei9Dgr8JdOTKVibCRPGZLO6Y9aRUF+Bty8rSUwJYTfWy4P5dsJJsrUDaXCTTiBymSjBx8Hbq0sh7We/ViCEiM3aQ4bNfElzAQvnun0mMf6fmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsdWPgdM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E351F00898;
	Sun,  7 Jun 2026 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780827062;
	bh=XPB3nQ7jNSWdej/jsORQVH8vmBpgTh5XHeuu5DcxTWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fsdWPgdMRXLNC0RV4QqPFH1XDYDA1QVoPBSNAJsTO8BKd7jkwlxcKJle/ONRcpMv6
	 5PYzT3L3U9fjPz1PfqZ44lWH5JFYvJG3bqV7yBEEZfan/76hkdLuqPjBMxz4gXqqDA
	 BgIVxiLj+uBz2yh5RFX2AFCnXEXoijmZiQEYX3DFUiZbE/g4xBKLIWzCx5QWdfED7M
	 efrt0kMYG9e0pIB68kQlwyICuLOAHCdBBWeqPFWByzlhZ82Buc5rizJyhhYJa/xm4V
	 xn4Tl+VbpG5g2mJGtDT07pFdeu8WWZUF/CqU5uAR6IfYBVz3JC6Y8BWGip2EUAP2GA
	 7qPP15qNhIE1w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260529052359.389413-1-tariqt@nvidia.com>
References: <20260529052359.389413-1-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/2] mlx5-next updates 2026-05-29
Message-Id: <178082705966.3033804.9374462993799593597.b4-ty@kernel.org>
Date: Sun, 07 Jun 2026 06:10:59 -0400
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21914-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:moshe@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
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
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3659264F703


On Fri, 29 May 2026 08:23:57 +0300, Tariq Toukan wrote:
> This series contains mlx5 shared updates.
> 
> Regards,
> Tariq
> 
> Dragos Tatulea (1):
>   net/mlx5: Update IFC allowed_list_size field bits
> 
> [...]

Applied, thanks!

[1/2] net/mlx5: Update IFC allowed_list_size field bits
      https://git.kernel.org/rdma/rdma/c/cc71b7f32f0ba8
[2/2] net/mlx5: Add sd_group_size bits for SD management
      https://git.kernel.org/rdma/rdma/c/ddbddbf8aee54b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


