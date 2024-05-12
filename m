Return-Path: <linux-rdma+bounces-2431-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5758C3635
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 13:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4331C208FC
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246791E894;
	Sun, 12 May 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="JIm7YmtF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA191CA9C
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715513373; cv=none; b=jndAdsaNgD8OOJJtsnSCgHi1fesICe/s2cZvdPSQuacgOZmi0ixqJoDQ1KrYE4QTEIkvPOej0my/VJTuAkxFswnxJvNh1MKXxK+fBMeTLebvUPRAZfbJxll9pTRVztaNv4A//yuWJ74UoWN887fi+2z6byesCSCGq9DlsJECRY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715513373; c=relaxed/simple;
	bh=ZowpcVfHzm/zav++aRrhMIVMUgAKq0P/SxggyqI1YVs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=FEgj7ZrZfR3ATC6uIE/CrXnA0w6os3NtBZFczK6fx3eBl7uToYL37xAXkIFEXcrK/P6O0aWpUkKuScGOanK8hSIsv+Fq1/xf6GYAqkWZOmeitBFAGbctqF0OLRRJHoOX9t2eAVxG2N9kYxTBJrUEB1H1ifhidAoGnvfFg8pkwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=JIm7YmtF; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id A84BC3FF1C
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 11:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1715513369;
	bh=ZowpcVfHzm/zav++aRrhMIVMUgAKq0P/SxggyqI1YVs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=JIm7YmtFCm7Gsrs7bB6+45PQl0NGbrQv5EDTAq4nKT905tUOmRSZ3ELWIi2WbZ4rA
	 0gyy0Vo4+y9oY9DRhmtyp94UfM9l2OEKKprFeNX6BZFHutWwGJqFApB8ztMCkElB1H
	 x2RCxA+MUKuomMqyN3nfkKD/LeKlRKB9LWOo5IcvC9NKnTiHuNWgVr7Ur5yPJHgJWz
	 PwbVJjS6pN4zbS4cVRENQ/5S0VuzLnGGwP/Un5m9/g/m0b+MU2S2wLyAg3E/12VVI0
	 MRAI4zzCweYgN6B4WBl5eUHnmFBY9HLNH+alDDpCedfs0n8SoyW96FRgWXeNoHjJH+
	 /zBT0k2e/pHzg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 520DF7E259
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 11:29:29 +0000 (UTC)
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
Subject: [Build #28440498] armhf build of rdma-core 52.0~202405120732+gite533dec0~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171551336933.2844614.12446550286434052335.launchpad@buildd-manager.lp.internal>
Date: Sun, 12 May 2024 11:29:29 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="0e1f616671af724398db43b36ddfb3ed1f2682ec"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5e6ee82700fc1e4cfdbf08bfd8160e2291ab9e36


 * Source Package: rdma-core
 * Version: 52.0~202405120732+gite533dec0~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 9 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28440498/+files/buildlog_ubuntu-bionic-armhf.rdma-core_52.0~202=
405120732+gite533dec0~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-073
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 52.0~202405120732+gite533dec0~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
440498

You are receiving this email because you created this version of this
package.


