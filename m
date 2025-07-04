Return-Path: <linux-rdma+bounces-11904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB78AF9ABC
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530FF1737FD
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A265521C9F1;
	Fri,  4 Jul 2025 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="OamqklJV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5D2E36F0
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653648; cv=none; b=BogjUq64fJ/O3CLGZz9xQVTbWyGrsMvF/XQLKVEi4D0Z1sKyp1FA+GKleDxxbJdAz5s3mVgsvJ4PBX7G02DSL2iJ6ZZEMRm6oCC16Co7obKcduNIMoLWHGUmT9rdQgpXqp48AK1qOR0umwGHAAiZ28Jplq82YpKjytZDn64BTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653648; c=relaxed/simple;
	bh=eX3xZ9T1Y0niSe2TvBB4Lsu87yMuaMcBHJ2LL1Z0c60=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=q25fsRARcodKnLvoVBEhhWNTZ0yrd0EuRcLfPADD7c/CQ/v2PXxlRNquy5lCZe7Dk68vn3b0fd9P7l14mfm+GecE1T9u4q31Hdxf+OE2HbAjKf7aeqRguREckD7UYmcgkiLj27MllBpGwRmacH32eYNzCRGITWVqdBErY+vFvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=OamqklJV; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id BCA973F181
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1751653186;
	bh=eX3xZ9T1Y0niSe2TvBB4Lsu87yMuaMcBHJ2LL1Z0c60=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=OamqklJV6V3O8NeobYUalvo70102lNkw6acoTi+6iil0tNKssMk/vAf6F6+g5+RcE
	 DzvTcEw7Xmk221zHQNYp5dZxkyH2XL3WB645/EioDFLQErHuaGj1D41jr1RiGJWd2H
	 fdf/7+L2ZPtF4i770sP0mT+pxrVIwL0WUnXUfHaZCtxctImZToCfj3qehUIrKG8f+B
	 cjp9toXdWocHEWU8GVHuz9sZytMBy59DFx7qSx+b8+r2Pv/S134CS8FGQbtLkb8DW9
	 4ecxNMMM8fp0peR/taSaPdg5qIeuIrZ7YmdRtKZqsixnnfKNIT78+thhT5ycoCnm07
	 J03/inUQ3zgUg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 8A2A07E6FB
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 18:19:46 +0000 (UTC)
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
Subject: [recipe build #3918307] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175165318645.3196303.16761381727326441310.launchpad@buildd-manager.lp.internal>
Date: Fri, 04 Jul 2025 18:19:46 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="b5a18a1fb2c651898dbb3172b738994271938569"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 3beb17777a6654e2d8314cd2b40ce3dcca4cdb9f

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3918307/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-063

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3918307
Your team Linux RDMA is the requester of the build.


