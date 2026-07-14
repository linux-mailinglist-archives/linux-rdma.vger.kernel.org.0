Return-Path: <linux-rdma+bounces-23177-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KpCNBZDcVWrruQAAu9opvQ
	(envelope-from <linux-rdma+bounces-23177-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:52:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE2F751A85
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:51:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=euiE0QYt;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23177-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23177-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 771913008604
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 06:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95CC3D9DDC;
	Tue, 14 Jul 2026 06:51:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AB4282F2A
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 06:51:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011908; cv=none; b=M7aFgmoP1CJe/UU2MtB1fCGrRKJVA0ySXssCP9I+g6JHGZwPcfC0S3uLmo8qSxXXvbUb84NoEp9eVf7ZqSlriJ4YmRzEbnN8T8nllnM9Wbj4kkCT1xRAECArCsSTqmujdr/P1JSh/5qMTtcLSQ3XdhbiliXC/BsNNPfuAMPBK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011908; c=relaxed/simple;
	bh=0wpwMzWx0zUeGiz0GrBYGzn7ZCKP8qly7eW1AXVCFx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SjzTvi17EL/7ahlAUNrPFsmwcHMTMfPdXSn2UHgZmAO7wWMbAX54IfNe6vRR883AkKXAKpYNlzPzxxmsfHTs1Hvl+cq0G6yiFSMFuxPcmOrccvBjHmadYuN4Yu1HK3QVPuhZ0CI4BNKpHLMWlCaRnX1gmSrFJ3yWNCqL7IFMwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euiE0QYt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E731F000E9;
	Tue, 14 Jul 2026 06:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784011907;
	bh=HYwSvi76+LIHCexu7iNlzxGLArlh6dRaX8AGY1huT70=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=euiE0QYtjCpl1jUHm8NKm0JD329RrR7GnPpo14h0WwkD+HtgJ4mBG3K/aJm9MZ4Xn
	 Irma52UguwAomwJ9nT4Q133x7JuUxYfksX/KmMFILw0U783KVpKkLdIhw3m8PRfU39
	 rzaZsIuDlE7EtEklZOIRq4TQblBFtRaFbYDl39qjOj51Kh2pG19BxayZj1A1lwdQdE
	 F+6Nxg7rAlXIjOSAsEg+2IwFAW457alC/oEefZlr95H76MHCUGtDjO+iWEfWrvHaSD
	 o3HUyW/LfCsvT6sU056LZC0abwME9nzZOV0lRP893nXomnSuqH+N572YFP8B/xo22Z
	 ikyGwbNf7xoFw==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev
In-Reply-To: <20260712134413.19226-1-mrgolin@amazon.com>
References: <20260712134413.19226-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next 0/2] RDMA/efa: Add support for 0xefa4 devices
Message-Id: <178401190409.5911.11672275004586418241.b4-ty@kernel.org>
Date: Tue, 14 Jul 2026 02:51:44 -0400
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23177-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AE2F751A85


On Sun, 12 Jul 2026 13:44:11 +0000, Michael Margolin wrote:
> Make a minor device interface change needed for new EFA devices and
> enable support for 0xefa4 PCI ID.
> 
> Anas Mousa (1):
>   RDMA/efa: Add EFA 0xefa4 PCI ID
> 
> Michael Margolin (1):
>   RDMA/efa: Extend page-shift field in MR registration
> 
> [...]

Applied, thanks!

[1/2] RDMA/efa: Extend page-shift field in MR registration
      https://git.kernel.org/rdma/rdma/c/4266547bdce742
[2/2] RDMA/efa: Add EFA 0xefa4 PCI ID
      https://git.kernel.org/rdma/rdma/c/6a57af838b1a56

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


