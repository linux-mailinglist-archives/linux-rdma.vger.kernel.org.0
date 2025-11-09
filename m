Return-Path: <linux-rdma+bounces-14348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC760C43F26
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 14:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E040188C569
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0042F744D;
	Sun,  9 Nov 2025 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="e/s5RHwl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038626E715
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695886; cv=none; b=tQDieZxkrPlT4oT4vOolATpRYLq9EIx5HlYDH4d+euk+e3RgqPnZeJXjQem7oTBBBmOsHVuuFqvusbDAL7pXLbXXbkUMegFA1YErwQnIs+VYLstp9bDvYAGy4sFA4EzUci+4TbWx/y6UvQmSx699Tv72ySr4jf4eoY5CtMng3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695886; c=relaxed/simple;
	bh=TZEYaLRd+s8lxvcuY0UGwE4Nsxe48LcrFTolzOxN+sQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Jsm4sffsJkWHHDSHzk6HVNfzRz73/PV8m7P4Bi0Qs1+HZ7hTa/0GiS9ZrAKjFLInqQYuJby1uFTJjmVVKeBaVtHfXA61E3ArjNuwE2vBhvSdnbgEqJiU+57WkaYb8Ii6SIeBAcQuBuWo3ruCYXZa/ZSdGTezp+eqrtCeu1l40no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=e/s5RHwl; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 35FD93F650
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762695882;
	bh=TZEYaLRd+s8lxvcuY0UGwE4Nsxe48LcrFTolzOxN+sQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=e/s5RHwluDcpFWe/ycXImmWtGjpc/RJCfPtOmmeewK8A6l6NhK0V7M2brJy8sfor2
	 vLbPKn2lnIr2vnQAZTjrcXNdkJyxT091WkiNLJ5J4cqyQlWoJ9YhT30RNF2rQzsSBA
	 6LQmQiP77fI66jnPN89YLsdmwnJJKRkHtUwzsjX4jAQm+gxAgJcRZsPbBFGBLOm41b
	 1zBtdVXQMfL5XOP5pg9GHM8OYUY6AgyJJHROl68lT9dt9fmYV8KZ8BWwlX+xUJtzx6
	 pSTVf2ot+++5OEfoT91Am8mub2Nf51252lUU/VJnxhRzY0IzIkNDhOtyQVQyCGuZYG
	 uDHOPcTprhtUQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 159EA7E7A8
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 13:44:42 +0000 (UTC)
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
Subject: [Build #31475472] armhf build of rdma-core 61.0~202511091239+git681467ec~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176269588205.1218157.3421451597520943053.launchpad@buildd-manager.lp.internal>
Date: Sun, 09 Nov 2025 13:44:42 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 231e10c4f1381df018fc20c83cc25647d47cd6d1


 * Source Package: rdma-core
 * Version: 61.0~202511091239+git681467ec~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31475472/+files/buildlog_ubuntu-focal-armhf.rdma-core_61.0~2025=
11091239+git681467ec~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-057
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511091239+git681467ec~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
475472

You are receiving this email because you created this version of this
package.


