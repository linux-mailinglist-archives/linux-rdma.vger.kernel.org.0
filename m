Return-Path: <linux-rdma+bounces-14711-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C95FC7E69B
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 20:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE933A60D8
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AD32472A2;
	Sun, 23 Nov 2025 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="RASEfTv/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAD35962
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763926907; cv=none; b=OMYwwP9OzgVwtHBif3tM71vs1E0qUgGS2WvgKAPxw00eAKOJX07puMaju2gO9ySxoJ44jXTU6UQ1bL7Pi6m5OcbhfO/0+cIqDA+FApYbFReVtj7ZrRQbwBXhPiJ3kLdH9acyxLtOvT7bzAdacaYBdBcJiGKKeVbtZTxCLsf3Dhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763926907; c=relaxed/simple;
	bh=dSWZbJ7fQMm1jvhdhgIcYWv+0dgCb3PhSQRqlmGX/Rg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=FHgjkyZAEYiipqC8HgfnecGmbdnmP19OWxRQ4Q6pomNA54FdKutuCxVD8oQVqlll+Afq9hzkHp3kP4+OGpAzhznwwwKWit/N6gFL0JdzHIYW/dGrc4v2sVfW0PbtfWlGMlCmp760DmrRCs0NxcXan38dPEPmI+OgJnnNt9crJxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=RASEfTv/; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 3F6384002A
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1763926301;
	bh=dSWZbJ7fQMm1jvhdhgIcYWv+0dgCb3PhSQRqlmGX/Rg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=RASEfTv/SkGn7gLKr6ZZmridhTBLAau6maRPUmhXYMTwHaS4FsUPJZshcRhWMPVG0
	 T4vDlq7tnBSosXtbQWEn6pzBRW9dilVhNi00mQGDFq7Huf5PmLtdOiOCH2floUIjgT
	 odyGAh4COBaY2QVjjoPOPOHfswjOBSjzf0A35oqzR/cyqkpagZfApkhNc0Vrtdy2zP
	 FwsX2b5XZd8CINhXZMQI3cSIuJq3x76eRbVUeZA9zFjo8MGLXxw35kgtOc4b+OHTO+
	 V/Lyp7J7aoS8lKvXWVVEY16KNftqN6Pp2mivlKYmtgGeDrWpAGsjkunsf7jz51jqgN
	 KrVgwFOCKIO3Q==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 1C9A87E7DC
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 19:31:41 +0000 (UTC)
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
Subject: [recipe build #3975739] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176392630109.791410.7337468465956563542.launchpad@buildd-manager.lp.internal>
Date: Sun, 23 Nov 2025 19:31:41 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: af61cac6fdd4f35b8efb3d695171ae300a62a034

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3975739/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-095

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3975739
Your team Linux RDMA is the requester of the build.


