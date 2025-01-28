Return-Path: <linux-rdma+bounces-7265-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E13FA209E5
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 12:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1281885F59
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 11:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D94319F419;
	Tue, 28 Jan 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="pewAGMPv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA319F111
	for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2025 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738064667; cv=none; b=Em+nNsry/+j7B2G73fKF0o6oHAqAMHm1xb9gDD4Z1ZMsH/gvSlmla9gtkS7nBmBY4RwX2zS6ouluj1El1hxNT/8S3u3S8CTyKegBMl+3kgZz8fw87Y0ChYLSQavfB1FokA0iShmU3Rs3QfvyOFZif0mZC1QqSfYdXPh9COIJPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738064667; c=relaxed/simple;
	bh=N6T3Wx8/p+vZUH2Yij5fZPJcbNH8cRo+YrYtkc30cxg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=QD6DoQ7syc5zLSym285gbXPVDgtZzZxsrGQPGrdxvoSFM9fZYvEYmEf+11DuppoLukiUZl49B0PbGUX09PBsYfGS2IDKx1SCWL5ycnN7uEJFYJ/chJ1RhhYOkffEi3rDYGZA7MVqYx47mfLiwgaoup9jpgjg8kMUtVLiKJL8RvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=pewAGMPv; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id A18053F610
	for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2025 11:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1738064658;
	bh=N6T3Wx8/p+vZUH2Yij5fZPJcbNH8cRo+YrYtkc30cxg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=pewAGMPvnn2VEySMcTjYmqYoikDY8ZJYTJPMjWl8benlPiQ8Ifgd+0i3vuEAH85ba
	 CZYpfknt1x3Bz/LbiQ5xjhHNP0XVQthXhEFDJBxtO72hXzYgMSPOicZurNN6NVnIXr
	 vc2OcfrFsGUrPraBVoMSeRs1fIn3kF17X2JnNvDVlyEUhRkY9eAi/Zz0Tx87H09pYR
	 J7sX8AZpztXEadINvUAfE2fPHUT6FMoab7Flz/sbOTC8z7WWGXsHsGBuNalm5CnvBp
	 NeC3zpcSynuMh3xv/Rlbh6HKffZFoRekAkzbIS4ln5TpXpy+QK6WXckwPsHFU2pYJI
	 QF7cUaXzIm11g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 96DE17E598
	for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2025 11:44:18 +0000 (UTC)
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
Subject: [recipe build #3845282] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173806465861.4117991.16238952123003284743.launchpad@buildd-manager.lp.internal>
Date: Tue, 28 Jan 2025 11:44:18 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4320d60786f71ace1040d24263eb30d3a5cc7d6b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 365bc7d88d3ea623682453091c2704917a5f1b4c

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3845282/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-002

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3845282
Your team Linux RDMA is the requester of the build.


