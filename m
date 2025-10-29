Return-Path: <linux-rdma+bounces-14129-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDD3C1CF8B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 20:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 461C134CA02
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84C2307AD0;
	Wed, 29 Oct 2025 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="bcYvoqid"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955602EBDFD
	for <linux-rdma@vger.kernel.org>; Wed, 29 Oct 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765445; cv=none; b=NcsXavnAcy5qeUl6uOTzay6advHKiKgoFAuJmgCoyuPEyhiMaN2pGimdRBQWu5pA+UgoWw065Zl3cn4nNYU9OqOkOaf3Rrq+RnRZhml9n+SrCUnbvWajphjKOrFpAz4Aj/TzN+5fdTxHaBJ2hV6GHIVRWBEQ7TwHfBxKf26D2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765445; c=relaxed/simple;
	bh=MtxP5fqW2eEhVtkaEQzkTfbOKUFpjffAKuq5wJHpKCw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=gNciSAQxZ/Qrh8Cg/bCXnG1/GgeJT2m2lkLi3xvUy/MsB2kdA85LDy65TgN6Kjfa/Pp+W/DkEj7r6OkqiiA6z786pvCEiz0a9NhoHQSKRUYCS/o8jw+QLc0Z1o+i5baHeJNL+YCsJfx5RaTOKEIgkFl2NZEF8k25+ZVt2Sf2bX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=bcYvoqid; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 631F2400BA
	for <linux-rdma@vger.kernel.org>; Wed, 29 Oct 2025 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1761765435;
	bh=MtxP5fqW2eEhVtkaEQzkTfbOKUFpjffAKuq5wJHpKCw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=bcYvoqidMDE7SHA9mMvP3JpBXYBwk/wH/GZPhpaaWXNKRrRcLunKcXqBMlc1P7So1
	 W3FpeEy/yAjJZdgUc8sCVyOtvkxRR5QfRHlsPgPWrw0GI/gjY48b2IX9bhnLkmpVgR
	 4NaQigIhTN4+pXH23nA3dSyvrvqDeBFu0U0CaBkn8/NVplMbcFU4wCzsOGSk1QuH88
	 /4RHSlYsTs88i2T8lM9ZZ8PZO/5Jr/Chd9/9zoePnezmELG3mSz0XlOWm86RrfFc6l
	 AeB2bhzD+iUGdsvod5+fD5S3xYhREfB8PurrXlVMawFdChzwYC2K02/eAJqgEMVxHh
	 JZkddGXOEd5Mw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 51BAC7E772
	for <linux-rdma@vger.kernel.org>; Wed, 29 Oct 2025 19:17:15 +0000 (UTC)
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
Subject: [recipe build #3964761] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176176543533.715.8760938974028969160.launchpad@buildd-manager.lp.internal>
Date: Wed, 29 Oct 2025 19:17:15 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: eb45762daa95278c00e374fc939d40105ed82cc7

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3964761/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-096

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3964761
Your team Linux RDMA is the requester of the build.


