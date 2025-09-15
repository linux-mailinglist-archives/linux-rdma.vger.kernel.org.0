Return-Path: <linux-rdma+bounces-13377-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C18B57C18
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C101887737
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F111B3002A0;
	Mon, 15 Sep 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="VdtbDKpG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F11B7F4
	for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941059; cv=none; b=N+GlzbZANGOsgSbDEySOOG7Wzf9RFhIt2KnJoeWrtyzHMVhvsxpCkSJdY/bzxXhGInIWqF8nwNDGyqasBQqLOBHRDC0esA2IM3ZnEwo0vlxyTHU746GugsHxwL3xHDTZmqk1AkAHiJ+K9NsqTQYg6E6eLWzWYkx3s8JnWSMP7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941059; c=relaxed/simple;
	bh=l7M6UUxxvdZ7X1VEccbJ/uaBop0xTBouOHa01tMh0uo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=CgTTsa4Z7C5fCo0YKTG5GSzAiaY75AuHsBqlHnsFSsv4rUkYVU5s0DD7dgZlglkvQ+wG0DPXHrKjaI5bRtzeRGJZx1gZ1ViNIZvDLM5DEo7ovjdvdnwLww7lXQjX4j6ES81+vDz2JAwlGjRbWSXzpuibgzfFJg2JY7w0Xxj75O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=VdtbDKpG; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 3EF53400F8
	for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1757940651;
	bh=l7M6UUxxvdZ7X1VEccbJ/uaBop0xTBouOHa01tMh0uo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=VdtbDKpGXIua+IuYPlvIFLcskbxwinpGwAEh335U7E+JUMT7PszUM1UCiiEKTEpBM
	 IY+NXtyJE/8CADeifvv/ru29Dfb2Lpi1liuD90HYM3geUScTs9R2Oh6J3oMfpHE+oZ
	 gjw7E9isXklDY4tZ2VikIdiBmGIpwXx16xy6BzMZRFE8XFSW7utBvoPvR6qEUXC2AR
	 JUF/rcvhD8bttTYDUtE5DOAUKbGXvBSkqscwzWsmJ72b/YYbN7fAO/UMfxcgFDcemU
	 LV2ek7UCQobddYF7FDSfhShLyRrVsUrX/SOzdv1hioYD/xpt7EusowF4gjeWRCEsCx
	 /5pG1YOIGMHfA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 28CF284794
	for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 12:50:51 +0000 (UTC)
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
Subject: [recipe build #3945621] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175794065116.787612.2618285125478901466.launchpad@buildd-manager.lp.internal>
Date: Mon, 15 Sep 2025 12:50:51 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="3db21b43f675a56d404bb64e0fe1fcfc5dc01a90"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 565b4ae5c3f19fe4c9b810b419f78cb8d991778d

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3945621/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-061

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3945621
Your team Linux RDMA is the requester of the build.


