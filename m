Return-Path: <linux-rdma+bounces-7350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E39A24D9D
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Feb 2025 11:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807551640BC
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Feb 2025 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833B24204E;
	Sun,  2 Feb 2025 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="mmcKwRaz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E561CBEB9
	for <linux-rdma@vger.kernel.org>; Sun,  2 Feb 2025 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738493241; cv=none; b=ARz3yTgWt/spY4KCQbzAXujrjZP1qsshcRxbYpNUqKH0ts2/kHJpJSYT6SoDi889yyR6ns23i0WCsDfOxh8M7Q8uuvvOPxKTkk0qKhiw/nlhkEPxBH0svAeO+6xsiNyKg5pQiqSOnKPNeim4C0GOtrYZKZAWtfAdk7rXblSSExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738493241; c=relaxed/simple;
	bh=XHL5jZJMtZJAq9MGEV7MoQcp4VMhsNM8/yp9age4wJQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ZBvQgFXoHzS0dxvJJ6IRdn2dLOgJUd4CC0Fiwi7ohjB3SPya6ToBLrxCJByfPGvY2677KFc3FVsc1+zYgrxKNnCluoQNxqwERPbURXsqnYfNnHXZIG+0O7iZ5M5cSyClQmCZ8G8wQl78NVQDFqpLYnztNuU2or5M3sDMXS0SmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=mmcKwRaz; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 4ABDA3F20A
	for <linux-rdma@vger.kernel.org>; Sun,  2 Feb 2025 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1738493230;
	bh=XHL5jZJMtZJAq9MGEV7MoQcp4VMhsNM8/yp9age4wJQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=mmcKwRazB9uXiONh0c3xu7ELr/kk0MVh/HjK1SmqNBElXikfujT8XS6Dzp2/ir1n9
	 HtqPyy/NnH3RdJnoB+nMswpQv+d1YB1qR/VIFyqBRQUNs6Z04w81ZeevmfHWEt9ATT
	 FElXOJTjMzDyZlk3hxFh4fm/nwjBfIiv1p9hLIQWkfjFRXiZlil8Vk0lU83DMKgVvY
	 7N9u3KJzWF9V4w9iCssV5fwvQZAQjDyRNoP0xeK5AcjFyAq+OgMluj+ZdWTEZOcBFk
	 lAmfJRlJk9DMFJET6GkKNphLd01XcArkTIJr3I1s/CmiZcpX045EiPdyVDAub/vOUC
	 PNsGrlf7tCpeg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 3D8827E24A
	for <linux-rdma@vger.kernel.org>; Sun,  2 Feb 2025 10:47:10 +0000 (UTC)
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
Subject: [recipe build #3847505] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173849323024.1817859.5530216733221611530.launchpad@buildd-manager.lp.internal>
Date: Sun, 02 Feb 2025 10:47:10 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="b13dacce4a364151a813e3cdd6940bbff676214a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: e33fe0c147ce395fcd224926ad4e214acf5e0f46

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3847505/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-038

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3847505
Your team Linux RDMA is the requester of the build.


