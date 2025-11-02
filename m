Return-Path: <linux-rdma+bounces-14183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C3C295E9
	for <lists+linux-rdma@lfdr.de>; Sun, 02 Nov 2025 20:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F62188A2DB
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Nov 2025 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8C2459DC;
	Sun,  2 Nov 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="tuWOAoNu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D1245006
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762111366; cv=none; b=gN45mrpZR2+zcxdmGXzp4NMCNhVUliYRZiD4EzPoKr2dF3EDVaVSGWw2iegCpX1bbla7UC08PRaqy5qdEeMb6jLWblZitHFHIfcJJ4zmZ4t9e4mrMSJUtiv0qQPSSAcSp3Z8CtQRDpirvaoSWNSx9UnqPXm2brniwdG00icQ+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762111366; c=relaxed/simple;
	bh=0GaMgtSxl8Z/CNqtuKlMMSrLKU+MXp3CTmv9NWdg0iw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Ha9st4GWdiMwzcJBCFw9fqinfFNX6SJa84cT6u4Hs2hhww4C9xa1rTMjKDFqz+mKrS9ask9AciPH9K7o/3RvQKrVp04p0Phh4S55zpkVO2PE0vpiepiZLSW3SyXy9m3zINXoRxzf27XCizbFEfgx+Kavqn3YuZFtd+5Rrii22ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=tuWOAoNu; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 8072D40ADC
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 19:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762111357;
	bh=0GaMgtSxl8Z/CNqtuKlMMSrLKU+MXp3CTmv9NWdg0iw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=tuWOAoNuhspZ7U1L97G74wsdrbbx1QiyF1wcmMPMvCwavO6Himmz/S1DYhv7yh8oy
	 Ik00ljrYNkC+56KtljTSMd/hdlAlJwy0aPpRw5awaUf5IxfrMppBmXRB19yDLPjMFv
	 UUALhWxn2jAM4rgguVE0wLPlD5Z1Xm3NuO3ZLBzRs6XuhY4+Z3fAXRfuv50b1lFlyk
	 5Gww0a+wKs1vzR4eaT5XqcymR9hfP8ni6hLGDA8Nc3TVfQFL0LqI3oNRDzzIlB+Qzo
	 qcu87Fl/u500VRjjRnJijnqdpnDYq8h6e39oDHrdqaFwHWDRNmttYDOBtSR72esSZ9
	 uFoBKbPfsDj4g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 762D77EA5D
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 19:22:37 +0000 (UTC)
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
Subject: [Build #31456859] armhf build of rdma-core 61.0~202511021427+git0d977c57~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176211135748.1218157.6448924454246397324.launchpad@buildd-manager.lp.internal>
Date: Sun, 02 Nov 2025 19:22:37 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 4afd162539be7ec7ec55c5580b509bd6d8f905a8


 * Source Package: rdma-core
 * Version: 61.0~202511021427+git0d977c57~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31456859/+files/buildlog_ubuntu-focal-armhf.rdma-core_61.0~2025=
11021427+git0d977c57~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-018
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511021427+git0d977c57~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
456859

You are receiving this email because you created this version of this
package.


