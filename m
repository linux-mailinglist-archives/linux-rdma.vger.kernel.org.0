Return-Path: <linux-rdma+bounces-9737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB9A98E1B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446673B2823
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BFC27FD42;
	Wed, 23 Apr 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="L5tKP8P8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76961C8EB
	for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419855; cv=none; b=p4sjgHSnMUijxaDtzrI5OIu4q03AHNHZKsABy8fZFQslKRI/Pihz2evstQC3zXDpBDkUXsEoAeKbT5QtbTul31BRpssWg7UiviKuhiXRtT5AsEWtzNk6D5opihgPlUfBtvXC38FbPBPTDVUcVOanpUqGJvdjTAwlerqf7gNs0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419855; c=relaxed/simple;
	bh=GbwZDkmq4Sk7A9qRXSBk/gFJe4eJ49v56ZdlCDXLu18=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=uXicYWfR3UT09TDZtz3d5NrP+le9R2Lc5YZ/j6RbbxR82a5AzTQbnBFuoYQriJwVEB8Q1InKoDTtGQk+NSkcHwp6yIFlXk4g8CjW4gJgubm+9fEke4c8CmHJboH801Uu/mVdOXdjP/EQ8hgidPO7M5KekcLZ4q+t+vPXkbhfgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=L5tKP8P8; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id A424743946
	for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 14:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1745419845;
	bh=GbwZDkmq4Sk7A9qRXSBk/gFJe4eJ49v56ZdlCDXLu18=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=L5tKP8P86ldJmliCIOElqyePr3hYQeBqQku4cZuPs2YczvWXLccdBh8o86LdkGOQp
	 XYXhc8kYK9/Q+UpiTjXBNzlJA33GbpecYoMz6KQ74EVYqCZPyOkk5CwWHOpmdQ+YlQ
	 zvOpZn4kCRq76kvH/QNg5h72f0ZFQoojoR5z2Mrsl54NAw0gsu0ji1HU9OT7i+x+v6
	 kHhVdvJeaQDhvU+lWNKjFrfIL5yG1ut31T3nNrEEPCO2kGQYU3knxl/axYlD2w0xgV
	 R+p5KyO0p2li31R4TnWClaiMuCPrBBhUxNqP3Nm69jv3PtRdjAdO1Cnj8VjG376mDl
	 XlEkj3wZ+fSvA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 8920D7E25B
	for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 14:50:45 +0000 (UTC)
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
Subject: [recipe build #3886956] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174541984553.6997.12117783233947769548.launchpad@buildd-manager.lp.internal>
Date: Wed, 23 Apr 2025 14:50:45 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e76edd883483c71c468bb038e98836435de44530"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 898f11da1aa799423d3c4e18edf41ca03d9712f1

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3886956/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-054

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3886956
Your team Linux RDMA is the requester of the build.


