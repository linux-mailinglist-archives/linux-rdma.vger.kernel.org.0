Return-Path: <linux-rdma+bounces-5937-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCC39C527A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 10:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915DBB26C97
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E120E007;
	Tue, 12 Nov 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="b/VSDaE9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728920DD78
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404551; cv=none; b=P2fApayxtFws3mcSjsrlTFdKuvV2fUj/vCdgIbVgtv55CzFt4aobhMR3OqBfLHDZbPUXEKKPrDYnIXAJr8OipmeR/BFYPKSBPFr8zykJ5+AhcgEAjr0NJ3nrdZa8PtohJOLVpMJeOlNRt/KSf16PFtkQw4vnvGxVYnJRPM6KQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404551; c=relaxed/simple;
	bh=m459/j/5ujcPo2CYgVX7Ua4iC5V1UX5oiE2eKBGzqnw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=d9VI9rT3Qo26a2dXgaYRzyjoyhN8Fbmcjtda7K3FdhWK/cF7FzxsVJK7SPTgzm9uuDk9MJ14P5oCr2jVaK/53wHhAd2DhL0TGcSVdiz32topvILpASKRN8MLoZziN7f43TqODHPWqBdwnfm+eFKwWKMzGX6WaWWiCy7tStNX3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=b/VSDaE9; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 11D0E3F1DF
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 09:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1731403953;
	bh=m459/j/5ujcPo2CYgVX7Ua4iC5V1UX5oiE2eKBGzqnw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=b/VSDaE96hPmF26BDF0ZygpCZnKO4lMc1aKQjSrY2QA9ZpuuloT0dOd4txrcqs8z/
	 U5DSKV4GVvt6b/X9mtQbKI0hHsYynwDHRNU/iUWvonZbZuEAhKhEKZ6sF+gey/SQfF
	 a4DuWl3I0OA4yfBsA3qsIZqLiMVzvXqnoTuEvre7Kw3efvgLQopAx9J2UkG09aczI7
	 OJrj9sTB7xz+uHMas4X8XN3BfXLK+vplMxQVXm1LfrJVA5nRoEPWaz3q9nRnVaCTMA
	 LIh6Osr7T8N03BTWpuS2tU5atbCxapv8Tp1NUuKE6j1Vjmw5uY5opRCiwViMBE76BS
	 BiXP9BM97GOOA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id EE6A07E236
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 09:32:32 +0000 (UTC)
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
Subject: [recipe build #3811885] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173140395296.4047664.9908601934196176473.launchpad@buildd-manager.lp.internal>
Date: Tue, 12 Nov 2024 09:32:32 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="22ade00ab50b929fac63b8ee7252243aceda294a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: caa3a1438a630db9fe6524dd12c96022b797716a

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3811885/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-082

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3811885
Your team Linux RDMA is the requester of the build.


