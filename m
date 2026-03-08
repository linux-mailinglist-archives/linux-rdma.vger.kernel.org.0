Return-Path: <linux-rdma+bounces-17722-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NffJjKjrWle5QEAu9opvQ
	(envelope-from <linux-rdma+bounces-17722-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 17:26:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6D123111A
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 17:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 386093004928
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066FB318EC4;
	Sun,  8 Mar 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="AXQxUq6r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DB24503F
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772987183; cv=none; b=Kxh89JMMctaGrKfUTXTnWXB2W00e2QFzLpAU3ZTw91TZWR6DDBz6OLQ9ZkDIr82ZMcuXviVCTFuk0Qkm66d8I/pKU4OKcxF1Biyu/9ckxnZp8QhY2YS7GXNmLqGQaOeofMiT7OS7pOwZoa368Y74WKCfM0P2nDzwBVXcfdlrWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772987183; c=relaxed/simple;
	bh=ImpbnWLZKBbAXPtYotmbiK3cQlEolVn7s48bdTQxsi4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=OXzSYSHT3sfUav2GlWJmsA7E8V2+rQ456u/JjHJoToOlgf9XNA7xGbYqesTv5ZUu3Hcmmi5OKwBiCjts26PZxaG0EIigEE9wy0A7rsd5StMB99/S++RTYctggt6gyKfBJFdE/rUx2aZ2QCfHoF7Qta6AgdAO1JkTEa26VHvueRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=AXQxUq6r; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id B19E1403BB
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1772986635;
	bh=ImpbnWLZKBbAXPtYotmbiK3cQlEolVn7s48bdTQxsi4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=AXQxUq6r8fW4M6k68ws5e55Q8vColH/W49nIddvXs7V0Al/ir+27ndsC1HOqw6trX
	 d+P7vtNtDuCOqmgPlHzmRHReIqq1GtPE3giM32Oy5t0hdsWDN31GDAWQqY2fkG/T6y
	 23NKiTlAnlrPi3MSA6uhFMXl+2RVO5VTvbCYvuoO2P4ly/A/HOB0tHYSapwoJfT3vk
	 CTA1JtNoDPpNdfYViSXNUPxT15Vzvk2D6E6Sgny9YR2FMORDA6HhbYLA+rH1Op8+Pi
	 Q5n5XVTgnzLKtkWXu7Bwt9dFu1za803BeEYciPBqcLKGeRsWJk7P+8eZrAtWV3i02u
	 Z0zltWHQrEzyw==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id A38B7BDA4B
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 16:17:15 +0000 (UTC)
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
Subject: [recipe build #4016237] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177298663564.1515240.1683695071103171548.launchpad@juju-98d295-prod-launchpad-51>
Date: Sun, 08 Mar 2026 16:17:15 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2b2e09fee12efee48836b36f2ca9a800f38d982a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 4b2d2325defdaece4f7b1f316b5a0c71c138e4cf
X-Rspamd-Queue-Id: 2F6D123111A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-17722-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[launchpad.net:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[noreply@launchpad.net];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4016237/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-061

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4016237
Your team Linux RDMA is the requester of the build.


