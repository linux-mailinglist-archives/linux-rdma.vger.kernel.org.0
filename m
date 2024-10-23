Return-Path: <linux-rdma+bounces-5489-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BEA9AD484
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 21:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8155DB22259
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B86B1D07AA;
	Wed, 23 Oct 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Y1bT3//j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01614658F
	for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710441; cv=none; b=K5V9pD8mYbHFSh1zBl7XaHl2ODo5u7JLemMuwIrVod8R1hHLr7XvjFNTnjvmkFuV0FHTcFyMujjQdjjTvLDIcg2qp4KFSEuRErF0PTWCSFT3yfpLfsNbaJ1of6eJtLgnPsRgIRoWIYi/B9XOrVU9x8Is574t61F3rgrIrJ/OXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710441; c=relaxed/simple;
	bh=FrLMsW1wH2rxaLPCH6KHkdJLVwUHEpXgdqDHBmL3BwU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=TzXLAXNkio6fnV0/gw9xi0DELUDKHTQJlfKrp/cWuhdyg1/0aEYj69K5EDG8lagu/WyO7fNn33E95leqYBlFy2fWp+dUJVtTEuT1WRjw+ouj/9ZBqi526LERf4DSUOR+wDSfdJIu3KpzuYlLPjWV/FjA4Qc2PGcKWfNq08AggyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Y1bT3//j; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 185673F0DA
	for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2024 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1729710122;
	bh=FrLMsW1wH2rxaLPCH6KHkdJLVwUHEpXgdqDHBmL3BwU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Y1bT3//jdK2f304Q9DrMalzx7PQB58RVF17VSF/FzdE6s/RJ23zjcPHbd8UuldITA
	 cEB9StLtGDtUZTITeBwpt3ylgypAajc5crYuDTL6cIy94CsKKYBx7UALsEFBzNPFSh
	 q36vycO+sxIYKPdpJ4+K/W2qlaMwxvGoHhxbx1GiDajVEQkzJVFw0ikuhiqqC65JzC
	 593H7A70nYfUr5ISpFEJ6Pvh1LFpYjs39Cqx4R5DQTdhJKiYNqCJK9twpFOyO/xScj
	 l2vX7CFQ8RZsQxiyTpZgcr0H+jQm0F8WaLBhLn4EOHxld/JpXYqWMB3TUnnyyvxlyC
	 n//0KbzNuVDyQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id E988C7E240
	for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2024 19:02:01 +0000 (UTC)
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
Subject: [recipe build #3805178] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172971012191.2122742.12585863523970376981.launchpad@buildd-manager.lp.internal>
Date: Wed, 23 Oct 2024 19:02:01 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="22ade00ab50b929fac63b8ee7252243aceda294a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d7ef6fc8839fba253a7d666aeb066b30875bbede

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3805178/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-031

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3805178
Your team Linux RDMA is the requester of the build.


