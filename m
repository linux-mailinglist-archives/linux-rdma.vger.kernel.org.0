Return-Path: <linux-rdma+bounces-15554-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C429ED1F622
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 158AC302FA26
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76D22C21C9;
	Wed, 14 Jan 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="EJyw1mND"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E301B425C
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400398; cv=none; b=hO7TiruAqJkO8feSnbhmTu4YgVERoBOu1eDBtEJQLRPVM8AFj0ZWpRJsn0EaM5nzK5OjQMb0ztYGzr6FH4Oguo6/9y0zDegRb+Y8bqtoUBgbpRI67H3KQMdzhAxEaHuXg8UvTEWbMoS0hHysmXpI7SpulQwID8JwayFZFVtdyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400398; c=relaxed/simple;
	bh=PDSrK/mxLtRSnFpoDTsP3PI+UA8Mbeg+kUyEKTbEDrc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=LEivRZ12KEbFKOwgLlSTNFa8eN7aJAk2h8VhWW8aOQ63FhaGYFXtiJUCABLDYIKaeKl+auV6P3m8ptnIsEtIauq6PKZlzb/hojwenUSOrto/UXavRVyLgII3SLaVDazObqen8akX+9gGTsXNiPZQAjo6zN6rJxBCUVDLaS2wU6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=EJyw1mND; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id E16B53F13B
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1768400388;
	bh=PDSrK/mxLtRSnFpoDTsP3PI+UA8Mbeg+kUyEKTbEDrc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=EJyw1mNDxtiWnA2nTitql2SwY3md06I+EkHNF360EVaZS1GR5byKAQSFWLDYUS2aB
	 i39p0zNoB9hi+oe0t1Vp6FdgkpFefVse3nhkdbJm4ExxA5cQKSzSQ5lbzeM8dgyzH+
	 irpPNghKmxdfTG+X57gMamH4KJGsi6b1Ic23YoXEZE1p/ugLpYflPFtuQ94vRonufC
	 XijGdpiAYeHrcGnbY20OJvwiCAtp7EeFjx9pPaUeplDEPevx0QVR4Upcjkhq0z8JBU
	 Ig3mPjH7ejPGQNX7MXVtAoUg9B04xMmYGxSl326Z2yjVGshV/eUn5Acmm1P+oWuKVZ
	 V+F3FgSlA5b/g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id D5F817E851
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 14:19:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: FAILEDTOBUILD
X-Launchpad-Build-Component: main
X-Launchpad-Build-Arch: armhf
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #32143571] armhf build of rdma-core 62.0~202601141146+git56921971~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176840038887.3160048.9774276063372867244.launchpad@buildd-manager.lp.internal>
Date: Wed, 14 Jan 2026 14:19:48 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="9fcfff1971229ac997140f06b41a902ac8ec69f4"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: b958bb90bc88cdf65fe76426a8597d0a45283438


 * Source Package: rdma-core
 * Version: 62.0~202601141146+git56921971~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 8 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32143571/+files/buildlog_ubuntu-bionic-armhf.rdma-core_62.0~202=
601141146+git56921971~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-113
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 62.0~202601141146+git56921971~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
143571

You are receiving this email because you created this version of this
package.


