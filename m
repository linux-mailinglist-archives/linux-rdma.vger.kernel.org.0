Return-Path: <linux-rdma+bounces-20122-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDKyCLNe/Gm7OwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20122-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 11:43:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 967DE4E6310
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 11:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BBF5301628D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D96136EAB8;
	Thu,  7 May 2026 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="BVf6fjZb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECF3382DC
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146659; cv=none; b=IHtbVnnBhB3b2KUQjgqCEAEciLXgBBG0ccauewi3CFm0J/Zq2PFuTi/3bPK1yxPOVRqYfl3w6ASqdmEUJA1m5U8b8rWK2j6aDbquWXovE1fE65fWPjV8xFXSvyNs1/cGpAoYoYWMhEwhJpcrgrAgdzH6SJJafc+V2GfqXAKcsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146659; c=relaxed/simple;
	bh=9D0tnZdvcgmENMmtjSewlwWAbU6vOd9vRcDQRE7dyug=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ZuTB+/D+KHE6qpyUQYZHKDyX9e4pjZqbPibUk/yMwRqNltrCSjv4dRFv0nyPthU5Skyqg/cxR788p57wvPVRZOexz3ZLynKZxFfPQbJvcnLe3cICi6TpdTY2Lr9HTTmmDzb837RasezuRBs0fd7mvLij6UXnrLtrMqIiKtGWUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=BVf6fjZb; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id C4FF53F060
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1778146648;
	bh=9D0tnZdvcgmENMmtjSewlwWAbU6vOd9vRcDQRE7dyug=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=BVf6fjZb9Qnv6YIndjcxe5yTc5BsN16TgI4Cmfw0s0jc2b4xpw/rz+RQ+tgzjsuwy
	 fIXVE61iWiDX8+s6qTQ07K5jpwb3aIu5d9izZ1TxL4YGK04K7RpgdqKwbilqx2XSyZ
	 UMYrNRkUZjwqXim4/avE6X5pnczP7pVZSwfA4SboFQMYcr/fuj5iihUakZWtlRIhEF
	 CpaNbCDnrOv7OARGgSO0GQls877TwICx6cRgDg+xWrlSwdZCejlXL5GST07nda3C5C
	 9h9DL1vcdM2I1uVi5qI3NtSLoMzFDI5UB1XFEuZZGXkkdAwd0OG0rJqxbnnZp7TFLZ
	 iab0Km8KKr5kQ==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id B84C0BD9DB
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 09:37:28 +0000 (UTC)
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
Subject: [recipe build #4037364] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177814664851.220553.7659260825755555204.launchpad@juju-98d295-prod-launchpad-51>
Date: Thu, 07 May 2026 09:37:28 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="91d5f4cbcbec62cc98ca9991c8ad99af4e21f85a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 40d7962f95fd5462442b7be862f4b5ee50a8d933
X-Rspamd-Queue-Id: 967DE4E6310
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20122-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4037364/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-108

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4037364
Your team Linux RDMA is the requester of the build.


