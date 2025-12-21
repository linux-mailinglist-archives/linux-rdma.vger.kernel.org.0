Return-Path: <linux-rdma+bounces-15122-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B520CCD3CA3
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 09:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3997300B838
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E52405E1;
	Sun, 21 Dec 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="UojBLrZW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4422F767
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766304102; cv=none; b=SJO9vRl9UzQGTvs8DOmUwSm/UP6hOy6Eh9b9mpQkxUm0ffdKCLeNo/wfiVTbm2aCr5/lrFV5/tsm3NNvxEFz0VnuzQcAoeLXMiW0eTAeXU/xLV2V8rQtoDyqk9XXGAGgV9AnYjz0+JWFfmRDxmbI/cKWbatjAf/8VEb4VsklkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766304102; c=relaxed/simple;
	bh=+RMvAcbzAHN0Fm8oHVYChw39J3SgnNgcTNgQo32PhiQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ElHDm6ZEnjHMf99aulZlt9/pYt8hdV3LbypfQYzVCuHFLG6T1go3dqZDI9lOIe76Q9Wqq21d3XTtlVrB5B65kHRB9X0ESS2cSdU2xzv/dDN3QS6fLzBtqcI15BKBB2uCdrW8XhN8R6xBJJlSScrSm8cdnY4bU37ETj8hDkRkbQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=UojBLrZW; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 34EED3F059
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 08:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1766304099;
	bh=+RMvAcbzAHN0Fm8oHVYChw39J3SgnNgcTNgQo32PhiQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=UojBLrZWaviqeu0OHPDgsmx8sfiCJIuSnnaR85Yg8yxGCOFWQzrE2gDVsNAyTGtJ5
	 UnPJyWC0T7yQHzQz8dDTb0qo2Cc93f0dF0vPVXikc7BN1w1pU9EmhWU8TL1dMwkcKb
	 ZRbrPZfo6YtfjEPswKtJMqVnPdFewTRN9tdSgTzpz/d9A++wHZXphyUPuc3+YVEKvs
	 JaFjcowpsLOQZW9TbRevUs437QB+i4M6Kz2nMplE0+8dDR4X1lDmwZXnx35KQ+ZJNu
	 CSo/wGADvEAwEG1F7mJ+WnMJQheCPHVF93tsw5nTt5JKGchsC9WcVS2YWP6T/Cf+xg
	 4dVgzrGOFs41A==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 1F5FD7E75D
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 08:01:39 +0000 (UTC)
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
Subject: [Build #32078590] armhf build of rdma-core 61.0~202512210742+gited4d0d6e~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176630409912.3431851.16955424561017975119.launchpad@buildd-manager.lp.internal>
Date: Sun, 21 Dec 2025 08:01:39 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 1d8c55f5924f568b6be200f7ebf36de28168c0a7


 * Source Package: rdma-core
 * Version: 61.0~202512210742+gited4d0d6e~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 8 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32078590/+files/buildlog_ubuntu-focal-armhf.rdma-core_61.0~2025=
12210742+gited4d0d6e~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-004
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202512210742+gited4d0d6e~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
078590

You are receiving this email because you created this version of this
package.


