Return-Path: <linux-rdma+bounces-3331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B396590F218
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CD2B22D4B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D121132112;
	Wed, 19 Jun 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="h+UDapbk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F59182B5
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810839; cv=none; b=SX0aeQwgQMKCTW1xGo7GMH5xA7/rS3Xuck5QyLEh9VYichHaTA1/b5efaJ3lmc00Ih/dtFU1siZpia6Mry1TzERra2qhakeLHHII1M7hOIepndnay71VabEmBQXxOzaloU+7pSNHKAxqtV/H42bb2iVkWiKnnnWrK9NyYZflAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810839; c=relaxed/simple;
	bh=xpLe4MK7uSuSxl4fhxwLOaygTGRB3/HIDr9pUZChuts=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=DYDQOoNKhtFztiCUeW3+qLMspW4HtP89QBGP3T0OYanDKZaKc4hVe76kqOzWKjhC/A8t26zOqg4bcowRouTObODV6dabCgAiclHRMAiQdfpxvplxyaHivZDlPXneowU3HzBtMcJvKWvC05aTjnjz2SfrjF4Xf88KAO3dsghVF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=h+UDapbk; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id B9BF93F284
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1718810835;
	bh=xpLe4MK7uSuSxl4fhxwLOaygTGRB3/HIDr9pUZChuts=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=h+UDapbk/ld7fR7zwC+ZOHgmVIWzfn7V+sTwecZMhgTxL5Q6ciEic+nDRXVJ/Q5kg
	 iaXj3vY3xoc7ZdikOObnhIR0KKgpKZ9bWFRiL26Aub0IYY1LCu4AFm7DRFjbPlhuxU
	 PKApjzWzb62/7w2/TJsNKEBGAJEArnKuuEa5YraRyvhNJsqMu2g9U+fBmfxwkWnLF3
	 fOjY2eEhFMp3yCx9s+vEAfaOVhED92DdCcu6dXgt730HphsT/FpIftbB9IUi05dh1V
	 MO3/nioRLf2xXNSIH1GT++9iqQ6mce6WnoIReVgG78DU515afYgE+ej5mSLiQF7zOT
	 EzS+iA0O3vFdQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id AC5927E236
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:27:15 +0000 (UTC)
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
Subject: [Build #28590807] armhf build of rdma-core 53.0~202406191122+git367ba330~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171881083570.3727353.2826594901534242411.launchpad@buildd-manager.lp.internal>
Date: Wed, 19 Jun 2024 15:27:15 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 3d8ca69fc6384773ee5b6e5b6da705713fe0e357


 * Source Package: rdma-core
 * Version: 53.0~202406191122+git367ba330~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28590807/+files/buildlog_ubuntu-bionic-armhf.rdma-core_53.0~202=
406191122+git367ba330~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-079
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406191122+git367ba330~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
590807

You are receiving this email because you created this version of this
package.


