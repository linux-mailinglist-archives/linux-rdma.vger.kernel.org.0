Return-Path: <linux-rdma+bounces-22693-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Buv0BEGHRmqmXwsAu9opvQ
	(envelope-from <linux-rdma+bounces-22693-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:44:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0816F9944
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=launchpad.net header.s=20210803 header.b=MwMT8aGX;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22693-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22693-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=launchpad.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9CDA300DDCE
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC80837A847;
	Thu,  2 Jul 2026 15:38:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5737A85B
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 15:38:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006719; cv=none; b=NLPhpun444k+inZF+ykNBT8+amONyTcMQ5G0yUrgBiJf1Y722qUhqyY80eP+3bv7AAcC/9AwwWD+yVcOxV8v1hT6ku1lCqGu/wtwy746zOsb+SV+bRFjThTpBES9/AV02vPUrp3m1G8G8VVBZ48LJZA0n2qrviPfM9WAUlaJAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006719; c=relaxed/simple;
	bh=Yykn8FB2MY3aJoAZtlnrXDWXPAtviaFggtQCDxBkX/A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=A6ky+5Lng2nIu+PoiWhcmLz+SxAc8vq2e1ULcBQaF2GZxXrD/Xw26F0/9skcCxS+dzYel15ykHf3UslVAvDvarNiY2jOgbIet33ts0xg8tEF0rVMBDnu0jJDZF2F52Rb1lwrBCt9vnuQL1Z17w49HSK4Lr5BPMH40G6ECnBs+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=MwMT8aGX; arc=none smtp.client-ip=185.125.188.251
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 1F31C4246F
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1783006709;
	bh=Yykn8FB2MY3aJoAZtlnrXDWXPAtviaFggtQCDxBkX/A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=MwMT8aGXh1R6Z7mzasFu++3ftNffuM1XnJT0lfM8FrGCwLTEFNZKH5cC+xnU0Cxjl
	 mfmGiaPlJkoOLq8CsYj05uPqknY4AWJdPPdbhM1jXBCjD7+h/vUtYK4LzoJ0YDfAZS
	 pvbcEenV1MP+us1r8wAHA6G9fx09fK1BI6ZN0ZUv72g59WIPI8PiEtvTr45C8IaY4/
	 MKcJbQjQ5SvtWrvzYTBXsFLlKtt/1casf1gxs7jC/PXkwgSeIsuMKRLlFWQlbWhFAa
	 eAuJzoPNbDO3w/xckBG53xlEXdqdZOaXsYS0qrmxFqCiLOy4m5pvMGnH8AZh7qmB5Y
	 FJgbj4NEM0eyg==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id DCCB0BD3E2
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 15:38:28 +0000 (UTC)
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
Subject: [recipe build #4060663] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <178300670881.3391778.9077992282733880329.launchpad@juju-98d295-prod-launchpad-51>
Date: Thu, 02 Jul 2026 15:38:28 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="c38ea58da9d7185c4996adfc854ab433551cdcdd"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 806b5ab67a017f8df3b9994ebe88ac6c1ad63060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22693-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,launchpad.net:dkim,launchpad.net:replyto,launchpad.net:url,launchpad.net:from_mime];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E0816F9944

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4060663/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-005

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4060663
Your team Linux RDMA is the requester of the build.


