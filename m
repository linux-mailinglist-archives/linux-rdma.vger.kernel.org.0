Return-Path: <linux-rdma+bounces-5145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31998952D
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 13:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCFF1C219EC
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 11:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0171448E2;
	Sun, 29 Sep 2024 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="iRBXmqFy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329E17736
	for <linux-rdma@vger.kernel.org>; Sun, 29 Sep 2024 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727609953; cv=none; b=fRhLz8XdYndMLgE4PNuY2n902OcOVibGANUKLylZCyA0tJn8e7rdZmE3H2NAy8sH0nNUJrRjgjzLyLkJ4Rj3JhpDrhCQYJL7gXD5BGFGdSkU0FYvquP+HsHNFLdl98Flz31yV7Sp80MS20KAXVGpzJ/o1epHgV2brg48CYb/Yzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727609953; c=relaxed/simple;
	bh=pNM7zfps/Qpi7Sm7Q2z4pV9REQysGKfNT7DwEDeSuwQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=BXh1YDm1E2QsUavSza8PvEqW3HMHLRBRr981OzRorblQGoqQ9VQoskjPjKZj9H9EncG1QWb/jpZckAlXveXReh2oj02kW0M1FVu2G57xKWIMu+2SfpJLVvN6GT+oMq/Z3FFOR4AWCFQPogy2JMPGBqU6OAD3yUdVxrz4TMz/h+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=iRBXmqFy; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id BA80F3FA15
	for <linux-rdma@vger.kernel.org>; Sun, 29 Sep 2024 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1727609510;
	bh=pNM7zfps/Qpi7Sm7Q2z4pV9REQysGKfNT7DwEDeSuwQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=iRBXmqFyszGYf6oKmeweycF9bkDflMRNQq3tl+lmY8pyKKb7tnqPcR31ZDLBSp07F
	 t//bGV1ePPUqiA7IWE2vsptXefGn/PM3sGaxKtqKDhrhr1w24uGNJqj+htdU4m59P+
	 8PyCNl5UmIqoO9Kte6clUxnLxbUPdrj7ebUDqpEMgAuxFEaizKVPjpZesg189ha2Mq
	 R3akj38zaE2E4Pir4BWY4JyLKJ7yt5WqYtUPGd4PziBRNB2kM/wYVk8m7mciFGGxqS
	 fMb+IUgRFtX9WkLSlzWgRl5LszW6+tAdAbqguDiK4yYY2M7WztE15W3Y14NnjtZZta
	 PcWlRtUc9rVjg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id AADFE7E24A
	for <linux-rdma@vger.kernel.org>; Sun, 29 Sep 2024 11:31:50 +0000 (UTC)
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
Subject: [recipe build #3792932] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172760951069.1181881.9526275929652719553.launchpad@buildd-manager.lp.internal>
Date: Sun, 29 Sep 2024 11:31:50 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ea150875aae0d5d42b9ac1053e471f67992ea1f0

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3792932/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-038

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3792932
Your team Linux RDMA is the requester of the build.


