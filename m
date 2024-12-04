Return-Path: <linux-rdma+bounces-6232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ACF9E3B0D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 14:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797DCB363C9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF031EB2A;
	Wed,  4 Dec 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="t+4Qzj+G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B51B85CA
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316846; cv=none; b=qv0LavQI5cpw57jpJUZNSW6GkeZYmK7tskyV+QCV89l0tZlfjG8mfzWARylyV/SiQCUGuJNVNNg9fxtOn3Yj56cYF8waX4KtfWwnU0nqQafXXjTvMdmz5GA7wd/MUVY9mQUNVgLHmVeEgC4caYejBVY0a8C19PTogJxkQnxZAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316846; c=relaxed/simple;
	bh=p4YkcJJ0RtkTpBxBjloJbQSTkmlsSbAGmZxkoAnt0u0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=X3US2s2yulFsrZ2D/VDY89KvGSmandDXKAJ+J59z6oorcXOzn184LjepLiDW/VtkrbaVuebLJjiuhF/pYm26LxrAnRXbGS2QtUSjIEPVfq6L/RMIXyAvOgq1tYM2WC074pyteUlv5e6/BeC5hPYEa1SktEaFsdnfjbctLy12l6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=t+4Qzj+G; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 93EC53F6BE
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1733316485;
	bh=p4YkcJJ0RtkTpBxBjloJbQSTkmlsSbAGmZxkoAnt0u0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=t+4Qzj+GZCuxnv55A2Uq8Ainj5nuoPpgr69n/8o/axiIgbwP6ntnZ+9PjVDjs5kv2
	 0efTedVM24PxFOkC9gpTIbAQbQ7W8AijRMA4KbOjOT3/v+dnUes9lLQLMH1LZE4Fhl
	 RlfikzVskJnWnTeBz6Y+DEyohd0TJ1pUg4e0o+xy+NHVsxzZc17uuF+I53JI+cmdBc
	 F8pLeBek90tAc4Ou2TSrYFiDvqiTxoF7Bar0IX8MwnnxtPkQXXNGZoeGayfNzKrzoS
	 5pLTnhxMh54Cy/AUWM6v4ctd2ei30f9ZwfJkcDfsFvPXOJumDEfGk/B4mhOUKTiePK
	 AMzsipdgty/UQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 8A0FE7E236
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 12:48:05 +0000 (UTC)
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
Subject: [recipe build #3822416] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173331648556.3877677.7127281435760946512.launchpad@buildd-manager.lp.internal>
Date: Wed, 04 Dec 2024 12:48:05 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1519c6efe8e9bd78e6c5ebf2eb5bcb040b95ad32"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 48295d86e3427d2651872ccea0f2bfd883dfb03c

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3822416/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-108

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3822416
Your team Linux RDMA is the requester of the build.


