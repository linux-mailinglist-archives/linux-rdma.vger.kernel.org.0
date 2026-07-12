Return-Path: <linux-rdma+bounces-23063-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xwz3CNRQU2oYZwMAu9opvQ
	(envelope-from <linux-rdma+bounces-23063-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 10:31:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C8374428B
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 10:31:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f+nhu7+H;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23063-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23063-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35FCA300613E
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 08:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5D32F363F;
	Sun, 12 Jul 2026 08:31:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B156266581
	for <linux-rdma@vger.kernel.org>; Sun, 12 Jul 2026 08:31:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783845072; cv=none; b=ii5xyK99AP4AJWTMQURMTLHhWXW8FggNv5IL1uvQnDuj+dClgEJ02RsU9M96lbEMwN40rctPHl4u+j9hxSeIQNs8eYMd9UfHU9aecprJU+DWlFIUmHDRONdSNTRnYxydUGJCSxiUtDrlH8/i6xf/LrCZ66L+83TJF9MXunzb5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783845072; c=relaxed/simple;
	bh=ViX/pi0jS2j9nP11eqo95K0RRiPHUwO847fNpUWRGCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tUOmf1aWkU34RdepPVuMKpODVhT5wk6z0FLjRzeOBaihhmW1S/QzexG9T7Ta8NYcC0tYae02aqdwytzbAgmlj+z2eLFLt6/xzlZFHDPUyUy4pzYiGQ6lXdqdHrcuMCseaGsvIbze+FeO4K4hTroxCAvth9uA+SsL7CRAgcm/MAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+nhu7+H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311A91F000E9;
	Sun, 12 Jul 2026 08:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783845070;
	bh=efc3fQQ3ZDkTp1fkEWzBY35Ff3fb0WN7xPmoUi7zWdg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f+nhu7+HItJ/TAwKypmLda3h+BBYtQhxGqOu/nt6jXAOPAUG5KCcYBpN+8u1cAoCN
	 NkzhNwm4IZb79EDnlcojRKSI/VBiTk9ZF1vimVpXqxQ2hIlBBbvhmaqyUi0L6WV5Nd
	 4q9KYVIPwQ0g2id3BzeuAwFbySTBa48RAYM7UszeBa6xu+HcPLvy1JP/CfvsYHJZrq
	 QJ+SAUZdlHXWZAVD79wxkX179iAQMjM4muOHTit4jAnRAcEx99/NRAY6yZQHA2sido
	 32JxQJZ5aPwH1OVZTmffm/EuNBJ3fQ3/foPitzAm5IYTosbKm/85tYzv23qVWrSfFj
	 j8YHFtT6kI0NA==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, 
 Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20260702170652.4159201-1-jmoroni@google.com>
References: <20260702170652.4159201-1-jmoroni@google.com>
Subject: Re: (subset) [PATCH rdma-next v3 0/7] RDMA/irdma: Adopt robust
 udata
Message-Id: <178384506798.1545032.10718094571776220022.b4-ty@kernel.org>
Date: Sun, 12 Jul 2026 04:31:07 -0400
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23063-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:jmoroni@google.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3C8374428B


On Thu, 02 Jul 2026 17:06:45 +0000, Jacob Moroni wrote:
> This series brings irdma up to uverbs_robust_udata compliance.
> 
> The driver has been audited to confirm that:
> 
>   1. Methods which do not accept udata input perform an explicit
>      check for no (or zero value) input.
> 
> [...]

Applied, thanks!

[1/7] RDMA/core: Add ib_no_udata_io() helper
      https://git.kernel.org/rdma/rdma/c/a833ce42d05624

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


