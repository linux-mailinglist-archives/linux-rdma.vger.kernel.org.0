Return-Path: <linux-rdma+bounces-4338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F27894EE4A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 15:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F5C28162B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A217CA12;
	Mon, 12 Aug 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="qezNflT4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD717CA09
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469606; cv=none; b=WanyMtvLiAFF2UZVSVEuuaD014ZgUooI+JGMsUvadwdsVPSSwION6Oc9bKmN4yptJlMofqoYJfnDErp9MZt+dB/oXVmm36Ln4s1ea130Wb0hJ/Ss+acDrpyOQDwMcxf9fZY49jz11Ykz1dwFDjHlQbqV2kLkGULB8D1ufIyX5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469606; c=relaxed/simple;
	bh=MZOAqlC66F84HhjEojL+O0jYVWVVj5fsZNDDsSBpchA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ghbXHUZ5rkLIwopy3G7MUygbAnnLcj/mDs4iBYfMzftXS4IzBlwPx9Okob+f/0Peo72984YuCMT/+Y5AtbeS759LXo7NeM8wbdxfyxKvUiSevhPr83HrZFPfESV7rl5NxBmlZxuoQ2vL7BEHCEsn/V9Fp0H6k5dqzRLHOT/coNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=qezNflT4; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id E409F44CF5
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1723469595;
	bh=MZOAqlC66F84HhjEojL+O0jYVWVVj5fsZNDDsSBpchA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=qezNflT48Mfrz5J5M0JaRXFsfmygN2GyNYyNQn19iEPEfqgkngk2ElvIIe6eRVj6/
	 YMo3tKHkZrtrKFJB6BRcascvBNlVl13VPhAqe2A1vciPtzPFywkLCZ2+ubajHtnVSG
	 C5P7DWTjvlh9x8JWJCVy7cbf05UQhPHhzHc9nM4niDJs2PXor/buNOdR+kFjZ0BM9N
	 SQ06KDE31jpuUPY6EmvHTH2/gz6yeO8ECkWgN2qO5wz7yCrhjgG9jg5//OzCxYoikY
	 gVUn7liYlLHZgESTGUwacZ0kHVVv5qfp5oCS9TRlto7oNqNhXNjtkNjjW3QqwMj1Hd
	 /4/slHFcT7VxA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id D982E7E243
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 13:33:15 +0000 (UTC)
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
Subject: [recipe build #3770929] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172346959588.2495917.17211365878202819442.launchpad@buildd-manager.lp.internal>
Date: Mon, 12 Aug 2024 13:33:15 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="eee2d0bef530fefd2b38300920b19962c91db1ed"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 1cd527270f69ff514590ede4a163ce0bd7e05145

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3770929/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-044

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3770929
Your team Linux RDMA is the requester of the build.


