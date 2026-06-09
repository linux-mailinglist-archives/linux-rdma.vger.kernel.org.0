Return-Path: <linux-rdma+bounces-22014-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H2DVLUkBKGph7AIAu9opvQ
	(envelope-from <linux-rdma+bounces-22014-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 14:04:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2E965FD3B
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 14:04:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=launchpad.net header.s=20210803 header.b="GUa/YDz1";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22014-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22014-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=launchpad.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CC4A301104A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7412F404BCD;
	Tue,  9 Jun 2026 12:04:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DD3FFAAA
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 12:04:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006658; cv=none; b=MH2fKC2dsXC9U9HeRQJ+75yncnsCNnXHIj41eTNscQt+CgUuMkhQTthCehsbDF9NhdjVl2+QXxoXSeWPj5PzNeJdUA8GNqxAJMg4hvnqlSopYckDZQYH7uRyFl1AxYxJ30ZQ/0ZynhEA7ZzPe8rL+MwZEeeQaJzbnOkNmPWc3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006658; c=relaxed/simple;
	bh=m+fwNac0d3eghZ2l9RLWeUSq9OY2Icj+ac7oXmrrZHU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=b9zSujEkqha1rr9MQaH4hkuBG6hyBdLO/3OakA9YDviIJvcw2XvrsWtK0b13/M2y4txUlYAOHq+968e+O2bvWE/XawAIUF8k2IRyFH7AK1fi+9fghI20kHPwTXkLbUUgxFK40BIyMctl+6vkE354mFo38cHI624XAkSXg7aRbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=GUa/YDz1; arc=none smtp.client-ip=185.125.188.250
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id CE7564031F
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1781006647;
	bh=m+fwNac0d3eghZ2l9RLWeUSq9OY2Icj+ac7oXmrrZHU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=GUa/YDz1Um4ZeFK8BrkVYNDjQQfT3CsYah+kAoggkT9FVh9nJykfHhEDkxSFmrsEI
	 ZNKORdrOuf2zyGf55XU+EcaF/WpF8s9+63s7kKs6hC9ESJrcqae+G1zjjR7w4K7Ni6
	 SzJWYxgN8tVOOd67xOWNquyeAUz48lmyDacDrahCvyIlHmlatQsV6qMGiWwKmt5Y8f
	 KuQHgbSsxOaKe1F70UUTQCmT81fch2jeOc+Gdon5tcNXJHfbP/iYe6M6o5QSvtBqE+
	 45Vwqnjvber8VZXNl08xxdKFlAleg2qrAth3IjUxWnjvT3G5nQoJL87Gf0fS7mUltI
	 5lKqnNyuqSUwQ==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id 913B3C5073
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 12:04:07 +0000 (UTC)
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
Subject: [recipe build #4049948] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <178100664754.3806946.881234282292865707.launchpad@juju-98d295-prod-launchpad-51>
Date: Tue, 09 Jun 2026 12:04:07 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="f85a4e13f5f1af0eb2d5aadecdf089bdd7783432"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ad0bdcae2c888f595cc18159c215a922842b5e66
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22014-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D2E965FD3B

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4049948/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-054

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4049948
Your team Linux RDMA is the requester of the build.


