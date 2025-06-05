Return-Path: <linux-rdma+bounces-11032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881DDACEEEA
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 14:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570C6168780
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499241F4C83;
	Thu,  5 Jun 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Xlth065g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3E17B50F
	for <linux-rdma@vger.kernel.org>; Thu,  5 Jun 2025 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749125203; cv=none; b=rtBVzJERXrymWqAM8J46nn5/ul5bx1cn/3TcDhCy8yquijYu1PKhHOomtObQUa7z3GyIiX6DWSY9aw57HTlWsjewzLY++lJ1m0+yBNrlhtnYWaQjGM6Xs3ML9AbW/n1A2cElURMM/XPwHFtQ9iQ3I2WMM5Gnq90CyiM5/YHsFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749125203; c=relaxed/simple;
	bh=9iLubBRTiKadmyhdpnY0B2JCF7ztFsrTQTzDTnodxQQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=IJV1gOOkwR3WEJaxQK90T6DW8AYiR/MmmRE9iYxyMHVR1SCjgfYqC1JnOT5hH4PrVtkvqzDzPBonYrkIpqCT+MLBweUZSt4ILQ1w8XnI/DWI6e9lP/azR9s1g1NRA2DERRGS5EaEX/L9HPBOUj0uOeg93V6+zqjlvMKKczi2QTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Xlth065g; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id B6DF142BEB
	for <linux-rdma@vger.kernel.org>; Thu,  5 Jun 2025 11:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1749124756;
	bh=9iLubBRTiKadmyhdpnY0B2JCF7ztFsrTQTzDTnodxQQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Xlth065gN3ZfuRRq1v47rC8HJtAtGGp3hI9D++PKp/8RHvErBRM924pn6O1Bsxzso
	 d3W9ok0rTQIYbV2ZJf+2hR3ZmfvxZB36T8hMtnj/0XcQBGmCQHB4KMdhuM4rYSeMOH
	 1gbbCJst/kHaUVTWYIIh6k7vD6Hrx/WqCBHG8YMSHlw2jOODYaAsCzoQXyKxyqyYP7
	 JHvEAWjUkcnEAcz05ISITee9pu8z+GlwDz0IctjHKnvUNdx9CqlQOlMw6pbSc3S628
	 jRvrV2PUs8aZKnbXx14BdnQnkbAnH40cOrv69IxdctThs0bdreIA+d+u2/XUrTbEi2
	 fgPBrGPJQydSg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 9CFCA7E598
	for <linux-rdma@vger.kernel.org>; Thu,  5 Jun 2025 11:59:16 +0000 (UTC)
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
Subject: [recipe build #3905904] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174912475664.1460919.14516714849378626680.launchpad@buildd-manager.lp.internal>
Date: Thu, 05 Jun 2025 11:59:16 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="c425d5702ce6a53fe8d94ca38038ac108957fda2"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2d25c03204c23e64dda4b183b335496cf1f2b849

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3905904/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-008

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3905904
Your team Linux RDMA is the requester of the build.


