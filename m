Return-Path: <linux-rdma+bounces-1409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30BE879D9A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 22:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6330A1F22251
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 21:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2414143737;
	Tue, 12 Mar 2024 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="qxkOk4vA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740813B2BF
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279769; cv=none; b=fsGKh1IG6SsUHQ/G75pEmrSZ8B89c4JE9ABOYMZJZnK3kDCMkFBgIIMm1vIHCeYvSZHXcaC9aHP2rKxVPVOxyDnPhTHW0zn7qGpNrXVvWue+xMWnnt7GzhK8HaEE3WFCRZKi7o6AjsAZqas1cz7XtpOguWjTz1LQvHaxshD4YcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279769; c=relaxed/simple;
	bh=hTc97pY61rYFXAFITD3pZOykhPvGiQKi7ayR8leS/ao=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=qVWYoD0sPLj+yHRxStolyZginUkQ8cjf6fMb/d2ceYkjruW0I03mdtI1yWLL8blR87LLNHmFTw5w/v6O8Maq0E/IpYWHIdzfl+FVfIYGLB7AXW5Z5M7EX7HeqN2o5uqcIiTBuK+D+Migtb0+BPH/aLULNF8DHUYIQ1qu1fb49VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=qxkOk4vA; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 84E7441E7F
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 21:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1710279765;
	bh=hTc97pY61rYFXAFITD3pZOykhPvGiQKi7ayR8leS/ao=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=qxkOk4vAy6MuUFwP/A2Qwif2tUekykyjNDwGK9K1SPFHI6QoAQOJhfI6EIts0QxFt
	 pMKLVTmAQKugSjvVDm9qXL5yJqUb+fxsdKDQvX7A63fZ8vZwDssDihpMUV/xEtD39b
	 PvpEhcuo/iEi7QfuOUxbQjr9S2DYGILYGM9H1/Q4mhYvEce7nZvQK1aO981wz3Jx+A
	 nx1hukAFvM8c8MpFpOmQqgLxoBCo9B8fOczbjDqqumburHMtoRu3HuaePI8YpfeDx1
	 1K7DFVfpuXIzTybvzy6HhsG0VawOhBSHfWCVLi2Rn4bsiEDGNFhTf5AdQQb/8AS8aC
	 mIWriwQQUPW6g==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 6D4737EBCF
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 21:42:45 +0000 (UTC)
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
Subject: [Build #27908499] armhf build of rdma-core 51.0~202403121118+gitf8845855~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171027976543.1939111.1604651601215923359.launchpad@juju-98d295-prod-launchpad-15>
Date: Tue, 12 Mar 2024 21:42:45 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2e4955e3d556e61e2eb54acf7a827d17e9e46822"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 4eafeefbfcf661d519450d5bc39e0ddb8a1bff96


 * Source Package: rdma-core
 * Version: 51.0~202403121118+gitf8845855~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 12 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/27908499/+files/buildlog_ubuntu-focal-armhf.rdma-core_51.0~2024=
03121118+gitf8845855~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-008
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 51.0~202403121118+gitf8845855~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/27=
908499

You are receiving this email because you created this version of this
package.


