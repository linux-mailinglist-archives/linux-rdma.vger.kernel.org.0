Return-Path: <linux-rdma+bounces-12709-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAB1B249B4
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CCC3A7070
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF242E093E;
	Wed, 13 Aug 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="l81Nc8mz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7532DD5E2
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088939; cv=none; b=rECsYF27PlIZzprjXgdmGrUCwqJ21aL9Xw+7EPG06Du61S1FrX3rS9uSoScX85huTe+xVrVUTUl8cozlj0MbPZi+Z3BvkLg2cZwDnS68w2T9Ef6Puw+0SUxUDqJ5BbeHSH3f6v5BjAmbYfwqEr4Bn2+5gz2n1Uhv4oLnVnAwLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088939; c=relaxed/simple;
	bh=qTdz51eo20/MZlbMIiOQxbWGgMzw4/XJ2s3DlZRstIE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=CQF+2vGE/rDm5fCPzboriUGgbLH2XujrMRRo7MlDfQnLPks5onRtuQ1IDhVTWCfbrFfVh31Kn07GLugdhrHCkOsE9Qm+l6j5AVc5vCwZUEx96tj/xafP1ANo3t1nvmSG/L2sOt/LKpdi7EkSoOPE811CVBM0Cn0FRyHe1DhfGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=l81Nc8mz; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 152D44BCBD
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1755088370;
	bh=qTdz51eo20/MZlbMIiOQxbWGgMzw4/XJ2s3DlZRstIE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=l81Nc8mzUGd0uarRJLcUWSm43Vem2cBDn3Iq1/d/f6CaPRcvDJhXV9H83GadNhukR
	 YvNELLz4IuzOuzFXJNNy2dQwA3OBpV2g9wgKgu2SEdvIhzbpJdg+7XHBL/y0+cB8vi
	 +AjwuVvGWwmf3CaPXUoTo3f+bVZpqDn6QgaM4G6/Zk54+UPXllGacVDO2FuNt9iR77
	 xsc/JTSThHZ0osmGegT7bhNM4K17A25ZjbvpVNRM59IYYDDHwRCRz8U1J3C8W4r6+y
	 XiuWV/spKOfQSQuAIkvRLcauLBNAdf1244rXt5VD5UbLFSeI/PPdR5M9mUdEen/GKa
	 PoOBHmILCtL3A==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 00F7E7E6FA
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 12:32:50 +0000 (UTC)
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
Subject: [recipe build #3933958] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175508837000.1267249.17107923122638194743.launchpad@buildd-manager.lp.internal>
Date: Wed, 13 Aug 2025 12:32:50 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2e2dbb502f0ece7c824fee89b47752027cef4ee9"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 071a7ccffaedc99e0840aa12fa45ccf16a3697df

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3933958/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-034

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3933958
Your team Linux RDMA is the requester of the build.


