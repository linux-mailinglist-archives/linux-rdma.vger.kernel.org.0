Return-Path: <linux-rdma+bounces-15162-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A877FCD6501
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 15:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6FDD30B4F14
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023901A2C0B;
	Mon, 22 Dec 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="tOSbfc7k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6B625524C
	for <linux-rdma@vger.kernel.org>; Mon, 22 Dec 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766412047; cv=none; b=i+3KJka7oxD9JBDjok4jixQaC4hHxePnFk9cbypImXfBkCSWdWwXEADt6lJPrM7ppfBVAnQ+wULiDKXnTCyu1a3kH5cpm27vJL0m+klauf6oTmKvJA9H+DkmcckbceQOrDBafWcTOhzzMiseFRu/xaH1gfAeoCxIl9yZMqpri1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766412047; c=relaxed/simple;
	bh=KbgXrK2SzesU8V8q21wgqpU+aoY2QW7kNmjTY1m3W0s=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=PWhhA6Qjor/MRlVbnp8oLUa4PcfKmvVhdbEvRg52PqgAtKuMP7aoca/RZLVbBfnSuk+Mvz7x6h19Eb+tlwg7t2NqdTpXd+fXAqfZkTEAIwvOQt9sjqd5b7u3GGcIQji/JOuAKxe/dyDW4L1Jrt2vcPvZN/cdYhdpNY+Mt7zqVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=tOSbfc7k; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6AE7C42229
	for <linux-rdma@vger.kernel.org>; Mon, 22 Dec 2025 14:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1766412043;
	bh=KbgXrK2SzesU8V8q21wgqpU+aoY2QW7kNmjTY1m3W0s=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=tOSbfc7kfVunOHB+cjbruGejAqW48W0mgOrQO83SfS7czJj4sWp3K9pAhqx1cGv8v
	 D85NVnQ6DriJBWpXcSd+Cd7GwvSpbjx/gFY6DgchCOUiYI9YiX4mP7F6ndo1rqh0Ef
	 22a3FiIjiCkoQ9wk443j2RRFrpprcYWDI7ppLBoVrj9Nou3j95VwZPNQ7Z8z8TVorZ
	 cUuecQKXyP8uZbj2vth8BXTiczstIvNXtyJhGUKqAC3g/i7xm4tzUTiROK9/5tWZyn
	 eeH159Z6jiws9wmu8dSUo+N9Uqh3mvI2N5lCwqyiPXLoKXzgj72TMFWU+CfJcZ0jN0
	 VAbpCdHA0YZaw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 6050D7E750
	for <linux-rdma@vger.kernel.org>; Mon, 22 Dec 2025 14:00:43 +0000 (UTC)
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
Subject: [Build #32080498] armhf build of rdma-core 62.0~202512210746+gited047648~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176641204338.3431851.10684622700334987228.launchpad@buildd-manager.lp.internal>
Date: Mon, 22 Dec 2025 14:00:43 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d1d4d9adeeed5c674e1bd1b3b3853fafc0ed5955


 * Source Package: rdma-core
 * Version: 62.0~202512210746+gited047648~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 12 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32080498/+files/buildlog_ubuntu-bionic-armhf.rdma-core_62.0~202=
512210746+gited047648~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-002
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 62.0~202512210746+gited047648~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
080498

You are receiving this email because you created this version of this
package.


