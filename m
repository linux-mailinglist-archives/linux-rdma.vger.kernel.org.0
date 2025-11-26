Return-Path: <linux-rdma+bounces-14781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59CC8872D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 08:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D163B107F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 07:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6210B2BE7C0;
	Wed, 26 Nov 2025 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="VT8D3PD+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571C29D27E
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142774; cv=none; b=hcUKJf6YVEMM/+/gDcvgELlyLVhcsKwfgNkBjT2YEIxunLFiv6lKMAy09GC4QbHL8BTErNh9GxgFBUtyepabXF8STao4FL0kUM/MMlGCfX/+Mcq0ulk07glZ+QsPlYZDGSvDFxfaUyG71OYxuU1GveAB0cfWXJC/2D0CJTkFonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142774; c=relaxed/simple;
	bh=FCFtdSbH+WKdibItNUMWVKYVPfcPtd1KWmX8KZNPtgY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=UfBJOQF7kEAOmYmP9QWHe1tEOcOkdocUf9WgHA8/QQcGmwBv7P5O34hGgOuoWVE3/3qZ+VWpR+YC227WbRBUycMyWCQCjRefuCvxk5mTrsRF1OGYT65806zCYeOqm8e1yfM49ByCWfF0qbpTP83m1U/b17k+ditwTEdFy5fhiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=VT8D3PD+; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 4FA7F3F161
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 07:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1764142770;
	bh=FCFtdSbH+WKdibItNUMWVKYVPfcPtd1KWmX8KZNPtgY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=VT8D3PD+Z98ifHc6ZXaXg439nODRFalkP/sgRNn+N67ksadNWWiDbbrDd7h9JFbDm
	 dt7HqjUMOrc5QDvaq/+dRZje23P+ozZenJCgV6MvhvKYRSAMT+Fgj58W9u3YcnkMh2
	 EXZGmeAgeMPqGil97HjF74PvCrp7MMOsVSwaoNh33JNPgIpvISQEpRsH98ZAiPIoCt
	 pwPbSpTKfkyl3jY+xzdexWhv6zOYoyGdO4esRJNHMEcGbXnQkqWy/lEJCOIROyM1BP
	 SigM9TPv5MX8mIbQdGPKbjBNc352ehv09v/WGKtzzjnb6yeIVhBPTcU0g2aAk9Qfnh
	 rM9nHufInwftA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 3E8087E7AD
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 07:39:30 +0000 (UTC)
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
Subject: [Build #31528003] armhf build of rdma-core 61.0~202511260703+git22415466~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176414277025.791410.7680614697218782160.launchpad@buildd-manager.lp.internal>
Date: Wed, 26 Nov 2025 07:39:30 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d3f47a82cc878934b8dcdd4ba95ff09ed4ac703e


 * Source Package: rdma-core
 * Version: 61.0~202511260703+git22415466~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31528003/+files/buildlog_ubuntu-bionic-armhf.rdma-core_61.0~202=
511260703+git22415466~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-045
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511260703+git22415466~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
528003

You are receiving this email because you created this version of this
package.


