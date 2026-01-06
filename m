Return-Path: <linux-rdma+bounces-15327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF585CF8B74
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 15:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D90930089BC
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F183126B8;
	Tue,  6 Jan 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="cjwUD3J9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4B30EF90
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767708950; cv=none; b=mbNFPL1BfMIt0a6CNVD/J4Cdv3WwhWHdn79xmOTcyLlEI6T8Nx24LbT9mAFwfvlT5AFCrbF/3g1MLNbK2AfQnmS5V2b/VFdaFTsxLfSBo7N86kb7b4K/eAsX9NRyrlvbPDN+FQCSPYaQ/F+bwnz+6zdwSgZ+ZeoXo0UxDH34LkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767708950; c=relaxed/simple;
	bh=5a8oSZR7T6zfoiPYxDP2dMFgpg5IiV+4WmGgEJ094Os=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ILksvrCByVCLRYupRMiexhsJb6z2fkDqUk8V09U6kJiPX45wBu9ltQuv93GlQz+wVr0/OwbaMxcfxOInUB6geP9umvZQUJMWB2cIBRF4Jj+qqu/KAbd1mygC/smuwPNFgVlTSpn0Mq/DFeu6Be/yKWZYpBnltai/vXN82BZ5hNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=cjwUD3J9; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 4E81C42607
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1767708941;
	bh=5a8oSZR7T6zfoiPYxDP2dMFgpg5IiV+4WmGgEJ094Os=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=cjwUD3J91UEV4D9/su+rPd6oB+zssbt6aW36UspTtO+jb6CujKVOkSTKl4nRtDFMX
	 R55BU2pof2lUftHlqIKOucnaDox1w/u9Kn40GiW6zLeHs3g9fOE07Q3ANjEXvWAqNY
	 +2v1ZTqJ6B21JkuFzUyjgFUEW0AZms9+pkc1Bn8vn8NQ2LUNxygfhswCl3Asr+u5Sc
	 jYnyJGOq3OnVtcf3rVJh4Y0kObTgXeDOEdblAmhc8xmc6WHS5Bu4K+G6ddJE1NydNN
	 hAwgkphz6LqjcHHtx9hA5/2wutI+al41QPNwHMsXb2IZsJfn+gPHLj0cC9cA5ohuJJ
	 v7fAicSlAL0pA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 2C0797E747
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 14:15:41 +0000 (UTC)
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
Subject: [Build #32114219] armhf build of rdma-core 62.0~202601061326+gitfd8657625~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176770894117.1103073.4098202654072979116.launchpad@buildd-manager.lp.internal>
Date: Tue, 06 Jan 2026 14:15:41 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2ed3390148e29d23f85f2707968368d2517ebdfd


 * Source Package: rdma-core
 * Version: 62.0~202601061326+gitfd8657625~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 7 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32114219/+files/buildlog_ubuntu-bionic-armhf.rdma-core_62.0~202=
601061326+gitfd8657625~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-048
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 62.0~202601061326+gitfd8657625~ubuntu18.04.1 in ub=
untu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
114219

You are receiving this email because you created this version of this
package.


