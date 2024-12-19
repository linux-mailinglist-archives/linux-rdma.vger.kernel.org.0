Return-Path: <linux-rdma+bounces-6647-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA179F7A3D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 12:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3310216C86B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F6622371F;
	Thu, 19 Dec 2024 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="QsjI1WgY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE20224880
	for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607097; cv=none; b=ZKAuS+nJoI7Is3Ah5x7CckLGi8AmSG+pFLhB07n4IzrL8YGmZzMxokk1FAQ7UEJhb4HC+eRt6ew/ZZ5aeXjX67IrSFkYmi7o9tIkORUdW31foOQA9L6NX6QI5Zw5jzR4FFxx38puGPuw52+3DnitD1gWpshltSIfCzjCL7wLExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607097; c=relaxed/simple;
	bh=vucmrAet+FTVdrjvcrWzdoptDY2jr10uRpqZpPG2kjs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=K1Im/usyIAbybi03Jz9wrDoTPoix8SUFpK1aiBfOS4TGHvHd7l4wVR7Pp9WqAcyMcM5x4gb0SVa3GG5clF10bCAGNpvPC7GaVoaWY+aQMvZ3LIbKhzsFUq9WJtKAdNwtCpQmCFc8K+nLt8gy8SgvvOz96VDbD26+rBaaN/ujA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=QsjI1WgY; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id AAFF041480
	for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1734607088;
	bh=vucmrAet+FTVdrjvcrWzdoptDY2jr10uRpqZpPG2kjs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=QsjI1WgYDNNc0+ppdXtdDWgGqtryjEj3bGSierX6eAY/xP+EELoVTYRaOOTVaJlUz
	 iGTsGPYkXJA09s1cCqC7Dh8QK+Uyp2Y884vi7DJv4+Ls7WPdxjWUYBeFRQhgKnP9zH
	 Fo4uuK8/DiSyNzqn6dqST+GCAHuCfm77eBNtNna6ia3g01CKyc9mXl0tGJZHN3IJOD
	 PVqsxZvXT9rvXC2y+oAuKj3vLDKE/13JAus/8/pJJOW232cCuysAN6ADZi7wOGRtWl
	 kyw7RFOAfOutWBO8ANkQOwWXcTtcggT5Nu5MD8TwRKldKdsOnp4YuPZBLvc112QKeK
	 Hv+DJgfOrstvA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id A2C607E236
	for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 11:18:08 +0000 (UTC)
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
Subject: [recipe build #3829820] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173460708866.3566891.5774512119445049307.launchpad@buildd-manager.lp.internal>
Date: Thu, 19 Dec 2024 11:18:08 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="6394e03793719e8d73f5a60b5439440e693c92f1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 3770b7b864f5504139c4cc88c0c4ea5adc7e3262

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3829820/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-116

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3829820
Your team Linux RDMA is the requester of the build.


