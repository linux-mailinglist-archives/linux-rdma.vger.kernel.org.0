Return-Path: <linux-rdma+bounces-14395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2759C4E20A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 14:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F0BF4EAEBB
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31475331212;
	Tue, 11 Nov 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="FxdjuNVH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DAE3370FE
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867968; cv=none; b=D/dCzfK48ViVGgz9R6zyMk8SbYyXzWDTilhVpeRodh4Cu1V9O/sB5OGoJ7hwSkWsislqJa96RV2i+QGjfgJb2TwOqAt1U86vq1RohjewrOGFmDhk1BblPhiJsmlyxOW9eTTav/jt1iQQkurj0ZgkwbtQV/t9U6hBY0p0AR9ClXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867968; c=relaxed/simple;
	bh=9rzPN17y5enjLGHsiL9RCTd6U/s7tMrOlOQJpW8q+Fw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Nuo0dS7E2knPKK4BIyOXr3Jyp4yizbpCY3FV18+xHjZklVNzPcV5eexP67Xp3KwHP/XeVIGpLNg5D0fp/2O0EipbTPTQ3ligWemsA9L9BcFl3qkRNlnYgyGIzlLaB18NfZZLgvVW4DZBFCwiKbSXSVSeUHaWAqFc1Tck3Xst9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=FxdjuNVH; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id F06DE42693
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762867958;
	bh=9rzPN17y5enjLGHsiL9RCTd6U/s7tMrOlOQJpW8q+Fw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=FxdjuNVHjaWDlSEBhzdVopcGPwsh47k6oIbbXaCpgyRlNbP/+vsi+SoWhxZiIWpOZ
	 rAkwV0tY+S5goyUf83LQaBGyZ/82AskG7buuJttdhZuGGjIpHsja2bgVuXnb0+sdbT
	 the64+8p53Q00V/MmjyzGr+4Hvzhm99wYZmWq+c0sz6sUn/V7FmH05x/RSp1spHyIp
	 w4xTaL51hrun6n5m4LMR85l7FmN2/PuQmsgegU09OtSQeI6ZgOpI/rarKbJvgC59Lj
	 /oi/5wd9GLYplVM49uePEdmFBghyGvmZ9TxEkIey0x8BZIgOUGtxigm11802bqdCCS
	 JVSA5P3WPXsYA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id D59C47EA42
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 13:32:38 +0000 (UTC)
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
Subject: [recipe build #3970642] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176286795887.1218157.15024257631837592788.launchpad@buildd-manager.lp.internal>
Date: Tue, 11 Nov 2025 13:32:38 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d8e6b5867522a740d2bee25845b40c6ad353dfe8

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3970642/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-095

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3970642
Your team Linux RDMA is the requester of the build.


