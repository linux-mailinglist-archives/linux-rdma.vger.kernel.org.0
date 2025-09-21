Return-Path: <linux-rdma+bounces-13536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD820B8E3A8
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 21:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416E03AA287
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 19:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CCC2144C7;
	Sun, 21 Sep 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="hhjPbqT3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221922BB1D
	for <linux-rdma@vger.kernel.org>; Sun, 21 Sep 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758481714; cv=none; b=FYTW4mc9zadr5Zsn0TKvFy/4GPnTfnyB6IUkVdYUYnbwYRS+73JkuJOSHHu7zjbhvyuxJ364Q3kGvxtpwqs64NCXKKewOMCNTvJc6KvHNHcjeeL25Mp9QOu7KUw6t6y2v40pviH0uLxnqA97d0n4VMJcX72wZ1NTqhlO/6ZiC3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758481714; c=relaxed/simple;
	bh=yzXAtPCWWWm2EALZZ1OSEwbMIgn0fPN0uuoCuGlsdhg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=FN6SoCzR/IOP7NMqSUnL5J8sOAX3oweYIwXOEZcglHiO+1gY9bGvEyqnOVlSSkwJEYcHbNoi6ijsAU4L6WR9ufeW6WQ7mMJz3rofUDpUury73pJhcyylw736mUlanYGAursq9t2I1SJFhNAp8kJbnuFY9NX+6MPdjIGDofGgOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=hhjPbqT3; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 7B36F3F1B1
	for <linux-rdma@vger.kernel.org>; Sun, 21 Sep 2025 19:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1758481704;
	bh=yzXAtPCWWWm2EALZZ1OSEwbMIgn0fPN0uuoCuGlsdhg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=hhjPbqT3zX1UV1msQ1lfoScK6+xJzeeUduvTMNKahgYS3uuzxj/VtCHP+T5yp6/fX
	 EFjj0ER/JBvdR9tZ0nroyScYrbNviYzEDM4OgPzVQEyQ4Mp4J6MIwaHNlUlqcpwHjM
	 LKsRFCDei2L5neFVH/LxnBnpdDcQH3smN/+lUQF1TVI9Aa07nDlrS3kwoerLqUhyxY
	 8fu9ed0MCL7UoS82qFw5W+yvA742NbOdvrw8DqVS2AxLE7vFPgxDJWjxcR+cG226Yn
	 Jv4EafbLJJNh3KcMg1WuZ8NMw/F9pNf2Dq4tL/3LXYUSfJBoEmTin71v74WNfRLxfO
	 Bbcnu2a4WXp/A==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 63E287E745
	for <linux-rdma@vger.kernel.org>; Sun, 21 Sep 2025 19:08:24 +0000 (UTC)
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
Subject: [recipe build #3948171] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175848170439.3480037.1464215808753998283.launchpad@buildd-manager.lp.internal>
Date: Sun, 21 Sep 2025 19:08:24 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="299e6cec2b88528c8351aab8852cf896cddc6846"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: bf71eb7a7a2cfa559176cb02bb84d492ea831e6a

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 8 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3948171/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-110

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3948171
Your team Linux RDMA is the requester of the build.


