Return-Path: <linux-rdma+bounces-12424-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB850B0F26D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C156758261C
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18712E6114;
	Wed, 23 Jul 2025 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="b1POsCyt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58128C2BC
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274528; cv=none; b=SpouYNIm8u3cKSf2y2NcAJe40ykxAzvRtJ0KFtMMMjwKQC7yQrI4Fnd2hqgImRofpNtzdXK97qU4HlQF8fFBEd1kA6MMGLGnfg+v3DCfJxfjOaDdJsxjkcKBjg+nd5FaUxsnwHGMQ1WiykhrzYzhY4qVyOEhzwwNgjirSxJeTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274528; c=relaxed/simple;
	bh=d/yF1ysUwVJXzAALy2HUQYUz49zlM020sEirSbnSNaM=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=g5+tk+/se8mp8h5Egs3DB7gIqEmrmFA4hOyvMx9eWxxZHkjoKDJHTzTJRrvCco6uEiP+I0uoDGorU40mrgin/4dN46uGubH66enDrqsv9xJZdqi4VtKkzlrzqoMpnpNr3qE9GsfnWQ5Xi2QHSsU/nSmURFBzPzeVNRU+s4JX3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=b1POsCyt; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 2F2BC3F27C
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1753273948;
	bh=d/yF1ysUwVJXzAALy2HUQYUz49zlM020sEirSbnSNaM=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=b1POsCytYJfzAQHbGfk1p2gWQDq49ACJXxz344wWNUNzRUFGdCUKO+3UVsUcFbTEK
	 iPZvI8coonaEss1t6JnKGSACYxBBEs9VhLma0ne6C6BrrSZ+Z+VGLRnOOZGSphSSke
	 tDAqGk9KMyr70aMRQEegkxa+HpZ1jnSiSyQG0CxegX2IZyW2aC1pa6y75u7Xsk2eZp
	 CktGA7xi6X9emqHnK6S6JegO8nJjlNYSD2bFFTdOVxJBr4ySe5uFXaHI7K83yjRCdJ
	 w1qBOusprBNVgJ9eZZLpoVIlrONFrT1Vy768a+pKL/g1f8PhY35X+FIn7a7QJ2pkhU
	 hMcZRxws0DtKg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 170D77E6EB
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 12:32:28 +0000 (UTC)
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
Subject: [recipe build #3925294] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175327394809.2830458.11646967763408509349.launchpad@buildd-manager.lp.internal>
Date: Wed, 23 Jul 2025 12:32:28 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4a935a27f849d9e76af17c154eb3e276e860afb7"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 86e85afab5afceac085249647599f2d2362c0eba

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3925294/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-112

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3925294
Your team Linux RDMA is the requester of the build.


