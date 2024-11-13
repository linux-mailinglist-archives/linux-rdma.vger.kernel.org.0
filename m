Return-Path: <linux-rdma+bounces-5955-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901219C6C36
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 10:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CA228B8A3
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D151F80CB;
	Wed, 13 Nov 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="sAl0cnqG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF99189BBD
	for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491915; cv=none; b=tECfNpatX6s0v0hadyqYjys5ZFr2y15AJibZyavQnF+QQYuB+EBHN+s4xiolOqYUd75tflQ1tM1dW9P8pSOZ0hik1CP27vUwIP+bOnhrzwhpPnA8yPcCfq820P2No8QW2Be4izPYTqn5rA4KMIyOAFxJCYz5B3t/2ykq3pnCTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491915; c=relaxed/simple;
	bh=bBY84p4QSRtLM2rFCH+6eIH9NkBnb+Dn4LN0nDDIJEo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=SRGCTTTolXiymzA8u11vdkTi886TPegwYQl+gSQKAXoSoiTA+JP6tz9LJS74PYwfHy3uHwFr5tADIcudAMBWfqMDY17YY+hS98y7ah997cLxKeEdr/PPp4QXZ046jSLSBllgk/OoKlJmPRonV9ZAo4Kdx4b9mz2kZQbv+MAZaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=sAl0cnqG; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id DFDE73F8E6
	for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2024 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1731491905;
	bh=bBY84p4QSRtLM2rFCH+6eIH9NkBnb+Dn4LN0nDDIJEo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=sAl0cnqGFncotLPOtMQlQ6z4augYyASMFsm9/SaeRvXicEyIfqHaAEtVQxsjdqKzz
	 dZ6WrE1xcEDSnv32Kwgjue1rSRQiZHqhv+0l0rVQtQn0EflY7rSgDzfiYOvaWNAdnW
	 kweQoMC3TJPHyh75N5PWl09IIzFt3iU1JcgYUzVbs3jZs6lFDnBQqFg4FA8lGuPikz
	 +iKBfFXBLuTXyHASfevx6mNhtOVkKY07hv2iMoVspmsasJOga0ONACv557Y3jz2A4C
	 Zmt3CFizKhtow87QxU8eAGZqOL06M3tgITh16qiae8MGQqAH4MisPN/w8l9cLXQ6+i
	 nO9qfP4sPpqsQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id D0EAC7E236
	for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2024 09:58:25 +0000 (UTC)
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
Subject: [recipe build #3812288] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173149190585.4047664.1108487091076232559.launchpad@buildd-manager.lp.internal>
Date: Wed, 13 Nov 2024 09:58:25 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="22ade00ab50b929fac63b8ee7252243aceda294a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 7d4f4284cfbc399092de26203ed2b00209c7a064

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3812288/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-023

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3812288
Your team Linux RDMA is the requester of the build.


