Return-Path: <linux-rdma+bounces-2895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E08FD116
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8E0288893
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C513BBD7;
	Wed,  5 Jun 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="COh0w6qM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E53A8D2
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598839; cv=none; b=JMzSEFaBr0+435BKkd1d1TFTxl2TuDH5wDTf2FrS3UUpzUA8xtq8yVtXWGggDC5xOKKL1AqV8w3y3Z17F6X02okSw9GAK21MsUiXVtqSwCzbK0acjsJhcBqxU+NdqA2bvACou6qsZlAq6gRYAkuWhU00KUlb8EVfkvu6PRplz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598839; c=relaxed/simple;
	bh=8J7FGY8ghKU0SYiFuRn0cxpEJFoj4lvQj9RdYIIm07E=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=G60b7BDjZGJF1YW7xh1jKga74SX0eq9xOF3v+PLWjvsuAVwlkvAaoCKf6ZyEY1PFN79HiPGO277qn5G4rdbjbLhmI8ov/YSZ4PU1lZ6pOAGEacWcQD5eYaRd6wUyxeZfT/ZNqwdFpX6e7L0Es9NBQJYP8m3Glz+UifYEmpmimG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=COh0w6qM; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id BE1D63F07A
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1717598829;
	bh=8J7FGY8ghKU0SYiFuRn0cxpEJFoj4lvQj9RdYIIm07E=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=COh0w6qMs1WKcGRbcWAgwyaQfE+hOh8LA4s0ruB6S62m/By69wnPkQ4NDcPilT5LB
	 LqiY/bMgwdfDV6hQwj+6Y1xBaI012NJ5LBhWq13iRFhR+6PNZUxjVxv11Kjd7Fvz2F
	 /mR/anGYgu1GxwxsV0sU0idSVcjGGjrXBtikrKGr22eRlT3cy/L76upgjzKXlQmKJ2
	 G3u4X4zbWfn7ETl2aFdxysXVKCBLA9wXunBSeM6Cg1VvC3cFuYnVlk8iFfnNP1/oUt
	 z30lt3BmTavuSD8WK964vMwoF8pggly34nMnqHrgMf7tLhAZmj43JiCaTd7XSqrgOG
	 556X9ZGC3LQKg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 9BEA97E236
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:47:09 +0000 (UTC)
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
Subject: [recipe build #3737792] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171759882963.3361349.11582782845894990158.launchpad@buildd-manager.lp.internal>
Date: Wed, 05 Jun 2024 14:47:09 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4d1350fd3710dfe10d207fa9961e224cc481dca3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 9f33cf98980486701aabf54a029217ad39e31997

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3737792/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-108

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3737792
Your team Linux RDMA is the requester of the build.


