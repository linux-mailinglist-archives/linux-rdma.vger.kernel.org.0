Return-Path: <linux-rdma+bounces-15345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45729CFE408
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 15:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14BFC3009546
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 14:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB0340DB1;
	Wed,  7 Jan 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="kpl1th/N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC733EAFE
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795441; cv=none; b=TyUT7vm90ZxpzujsSlGlva3dChUIKOriYIYEdBg+npYxvBvhuEtkUVIGC1K+St9yILU71dJ1tbMMYHPPPSBBshJH3NDDNrJU6CQIAsQ2LPdgrGzEX9AV4UEQz+S+PZmHX5PV12Z0uVKy/qxlt0s4TB+7cFTdes0OL0Y4vwG0aIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795441; c=relaxed/simple;
	bh=Xkc2149wNtXY/8qtTP7G7BYzeOjCe/CdZapZJTRO6u0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Z9njTKed34tppj+PfAqWSqH2tS+55uOl/ID0BE8y/p6BBpawYTJFloyOWBlVBxCAc/Np3VtPDl6AyAlP9F/WD3r3BHB7mzPdpyMW2abDLBJfx8fOjcVL3Tq0VHaZ8HKFamENxTXhYQHtMy7KblN5bmjngvcbDEaH/Os0VexPvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=kpl1th/N; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 541EE42C7D
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1767795431;
	bh=Xkc2149wNtXY/8qtTP7G7BYzeOjCe/CdZapZJTRO6u0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=kpl1th/N2tnueCX229Wd0xBCjfiEXn7dVtL7WWfcl6L4Q8ZZ7MCias/rVMM9b0SXl
	 E+tG/06M8XsTI3wlLfRaZQZwn+vo+X76RRTtDg+kpjfYQm4RXGStMq+ng0pjbGcga5
	 wLkGqQ3Vmj/VbloVNl+hEvhekzqWAPOLG38Z2CkQe+SXqcW4xXPBzW6d2jdXf0muLO
	 fB4CrYbs8eoupRWrHzpyKW/Rq7m5txrjNVMiIHaA1yy3cU6rOh3BjOhx84f0MZozC/
	 6cJMv3IQyHKdlGqpCtSD9JJCxS832klvDFGat12M9GaF0Ui3TPfhMUpxOrU91UYQ5e
	 FY0C5aqblTGBQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 441447E7E1
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 14:17:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: FAILEDTOBUILD
X-Launchpad-Build-Component: main
X-Launchpad-Build-Arch: armhf
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #32117306] armhf build of rdma-core 62.0~202601070825+gitc7cc0c8e~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176779543127.1103073.14725601678462970236.launchpad@buildd-manager.lp.internal>
Date: Wed, 07 Jan 2026 14:17:11 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5d04a9888ea0c5f7b2fb3f7c73882e5ad311882b


 * Source Package: rdma-core
 * Version: 62.0~202601070825+gitc7cc0c8e~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 8 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32117306/+files/buildlog_ubuntu-bionic-armhf.rdma-core_62.0~202=
601070825+gitc7cc0c8e~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-034
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 62.0~202601070825+gitc7cc0c8e~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
117306

You are receiving this email because you created this version of this
package.


