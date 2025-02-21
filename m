Return-Path: <linux-rdma+bounces-7992-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E3BA402FF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 23:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32EE4264BD
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFFE205AB3;
	Fri, 21 Feb 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="gy6GjHdI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538D2054E5
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178177; cv=none; b=W3MhaSx9VnL28JC0QDG93YqhvmOJ2g5/s5p85d6SsawvV7pDdLPT7jg6cgTSW8bvdNf4ARsjE8sWzh8eXKpJLOe0QD4WWhFn4bhmeK5Py9JSV+03BsiFWbFMWlHfJgtOxFm7fo2WzRhP0xUb4rUWFiCxPSkVyHAxlS33G+vEO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178177; c=relaxed/simple;
	bh=EEnEB/C72SjAWinYPRUnDFCJ65ajL0HY9Nz9Iu/tRXU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=iYZDaRmFdYclj3+HL0xx8pVKuJxZkzDHRemcp2IliImocp5++TSa8nVVBBydKGIx5cdzR3NnfImcUiP6Ao4ic18NhHzWS9Gtm66CkJ9DePoaLOnyEaFIzbiEHx7iAkyn8mnhWKPMhXD3yXRHNnHsaYqCdHV1LvmQoYbB0/s5ppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=gy6GjHdI; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 1052D40D2D
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 22:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1740178173;
	bh=EEnEB/C72SjAWinYPRUnDFCJ65ajL0HY9Nz9Iu/tRXU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=gy6GjHdIHVq0ukHCr/csydlUgn5k93NMdkYmZJndPncMrXkw0oyN2AB3PuLnStTfb
	 g364b3cidQFAnmFOomp2R4cYz9WQJ5FL3p7BBGisBan0EdiZwZdtseEhjQjioWIt4K
	 zAdsMQq9hVCZJnrvaXnbP7b2/ey+CWKtUEtVow9lEPr+1pyUXrCFsFcNWCanANqVER
	 YetxSMkcCW3LaURu0O8RgRSPvBB0ydPbic/SdpupPtRERiMi9ehUfof+WxpmBEpihw
	 OAj6CJVnzQLzFrGAkCLNmn4RTxmbbau2lwJvnhP7AunlAyCborLwKjo1vHrP1Y/9b9
	 GizAJu0vVM7vg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id EFAD17E244
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 22:49:32 +0000 (UTC)
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
Subject: [recipe build #3857650] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174017817297.1613549.18051176831177200752.launchpad@buildd-manager.lp.internal>
Date: Fri, 21 Feb 2025 22:49:32 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="78860d903de6d6d7dd5a0ade63efaca45d3467e2"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 1f4d9c5fa9357ff9963fa46ff5752c7cdc79f916

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3857650/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-118

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3857650
Your team Linux RDMA is the requester of the build.


