Return-Path: <linux-rdma+bounces-11339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E17ADAEE0
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2977AA007
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ADE261570;
	Mon, 16 Jun 2025 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="ulgLojkx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12919F424
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074125; cv=none; b=Bni8URgGnlQaXisaZ0XpCduMeNLJRc3AzGHM5GFey0A4GNQ9A4WJsKbuPOW1HeSdKyNUftPaSVY+0xodTwvpat/HgK0WUgS4y7A6dKn9io3ilVeh2pmMBGSfa3IjsqKhCjp8BWgcjuBMturcTuNXCW3hTGfq0zXQzICI5O4Kaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074125; c=relaxed/simple;
	bh=i6r23/HUS4T+9rIsAdlkrVSKjtMkGtURMRSFxm9Gmhg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ih0T6ddypJ6RjaJf5JMt+VZney7E7z6HTNR7UPzVvyytskOMhdsVRHk2pIJANOf9HnU4aP5OASb1CjvIHEhzby/fGV/nMNCGjWibxI0gfDpIHPrfKrg1i0zEvLggRoNXOCdrlzgNUOoEiDE7mgulWgmgJIbFvQqf2nl8J9TSn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=ulgLojkx; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6F0333F92A
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1750073573;
	bh=i6r23/HUS4T+9rIsAdlkrVSKjtMkGtURMRSFxm9Gmhg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=ulgLojkxsoEm8BG3wno7lB2tDiRqHVNNYsz/glK6Qn1Sg55t+J6bhkJc7ecyfJA6X
	 EzFqkkdEkEHrV0IlbvGH3s0ZvISnF2Hn2XDOq9zdF/ic7vXgyIkUTqyen7WYbCXe+Z
	 x4EK7SACgaaPpOkhhwW6HEEK2exqXoORoGpj/CZEx3X8V6HHHoNzLlMjOIhvHuHzUl
	 RswaZNpbP8vo8od5i/vecYJEtKAHdtlVm9WrVZ7bgl668ZhuhjpQSudYfQm3UK9GJN
	 jdavpzP6exbALi9NKeAXowQdrYwV+SWvmCNP+Hr+jw2j3VyjDubUtGIITaWxlenfwa
	 MrFIWKmPeq4Ew==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 5C5087E24B
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 11:32:53 +0000 (UTC)
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
Subject: [recipe build #3910366] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175007357335.1008304.985193705844146150.launchpad@buildd-manager.lp.internal>
Date: Mon, 16 Jun 2025 11:32:53 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2f3e2deec61796d4ee775e1cf25403fcfe2e4659"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 3d8b2b4c1d5e39614dda8715afcf478cdf888e27

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3910366/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-101

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3910366
Your team Linux RDMA is the requester of the build.


