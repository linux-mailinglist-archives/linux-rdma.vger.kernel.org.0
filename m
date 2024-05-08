Return-Path: <linux-rdma+bounces-2349-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50BE8BFFA6
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656A9B26FD9
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D284E0F;
	Wed,  8 May 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="S63TQqWW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9C84D3C
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176834; cv=none; b=gKx8Uj6213lWzicsFU1iBilmMDXfJZiMDMa18xcVy/GcNuCc9PSwOwlcrreydVvQ/j2LMIFiGlIDccx3mGDFzkGVPEjCZuqTyfdZgrLBhYzZq/AQ8PvnWtyTFlzbRxIvm08iFqAd/K/HyF3Fj+SIlqxjgGN4NMF2Hrp+bapX97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176834; c=relaxed/simple;
	bh=lpZ7+JKxaIW1yAHCTZU8yq39DpeJdP6qo0rYcr0DgLw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=YpbNilK18cqRBUVU3Z9t+cwxGLRGQImB9eflBxCEKx2f24ukmigPB+Zy5diJdlGwswA/J22/jK2TfLP9kekDDmkFo+RgycK6hCNUXwhfox5vdFjg+ys3trXffR0un0S9/vOM8zhgLZkcGZIUW8JlA94sdznLL4CTFm1ApVC5tCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=S63TQqWW; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 52D764142B
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1715176252;
	bh=lpZ7+JKxaIW1yAHCTZU8yq39DpeJdP6qo0rYcr0DgLw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=S63TQqWW/9XTgyE2ByVowhJ/aUHP0N2ByzvQcoGKLTEijfMHnzAOljEL65kUKB1Bg
	 eEAwFUzHr4q1zEVjUzmVkfcTjU14iMUhQYx06hWU/GxVLMgdNVr1HhAupHsOjJgDgz
	 5Q09tQoLRbh6F3l8gDisX9xwQnmejb7h/3kmpUaOH4uFg8m4WoUzUCKVfuPSuugWFm
	 lLnbcJuN3QjnogC31x7hs8NSsAdB50kZWv8wwlmo+PDk6cz78/9ddcIrXnIqzZXrzy
	 PoxHMtGaT8KwW3smNES+BEkLuFnhaXJpR4eol93Y8+BnBkG5Ha7q9mj1aYPVOk9Er9
	 9PqepCYGKi9ow==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 2D6F17E233
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 13:50:52 +0000 (UTC)
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
Subject: [Build #28428495] armhf build of rdma-core 52.0~202405080841+git311c5919~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171517625218.1886921.10651044483497272861.launchpad@buildd-manager.lp.internal>
Date: Wed, 08 May 2024 13:50:52 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="f33e6521bc5e85148b1c93453be6e27c66f3b541"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5312cfdbead553408732a57d10228c5f36ecce9f


 * Source Package: rdma-core
 * Version: 52.0~202405080841+git311c5919~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 11 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28428495/+files/buildlog_ubuntu-bionic-armhf.rdma-core_52.0~202=
405080841+git311c5919~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-005
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 52.0~202405080841+git311c5919~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
428495

You are receiving this email because you created this version of this
package.


