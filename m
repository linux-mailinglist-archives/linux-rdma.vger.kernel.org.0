Return-Path: <linux-rdma+bounces-14049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B31C0A409
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 08:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2CA54E4CF3
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 07:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48526CE32;
	Sun, 26 Oct 2025 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="PU43Bieu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC71255F31
	for <linux-rdma@vger.kernel.org>; Sun, 26 Oct 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761463347; cv=none; b=f7s02MLy4ULkKXaSZAqApR41B25H8WST9vMeqLD0JceOdIUxNxwexYGmxzYyFyqauA8a0+zv2Ok3w2CDGC/dbPEdBnk5L4rebb1h8aQzPbPuTmLSfPLntUvBSd7sZSDiSAoz8CxHplWsqGyk71u7o7maXquS+EgTw+nwUgP7A0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761463347; c=relaxed/simple;
	bh=Q6XnVjZlISwhlQyDsJ8sgiCre6/epmRbE1fRbXAb8yI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Yn7N/94mgdYZx4YV/HriT7GvzZSixgjvN9P+f/eywke5dTacHvOEkj3+dZKUIOmt1NIG2hL+Vo66nz40yuASPuQjUM5gl4nsCVj/yRyjte7uhM94FotKgsm5c9iD0rU0E9LMrT2lk2qgDfWZBN1nI7mw54HytIqrm5g0KnqnDL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=PU43Bieu; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 455C73F080
	for <linux-rdma@vger.kernel.org>; Sun, 26 Oct 2025 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1761463014;
	bh=Q6XnVjZlISwhlQyDsJ8sgiCre6/epmRbE1fRbXAb8yI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=PU43BieuvyHHvyoUsKOWpehOGe0JHjI0NVTfBa3ZlmXCIMfvoVByuQbkpOJjkYOp/
	 Wt2MMV14JfQqeMFJqZ+zYhiWA9Kxk2rq5+SqMvj3QDr/wb0sonNWUDFwqoffQVlnEz
	 N9yq6mpY4jlMhVVLKRbQqYZtz6Cedj0vbn9YtafrapivEdUjPe7tHM+gJbXp7uqLTj
	 HhYtCEfYeviIaUtG+kYR/mULWmjla/7Ub5e5yzTwYKkE6q9cpPQpES6wAqXYieyyXO
	 vOfPaT9Qv30i1fXRAkh3m7CcKAoTE5Xt9Uvua5HVTlhySD8U7fFRwVGjQOg1OB1OXW
	 X3v9ERZdFj0fg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 305B07FF2D
	for <linux-rdma@vger.kernel.org>; Sun, 26 Oct 2025 07:16:54 +0000 (UTC)
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
Subject: [recipe build #3963074] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176146301419.3193834.703959231533797808.launchpad@buildd-manager.lp.internal>
Date: Sun, 26 Oct 2025 07:16:54 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="85440ec533b5f0f56d72cb53bf7a09726604f8f5"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 8cdf36ba8105b94ad45fecb75a316ee4c7d5755d

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3963074/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-010

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3963074
Your team Linux RDMA is the requester of the build.


