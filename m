Return-Path: <linux-rdma+bounces-3596-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47D91E6D8
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 19:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0712855DE
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 17:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320816E89F;
	Mon,  1 Jul 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="BoCZ/7/f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195116E883
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856048; cv=none; b=As5z2WCrD49hcSJQ0l/D9dq1qLNTvVbvsITz2D9Wf/ZnpI10SSuOjJb9U2X3fcns4K2k4lAg2vG8Qq3oweXLLkxM1dDuSwB6R8VBnSUS1CbqDzKNpdbcdL/FnVY8aRTndYNiQfB2ggXVCoEJeQuzls0HI+S+VIuykKnG3r5rCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856048; c=relaxed/simple;
	bh=r2Hrq5aAyMQmzhUCm62p3+BUNSKMMyGsA6Z7Hsv13ic=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=DGFMQz1Dsh3z6ZtJ/c6OKaBpKSBP9Mgt52JyGGteRtHngnBHxt5cxPQEucuwC1LEJ3iTT7k15rUbi0hkqWBS47sxh3oa4Bs89g3yufJNDUKk0hYI5wWy7t0z0sXBaweNsQiHwA3KEPfM53sqb4IW1JCjBpKkzRsS3hmaNaUVAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=BoCZ/7/f; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 2F35940AAC
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1719856038;
	bh=r2Hrq5aAyMQmzhUCm62p3+BUNSKMMyGsA6Z7Hsv13ic=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=BoCZ/7/f9RsRg6wg0znEXGl5L5oT+Z9PprhYyYBiBAtY6QXOod23nPGRuHykuBCkg
	 LzbwmWUDDT0ZDNNSf4IeEQE5mA38E390EfVsPy9kRJjRCXoNZXUrO5AUcOF9n2vZRL
	 3nZE0vst3llWAHO+2FQcR1XIgnZ7AvEAUcDMZkEJ9LDb/KxR2+uI2NZfYVUTaIaBcO
	 NBRMJIeANOueK1het7TQL/jo4bBMepsHjCFQUqt0M7gDz060fwV86mK+lVLJLS573D
	 mOSB2KNUiWfYLsKsjsqDKWU2pq6N0O94QOJDWetOlsLz6XRUOTUyGGwzD6nk6rclf2
	 JzeLNtSpIzcHA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 0DC7D7ECFF
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 17:47:18 +0000 (UTC)
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
Subject: [recipe build #3750349] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171985603803.32807.17462664284663720328.launchpad@buildd-manager.lp.internal>
Date: Mon, 01 Jul 2024 17:47:18 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 90730dc63ab4e7b4c4b47c9d585303fbbfb7ae66

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3750349/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-107

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3750349
Your team Linux RDMA is the requester of the build.


