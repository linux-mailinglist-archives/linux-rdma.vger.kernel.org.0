Return-Path: <linux-rdma+bounces-6032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD99D151E
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2024 17:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5362B2F6C5
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2024 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52851BC077;
	Mon, 18 Nov 2024 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="WPa5Z7RS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3A1A9B3D
	for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945819; cv=none; b=MZe6b+v38y2MrjdgaGNSSSB+v1Kqg+qOoW5wi5erwMqFBnBdQK/9+p/SdWAcqMTURRiAUqy1tgaLs7C3/W4X1UFN1ghUvHEdM/yZPdEqlYjAaFrqiz50odUQO6a+HBAWHAdYxPDHzEgqQfVgQYH+kW601fYO+kVPW+rsJFQ5ZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945819; c=relaxed/simple;
	bh=OflYuOmB+4qzcz6SPKhmGs+B17JrQDo5HK7LG0oxKrU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=qIoX7mxSY6zH7ywMCRNJUi+sDzLhFy+Rjgf5Ki3e22cCuZ7185IZ3NkAdjkL1ByfbggGBSbkHinXRDlF78Tsbx6R6lXGppQqoXiTFKGNmUoldLC8vifxIWvdVaMw3jio9d4qVytFVb6U1OVW4yoCPKZS+CV1UY1Xqmg2F3an2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=WPa5Z7RS; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 888503F613
	for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2024 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1731945809;
	bh=OflYuOmB+4qzcz6SPKhmGs+B17JrQDo5HK7LG0oxKrU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=WPa5Z7RS9udj48xOIozHarOveGVxhpzJk3ZkfrI4aBkE7TJD/tGL4leLsg+393pr6
	 HCXeUfGN0eS0EeCzlMABeM2d7KiHIrqVGjLv+57jTP5vyG7nIFyy3XstbxPeA8uUet
	 HY6DcJVlru797q6AR8q2WswZP4/2yE4sq1SysbKtKxpvBDjeouAvxLYcbg+8wINztO
	 J/isSrm2Mz0W/qLV3ZhO3uZM12+sCCA3oYSdS/qwR4p3CkeNcxcwbimMCxDHnVTxvD
	 eUJzNXxwIq6mXgHgoJNPTmfFVvwqEJ8P6wFH0NOFI+aK0M0VfOCcWK+vB0vqri5yFs
	 Km1WfYeKMPTOQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 7BB527E236
	for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2024 16:03:29 +0000 (UTC)
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
Subject: [recipe build #3814606] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173194580950.2106356.8465221862477570679.launchpad@buildd-manager.lp.internal>
Date: Mon, 18 Nov 2024 16:03:29 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="22ade00ab50b929fac63b8ee7252243aceda294a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: cf344f91fda7de86bbb486372024b5634df5b69f

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3814606/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-062

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3814606
Your team Linux RDMA is the requester of the build.


