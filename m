Return-Path: <linux-rdma+bounces-20305-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGRGN9GTAGoDKgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20305-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 16:18:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A2E50492A
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 16:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99D363002529
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872C0381AFD;
	Sun, 10 May 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Net6F7F3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20EC34F479
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778422678; cv=none; b=bwZf9+RJIXrUBQC54Bb/tyxkrjTP1hsh5OTwVELdPMBzTsEwQdQj/rMvtOF9xbZj5m3V9i0Yo6E3wUlRHhzraqSVwxoAA9xenzLF8KL+wpaAwodRw1vvi8ffsEyLhgQiVHB9tS3HhsqaJYqgse9bKFYiQpjD3/JBQ+uhJSTD5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778422678; c=relaxed/simple;
	bh=0bKEjRlIxEPYnspZXbCmSzzgGtJyASX4cEhRLyn76uI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=d4wFx74zW3dtzckB7kCVdEYdlnLcBYZYJxTy11OHZ3nEXrKAqIDLI546KLZm4VUf8MB0hvRRO4WN7SHhYSdaGjSXp382TyK5tZNgUn64CWkHO1kAQSQTRUcEzYF+R30oCAyrWzrLAAJhswyAAStrpaZFZO4pBDumYD2p2+Q3iWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Net6F7F3; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 6A22D3F1A2
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1778422668;
	bh=0bKEjRlIxEPYnspZXbCmSzzgGtJyASX4cEhRLyn76uI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Net6F7F3obSSvYOX75SU61eiJUuCgDm8eZOv37RcPtmadxTdhoTNOYWxfpe1zkUKs
	 sAW/Kzy6YeMzIV7cgR82zdLRhQQDFz2QoWt/gJwb3KqTv/R/7Z/TykTYsyj/mpYXek
	 PO+rgtcfgwNequjNAcxfM4SvxF/w6mQ4auZS+/UZxHv84DHJ+WHxkKRN/clEAZQEDL
	 dVMjiGAgA+0XOqOOg7rDxxUoUOxZZaHLxexf3w8efTC+ekQeMZFNYV+YJQFO3Vpuzd
	 0wh+PfYUCd6N73UVOSHmF20A+8HIhjrOY0xHGRW2BTtjog//YSXxrNQq2xnRq9h1dD
	 G/fJTwTQ8Nlrg==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id 593C0C10F1
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 14:17:48 +0000 (UTC)
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
Subject: [recipe build #4038468] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177842266833.424961.15705467242455404768.launchpad@juju-98d295-prod-launchpad-51>
Date: Sun, 10 May 2026 14:17:48 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="91d5f4cbcbec62cc98ca9991c8ad99af4e21f85a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 3bddbc138a4ae94f3defb696a927bb2ef7aa9a11
X-Rspamd-Queue-Id: 57A2E50492A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20305-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:dkim,launchpad.net:url,launchpad.net:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[launchpad.net:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[noreply@launchpad.net];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4038468/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-080

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4038468
Your team Linux RDMA is the requester of the build.


