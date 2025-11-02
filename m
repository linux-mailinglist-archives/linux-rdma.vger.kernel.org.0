Return-Path: <linux-rdma+bounces-14182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19135C295E6
	for <lists+linux-rdma@lfdr.de>; Sun, 02 Nov 2025 20:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24F654E965A
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Nov 2025 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA98D244668;
	Sun,  2 Nov 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="r3a0rgmr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB00241139
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762111340; cv=none; b=jovz+HOoyJSnl+fn9Kg0lKw3Kun1FuGbPIv79c+gzVOlqlTlk5bZyAntCPUbCsovdk3Qex4l2VokZI4X/3OtXP/0i4oaGLRQWWRxgYKGArhjFOybMVMg9ONd6PehDoHFq0AP4rL8clBAkKxR2onlkzvZan7iVPfOIKkEkBprWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762111340; c=relaxed/simple;
	bh=ZxAc08/YmPhn0QP6lZCC0MC9k4BUi1sDazkHJdwW3OU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=lcACl5JyxmPT8/O6PD72dVqaMlQQdldbJecVynvHiDf8wgkSuL25y/14L3HpskeKJwG4ejyjkb8tVdT2cgsAt8PfNvxv8TPcTHuTTUboWXSyPExid/lHAyq6BGYcWDf5i8i6JVULlsjhFEPTRPm3gbT1nvQFXKQ22wScgQvkJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=r3a0rgmr; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6418940D3B
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762111016;
	bh=ZxAc08/YmPhn0QP6lZCC0MC9k4BUi1sDazkHJdwW3OU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=r3a0rgmrHJjSpMQTG8CNWFlGXjH6O7u24uGVanccH3HW6Wg9yGophbhWhcc6TFuLZ
	 ZOaiYfAmMUQ0zIe4UlN6aVGXFvLwtfkP2Ok/B1c+1M5wTdR1PXrkRg4JYbEUZwgV9B
	 9RglFbtbbRT59uU6GGvwWNLzKWigKEJZ6e9g6LluTclNCZ6QE48wp272UzD8Os0+3W
	 qoviVISJnVE0zIA2mIhypIjRtcXpeMr5w1b/AAlPIRyg9UzFM9WGPwNy8HNggsWM+P
	 AZ6NEkBLzBsw1P+MSmMnV+bRlvT+La+pKafMPOfOo0xqzEMdWtsYxojGrIyqvMTICH
	 2vowrgR9EeVNQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 5472E7EA5D
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 19:16:56 +0000 (UTC)
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
Subject: [recipe build #3966815] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176211101632.1218157.809417447121766407.launchpad@buildd-manager.lp.internal>
Date: Sun, 02 Nov 2025 19:16:56 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 390f206bf28ae537c744c75c982884dccaf85b5a

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3966815/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-075

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3966815
Your team Linux RDMA is the requester of the build.


