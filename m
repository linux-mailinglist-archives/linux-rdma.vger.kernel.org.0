Return-Path: <linux-rdma+bounces-14449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA09C5286C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 14:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C40BD4E86E6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E2337B9D;
	Wed, 12 Nov 2025 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="JKbH1zqG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8E2F1FC7
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954516; cv=none; b=pEFiY38B/Gj7mrB2pgvoftt95HXGYpZM5jVB79Xd+Ku7djBaDH6M2wLpA/CLh0xGEgj/Gmd9S8hQCJkRIs7HMcVZmnGiNrcGNGzaPfn7S+y8tOePr3y57mjtVUxPoXSje5GS+ehCws2z+cpszWRVX825x+jK2MzCPx4fov62AIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954516; c=relaxed/simple;
	bh=oAqcEqeMfHudm8tz9pkh0GipktsDWrE307qyKM5DSvc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=KAo/IJbfLdCtM3b7EWc7tGsqyyfUF8TnK2/DMzGxJIscZH9ucMk0EqIi6Og9FmpWApA5g+sc78TasRxJpOOn7p+RpfG1M6Nwl3aEUaU8DohWn3YVFiw0QZZlO1snthfXPY/zvdP9SHPyIINeIySGKQtoudUfjWvxNSjnK7T9aGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=JKbH1zqG; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id C345640094
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 13:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762954505;
	bh=oAqcEqeMfHudm8tz9pkh0GipktsDWrE307qyKM5DSvc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=JKbH1zqGXYrlJ1JFMWrA6+2XrrXLEb2I43Kt+mQ9TyZzT1BQaG3sXU3OeLRt5PZX4
	 bja3SXpWFCvDwvpYYdiJHSLr6xlfcPf6F6N4dAkp8iq/rler4qP40KWjuGuUfibZ2T
	 DJ26xytbwzI6yixxmMpHbW/2s38xc/HHtTA0LnMUYFboP85UK+dxaW6PZMEJlfsV1F
	 /QkGHWrB0EuXNqV54K//hXDEEQw/OchUTnJs6cv/sPkxWkv9KEwkBVhSV/Zk+mF0BG
	 Lo08OrIt8ViirSPBoNwkPS8knosc1mHPAGnRh5fO0sciP6kc/2ywIToVk4XzcykV85
	 RPag7lqf3EivA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id AE30B7E982
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 13:35:05 +0000 (UTC)
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
Subject: [recipe build #3971060] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176295450571.1218157.4688963926693928956.launchpad@buildd-manager.lp.internal>
Date: Wed, 12 Nov 2025 13:35:05 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 4ff855a91cf5775e0b510a0a18a91a3d53ad76b7

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3971060/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-055

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3971060
Your team Linux RDMA is the requester of the build.


