Return-Path: <linux-rdma+bounces-2904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81A08FD142
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5460E2859F1
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694432837A;
	Wed,  5 Jun 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="G73FE5lG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566E19D88D
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599408; cv=none; b=QdwCwkVzpKV0cSAlQbVYVJrbscKkScyOA3hb/6Lme/HnvdCAE1FtLhEC725sYR5N5KPWDBlJvtXw7tlAfkn6GZjOBDTxd4FUcNjRyiCuOMZVp3dl/WWaj2hvfkMF0EJg7/y/OzXzaa8BNA9tNmOs/RAwuknRb+l6utAajbSe8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599408; c=relaxed/simple;
	bh=E2MeVJzneiDJ7gMVd3g6Xe0aEdHFhV5cqe3bZl1w0jE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=rtynuLnK22+w7/85wASLYVm1mDu4R/kt6sdHdLx0dbAIeoXvUXVT1TfipR9m80yOsKR7OX5UfFgB/IoAU5w5ApBsCILx4e8NWq4xb2tIkO8yFvnZ4S2ukloIS9l1GmQCY06rMhHsdoXKB4XhevClC0LOvtVEiKSNGPKBZamK+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=G73FE5lG; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 082B14AA49
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1717599399;
	bh=E2MeVJzneiDJ7gMVd3g6Xe0aEdHFhV5cqe3bZl1w0jE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=G73FE5lGED41fcnVD1jX1g1IeHnHRBMYctoF/Hquu2rsmqRonZyOHKSFrTwZTbN47
	 oG4YtUAne3Q1uAFEeA39NWbA338pMYRpioGfdPRni1N4qPVJcSGcRyNGr1bkJqRw8N
	 5t07z+kKl4t0LhA3CqdBN00wV2Sb9RWAFCgnHd2wcElbjgTqGMMa4MGSwk/JSaXCKC
	 cN+/i5CSH33+1GP8H3kGNNaNYMcbwTtGwmqKXatJdrtUnL8ANyWryyR5UopetBoAJe
	 ItDTqOU9uhWQwYsylI/GP6vCvsPwIQQ18rrV09FJmX/eGNfLvA95uhIgBy5uUK90Hr
	 e1VtE24ZsWECQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id F0C257E236
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:56:38 +0000 (UTC)
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
Subject: [Build #28518774] armhf build of rdma-core 53.0~202406051209+git1840c1b7~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171759939898.3361349.11165003317401744982.launchpad@buildd-manager.lp.internal>
Date: Wed, 05 Jun 2024 14:56:38 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4d1350fd3710dfe10d207fa9961e224cc481dca3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 72d0bd84a779e8570ef9758af943bc5370f1b2d3


 * Source Package: rdma-core
 * Version: 53.0~202406051209+git1840c1b7~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 8 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28518774/+files/buildlog_ubuntu-bionic-armhf.rdma-core_53.0~202=
406051209+git1840c1b7~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-026
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406051209+git1840c1b7~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
518774

You are receiving this email because you created this version of this
package.


