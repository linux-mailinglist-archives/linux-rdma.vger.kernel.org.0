Return-Path: <linux-rdma+bounces-4635-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0577964714
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 15:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772A2B2A214
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BBB1A707F;
	Thu, 29 Aug 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Xwh8pkiq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27A16D33C
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938829; cv=none; b=BG5ZmhNXLLGKeQ/vBaKLyiDRDDGXTdRnHNtZjaZAFlF+Rd7P7sTeMpT5kEnc3qNNaYG4j+JlG91HjikVe9O3VvpCioRD80raBgXdJvc3L6ayEjMwp42bOrBkfyRhVdPhZwnGYPe23Wg0caMHkEgEc3dLiS9jnvxEI4OHK4reNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938829; c=relaxed/simple;
	bh=A6s0/9kefY/d/MF2CPmN5Yt9QOhw+cylljXWxb4hz8A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=GpkLvBKT7tBDn5nkR8j3vfT0K7DNyM59HwrwgMwThjg/1c6+l/irM4cgelOoN3paEvaPbIMrVIlLHUozPcuGDxbd5FyradvD0oa6OICYqmuzIDdzVW9XKmV2wOkNtZUV7bADrBWhZWtrl+hncEY0Q6C0lGA4XDbGuL2Ink4dY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Xwh8pkiq; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 064043F47A
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1724938396;
	bh=A6s0/9kefY/d/MF2CPmN5Yt9QOhw+cylljXWxb4hz8A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Xwh8pkiquwokfUA43wmr2KVroXN8PBZ42LoHnA7VjcbfblyAVuRETb7AP86YFh4uW
	 ifBbsiov2bICzPHFxiDkjBh7Ux8C8EJHE4mFxQW9Pcgh/LQvcWwM3VZA8pkqliKaHY
	 Tew8Ty+JrxzYs8tWsrRgn2mrksaR9IvwVMUXFOf8xBTX7JQ6eGRJcORHjaiBd2s9AJ
	 aE6PFXeLESbD587F76iVRxqGn3fzQqkU3UBIqLolnn9/txXao+rtKpTUDj2SHebam1
	 3kDqQ9Uwl6UmJ1LxfdEYGcyFkfpOhsAPRxpxJP9EdUigobqWRl2M1p2uSeiQVWmoWS
	 LLZp+0Xm/qekQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id F22207E24B
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 13:33:15 +0000 (UTC)
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
X-Launchpad-Build-State: FAILEDTOBUILD
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: noreply@launchpad.net
Subject: [recipe build #3778657] of ~linux-rdma rdma-core-daily in xenial: Failed to build
Message-Id: <172493839598.1779024.9210505566018910381.launchpad@buildd-manager.lp.internal>
Date: Thu, 29 Aug 2024 13:33:15 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2d98910fb261d419a052f7405441227555321932

 * State: Failed to build
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3778657/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-056

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3778657
Your team Linux RDMA is the requester of the build.


