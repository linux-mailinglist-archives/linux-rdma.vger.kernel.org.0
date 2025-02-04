Return-Path: <linux-rdma+bounces-7399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B25A26FA9
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 11:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534FF1886B63
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0540820AF9C;
	Tue,  4 Feb 2025 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="OniNqlU6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB072036FB
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666706; cv=none; b=Vywp7GVIR0yfgR0sJO/CMjmdwUsJR7vWu/nHQwMsh591aGsnjcOlkG7UYOLnluSOKfe/tekvClWhvCVlmZ4H50VBPYhYw9tE29BRmy6P1hMHDAX1uMu/tm7SVjYDBSTY+dDdGnHgrPw3pBMyZoAJoTyeObWmpGuwJ3Vbjbmgpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666706; c=relaxed/simple;
	bh=whWBGHphCm3IS1q4CRjetoDh/2Fwc04KieARMl1yEzY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=uQ0lkqrGxdruSKLnUpa430MM1aWm/MviqG5RhvaVRk+E9FOHsOqDD09RjEDSA/BX3X/KwNLa/FjcwlvgRM+RTa/U/G5ruV05M99pCM9RSuAs+Kmp04NkQqLvt8iKzo8hMsNJU0JMYUvwdidl1iznpOa2mwO62Snbd8qjFNd74yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=OniNqlU6; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 27D3142CDC
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 10:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1738666243;
	bh=whWBGHphCm3IS1q4CRjetoDh/2Fwc04KieARMl1yEzY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=OniNqlU6EoWUPgP483uJr5ACpobE8yVVs/jlJisWtYbH46yILj/mVe5QlAaYpG5wD
	 U02nqjuOtAJskHnK9YK3nnP1s7IftHCVEksj/EZpJlVvIOchH1wlva472D4Sz3FU/9
	 SGBexfrn0n8ZEScrlwWg/YOo7tlazGyR2/GiKN6db2MeKgd2n3pWAENYTo3NgD4sAF
	 9yKJ352XkqsS8tI6OVXVImw17YR0rLA+17pomowkLk81zz0CBY0dd5gna99d+O+DeZ
	 sc1HZg0/YYkxBNDamZ2LTIZJ2SgaRwV0xm4xR5gRBX09izNOp8ImTAeKyf5Ugb3BsP
	 iM33QChZNcW1A==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 13B697E24A
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 10:50:43 +0000 (UTC)
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
Subject: [recipe build #3848689] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173866624307.1817859.16552070942908908901.launchpad@buildd-manager.lp.internal>
Date: Tue, 04 Feb 2025 10:50:43 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="b13dacce4a364151a813e3cdd6940bbff676214a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 318cca451a1bda42d887d0ce7fec2168877c48e3

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3848689/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-089

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3848689
Your team Linux RDMA is the requester of the build.


