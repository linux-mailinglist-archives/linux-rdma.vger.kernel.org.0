Return-Path: <linux-rdma+bounces-12087-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7E5B030FF
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 14:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01619189CEC9
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7343024BD03;
	Sun, 13 Jul 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="SPvDJOAA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3631111AD
	for <linux-rdma@vger.kernel.org>; Sun, 13 Jul 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752410555; cv=none; b=ja3p0qWKY1ssk2FVpdEHSJyGDL3d3guoeIXI8Z+ts4hrxV5Ssp2pXYD+dny5kFVV9MQeVHW5FWPZAzSg/xymTv+NpUp+UuwR0beQJd+AJsMIJqhNj7sHooDwW0NWMJpFrhKSK0eGMl8VTMkieNUc2EKT2aWi1YQaadt8aFjPOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752410555; c=relaxed/simple;
	bh=wvLKFD61bePciqvYXTQohc5gor7iU6yLvS2mYK/uGWc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=sc1jAz/l1VQJRHA7b0tAr++waDeFjNEddC+9AxtxjFJnEns/CvciBt0+ISAlCEEzdA+odMLQbVgmaPnKYk7K3zV+PX3D1GvMhkejjogD4mupWqTI5j5OOML/y1yIfh478E1rmYudUoT685KGaYfLhOThFjAA8YTMyR7FDQqfK+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=SPvDJOAA; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 12FF33F59E
	for <linux-rdma@vger.kernel.org>; Sun, 13 Jul 2025 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1752410067;
	bh=wvLKFD61bePciqvYXTQohc5gor7iU6yLvS2mYK/uGWc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=SPvDJOAA0Yf3y7mdVcFipA8WFm39ylPXsa32S4a8zm8Gm5f9z4ScinlMxw0ckjZFe
	 g0xn5u5Dr0iHZ/OqjdvsZe9bUBdCAYIEr6KZlHSBxL2IVS+ZMkAWx9+RZaA0YQKPm0
	 7G+k1Tu1jrOYQthHUBvQbOi/VNKblY+IFBct8sPSXNSl9A9Z69ikysdYjPsV9xvo3m
	 1rle6i0PHLPpns2ZCmlc9oBqhXLKaihz52HLD86EZFpvFMfloB2J+cEvGu/w0NWXEl
	 S2IpQKs85pA2DBbxZ4z4qSxoBrzCZT+J7IdPcqdf/vnErjs4+qvgcY3mZ4x3ok066u
	 VX/VyX+tCQHGw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 0BF397E6E4
	for <linux-rdma@vger.kernel.org>; Sun, 13 Jul 2025 12:34:27 +0000 (UTC)
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
Subject: [recipe build #3921786] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175241006704.598786.12865813456943900156.launchpad@buildd-manager.lp.internal>
Date: Sun, 13 Jul 2025 12:34:27 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="cfa369d8c8bbab36b411e1678170ab3f6f956359"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 81c43651c489a8d73f475cea39e02ca3d76d4a1a

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3921786/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-115

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3921786
Your team Linux RDMA is the requester of the build.


