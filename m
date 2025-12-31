Return-Path: <linux-rdma+bounces-15253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2466BCEC112
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 15:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE5A2300E005
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054823A562;
	Wed, 31 Dec 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="NLtSopHe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E51CFBA
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767190455; cv=none; b=r2t4KBA4bWtNlrpyYkB0Q5stbcPyKBQ3g9B1pOD6nlRYJMT617tRhguKlyrxRRrrnzHnKNayUF3Me+PQjAOsViVRAXWiHjww/ZjMpY+j3RwCCTKGM6y2NPzcI3tQr2kfxO2wVNF/8dj2Xe31yvGfIhjqIivpkntX7vtc4RFOzLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767190455; c=relaxed/simple;
	bh=T7VNAHEoj9uaQzw2ygkxKwtNdzNkIbZ6isDVJi5Raio=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=W9y9lF5j3HPtJmmgijtpT4ttH2eDeN4BrfMGmGdXN77xabWap5ZoLNjOddJuVuFbTBzXqMihLXiM2UX8E0JGbwXM1r2dGYvUVH25aKiOB/1mvGDidM33ioS2j6KHZPdM6qp1pG/aJWel2xgP+5n9mydEUO3R0UtWhnQ8MQF6pOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=NLtSopHe; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 961863F02E
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 14:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1767189856;
	bh=T7VNAHEoj9uaQzw2ygkxKwtNdzNkIbZ6isDVJi5Raio=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=NLtSopHeyzvkuR5sy/+R2ltQIoYcy93ytedeZZFei8Lt+1B0Suq2GFb1OowYzUSDo
	 QvMACoxBBJSdD7m6YRZwAIoUoxvtTpMUSwWkxfMDVJgA/Nt3WiVOpvZSrmZ1Tf71X3
	 jHgi39RMRZQR5lwC89MPYZvh74//EkHnjke/zISI+8Jl1Hbom4lF6PwMf8dks9QbHb
	 qQ2pP03JS6stLoj4A8hhq3uYWaZOmgY59aPTaGv7gb4JQ+karsdzhLpeLKda6jI4E3
	 BraKT1mL01Lf4V/Ct5rb1u8hHMRWIdPvF04Szp+okwEJ1kGT8rZW20NSVeZku0hMet
	 50DvW4iZUzUfg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 7E1B77E747
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 14:04:16 +0000 (UTC)
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
Subject: [recipe build #3992269] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176718985651.3785417.3452909702807199920.launchpad@buildd-manager.lp.internal>
Date: Wed, 31 Dec 2025 14:04:16 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 3e7cf3e40c768d20f536e84e951beada4df9b8c8

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3992269/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-049

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3992269
Your team Linux RDMA is the requester of the build.


