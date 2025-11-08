Return-Path: <linux-rdma+bounces-14323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230DAC428D3
	for <lists+linux-rdma@lfdr.de>; Sat, 08 Nov 2025 08:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A3D3AB540
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Nov 2025 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891D265620;
	Sat,  8 Nov 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="c0do3Zme"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5FBA34
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762587128; cv=none; b=UlRj943CcJCotVrja+mRYCqayT1YqjWOwoh46W6N/0Kc3tqQNPapoOr1LT3E+WRs3GInl4GmAACLoTPu6pgmXc9RwhbkxcsKYqzTyVa8XLC9+Z0/xfsoAe+bXLiPCty5AmVNSexhmCyae5AfX+LzZi7o/yCcj25xCo1MozejlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762587128; c=relaxed/simple;
	bh=/P38kVqBxaW4Z2AvTJJVJFrfLgJM2ZuSgaAjowRhI8w=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=iSdyk9oLKTy73saXm3qq0NOHHZCN3k/uEsqGBZ5xKBnPlAyFZKtTT1Q1mLf1LLr1IbeU9dQvu6jyy7GG+rGzNa03bnbvda0SL281qz29JPtCd3GIqBj2LqgRFYsjvG9Gzitnq1vvmIxCGdQ/7uZqldJ2syebe/BZRomhIx89diw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=c0do3Zme; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 63F003F150
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762587117;
	bh=/P38kVqBxaW4Z2AvTJJVJFrfLgJM2ZuSgaAjowRhI8w=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=c0do3Zme0EKv3Vqc09oZQfQUta3Ob9LuIwew201TPMZvDxLxsCFJ2IreKtGAgVh+G
	 0o19HMhS5CqtsH3bxjoJ4Npo7Rai+15/4UcaRES714yZmAdKvvHeLC/lCXpjr4wmGY
	 dXZRIcE7LGXKFJSUzi7tHeD2CAvdIQK5EdkVjskdZ7YpmM02NHzR5s3WkyMZU+mQGv
	 IxIPVqtG+kSeyh1GDWolmDQmOXQyc3UFoQg/Aw+2T/PBv1vTWXCtWqBMIGNA0HbZkL
	 SfRxhRIdVm8XX0qA1O8vrdJBRZB66Ib1bUDw1oYszkrfbZhAIjCblgU1iSDf4FUmsx
	 SUGA39SvNknaw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 4D0FD7F148
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 07:31:57 +0000 (UTC)
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
Subject: [recipe build #3969287] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176258711731.1218157.7141918048297085653.launchpad@buildd-manager.lp.internal>
Date: Sat, 08 Nov 2025 07:31:57 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ee879d3fef0511e1afa17f98f50ce83d2b3d9cc1

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3969287/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-075

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3969287
Your team Linux RDMA is the requester of the build.


