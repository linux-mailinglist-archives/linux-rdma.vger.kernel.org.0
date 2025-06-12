Return-Path: <linux-rdma+bounces-11256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF8BAD6F14
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 13:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6E87A7DAB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02CC2F430C;
	Thu, 12 Jun 2025 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="BXTPeEGQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25026EC2
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727964; cv=none; b=Q4mdOV8fF3cQiGZ8I8F1CM0xgzyu+bFJlORKy6HmrywEDbfV3cMfhe3UpA1elqR9/2rBMzTSvlsB5wy2eHTdAQLSIE+L/BaU51xzcE68DpXcSda+xYBsmadWOpjz/LJMBKXwCCFFhiHar0NArVeJgjLX4tJ6NVcuCzZ+W1czAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727964; c=relaxed/simple;
	bh=a2ynJNEYpEHNeIUGKaZylk4dys23lGq6Bo8Rd18w7ss=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=lpJrO/Xr7wakRdgpqmJSZZB1dVizDhWji6ENveLmigxoXOzBzk8HvXsMHKwScvKwz3ZRk2mPJGruCbvso5pEF+0JrVldeITe4qbbeehZOR5CnAzjI9WSXFecGgCaZ6vZDdXmQxFajltVL8GI9hMoA+2+V/NW9dte7k5bQL6xMsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=BXTPeEGQ; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 68C4E3FBF5
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 11:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1749727954;
	bh=a2ynJNEYpEHNeIUGKaZylk4dys23lGq6Bo8Rd18w7ss=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=BXTPeEGQqqFUaxrNaQRnDMLg7oosmkgfSRDuKS5bueErOaPxn46MZ6u+jn10pam1A
	 8PtgwHmG/ahfvNKL4RL8VTFbt3K6YZe9h+AupH/dosMqIXYairJSLPqiXrzaUrImS/
	 YbbCpcH2xQ3msTzHn3EIDlddQnNECl/nBZUXGaHstzghkTlBoUV7+sWe4N2iU44AFa
	 PyMwPwPV5J92vw8cfrlWUKdNOEP2oZbqUvgAnaUEhglrr+y3dKbWxtXJdzE5vZMSXj
	 rMxOtuQs3Ei03id8xJMSOQi/QyMVQSxjxzYNJy4J6c2yUeX+1XkQBP83bZ7j70kAv9
	 2RfXrFh/sps6g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 4DC4F7E24B
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 11:32:34 +0000 (UTC)
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
Subject: [recipe build #3908803] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174972795428.1008304.14045564623822925660.launchpad@buildd-manager.lp.internal>
Date: Thu, 12 Jun 2025 11:32:34 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2f3e2deec61796d4ee775e1cf25403fcfe2e4659"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 1ae42de10a238b6ff6a855a0daefa68f600d9754

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3908803/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-088

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3908803
Your team Linux RDMA is the requester of the build.


