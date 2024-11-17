Return-Path: <linux-rdma+bounces-6020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB129D04A1
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2024 17:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79721F21B00
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2024 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAD91D8A0D;
	Sun, 17 Nov 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="bzs0knFq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768D26ACB
	for <linux-rdma@vger.kernel.org>; Sun, 17 Nov 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731859349; cv=none; b=JzQU6noB28QpyE+MMNu5j9zA4E0yIiVNdPsFQXROD60bi6ZoVBTe0GT7kk8zH+gkIUZc1n9watKrTx9v1xVfNqDJRPwYAqnr8nKVwE8StcNcMHsxSSlR1aUS7CMFmOhTnANM98EKl1iDoilm2Y98kmtk+s6/AYz1Ln8bbRN4hW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731859349; c=relaxed/simple;
	bh=RMVpJJLXXeBtOBBEz57mC1ndfCo6Fo/kV7mMuKWFPHw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=mCXpk+t5Vxskf/4CjPjxT1tEFwbob4pXERiW7w1fkOYvXU9LyPcHbbHrhZf2Ny9nkw3202qsov97uZ/ydYapu80NCESAl7IuZAUQWUrUP198BelFoV5rOi4ERijUZNkMB1tzwTcwUYMQdhwkR6UejFYOi0U8UR/B2y2iFfHb4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=bzs0knFq; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D99E6404FC
	for <linux-rdma@vger.kernel.org>; Sun, 17 Nov 2024 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1731859339;
	bh=RMVpJJLXXeBtOBBEz57mC1ndfCo6Fo/kV7mMuKWFPHw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=bzs0knFqZLi4Fpn9CQH1gUrFE+2eJuxEvVrYC4B44n/x8g6OuJX/cJ+1SYcg5J9uZ
	 Nh+jrlLxpZU6d1HiUWR7414+KYZ+05adEXEciRvb24o9HcwhkvWEXGVsUvev5qtY9K
	 ItCF0zM/HrWRGdsX1/eSULGb7DAmmGyAhz4dHDspkRhm00NJhPvMJrnHDtn2fNxlhM
	 u3LFJQBxbpyRjnpPrU1AybjM/D4vBL66zlRcmAkh7BujC3xkk1Q33eLdQCUhUsv18X
	 Y3K4FX0LzxiKPvDL5VzGAiBPYIbstZ0ozqTm2CiF5Ix7S8AbAhfn8Lm8nSZ5cdqoxb
	 k42hkUXHSSYOw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id CBCFA7E236
	for <linux-rdma@vger.kernel.org>; Sun, 17 Nov 2024 16:02:19 +0000 (UTC)
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
Subject: [recipe build #3814044] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173185933982.2106356.10713067843193632266.launchpad@buildd-manager.lp.internal>
Date: Sun, 17 Nov 2024 16:02:19 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="22ade00ab50b929fac63b8ee7252243aceda294a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 7dcbd0b568c0de2ea85dcb1606efd24b7f8d97ab

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3814044/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-116

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3814044
Your team Linux RDMA is the requester of the build.


