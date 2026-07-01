Return-Path: <linux-rdma+bounces-22772-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U6fQOrJjSmocCQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22772-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:01:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8270A330
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:01:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bz8aMTbJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22772-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22772-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93AF2301DCC6
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0D37E301;
	Sun,  5 Jul 2026 14:00:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2149F37F002;
	Sun,  5 Jul 2026 14:00:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260041; cv=none; b=NlWvNgd4PRVvPXfWnkWZxEC+FxMTdD1bw4oKFwmB/FxUjlaFflMXn9cZ92ancGKev+A0vFwzAlEvu+kOdCnZT76BIaCD4Z3CbZGeVygvIa21oP4trB5Bkd3fGuiWfQZQ52VHY7wjo6UJCo1mj/0uCRkDPXAWzeEHv1wMsUM4sOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260041; c=relaxed/simple;
	bh=dIgM/e/kirb9aRF1wwS6FyPm98YEncXJWIh0NBcJpWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qLn/HA6Zs1llX14Z4viOsE6vxjFXyX8B6IBNpgPDPTkdu9pYP/WaXWzhYcT41/yhMr424YvpaC7AvZzUxyVoRvEWSK46kJAxV8a56i5F5mANKtGnccloipyLJ2mGTQrwZ/1d/xnCV683g5FpUVW+glV6qgKI3PyCiwerGRLLhEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz8aMTbJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DF91F000E9;
	Sun,  5 Jul 2026 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260039;
	bh=Cindx022M0lj4qSwLUTNCuroG/E6P0ePMlG+2zgvzhM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bz8aMTbJIiVmyzrLyY8zv0KikaooJESjqEujeNzVAPE5DIKUwBq6WSi0XM9iVG5fW
	 Hqw0ScwaCqcMwIsLlyEkyzx4wX/b13PAeXI8A3VTBfktdCL+E5hJH/4QaaiHkPHLrM
	 5Ny35RI1HqTdOJCclpFBwxpzpvT2sGeC4pGC91qhhEk/k+9DjIdSecKO3+udSfOxIX
	 fRTVN7YyXGDornsAW7cthO3oOcXPOPQnNabq9myHg1wAeoooTs+aLWfW1jDEPKrB7R
	 cV2l79kG+W8tdjM8q3IG3XplkmeitcUqKOoBU64b8WSImQs3q4E/jFf8QzpE+uPngR
	 UPg/hOhxDsb+Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260612201611.4127750-1-arnd@kernel.org>
References: <20260612201611.4127750-1-arnd@kernel.org>
Subject: Re: [PATCH] mlx5: avoid frame overflow warning
Message-Id: <178290923937.307054.11359323071152941607.b4-ty@kernel.org>
Date: Wed, 01 Jul 2026 08:33:59 -0400
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
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[97];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22772-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:arnd@kernel.org,m:arnd@arndb.de,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DC8270A330


On Fri, 12 Jun 2026 22:15:59 +0200, Arnd Bergmann wrote:
> Building mlx5 on s390 shows a rather high stack usage that can exceed
> the warning limit when that is set to a lower but still reasonable value:
> 
> drivers/infiniband/hw/mlx5/wr.c:1051:5: error: stack frame size (1328) exceeds limit (1280) in 'mlx5_ib_post_send' [-Werror,-Wframe-larger-than]
> 
> The problem here is 'struct ib_reg_wr' on the stack of
> handle_reg_mr_integrity(), which gets inlined into mlx5_ib_post_send()
> along with a number of smaller functions.
> 
> [...]

Applied, thanks!

[1/1] mlx5: avoid frame overflow warning
      https://git.kernel.org/rdma/rdma/c/f5ad2ead846e3a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


