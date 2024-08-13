Return-Path: <linux-rdma+bounces-4354-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A8B950D32
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 21:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B3A1F21C7E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A811A01CA;
	Tue, 13 Aug 2024 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="QCVo8xFp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A644C64
	for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2024 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577615; cv=none; b=cUxLgh9aXAmVu/jUVXKQUTefZxgwd00dzJ+ZNsmtZgE8ek35FMyvhVI7mvB/aRYwEqXmQMGIbOVNU0bc1G4Jh3ur69fsusoTMY7lIGA2V0bmoMAJytOpuuqFr1DGluN6jy/ZGH7rCL8B4nhswgTrA+3sAtapiy6LHFyJiauwhSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577615; c=relaxed/simple;
	bh=JRevA8VsECdV7uScj9nexCRAVQKJ7MQSbaeytA2ludU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=X5asf0bco9zGOR5/9DN+Co7SjCaOTu6g98jB7Aibd+6QTaoSOCPdeiAy7sJOct9Avy8+ZGrhd93hJYpkJuBrDMQtBWE7oIofKEWZfR7EJU4ZqvXXdO6puodL0zTa+s+fUEogL0H9JIi1+81t3HR2yIFAJcZ4nd/wMQtfyWPwNsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=QCVo8xFp; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 594FE473E0
	for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2024 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1723577605;
	bh=JRevA8VsECdV7uScj9nexCRAVQKJ7MQSbaeytA2ludU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=QCVo8xFp+KksJi9n60WxGwpuTFIo1KqnAx/yu6fz13SVVDy99MmmV1mbtH0qHd+vN
	 I0sLiik69WQnZ8hdgDDHjsLPv27rZSoTrtnf5toFXwm6akLwXA1W4At6TSpz52kl8K
	 T5JhW9yx3JqXep9kfs+gjqjrMkvlYhOhnPRH49coEQgJ2K9w1Gn1LN0NvRKo9PvCnj
	 Y46ShC3kWU2l3R6wjrNeON50u0RYmdPKBPSPFt52RXssg0uKcZZXyXcVRyscECBhKU
	 Tpn90FxEQo/vUk/mss5eg1wXtuZXW88mh3rizaFcZuIsH7wB9ysi5mYB/rLgnJ+rGf
	 MRzQP9tgcNznA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 4B7F57E24A
	for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2024 19:33:25 +0000 (UTC)
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
Subject: [recipe build #3771597] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172357760530.4023794.771774565462955406.launchpad@buildd-manager.lp.internal>
Date: Tue, 13 Aug 2024 19:33:25 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: a9ec7c6a414294a905537f4e0499a6f60ad33aef

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3771597/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-026

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3771597
Your team Linux RDMA is the requester of the build.


