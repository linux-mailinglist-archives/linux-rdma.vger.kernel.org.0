Return-Path: <linux-rdma+bounces-15346-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36451CFE45F
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 717E230BE3A3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3B341055;
	Wed,  7 Jan 2026 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="SAgbhYKT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135BC3081AD
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795596; cv=none; b=dyEDDV4PRLcknwxJ/c7C53LYV6Ioo3o2vszGo5S80VcLifGskRpeXBrz4CSgmA1o+6XG6TBXXIfYqDST/yo+es6aDHUIsYx0FaIYoBc81W2EHYtCl2PQASknlDcRmInOdlCJFoXj7nKtGBLpQQLt/f5RPhQ7dctuqs2IdWvRw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795596; c=relaxed/simple;
	bh=mtqJuHWwPZIXJJQezDEUUa3SMD3RK5iBi2TSSWkkbuA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ezfkCavtab4Y60eXzgCo+yRzG/t5NzG1UOVZicMznxrrzNEVZJGIm+45/viscQS8BeixjX7k36MKUaAxDHv79cPL2Iy8zklRmAnEorCWvh47tmeRDhbqMYrAGv3PSRGvlc8yXrlT47nBkO/RnY1HdiJke5IogrAcl4XbOHKiahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=SAgbhYKT; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6261C3F592
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1767795592;
	bh=mtqJuHWwPZIXJJQezDEUUa3SMD3RK5iBi2TSSWkkbuA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=SAgbhYKTLCVYgMTyTp5we1A0IoYG/EKUAjlbQ0VQZ4dVado0Yiqt7OyiAbqXo8cOe
	 or9Y31ewl2rsQCHe+brwEBMhrhfyaOMSitDLu008fzN24UTcehqnkqAYauVguWT6c9
	 UUHDtX05U6rUiydPm1ivMJLAgcgvs4pklnQ6jK5aMyHV+R75hdI4DMQhy0/OABrX3J
	 lEriYyUJdc/Yq9ys2WvOxUY69hQELztjbS3rGQUEbBRpEypr9NV9RDPwvToET5UBPN
	 R7rKq1UXSu1rlDO2Z6kaBkVhiZiL1otQt8chq+Cfq46LIPiSum0vUKM/0QfqC0KQuW
	 x+EuCYiIxU9mQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 554217E7E1
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 14:19:52 +0000 (UTC)
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
Subject: [Build #32117338] armhf build of rdma-core 62.0~202601070825+gitc7cc0c8e~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176779559234.1103073.13820188852196064976.launchpad@buildd-manager.lp.internal>
Date: Wed, 07 Jan 2026 14:19:52 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 224ccdfc4649e0db2513ac3f3fbe95e46f433c27


 * Source Package: rdma-core
 * Version: 62.0~202601070825+gitc7cc0c8e~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 9 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32117338/+files/buildlog_ubuntu-focal-armhf.rdma-core_62.0~2026=
01070825+gitc7cc0c8e~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-030
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 62.0~202601070825+gitc7cc0c8e~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
117338

You are receiving this email because you created this version of this
package.


