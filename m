Return-Path: <linux-rdma+bounces-1366-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F70877762
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 15:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB2C1C211F2
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6481D364C4;
	Sun, 10 Mar 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="rINluAyE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53AA10EB
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710082659; cv=none; b=S90amqsDheWeqjPDO/m/4EuPlUrr+yIiU7hjyY1ed55ndXQDquAd8XD6VcJERxxbS+2Yew+NYobAQS1ohnl38E46yLHK7lTGTAVGWf5EsGEwG3TDilN8DwulrtELP7oh5/wKO5gmSUhmKDkFW6IUZec06ZOXnJPCSIj83m0IKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710082659; c=relaxed/simple;
	bh=L+n43m7XD6HG5NqK26mtVVOJUUhNw5RyCOlxOxkTHMg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=X8EthUtn6y7u4ANUbOnNuJ5qxzIrkbgUpuSMDTO+bjfArB3E42/DmVP3xm6zVEjprrW7jb7ets6L2d8m+T8jIGAfzAUJR6B62fOhwAHCF8KMcDTgOiF+tGc9/6jxwPcmuk+UBC/ga1aPB6vH+s49cQUSaAm216m256tN+DR95ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=rINluAyE; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id BE36241F05
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 14:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1710082650;
	bh=L+n43m7XD6HG5NqK26mtVVOJUUhNw5RyCOlxOxkTHMg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=rINluAyEHoGuArM3zz/7Jxl10YxoeVumg/Xn4wogCzhgr7kBuvx8mV0b7zfOR6ksE
	 YS5D8pxX39Zk6YOpD4qJrtSRzks5tfSFTAJ18MqRoCfMKONfth1e+gqcx0R4iQdCxf
	 L9S5ihER9Xw/RIjhVucZ+RlzQDEQjpy5dPDOTI4suTaSzlGoPCJddhLwquUSwpuojv
	 6KFh/RulHtHpEPefRdQ5yNcT4VW5nnMUpOE/UTLrYZVZV0CIrLGyZgf6prREVgUdqv
	 h9PbtZEn7iLO2p623JE91FepAcU+qCqn6GxUmiIe2J+thK+3KxYWNqkMzpblg6Iuzm
	 KY5H04S8SaOzw==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 723AA7EBCF
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 14:57:30 +0000 (UTC)
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
Subject: [Build #27898052] armhf build of rdma-core 51.0~202403101259+git710aa556~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171008265042.1614976.12517416453815239378.launchpad@juju-98d295-prod-launchpad-15>
Date: Sun, 10 Mar 2024 14:57:30 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2e4955e3d556e61e2eb54acf7a827d17e9e46822"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: a47bead68271d76ca9af7e1eba1db6834d4947ce


 * Source Package: rdma-core
 * Version: 51.0~202403101259+git710aa556~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 8 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/27898052/+files/buildlog_ubuntu-focal-armhf.rdma-core_51.0~2024=
03101259+git710aa556~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-033
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 51.0~202403101259+git710aa556~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/27=
898052

You are receiving this email because you created this version of this
package.


