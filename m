Return-Path: <linux-rdma+bounces-8834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D61A69380
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D21B8676A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF108528E;
	Wed, 19 Mar 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="BKgbGwvq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF512C499
	for <linux-rdma@vger.kernel.org>; Wed, 19 Mar 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396241; cv=none; b=YltjJIzsK7+U2xqWQVo4q7Zesc0/sQk9a8EdykmG6DTd+CtaIHzSWp9KA+7SXgF45LowcWkgEdcUEM46+/8Z0e0I++QbZ3kJmc8zmTf+UpHp0obIrsrrJmdWswTr9TWR7BFsxd3EHpZEuNnPiIYSM1law4Xbt2SmBV2IbjzL30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396241; c=relaxed/simple;
	bh=vEEsL2SZrZyLk+tR180OGbjTFBwIE5Ojz/SIMlB0wQ8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=pb0oHlmm2s8sAhB3Wjo43hW0slHURZDDkBliAgT6ZWBE6AfOzGljbr3k9D2VAQfik1ejnonu4+vwvzv2Fnm6PhzyEogMJxau+vTzjwgrZU1zDcw6MCNndPaC7xwPlyGwc7H0a6fFrrSqG7SikoW1jPKpSmmdBJ7yV0B9NdJqHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=BKgbGwvq; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 7F2E242EA9
	for <linux-rdma@vger.kernel.org>; Wed, 19 Mar 2025 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1742396229;
	bh=vEEsL2SZrZyLk+tR180OGbjTFBwIE5Ojz/SIMlB0wQ8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=BKgbGwvqZGvVITVxIfCo3s1bttHW99+Cprp6Vq1IrpArZOx8F6f+8e6xm8xj/wt11
	 6zP6qW+FV1oiKPFK5v2qJsHYz5yP/bsWEXpMJVNxO5InjQCA7F+osvSpu3K77eWSHB
	 crcAZxJhOSVWqPquYM/h5ZRd21X/VhDRav92hR03iXOcNq6zBE9pUN92J/zefxi18R
	 95iAq3pxtAqlUry49cpbXU7Z5viqVIDWyfUpY5g3ibgqGF8rP/XazIi4bzZQ0cKt3G
	 OuyJj0Qs8/EEYXO+PiOPZ5jdRr8A//ctpBK4Tadr9pOGbMzK6/mA3LjP8z5L+1w1Gj
	 XmhOuL60QrBHg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 748887E236
	for <linux-rdma@vger.kernel.org>; Wed, 19 Mar 2025 14:57:09 +0000 (UTC)
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
Subject: [recipe build #3870046] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174239622947.4188075.9567713564303375659.launchpad@buildd-manager.lp.internal>
Date: Wed, 19 Mar 2025 14:57:09 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aa29ae0fff49e4e804b39147c9f259d2fb023199"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d8fe44166fcf0a28a19aae3829fbccbe215e86f2

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 11 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3870046/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-059

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3870046
Your team Linux RDMA is the requester of the build.


