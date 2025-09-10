Return-Path: <linux-rdma+bounces-13250-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE42DB517B5
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 15:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291691C85183
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382D5313E33;
	Wed, 10 Sep 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="ja5mvsbi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E82F9C2D
	for <linux-rdma@vger.kernel.org>; Wed, 10 Sep 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510076; cv=none; b=S3RRh7dMrDNv6ThLnEwxfrV5aTHey0nVqKdrKlX9asnG91jgHQSFQxSjjYZP7IQItbLT1ebEWzRz238KTgfjBEbM/o/yFYOTFoKkWEP8jXDmRn9RuVFF6w3RLC0Nd1YdhiQwqgbUrcCyzFB9juWcFoEMfmISn7KYXVfggd7AFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510076; c=relaxed/simple;
	bh=MzLo7wKSlhd2jxgcp9cnKzTak7BRFGWV6R+Xh2Kip2k=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=YTas9HjsjdGCMGwwz3WdYuNURajFtJze00mtgRaI8V5A+xCRGtHGRj2Ae+DmwgnypkGQv+mRsiM3UhZ1Xq78JyNp6CuFE8NSz3eTy/RuCyq2tCuqYqaNA1nIc5p87ULHjLb0ZiFFTgWc81F3NiLvrrsGNwu9B82b65BEEBTXQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=ja5mvsbi; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 577F842204
	for <linux-rdma@vger.kernel.org>; Wed, 10 Sep 2025 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1757509568;
	bh=MzLo7wKSlhd2jxgcp9cnKzTak7BRFGWV6R+Xh2Kip2k=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=ja5mvsbiSXfsJh8UUgKc+Kk7zcRXCYgxDx+agEBegA25x7uZPfb4NhoNGLP6rVvup
	 nhhOJTOp66jaJ0iaXfL6rBADJGqkj3grYpybD22HoVSLIwGSXIGx4nfIwTQP580g7a
	 puhsOihm2976Djy+34wg/QXOQmRw1R3NyzL8+RSOFLI+HdtdVpm0xKR9qZgm0S6lGz
	 EMrfE5C5fSyUuixT+tDldbWzmky8Y/h/VvmRmvhYKt2Z+DMlg3nm5hULuLiTRQNPFb
	 XtJMytYkv+GqPkVfZt7L2tv9+HG+EEX/PwpQ3vh1ouGbz/EVcx+n8r/7cbkEWpWfwj
	 1PjdWO0RQqlTQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 471A5847A1
	for <linux-rdma@vger.kernel.org>; Wed, 10 Sep 2025 13:06:08 +0000 (UTC)
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
Subject: [recipe build #3943946] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175750956828.2222963.11267711653443984640.launchpad@buildd-manager.lp.internal>
Date: Wed, 10 Sep 2025 13:06:08 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="3db21b43f675a56d404bb64e0fe1fcfc5dc01a90"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: e846d6e603f32cae5eb0d7d2ce16a93b3a4c17ea

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3943946/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-053

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3943946
Your team Linux RDMA is the requester of the build.


