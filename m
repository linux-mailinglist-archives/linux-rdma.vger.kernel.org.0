Return-Path: <linux-rdma+bounces-8020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7EA40E27
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 11:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3A5179F52
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 10:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171462040AF;
	Sun, 23 Feb 2025 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="tu176Wgc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144E1145B16
	for <linux-rdma@vger.kernel.org>; Sun, 23 Feb 2025 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740307619; cv=none; b=pIxxwNiwmtsGPBlXm6wOSGFdZQ9M+neK7R4xC4nsmGWgZuP7KsfSv6fR5RfQLX/zJslnDULylPUxKA85b5/GpJVOJe2EP0Nh3Kz1O8wZBqIeYu0FqV16hl5AKSNefb0JXOXTFY7LEaD3qAp28tbjwwcn1c8fgKcxO35rXqfHcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740307619; c=relaxed/simple;
	bh=sC8Ul5bn5y3iMSI4WOyPMu59wm5L5GmEXJJr1yC5jo0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Y5hgHJK95CnRfbAyIgtEOosuVnNEMvE/yLR8PDDlD8mZEQqvvnaNSpHn155jXmewjiRVy64KORSieHWce8YJ19DCdV4oa+sosQePgX5Yn+4kmcr2cGI0XUHSAFXKJ25FSBpJlXYs7AALeYyPqquGNTs71lOhuZzOXF+pl0IpcMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=tu176Wgc; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 3E79A3F219
	for <linux-rdma@vger.kernel.org>; Sun, 23 Feb 2025 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1740307608;
	bh=sC8Ul5bn5y3iMSI4WOyPMu59wm5L5GmEXJJr1yC5jo0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=tu176WgcIs5dF8gDzzCa/4Viu8djAwtZI0V5UCui79VsV/qrHuP+C5aTg3y8Xh0lW
	 6D8ghvmXn5KT+N9drtXp7vMpjfK8e61Qs5tVLtdCjgZ69c2+NPsKX3gCaPBt3rC3ve
	 4IqNW7OQs6yUpDr3bx33tIlzGQ1IXn5j3GpF4jBihzDM2rkwR5TkRscJRrBBcjrrg1
	 O9aXYfPiR0GtXpuEY4cNkXi1ufifjvQzQcE/eqKXVEBf+vYgLABtax5uiBwWbuNwpu
	 WJEk592BISH8CS7OcM83watAu74I81EJSCwyhMgD3xHBwVn7HrnxBp5OmAdeRLRGVa
	 OHJ+RP3dFXgig==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 335637E244
	for <linux-rdma@vger.kernel.org>; Sun, 23 Feb 2025 10:46:48 +0000 (UTC)
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
Subject: [recipe build #3858276] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174030760819.1613549.8239045641345974907.launchpad@buildd-manager.lp.internal>
Date: Sun, 23 Feb 2025 10:46:48 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="78860d903de6d6d7dd5a0ade63efaca45d3467e2"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: dae41f77854dae5e5d9d305fb8cf67b061c825c1

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3858276/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-017

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3858276
Your team Linux RDMA is the requester of the build.


