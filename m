Return-Path: <linux-rdma+bounces-14782-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E53FC887ED
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 08:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F93B237F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92B528643A;
	Wed, 26 Nov 2025 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="VUHh7gtG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50787207A0B
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143353; cv=none; b=UhgIWNideQUCi8RYcmt4SpzHdu1kmJHeRnDUKcdBz+Fgtu0lKF+K3QukUHsoRqvRo/5QnReRcRsWigbz4HAY7/iTcO9u2qjvc/1NtnM5NkT/AxjcUJHgp7YRYEHYKcU5LHSg5W+vCEFmz5fueYyD2uKrnrfgV6lOOAzKG0OCR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143353; c=relaxed/simple;
	bh=E6Q+soYue3k8ZY7gT8fafoA6C3F6jps+mV5RN9yV/FU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Ppj/5wbfYAOg475PbuOg0AqqsNDRRYEnHQ6vnpGJ56tNF4lp3dv4WOC0Lf7wBZwIfhXlyIPGaZM4zA4nsTFR0E/suAmvEkmmoIodwyJI22k7JySRolPKHJjuPgxAyhUlUuSgqZiWofVmPv4LaA2pliLaoOT+sHwASX74Z5xkGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=VUHh7gtG; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 9860B3F13B
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 07:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1764143343;
	bh=E6Q+soYue3k8ZY7gT8fafoA6C3F6jps+mV5RN9yV/FU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=VUHh7gtGT6htZsEhc4XOnbileEiCS+x6VtDLnnkm0FWCyBy1ipj/VBJOc1tJqPjYz
	 0CYX0zyEEB0ecrxPM7Nruf+BLp6Y19rp8ZU5LfpQXwk4HfkGykszafE/pLuajGrRo0
	 2RtOdXmiO1OPYWV8ZxcxG0evVW2r0f0RhtLgLbGnMAaauC1Oowu+VMUjalqXASKPIV
	 dooHZVq7dz++7wpj6YT8zOIbtZK57hnsAFHqiTT5P7n6a6aXaCmvfH3IRWLCauXtI0
	 9BhG9GOJ1r2jI9IzQ08Hs0Uuj7wzIz1tf3b6l70vlMvVb1hhg9ctwnBFDIM6awdcG1
	 Ub32riuPSmlgQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 8C0617E7AD
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 07:49:03 +0000 (UTC)
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
Subject: [Build #31528009] armhf build of rdma-core 61.0~202511260703+git22415466~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176414334357.791410.10581665840156048767.launchpad@buildd-manager.lp.internal>
Date: Wed, 26 Nov 2025 07:49:03 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d41f8b439e2d9038fef9efdbe1e7f2d5301395f7


 * Source Package: rdma-core
 * Version: 61.0~202511260703+git22415466~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 15 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31528009/+files/buildlog_ubuntu-focal-armhf.rdma-core_61.0~2025=
11260703+git22415466~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-018
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511260703+git22415466~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
528009

You are receiving this email because you created this version of this
package.


