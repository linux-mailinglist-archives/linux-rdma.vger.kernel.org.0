Return-Path: <linux-rdma+bounces-8503-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1697FA58042
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 02:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B31188EC95
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 01:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED011119A;
	Sun,  9 Mar 2025 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="XV6+oChk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E12576
	for <linux-rdma@vger.kernel.org>; Sun,  9 Mar 2025 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741485189; cv=none; b=B4NoSTII/DHXPx5FpMHbi7pnOlRWqxkWQ50QOC6LR7FeawH1OrV55UJAbyRGe20oBvCX6OLI8FUvabPicnI566Yi34M5m3egDtRCgKAjdNFXu7uxX+Gup7910OhyoSVnB4GBZ5FhCRlOpS1LrET3DisNZPeWH4CQEd0l+Keh8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741485189; c=relaxed/simple;
	bh=7laB7Yit9X02RO+Vo9mFR8sv9kWmEZBlYK6nljXGlwQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=MvI7tJyp8uKe1N5dq2sA5IP4dmyjsU83iERaDy9zTPLymv8e7rW4Uabjyg7vNCQ/lzCUHTtwUVgxMfjxFYV48Q4K6iVP4b7Feo2ZZWX0sQpw2pap8pe1b+n1yz8FRerQGmzjZRRgLLCO3bDgA1sOEUeVQFPqJBZyj1AqWLANIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=XV6+oChk; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id C807E40D79
	for <linux-rdma@vger.kernel.org>; Sun,  9 Mar 2025 01:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1741485178;
	bh=7laB7Yit9X02RO+Vo9mFR8sv9kWmEZBlYK6nljXGlwQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=XV6+oChk2DQXDu7IGg1uwxD+Ie9f3FeLLFSyRqMOhx5oO6A9v/lYiA7i1Jk0NwQg7
	 TikqR6/ATt5oOZsHnBf9FJCPEUNBfRWavdrUu9ITjme9T0+YJPuO3KhU4JhyVqwYYj
	 tw+tToenV5Ftd2BCIZvkTbK/hQSn/BBYBrxX1YanLohkUIDd0Hf1Y5QHqtIzwMx1GC
	 GU5dVs+x9UyDbUl6UWNDiuC1eZDScgwe06oYBUTfW+gL6zkj4ay8pjh9kaoy69RXBf
	 ZqcqIDh4TOKfBcMWcng5/3a61usp/dAJ443igbP2Hx5g833/X+abHd0E+sH2rSO9vp
	 t6XkW1lTm78SQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id BE7D57E240
	for <linux-rdma@vger.kernel.org>; Sun,  9 Mar 2025 01:52:58 +0000 (UTC)
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
Subject: [recipe build #3864779] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174148517876.4188075.4620972864789648967.launchpad@buildd-manager.lp.internal>
Date: Sun, 09 Mar 2025 01:52:58 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aa29ae0fff49e4e804b39147c9f259d2fb023199"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 1422b0784a1a33dc581bacd2af47606f6a483981

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3864779/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-056

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3864779
Your team Linux RDMA is the requester of the build.


