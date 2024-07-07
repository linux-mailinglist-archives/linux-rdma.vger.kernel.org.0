Return-Path: <linux-rdma+bounces-3694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7686D9297B9
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 14:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08101C209C7
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261D21BF47;
	Sun,  7 Jul 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="JyrTF4Pn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38C1BC43
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720353719; cv=none; b=unXCS11XYig4p4+2R383Y5OPQbF07A8wSoIRgYBY6fdJPNx+Fsd7HgC2qMK0s4S4wLY+PQoBdHXAOy4bQzLQCGIsEZ1s95ON3AK9C0UmE/Oj7+S5NhQlc3/RvEBUWIMAFnJYSQBYoH3j9YV6lXf7aNZ+/ez3gJkNAFmLljwfahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720353719; c=relaxed/simple;
	bh=rWj2fvuQLquLnmVnW+lvEoyT1zF4I9xaYw6ch4wKOPI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=iYehBtdwCacfnnrrlkW0tCj83Lm0f3/UWfZaksqz6NoxpFCVg9tkdnw0jN84XB/Qs+v291+wGSnOgr6KSoLRGmR+7KxHn7ijgGPjvkY3U9aIuRSBHTciSb25WNKK04ve7MGgfxMMlk3fYKs0wdKGl60VvF0mxgquDkiXky1y9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=JyrTF4Pn; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id AD5C040ABA
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 12:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1720353710;
	bh=rWj2fvuQLquLnmVnW+lvEoyT1zF4I9xaYw6ch4wKOPI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=JyrTF4PnLsWxrRh/7zfGyNsQmXJz/aPZ+VWF5YPQ0ZxnNtuS/BqwsJ1QOB8Wb2t9T
	 AcWqKcj50JaqJ1aKo+kponppWwnHnNmGFJZrg4XwfZprkIdWsAzXDJSF2XM8wDCiNm
	 A5hieg9pn32mav0Q5NBAsOH18kNYdCV1Dya7YtFLM95iCaMrHVTkXxuUqGNDhT6jGA
	 4c8pvlAysXC6/5u+Sl5cz0Nqp+lQipWOmmTPB6NmKUwa+8APwCL/xft4tX2zCT5ZlE
	 M0V/exIsQlO4ZboumNZOzZgN/IRaA0gf1PNYevgPUQf5cSAcold4/ussLZSEqF96Xl
	 6Ez9pD9LhXY1A==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 9D7347ED16
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 12:01:50 +0000 (UTC)
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
Subject: [recipe build #3752815] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172035371064.1591207.7289828304825081051.launchpad@buildd-manager.lp.internal>
Date: Sun, 07 Jul 2024 12:01:50 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5fbea204b583981d0dbe89fc031da2a101ce9735

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3752815/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-037

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3752815
Your team Linux RDMA is the requester of the build.


