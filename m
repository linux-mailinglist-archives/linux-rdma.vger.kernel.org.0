Return-Path: <linux-rdma+bounces-4967-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02E497A017
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 13:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC65A1C21BE8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A962148304;
	Mon, 16 Sep 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="h93R00v+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552A1804E
	for <linux-rdma@vger.kernel.org>; Mon, 16 Sep 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485331; cv=none; b=on/vBhgtcoxsWRooIpjCAQs/TeTvSSXnINZHDQxKoEDkGbBkCreZomyT/mxhVeCC8VvI8cKHhJYNzNQwqF7wjI4IS6HYoe0D4UqCmS+plQ0apPGbTQ1C0AGiDXsdHWqR6hzyoq93rCIj/OtOMG3/Ek6yE3lGz9avL2200xdNDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485331; c=relaxed/simple;
	bh=hxRMUUhMaxbmV1ZpioiIfgL2tuvlUgoD4pZdtXtQsWI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=AiFteP625W4VVCJx2G/18kljI9bMTrm16EEx+2MUAesJ0jEivYxPhwEtctd8a6HukAV+LYAxxA3SszG+xyaJpq0bReTVmjYG3ysOvzJ+M8hQ8wkkFf+kG1E6Xuvd0L0NBj0pUrWylXTJqgcPANjwxryYJ5IslQ025gO0oJ4hD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=h93R00v+; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 0732244666
	for <linux-rdma@vger.kernel.org>; Mon, 16 Sep 2024 11:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1726484772;
	bh=hxRMUUhMaxbmV1ZpioiIfgL2tuvlUgoD4pZdtXtQsWI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=h93R00v+26DW7AoZT4LG3OxvQKNpjlVNpJ17DUcpDvYNriZtnKsRI+NyE3lGonBsJ
	 0yax/IIh+yTY2T7S1GBQsuKwXMDe1FCBB0tTPcca8jogd9q+k5crp51+mTQweBYTcW
	 UzcWXZuCmG1EKvi2/OVq88whHhZcU0ui2LsUO+ZYT5q5pfcbMFRUFoBtX2xBDajx2s
	 u2Mx28XbPLdg68w7jJb3GPQdyD/dfu5F013J9cM0wSJ7YjCeiERE2kHs0WA7JbnBTk
	 6bDTilTIFYIgq+LkzJpIVPi3Li1AX5yXEut910u5jQB2Tq260Zxa04nwVNfaqP39OX
	 RqE64pWikan5Q==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id DAF487E24B
	for <linux-rdma@vger.kernel.org>; Mon, 16 Sep 2024 11:06:11 +0000 (UTC)
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
Subject: [recipe build #3787641] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172648477184.819562.7949671799800838977.launchpad@buildd-manager.lp.internal>
Date: Mon, 16 Sep 2024 11:06:11 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 59a7e5fab710bd065d9c0f428c3ddafb04084b83

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3787641/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-064

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3787641
Your team Linux RDMA is the requester of the build.


