Return-Path: <linux-rdma+bounces-16324-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC9LGrNygGkw8QIAu9opvQ
	(envelope-from <linux-rdma+bounces-16324-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 10:47:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6677CA423
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 10:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45953304925F
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD621B918;
	Mon,  2 Feb 2026 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="BW68UhtM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7B2D1303
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770025360; cv=none; b=CysGiet7weYn3egoZPhWfWRnvpycpuvu3I00RgvuQJX+vuJlY4Ixmec4u6ATuXxy8IzqXoR9T5XahouezQBRlmxz7hazJ+Z9F4f2OKOXnbcQaGVV6F2P0lf7IPJciKswYWzrzpMM3fRoe1cKWTRGsnUGZ2C0YGcUe13yy1K+syQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770025360; c=relaxed/simple;
	bh=GsN7Bxjbw1jhh3xMS52h7dHswg0lMcBD+PrHyXj+/Rs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=bdPr04J+u3Z6skvvHEGfZY2GObhS05lS/XkIl68iaeqpd4iMyo9wAW0cwxPOmGbc2vh77nDJ0DU5W81BPGlttjYMmSVOmZ6pNk83OUp6k1DQIQoFK9rXvOagyUehzY4lnn2D02v9rJhPpv9omLBYiwJDq/d6jNBZB8vbHM5vih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=BW68UhtM; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 680483F15B
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1770024808;
	bh=GsN7Bxjbw1jhh3xMS52h7dHswg0lMcBD+PrHyXj+/Rs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=BW68UhtMdUjGSxzRmz3TVFdwJ8N7FLa08nr8A/HZB67ypdNspy4nMf4TLl9LgTaHF
	 J+LykH1K5+E0kRQNHMVdq3YunccGcqFCbzTTnHVOUAjfr9Ur/Cl8r4U4tcXODdwDdA
	 NCr62VIttogl9DOgKmxZGzDSqR9CztqG2yFM0MVmcw6EG3joM5Hnlm6rP9esgOg36L
	 MrMTe3xFdxJOM2sYW89Hd4c0iHT4DmFG09je8NeZKKPd2xMW2geqXmCYS+CkNw32Sw
	 aA/uVxpWKdCWDUB6Ex9FhBzVGHjzlhlcCyiY5MqFwnGjEYBLkkTTyH9Ex3iKxHrft7
	 YF98HBERN3yPA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 439677E772
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 09:33:28 +0000 (UTC)
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
Subject: [recipe build #4004369] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177002480827.1615174.2816703563865500175.launchpad@buildd-manager.lp.internal>
Date: Mon, 02 Feb 2026 09:33:28 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4847db153920c8fbc330ac275b92a72279fa07a2"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 26a0e11f509b6e568b79161c8ff6e9d85b1cbc15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16324-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[launchpad.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[noreply@launchpad.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: C6677CA423
X-Rspamd-Action: no action

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4004369/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-119

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4004369
Your team Linux RDMA is the requester of the build.


