Return-Path: <linux-rdma+bounces-2688-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF88D4B5C
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFEAB2388F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 12:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476561850A0;
	Thu, 30 May 2024 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="SwfD1G1a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8D1E489
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071340; cv=none; b=GK9f/cTuLW3SOcFEIF+Aw8atEAq7SmipQqnOGWLbK06KgNd6xRdeaOMatQfpG7HRViOb1r1n1DUs2uuEsqEPqNpuO47HgSdiddef7g+O3QUTqDvtRDPsPjwH7p7bVqHv5flkwejgfTEKW4uEEh5VMgGavD/BOrJTI1Nb1/VQhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071340; c=relaxed/simple;
	bh=rrgmchlNtq3OVuE83qkVkfzs8qhfjGjfM/v43EuOln4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=XTbx/piuTl7/MdZXnhgTvOJqczzBdk1awGHVmJdghjAl1jfJll58n4QK3e7APiKSn4nknNVf8HZfWwUrRejiWOVZ2jqjlFdBvsSbkn74XOO11xej2lTpm4efHZAeGArh+nc4ZBzGW5T+sEkLRCUN+RVH3fvqrLu1cIH41w57CvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=SwfD1G1a; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 864FC40450
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1717070829;
	bh=rrgmchlNtq3OVuE83qkVkfzs8qhfjGjfM/v43EuOln4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=SwfD1G1a0beS5IZlxn4nJjDzwrSRxIsCtHhrWV4Jb++AlGh6rZ5TZl6MB1q3q8nZ1
	 aVeA0oUD/QsvolKLtLUwoglaOk3MTTt3iBZrqMj4H0sjHBEU8GfmPFLR8oXbayyI3h
	 iDt7nsChxytTEpGePZsu/bf4PzhhgYBjbrcK9u8AcM46c8vfILadmz/8xYbasflqz5
	 d0v3kj4gVxOf2xkPlczh015Mxtw80EbEwYvCSmJCbBvczvP/YG3Qgy1hbLCCrsAH1j
	 gXPZZicqADalHfGOzr2URw/9AkiHLrDGeRQM+nO6QSHBYwf+FLYefUy5D+vnnKRVlx
	 4Ke14bnbGuOtA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 777A97E230
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 12:07:09 +0000 (UTC)
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
Subject: [recipe build #3734512] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171707082946.981272.16336342277553728182.launchpad@buildd-manager.lp.internal>
Date: Thu, 30 May 2024 12:07:09 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="a60fb269857abd7169036a2da5afd37a6a1d41e8"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 851ccb06a8f3e18e1c16871094bf6d55e2159e30

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 7 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3734512/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-027

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3734512
Your team Linux RDMA is the requester of the build.


