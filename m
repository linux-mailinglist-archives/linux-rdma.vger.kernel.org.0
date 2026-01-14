Return-Path: <linux-rdma+bounces-15552-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD0CD1F51C
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 15:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F20C83002966
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AAB2BEC2E;
	Wed, 14 Jan 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="tpvpeUFq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56C2C08AD
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399576; cv=none; b=tcG5SMC0viQkKeEDmiw3cWKduTQMGCqFBxTREjSvPZZCsatskZc+bHKwpp3p3kZ3laILeYx3OvodYccoQ4EAtsjJ/rE/wHXGQ+NGGGeoGpQJP5ngseQNgPKWj4ObiMZPxRY2mvlk7FXWZNgkbFb/wfL7ZheNCJXk1pnh8qT/GIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399576; c=relaxed/simple;
	bh=35zRktk/0ywLbs2+4fcawPriwt9H95nnBD7YmI5jU8o=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=BGBKLlEfZKkMllnMzsD4m28trZYfQA+nKtCDLekUTXEam6eZQGlb95yAFEkQp2/GIFflbxikCNsi06wvsHbbGOSL7+7FMN1dWnFcvma8EewuwUSp/GO/yb2r53hBsnPlyDVkWv9csryhHC+YpSJtqAP3u3pG+CoQb4BqN4xKxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=tpvpeUFq; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 130DC3F25E
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1768399566;
	bh=35zRktk/0ywLbs2+4fcawPriwt9H95nnBD7YmI5jU8o=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=tpvpeUFqNQQkxIkR7RlgMrueXJVosRL6wxBtRiLd+EqXap4unDRdJVNx2Q2J9N0t2
	 Y+3V2bU/bS5hyyXAb3v+QXHHUzp9vlDr2xn9ew1v5Iz2kWXbwiC3D4fGvB4+5fMa0r
	 U9iNSJGKETx8vpC8S5GbbfmfA64kGIHrFVSVI2nrYqCwEz5BfRrGb37orl4b1TVzqR
	 X0zT3RVxTf/fGKsVyFaJYRbvmvvk5YhKhVwlUjiQhgRNEBIvqSVFj1D4S5O25ThL94
	 daSISZKIJBWWZg8/bRQ1WGSsHlmackfLhPL9G8CPKHUnxEdJEPKgpn4he+UoYnhQ6W
	 GWuDiaKniOPjw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 026257E851
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 14:06:06 +0000 (UTC)
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
Subject: [recipe build #3998054] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176839956598.3160048.9921553700695537158.launchpad@buildd-manager.lp.internal>
Date: Wed, 14 Jan 2026 14:06:05 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="9fcfff1971229ac997140f06b41a902ac8ec69f4"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 0a6ce33d7b1bac76e2e98711b3530792f72eefcc

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3998054/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-019

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3998054
Your team Linux RDMA is the requester of the build.


