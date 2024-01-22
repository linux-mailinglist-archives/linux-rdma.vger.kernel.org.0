Return-Path: <linux-rdma+bounces-696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 931BE8371F7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 20:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EE428CC58
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882B604BF;
	Mon, 22 Jan 2024 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="HTZg1Gls"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AAC6027E
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jan 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949236; cv=none; b=bOwu1g7nEhpkpSi4/NmfvqDZGWPVHaI/wsuq4iLMTuB8FkZqFJ2rKAm52W6VOXc2atf70OD4QQMiBlaQYki2zorEecMMB3HGZ1+CIQsWzk1ePLBi1iSNKG90T2b9Fpe2D/Z4mQKGkmZvp9TlCYcspzpX2T2oQtD/XzKNMhyTmDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949236; c=relaxed/simple;
	bh=5tAHHFZHmDoE7pNDByxS73nN9ErhoBaIEay3Qq/V240=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=nWtuIHJy9y0b7FehAZrzI/tSB6wFFGBgtyPkUhQ9rX/l4+xFBSHNtSxBLOm3WaTS4HbAhDym6at6O/zwECHOYO3yYgBPBlEEyTuRyythNkMrgy5CJGvcnq/8BAAGG+FqSk/knX5JbvhPj64UYBlojx2lo2nvNwAVXBi9FdmMeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=HTZg1Gls; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 311DF40116
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jan 2024 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1705949219;
	bh=5tAHHFZHmDoE7pNDByxS73nN9ErhoBaIEay3Qq/V240=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=HTZg1GlsQHmSPQFMJaWgZeuJRKB4rDRyDCyl87pd/6AVE6CPZ2b0pg59r9QA0PKbU
	 qkgKDD6XV0nuaEM3ELxYd1HnmX3dPFKBuGHZN3LCKoBN4kerj2GhCHUNMe0bmkm3iS
	 eiCMcl9q5rEdVmcGFErLpbSj8K7Kxmxl3K0zc4D9/ZuFzF61f8sQPTsD7g3oSdAoiA
	 zDALKwKTbvpeJ4QLoxuT0XqQKazlDo+pX1FM5orRFWEHTRFxcD3hyP+6l7HI0PiiF6
	 H7jBrH8TcXGeeHHzHbm6arAbBHN5MmmRDRHPUUMNBc2ZeVS++q1LLtsWnEKX0WRXHr
	 KtjG3GcMv9l+g==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 0F9327E5C6
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jan 2024 18:46:47 +0000 (UTC)
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
Subject: [recipe build #3670517] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170594920704.3774464.2348043546030672915.launchpad@juju-98d295-prod-launchpad-15>
Date: Mon, 22 Jan 2024 18:46:47 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="ff54b7050d99a0d84ff58e179f1b8e071713b594"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 63711892beb457033aa7e20eb8bb9daea74f45e1

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3670517/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-114

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3670517
Your team Linux RDMA is the requester of the build.


