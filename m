Return-Path: <linux-rdma+bounces-9098-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4ADA783D5
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 23:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921803A674F
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17052144A5;
	Tue,  1 Apr 2025 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="GTmIl/oR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C120F078
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743541956; cv=none; b=u9tOLNqEZg84FYHxK5JA42TkfkFAVy1BTR8IQzu0ZyEQegxj1ZuWBPSoD+JMLzv0oZova/BXkueVYMtZSCleuojdxVgnbVeo7pmh8KrYVawP4ZHZNrWgQ7vZMk3jzff7YBKI9O0f3szEHIYxUw0yMQNsR3WTDXZuLDU07oeOD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743541956; c=relaxed/simple;
	bh=PDwWFjikiRGhWMYezXLa4ooWnKJOSfhd73yElDIUmpk=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Mpu8w2/IamlLO7tLs2yI19c30QLOZdO0gJEQq2OZlM9gIX9lInztptgbKZcTdfIGZixxw4h6gnGWxdT4NzFV4Ay2jdnT08NCzIlCzS3dcmiqQcniRJch5CkFu8eqDl2W70OUo9pDdpT86gGzhTWVncJfCpSB90sgiUiRvKlzVZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=GTmIl/oR; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id DFFB4410E0
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 21:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1743541387;
	bh=PDwWFjikiRGhWMYezXLa4ooWnKJOSfhd73yElDIUmpk=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=GTmIl/oRGS6HYLo4lwtERUCu0UVDzSiOa1gbQbIPSGXHBwyl+57kUKcVFv8jti+hm
	 VbJvGelOa5pZd29KKENzHgPfSE9s1Cv0RhXhj3/1D16ltGrPn9XowhZaxrUWfaEPCE
	 lQ4VL9F1CywHtpIbZ7pf8sRkhLZnbyEcM3Nd9hCcQEmNtOMDi0QnG5aj/lWFnBrXGL
	 XPJGESm6EF9pQYCjieoIf7fTRK1bHWa68sDGagV/5XDHvzpsbq2FHOk1H9rNYrH2N0
	 Yu55sDbtrw8OuFpTgd7thp6Bdg9kjUIC5T72Jvfo7QzUDW0cn7wZ0And2gbj1i1iuR
	 gsYaSIU/9y2Ow==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id D58F77E25B
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 21:03:07 +0000 (UTC)
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
Subject: [recipe build #3876259] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174354138787.1552665.16464693905904048701.launchpad@buildd-manager.lp.internal>
Date: Tue, 01 Apr 2025 21:03:07 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e76edd883483c71c468bb038e98836435de44530"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: a03f5c5cdd38f547aef8311d9a7614ed606bfce6

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3876259/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-031

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3876259
Your team Linux RDMA is the requester of the build.


