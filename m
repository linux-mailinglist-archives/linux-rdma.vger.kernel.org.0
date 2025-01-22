Return-Path: <linux-rdma+bounces-7182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F903A196D5
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 17:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB19B188D541
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6117B215040;
	Wed, 22 Jan 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="cstSMHuB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E011CEAA3
	for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564577; cv=none; b=ra2E2quX1q2wo5vHWgx8T74znvjCT3nEcz4lZ/70rE5OBUoYOe7b0Q0CO00Gcr+rGLyEAW/IJUOSbO+RlfBT9kqb8R0pgzXllllej31Sa5+A+gbLslV2OjGH0nQTxEJMaGjJow0e+A96kgX247G8IEB1ZOywYJlPXK0yAhGNoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564577; c=relaxed/simple;
	bh=qgYDUQ9Rb8BferKGeyser5jlVkdZFMYgrkz2Z72OVAM=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ZCFJp4VCRIPtvi9YTtwvdQiiymuQXHKz39dUd7+7MkSPetHizMbMKnGJi8QdVk8OYFizKs98q8rja8fhjhg3Lr7mar9QFHGGW/d7X4nO7LnluRIeFe2bRtxR3pU5QkBlyKnvfvtWLAtDv2rvoGW31OdNQbhBCb7k4riH4K85ET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=cstSMHuB; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id A28853F4CE
	for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1737564567;
	bh=qgYDUQ9Rb8BferKGeyser5jlVkdZFMYgrkz2Z72OVAM=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=cstSMHuBfr27Y/J9CVugliR7QQbJY0hxBKXWrw0gFbsqu3GHGWSUMZZDzevaYk+Zu
	 0sLVyK+J5tyCGDEG9HNvYIUuP0Bqbn2iDXegfXQjSoV6mgJq4qN2uqoHod2TSa5k1l
	 mf8uoSV3CC6e4Euc+YT9bllGjC4qAF+41JBt9ssdPsA2Ie+vAp7NN4F9oJ5fXohMeh
	 v+OKwT5i68P3KoyDizFC+g7D7mBzE9iHhpU5qTPkY0e1E5usAx8SNdPTxWuVMDpeI2
	 hi7Zln5v5B+WQrFCpD+4yJ87G0WdvNhLLW6artLR7KdaQskRaDqzaMf5tHeqpjiQ6D
	 ca/nnTPsQZCaA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 95DBA82F83
	for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 16:49:27 +0000 (UTC)
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
Subject: [recipe build #3842951] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173756456761.2646399.7445314111843786950.launchpad@buildd-manager.lp.internal>
Date: Wed, 22 Jan 2025 16:49:27 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="6394e03793719e8d73f5a60b5439440e693c92f1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2b7545f18ca41c29a188a2048ce5d744e5e78056

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3842951/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-038

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3842951
Your team Linux RDMA is the requester of the build.


