Return-Path: <linux-rdma+bounces-4125-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F39423E1
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 02:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BCF286019
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 00:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2674431;
	Wed, 31 Jul 2024 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="bQjMYWKy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE8523A
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2024 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386325; cv=none; b=DdFYrvUjfZQShBCn5xYJgUyHNav1V4ndV9tQsX4Ejrtw7yR1IYs4jKwvo0EQnAOZrEtjwBOtFFZtfncKB8WsqkzmSEDZnhZWc+SSynnZ1JuMR8cffd8c4qI0zWIYfWm64u+F9WzOUTWyajybGtWZMhwcz1jOvAjAKzESq1OP690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386325; c=relaxed/simple;
	bh=Nx+rNP6D1KyTVVKrQkBr4kU7PxagIbFJK1RuUFN2EhE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=N+xWbdNXrw6gRkPD/5tEn9SwLQEfxT+SY9y3XVnRnh3UvH6NLITmvZqjFuJTULDefDZIVavURxtaWvOpZduRtHOTc80sAtC9FMvNdHk7+cdsuN1Qa5vIgLrVG6bxPTncagEk5uMMRlw2OnQZ1TvXpVbVJuwe9F/fLemmT8k+b8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=bQjMYWKy; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id E17D040E05
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2024 00:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1722386314;
	bh=Nx+rNP6D1KyTVVKrQkBr4kU7PxagIbFJK1RuUFN2EhE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=bQjMYWKyjyPLEaWIHCeZug+YaMu2vDYFEyQzRI9yL9o+L+XEvx0LD3JCKNBXMpimw
	 2KYieDUD4zRvqR9oartLadx4a37O6e2aYLAuVVYzWxNv1KpMPEBsjJgrDO4Igp+i9z
	 TqlDho0rZ2nC3yA6rPtxgDbd/0CfUfBnHH4bAX2cPgusHPLCbi7Al01f/LYWBtcY4R
	 JUuyghwr51E9TcGhBxKdXsqHg9K1Rpn2yFFJBaVXZEikIhFFUWNU6X4PgH2XuyRcLx
	 LSbi4Jf87YdLx3VM2qzVO6zssu+rloQ9ON/BCTNGxEIEf7w8Yzh2FAeS8M4ohMfr4N
	 JzWgjytT+vGXg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id C0F5F7F50A
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2024 00:38:34 +0000 (UTC)
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
Subject: [recipe build #3764170] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172238631474.2860173.9208585806280066151.launchpad@buildd-manager.lp.internal>
Date: Wed, 31 Jul 2024 00:38:34 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e3ace39cea497a5ecb83e8fb6dd8e7e169f02939"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 065729f7af2e9c2cb1117d267f074bc939bb2183

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3764170/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-116

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3764170
Your team Linux RDMA is the requester of the build.


