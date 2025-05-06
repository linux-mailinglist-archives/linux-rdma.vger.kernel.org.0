Return-Path: <linux-rdma+bounces-10098-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BEDAACADA
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3BE174AC5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8183284667;
	Tue,  6 May 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="rZHG9HmM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF2B28152D
	for <linux-rdma@vger.kernel.org>; Tue,  6 May 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548649; cv=none; b=ZS8MT4Nx3ilW7YVb1dcCCjwqsk6osE7MSNgnk0egWCM3xRGS4dJxVNAggenwZcq9e6FTtyCcfCUko7w6sv+vSBn/QNsCViw2IkE2lK2EIGQGhzCOgQ8Ws+GC75bw5W+xb0ItsGBdtbFxdtwfG0Aey84GdK6gGTjfR1GOrclspnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548649; c=relaxed/simple;
	bh=Z6d9sTCvK3Vp7zF6BniwF2uPCwA6S2CndBsOSdzWuEA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=JhTNyezDvEcUxfMgeVQHzU8nq+Lo1wE+radWdsanVHcysvRfgeJxYxxm9tSQZgpWJsVMa5Qzcw1ras8eMzJbaRYf2ohWp4Re7HANVwF7WwCKOAhNiN/qGWrOYEQ0zkGfPHiCfL8gP6S8+s9XcQbNyk0Ii7CBw/mSBAphU9a+9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=rZHG9HmM; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 70C1041E31
	for <linux-rdma@vger.kernel.org>; Tue,  6 May 2025 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1746548238;
	bh=Z6d9sTCvK3Vp7zF6BniwF2uPCwA6S2CndBsOSdzWuEA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=rZHG9HmMxxV8vDCw7X3LBFc0b0/D5ZIA2c6szfnL/I4PlNV05Av9T0QAjLzDviNGD
	 EoPMSqjq4ByG689AFu3Uj2rVRt7IdQmc0uTE6FuXE1q3Azq24IObI84KiUbkaZQpwN
	 4ibWNKxH5ECNK83wgS1ScRU/Ji5+Sxs2ZN9nWGEnOLlDLX2zrOME67kPeeS3TMDUXD
	 FxcKekhFI0479tU8kl31sv61SmNhVmw6Ok9ubQHfIj0RiEdPPmdKRufB786ZdL0vd/
	 1LIJ6pKi4N2XA/EHNlO76/s+VwOq2D3NX69I+2DSpnFS8+6JGNZg1kZynj4D9HzVm2
	 U04Rb4FFzNkTQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 50D8A7EB93
	for <linux-rdma@vger.kernel.org>; Tue,  6 May 2025 16:17:18 +0000 (UTC)
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
Subject: [recipe build #3892789] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174654823830.3032892.3524929293249735952.launchpad@buildd-manager.lp.internal>
Date: Tue, 06 May 2025 16:17:18 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="0c26a2e7f9db0d0716027609f2b41fdcff7084f9"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 07c76ba14ce9abdb3c53f657635d7f92bb3c9cdf

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3892789/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-036

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3892789
Your team Linux RDMA is the requester of the build.


