Return-Path: <linux-rdma+bounces-2782-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BF48D8481
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F10C28A70A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250112DDB3;
	Mon,  3 Jun 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="TAgzxJXI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E71E892
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423134; cv=none; b=WrgFjxYLrLRz0o9gWau1da1E6+/C/dmoUJttqWGV6944aK9yNk4Z/xZGsBfvYjsmhSd3L2W0r9rgtfb1I83o2eRqWfsxX0fyJYj54zsv/9fVrdCszenpFEFCT2DGuLbV34ULbz0NsAu5MNVRnhsSKHeNDBAcz/6qy9tCsNtZha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423134; c=relaxed/simple;
	bh=va3924wBqKNYek4GVRJciQJ2KKVcFkGGac98rcp69zQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=PP4pB2vCvNbbyPvw/+nlTowRwr4qhaF1PJUl9D4L+MrhAGPjPHDsDEnQ8n1psQMlS8DhTnWKl5P7+YLZ5fNKedmuY368qXQyS3VzmMXGIKQ5cA1lgSOva3+wVSsvIGe0gkR7H/B5UpG+/RlQC68xB9jSdZ98o4ufyh9dsZBRTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=TAgzxJXI; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D6CC041F50
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1717423130;
	bh=va3924wBqKNYek4GVRJciQJ2KKVcFkGGac98rcp69zQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=TAgzxJXIDSfx9vPGovpqRtKJdkaNqWlPPUoo+j78biu/pGtCAXvsTjDG/xHq61cMT
	 7ZA535ODy0hzjkjI+8skM+TRs8CRnwdA3w58UCiqdk9H9zpg676HYqo4XQWBucMWhD
	 OFE29r/GTbyEho1hFhy4vVFUu2/+E0RjB9ZFszV0h9FH7lNgSv6h5RP/lILBKdRbCC
	 GsFZdvrCkru/+1S9sufibrcKtHarroBz3som8vPscTSNdb1tWBpsja+7ZcsWbRtVr7
	 v4yXDp6kMkUin6+2/ZEA1Wsg95ca7fdSj6ENGPCzXvH0X2sCwK74GrZG7V4vUqnyxc
	 hgR69J/wzA/xA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id A867E7E230
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 13:58:50 +0000 (UTC)
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
Subject: [Build #28512733] armhf build of rdma-core 53.0~202406031027+git4b0c93a6~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171742313060.3361349.669319836543453786.launchpad@buildd-manager.lp.internal>
Date: Mon, 03 Jun 2024 13:58:50 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4d1350fd3710dfe10d207fa9961e224cc481dca3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: c410a8b29558d9d0cc8538d4806ca40badce6eb3


 * Source Package: rdma-core
 * Version: 53.0~202406031027+git4b0c93a6~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 10 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28512733/+files/buildlog_ubuntu-focal-armhf.rdma-core_53.0~2024=
06031027+git4b0c93a6~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-010
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406031027+git4b0c93a6~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
512733

You are receiving this email because you created this version of this
package.


