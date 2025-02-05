Return-Path: <linux-rdma+bounces-7428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B318AA288AD
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B28167BA8
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1922E412;
	Wed,  5 Feb 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="FE7dh2o3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209222E411
	for <linux-rdma@vger.kernel.org>; Wed,  5 Feb 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738752560; cv=none; b=ablHdxu/giQD5GfnseJ6+U8EosNB3aCujulMWEAejRdf1/X6zLAmWimmt+heRuCVBXq+K4ucOoOd/ChlSJ21APvTxdI2fj5Q15+b7KWTu3F5wOEBXwxH3n43PzXKSaYwgQRmX/wiW66fJbk5S1zkcZwLbllqYb88o7XFUeLcQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738752560; c=relaxed/simple;
	bh=DtsuSDbEOKydq0UrN4JJjz8l/ExtbBGgA4ufHOinNcs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=QSzm6RDbyioSXpIfbal3rsEnwluWdOQPLNXH7fXuVKl5u/18UMtEUx5hWm+25Jinzg3cmePyEIFT9n5a0q/p2HwaVmf52f2fAn6V85uwsNUPC1diSr79rF3O4fqYv5X4gTh7w0s2U6GwX1h+e8prPzDWKilk4HXp+6KezhtFxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=FE7dh2o3; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 1064444CC8
	for <linux-rdma@vger.kernel.org>; Wed,  5 Feb 2025 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1738752551;
	bh=DtsuSDbEOKydq0UrN4JJjz8l/ExtbBGgA4ufHOinNcs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=FE7dh2o3l89mxdNG+UsUJrL2bg0A6cs86xDziqiH3jV5Q5iyrMK/siJgRSroUqQqR
	 4sxKuOC/ywgimy7jXvsAaPpxdj4rggtnCUhs7/etc9qWta/NpIGvPNXldw+2BWmImv
	 jYdoW3d58iSO4IZ04WFNVipWig/7zxH6OG/J3XHmiKYP9UEUa8X5Y238S+chc1Ehb5
	 tl42XZOa0ePq48Fo+qEqXTgTT6R+b88qZLqaHnqt4wcet7f9u5QlZ60HvuhlihZSGD
	 n6F214HDOxuASQg/RjuWWABehwVtGAk3iqAlc+K0fDjzYlacNn/mVOartdlVwLiJq9
	 c0YSxI+aHCgUg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id EE18F7E24A
	for <linux-rdma@vger.kernel.org>; Wed,  5 Feb 2025 10:49:10 +0000 (UTC)
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
Subject: [recipe build #3849332] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173875255097.1817859.1814628308987495147.launchpad@buildd-manager.lp.internal>
Date: Wed, 05 Feb 2025 10:49:10 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="b13dacce4a364151a813e3cdd6940bbff676214a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 8f0b5529898dcf81ccda5e22a88b227d16e2452d

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3849332/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-111

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3849332
Your team Linux RDMA is the requester of the build.


