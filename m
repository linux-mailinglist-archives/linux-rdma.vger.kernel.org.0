Return-Path: <linux-rdma+bounces-22775-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ThqJdJjSmoqCQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22775-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:01:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ED070A343
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:01:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YpygdvFT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22775-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22775-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCE59300F5D5
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1FA37FF41;
	Sun,  5 Jul 2026 14:00:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6537DE9D
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2026 14:00:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260050; cv=none; b=b6UfZ1BSjidPS/gJ2TZtL7QuLWiGA84NFPamffzJdl+njqVpN+4PMiIwl3JNy7ISEY3tQoEpsgal/uwjK6P0fGlX4U878cKhXuqvGT6JrBGQZVwdCvFgU1fiZQE65Hqiqz+smVPqAYF3ftbZGJoiphQoc6r6C9Svjn2i3KXOfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260050; c=relaxed/simple;
	bh=qN319TXaeYmRwxOpSozB9Hh25fWAFiHQJER0/QXq6Rg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CeLalmkQ/IMjvKKYXWgP2ipeXuHxp+TD6GD0eFXJCL417EuawX8jCQymCcqpRF0AyBslDOp7LP2gBfkPnE4QzOzClOO/1Vr3PqvtltvLeE5eodBqCWNfz3b7SgRZ65CTXWMYk2eYp/iqZdVjxYZK8APYD6PXOWbdKmPwqKNHUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpygdvFT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9D71F000E9;
	Sun,  5 Jul 2026 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260049;
	bh=j6DuzcmkeTZrSDbVGek4Zy6e7b5YCkONK9X6hz+hltY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YpygdvFT8UtYvoHNvgV+XD/SUv3Y5UgGGWBkNOKytI2Tz3piKbobbpwMP4MDOXvVE
	 12PyU7/0goGTa+sY2iTY5yBh61hOYtVOW34iZp2z1SiJtByozAvzlFLjTFn8hMXBCN
	 15pceuMfGvh6JvIOOgD1CSYJ5lCKDAeRGgCtTAQF/AL9Vf3h7AeVRunsRmdvQEe/08
	 aTkee9FgtUfnNtOUK4PZRWUsNKGU1EpglbVbIEZ+pNHGfubdWEgqao0RTYLjarhGJ+
	 LMl+ncKr59e6R3WyPTTeXCVNBiPfce0vTmYA+Ck9IKIIKA+hn83Mhk7TtNDDE46W/m
	 8loNu/WN4cLEw==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, 
 Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20260617141936.3280979-1-jmoroni@google.com>
References: <20260617141936.3280979-1-jmoroni@google.com>
Subject: Re: [PATCH rdma-next v2] RDMA/irdma: Prevent rereg_mr for non-mem
 regions
Message-Id: <178299386411.615406.2919527433922934520.b4-ty@kernel.org>
Date: Thu, 02 Jul 2026 08:04:24 -0400
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
	DATE_IN_PAST(1.00)[73];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22775-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:jmoroni@google.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15ED070A343


On Wed, 17 Jun 2026 14:19:36 +0000, Jacob Moroni wrote:
> When a QP/CQ/SRQ is created, a two step process is used
> where the buffer is allocated in userspace and explicitly
> registered with the normal reg_mr mechanism prior to creating
> the actual QP/CQ/SRQ object.
> 
> These special registrations are indicated via an ABI field
> so the driver knows that they do not have a valid mkey and
> to skip the actual CQP command submission.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Prevent rereg_mr for non-mem regions
      https://git.kernel.org/rdma/rdma/c/a846aecb931b4d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


