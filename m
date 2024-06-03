Return-Path: <linux-rdma+bounces-2780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69688D844F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7071F226A1
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCA912CDAF;
	Mon,  3 Jun 2024 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="FCHDgsKW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58512C554
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422421; cv=none; b=nw2vt3U0qHr5HU/kF4QnIzJrMK4uFQVz5HpChXVaF9vpS8jBR5MyQQGYnpniVUwZbvLpkm6uxzdu2W+KDIERZD/eRUVglJJYR1ne46gfWWAIucpr2WThml7m4Q9cKyqW4UNyVUl/r+M/A77wPG96HUYiE7suo78vDn8Yr1SmW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422421; c=relaxed/simple;
	bh=/woLTYF006Wx6NCaCtHx8BgJUqJgOPVBgfe2/tFVqqg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Nung5j7HophOH8NmBXS3P/r3+9p/y6BSfYpjVA3mOnO4bBntAqGzw4YU6LlPEOW2qWTv06xVsIXddcUH0an2GpKyo2nCyNu/zGY8lAtKghv/zSnJLvAYgWqzOeXmKRK8qy5tXEOA1Ag/UaUh87oPJGFHY/sHgw0PrPmly3yETHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=FCHDgsKW; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 42B1340545
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 13:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1717422412;
	bh=/woLTYF006Wx6NCaCtHx8BgJUqJgOPVBgfe2/tFVqqg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=FCHDgsKWGRJfRJPgCTZaq701DbwzhZHWZkE1rPLGiLOIXqjSxsGef3BqnijTKbaHY
	 ktnLAdrbAywNiHINXRTnGV60q8bswtvfTmWSSrfYynEGLmPiFVCdqDSW8ROWQe6ICb
	 /txSUV0aS5BI4zICLy0AB3gp+N4BYeutwhnEd2YlSStaA6ndS3wcy3tb9n7R1SXWyO
	 HrUakooh8g4tArksTU6z7GoQlCVfRfjpRMX96F2D8F0B3hyBqhtOs5o5Pjz7yV7PRC
	 i9VTD+su5g5kPYQwDw3v3DLWZBbOy15Qwq/i4Valq93KeBSC4ib4q3gXGvDEAuQJAN
	 zMxjIC0A7/jpQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 3124D7E230
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 13:46:52 +0000 (UTC)
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
Subject: [recipe build #3736779] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171742241219.3361349.2083979467088615323.launchpad@buildd-manager.lp.internal>
Date: Mon, 03 Jun 2024 13:46:52 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4d1350fd3710dfe10d207fa9961e224cc481dca3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ba9af7167d5bf2247c19793528a0c1dc583c0b32

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3736779/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-092

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3736779
Your team Linux RDMA is the requester of the build.


