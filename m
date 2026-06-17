Return-Path: <linux-rdma+bounces-22330-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hkhuGgDuMmow7wUAu9opvQ
	(envelope-from <linux-rdma+bounces-22330-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 20:57:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C622769C0B7
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 20:57:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=launchpad.net header.s=20210803 header.b=efEtbxAq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22330-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22330-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=launchpad.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3A5830F747F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A037DAA2;
	Wed, 17 Jun 2026 18:56:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4937B407
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 18:56:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722619; cv=none; b=ecx6WXTvY8BONd0dt4G/ZSjIeosqH4Jkq6Ki+2slwYf6UDYGoCvQA+2gV96pnfQKilZ33hh9kIBIUPkUCSpnRZ75cFKMEs3wVNNnd+gsRXliVj5iG862Vi6MJvwp3zF+1yr6I9D2MK/YZr6NvfOjdy691An/b5OZf+xY3omPveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722619; c=relaxed/simple;
	bh=GqIiKnlay0A+e2M+zwVKbTjljmgaQwTbWxn9vlBpr5g=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=DMfqCVN73niOv4T1yQJKDPr/h4MlW9nhnYz7O3kjZw19+ACzIvl/I9RR1qdKHcdGiWdYCX/oaUzeEdmgvlKrlR/eni4ftijRpBOTS+tSDXDZumEb/dzgOL5SQyuin0/SoXc0ZQiGPuyH/wxtBv62SeextKVQMosSl5eExMU969o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=efEtbxAq; arc=none smtp.client-ip=185.125.188.250
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 82E483F18A
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1781722060;
	bh=GqIiKnlay0A+e2M+zwVKbTjljmgaQwTbWxn9vlBpr5g=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=efEtbxAqceO5KdrUc96hBSPFZnMIvl70d8dBIawAqc5CJlb21eG1L81bLnKg0CnwL
	 1N72yckaJV0IN0HyafENFBEu/lrJeYDj0bugS5UyHlKzrpeCiYXndW8f3ikH8njDJg
	 v0h4zUo0heGPtvc1/mpmx1MTo/b6sXmZd04SVIOVdx/YDKfO16tCe270WZihdS7ak2
	 RcNeDwPbUgkfteFJU9LW9nvGylfvJT7h3AfuOZJFt5Nb305Nh4syGcwdFeQne/vwxu
	 xqMwROq3i3ZdhowPgL5YdC8KEM14NwP5JgsdP1lGjw/6sUdgrzAtRJMasHNc0HTnd5
	 YKECsUGv3ccmg==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id 2FD5BBD9D0
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 18:47:40 +0000 (UTC)
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
Subject: [recipe build #4053516] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <178172205991.127449.14308662436117379240.launchpad@juju-98d295-prod-launchpad-51>
Date: Wed, 17 Jun 2026 18:47:40 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="81b3240738cf12f6bd4aac6593260fef8d7b0d96"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ea796d26fbbd56f7c444068580d089492ddf12c5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22330-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,juju-98d295-prod-launchpad-51:mid];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[launchpad.net:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[noreply@launchpad.net];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C622769C0B7

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4053516/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-030

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4053516
Your team Linux RDMA is the requester of the build.


