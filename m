Return-Path: <linux-rdma+bounces-3328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1102790F1D8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92667B260E4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2051509B3;
	Wed, 19 Jun 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="gvhn4wbI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA985626
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809943; cv=none; b=VG/7BwxrmWwGjlnDAFcDcEXIqQzJdYH1f+1a9BCi39snIrehIQPd6MlCj+fC8980XgPzo2LNH6sRyFoPbsknTyCIG526J9peHsydayjekOLrgqS5qwcvhESoVqmqo351UN58tgxzVqi1wopkGbtl8ugGceNlUTicg5IZHCRdzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809943; c=relaxed/simple;
	bh=JQR4PxySn0hNZhdc7JzcxhnzVPEfM3qTBFLms+c4JAE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=SK1cGi2LZNFDjlwq03We5tqgwbBzdk94ZHIpziJBVhPKqLYHvKvOavEFEFwcPFzHRRSWgpQ3kfCsrL2tL0Ay/JkqGLYSFyHARxU02MTDYqvj+/pn8bTlVqZcI4VREsuxRF3bv/0x/n8ePt9gw7QIyiqzk2z4DoKp7fFa6SblAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=gvhn4wbI; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 0B92B3F26D
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1718809422;
	bh=JQR4PxySn0hNZhdc7JzcxhnzVPEfM3qTBFLms+c4JAE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=gvhn4wbIn6sCmD7vbDFoqxuyDtC1V+XWv/GnZJCEjI8hrfzHNXOepxUr9wnWhr6Ne
	 DMMJXqA8UI6JgUIUy6CV5dEjthJW6PMg2rkeniBrMSnQuMcuowYYKqsX6W3LJEE21n
	 1/ZbDRKp/uBRiefcnsJcr9+BdqawELrzq2ryxHjPV8xDm5hXTFXBcc4RE3qDJP2oUc
	 nIs+3vU8itOhbzt3xPWxYDiZjDiGmHFqrVBiTaFdp5RCelWuCW9pmjGoePBr4XEXvv
	 /Zu2zK9dCDG5UTFViOgVnKLA7s5+irJtukRkyAHPuHhSxWBhWksaE7OgvIAD3xfhEl
	 Wu6JFLLFjW8aw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 019557E236
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:03:42 +0000 (UTC)
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
Subject: [recipe build #3744709] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171880942200.3727353.2572999646131687453.launchpad@buildd-manager.lp.internal>
Date: Wed, 19 Jun 2024 15:03:42 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f22c1c8e410ea7989a0cc0b5343595464aa1e0fd

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3744709/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-011

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3744709
Your team Linux RDMA is the requester of the build.


