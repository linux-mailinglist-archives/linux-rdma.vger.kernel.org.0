Return-Path: <linux-rdma+bounces-8714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55731A621C8
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 00:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FF0880CC1
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661101519A1;
	Fri, 14 Mar 2025 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Ry/RjFm3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F82E3362
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995250; cv=none; b=h1BQ74IKqVEgGt2lx7V7E0UDW2fFeos/lR13u7n+RmP702oHWRxKOU6C52WT8LgKclD0SaJChRkwaovFD3oxGRxaP7Gj9UgI6mCc2ztd6vorHpAoXuo5557PrNbR1LOLq+RJccCAm7pYgZ8xRibQwLpGz2xU9RK7psYFCK9WYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995250; c=relaxed/simple;
	bh=PojN+u0I8LoI6JVwJ+r8Ve2u9dEFPbRPC3icxPNV8FA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=t6tDPPkYXPsUi67CohZ76QLYeEa1Avkd3qSvJBdceUGjhfX2FG6+z3tQmGScNHXwizTOWD+hNA6rlBWYC3ZCtOfxKUyQuoOmhRmF+VvhcSCuL9qOhVrpzZ1Xg3IZD7HCFEWhRaD6BRVZyTgPRdFeGmHTCnmz62BoCde6KDO4qJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Ry/RjFm3; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id C40D74083D
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 23:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1741995238;
	bh=PojN+u0I8LoI6JVwJ+r8Ve2u9dEFPbRPC3icxPNV8FA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Ry/RjFm3ru1eMLvaRJOjFevXRq5kmLHUgWSpswHGDEAWV031KQvlz2nXFm7uspKIk
	 xnrVt20YJOjF8/i7Q9ZEjPzOn55Dxjwkgywu/MGcYMTgoZVLU/ZA1su1kOmkBKnlA5
	 taAi8qfK64AyNcKeydRRFruRIWJvTmCaxOUQu8dY2AzuY0C3J5S2C8JtdwW0FaFgU3
	 z/7K28EvJKTvKKi4z7sjRAygGbyUpisUXsqqrrWL1B9ciBzA5/sqTtEKium0SSmlzD
	 tArwV/n6qez7g1lQuckirYkUpcB2mMcWS6Q3oWaTU11+y9e7OUeCS3bnzjwcZhbGbk
	 ZIEuUZiC2v4yQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id BCE497E236
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 23:33:58 +0000 (UTC)
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
Subject: [recipe build #3868162] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174199523877.4188075.17948206721384867076.launchpad@buildd-manager.lp.internal>
Date: Fri, 14 Mar 2025 23:33:58 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aa29ae0fff49e4e804b39147c9f259d2fb023199"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2de20bee802bd5fe1eee24f3a44c30da6bab5134

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3868162/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-051

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3868162
Your team Linux RDMA is the requester of the build.


