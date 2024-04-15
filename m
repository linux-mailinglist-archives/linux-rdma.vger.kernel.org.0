Return-Path: <linux-rdma+bounces-1947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A03488A5DCA
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 00:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DDF1F22554
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Apr 2024 22:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A57B1442F3;
	Mon, 15 Apr 2024 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="ccCU44D2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047D2E852
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221010; cv=none; b=E0dSzEp9laSmCQwqxL6gjOG0AE73lLl3Uvx+e8EY127D3108lncLTdUgiVACso5fXWcItOWPR93HLB0vel0C9RTbhJtAuY1OEF6nHce9Qxeq8x+o10yU2kFGBM8TuaIu70cHSRtfY5eB8kgmdVAUL+CHqqZUzEKcDTtXMhGJXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221010; c=relaxed/simple;
	bh=WI67IuvIACDf6rZggFVa31X6kJZ7iRWQeaSB8z6103g=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=GRJR7UKadC8g7xtAJ32VfHB9JTk3Xj6WG8dEM/oZQ9WBROJT27XdSVbB+KxRyM34V+s2Kr2kqJxRGQIXWkdw7F62Q2agS3KE+hoKC5U09jZaA1q6m5ohpLqAt3nTAahemrTHNnx1+2R2Qi5vpSIL39mJPRAWMPKhy6YSopmnfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=ccCU44D2; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id C7EE33F8D7
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 22:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1713221006;
	bh=WI67IuvIACDf6rZggFVa31X6kJZ7iRWQeaSB8z6103g=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=ccCU44D2UzAKwyTXVkFQVgEToNuGq8znUdtpMCMb6Y3dekUIwaZke+92l3Fzd7eD+
	 Off4ELlCNsPUZ5XV0/hLFvx9vPJPzWfWC7ZJ10hQ3d6zbWyNcysrrm2mlPCN/+OQxL
	 SKDrgMVQGnkJJ8ZKmffexyfqn8AHXqsgaQ3JyUU/e1WQ1/7daIjqTSXh6+90jxYjFi
	 Za6Rxac9+5VaEq6vIAkgerw6RS4f0WfNpv7TRP2L8KFaqLpvbm+zyig5orf6Jl1Cri
	 DxC8gzheqFXejxUIuDnDIfO65geteInFE4oI+y5Xd8afWLMoAF/cRvXE867hEMc4RU
	 6yBQoGlipEH5Q==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id B24787E243
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 22:43:26 +0000 (UTC)
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
Subject: [Build #28097061] armhf build of rdma-core 52.0~202404151807+git3be56612~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171322100671.3971088.8758366845839240244.launchpad@juju-98d295-prod-launchpad-15>
Date: Mon, 15 Apr 2024 22:43:26 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="67d34a19aaa1df7be4dd8bf498cbc5bbd785067b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: cb8fcc0a5c10bb6a42ef9ab243d5d98c5c71aee5


 * Source Package: rdma-core
 * Version: 52.0~202404151807+git3be56612~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 9 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28097061/+files/buildlog_ubuntu-bionic-armhf.rdma-core_52.0~202=
404151807+git3be56612~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-051
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 52.0~202404151807+git3be56612~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
097061

You are receiving this email because you created this version of this
package.


