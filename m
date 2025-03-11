Return-Path: <linux-rdma+bounces-8577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0FDA5BE6B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 12:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12F37A6523
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B9250BF8;
	Tue, 11 Mar 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="r3NBVxR9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97F253B75
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690977; cv=none; b=KeOYaQCwBpFo6BlXq7117H1JZ/vrmHEpJWpIFfWECmqI/72WfLcBbdq3vguJ52oiUCXmEVvQto0RfgXJA0W6TRoWeos72Kn3/u7f/ThCrTeXSQyPF26m6sfr1IVOeeZLNrd4Maw3/g5ipLzUUs2OeNnAj02wKXE22CdR2m1D/h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690977; c=relaxed/simple;
	bh=Ds25PcIOVIy+pl/jekSlChyRbXACnD1hyrDNfYEr4CE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=SeR+9IN6DwU0viO7qkxeYNM+y+ohOIuZzU9e5RfQo/vN60TZTgAtCfpRFc2a20ZjFsTKEDiydKgA6E4QdpEUkfMKMPC5aLW4M5jwFTBpUrzivKRvC1FSU3dexAbUPn4MwyrxESgZYWg4wbtkjyvxOO20JZ6yC+WUWA+PKVUS4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=r3NBVxR9; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id C106D40B0C
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1741690966;
	bh=Ds25PcIOVIy+pl/jekSlChyRbXACnD1hyrDNfYEr4CE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=r3NBVxR9aV8VzITp8jzz7lbxi23FpLjkFZ0Cfr0m2IHbvB04k9bD/d0Wqb7N/xsyw
	 Jety9lEKq+uUCv4r6R4kuXqYwXV0o2Wm6SDGaxnpitXS+V0ZY+4qI2ep765ZjYf6WQ
	 ry1HdjQSGKm3nPktCih97yH/aZ0saATHgeS1tAh5Vib8KQ3uMfqmeIML6iThsSqoHc
	 sSmk3l/x8tuTrkaO1vBrlIH0vzAAvzSbWAYPfmcfBNTCkC4lAhaTr93hw2x8P1d0Pa
	 o6RMnctwhwIxSW5q0ANmSJUebsKcPvpseO9MjU7mbH1jSlpuVpZyvSc0z0NtxiPTxR
	 /N0DC1VJO5rCw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id B59BA7E240
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 11:02:46 +0000 (UTC)
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
Subject: [recipe build #3866024] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174169096674.4188075.9986734669446182717.launchpad@buildd-manager.lp.internal>
Date: Tue, 11 Mar 2025 11:02:46 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aa29ae0fff49e4e804b39147c9f259d2fb023199"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 86a259bc33c0a01eddb0aeb2097e2f86dd3fddd3

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3866024/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-092

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3866024
Your team Linux RDMA is the requester of the build.


