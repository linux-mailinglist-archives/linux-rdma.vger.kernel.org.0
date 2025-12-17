Return-Path: <linux-rdma+bounces-15051-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B2CC85CB
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 16:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EC40303F2B5
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62B335545;
	Wed, 17 Dec 2025 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="TsGQWqeW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216433B97F
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765983722; cv=none; b=bqm4CuYnDyCDk/xHk/QKroXXW57qZci6oOniphmPfKE4G0pkeJZB1JtOu/lovvd6ZowtMHzc9eydJvJ++ZaylO7BTKZ9xU+s0fgZnRB2wVKWxCWW7bzQYMvjdNGvLydH7iCQgzOyIySjkDaJhAlZrwueAFeN2i9cUYXJlnZVxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765983722; c=relaxed/simple;
	bh=T4DrC6AfUrMKClWJv7mWRbHlH4C1UqzyWZDIXGdc7pk=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=MvMqKIAOX79ztsPxy5NBW9ejsdHEy6BYmmhGtU9Yu0XenmlO6jzVV7Am5WCmQRPkFDLL1rUXMu1Sqb7UU0EW2Tg5DJntLAfmLFIn8/tqH22BAjvOKAC05Sj0+KHMXGzSLb8GQV9SALxzWHvCs7mNI5k/79slM8HD3XZsTHYUCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=TsGQWqeW; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 632EC47F45
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1765983356;
	bh=T4DrC6AfUrMKClWJv7mWRbHlH4C1UqzyWZDIXGdc7pk=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=TsGQWqeWzKC9p4SFx8p7xc6SIYLGGfYiG0MncmhK8kOF1pksgVh7LonXBhC27uaFU
	 DY5hOupVoV7pFLknGiZdR1mnE+WPsIie4t+NSjcLT6PlnH/TTGbfIk1rZ/Nwccfdwe
	 /JeIAld8Oy23lR9OpwZJyRnmYzDvYwSBz0vY+E+T+QvQo6ueB14BLIUKnVU9EIw3zO
	 cgR4c63LYtFT0LveHhbXfEyVmTtUIAdQBJ9mNC7PtCZbqRfDnLwaxolcJ/JhXjo+Z5
	 wP3IoWVJjXeOfeH9auYePX21xz+POvkH5sZjcS55hXnqs4QUeq9zoL2UA5qHPP2rK6
	 OuJu2vPtZNC3w==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 525F27E7A8
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 14:55:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: FAILEDTOBUILD
X-Launchpad-Build-Component: main
X-Launchpad-Build-Arch: armhf
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #31662576] armhf build of rdma-core 61.0~202512170735+gitd74af53e~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176598335631.2912269.12090647092906327471.launchpad@buildd-manager.lp.internal>
Date: Wed, 17 Dec 2025 14:55:56 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: bdb8303d3bbd22b4f2ed06cb236bd99de8a1ac53


 * Source Package: rdma-core
 * Version: 61.0~202512170735+gitd74af53e~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31662576/+files/buildlog_ubuntu-focal-armhf.rdma-core_61.0~2025=
12170735+gitd74af53e~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-010
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202512170735+gitd74af53e~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
662576

You are receiving this email because you created this version of this
package.


