Return-Path: <linux-rdma+bounces-20911-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHQLFBUnC2pAEAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20911-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 16:49:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D154D56F3BA
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 16:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2667A3199C2D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CEA48096F;
	Mon, 18 May 2026 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="XyDxl5bJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8928450909
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114827; cv=none; b=dPqacwLc/MumG16cKZdeJv5kwEioURBYcIWmeHNivhC/Z4OgLr3VI02qrt96aaDzBR9+RyqfTgbXkdC1c1KksAaC0AbK8qeHRJPKq7PjyHNkOdafW0cxnQaahr9FX8+dW8wnDGydxqFfPlRdFXaLoeinic8uLfKdm8/GE5K5/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114827; c=relaxed/simple;
	bh=xFY9X2mjVk6W7f9VbEGtWtnzQDtgT8F27rqDcjsh1U4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Srod19T0i2JaV9RIiy6ysjU6K9Q1tKN48vzhUjicltAJ3RdL+ecr9ZmeiyHn2as2BQxWMYwnAVf6o+iVbBWCBd4hfZw3YaRsCDpAEPwiGlSHtjf5wbk30U3nsl4bTlDOs28e1srrvdDhOK4YAHxkSNsDZC5S8HvoVwIVbZOxwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=XyDxl5bJ; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 253D03F1AF
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1779114817;
	bh=xFY9X2mjVk6W7f9VbEGtWtnzQDtgT8F27rqDcjsh1U4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=XyDxl5bJ5BoY41GyvBSYT//3UWQIieHZ0C39JvKflmVx4eqrsVzdqF0TLnJSPuHE8
	 7etK9i9xJa2bAeb2i8/p3BAvGmLm/SaLcBF3epr4lblTOubT4k5z2jsKG8aBm4UhLR
	 oopya2K7shR2FULDKjBnf2LBUPFew7pGeHTTV3F1T3RIoMnHWlIgV9EraS71bwLrfe
	 /s0CC3S9KL77exuaOqspXB4PbwOZkuTjJXUbW8N1Q1rGsljy49F0YtvUozUolauPfC
	 7ebw37de99w1aFg+jfkDdgt84HoGXVHjmNmJ6sOuKU2R9PxKZPBhLzdme2lGULlb7/
	 HTm/9Xz8oMT7g==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id 0F6A5BD3E2
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 14:33:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: MANUALDEPWAIT
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: noreply@launchpad.net
Subject: [recipe build #4041402] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177911481676.3147202.7045997433300110824.launchpad@juju-98d295-prod-launchpad-51>
Date: Mon, 18 May 2026 14:33:36 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="21e17fefcf122f18da93c143f29f40ba940e464c"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: dee7d267b4027f0d257182123c94a514859f246d
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20911-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[launchpad.net:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[noreply@launchpad.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: D154D56F3BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4041402/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-115

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4041402
Your team Linux RDMA is the requester of the build.


