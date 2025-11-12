Return-Path: <linux-rdma+bounces-14452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C4C52AAD
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 15:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1743B41A8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A623EA96;
	Wed, 12 Nov 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="bpLgztjA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B622A4FC
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955794; cv=none; b=Y63UI8hq7jrCLk+KZfsj4HHDuDBqqFFOU+cCJ+cQMxRpg3Qkk/ZBMuIYtQ0oQRGp9DsWFbukD9yyCpQfH0Pz3ZBphAcrZo8NBWXp0cXlm07H6Cjyw3EOOa9c1TXEOJSeJ7BcaAbkRex3eb+zdpfJ+upGWsYdKLY/PsaHxcC2LHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955794; c=relaxed/simple;
	bh=3LcT0gPp+dC3cs///MYsr8SGXVixlb+IM3cvKkrMw4M=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Zes2JDJAf3dvKVBluXJh8D45tEhKoJ42LDMuU1cbGrg8466wML+vb+EEVYuawI+/hprm2eo2AHQzmBoksEHicpbrqFhirpO2Ctplo3nDgk3s21zrdhtQqyHylyl96uh1TCYMxNS6YNItiWQ3tSHqyev6G9yvsMKlWUpVAt9Om2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=bpLgztjA; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 294F640EB0
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762955791;
	bh=3LcT0gPp+dC3cs///MYsr8SGXVixlb+IM3cvKkrMw4M=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=bpLgztjAAyTA5RFR7DSMymnQy8GPobdiDLrCrgxpPePT7JdWP5VRgAC8mujgAYhUw
	 4EYjOn2BsPInRCQIOtaD20H1pLk2JZfg0n+wlQa8tYy16DzbpDpOFzGaaZ8FEauzUD
	 iqvO6lhRloMR6Yu9UehdOYDYun32lmX9T2kiV13CeBhABdijQK5X4PoXZYQ4eGqsBu
	 bmvvn9Y51FnWX1KjjbpXKfobsgTL7VNhVfmmbbj2xEe+ATDgn8JgOLYthH+XL3QG87
	 SiSjgeZKz9QTdcOQ1H15Z4xcoakQeL2T63D1eLx0Wgqwl9tfLGJ801v6y+qxawb5Jh
	 RvcidOFVsw6Jg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id F28AA7E982
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 13:56:30 +0000 (UTC)
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
Subject: [Build #31483543] armhf build of rdma-core 61.0~202511120819+git7528827b~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176295579096.1218157.6034167137878024719.launchpad@buildd-manager.lp.internal>
Date: Wed, 12 Nov 2025 13:56:30 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: fef7766c6cd2502a20f27215b78be972793c8543


 * Source Package: rdma-core
 * Version: 61.0~202511120819+git7528827b~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 8 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31483543/+files/buildlog_ubuntu-focal-armhf.rdma-core_61.0~2025=
11120819+git7528827b~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-116
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511120819+git7528827b~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
483543

You are receiving this email because you created this version of this
package.


