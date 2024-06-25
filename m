Return-Path: <linux-rdma+bounces-3482-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA29916F9D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61233B245F4
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D51177990;
	Tue, 25 Jun 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Tq/iGwE+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DB176AD1
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337937; cv=none; b=f8bTh15G9q1Bf6IDGQp47Mphj1w3/WHe+L6iVeQfZNyZL9gxq2Sbiq+Vk6ZOB7pm3y4v/Cj+B9EEdXqpjGr+cmpvpg/5J1ARVQsJvoOVHBtjCER0BEa6ZaslEuVsnGqPbhYvyarloaNDrTyVwsd9Fo8aSjVb/MnaLAm2Qthn0Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337937; c=relaxed/simple;
	bh=GohNHbhAQnQQLXt5Hnx/HZAVqkRyv7cdd5FxYrt4ds8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=HmIK/CCsl4s8Y5RAndaTffV82B3xGOXk6hl1aEj2E6cFoUlANeBEe/RUHhMnEeNuKLcK/u2XVbUZqwl6omj6BsKN7Ieqbr5rDn1vfFpRPWDM1PVCoMWcP+f40ccWzrEgAo1qsC8/b9LxoBhUj9UReP0hzCzwEL9pJddAY9HC600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Tq/iGwE+; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 0CD5B3F347
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1719337934;
	bh=GohNHbhAQnQQLXt5Hnx/HZAVqkRyv7cdd5FxYrt4ds8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Tq/iGwE+GCeyPgAcMcu+gcwPYRRwdRkJ3zs2bmRCV37NW3jQ226cB+sitoGxsFsvR
	 WkTSVWUejSfGjArWgRahiOV4zLSi9UA9OwsxY0wmZD/cX0XxZyYDfqAkYbTlamtFSf
	 HpEmlQMlV9sbey+aPHnnrKX2auj9tv8k9u51zujHb8/tYMyoRqpbYryK+6DvE3KXD+
	 rbMuT0QqdSCnaIyDabftUTNJ2blFxJqKMewryMRuuzLZf2FdXWl13ucwMQEh4Ge7LC
	 9S4ye8ftdT+jc63fhEvmUHSnjiVoLlrKaBRkMTzRk1yaLyttKsUPv0RmyL2qpPbjpT
	 Ow1MFKshv+vpg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id E91187E252
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 17:52:13 +0000 (UTC)
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
Subject: [Build #28604920] armhf build of rdma-core 53.0~202406251104+git4d318e35~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171933793394.1839645.14319325135234438136.launchpad@buildd-manager.lp.internal>
Date: Tue, 25 Jun 2024 17:52:13 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 8c5123ab0f15252126ad0742fd1910af5e0090b2


 * Source Package: rdma-core
 * Version: 53.0~202406251104+git4d318e35~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28604920/+files/buildlog_ubuntu-bionic-armhf.rdma-core_53.0~202=
406251104+git4d318e35~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-018
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406251104+git4d318e35~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
604920

You are receiving this email because you created this version of this
package.


