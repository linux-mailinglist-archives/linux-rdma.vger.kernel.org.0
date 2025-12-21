Return-Path: <linux-rdma+bounces-15120-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2DACD3C85
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 08:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B53D3007699
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193D720458A;
	Sun, 21 Dec 2025 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="i4oUWa8G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B121262BD
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766303444; cv=none; b=AZOGQvsgnHfYQXD+G+QVWVDe7miUBAtA6lx10akSEKtWJZAkz2jhVYaZ5BzsOHU0bc4k100vDJYFCdcY/naB+yn93znT84+NarsnOssX5qgHJ1Vx0G5JsOfO1KRKisYhH/UstiNBLong1ptUOZbI6TcBetz1oDfLScylQO/q+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766303444; c=relaxed/simple;
	bh=1ncfEo3Bd/GS7mfjmBgGMctJK+DybybwfraWlyEHD3A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=O2Q+6I2SzB1qEWFgQ7BAhe7KR4O8GnwM7icosPQ9+AN9XwG9guMycFhzbg4BXNqRWWuqjSD++haft/Q3QfJ3up6yxV5JUPo4pDmPbGSLevn3DVcalVs/mkKq9kv4HRzYQ1ZBN1oLUc3EaFSReOuwnVo2pRqrCdCAxhT37ZHfVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=i4oUWa8G; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 8F8353F1F3
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1766303435;
	bh=1ncfEo3Bd/GS7mfjmBgGMctJK+DybybwfraWlyEHD3A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=i4oUWa8Gl5u4vPcIOZ6jZ5NT6WNdLNjjR20/DHaX3bEUS2JRLPuvIiVNuWaJjYHqM
	 eLh19pYMf7DZBTdb0cgB7FiKlM22bXKU+nxP3YbZzYkxF6HQtNqAo5UQ7K5jrTawze
	 BkgmbXzh+t7ua8imCl21QLB2sDxOxBLYrTKdjqjDy06TjongWnGd/cDh+7FUkMFMJc
	 yKk1Pd/R1eloEqYMyCKtRg104sycAyFRhePIUzJ4CKRzXHere4ULNcKS/gV0F6NRgG
	 Q2VLy7vp4WlVt+EbiOjv1mAElIbpnnRKyYKCSTLZXB8D74MeUNkPWZLLCW/WebZrM3
	 Ko9SqpFD5zsHg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 7BC217E75D
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 07:50:35 +0000 (UTC)
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
Subject: [recipe build #3988381] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176630343548.3431851.2073501188363478471.launchpad@buildd-manager.lp.internal>
Date: Sun, 21 Dec 2025 07:50:35 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 776d0d6cac6f73be65efa852be3a1e1923f91df4

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3988381/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-111

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3988381
Your team Linux RDMA is the requester of the build.


