Return-Path: <linux-rdma+bounces-9882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F6DA9F4E4
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFAF67A9CF0
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302BA1FDE3D;
	Mon, 28 Apr 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Pl84GHMG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1DA28E0F
	for <linux-rdma@vger.kernel.org>; Mon, 28 Apr 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855275; cv=none; b=uv5jr8T3QC0X3D8/N30lWvD5WHdgkw5xJCQf1p4VgBmTpPr1iii7+bBEVjs5/qFDiEo4RIp2Aa40g2mtSOybSsjReYyrLqxe2lg3IDk4jqS0id23pVpGbkLxwbq4HvwKQEBzUBO0XAVlvp2pVw4YhdhuNjJa14ZxYTvp5qTWn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855275; c=relaxed/simple;
	bh=8E2LaHih0M0GFeYaha0rPsRV+THQvFD979o9jdO7k/k=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=tPHRO5mByX3IsdzSmqr0IMV0aKaG1ilOC2gunEW9T2WJIAHx1kKEosgkTbo4O3PzRx/VraGbMYHG6kTQkTzdlJ73AdZXR7IFJvgSzHmBr4qm746lfN2qWK8XbJuJEXIfLrj8JJB16Gs4AIo31y4xO/oLysTJHrjoPtCzh4tBFuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Pl84GHMG; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 3BEAA40D59
	for <linux-rdma@vger.kernel.org>; Mon, 28 Apr 2025 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1745855265;
	bh=8E2LaHih0M0GFeYaha0rPsRV+THQvFD979o9jdO7k/k=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Pl84GHMGD2un1AjXtzrmTw47OGjAlPYWHhZDLU1uKaLpp2HpH+3o5Ow9+cTVS570I
	 gx15bAxolbARerCbIQAPqDIa9pyuf9WQjAVB5k/0+941oKAaT6vXynKfeuJDPXqSBS
	 N2Z0ftZC+v1NB8j6DK1jk6kgrhYSsNGwmLvpTrGwa/7Dcoe28oAO97HJJkLyXtBnD2
	 MCczIY0MkJtGC9tSII1zSpcdzD6POGLsOhS8/4gWOl1z0UYc74D1vGS8MJAXcsaU1U
	 Y1/o7gVpIXuY4w8xuisISVgBUjVRJEi+HP3dy/NESf3RyfLusuJmMkFfw7RdO9jffa
	 FjpHONCamgwWw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 294107E246
	for <linux-rdma@vger.kernel.org>; Mon, 28 Apr 2025 15:47:45 +0000 (UTC)
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
Subject: [recipe build #3889202] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174585526514.1088752.17634781256328306220.launchpad@buildd-manager.lp.internal>
Date: Mon, 28 Apr 2025 15:47:45 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e76edd883483c71c468bb038e98836435de44530"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5883688fbfbd8bc8039fea68fb8e6f91229db874

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3889202/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-099

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3889202
Your team Linux RDMA is the requester of the build.


