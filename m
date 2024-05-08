Return-Path: <linux-rdma+bounces-2342-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B1B8BFB9D
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 13:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22E62810AB
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 11:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C226AFF;
	Wed,  8 May 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="YfEN9B50"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C181749
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166634; cv=none; b=U4nye3eQ3BvLotggBzC9hGIKWC90KdyZCh2InYN/9daPVtUBmhKQufSxboP/QZyB8B3JRTAP5zsrYMyzi7j0aySTkP/l+e+x/2H7YKBSyrF7Z8FLhuYGtqgDFzAoL7Yd5/cXY5/NvgHEOio7n+pfvBtnd1j2yH/LO2AWPao1vH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166634; c=relaxed/simple;
	bh=eaKJOGNf+HSYbKbH50giDEJ6v+RF/9tswMUqVGFjbWk=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=o72QbEVt+oQ67Ta+jv5eCU7LDHYkmaQ4Thu/sorxEIXc9zRW5BHh+EMKeweUfuhkgt6Ujm7y+3oTLGr2xQlUHt0lwU1XmjnNQR/2rfqwNvb08oDC5rma20DQCE9bOMMUIfEvABz12M0e3mM2Y83BSAbxczhqmEKzptTkGwOC+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=YfEN9B50; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 8543742B4C
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1715166244;
	bh=eaKJOGNf+HSYbKbH50giDEJ6v+RF/9tswMUqVGFjbWk=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=YfEN9B50YYws4LcCqh1n23g+A4opRKaBcT9kiwbdHyVv03cL5dCVsL39ZjMwnH2ns
	 1G9CsIuZSeopnG3YFwkj7KDmY+ooFpitq4rtYlyVsLVyeagi4T9DfGuZwulNbs6KRv
	 Lyop8n0n0YyjIr4yELVLwDjWCCqx2v5k2yZXuvdK5TQDDrJWiLrpcbzE/j8ZWCadSD
	 eHH/noZNJnwWq5zv33oabC4Vv+U6hWAvokjYI2QuX2rWurGSojfCVg0ThNPCJdA+YP
	 JuvSvjYGOenZPEjg2IjESED/bpxsTZxN0dyvBp/7Wcda0hpwO5EWRBPadvLWcEFWbS
	 lYkjQF2EqpFjg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 7839D7E233
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 11:04:04 +0000 (UTC)
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
Subject: [recipe build #3723474] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171516624448.1886921.16248605658744633320.launchpad@buildd-manager.lp.internal>
Date: Wed, 08 May 2024 11:04:04 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="f33e6521bc5e85148b1c93453be6e27c66f3b541"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2cd3746ac00b1bc3ccb477ef3d9e10070af0194a

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3723474/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-024

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3723474
Your team Linux RDMA is the requester of the build.


