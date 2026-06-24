Return-Path: <linux-rdma+bounces-22447-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YPYYCzrXO2okeAgAu9opvQ
	(envelope-from <linux-rdma+bounces-22447-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 15:10:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3AF6BE724
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 15:10:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=launchpad.net header.s=20210803 header.b=RPwilU3Y;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22447-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22447-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=launchpad.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6875312EBD2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326C358D00;
	Wed, 24 Jun 2026 13:03:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0DD2E63C
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 13:03:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306210; cv=none; b=THLRnIBKNsdVnMrsTt7usCOKv5oHH8Mx1EYW5wx2CEUdZGsoIIf039T0K98ThsFfuMQWUd89mp69ym59Z0AHbUqMbT5yf9y4vq05ucj7U4HSQw2SDLuo4oUVa5CvH/mLbkVWGitx4lsJ2H7DTI1uaQAhSDZXY3hLu2gqUu2Qy0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306210; c=relaxed/simple;
	bh=fZnTtIjSLXpNcuqYBK9JcBPbwHna+kwShW3LM676oas=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=lP/ND+JxtKHMROrte5IGB0SzKvJ2BJwPd3ov5/T7NBH2q+p25y3psUje9z/2zshjZ7EsjTOYo8HjsWPy7LUDHqmOl1C1kMjnR08ayDG6IvkxjsJjSMShC0r0ZUnO9ED4AiE2sXEqg/lkYfqY7XU48mb6xehaSj2t943aAnCKvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=RPwilU3Y; arc=none smtp.client-ip=185.125.188.250
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6A0F340597
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1782306201;
	bh=fZnTtIjSLXpNcuqYBK9JcBPbwHna+kwShW3LM676oas=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=RPwilU3Y+e3EL1Fm53a24K93B+qzA2D6NZ4acjAi/coLE/fvHShFV/ZDgHM9xCePO
	 VH5xIr/SnKkS2Gv96kFLreJGMqzIZo2Xq9SL5o/cZgRlq5qdjLaGHSXbwzt2XKEZLZ
	 C4xz1IPH5F7bBgL4l1l2jVkuz12DqcPzTrpE7fdItXTQk1dj3sfckGPyClXmTsP3Me
	 jQdxESTCb1RPEOjR5aAOOhsa884ciBgTKx1Llsf6QpHO0J9Bq9lw9zni5labuCCUno
	 kBZcEQpa2oaS32ZGuin5Hj97v9TaNsfxPtoHVCtLDX3ORR5Plat0z1vyxnuCi5MTHv
	 DqMSLC8sHIAvw==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id 33FF3BDA79
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 13:03:21 +0000 (UTC)
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
Subject: [recipe build #4056915] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <178230620114.2634524.7582466509536963802.launchpad@juju-98d295-prod-launchpad-51>
Date: Wed, 24 Jun 2026 13:03:21 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="b14b31288034a9920506d3068d695d7e27dca403"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: cc26f26a5e80418f2b2df8abf1b62a5b3a64e5f5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22447-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,launchpad.net:dkim,launchpad.net:replyto,launchpad.net:url,launchpad.net:from_mime];
	FORGED_SENDER(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C3AF6BE724

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4056915/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-063

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4056915
Your team Linux RDMA is the requester of the build.


