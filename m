Return-Path: <linux-rdma+bounces-9836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56682A9E3CD
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Apr 2025 17:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5376189A4F1
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Apr 2025 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E36192B74;
	Sun, 27 Apr 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="NScg278C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FD88BEE
	for <linux-rdma@vger.kernel.org>; Sun, 27 Apr 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745768832; cv=none; b=UvHKT3UWP4XbDqKVrJ9a6+rddhGfSzLuO3wYogbQQFUyBGmrufGhqirqql2BGWF4ZvanwBG1rJIhCj6lXIEwwkfuaT3ph/frtV7YIAe/1tzDYwtGKp6tPub3CWJt/vlbqKG2TsXfD7LHpX5IKivvEoFDay4aUdQJUAtphqrjLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745768832; c=relaxed/simple;
	bh=rUfeQT6v5UIEJtS0nPto0D/NgnoKDXP+Q5OWveDeZQE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=sNtcxY5JBplw/3NrZ2BHecoOtpr+vm9s+0BkPIav0Hjw7vqRYFWo312S9H5QPUYqxCdgGFZXt8UYLfGfcEfl99bkIE9TI6Zpe3WX5lHrXcdSWZ5YPH1JTjNJDLqBkHAL1hf/2+/0mKNqzVpXKHYW2NPlC+WmAHKwFPSF4ou55Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=NScg278C; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id A35B03F7C1
	for <linux-rdma@vger.kernel.org>; Sun, 27 Apr 2025 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1745768821;
	bh=rUfeQT6v5UIEJtS0nPto0D/NgnoKDXP+Q5OWveDeZQE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=NScg278COFuU2eWTwj0X1VfG9Ccnqmmt8ZJUTG6NZvFSCxcuJ399aavfic2o5FsQE
	 qTAw2kGsHqmLdlTMlf+clfPyr7ffQnuWYxYbHjB+P7s8n4Rv8tynQpaiTHLGaDArnA
	 lKVzuOp1+Ex5q0uk1kHue8KKFQF8GGdvflFlMwiioxR7EDsiE739VYgjiMXgfkXh0u
	 PHYWQcollOY5GEMCEz2z0ddgk60BONOOqmXtDWZDz1jdku1ESWTLk1evUtfoQImnj9
	 Py4xzivnXGILfJ4Z69js700bMCBu2JPAzuGFOC7dGUVbe5pGkXA8MyfhWKoN0lELED
	 l0BQozJ2ux1PA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 893C87E246
	for <linux-rdma@vger.kernel.org>; Sun, 27 Apr 2025 15:47:01 +0000 (UTC)
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
Subject: [recipe build #3888698] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174576882153.1088752.14401505462831519363.launchpad@buildd-manager.lp.internal>
Date: Sun, 27 Apr 2025 15:47:01 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e76edd883483c71c468bb038e98836435de44530"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: dbe976bcbc207fcfc3736e9b9c41ccf572d2f075

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3888698/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-100

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3888698
Your team Linux RDMA is the requester of the build.


