Return-Path: <linux-rdma+bounces-9883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E594DA9F504
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F90C16E386
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2F026B2D8;
	Mon, 28 Apr 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="CMKGnJh5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4852269CFA
	for <linux-rdma@vger.kernel.org>; Mon, 28 Apr 2025 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855813; cv=none; b=lGRiE+glFAJbxub0V9/YnmIIXYqIcIU+oQq7k+74ONxtJ6nqf75hlDcbjIDLIhomPLZTBpJbf+RkcyQghoT3eAaMDJL18w4RpoAxkILvofydgzPYloeSKEg6FAmoHTMiN8xf+SExPbzweHuVhBygwWYjnazffPe0uRZcJXZUHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855813; c=relaxed/simple;
	bh=U2AoLwvDaOkdpCgevGHou5VV/kpztfCUyCrKk6vwST0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=hSsmYZL/ljQXWp4AP1y2iFGLUyNErKWGMKXs7v2o1wuK+HetEXja6feRLnwZcaiLlCDDtkKjwWJ43kbpVO/RFqr7U766PPDSdnf/dhd2HmR0wpCc2RjSniHTicnrx6ePalHjzuHXzhAoFzV5mb102pR83ykIlvK8suG8zd7wCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=CMKGnJh5; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 2AF4C406A0
	for <linux-rdma@vger.kernel.org>; Mon, 28 Apr 2025 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1745855804;
	bh=U2AoLwvDaOkdpCgevGHou5VV/kpztfCUyCrKk6vwST0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=CMKGnJh5Qt1fZlSATerTX/AueYTZ/YRbEiI9eQxrOmBf4LqtzpLQZvHmdanjY9ZuQ
	 IUnTq+6tptmHfsecR88ZuJfBkvkSGZc5JmkZBtpUvwkgNzJr9Eh3t7hJKAoxNbE0WH
	 Wf2hr/JgfeLS+y3QxcY8YxcKPhlvHE4NkWgCoPOfKBtd16DCd0dGOz57KRAfsb0f9p
	 MTrvr6HNXlBVXfnW2Gp8Rap3iiNpzb6hA90t+gsvxW/yGojOUdj18o46NyO0K27n2E
	 LUsrOM+c0I4AVPzdrO0BJ1VOtIg34DGj6WE2Yq7qpBkutxKoPQFLUvosjytLT/WK5/
	 jTUL3gl1eUm9g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 2225C7E246
	for <linux-rdma@vger.kernel.org>; Mon, 28 Apr 2025 15:56:44 +0000 (UTC)
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
X-Launchpad-Build-State: FAILEDTOUPLOAD
X-Launchpad-Build-Component: main
X-Launchpad-Build-Arch: ppc64el
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #30657937] ppc64el build of rdma-core 58.0~202504280529+gitb2ff2388~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <174585580412.2153366.16235861273057343866.launchpad@buildd-manager.lp.internal>
Date: Mon, 28 Apr 2025 15:56:44 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e76edd883483c71c468bb038e98836435de44530"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: e9cfa67c60e30b2e6486ed58cf973c271db6e072


 * Source Package: rdma-core
 * Version: 58.0~202504280529+gitb2ff2388~ubuntu20.04.1
 * Architecture: ppc64el
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to upload
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/30657937/+files/buildlog_ubuntu-focal-ppc64el.rdma-core_58.0~20=
2504280529+gitb2ff2388~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-ppc64el-043
 * Source: not available

Upload log:
Uploading build 20250428-155535-PACKAGEBUILD-30657937 failed.

If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
ppc64el build of rdma-core 58.0~202504280529+gitb2ff2388~ubuntu20.04.1 in u=
buntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/30=
657937

You are receiving this email because you created this version of this
package.


