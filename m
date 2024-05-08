Return-Path: <linux-rdma+bounces-2347-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A52F8BFDAA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 14:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA711F22538
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 12:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A447B56B70;
	Wed,  8 May 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="v+qlQrsR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337FA22071
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172651; cv=none; b=aLE/tphwPus7MP2fvrU/358wCKSVayrhlHNd6mizdkslC+mjSmMGe5W1y3SPvRhnnoKATE9n4svsLYa4KR0K8bfCA0kaTF82QRcIzt7e7yzFH3rGPOScaex6hSMFlXMoKMBWtJkA6Vb66y3UZhzlQbLdR1aPmfvqE9eO3YspO/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172651; c=relaxed/simple;
	bh=izJsFyyIPgoA4hISy/qu4DSI7o5FftPtIZBdjO4GROY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=BHJPPtM9+y/OdXuM2i4cCW8D4PKh1TiAjj3gA9SEpGkKFQfA8FnoBMFZCC2RfmKf90W6CjIb9RWaQzeWCEUS8aE6/oH3uDhgSfCVFarGIu67rOoAVd5lgbzIIsg1d5zVCVMhGv3dUIJOrYrR+rsldbD38i24WDjta84OSAnWE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=v+qlQrsR; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 6F76445FAC
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1715172635;
	bh=izJsFyyIPgoA4hISy/qu4DSI7o5FftPtIZBdjO4GROY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=v+qlQrsRC/DZF6FiKZDMBrKczMS7XVb+hJf0mVtBd+XWAVdDV/WMVZCuXQvdkSInf
	 YL9T1981tcb3GT2DynE1AZTSSbxsGRuEXg2Y6oKIhN6/jTEKw7wWk1w8dhho5+zkr/
	 Y9MuyKrriOuociC2J9HSo48R65hxpyZYzE+EPbCGrl6F0uR+8Un9ULbfX7nCz4C7GL
	 Wkdcx40E5BdiB5BSlbwm+1o/9xV8fZ5SM8GUTa1l9vaF+yYPIjmS5rJ3PymagKHkUA
	 z9fpU1gd7Zn75dlMYOok/i1jUIipwbi9bInjhtl+DWpe+Bs0CNB77Nau+ezI7VD2tb
	 MpNc7kT5s4Txw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 5B1607E233
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 12:50:35 +0000 (UTC)
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
Subject: [Build #28428482] armhf build of rdma-core 52.0~202405080841+git311c5919~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171517263536.1886921.9781732472464414693.launchpad@buildd-manager.lp.internal>
Date: Wed, 08 May 2024 12:50:35 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="f33e6521bc5e85148b1c93453be6e27c66f3b541"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 42313b48f4f304af4e9012ea67099598a33beca4


 * Source Package: rdma-core
 * Version: 52.0~202405080841+git311c5919~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 10 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28428482/+files/buildlog_ubuntu-focal-armhf.rdma-core_52.0~2024=
05080841+git311c5919~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-024
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 52.0~202405080841+git311c5919~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
428482

You are receiving this email because you created this version of this
package.


