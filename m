Return-Path: <linux-rdma+bounces-1773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F811897AA8
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 23:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939A1B24164
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 21:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB74156672;
	Wed,  3 Apr 2024 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="GmrOMtK0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E9F15687E
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179725; cv=none; b=km5o7RM9cMaTyxnJGbE6baxXNVuAUn//uQDb5KxNOAsj9ONcpomAWz6t6OGrSAmvHPIuRD1rvlr9+oCgjSzs6Do1zMbMdJ5aEqCFUH4j4GyYcNR2Yj0KXjAgtg64Xbi0ho+cZqZQI62Ngxh2SqZrX1YSg2cYIzebbZOYMlfyCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179725; c=relaxed/simple;
	bh=CzNasDftIy2UvC92j4g8knYBs+DDwEwlNiH8hYpR7qw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=A1NUch9mE28EHxLMHq5JAlASWoPpI2kkJ2Fogqi9E90LiQkMspT9ighDhMlbK9WonwA2HkGicOwpP4i6nmzxuX5yY09jhBMGCsMMZI+vKAWMba1zQUzlSgf36zZuVIDDDlYzzlXaXM5r743bsHKNSU/c/Wcj+18vCur0VOAHXfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=GmrOMtK0; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id B247747DD2
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 21:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1712179110;
	bh=CzNasDftIy2UvC92j4g8knYBs+DDwEwlNiH8hYpR7qw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=GmrOMtK00EoHqNGMez+KagyDAkoEYMsWHx0AjNVJ8XMH2f40fcKMUbCPyG2gF97Hk
	 WidirChacCaQlGXqyyrH+KhbzrjLOZGT/lKOY3YMnzK4CCl6lG1ZmzTbwrSM1sQ7PY
	 1t/Mjbq0QU9eqxX1MrEeBQFew8hdbSYqugp2E7VpbWxA1toUbb513dKb78LnYH5rQI
	 VfPk4ON8doeK53D25pip4ul9MZW39ziMzs7Xo7EBIcbwYJH/WTLU/AIyLlCi9cccj9
	 hFBi4FBRF1v3hJHrh/VvE2FsF/vBhB2qIBCYv8V4W0D7IyA7+lXgNaK065GC2MpiGE
	 oVVOQjp+52dZQ==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 804C27E246
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 21:18:28 +0000 (UTC)
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
Subject: [recipe build #3707358] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171217910850.701.18349643419978871719.launchpad@juju-98d295-prod-launchpad-15>
Date: Wed, 03 Apr 2024 21:18:28 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f2bde4bbf6339aaba7c08aaac741cc3809bc8c84

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3707358/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-070

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3707358
Your team Linux RDMA is the requester of the build.


