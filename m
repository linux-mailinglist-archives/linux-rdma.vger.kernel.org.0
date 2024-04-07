Return-Path: <linux-rdma+bounces-1816-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697A989B04F
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Apr 2024 12:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604BF1C20B7B
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Apr 2024 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E01F14F78;
	Sun,  7 Apr 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="tyDteH2z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC413AF9
	for <linux-rdma@vger.kernel.org>; Sun,  7 Apr 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712484692; cv=none; b=UecPtiGoAYyI4l7p/Olc65zypSrCQUYzSNdL1SMM8G01OwKeYwbz98ZMymTKxJqFNYt1LzZGGtUYIo4x9kPf0z3Pn531zpmU3vQ8i9XifV96YRgbu1GPoTDd9fvgKCUZ0cHvseKEQRqrFshxv42aVTMAKRl6RLoIK4qEjGB6Ofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712484692; c=relaxed/simple;
	bh=emTEYsHwpdApFR9zNitQuUS223wa9qqtPXYsdM2dwTE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=WVj614Wjr7F7XhX1cBO65HL4nuapqMq7F2o/pRt7x2o9J4C6BCT8XvJKh1Z5UFrdEHpni1Im1jibc5QEKpZCN0Bv+89fkWqh1Ug/xIKxki+3raVKSEeXuMQfDM8LrLe2E5ptVfvQVK7+JpxnU2QqDzew0idWi6dcPiCOzjl2+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=tyDteH2z; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id B7EE93F1A0
	for <linux-rdma@vger.kernel.org>; Sun,  7 Apr 2024 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1712484688;
	bh=emTEYsHwpdApFR9zNitQuUS223wa9qqtPXYsdM2dwTE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=tyDteH2zDzFL7rtjn541qusNqcR9Y77fbnpqRVfJYj05s+A7b7kfRge7kguo8qjBs
	 MMIBWw116BiJeV0rya4KT9nBse1iK2gQfQ0ISM2OlZEJmlc206sm4W0+YNXEpVYbQl
	 KxCMqTv53IoZPV1i4FE+9BK41aW8fKvm0O53Wgl+vP5sYJPGJy+24uoDEWM8+fbxCG
	 kBGy3Lg5YYZ8wa1I8GygcxDREzJqtkRpNMQOHFpns9Ifq9zKjxmBSggXPlVD6Lc/V0
	 3hKIAaE4fpYmkx+wTuzKYqpB29Z7vL1iTMp81vyvThExDJOD3cIJYyBmzLWMIF1lnY
	 ivD8utRz+AuoQ==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 9D8EB7E231
	for <linux-rdma@vger.kernel.org>; Sun,  7 Apr 2024 10:11:28 +0000 (UTC)
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
Subject: [Build #28030858] armhf build of rdma-core 52.0~202404070746+git8364b11f~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171248468861.1551173.13616499325959079113.launchpad@juju-98d295-prod-launchpad-15>
Date: Sun, 07 Apr 2024 10:11:28 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 125d6b87185882dd45a6e0f80eeeb8debf61da6c


 * Source Package: rdma-core
 * Version: 52.0~202404070746+git8364b11f~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 9 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28030858/+files/buildlog_ubuntu-focal-armhf.rdma-core_52.0~2024=
04070746+git8364b11f~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-071
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 52.0~202404070746+git8364b11f~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
030858

You are receiving this email because you created this version of this
package.


