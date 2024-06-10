Return-Path: <linux-rdma+bounces-3033-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD989024BD
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B591F247BD
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DAE13E3EB;
	Mon, 10 Jun 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="NPMH6e5s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B619132113
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031362; cv=none; b=pT3eygugfliUQX0v7ZoA7Yj/YUHF1diB+2ntkciOgwtJZXexzGOX3+5ZqhLl074TNiGHfnhBxUzy4vm/ezgiZsKSPM+TdqT9eiEbBSscW3b8w+RcuQya3gaz907r3PnjcWFHjSlRWYy1jJxGViMoq1fBg1Y+5811v2L9Ah0w5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031362; c=relaxed/simple;
	bh=WGV2E4+WiNvdzFhauf35UYS+sXFul5hvpO12dcqOcNE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=belBvnuVox4TrWoF8f4e0xwF+Wx7Em12DK/6uX5tjNYY7mQDeK3lSQD8lmuc5ATCyXYOhPVBacUy7fPl3m7nU+dY1NCR03UadtpA5MCpwBG7D20KhCriXw7XOzTfwL2LjFb6TXLrNBddYpPe+D7kAHI10i7yAJAMbdF/AvruO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=NPMH6e5s; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 4B0463F6C6
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1718031353;
	bh=WGV2E4+WiNvdzFhauf35UYS+sXFul5hvpO12dcqOcNE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=NPMH6e5s2jII7+oRiKzBgCy0Pqn1+rpQrAr4lIGApfhnQbEHZ36XPwRCXqo3+yGAu
	 pTxo4ac09ZKC4u3i4kXNbZOENCyRD8nlTqcqggoONmGvByBHprff61OBcku6TrTASo
	 5276JbRlRGKRFXkFXxJrIiKCWcQbPeQrkCCvEx8+9w0z0ZUtFk+PgXpxsnVdUgBHvX
	 q+/K4pe7fYAqgJamW7PqyZ9BvFQOY2PgsDBFPytmo2UYTLUD7BKYQPa2yNeZehpDFt
	 1b7eBr/mQKopOHhmmh5SE+a0Kp3gY1SgWfE1BHbMnZBCi/voWLakSJRfAlArdJjW9X
	 DMq6MamwHdtJA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 430AB7E248
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 14:55:53 +0000 (UTC)
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
Subject: [Build #28567148] armhf build of rdma-core 53.0~202406101038+git4b429243~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171803135327.322650.6276202810412585337.launchpad@buildd-manager.lp.internal>
Date: Mon, 10 Jun 2024 14:55:53 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="7020100bd22578495a0a6fd39859337d4641b57b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ee4b74bd5e19583d9c01ee97e7ff8d7fb6161c45


 * Source Package: rdma-core
 * Version: 53.0~202406101038+git4b429243~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28567148/+files/buildlog_ubuntu-focal-armhf.rdma-core_53.0~2024=
06101038+git4b429243~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-027
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406101038+git4b429243~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
567148

You are receiving this email because you created this version of this
package.


