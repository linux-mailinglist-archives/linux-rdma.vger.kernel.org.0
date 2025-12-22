Return-Path: <linux-rdma+bounces-15163-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD1CD6504
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 15:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20CA530B6D3F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB3B2798F3;
	Mon, 22 Dec 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="g10TL+67"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966827381E
	for <linux-rdma@vger.kernel.org>; Mon, 22 Dec 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766412055; cv=none; b=S8sjjFvnYgMw+8DmGk1G/F32u4fuxk2lva2EIMRSxSafqgRgFRwc3zufQaCbawdG+UbQtaNr+8ENLcijLgWxlNd3B5wg5KAQxs7pg+cKn1KuR3GhW6pbuUVGiGV+NmmB0u5D91asRjYR8STf+vw1GEJVPa/rfivxZFl3rvk2+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766412055; c=relaxed/simple;
	bh=+G+/V4pTd5B9w47N5KtsbfqA1r0Jr5NmxGZVvVv72M4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=QBE2gVESgdesG62JHlR04+ea5M7kLeL0R9UlAE+5aQnHt4VxwJY2KzSmQqPQmyJbJW5UApOv7qN5jolMuLO4J5rRQu65bfuoaThIbK1Ur5IOWPTmBHxBy/HaTm1cR7/WPVhQCwS9e/VovARAJ9MD8OjP88N81/KbiAamscpKpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=g10TL+67; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 990363F292
	for <linux-rdma@vger.kernel.org>; Mon, 22 Dec 2025 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1766412044;
	bh=+G+/V4pTd5B9w47N5KtsbfqA1r0Jr5NmxGZVvVv72M4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=g10TL+67mg70pitqnep+rtU1+GLiLXemxzaKg4RXxbnevwWOwwKeIkb/xeKdpf21M
	 vzRD3Nh2ZXbBexTPAB7ifgF59sbex4nr7w5kAkuoX45PK9PMqjH7g6cfzOIaD9/Js/
	 4Me530+PwSKf9YBlLPLlooD0QfABVVk7cISFLcD/1MrKEEqucr56j+5CKCRxI3ii1/
	 zE9qPGeoEl9uGEWrRNINncBI+lArF6pngTtdPY9O76T4g7ZiFPLIPhGhvmxzXhTX1d
	 /ACf9PScH60STPqYcpIrZ9pCunfSD8xvbcyzXXZNg5hMs/qJXNa2H6h4XYkR2lRN8B
	 p7TXPSxQKxR9g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 8F4EA7E750
	for <linux-rdma@vger.kernel.org>; Mon, 22 Dec 2025 14:00:44 +0000 (UTC)
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
Subject: [Build #32080492] armhf build of rdma-core 62.0~202512210746+gited047648~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176641204458.3431851.10748175294593774042.launchpad@buildd-manager.lp.internal>
Date: Mon, 22 Dec 2025 14:00:44 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5fe1eb333eb5221bee94ee0684b5772727cd6c23


 * Source Package: rdma-core
 * Version: 62.0~202512210746+gited047648~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 12 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32080492/+files/buildlog_ubuntu-focal-armhf.rdma-core_62.0~2025=
12210746+gited047648~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-073
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 62.0~202512210746+gited047648~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
080492

You are receiving this email because you created this version of this
package.


