Return-Path: <linux-rdma+bounces-15328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D38CF8B90
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 15:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E68D03048BB6
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C482E62B3;
	Tue,  6 Jan 2026 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Dluh16kq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422E2F1FDD
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709004; cv=none; b=MoCa4Uc/wK3HMIu1BqTt2B//4OMTj/51DBLfUxf/2aMsO0MwzNSIxe60PHJS6wBDSujFb1YfvlywXXQ+ogGwt1kH446DZoAv9pC/DEM6jHD1uSmnGSoEuDkt/W7Tg9hBUeyN4KrQ/oBX0XEXaTofj2zDWaNOS1YptcRTMutvuXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709004; c=relaxed/simple;
	bh=D29iKI3mfFaNO25zxbIATpUxZfcq+grITYZO6mnHAdo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=J4bxiJFN5QxzFT6jpD3oQtKIOpreWjKE9LP+ERz78kBnfr4elAngRtNWMbvMIKpyYpZc2ijOElaEe/eRLd64jj7MaX74QIxlO7wZP8noBHLKT8WDfkGYwPCSltpEPdtvtqRhILpk7RFkav/WqgSen/5WBrQLpP9Mt0ui9oRT9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Dluh16kq; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 346583F78E
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1767709001;
	bh=D29iKI3mfFaNO25zxbIATpUxZfcq+grITYZO6mnHAdo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Dluh16kqo+MMhu/7WOvnxqFqpNUiEftcM/hxOIptK74QzLe1lp0LwSUzUtiPfA7yg
	 Q30ILS3ZNKhhKwGEnEN8LlyO6NASbApLCLJIniZs81JKXTmM9XG6Hr/Xm+8cRv7osM
	 7ar2DTfOhreQ443pyaERicdT46whTHN/k8rqh9HORmL1Q3ImM8bujjoLPpEOKlm/Y5
	 zsWI1ovAXGwHQhAjH5xHv8JUoAWhllJCc05aNV+1B9fOuh/TDHC/u75Ws6DrsJ2L/u
	 BrEqxSvLLXz+5Qz6Br/ahAe/YTh81+ehE0Vp2uYFjPPpQ8xnFKD0id30o8CZqTvO52
	 qGkMt8YSDB+zw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 136567E747
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 14:16:41 +0000 (UTC)
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
Subject: [Build #32114225] armhf build of rdma-core 62.0~202601061326+gitfd8657625~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176770900107.1103073.16844407588799705693.launchpad@buildd-manager.lp.internal>
Date: Tue, 06 Jan 2026 14:16:41 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 6072d39fd8eecc1542c4b7ccf907796e2aea8356


 * Source Package: rdma-core
 * Version: 62.0~202601061326+gitfd8657625~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 8 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32114225/+files/buildlog_ubuntu-focal-armhf.rdma-core_62.0~2026=
01061326+gitfd8657625~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-098
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 62.0~202601061326+gitfd8657625~ubuntu20.04.1 in ub=
untu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
114225

You are receiving this email because you created this version of this
package.


