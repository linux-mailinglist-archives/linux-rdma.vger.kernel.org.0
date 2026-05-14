Return-Path: <linux-rdma+bounces-20623-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOv/DvsVBWoUSQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20623-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 02:23:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3260A53C50A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 02:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14AD23018AF5
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 00:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F0271441;
	Thu, 14 May 2026 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkoSgbwJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95B1A76BB;
	Thu, 14 May 2026 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718195; cv=none; b=QackDUH583WvsQQyLr7iq3Uz2Dk9Gxmx0uJEjgwwNykUZwpj9OFkceqmme8tQZUZNB/nmTYHLlGu4pfilXDWFUbCHwak9NwEuPKCDs4yfVfOGzrk7REkJgjBwpeCxQ2XuwJXQoJOBeK4kHRRyTnCLFh2vOYfCydz7A1X7RrgB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718195; c=relaxed/simple;
	bh=LBlMw0rC/Sl8ZWesQ3L3vS8PBcEnOpafwNwjAK7J3iU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHECixMfzGrGQchd3Y8xYPbjnyIr4o67Iw6k4yARYxAjKF/FXeraE9iLKRtR0I5fj5jdUP+bQIn+4Kouw93cejsbkSbKlWib8EQ1/3sYP8+5Y14YU1Duqllr9Fd8DlQ7ibOlg5Mqz/4r5tk0mypiRe6ahJ3Tr5QDok5Y7faG+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkoSgbwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FF5C19425;
	Thu, 14 May 2026 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778718195;
	bh=LBlMw0rC/Sl8ZWesQ3L3vS8PBcEnOpafwNwjAK7J3iU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RkoSgbwJmWqPbAJACPMSC+HRD/oGmlD1NBCewEkZD/y6GGmQCUp7UsWoaDa6VQVKR
	 j5YcMDdAJxtd6DSDkTtSEB4d4hIE53Ax9oE8tWb2LLjfYfd7dQXD74tlaQ9O5UfnTR
	 kxOD5neDOHvn3e+KR7hvEX/pNYzJapeWcc4XdjYfBvf8knC5uhIyBjLSznP33AcMlO
	 Ef9+GyYrc44ZtILO7gFlUcRaTJtd3Ax/2QfE/uMR2J+xWkQM+9oh4MLDvOSqN2RZKG
	 3r1biYWk2pz8ENekFtXKwgY++ARTkubNfrFw0B+lXM5QZs3Ndb+J8vQPgntTuRwVhJ
	 +NCXfxCIm40tA==
Date: Wed, 13 May 2026 17:23:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Abhijit
 Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next 3/4] RDMA/ionic: Add debugfs support
Message-ID: <20260513172314.35e71e7b@kernel.org>
In-Reply-To: <20260513072113.GE15586@unreal>
References: <20260506041935.1061-1-eric.joyner@amd.com>
	<20260506041935.1061-4-eric.joyner@amd.com>
	<20260513072113.GE15586@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3260A53C50A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20623-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 10:21:13 +0300 Leon Romanovsky wrote:
> 3. The patch is too large and exposes too many details that should be
>    gathered through the FW (fwctl).

Why? What's wrong with debugfs? Much easier for people to access.

