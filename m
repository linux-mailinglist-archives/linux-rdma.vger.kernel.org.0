Return-Path: <linux-rdma+bounces-12548-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C23B1666B
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C7B568144
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D22D94B5;
	Wed, 30 Jul 2025 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="bhyn9WW1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243562DFF19
	for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900749; cv=none; b=NAacY1IPdUOOxfjdC6NvJ7nu1LJCgLgBo+EJPLzLDrhZNIUlwAoph7xCEgHQ1PecettBzsxJeXCpx4gXwgkv0IxWzTKMEPDQrVErwtcy/8nqdQ6sIBLYjtfo2CY7OVjbzlEW+0Q4avIRIYGXecwCY3Zbb/hCr572xASVVVaWZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900749; c=relaxed/simple;
	bh=81Yl8t6NwE0QaKPEe1bvsV0+bFp7bCxuD1993ge0I9A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=PHoWbaj3Z6MIDkXQ3bFbL0VzFJXLpwRHob4jkSX4S9hVkZ4Z47ovWHKo+EXHwefHp3hgCWaG2Uvm5dK8kk2yQsjicZ5OBxKCfIRz0znfINh7iBIcb2G54pNqP32b2kdT1M1ViLm7XQOItFb9Pgv/Uxkeg5otlPbr+R+DrR1JnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=bhyn9WW1; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id CC51F3F263
	for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1753900299;
	bh=81Yl8t6NwE0QaKPEe1bvsV0+bFp7bCxuD1993ge0I9A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=bhyn9WW1eM7V/+qI9G/DykODAZd6njMKstEXxn6r2dBLHSHGZ3sfrWrZun+PovfTc
	 p2fVeGEeIXuHQ3BDfHewabapu1Ld/Sx7rxJlkhchGXEw7rIaIILmpvMhnH6VG+c1Lx
	 3KbVniLI0lw2utpAVnUyyJqJmm+vzMSNXEQgBm2vXrGGceM59wf9+LrEiEaIEnU/u3
	 ZzWx3WUdtQbnnaTPn62cy+c4H0UjcJ91h8TJzdg93eN+ZoKPSapcXRgwxJK7W04q8Z
	 fPqaT9t/3YkB2QjsMzKPnVWg+sIJmSoOQMypEvTdUFMcHrAyFv8nqo7KR2l0L9ghrf
	 66K1dg1iSwqBQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id BB2BC7E747
	for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 18:31:39 +0000 (UTC)
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
Subject: [recipe build #3928377] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175390029973.4104953.12594581301309931676.launchpad@buildd-manager.lp.internal>
Date: Wed, 30 Jul 2025 18:31:39 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="647c49fc7f614412c17a151d8ba4fadd90c06a00"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2c4c3d1aa3be6ca926cd975f4b30c73d3753b33a

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3928377/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-070

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3928377
Your team Linux RDMA is the requester of the build.


