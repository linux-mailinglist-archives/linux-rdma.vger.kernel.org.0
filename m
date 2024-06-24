Return-Path: <linux-rdma+bounces-3433-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B7E9148EF
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 13:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD961F23311
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940B138495;
	Mon, 24 Jun 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="r6WeYzIA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB313A3E6
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229117; cv=none; b=GHVDSWwMgyt5pcmlsWZ8yNmN64lpRlUTXhFladabd6w80udtWg7G60VGexDShS1Fx/PmHZa7fWYndJYski+f08gNbWOeAU62xM8Omxx5bi4z4WMS6XBuURGk4maFHbfN6ZEJvs0uAzMGKNUKwfZUbdOn6Vy3qiZSfoPbme/Gk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229117; c=relaxed/simple;
	bh=1enphMuT7054E8RjbXr/H3pg400FGRsyRVOxWyZtziw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=PcjWSmTiAm74HrAzhPrT4AR7Ut/4CRYygwaTTBmpNs+YAD2kZ7MImZqWWUqf+ssar6gBAGCfzRsKBOYj7ctKH1e+v02Q7U/wQuz7abtrWzdu/QAcJV7tE1ANfSkSvvq1Ay+nZ1JIsf96FU7J1pO7wtca8F/BPUP0LQOZPc9kE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=r6WeYzIA; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id C090641A98
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1719229109;
	bh=1enphMuT7054E8RjbXr/H3pg400FGRsyRVOxWyZtziw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=r6WeYzIAWA3XpFIor8KBHdCkjdh2QFmmYmC0mO5mR4T2G9Cv5Eb3uRn1xHerPU8t9
	 ALxtRuB/QHuMKdIpKeZJXvn12QaF3/l0iV3VHeoIF9E3swyXNX50KVmysynpWBQPnI
	 3JxuZAh96dJJtz7RM2bg5ZCxEjnBlLXwH/L3tkdFW54CCmuXwZXK7lErL75iW8DQmd
	 ueUZm4BWT58W61dDYRl+6b2M6Q7elWiwRde/mMO8phDIlHSLaeGzYBZkV3mUSRjGCu
	 dpFiYPDsY9ZvLfM1U8dfcq/VdDa3xcy38zQ6qkjts+EjNbFr/ZUihQej1XNZ1YMtXQ
	 l94KC80lX042g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 9C86B7E280
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 11:38:29 +0000 (UTC)
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
Subject: [Build #28601322] armhf build of rdma-core 53.0~202406240732+gitb4018780~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171922910961.701.16447989059184860646.launchpad@buildd-manager.lp.internal>
Date: Mon, 24 Jun 2024 11:38:29 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ddc3cfcec5cc51ef5834fe066160d811604203dd


 * Source Package: rdma-core
 * Version: 53.0~202406240732+gitb4018780~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28601322/+files/buildlog_ubuntu-bionic-armhf.rdma-core_53.0~202=
406240732+gitb4018780~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-002
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406240732+gitb4018780~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
601322

You are receiving this email because you created this version of this
package.


