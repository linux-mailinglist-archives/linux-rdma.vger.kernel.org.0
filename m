Return-Path: <linux-rdma+bounces-2903-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75008FD136
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB67C1C2256D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DD32836A;
	Wed,  5 Jun 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="odc8tUi4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B819D88D
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599229; cv=none; b=b8CkCoxlronxWcWg5uhfYgclxilDb9aTG0G5fOswr7IgOLyIFkYMQyeU2GSsAOVS9sKX/QoxEPKwBbmNPTReT/JW8j+6f/eYQcIml8fTfl9MjI0AcNWO9mrPe90bMzBOQDZAe8BmoB1nSB4n1UokOvg0poqpaH6gCkdg3A0ZpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599229; c=relaxed/simple;
	bh=jZShF8MbXhEGNC9lMTRUMIuNX5b3WdpDswFSyflVqC4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Oe4NReQkyZXajlqQ0ZUz9a+Zj3+to0KuyDx14Ml8lmCD6v33HQHo/0WdTOJJHlvd+Ro+0q4w0GQWpdQBRQ1UEFa2ofE031Q5d0i0lkbKonGKyIecjez+xgTsT5hCxBtQ/clcfQ4VTjusCP/vb8+uKiOXh5jI0ilcXJhHQ2sKMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=odc8tUi4; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id C649E3F07A
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1717599225;
	bh=jZShF8MbXhEGNC9lMTRUMIuNX5b3WdpDswFSyflVqC4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=odc8tUi4elwJP0DECSXVuuYdoNpvbHpCHhsSd+n+HdattmnTNrqj8pdquGtLM1pba
	 1hKFQ/pJJHDSb9YhMrCh+rKv4Lem81i3ZcpidF6CTHGTudejFuYp5DSrOjjylaWEB2
	 cUojURVmOwHkxycuYLtHnLX+x7EbDJhyyXN/gpUVKRkPTNkADBgJKU7O8K/Y/IODhx
	 5EeiipSP8n6lbwvLefuBuwOMRqR3lviDwwoMOJ8Li8fD+kVvrRvkIW9vY/Pwmx0fb5
	 ZOXdrhUu4fhsyjthZjxbe61kQ9MVc7ufZXofbZWOkE/KPmhuphWZhwT15jNfscyKig
	 qT8l7LCymbt3g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id BD3A47E236
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:53:45 +0000 (UTC)
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
Subject: [Build #28518780] armhf build of rdma-core 53.0~202406051209+git1840c1b7~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171759922577.3361349.3995280069323362839.launchpad@buildd-manager.lp.internal>
Date: Wed, 05 Jun 2024 14:53:45 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4d1350fd3710dfe10d207fa9961e224cc481dca3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 6552e026a45687788c6f126884c67ec97dd2c161


 * Source Package: rdma-core
 * Version: 53.0~202406051209+git1840c1b7~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28518780/+files/buildlog_ubuntu-focal-armhf.rdma-core_53.0~2024=
06051209+git1840c1b7~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos01-arm64-006
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406051209+git1840c1b7~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
518780

You are receiving this email because you created this version of this
package.


