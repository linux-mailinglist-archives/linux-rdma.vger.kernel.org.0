Return-Path: <linux-rdma+bounces-3867-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0329931578
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 15:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0501F2226B
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50018C351;
	Mon, 15 Jul 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="aAjH2zaZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A75172BA6
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jul 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049141; cv=none; b=uB7nytpHP+EapW2sC3hfaf606p/oF5RXYqp9yS3kg0SY/ebDOL8vek3iMXbjgWxgDeegziVlPaXcPXMyOZhRsIB+K4JVDs6SqGsexA3GSuQMzWBJda/qAoZ/fIPXTZwgUXfj80Y2JEpXj5CjVhc79ktUyXVWsA33uqqd/CUnxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049141; c=relaxed/simple;
	bh=NOJoGpPD8up7EqzpgjiKEjW5iEIpwbIUuNl/mdHEhJU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=sQe7T7doENeeKTax4qmDlqVcm9a8XFbx7MvfnpsycapqsfofDOXeNvj1bBMWfYT4GZFHBlGIi1cYIfjXZG3eQ9U3TA9+Rz7Bv/wO0ky+3jjGQcnRUTdfQtkW1N5j9OvchcMWRsDCMXmKXayCwXi01kc5TfCToZbZplCdUPQBCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=aAjH2zaZ; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 0B2953FA0D
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jul 2024 13:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1721048595;
	bh=NOJoGpPD8up7EqzpgjiKEjW5iEIpwbIUuNl/mdHEhJU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=aAjH2zaZsjLIn8pdoB7DHXYL//pCaok+JK0VmklEuCi+EcszomUtSY2yJBgEEVLiG
	 UB2YZ0X+A+ezrJ41RFARFRabJ8rNyscamu0rCsfDSMBsuGEV0p5hSAStl6hGPuJ98+
	 HkCM9mNoyOHsoVQGj+JGMp/Ol7xU2exfASKGUF1v2KY28DYRq01a+Bbn/2MGP/S3V9
	 jiubZGNPLfOJB+jd6QWUThJH1P2+a0bUnlWpeoc4M2n3QrXn6POxKHH3HcLoeoRj84
	 pyIhuJCchlDIoH4P9Z2SyY0CaqSfhkokEyZkG+nw1WtfvPLYlNUELjAGyqnNCC8Pxu
	 7IxGWaiv5v4Ig==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id E68557E252
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jul 2024 13:03:14 +0000 (UTC)
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
Subject: [recipe build #3756340] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172104859492.1591207.3808870405690072710.launchpad@buildd-manager.lp.internal>
Date: Mon, 15 Jul 2024 13:03:14 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 1ec5cba91d18c7fd0e632e1efd692aef3c1d4847

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3756340/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-003

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3756340
Your team Linux RDMA is the requester of the build.


