Return-Path: <linux-rdma+bounces-7782-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A883BA37619
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF1F16A7A2
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6B19CC11;
	Sun, 16 Feb 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="oZNn/lau"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C7450FE
	for <linux-rdma@vger.kernel.org>; Sun, 16 Feb 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725153; cv=none; b=UiLcmY2Gj6ZC+1wQqeNGGUN0V8i1PxaJmYMVtTYHDzgcyLgkrtbyu2AtI7NAf8wEf8zSqgf8SGYYECdHET1+US6gpWkt5b5Kxp1u/YN5OU0RTjbVgzFwThCQtH8u396OyeuM5oUZUHnHZY9CVRm0EfupFBoohzDJcFkqjHRddvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725153; c=relaxed/simple;
	bh=KZrvV3YT+T2WkNRHgC3Iv7vnVnQ3ZYbo7ai2QfBfiGs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=auR+8qWf3VvFz0y+X+ZBgWTaig5iPaMwCzqaOh6bB14grNBxupZFFuyukM7atLuETK7NZMijl06a0kmaWWYfVSPyeBNEES50LacKDiJSwGsgHIA7Vs31bzXKqKAWIY9ED62jzPFBUAR6twvEAqPUVca7acMK75Pl0/LkK4qegGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=oZNn/lau; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6DD1C40D60
	for <linux-rdma@vger.kernel.org>; Sun, 16 Feb 2025 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1739724630;
	bh=KZrvV3YT+T2WkNRHgC3Iv7vnVnQ3ZYbo7ai2QfBfiGs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=oZNn/lau2zidFVqO74Kp+un3Y+nd/0SGpB9cLYHPWu2JsxMRYvE0qqOHCphtY7uda
	 l4LV4sB5+VS2lTn//TfcxtBY00gi2C9VCM7xuQ5oape501TK6HYXuCpLAQnY05zwPW
	 x4BO688XWGV1cMHeeLCgzk2Hq9mg66wyHxmTuJzNhbdzdHGDItWTpMUK/J4QFeRYtZ
	 rryjPA3uFzHN3ZoYaMpcspDvtGERXBtt2qgpdYpLEqjOENVP+mixMg1DdOmC+sZR2z
	 JtDJ7t1g5wweWoGyrWtL9WgAeICgvsVJQTRk/wUSa1O1SwpdW3xJtOP6B7Q9lO3ipk
	 IQEE3scmb5Ksw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 6515D7E24A
	for <linux-rdma@vger.kernel.org>; Sun, 16 Feb 2025 16:50:30 +0000 (UTC)
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
Subject: [recipe build #3854452] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173972463041.964601.10847012351147994832.launchpad@buildd-manager.lp.internal>
Date: Sun, 16 Feb 2025 16:50:30 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="78860d903de6d6d7dd5a0ade63efaca45d3467e2"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 9a2c05c977222062192413472196fa85e0348750

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3854452/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-052

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3854452
Your team Linux RDMA is the requester of the build.


