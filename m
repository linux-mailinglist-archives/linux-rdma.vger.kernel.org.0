Return-Path: <linux-rdma+bounces-2430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747318C3631
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 13:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA2F1F21373
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0121921104;
	Sun, 12 May 2024 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="FZfNMp8T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D71CD11
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715512667; cv=none; b=meESZk2Vt0spGgHvqls3m0NvjaiEOl5jqAM8zKxTrpjwKRVy/xmu1Tmr0z/RnRSq4NnLAsCi0EMiegvRgK4Z7ynZdF77d2G1dm2M8B8GJmz1TNEYSfoMC5Pz8qcC5zK1/1l2H2r1hU07Uh056T37yV6sYr3adNT2tPTFXy9uwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715512667; c=relaxed/simple;
	bh=OJEC+WX66WRBrt2U36j9/2E6rncSgaJ3Yf2aNfSEu80=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=SfSpXYmTswSoWmSuO6bZ/189XK4NvJao0IyAw5GdRV/0Wtr+58Gl5IPEuM4XYvEGla0KRJSf/sLb0WwGwTju9j0Ar3K1/mNg5SPlalzudhvhynLHn4hyHgAYvi0U2jCD7KpL3es0mRrMP+RaGOHNZnhuhkeIo1tkfomvlVYCKKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=FZfNMp8T; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id CE8903F07E
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 11:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1715512657;
	bh=OJEC+WX66WRBrt2U36j9/2E6rncSgaJ3Yf2aNfSEu80=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=FZfNMp8TpMl5xrIJsHveZhUYC0iw0uttLPORaCfzVW52gWwhvlEhkctblpUVANwIr
	 15tq14IpyZJVSUj8rCO941f8tl3CzmO0srCE67I6PWcTmq1rNHtG+vkyPwXg6P5tu8
	 i0W2EaYBoN5x/KQcdUh5U7KTdMKLybghnN2Y5anp6wRwJDAVFjVM1v0pXSNyuDlDnV
	 z36vhWo0ynjgF1IjEZV+y5wH0ZmyKFA+lLAid8ie4HehJuHe3+O9U2hltmnxKywKTO
	 O47228IiGQC+ma/GcqOai9iG0xuuD17E6czkZkD1f4U9QYSZXyymB1qRFTNopbfW8U
	 OUyoZsyE/byEA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id C60557E259
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 11:17:37 +0000 (UTC)
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
Subject: [recipe build #3725572] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171551265780.2844614.16418975023303506052.launchpad@buildd-manager.lp.internal>
Date: Sun, 12 May 2024 11:17:37 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="0e1f616671af724398db43b36ddfb3ed1f2682ec"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 70eafbb045aca0f1f4f09b6a9f82fc05ae12b3a1

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3725572/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-047

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3725572
Your team Linux RDMA is the requester of the build.


