Return-Path: <linux-rdma+bounces-7085-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20746A1616F
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 12:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A1D7A2F7A
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFCD19F42C;
	Sun, 19 Jan 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="u/Y8Z6av"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67A13A26F
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737287235; cv=none; b=PrK8+UgOiICvH9absJzH8vHWgQhJXgsLIuZpMOBNS0BA1OjrdcN+nE1dLikm8P86XIVz2KFaC/rIy8+/pirH2ugDbh6kwwaXNPC+Sd9HY0MKSYoT8PpoUHvAR0VA9oKJi2EQg2HfLYUI4+oIRSLeVLMohTpEQKnw++sV8FXIoxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737287235; c=relaxed/simple;
	bh=/8+5G3u1m7vktHPvRUtaHFXMyDbLT+1ddt5b3lnwyHo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=A4fI9kg70mV9OIqz7V0/Nk1DXdpcdfA/vN0jVLyy7HQkch6tWXRxudwLx4tHWsUoCSF7fhjzzdy+TqWU+U/mkJagK8gOj3pXXFa2W96BLhRChD/yqOP+K1uvZvE6PD0yXfrdIF6gml6Q6Uf0eOua9BGrxGWJ7QUDlwoYWctLwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=u/Y8Z6av; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id EA9B93FC5D
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 11:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1737287225;
	bh=/8+5G3u1m7vktHPvRUtaHFXMyDbLT+1ddt5b3lnwyHo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=u/Y8Z6av3637BpwFtRlGbNhS3nqlsTiAbM8hYm2oHG6RjaRsI5EkLWYUpmhMCcTcq
	 VQUd6+7FSHuaO9QIGi26Bxkmzvwmev+zJmCz/RO7FBEEOdt50mQ6S6Uin7uq+i9QyN
	 3mllb8cVYcWJAg/FmYJVouDyTKhVk/gfl3WB/tEkeSK8dCaE+02fILdM7+VXSAEwWU
	 yI9wVGtHtk/Woz7l5I97NBRd7ZpgScExcA30CDTbBvTtPU+asKTXH4XTX1Ng9IMx89
	 RsNHPBjdeBrNRkepxd/JuIyXsIFNw71Ul2vtKEIZy93ceCVUzHtdokgKQ6MMY/+pqQ
	 pUjQNXd1lxhTg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id E107E82FE4
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 11:47:05 +0000 (UTC)
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
Subject: [recipe build #3841964] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173728722591.2646399.18024673913231029961.launchpad@buildd-manager.lp.internal>
Date: Sun, 19 Jan 2025 11:47:05 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="6394e03793719e8d73f5a60b5439440e693c92f1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5dee462b36e8f6e942614c6a049fe4add6415175

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3841964/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-088

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3841964
Your team Linux RDMA is the requester of the build.


