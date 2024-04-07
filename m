Return-Path: <linux-rdma+bounces-1814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A47089B044
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Apr 2024 12:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81F12844BF
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Apr 2024 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31C8171D8;
	Sun,  7 Apr 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="ccpYQT4+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7E63B8
	for <linux-rdma@vger.kernel.org>; Sun,  7 Apr 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712484116; cv=none; b=jnGgm7AScq/MLAqvqaR8L+SdmQbIzzrhZmzgLEH7JGEn6ZxQjY++7SMM/1Mocz+jEeQf/f1VDYZBlVYqq9W272saVp13h6RwehltKpwanYv21GZDY6LxFuKffSTEzElgfxu1yx6gbSZFC3S+4WniIbCqIKEm2xxkA7SdhCE6vfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712484116; c=relaxed/simple;
	bh=8c2HNU+lczAqH/l0isjQM2VjjShIfaPZs3LMd9nQuDE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=dEtQE4v7i22lfGWXthj69kdCrjknhBeImdRUkGr4IE0LtugY5c1w2+QG8riYAJSSdhU2C1Q4xmgeNN0QBbrbSuY5u9psiKh8KzCjLNRZ///8VsAXclhjY2CyZQNOpCSh8Fa+xzYlF4TdjlxrgpL7B3JWpKoWpUn6ttCGCDriZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=ccpYQT4+; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id E91E33F13B
	for <linux-rdma@vger.kernel.org>; Sun,  7 Apr 2024 10:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1712484105;
	bh=8c2HNU+lczAqH/l0isjQM2VjjShIfaPZs3LMd9nQuDE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=ccpYQT4+PCSoUoUpkZmlJ05ANhiDTHPpn6jVHs6vFYlprF+vMp+EukW7/+MC6cq7x
	 2eMqQShwj+3R5RTpUV1Hq5KS9zJTdcbVsEewx0rfDabV1lRfGVGJ/troIpuvlr3Fnq
	 kE52nrXbhGkvlL4eWktxMV8grwE6sX85dwyY78yXwnDmkTkgJPRhcPUWvuHTy+2VIp
	 KVXJs7nR9RVyvu3O+04oS/nK6dieQz6qFsS3CsC2kgoijttl1uzEOJwATajWDGrM7u
	 vFsYPCPCW4jrhyvKAPxxgQRCn0hYDn2nKaNJluGThlVICfG+YSGdviBk/KeiohLF/O
	 Yrp+0dR9ZN07A==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id DBCA57E231
	for <linux-rdma@vger.kernel.org>; Sun,  7 Apr 2024 10:01:45 +0000 (UTC)
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
Subject: [recipe build #3708865] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171248410586.1551173.5064894406674607076.launchpad@juju-98d295-prod-launchpad-15>
Date: Sun, 07 Apr 2024 10:01:45 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: a6c32064ce7d1e3c6f105896c2851a94968df401

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3708865/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-045

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3708865
Your team Linux RDMA is the requester of the build.


