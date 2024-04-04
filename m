Return-Path: <linux-rdma+bounces-1777-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696B897E2D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 06:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33E0286635
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 04:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6F120B33;
	Thu,  4 Apr 2024 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="B0o5yg43"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B591B3D577
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 04:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712203987; cv=none; b=ojkg5f7NqcP40Sk+RabqjNpk3IVNvm5ufAbqzDvKfjEy6DTYYLTKLWbvFnePm1WKev0KLGy6kUOyFJUT86Q9q7lNDA3H69a0CptYRwBtNFVc85ohsa8EFjQoGgkwWxHjSIpgKdQr941g4y8qL3JoWzTrOFZPsCeI3f133J1JKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712203987; c=relaxed/simple;
	bh=9EwiDsZDv5fx9BvcRR+omHSGJkVb7ybwfQZSRyiB+Q8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Do1yvRHxBXkpRtY8mFyltEGc+96sZmLnDHyGdgMegykWN41DGlkf+y/KIaBbdZfF8MUacx3Ny0QinPoTyziKze7/aS2d4R4t8Gi3sS57wlL60Wxgdusc0+UuVyTtYeVuuP2Zw5PjVtHbzkwYpl8NicYRbhtsWsiJLGN41Swbs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=B0o5yg43; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id DC0CB4D6EC
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 04:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1712203973;
	bh=9EwiDsZDv5fx9BvcRR+omHSGJkVb7ybwfQZSRyiB+Q8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=B0o5yg43lFNdp7cUV/iJlPaISz8ICXp4jQWH/cw0JMKSlC/dSHlGsBQI6NU3/KVY6
	 VJZUNbE/1CKMkeLZc/X3+Q2IrxDQojCNWoWE821M2OOk4bkymcHMuoqGxCL9LMEucn
	 aQI77nIQwo9SBcmWE7Vt3LY7N3zFISXbxwua1oQetXcGrQJWD09HNVU0hnnIfcNiTE
	 OUVPf0LgV8o9z29x/Bo3lbW6/YOqnRrcsEhqjLbG2h/XpCTHzEeecV+/5STyvw4ENA
	 ditOH86m7T18j30WeiNsYEs55e/8SkoTIDn7C6iKShZVXvOMvmBtmmvvThH/e64GS+
	 p2bC6rLdItbjA==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 35D9A7E246
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 04:12:52 +0000 (UTC)
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
Subject: [Build #28023184] armhf build of rdma-core 52.0~202404031838+git4b08a22a~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171220397220.701.10742406623297533361.launchpad@juju-98d295-prod-launchpad-15>
Date: Thu, 04 Apr 2024 04:12:52 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 8c2d8869eaf8f4b3ec7bc77b3f8ffa1385a17198


 * Source Package: rdma-core
 * Version: 52.0~202404031838+git4b08a22a~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 17 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28023184/+files/buildlog_ubuntu-bionic-armhf.rdma-core_52.0~202=
404031838+git4b08a22a~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-033
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 52.0~202404031838+git4b08a22a~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
023184

You are receiving this email because you created this version of this
package.


