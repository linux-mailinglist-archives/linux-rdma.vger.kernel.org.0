Return-Path: <linux-rdma+bounces-7046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF8A14217
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 20:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43AF41889DF9
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 19:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD17322F825;
	Thu, 16 Jan 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Z5/+J2Rf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68FE22D4F3
	for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2025 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054797; cv=none; b=Oh7jZZUbyL6ONQ6Dz7L3goz9whSK4pU2EpFsprkhZ/L2NBnsPhs8ddVZyqaikS5Q8bqJ9NuJunXJOvg6Z/eBIAFFe0XaUtdUt+7wNfFmQdB/8Asz4jL6GxTZgI12DGhGSToCACWrE20lw2Px+elf1buVWxeJYPDJq2WYSLlFKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054797; c=relaxed/simple;
	bh=LY1gI7yJUX+I5ejaEo3Mxh65JeUrJB2J5GwkYH6dyWg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=FyumaCL3Sue1aPELR9KSY0IwO70yMX5SMcEpfgOKjBn8gtqZqc2p7MMgpKbaCeCvEbVmNvOSCVJ+MWY3hdyMFrKcaLKsb5FP77kCKCyvnynAXEuH4kcCJrtTgFAsdr7viosMpzHBAtNUaWJTRGqHKcCO9Iq9ZSiF6NKQSkS2840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Z5/+J2Rf; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 9595F3F832
	for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2025 19:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1737054438;
	bh=LY1gI7yJUX+I5ejaEo3Mxh65JeUrJB2J5GwkYH6dyWg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Z5/+J2RfG0Wa25YgBvHrtadapYJKBFRlQY2ix+VGDYsGgJsS1j5MPiEhXavyZCSMU
	 3n57sjPeLZgfMjUk+RRb5hr88ngCYttEplLiYlhoXHKzaEgbm3V3+Q/VxxToAY6vze
	 hhJgM6V5eCAvQdHaK1cO5BgGuvQNyE04mJDpyvjgMKLbz9m53ximxHWrXoToNMr8wl
	 Qi3JkduYVDmUD0BHPBgJNEw8PNul91UTGIvUxm6lE9bq2orUgtf0JsgQEUIPTSpuFf
	 8f19AwAaXOgFyWrq0s5pxSdy37abv9rPupdP0ylncj16m5FAnZxRLakJeKhJb377ua
	 lz4C4ENUjTPUg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 8A05F82DB0
	for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2025 19:07:18 +0000 (UTC)
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
Subject: [recipe build #3841184] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173705443856.775904.152014882004095085.launchpad@buildd-manager.lp.internal>
Date: Thu, 16 Jan 2025 19:07:18 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="6394e03793719e8d73f5a60b5439440e693c92f1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: a8022a0d0f67013aaeee0a39fbd652ad3ce00a80

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3841184/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-014

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3841184
Your team Linux RDMA is the requester of the build.


