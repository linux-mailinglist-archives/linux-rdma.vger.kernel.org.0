Return-Path: <linux-rdma+bounces-6990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2FA0BC77
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 16:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40AD1885934
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D83C1C5D74;
	Mon, 13 Jan 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="eZLL7avO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AD1C5D4F
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783214; cv=none; b=brIEmqWfTwTlL2Zap5+VAM7w9WZ9UnxXc2MGJWN9EVU4P/+J6pde1EyWx9hUY4pailwAEekd2OYmrLMTCfGuX1FBFk/AXQ+217rmbn7JraOdsoklDlb2sjYVHJRpl9+wqS66sOfqdilTNMReb1Gw38XuHASNMQP+z3YC/+aRvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783214; c=relaxed/simple;
	bh=b821PwKpTChreAz9nmU44OCkYi4QjFLE2hnMvh+upsE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=sNbKdJsUqPiFBn6iSzSEvyrwpx7Cc6EWkSEiUNnKhZbbdXWcGn8iwzr4HyIMF5c4NVx+ISw70kODGgxGI3oPSkkUz3mUmZEU2X2NdyYxbwfg/ShFT/Mb7bHwilj0laSAnDtBMmOqlInLEv5HI14Rxdms4VUFp1/MtdIgIcdiSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=eZLL7avO; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 636CF3F598
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1736783205;
	bh=b821PwKpTChreAz9nmU44OCkYi4QjFLE2hnMvh+upsE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=eZLL7avOtdcLDGtga/vZi4y3umGKI6Js/5xYYkdQzWVk1guTBSHQRLLgcpnwGeljH
	 BRoG3Ydhbs7OUkG6uWHlOkU3UYpt+3+Jqcsr027TsGh2uOzqW9TMtgF2oFlKRP5uQW
	 8qEqTSzLH43b71Bpt3FdUPQKiEZuqCGyUwNoPqKnWFZN82HySCFPu59Wr7o8Wzr1n1
	 3WRG0NTFYDU/wYkCJh69sjnHg8JxmKBy/EJkO6y+Bwfl5/nzPtItcnIuivOfbUHoq9
	 JKNkpwBkquIfJeQdcRc4AafRk49iPWHzFUdWTPfgqef1MPIKH9Oh4mIwgOQa7aPZJu
	 Tijil/muiCtjg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 4F34F82BD4
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 15:46:45 +0000 (UTC)
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
Subject: [recipe build #3840197] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173678320530.775904.15336946513371356279.launchpad@buildd-manager.lp.internal>
Date: Mon, 13 Jan 2025 15:46:45 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="6394e03793719e8d73f5a60b5439440e693c92f1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d41626afd9e444dc25de7856b49ac1682bb5c557

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3840197/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-039

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3840197
Your team Linux RDMA is the requester of the build.


