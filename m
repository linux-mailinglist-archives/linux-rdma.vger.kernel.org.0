Return-Path: <linux-rdma+bounces-9648-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEAEA952E7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 16:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBF03AF9B3
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9761519B8;
	Mon, 21 Apr 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="GujOuAL6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74398D530
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745246393; cv=none; b=O43cyvC5zjfbPYcd8PSsKwJ322Ph1jIkzgSBlTjMS3c1FcwaY+trG83nLEGXwcaGGC11BnVVp5CKB4nv7DF8o+gGsxBaQ5114k29jzODOG7M9w/YwOLGt8gMAsR6FpFZ/6benpInYJM/Q+BJCYYp2UFkOapslCQOYD+3BzVCWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745246393; c=relaxed/simple;
	bh=5oSVPdPIbKgFCl9cHos7Aoi+O1haxZS0ljJbOTIca/0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=QkA0qhG9cQRQAe7dmV1lkYW3z8XG8YbqQE/onVh0rOmETNZXktqi355lGJgwwLkjBCcEETERQcntoZtFSSx92sk8/TFvK4gzCAsk1HO0c5HC8YNQo1QHsU2i1V9N8Qv4ANAqxRq8BPjUk153jANgqIP+RBtj4V9iAV5T48P8iOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=GujOuAL6; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 903983F20E
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1745245935;
	bh=5oSVPdPIbKgFCl9cHos7Aoi+O1haxZS0ljJbOTIca/0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=GujOuAL6bGi9lPqCXUwQTNADRFZEHT47bMY+MR4X+hFABzEV/qClcVyzNB/m7nv6X
	 vKnqoIGxuEaXvE37v9H51pypQdJW0JC5oaoxqSMBs9jz/fXbRKtZkc+7gkTV1a6PP3
	 DlCbg4T/cnkWz32a3cDHWO7+u9Am7tYOJKmLa6HHAte4ywsIQBAjeHR0ngbZ62x72f
	 8MGf8C8xS11F9P1LruoR5gOko4ajmrIVCWrL5+qvXmGx1ojQFS5bZF3HpFNgZP73ia
	 uIoa0riwRnuxPXiAqQ2zw9w4hX2xT+C4GwMQgb8tEdiO7Owc0ixxeLkU/KhEa9FkLb
	 yCROlgc5e8/3w==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 80DD27E236
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 14:32:15 +0000 (UTC)
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
Subject: [recipe build #3885982] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174524593550.2962190.15317599854969782451.launchpad@buildd-manager.lp.internal>
Date: Mon, 21 Apr 2025 14:32:15 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e76edd883483c71c468bb038e98836435de44530"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 94fc5c289814eb11cf77dcff9fc17acf0d664841

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3885982/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-016

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3885982
Your team Linux RDMA is the requester of the build.


