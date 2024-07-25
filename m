Return-Path: <linux-rdma+bounces-3982-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31E593C2A6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 15:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5F41C20E67
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C12199235;
	Thu, 25 Jul 2024 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="sGVedblv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E1813B5AD
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912549; cv=none; b=rVohamXWQGCZpudFKRjFEbW2OkDM77WIPoqqxAWPybWBWyioxIA/hQITdnD4mQOymJE/saN7mJR3GGDuxUD7IM2evMAJdHSw/tA33ZSOIjjra4alpfXSbMwOKfZuWdDPJWPIcAdbeJHXuZSGCxUBrhe+vZwMBw+bGlKXPBmN0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912549; c=relaxed/simple;
	bh=RBRY1J32jwjtuEUFh3ZGaKQwjM8oICxZESsuGrA/Zq4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=JPjt9pg5wezhoMZuuhUDuMKnVv6Qu+rS+7ARmPfHa1uVCUAFKgNLB9gyjf8oPoIhl5335jTZLhh9EMjFEaxRcjXaQqVLpcR2K4xVFDMHDSfXmMDCoxcR79NaUCHi1uEhcxAgN9Jqq7eGYQatw18DFGXAuhm778SWCwwW9p/KgP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=sGVedblv; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id DFFDD3FBF5
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1721912539;
	bh=RBRY1J32jwjtuEUFh3ZGaKQwjM8oICxZESsuGrA/Zq4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=sGVedblvRFCQaodB5EX6KULouEbNYXIHaUSw8NK24rrC7/zg3nJMR1D+J0YIX7TWP
	 nzTS0E7SpC7Mrvtzo+V0xYtnLKDx0OM2YdEO3iXTBmAhFanjCzN9KPSIslb3TD5F43
	 eyZ1QPvWV1yheVadV6UG1WaaTZKjoBojDZF1vPx9q/+RBl2DZWUQr2VEVRwkGxBK6s
	 naW8LK9B1hwp7urrgH1qHtwwz1epKtkGX8FmheUYecmuN4uMjVYIDTA3f4ZNVyJdqD
	 G8u4wtkeQfeMn0Bw6BpeAL1oiDNjR1RyXStPDzApjcxTNS9KSYz9iirmV01W4x+lF7
	 q1LtIMyeg6ggw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id D63B27EBD2
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 13:02:19 +0000 (UTC)
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
Subject: [recipe build #3761346] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172191253987.482060.290684927610925811.launchpad@buildd-manager.lp.internal>
Date: Thu, 25 Jul 2024 13:02:19 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="0f7b58d0a728e5e8f34556869262ccfa55217529"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 6574d13ad79f59a088f5e869434732be66f388db

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3761346/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-046

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3761346
Your team Linux RDMA is the requester of the build.


