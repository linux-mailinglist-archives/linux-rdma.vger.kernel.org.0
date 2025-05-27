Return-Path: <linux-rdma+bounces-10752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF88AC4CCB
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 13:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB67D17D99F
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B424887A;
	Tue, 27 May 2025 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="RVAkHk1c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015F18A6AE
	for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748344347; cv=none; b=KiJ6aSlw7yJECkNJcMoaryec6PxXJMxHj75LP8yB/lJqBsoMWb9WsOT0cE7eT/BjAF3QA9vMrjMv4TF+j46vu6BnLN9guXJM+QxeXiyX3GilNpQ4mAM0lK05T2oi7sgg3Sic8sptVuGDx7wWN6A/MZceF5gjm3v6GK0l/Y91bCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748344347; c=relaxed/simple;
	bh=qBd7sGFeYE3UOKmEMZ7QdNeyxCoAXbcELQE/Z+XiOsk=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ZAN75+d+tuiHaQdg3QApCHMUrd6BO4mrNHqziV/4UVxOWHDmw+ISMKXV5EsOwoHmEtWzEux9uR2aQ/KOtlalClPkK9DGbZCGmZI/JrVjIGdIRMxrmBsXhUEsVAz6onqLFR5QT5zWWXmc4AQPe4Y+AmDfvtmCu4s6e/WzoF6GSbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=RVAkHk1c; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 0EDE33F303
	for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 11:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1748344037;
	bh=qBd7sGFeYE3UOKmEMZ7QdNeyxCoAXbcELQE/Z+XiOsk=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=RVAkHk1cM+ZzPAII37OoQGjqMeB1xQxoa88oGqYgDWMLz9en4rSvFiQM95gJnh1TR
	 CVKzUHzDEfqpsul+YE/APGBWQXwSs5NyfI7WIKinQiGRAdX0aXzVV3z1wdMAAVXx8f
	 mCPlbI2QqhVdlKsW6DvlBLor8sBc7W7/pm0//LhIdgDSgKtfk9JRwnKH33VhtdSC+/
	 TSW1lEHu0BcQlGxjQfoc8UNTeoGDwb92dDK62T5wdzAfdoNOjRaTd3Scb/OwV/isbh
	 MYPZyasrMA2tbv95Vp9c6xyvsLG671NxNbbgTxjHVt2k0xrTkZkO8tnI/qo02Z+BJi
	 z8cOqICfAoLRA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id E4C0B7E5A0
	for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 11:07:16 +0000 (UTC)
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
Subject: [recipe build #3901036] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174834403693.1300374.1395121727948490974.launchpad@buildd-manager.lp.internal>
Date: Tue, 27 May 2025 11:07:16 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="30048e740966359d3041f59a477700a1cd51464e"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 112c47d616c4d803927d237e1d4a58b2015cd80b

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3901036/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-049

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3901036
Your team Linux RDMA is the requester of the build.


