Return-Path: <linux-rdma+bounces-15050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B79CC8556
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 16:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7530B310EB64
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C37346AFD;
	Wed, 17 Dec 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="POPYckPM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4134251E
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765983414; cv=none; b=i+bktmOCCv7Rvw508EQgnl9ebH5okHq7KjsRhHWZ/GTNTiEzzc9NoXdNxcJWJ72vAXt1jsvL6ITPwJoxfTXh9NUId1aZacrmvSMAbDccPFnsZrw+PAHC0IGHTeKllTMfzWbKgZE9WSG1C5xWLCUL+kCo3vBbyvCE7Mez1ixrWGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765983414; c=relaxed/simple;
	bh=CoIWY+HPKnWqnHPBYiMv85Z9B1QWwgfSWD8Cn1uWfhQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Nn2yY8nzC4qRd9BV5IdLG4psuUYQgZAMx1zFQ4UgbXcuiAoN/r34zYT24O20iKAPuZIgv/ugWOL2Dt53fI5CyxNuIidK1zDUI+elJitw//Ji/frSNI19T/U9mSdGKaNaiqES96CXjcvTSUOMZ+yUiCsuORaALJ36d84rsw2Gt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=POPYckPM; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 6131F47E86
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1765983410;
	bh=CoIWY+HPKnWqnHPBYiMv85Z9B1QWwgfSWD8Cn1uWfhQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=POPYckPMudlrwPDMTu0atEdOPcT3lHVtgtjnj/9RwrIQz40lskb5kgLKLNd/GQO1e
	 r+GQD5VPdBhEdks58gZbcjWGDrI+McffbLXsy3a/hysgb6trW6HKZ8ifYD/bH4n286
	 5mZ8oOZNH9VdrrEjVJ/vROQSpGqCTSshOcphIC6NE+/3rpfR8tI3bE+ynfblSQqXwG
	 RfxbODfBKoCXH8F2Be9EmCQfSXfhv77QbZL7SE2dhZEgVh5g3ckqxGqnez/06u3J6I
	 6OWXyXysqmwaSxpDmNDS4lUn4pZpK+5XArDUz5iTJNpjI/ULflpA8eIxFhukPlAi/M
	 m7dUUsoSdVYvw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 531507E7A8
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 14:56:50 +0000 (UTC)
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
Subject: [Build #31662563] armhf build of rdma-core 61.0~202512170735+gitd74af53e~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176598341033.2912269.13018000838779528208.launchpad@buildd-manager.lp.internal>
Date: Wed, 17 Dec 2025 14:56:50 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: a09e4f787c0aa63423b4a149cc7842a2c63c20b0


 * Source Package: rdma-core
 * Version: 61.0~202512170735+gitd74af53e~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31662563/+files/buildlog_ubuntu-bionic-armhf.rdma-core_61.0~202=
512170735+gitd74af53e~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-114
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202512170735+gitd74af53e~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
662563

You are receiving this email because you created this version of this
package.


