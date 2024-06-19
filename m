Return-Path: <linux-rdma+bounces-3332-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0705B90F232
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF7E28438F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 15:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CED5224CC;
	Wed, 19 Jun 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Xbvv8+Mg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23BF111AA
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811183; cv=none; b=iyQD92nk64eG8ZQZtnGF/V6nRtkQaYraeoVrCc8qh++sSSmnsgemLq8lfOV3OumVzddJedv1kHc3XPj3yFZS1/Ctk2mCI2LtSd8hnmqn+L0ny7TVd/sNvix8tgTVmqyZ5m66YB9BMKYqz+rD/qbeVjQgZyKCNYWmrV6rlwRqh7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811183; c=relaxed/simple;
	bh=g/Ap0ypqLytXIBoSO9wcyDBfUukjo2J4ynDels+I0jw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=D8DnNvNcLkZ8n9g5StrNerwNbdnhRtjI5LE1Z87G7AAG/q+B4Hy4wR2Pbu8miawn5zZ+d04ZsHccQ0aO5OgY1pL3pUVedwl1SUs8rSJLUWMAOentL2Vp4xCRg08Kzd+CvxMCDy8ZIdiYUE98lQt5i1bwJ5k5VMZm75WwS31JVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Xbvv8+Mg; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id DB4983F23D
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1718811178;
	bh=g/Ap0ypqLytXIBoSO9wcyDBfUukjo2J4ynDels+I0jw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Xbvv8+Mg6llxXbTmSYIJ4n089M7VKaBzfVerUSDOXteJzJnWF4MdgHhaWipfFZ1yO
	 Fbm/7Sq4lZDcCIWRh2K01m1IMo2fn/zx0vRXdpjrUgmZuTw6vQwcIblb+e311QWos4
	 jAxoP9+FkssRTiNk6CFZBzhS0Z0kM49n/dVHZAZ/VM8jficBbw/w1TDDeWX5BD9mOr
	 n0ox3M2mAmTavXU2xEUxsi2UZ9ehEvUNOV/DeBPK9UTV17DvGvza774WCuIWN7RwoN
	 Ba9tVRpty2yif92ku6XREodFd0jF8esFWqQZ3xbeNMkbuwMzUpC0WGTHF38ewEtBa+
	 m7X/wfrpiVlng==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id CFCFB7E236
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:32:58 +0000 (UTC)
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
Subject: [Build #28590813] armhf build of rdma-core 53.0~202406191122+git367ba330~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171881117882.3727353.13715922174566027370.launchpad@buildd-manager.lp.internal>
Date: Wed, 19 Jun 2024 15:32:58 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 42bf3048be98bfd842cfd165fc5ce041426b3c96


 * Source Package: rdma-core
 * Version: 53.0~202406191122+git367ba330~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 11 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28590813/+files/buildlog_ubuntu-focal-armhf.rdma-core_53.0~2024=
06191122+git367ba330~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-061
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406191122+git367ba330~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
590813

You are receiving this email because you created this version of this
package.


