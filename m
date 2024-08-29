Return-Path: <linux-rdma+bounces-4634-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F99646CE
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 15:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F3F1C2185E
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6674516D33C;
	Thu, 29 Aug 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="qAKw4xEr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F751A76B7
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938426; cv=none; b=Nv3o4vKrSXij1qMqvMQNX5/4iV2MqOvsjplAYMhWiM3daiRFK1wET7FU6YRgX3PFbozc/cqRJGVSMFA7ebqhrfD5gfXKX+Qy4KGKiMc0VQym60fIUucPOSAVb69p6Xnak2crjnYVVX2ioYI2vtYlVGa1tUtMfcSiU27U+zsocZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938426; c=relaxed/simple;
	bh=hDfRK+slGkOfai8AZ5Psove1Tc5lY+6jUxVj2aOQcj8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=omZltezJXGTihQPOs92N2UEjZ49PVCw8o4vcUlR0XkUzeltEfYuGezSe1E5p2Jvk2Z7vvPgr2AE/9wznPFADGRWBQgdevF+b1yeJMxBEguPhrHNSNla2GZ/uiAyWQzoJR5nqXNw67wQtJjJceC/+JqLpSapiYUSsm+kvC+uFE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=qAKw4xEr; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id C607740F04
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1724938422;
	bh=hDfRK+slGkOfai8AZ5Psove1Tc5lY+6jUxVj2aOQcj8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=qAKw4xErc8aulbUzgiyyrSbHVVEgkomNES3L+SxEKguKNkZ/klWQ34Sc7aYx1HkSS
	 AUzTTDKPikcbAEsWbLOhtB2BaSxKvXwVpQIZ1e3cp/Qg6XQ71tY5FqucK8NuEH6E2K
	 XThpfQabib6W43hqB05RN5emfYLVCc9V6p7Sg9JAX82hTweDTGbZESdBgYhK4U72Gl
	 H8wZTi643QfQp19M/4rtRTwsdOH7ryB0EtIUy8PY/SphE7en9lgDLt8MVp1nF0hLyX
	 YSeWnkY0aXtRhe5EZEVRIFpAKr+wAbLtciyeB80/1qaO8tfs8UfHvZHyB/tysGV7gr
	 cDOmjs4VQYzwQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id B80747E24B
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 13:33:42 +0000 (UTC)
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
X-Launchpad-Build-State: FAILEDTOBUILD
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: noreply@launchpad.net
Subject: [recipe build #3778658] of ~linux-rdma rdma-core-daily in bionic: Failed to build
Message-Id: <172493842274.1779024.18286710503514828061.launchpad@buildd-manager.lp.internal>
Date: Thu, 29 Aug 2024 13:33:42 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5c5756e056a781b0a75c518ac7b9c0710addc59d

 * State: Failed to build
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: bionic
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3778658/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-033

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3778658
Your team Linux RDMA is the requester of the build.


