Return-Path: <linux-rdma+bounces-9674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E628A96FBC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 17:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43CD1B65F12
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B01A28F940;
	Tue, 22 Apr 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Yp1rjhYD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43BF28F926
	for <linux-rdma@vger.kernel.org>; Tue, 22 Apr 2025 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333876; cv=none; b=Ogje9FRvn4H3idxfCYcUb/cnUFVSLH64NZmSbKuQtxCeqT65dsxrGp93+ByUL2qGg2PaIezi4EYOZbx/yuBdFTGoEG6tGE30XKDeWxBWo6Vfbm9xUUbP+nmGyxf2fY3XKty0pcPlvzN9qWM7C/QniQDB5/kv79mElbJMCos/PTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333876; c=relaxed/simple;
	bh=NDmH704RZclE04eIUGhBpzPfSi/T+pornaZ/MrC8hgw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=IvOswkEAAmsZNLQjCKEJ3unbAjIR7J1aYAihwu66nFZY+qz7rmzSQSRoixTD6Q2XYt4FGboZkf++51eQDV8r1S9sY68GTp/yc5OwWHlPHCR+LtZeP0rS9cJjQ33SmhtPRjc4BuMnvoKhNdg0ZkP/YjE0GXJ/3Cptc1zLRxbCeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Yp1rjhYD; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 9EE013F7A7
	for <linux-rdma@vger.kernel.org>; Tue, 22 Apr 2025 14:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1745333351;
	bh=NDmH704RZclE04eIUGhBpzPfSi/T+pornaZ/MrC8hgw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Yp1rjhYDgwyjAEb1Eyjp2GHUBxBCPjDB66YOsKWrIqDUIkDtg1C7EGytvkZ2lISkd
	 0P/i8eYa4pD7KfHVTz9EDs1seER+9IRMZcoEEndiPsxwprJst49zPG+PgrEiMT0q5x
	 YRdsO3GHKEpz9AeMpfNjs0J9SKg1Yh+bciwAsyRyLZsVQ/oDt/eO/CXPmp4s9GsRW5
	 IrBl/Wyyn+C1/tQPCKbgheRnBNfPSYN3U+YE61G95J/T1GGU54aPPsXigDGJJbGvBR
	 NKMFEmTZZ1adJpZVwHJHNr/c7fiL153tn6zq+G4r8OT8ROZsNLdq49pePNnbcRpeRS
	 i356SukEJu7yw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 94D4E82DE9
	for <linux-rdma@vger.kernel.org>; Tue, 22 Apr 2025 14:49:11 +0000 (UTC)
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
Subject: [recipe build #3886525] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174533335160.2962190.3469320707421236439.launchpad@buildd-manager.lp.internal>
Date: Tue, 22 Apr 2025 14:49:11 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e76edd883483c71c468bb038e98836435de44530"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 45e61e92e3524a6daa19a29032bffb6109ba6111

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3886525/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-088

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3886525
Your team Linux RDMA is the requester of the build.


