Return-Path: <linux-rdma+bounces-14349-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0EC43FA4
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 15:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408CA188C098
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82202F6592;
	Sun,  9 Nov 2025 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="tVvxZqxy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8110D883F
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697330; cv=none; b=AC3WcWS5g+sQe7fviYxEZg6Ov5RAKxHaD/pN9/SeBRgBDz9brnda9dDnWsgMX367fzXztp48nwwXtrnFDJqxYpK8mALOcdhH6lpF2nMTwQ0zjzRuKsVdBqgv//+twbx1CbctV+c4PsVJFITPVDRAT76R6oCCeryLMsaG8498XZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697330; c=relaxed/simple;
	bh=6YyRIrtTnrNhr0r4rBb99juioQNFxm5LLVVV3JX1Uq0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=dywICqGzjlRT+4/h6dsH1PlC1b77eVKYU97DIHDtK8FsTHJslv5rIR+Q4JwRrA1sBEfr9xaD4p6lP8q8DBjlZ6osJzecQzShGTCThKhR4Mux2RFrOw6wls2nUe4IZkkxDvZ5X1h9aqzAqNkHzEOV6uOD5QSShvcBqRyu7g0p/Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=tVvxZqxy; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id BE4C83F273
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762697320;
	bh=6YyRIrtTnrNhr0r4rBb99juioQNFxm5LLVVV3JX1Uq0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=tVvxZqxy23G1zfLlEffHynPYcQY4UPUYPPktWBSb0HbodHdK/KlLXu9TV630+BCAq
	 tX/ViOsRNx26C5WliptU9zzq5iLC/JlCloHGCAdSvGLf0rDLJHKgtdTgZE5QCfmiEO
	 ebRHHtrho8y7tcLgzxTJCRlNoC/tbazwkM6d1HcuHK99ZptNPFOh21KMRZ2gy1ZZvV
	 x7LNMTNxMQLXWqA47NnS+aA8RAD5UT9Gt/1kwYzoRcs/dLUu5rPQnxOjWeDKAhvO/N
	 CgDH68g/qB6a0gA9uTcCR5acEjzUAKAilaKk54TP+t44rosHhtFZPNOK+C9Fcrpp+R
	 OsP8w/RIr6o1g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 9ED8E7E84D
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 14:08:40 +0000 (UTC)
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
Subject: [Build #31475478] armhf build of rdma-core 61.0~202511091239+git681467ec~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176269732062.1218157.2526117394498826247.launchpad@buildd-manager.lp.internal>
Date: Sun, 09 Nov 2025 14:08:40 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 7b80c9cb9eb2a13de82a3cb6e6fa6250d3132a23


 * Source Package: rdma-core
 * Version: 61.0~202511091239+git681467ec~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31475478/+files/buildlog_ubuntu-bionic-armhf.rdma-core_61.0~202=
511091239+git681467ec~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-082
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511091239+git681467ec~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
475478

You are receiving this email because you created this version of this
package.


