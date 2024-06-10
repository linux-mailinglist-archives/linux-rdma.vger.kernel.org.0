Return-Path: <linux-rdma+bounces-3032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EECE90248F
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1C51C2284A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE213DDBF;
	Mon, 10 Jun 2024 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="GAwPczth"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E59D13D89D
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030911; cv=none; b=En84HdwREVkgtAqAUln51fbsVWbOWILbwoTUqzTXaqLWrSrMbqjDa7BRo4Hg2VyWyaW1jxIACl7krNkuxuZ2wrnr5Yayrr3s0XAC9xwqhB87dRoC1k/6lWk66QtGANaLL/6zmgKyMT+h8qa02JKvnScCaBe3cPQ0Ks7XCGNMBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030911; c=relaxed/simple;
	bh=HcbyTXrHvHqx8vexxjgA9ggI8EqixEZZpoLJSrpJK3g=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=MWO13g/YzsotAtFjzqkbnGmbSYw/tooU4jFhNV+G64mPoG9yW+ysq39soE3cECJlXtkoMjKDcQhJhexzna20E8uV09zHy9Ez5DmKzmY90mQDJIa3dOlxUOSD3oov48tWjOrUsijBmRKqiefgSqIqgMsgr9f0tIN3DuY9nb+RDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=GAwPczth; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id A4B3E42584
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1718030901;
	bh=HcbyTXrHvHqx8vexxjgA9ggI8EqixEZZpoLJSrpJK3g=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=GAwPczth/AP/ca9YKnj6oq7YqC51I1cAJyP21/9a2Pr3OJP7hek8CrEqv+bXCyZqR
	 XLWFkseCIiiUyZdBOYE9tjH2QLV8COORIp2owyFW6yE/k0ZM53QEQmiQXn0AeDSyb4
	 aqRPvOD9z5OOLF0pd913Evuuc67LS6uRPsqS2CsjA1vJCLUCNjS7b2394+fKoiyvaI
	 SZGq5p46ccFQPGlJAIfHDhmOd2KktvV6U3RWFCCT/jZZ5KiG3v0nt3vKapZ+attTHY
	 QomBS6g6vloNSda131V8vX8cVaXnriRWFepaZP4Vy9lfrquwP6+wH0VZmAfOVehYN1
	 DBGzREnNGor4w==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 8F7147E248
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 14:48:21 +0000 (UTC)
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
Subject: [recipe build #3740099] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171803090158.322650.18021060253322415027.launchpad@buildd-manager.lp.internal>
Date: Mon, 10 Jun 2024 14:48:21 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="7020100bd22578495a0a6fd39859337d4641b57b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f763ce047556344ec9ca5ab56c2c49f219ad7e1e

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3740099/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-077

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3740099
Your team Linux RDMA is the requester of the build.


