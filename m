Return-Path: <linux-rdma+bounces-12581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66009B1A938
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Aug 2025 20:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B275A3ABA3F
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Aug 2025 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EBE1F1311;
	Mon,  4 Aug 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="BGg977Id"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C31C5F09
	for <linux-rdma@vger.kernel.org>; Mon,  4 Aug 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332333; cv=none; b=slFGAHJ8PLu+POpry1SpuAqKQyKztvaa7GUl07GMB+ziTRiV+hAPMd0Dt+ekDbYtgZdKCnmnqz1xV3/IbOY+UocFScbQEkWM0UfVSgkLaga9I/QCNdr324EyHvqMr46GkjxHIneHjs/n3VpUlxMNDruNtK5VQBXPafCtjgADYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332333; c=relaxed/simple;
	bh=xfvLyT6sxtPQ39VuNYexpIeTajzYYyvqyd37L6nkE8A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=cc06ltUXDoBzi2t9SavyF5zEDfbAGmCWBLWUdSF8YHkK2m2BCUCq9uu65sDL6+qFIOHOfCxl+RnkgL3LPu+/7mPhOBldbTqqsfd28wx5D9zWCrTSh/r3nw/OBIyntLISw/xKKfZGrVx7rVOoH/cRZ9ZMDTnAcmpu5qXjuVvgTGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=BGg977Id; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 8C3D93F6EE
	for <linux-rdma@vger.kernel.org>; Mon,  4 Aug 2025 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1754332322;
	bh=xfvLyT6sxtPQ39VuNYexpIeTajzYYyvqyd37L6nkE8A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=BGg977IdVquw3NR8XZ4wJQsYD+0Z7l0P/G5lMxQG4GHtqh5F+U6H+LYSKTu6k0l5W
	 C27FRw2iwqw7h2qrkvz+ZTgXoaNcmdutO09RWBSO6FLKLXDdiDcxOLfhhuND4vXeSw
	 v5J2oP4smpb7KzB2O0ilwjUWKdtAE3ZQUe2ugpH/RUVVDQoY+a2L0UVR1i7eJ0xcd7
	 4i8uNOzguv103TVVdxFeCqIlfxNPXsMsbZkeabMClbsjdw/It3dBv2hQcke4AgJ7Fc
	 M2ePdU8d0s9sTbNUMsfu845XTFN+xlEOnPm1FGaG3AnglZwUgHgYZAS1ruUXB3bA7x
	 CtWB1PHfD7Kfw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 717C17E6F7
	for <linux-rdma@vger.kernel.org>; Mon,  4 Aug 2025 18:32:02 +0000 (UTC)
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
Subject: [recipe build #3930340] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175433232238.794478.9347508246858475707.launchpad@buildd-manager.lp.internal>
Date: Mon, 04 Aug 2025 18:32:02 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="3cf67b79dc0cb931b720b669b1d12163f9abeaec"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 18bf7fe3dd11bc5802347c758f363e39ad1e5435

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3930340/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-102

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3930340
Your team Linux RDMA is the requester of the build.


