Return-Path: <linux-rdma+bounces-15140-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF62CD4E6E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 08:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46BB43027A42
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 07:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DFB30B52B;
	Mon, 22 Dec 2025 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="jWtr6qGI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA49130ACE5
	for <linux-rdma@vger.kernel.org>; Mon, 22 Dec 2025 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766389722; cv=none; b=rmARMOAoeHBSiI7ghNDTopUhyczRxctVa9yWIsdvjQzaJm7cVJnzVEi5iNFXpCAXituW5MH1TUCQOdNzDKHEhcBD1VnslBoQhZcYOPKXX5Yxgm3OOd+awT2zZjw9d97twXABgBhTusQgYUnK3JAPAys32YcfyrNYRSi/cFF6Hiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766389722; c=relaxed/simple;
	bh=NGWuhJI1sOTdjb7bY7jufBYdhy1J0oL3PTe/X4fZCfc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=o6DIp88x1j8sWF17aM9clrO68P3z9t12/NZT/oRRgYK3vaEVTXE+0uCke0L/F7/JeBDJyM3evS36P/UEsIyYzWf1mSCUnyPYwYJjAYTGnxMhzdlaTylPcJkXoRkKhsR/L+HusikoC5OQB0rQD0AWUN9gpRaU7ggd77d6+zVGoWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=jWtr6qGI; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id E7BC840BAC
	for <linux-rdma@vger.kernel.org>; Mon, 22 Dec 2025 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1766389711;
	bh=NGWuhJI1sOTdjb7bY7jufBYdhy1J0oL3PTe/X4fZCfc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=jWtr6qGI1Iam0j+imOBNm6gHW/WgYb4yhTC04cbKHXZK+UiEP8aNhQuF6wlJpzJBe
	 ESBnnjMyvefLMocvW4T4fsS9IpHxhmSPiCtSMWop8gfaP4uDdbh+qbZTbtQddOYNvC
	 k9WIWz/sV8eiDvpMPzKixfgCMONT/P7kbGx0FJfPqjr1nUygzkOyv6eNgOWdKn6pbY
	 Rc7Y704n6rL2Xr199TSN4BfxCzPH2t8IZsLm3ZcnMSNknZvmWZV2BRqsvNtv6dPl8u
	 gmKXDQCKkYcipYz6hbzP5nQhn98IBMpYW9oRV6QRnxPuj2lQQi5KuySPep7NP6CNXN
	 WZh2LzRYX732A==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id CBA577E756
	for <linux-rdma@vger.kernel.org>; Mon, 22 Dec 2025 07:48:31 +0000 (UTC)
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
Subject: [recipe build #3988829] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176638971183.3431851.13047381186641709336.launchpad@buildd-manager.lp.internal>
Date: Mon, 22 Dec 2025 07:48:31 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 0ea0e77b4051c3e8579283a2f71b6896a3b66492

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3988829/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-003

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3988829
Your team Linux RDMA is the requester of the build.


