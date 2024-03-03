Return-Path: <linux-rdma+bounces-1195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17686F595
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 15:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5941A2860CF
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6726067A07;
	Sun,  3 Mar 2024 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="qA8m2kgZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FF59B72
	for <linux-rdma@vger.kernel.org>; Sun,  3 Mar 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709477203; cv=none; b=WbDn4Uc9xjdVC7lAKad4vyuD6VaFSGjBjbABmdjntLWz63e2WSX2Z86eOA7a2s+z5uZuws2nZ1k6ONDifI57JTjnIC6mdX3Ug6ZGyZl2Lg9DVJRkXtUnJpJ+q2uqBjOYRl0lhU/TChCFSWELNV9A/I5sfl0fRbpBnGNELvMhCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709477203; c=relaxed/simple;
	bh=kRR2tpF6nvYalr2Z2RxitPjY+KbN/XfteTAXIzDM2Hw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=GsBdy5NF9F5oEDR4IU7m2qtF96vSjNfNgTDft9zo1xkFaL2e43NIgbPzm/aQDwjEBi3W10065I1ynflUehUCZkeZ42RmqZq45iCc30DD4APTs/kHnvjvMFX1s8yRGWQyMcS6VR/iL+43+fWTzUE1GcMLyaQxnUfg0OrKtkPPXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=qA8m2kgZ; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 94CCC411A9
	for <linux-rdma@vger.kernel.org>; Sun,  3 Mar 2024 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1709477193;
	bh=kRR2tpF6nvYalr2Z2RxitPjY+KbN/XfteTAXIzDM2Hw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=qA8m2kgZC5VKQbbt0IPlJ6y9FJ4I2Rju1Pox3OiFjS/uLCC6rgdPIbpJLbfQe40Xw
	 UCDmXfdijYikj4kwvPe8gpYylhCLxD98FiVoEG7Al5gEToOyf2m6/jW1cPIsjPfNlM
	 JVs3sv6BVt8a1StHIWz8SDycjYG0tNJxZW9yZwrfxEJog6fIu5QR/tQI3NSb6M/7rv
	 zpq41VAkGDh+DncSzpJrxZhci5bYKsK9jk7+8GkwCMoW0hkB9YnmhOajMLqEbjb2ee
	 8xHMnHUNW2DsDrb3Ut4Wb/wWYkIacJS+2SmKpkyY5ViPMb39XjT+eCrW5ixbqqjKJ8
	 WZ8LhyEFM6SLA==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 7A59A80ED4
	for <linux-rdma@vger.kernel.org>; Sun,  3 Mar 2024 14:46:33 +0000 (UTC)
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
Subject: [recipe build #3692247] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170947719346.1614976.6756256216968738212.launchpad@juju-98d295-prod-launchpad-15>
Date: Sun, 03 Mar 2024 14:46:33 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2e4955e3d556e61e2eb54acf7a827d17e9e46822"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 152bc84fe465e6086dda9f61e4b137efbc166f1d

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3692247/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-079

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3692247
Your team Linux RDMA is the requester of the build.


