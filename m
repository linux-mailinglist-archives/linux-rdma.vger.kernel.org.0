Return-Path: <linux-rdma+bounces-15252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B584CEC10F
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 15:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01FBA300E149
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A3239570;
	Wed, 31 Dec 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="g3V4zLzF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020022B8A9
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767190319; cv=none; b=aEEOMxQRY9xnG0dQC7BunnWSMLRLguth4umcFQkAfSoj/to9liHKxXYixSUGF/vEdkI1RJOJIZInQge5CFNtwcyV0ahoYTymZa7XzREPJR0AWHet5e53u1QnC9WADLqGKp9EmjDBXgBILP39DxEAY8sNTN+ZAV0dl2xjLnrjUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767190319; c=relaxed/simple;
	bh=j4SnzScyqIGiR36r2RdFKndT6wAyVkE+XLdbRs8vSVs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=EO2pNj6UAZ0zJumI5VxBGzwGT3uPqxzjTjN3MyqUOo0w2Ink6jqFudWtOkfO4Ghlybfo7h+ZxMuBlhMY/OfyoWwtMtcMwLKUuWY4BUE+3teN8e6CpC89ezMI/jAbunV4j8HkMUYpz/yKZ1oBpuKW+tds60GqMXM/DZm9RAClak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=g3V4zLzF; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 16F8E3F04F
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1767190315;
	bh=j4SnzScyqIGiR36r2RdFKndT6wAyVkE+XLdbRs8vSVs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=g3V4zLzFQ+M6kB0AkoW5ISgfiRuCVF7FlDZuYL4OuJV26lRTpvhBEvM/4F5yPGYer
	 Y8FuOhrzCN1C4apVpjWpOqvGbexNDKFxyLpujDlPsHBBbh3unwxwV0+2A1sppYguhH
	 ELvooTJLdxJDNV+Jxe8N4jQGW2cIUjIyZjjB2bbn2M4qf1RoQLAovupnuJcgrf1wtN
	 uIG2h/WEYkUn8mTJ3XiPe3Rv0AbcLjJ602hnLVzPUDunR/9ZsCQfgsPA8sFwMxu82A
	 1SH5fTPblW23k+lWQKrymRrdVGLugtJt6MOzqZGiCjEfiQsgxzw3Sr6HRG0lNh++tL
	 Sygw9r0xFUlGw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 062CF7E747
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 14:11:55 +0000 (UTC)
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
Subject: [Build #32100531] armhf build of rdma-core 62.0~202512310751+git902dce1c~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176719031502.3785417.4762421581530413717.launchpad@buildd-manager.lp.internal>
Date: Wed, 31 Dec 2025 14:11:55 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 70fdc76895984867cd36657617e77bef628012b3


 * Source Package: rdma-core
 * Version: 62.0~202512310751+git902dce1c~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32100531/+files/buildlog_ubuntu-focal-armhf.rdma-core_62.0~2025=
12310751+git902dce1c~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-063
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 62.0~202512310751+git902dce1c~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
100531

You are receiving this email because you created this version of this
package.


