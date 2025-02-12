Return-Path: <linux-rdma+bounces-7686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38187A32C42
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 17:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08645165C20
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C19E21A424;
	Wed, 12 Feb 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="ASzrJUip"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0D1DEFDD
	for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378838; cv=none; b=ik6PdXONoyh34oDWCliE/U80r1a8qOpegYpIA1POyi4Qy/y90oeS9ANguJbnh+gmLJG1ebatRQx2yGveh+5xH0epDZkULc2I4dYJFEBm6x8dthPGYYNvCsChkhPOMkMGoaTJ0VXphYt1tzoo8m61huKaz5wvqDA7w+eIgqakGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378838; c=relaxed/simple;
	bh=U6exCgU3aNiwCJtKUPQRODLm1XABGAnLAc5c4qSNxM0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=RfU8Soa0Iek8wzepnUG8XhIKSQxS58zTftVD+TLVDmP+N6vqahRYStL+H+fWezSUFdx73UwRblNjkc0CLnZou4QGuROQzYtkHM65a3cRMaKQ0kcLfvqtJOKoT1e1+EHZ7TQmXpkV/pxF50uei5M1GmU+RY8KXtpAFy0qkS+CtCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=ASzrJUip; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id D43783F9D6
	for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2025 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1739378828;
	bh=U6exCgU3aNiwCJtKUPQRODLm1XABGAnLAc5c4qSNxM0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=ASzrJUip/MAGiV1Q1IN/spnVQDvZNlN5c6JR15uVGHQ91eQY4v8sLUanUfWl19hbx
	 tj8/qEzqAtNApaXH2jSLOiYrvQFdS112BznWI0VW13Sy49bWq7MC8dk9iMzKUBHfFy
	 8cNBFqxS3UZYsfkLVL8AOZiN1HUFqtWHIocCV/GBSkXraZN9VHB6jqBiPvX2e7I6Zb
	 driS1OE5uMHJJY7Rq5M9JWpvP+RRerKzkyCSww/TPO2A2NvZCsTycBaVHPvBMC1UuI
	 K4NELclWgYwWnvhPGSxhfc8CQ/r3Iw0S9xn9AijOwerOFGRfiHNS/VDa+z9QXGjfwY
	 QeOv1KShgfxTg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id BBA2C87FD1
	for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2025 16:47:08 +0000 (UTC)
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
Subject: [recipe build #3852487] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173937882876.964601.7230003261406452837.launchpad@buildd-manager.lp.internal>
Date: Wed, 12 Feb 2025 16:47:08 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="78860d903de6d6d7dd5a0ade63efaca45d3467e2"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 35575901d7c0791cf9c7578690ddb248db7b69db

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3852487/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-039

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3852487
Your team Linux RDMA is the requester of the build.


