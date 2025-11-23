Return-Path: <linux-rdma+bounces-14710-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F227C7E693
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 20:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037D43A5B76
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA9E255E53;
	Sun, 23 Nov 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="bV5jcMwR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D81F5437
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763926660; cv=none; b=BvlE4EXW0iVnrHhp5XpzNn+as4BrwpAoNIFUe2FQvgKVd2BHNbFpSZ+ga1pvHztylvk9kalmEbbAFC+RHa7oHx9s00W2aX6Pf6kQ7RRcAxnAFPeQrNt6PWK8SFc20wRxHopvJGYggpq1LqxN2V7s8Vxl0VSSVzYmJFqey0/aoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763926660; c=relaxed/simple;
	bh=VHds8w3i4y3Ekbu6y2qCVybqW8MfhFj1kbhowGDFzJI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=QhYc96V8BCwiNi5jn+TPqlGdGlKEyzbOuFQJalwyQBJ8eyoiFg7q+WZIiNJYTym4o2J2D3huNX+GCcEpd+E3UL11FGUjuza3eo7yAWf/4IhT1lF3Osg1bWXL1M9hJJv4/Wvt0LW8n8ydkQGobRFck73vvbP89Q6TVsuYW9KfK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=bV5jcMwR; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 0CE8343117
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1763926657;
	bh=VHds8w3i4y3Ekbu6y2qCVybqW8MfhFj1kbhowGDFzJI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=bV5jcMwRLaLFctQUUzhv8NMX56E+4WK3u4RIw9VqhW6OrmwyL7Aup23VQxhcr9Oii
	 /urrT1DgQHWs9+lepf6fv3DI25hT6L0GTrN36g1MA4xynS21pvJeIEWXEJI12xkhxA
	 lbAcqNsckqJzum3dOKAxbI40biiU9CABBMoOdGtyFLJU3Q5htd8YhgIcaQa5g3WA7e
	 ExKZW80apW13fwVy5DsYBM8xwKBr2YgzybsXE/gQyTFuEs5W+Raeveo0a87fQEZkwB
	 JCSaS7GRKQFBQRjOX3x8Ny13jdkTqpYzmfuc2DhPGJxCvcx/hTcEFwwrocA3ue6pM1
	 Se8DUz1qXZiMA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id F0B657E84E
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 19:37:36 +0000 (UTC)
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
Subject: [Build #31516386] armhf build of rdma-core 61.0~202511231620+git89fecd94~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176392665698.791410.16558423063029472760.launchpad@buildd-manager.lp.internal>
Date: Sun, 23 Nov 2025 19:37:36 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 8b67a784efb40d404c1078616067170149483f91


 * Source Package: rdma-core
 * Version: 61.0~202511231620+git89fecd94~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31516386/+files/buildlog_ubuntu-focal-armhf.rdma-core_61.0~2025=
11231620+git89fecd94~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-014
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511231620+git89fecd94~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
516386

You are receiving this email because you created this version of this
package.


