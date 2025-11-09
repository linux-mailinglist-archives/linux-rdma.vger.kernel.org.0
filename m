Return-Path: <linux-rdma+bounces-14347-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A013EC43E9C
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 14:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4923B39BA
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9C72D97A2;
	Sun,  9 Nov 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="nvy6Ckh6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D717BA6
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695164; cv=none; b=rLboAqhvO4+MSJxN6J1usg6NMrwypgliGlgoRANbQjmhwd3oI3jKaIlgA4bMbrcmAhkgYktvo2McnN6OOpHKjzlNEenN4ioVS0jbgXYzyXN9OMBGsOgxgyUp1GrHUdpvCRGDN4dN/5/NxrFPjsvM2BtTTnNERGQvg9KReMd1R30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695164; c=relaxed/simple;
	bh=8ksdHN9xO8EaiO8J//g5QP7EZS80G5tIs3AQ4WoE/tM=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=q60aMFuWreAtHEpBDizAPRgMHkUx7DUL9PvVal4hZ8tFEsFEYIXSVUyYTvSRmdnH3/EX869fUjjH3Q3Y+KKgFfKsqlm71XWF1K6nxA/cG4zaBROgIbxPxf4/9mQXHz6uE/ck3FRCm0bAaTaJpfIQ9RVdwxf+VXPRiiFm/9Zi2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=nvy6Ckh6; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 60C143F64F
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762695155;
	bh=8ksdHN9xO8EaiO8J//g5QP7EZS80G5tIs3AQ4WoE/tM=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=nvy6Ckh6gMhzzdX8+Bez5WsmihGhLeGJYyfy146nx8XmJcfOSh6EA+fZ4dw4bLbE5
	 SKllObOoN3lIN3LAntpmATcIpKDGcbtFDG6BUmanodDSYkoVt4Mnqt0H3d+jEQvjdB
	 Wpr9fH9OAJHwdBWAarLFXV2vsirBgSFj5TYbe5vWgPyuUJsiK043TnN2e2A3xAjlug
	 mnYBhTrHozmMSVnnfD5GnsADBNJTg6X+XKTRfRtUZFC74bbMkVX4U/mXHuNMYW/JkV
	 ZgVpK0m8S3YoCESItWWPe58C3g9cdcxPBY8I+h87m5FsBvtuh04APQthR+Pi5pIOr8
	 UPi8KeyYiaYMA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 519C07ECE7
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 13:32:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: MANUALDEPWAIT
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: noreply@launchpad.net
Subject: [recipe build #3969807] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176269515531.1218157.6965402866266264201.launchpad@buildd-manager.lp.internal>
Date: Sun, 09 Nov 2025 13:32:35 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 03781e1c7b261a7229d1e10e700211a99f5fefdc

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3969807/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-033

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3969807
Your team Linux RDMA is the requester of the build.


