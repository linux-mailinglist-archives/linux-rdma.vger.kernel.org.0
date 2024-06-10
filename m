Return-Path: <linux-rdma+bounces-3034-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A957D9024E4
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 17:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB2FB255CC
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F3132138;
	Mon, 10 Jun 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="BclxrbkR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CB13213A
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031401; cv=none; b=RVt8MTALRxlSYBi+CHm4i6UfOHNuXlve5i/aZxEBBDMs5Fawj5EiwDwAtEsGndyVVQ/osmSZa+bOa8TJpZenb1ceuAVY/X3dsquziL1VnKG78B51uWsWEGqsntugI5SOXK4ATk9v/JZUdKMYx8D+cgVkYLdtRfxWVk/pH0VX0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031401; c=relaxed/simple;
	bh=xgWoYFrpX2U5ZbVHtdIOuwXdtAwkykSfvHLrbbiP9dw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=mTN8jvVJNBiN/i2LXckDO0JoX6d5Ul+PMJdwxwp6ZkzVVOOR0ROXiTRKT6pLkPtDK+3a68wSEoqmkweGyfVbzUuguOu9OEb/hk0L4/RI9mTNFjqiC1Ivwek4HVz5RPzKWdDK6kgn4HRmayL3dpA/SaNpf1gC0dflnbfb+1+V7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=BclxrbkR; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 1FC783F6C6
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1718031398;
	bh=xgWoYFrpX2U5ZbVHtdIOuwXdtAwkykSfvHLrbbiP9dw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=BclxrbkRxZ7TUYBeSwyh8uxWHIeCXU01F7VN6AtuvIf8AYzB0UmuT5R2uYkUs2aAN
	 lkuuScHW3vI1rCffLDjtbsmZpCseEYSpuLvhYdE2L7FTk87Yo52SXn91GucIkIdXMh
	 tfwWU5UZqbHP2WTI2opx4On4ltNUwKpUfJ6nyvhOIrM/k2NIUdBT3aMXX2Ptfc1qJg
	 Fk9/Lvq5ODTPANPIBXvGGF0QxZ58bZGgGZX7VXCLXDyWla6qlwFyt2fvUvrA8H17WM
	 WUyK2BIsNEWLsOj4IjqiJFLJubSLMuWL0fL1LsDTFc4QDrY5FB6b10hcjiF8O2NLdu
	 wa5gpkNCPBkJA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 161757E248
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 14:56:38 +0000 (UTC)
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
Subject: [Build #28567142] armhf build of rdma-core 53.0~202406101038+git4b429243~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171803139808.322650.3841736996242975446.launchpad@buildd-manager.lp.internal>
Date: Mon, 10 Jun 2024 14:56:38 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="7020100bd22578495a0a6fd39859337d4641b57b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 3c7da664f31e5d093dfec043cb5261a77a8818f8


 * Source Package: rdma-core
 * Version: 53.0~202406101038+git4b429243~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28567142/+files/buildlog_ubuntu-bionic-armhf.rdma-core_53.0~202=
406101038+git4b429243~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos01-arm64-005
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406101038+git4b429243~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
567142

You are receiving this email because you created this version of this
package.


