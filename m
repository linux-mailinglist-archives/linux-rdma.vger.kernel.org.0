Return-Path: <linux-rdma+bounces-14450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49225C529A1
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 15:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB8B64FB977
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A41123D7F0;
	Wed, 12 Nov 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="A6DuQMz4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A098146A66
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955686; cv=none; b=mrANSmdE2SCVwytoQvss7/Q21/RqqOjtTNwq0WLgWmhraZMnlDS/uJ8QD9e896Y+2jclkbYdFNaI0W8bt9ORK8+W9DOBq4L2LHTt+8KVe9ywfY0imsS/SvSVCFaN+5RPauwhy6nF3iglL7YLh2/nWU9clhSD6pvwHsyXFv+KM5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955686; c=relaxed/simple;
	bh=U4EX8qESUpyzLUBFqenFwPBCZM4RGz5SDm2xUZrMPYk=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=L3HOham+KQeaYv2fgL/zaH/nWKV1sxeHUK0Biu/1kkacFsXhASHa9bG4zBkcGVCysQn2dibbpSCuDeOtWygiTmgccg+HDVXZPAUENWkXP6Ah+HZWWcvrZuX9IySypY7R4Az4SDjfwvajm9B2m/Im6XA9Jt+kAP4N0tpPg2MWvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=A6DuQMz4; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 13E9B3F263
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762955682;
	bh=U4EX8qESUpyzLUBFqenFwPBCZM4RGz5SDm2xUZrMPYk=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=A6DuQMz4PKyYnF3T0mmmrBG3BMth4I8FGnVMgb8S7tEMHDT+niU7JBXfzFeFE1x74
	 6E9jzes6dzH15bvbjbIOLkMjvnXeBZznLg0jYmmul7ZV8IBzl7qiIY1MuB43UPxhAP
	 h0zpe5/9jgs1+lPQDW/lqXqxQxb6ek0ijIQpcj2LRAVuKZRF40wC8BobYg069t/9yV
	 54r+yo+rBFBRFDGw+Ly0nsAy59QuB5/RSz3MGtqp9tVNbfr+vqldjlFKWv1GH/ao/0
	 LGKiIBDj9niq0lfyIi6S8bdkGEDtUXaOCOpLMPKDDlIiVhqAHMCm60l9F6b/kziWUY
	 ZbdBz/FqIVIwQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id F3F627E982
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 13:54:41 +0000 (UTC)
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
Subject: [Build #31483551] armhf build of rdma-core 61.0~202511120819+git7528827b~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176295568197.1218157.14923688536814205544.launchpad@buildd-manager.lp.internal>
Date: Wed, 12 Nov 2025 13:54:41 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 588c0dd8f93c2e112bd5a940d3d9f519a6409f91


 * Source Package: rdma-core
 * Version: 61.0~202511120819+git7528827b~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31483551/+files/buildlog_ubuntu-bionic-armhf.rdma-core_61.0~202=
511120819+git7528827b~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-072
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511120819+git7528827b~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
483551

You are receiving this email because you created this version of this
package.


