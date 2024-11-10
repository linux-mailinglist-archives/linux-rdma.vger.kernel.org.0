Return-Path: <linux-rdma+bounces-5908-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40449C34C8
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2024 22:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7542E2814C7
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2024 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60814B075;
	Sun, 10 Nov 2024 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="fOGmJU+S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28C18E1F
	for <linux-rdma@vger.kernel.org>; Sun, 10 Nov 2024 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731274419; cv=none; b=H8gEAnnDWDfTfwbcL76XVbdE+t7ndqHmX3tRnhczrEVy+X2XoEVVByt9dyN9fxM7XnMm3SFaOEjggs159Zh9dzTWKumynvI4mxjuegU2yjvyUlJ2ZFLsKY1o2686HqtbgTmWZY+oYmvrufHaGXoZGfMDEbvKNsbddipkPqnM9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731274419; c=relaxed/simple;
	bh=McRTUULWlKxQw2tvSSaXDYPSK4nucaxg0hWvqMQD4LU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=gcOqG2G9IiqhdwBlP9MVxh2bEISpSdMFAl7aqe7j2EY692Rmy3aAo6vgNjmV1NX1zyM95ogfeLrjEcoo6oba8JOqpRbf6221XgHlOY4PK5uigzktU8pVytvpKXC4GZlLfZlYmBlcXsR6nJYBCSRquDFQlC+wB9ui1suWz03fKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=fOGmJU+S; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id CA3F0403E8
	for <linux-rdma@vger.kernel.org>; Sun, 10 Nov 2024 21:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1731274409;
	bh=McRTUULWlKxQw2tvSSaXDYPSK4nucaxg0hWvqMQD4LU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=fOGmJU+SFRKktnJk2gnm45OMMRs0rC6WifvyBz18PtIxT5AWwm5G6uIFUKCYi1n3t
	 D5im4rwZX7JM+qWi9JAz1rsxuEjjQG8s0DTsxz5rc2Iy+ibFFEblKVUvQdC1MEiOPt
	 KvsZDlHuIgfOlVouBuv18tIXpWO83aKIYlt201Y0oK+GVVW0b1Rzz6DOMOuUSeis5E
	 nRMaljZra9MrWghUeyaKpz+IoWaqnm4Zl8pXIBr+hs2EyAdwfD0W/3hK9ohx1tCRbv
	 GbQ0T6sgOcanEqmQ53s0JIjdZqjAbm5IGqM7Q2Kf1DPFJxZVFhGYMeu64UYabzhPOk
	 YcT71G6E8hgRA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id C0CC184909
	for <linux-rdma@vger.kernel.org>; Sun, 10 Nov 2024 21:33:29 +0000 (UTC)
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
Subject: [recipe build #3810848] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173127440978.4047664.14542998531145117840.launchpad@buildd-manager.lp.internal>
Date: Sun, 10 Nov 2024 21:33:29 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="22ade00ab50b929fac63b8ee7252243aceda294a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 743f1601faad54dbd44e05280863a738f3cb4742

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3810848/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-096

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3810848
Your team Linux RDMA is the requester of the build.


