Return-Path: <linux-rdma+bounces-13462-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC5B81652
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 20:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64D71C261F4
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDF83002B8;
	Wed, 17 Sep 2025 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="e4zAFDZg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7681E1C22
	for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135284; cv=none; b=To9dyFEwhF1fOjrFqVhlmnOiwukUHgJCQBLzGrINFtSRwa1Le61NTS310+rAwMI3ylvDpve1QQ1jguo2aUGrB5EBu1g0wLNVH1vOTtWfCwdyIxoTCynZvM43z++rR10TxsFr5+PYb7bJkLN4pWjopncZ180ecqfv3mCWKXHbg5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135284; c=relaxed/simple;
	bh=OBVOFYDhjTj4JKqSXJTMKmCubUbFMloAr9fCTPFECDU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=GuAwGIWzHLRrEF3P9TwNih7Au3uyCEj3cKruLb66eOi6H1FYV27V+FaSZLtR6PWWy5vBqrSBk/BQqAfERYqZltGBm22J/d1y8NU0qrkH0huYojBO4KETePUoXG/Tlz0szOxt9vG60IJ4l4gm7H+xXqSLQEf0Nst7EWTOOnTqTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=e4zAFDZg; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id BD0A83F9F7
	for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1758134944;
	bh=OBVOFYDhjTj4JKqSXJTMKmCubUbFMloAr9fCTPFECDU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=e4zAFDZg3R8FRA5XUjPq5Cw/lRSQIji6TX/bzxkgdQJKCL6FhT+rd2lBLX9RlrDTU
	 7r8dNmJtLjpGSYBiPfGRLO4zlBhVumQK0crjCbzOkTPdzXMfei2R8AvID4ctHSzcl4
	 0a1Xty6Xt0Lf9c9qasWzi0/yDz2svCwW5QxGDnyhZXymrLoL5AeVOIMulPVWIEKkwF
	 xCqot7iFChg75Y4towXFmQ4wSIIRZwBCiXXgEqZdni8SBcM5Py0TFs9b2mBOPtfHEg
	 /0mvBIu7qzE87h1SF575D2DdG0fuVbFFjPLDQkpF/bKGFYT74RrqTd45GHsZzNOYrk
	 uiOKxv6wZVSCg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id A96DD7E79F
	for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 18:49:04 +0000 (UTC)
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
Subject: [recipe build #3946493] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175813494468.3480037.7830547153373416451.launchpad@buildd-manager.lp.internal>
Date: Wed, 17 Sep 2025 18:49:04 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="299e6cec2b88528c8351aab8852cf896cddc6846"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 99c4f51f60a359315ca3d735008c1f3a7463c9a3

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3946493/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-032

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3946493
Your team Linux RDMA is the requester of the build.


