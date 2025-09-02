Return-Path: <linux-rdma+bounces-13044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABCEB40D63
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 20:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BB83A96AF
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 18:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D9931AF3C;
	Tue,  2 Sep 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="eOtqSbHk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829323D7DF
	for <linux-rdma@vger.kernel.org>; Tue,  2 Sep 2025 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839269; cv=none; b=onhNqH4zMBbHu8RCa8/K/vTLZncNFVefNAUn1x1o2se8uROAgfpgao6mcXJgk6V9i4ukoypq6r6DopUZ72mJ+BkfWVlpKkS+GUJMCG0l9dk/aWP54BZJnmH1eq8A31Fz7rEu/ld02EHjpisnD/G+/B3njBBGzcJbYfncblyGn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839269; c=relaxed/simple;
	bh=6LEwz+IqmxgWL9ZO6VfCMuMstnIqRyxCZPzC/W0Cmso=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=HwCynvrPlEk8Q18pcG5QLOmLsohZvHDfkuZC3VDEOWiNs3oHKqEDx53xqmgEx4F6clGqL1dZSkKE1zviRtoLX5R/7CE7gQ15lCpRBX7uNI8XcRsmmlY5qyjhv/9iqxO+ZmZk/5dpCP8rL6VkEySG9NV2Oyod6Q8Zn9sCoBh1DFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=eOtqSbHk; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 941C73F747
	for <linux-rdma@vger.kernel.org>; Tue,  2 Sep 2025 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1756838872;
	bh=6LEwz+IqmxgWL9ZO6VfCMuMstnIqRyxCZPzC/W0Cmso=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=eOtqSbHkCmo918fC1kthGUEYwh+3Zukz5gPUUozBPxkGrbxH//1mjPIQsJ6f9L6Fs
	 mBKokiy9v/uCQNSfxD3znFPw0Q2xROxH3Eif2nvWeyCtpUpVZnywqrcWlePB2GPZ2e
	 RC2z5Jer9CXuoLEGLAXDmhPWMAB3KnKfszrlCqDFm2Wo3Y6l4IvzloBx39Tv63mNgL
	 8njlRUmVHUGuXEzLKSRJ4A91fYB8Y/HQXo+wBMbBC/qUo4gcYhkAZ6YmOCxiCkW5vr
	 1G2WAZj92Z5eQr2ZCkD0Cw12OyJZ/KG3rvRobgG+E/al2+rugKdA5M0PeSsOF2KkuK
	 9gO29pNTgXX/Q==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 6F2DA7E772
	for <linux-rdma@vger.kernel.org>; Tue,  2 Sep 2025 18:47:52 +0000 (UTC)
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
Subject: [recipe build #3941419] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175683887241.886896.463624218546034017.launchpad@buildd-manager.lp.internal>
Date: Tue, 02 Sep 2025 18:47:52 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="741e26b3c4422aad1a3f9f01f274946c738b6dc1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d1cfdc3ebbaf7510afd1eb9119138d8d34370a85

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3941419/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-001

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3941419
Your team Linux RDMA is the requester of the build.


