Return-Path: <linux-rdma+bounces-12480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E9B11E97
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 14:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A94F57B2B88
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820742EBBB8;
	Fri, 25 Jul 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="FeRubekZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9E2EBDF0
	for <linux-rdma@vger.kernel.org>; Fri, 25 Jul 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446747; cv=none; b=cfQnSTrhTNJidisij2ITi0wnAjnnwmTbOtKhJ7mwM5q341SgwZeHz9FBZC14HdwdSJI0eyIMcAMtNrBNQHP1W0zeYHl0r67UZAH6yjNU/bHkFMYLyr7kLTIvk+/tTk+TqUNTDRhMskkuhtKcUnP/m76AVJ2WBZ3SFbLIrSQcj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446747; c=relaxed/simple;
	bh=iuB5gXzTrBmnqrCsgX7HGMDEc8YMXvye+Tfhh+lqUtY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Ch2t4ExzMIj73X/kQCHw/YDqCgo8wHZDDjO9RSa99gHho2gXpbeZo8Xfez2KxEpn5M6PsiP7D+iltuQd5AQ5UT0BddYUigEy89FWgD8Ofxf81g6wRthXNz4maV/mPG5EpSjAYPeXQu+Av3QD4FLxyDHm3msd7z74SrvZRV9PUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=FeRubekZ; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 126DB3F1FF
	for <linux-rdma@vger.kernel.org>; Fri, 25 Jul 2025 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1753446738;
	bh=iuB5gXzTrBmnqrCsgX7HGMDEc8YMXvye+Tfhh+lqUtY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=FeRubekZn1tLdpszH/EECidBFUju9WZO89MM+jjiJZYICfEjFiItEOdIyO2q+PWNu
	 JFhnw/LJGTqVTyKVtmyu24ngSo/cBHe4qDI06Ar0dSvdDfrCj7bkjE3Im5kh4ZdXiU
	 Ouq4xnBlStmWCmVLdzuC1PII6TnKswLjFrZhafK2sa+CHkSTVe67hmZ1Zh/JujvQ5B
	 1p3gUDeyga1ethDby+Xsod8xQ7TyWuPKi5oaq3ovjJFG24u2A2KsbPIDWE8A5fVhm4
	 nI215qejYwGoVEx4qbLhkREwLsKtxgfud5158+g6s5+fph6gszwaLTkWJ6KFL2AUEq
	 LcYsjAP+T9V+A==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id E4EA084716
	for <linux-rdma@vger.kernel.org>; Fri, 25 Jul 2025 12:32:17 +0000 (UTC)
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
Subject: [recipe build #3926174] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175344673791.1714934.6960781134880373023.launchpad@buildd-manager.lp.internal>
Date: Fri, 25 Jul 2025 12:32:17 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bd06841ed8708d847f33096b5527f49720e929a6"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 3093b10fb66ecf5822268947a6759cd8275866d8

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3926174/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-089

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3926174
Your team Linux RDMA is the requester of the build.


