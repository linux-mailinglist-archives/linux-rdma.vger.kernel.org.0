Return-Path: <linux-rdma+bounces-6483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F749EF653
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC342838EB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBB21E085;
	Thu, 12 Dec 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="kiD3eQeW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF78211493
	for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024259; cv=none; b=qvKudAAr4TTsPoGxawdtiJRdzPNsSOR+RgQQGHXyUk5odj9cCF0mLoe8dkcY6OMLv6yXZmDWSwXLHPU2Pmyf9MEG+muVnKE8Ux3wvJurbQjEKQiHPQ/umjdStqbbJ1Qy08q8nNkwiUdV/iG9+53Q9cNAj3HLgCI3xSzj7BEOFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024259; c=relaxed/simple;
	bh=sXcSz0lrzILvpRs2XcFnUOS6h2X3geXpEJqSEfGpWLc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ANgmuCDdZ1MzE4/9sjzcOeNPq1gZGgaCBtqNF1T6K9l2u/4xAc01YYWeVUqNcDUWA4Ro+RfuPfsR5tJlOaiaJxjnOL40euK5sFnsqlVJR7qqFnsPZO58h9YSRprIAl69GyhY8VcvbP0l9UZteJoRNWLnls3SedyTm7rx8CIscTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=kiD3eQeW; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id EF73A4015C
	for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2024 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1734023845;
	bh=sXcSz0lrzILvpRs2XcFnUOS6h2X3geXpEJqSEfGpWLc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=kiD3eQeW/TuIEblOzecyqpySDD9qfke2yTXh/pwELJ1uHRNNHp+qyI1Tw9jPdtCAv
	 WEwf3z0Eilc++6ZF4ZWvQ2kR8KmgRkHTO1RXypenko6LzPb50gx6PX+f4NTTRepAqG
	 lsvETWaMIrfIq0N4uEMTIl/ySl7+OYAaxiF4sXmDT+XMx3cOdK4raQ6fuxFcsgWoch
	 QeKD+yokyVsq6R/qIgkgWyDs6aZIAynpsYIC3ELaEvJam90iVoevrxy0R1JwlYT1JP
	 flqN8gZkz12sjiHHfA1ZNpClt3bPZy+zIsBQl3fiZ1dewSz/PKLUVLQKwDy2FQ+aLA
	 juCYEh1SNGTjQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id D14F984900
	for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2024 17:17:25 +0000 (UTC)
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
Subject: [recipe build #3826595] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173402384585.1066581.11683918378987848895.launchpad@buildd-manager.lp.internal>
Date: Thu, 12 Dec 2024 17:17:25 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="39bd251485adde1a3ef538479f6c030babb8e251"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 7ce5993f1249562427d63547d463ac359042bc1f

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3826595/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-114

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3826595
Your team Linux RDMA is the requester of the build.


