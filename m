Return-Path: <linux-rdma+bounces-14325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D83C429AE
	for <lists+linux-rdma@lfdr.de>; Sat, 08 Nov 2025 09:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC8B24E1BAD
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Nov 2025 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348CE2E7BA2;
	Sat,  8 Nov 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="uvUDHeYt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF9199949
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762591404; cv=none; b=QYX3IbmMKZ8sQb2mMjkraoAHp0OoA5MOU21zA1iK4PGR6QuW1XZIFciZ2Ilku0D+VkMizzEvndPOYPZLWxnu4/9PMkGzA8Oq/z41lOJ2mAhs2hMjT9mYl10DKCsldqW/dyMvFBkYN8dyRXBGdux4uUduyCKYKYgQJ0mgfgyPBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762591404; c=relaxed/simple;
	bh=t+BvriIVFjPUZGe+jkSDH1ST4wjD1enf0ZSGK69MCQI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=hTahE2eJd8dW7Z2LMj/l1nNnogMeg54jJRVeSP3oRO4eD+67iZnFasBKSAFehCYFhOGzVbx/TRJks/yV/LSUwbEzRhH7MYs+EdoEBrQxUS1utmLGOLL0xZZ9pRsx1QQhxHoahvSy+JkJMO7v3TAgcVrMKKitbk2kAmKqTnJdc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=uvUDHeYt; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 21DB83F055
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 08:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762591394;
	bh=t+BvriIVFjPUZGe+jkSDH1ST4wjD1enf0ZSGK69MCQI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=uvUDHeYt3U+HagqP3BqC3UtT5gLAuZetm6TxDBz+M4C1/NqjBlm+f+UaRrczpiFxg
	 aMCMFyJPOF2v6WBMyHcNst3muFi8faYZM6XzUy+oXa9cHIE+rX2d65a1lXh5VwewBa
	 hjyIV8HIEJTXKULdVMpgx6wutxUEnlvXd7L40NRm8UOVk4/bA+YB3jr3Wy6Y3xCJj2
	 6V4Teee8/qXIlqCXWr7hQ39tBflFrbTv0Pcaj5Oyjf94Lzm3Rd7+C6tLB5qafh0/q6
	 m+dTaQT8C1U11qFF1XDj2B1aPF9bQy9ZEO+WLAdb//UOvQdk8VN6/QYs0OrTofkKY3
	 pI4xGJBI/2x0g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id EE2F87F14C
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 08:43:13 +0000 (UTC)
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
Subject: [Build #31473530] armhf build of rdma-core 61.0~202511080232+gitc3d6991a~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176259139395.1218157.4010204614735636450.launchpad@buildd-manager.lp.internal>
Date: Sat, 08 Nov 2025 08:43:13 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 04c727056fa082d389dc53cb9695a9e5b381b640


 * Source Package: rdma-core
 * Version: 61.0~202511080232+gitc3d6991a~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31473530/+files/buildlog_ubuntu-focal-armhf.rdma-core_61.0~2025=
11080232+gitc3d6991a~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-021
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511080232+gitc3d6991a~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
473530

You are receiving this email because you created this version of this
package.


