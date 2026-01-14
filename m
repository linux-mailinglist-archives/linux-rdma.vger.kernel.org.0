Return-Path: <linux-rdma+bounces-15553-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC0D1F616
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 15:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3D883027CF6
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4925F7A5;
	Wed, 14 Jan 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="EZRR+BiS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D403D3B3
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400397; cv=none; b=Xm5id/Rq//dDcG0QzDUZ/EcAVTKA2TjW8/qwPcoN+19dANFTgsBzGwGxqz/kgDCeNVwCCvPzd8Nrnvz/U5xvZsCbEYmqDnHW6OIBBfj4A/sNd1IwfzoK5MQbB7v1tGbBfD+nZR8wkMzrEADUSisqW4j18SWRJHN5S5ZC5Tuf2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400397; c=relaxed/simple;
	bh=jUgV38EAF15KSgOgNnnt1uodviHSIlsgTfacnrJmXIo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=M40/91EcWZTRAZNDLLzsHtXgQmcvYubW5wMXDwpb9OMVN6tzHgo0X63SGgwHPNaKvBCHevXTaBLnrP8tqCBv/9ljMfFTrG4AMA8wUKbOQTxHKZtvWSzMt+mSkKdGnqCDRbfpJiRyf181NzW2xcwuuSB12w3bhHB5kebqTpokvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=EZRR+BiS; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 4BE9D3F895
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1768400394;
	bh=jUgV38EAF15KSgOgNnnt1uodviHSIlsgTfacnrJmXIo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=EZRR+BiSBx5j532lSyqyOtNN/9B0zXqB3W8DrefHkErJEvcl6LDlyGrxTXii60LcL
	 MBkMZp2XsHcXtwvm5lxThh7z0LaiY8eSNuCc1wNZ7ZnhWUubzAp8iJqlGr/JU4S2Kj
	 HpJDYeZDM5/2h5GEeSqQNoW6D4aKhnornRTBoIDfmxx9joq/57lSHkczzxLGbuxQfH
	 tOjtsocvXm5jn3PsJHkesxC66z98pTzYYYfX5hKkSXLdyT/8EAXKusY3rBaGEMjynK
	 4tORhIGRopvX4offksD5KTlTNQrfXCDKRgMbeaFbhWnq2OKI6jk6nNGxOYnLG7+VdB
	 UWEbTxsZ6c2Zg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 2811F7E851
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 14:19:54 +0000 (UTC)
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
Subject: [Build #32143564] armhf build of rdma-core 62.0~202601141146+git56921971~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176840039415.3160048.698870953321556729.launchpad@buildd-manager.lp.internal>
Date: Wed, 14 Jan 2026 14:19:54 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="9fcfff1971229ac997140f06b41a902ac8ec69f4"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: fa41c2f6d173aa8d38e949e1fde36eded075ac92


 * Source Package: rdma-core
 * Version: 62.0~202601141146+git56921971~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 10 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32143564/+files/buildlog_ubuntu-focal-armhf.rdma-core_62.0~2026=
01141146+git56921971~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-050
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 62.0~202601141146+git56921971~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
143564

You are receiving this email because you created this version of this
package.


