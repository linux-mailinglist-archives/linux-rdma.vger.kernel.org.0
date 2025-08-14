Return-Path: <linux-rdma+bounces-12763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E8B26574
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 14:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2AF9E870C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314BD2FD1DD;
	Thu, 14 Aug 2025 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="DAR8Z4yU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5482FC89A
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174888; cv=none; b=FcWBwOI8KEkTPpDztxFenjFytsliYtWxeeMl1R8J7D2A0/XQ4MwSBpRpBfBSF1gGsdvN2Zu4vrylH9GRrFWHn5gaf1d5/SnWbSJnJ29zteNMUv2JmpK8R5nzrmPqgFelonyThb8CEsziBj1yW04btmNHL+5+uyd+qQ0DKQpK32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174888; c=relaxed/simple;
	bh=XrNhy/70YzogVNqeLvwWAOltprqShiGnOLl2rRbyUk0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=XphHpOPyXHz5g6isXMb00oDSzOeSCJcnABFgZdfrHea+eMNJafM57/eg6SYWaEafIkYiPCPrELUhZeRLxDdmKVkc+fqyRuCB6Qhw7sfcBR20Pz/utFA/WmHNqSiXiWqJjJ61HrTjoqTQ84T9DpboXT25c+wYOgYw4klcMRAYjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=DAR8Z4yU; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id D4A593F16B
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 12:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1755174876;
	bh=XrNhy/70YzogVNqeLvwWAOltprqShiGnOLl2rRbyUk0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=DAR8Z4yUVTQbP5dBh7z8zBuNSZaL2wMNdPRRDBRnn4PjToTjfLbrvHiJ5XWDBjdAc
	 waYCfDhOHJ7kxp8Cj2BP/Zs51Ksvy2f946djEgw5RYjNdpOfguQ42Np+ZpyCgJBZeS
	 JGhA6iefXK77pwhZyii5XbKsm/jTPirJ/MPCkl6FFnw2nC+crn8eF8lxHqU8eUmLWC
	 SKQMtEHCyWjG9WQI2HgInHflQghd40Xni+PEHcvK7DWurMH7FdHNEHfz+gwmAnpD2F
	 olkVWZTGYWyJIbOtnEOQAL9zNMTCVhJ8vHMGq8KQRfeQI8BcP2h3TEYn+cpIVqgL8c
	 jNEx59y3zsgfg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id CA2F87E737
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 12:34:36 +0000 (UTC)
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
Subject: [recipe build #3934409] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175517487682.1670651.10258891300854628465.launchpad@buildd-manager.lp.internal>
Date: Thu, 14 Aug 2025 12:34:36 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="edfc2dde4eeb7cfca47c7fcdf823a0522ed18913"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5b5c6e43f64d7d74b8c52a1e0a23454fbd901f4c

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3934409/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-084

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3934409
Your team Linux RDMA is the requester of the build.


