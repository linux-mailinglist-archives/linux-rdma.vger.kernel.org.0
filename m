Return-Path: <linux-rdma+bounces-5252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE2991E20
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 13:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42352825FF
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195E916132F;
	Sun,  6 Oct 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="LQqYltH3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304C7F6
	for <linux-rdma@vger.kernel.org>; Sun,  6 Oct 2024 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728214327; cv=none; b=a5qBmUA0QI0yAXmqZwRKYqskQ2yrLaGtJjJw/U48AsF86EzIFWcB3Qx+4chcsUJXC0OiuTyW1dLLQW2SH2/ZTv/WAI2LpVnylpgyFIRRAjc/Vx04duB90BYJyafoOZLK2JQiW60Ku8mryRhJK+RlLH3hKMFsEUSzup0hFaNzCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728214327; c=relaxed/simple;
	bh=ZkeDI/3e6v8oFGjx/TlCAOecbL1KmnN+vlDFecrnKKs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Le3+UlbTezMjnZmTxEiAqdJKJlAlhRxIZjM8jcJDuXdS7EJKscnk9RXnzc5gXpEZLQ3FCqsYeqe8kyq0JjpY4NCeLUwaM3XVm/A+kKOxCCF7Dwc4joGS0nfvx/DaRWu0lvCQgFcXRlX14hFC3wXPADROace84mnmbC9dQ4Oy4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=LQqYltH3; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id CC06A44F95
	for <linux-rdma@vger.kernel.org>; Sun,  6 Oct 2024 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1728214317;
	bh=ZkeDI/3e6v8oFGjx/TlCAOecbL1KmnN+vlDFecrnKKs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=LQqYltH3MBm9+DcA9hdfzGxQ1wEVNBPP+FIVUvblQvLs3YzM3drRwYBnKQ4+dGo7N
	 FylylUUF7YeUJyEyEE/5IPOFnWGFa3aKEIDaa5fGZWGS3Zoz/QuSfOhhkD4PAcWwOy
	 HK4ji39HAPumgl+2ZfDmTcQfOkCfC+xpKQ3EkJ22RPZhkOaq70wjKmYFPA60IniKip
	 qtyAnBr96zPddq8juPceGiEQulvdAjqkTLefyHEPMDlC8ZX7/Je2KQC4NWE4B0yYni
	 Ff6xUZd//OJoO79TxoyaVzMcdwccUoPbR79N0zf2V3v88xeeO3Hv4Cnp9rS5wb1pSw
	 rnEZ69Wbj8/zw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id BD3407ECBC
	for <linux-rdma@vger.kernel.org>; Sun,  6 Oct 2024 11:31:57 +0000 (UTC)
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
Subject: [recipe build #3796814] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172821431774.742876.550532478756979840.launchpad@buildd-manager.lp.internal>
Date: Sun, 06 Oct 2024 11:31:57 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="6341c735b243a0768c3cb66edf85737937cab327"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: e6fdd627c5270204a2a86e0a19f2c0c970565618

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3796814/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-099

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3796814
Your team Linux RDMA is the requester of the build.


