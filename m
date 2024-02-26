Return-Path: <linux-rdma+bounces-1134-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE243867A04
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 16:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434CDB2B791
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829251350D3;
	Mon, 26 Feb 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Jo01TZsA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2401350E7
	for <linux-rdma@vger.kernel.org>; Mon, 26 Feb 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959318; cv=none; b=WOs5ZGtVxsHImN+vipYz60l3SOGtniaoHyMMKZQbTxNQ8JXTWpk+xEddM1qkhtYRX/rQgltrqYzrjzZTNCVqSMhc77XGisRGj5sD2cfxG1RCePTJCzg/NayIikKDrgp33r4sQF1r8WfPFH8u3ow7lF71veXAAltjmV39BQt8xgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959318; c=relaxed/simple;
	bh=LqPvbmkcWi75Fb84YfZiLlxzVXXi40LmpUuoNpWluO4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=sOdPA3GPvAXxAIs/h1pgZrFVnMd7ahroygfJSrzGLXg7biNbZRLSnACab9aGf9+PZ8BX2bNHo4mXrV0ryjeVQfDd1l0tUTmEKz11ih2IQs6KKdBzHFsEYp4MKnwPQ63gVAHUP0tM9gRAnbExGA+ecjn+NaGORt+2Vo660+q0Zlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Jo01TZsA; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id EBDD841051
	for <linux-rdma@vger.kernel.org>; Mon, 26 Feb 2024 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1708958833;
	bh=LqPvbmkcWi75Fb84YfZiLlxzVXXi40LmpUuoNpWluO4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Jo01TZsAVsbdXFNbfJA6wHfEQPntMS6KaAsm0SNsgHzZOd/WnuZtgfQdt/CAf8j3N
	 xlqKE6dYdai2KF4GwRhxOyuV+c8oaLPbJSEAf8lBZ+WznhpxC0gdouF4uWnYOtviqo
	 r2lh6ti49HhO+oRck8BMqkoEJl7/0tODUC1tZc2mi0rgv4fgmmmzqWVm6Js86BDBRN
	 AFEI2+KzeIQYKUfYawIZhJnwyJkQn+XVqRVpkSHZs5sUQ1SrITsRv/R1tpq8BjCCUP
	 zerrAKCsmibWq/jrdcIKdImJnscMo9cTnDu1aWmbdnWXW7+xffNhtjNhZZAbU7g18K
	 w8WQ5zYLmQbJQ==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id A2B7F7E5A1
	for <linux-rdma@vger.kernel.org>; Mon, 26 Feb 2024 14:47:13 +0000 (UTC)
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
Subject: [recipe build #3688923] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170895883362.3580314.3225917499707251264.launchpad@juju-98d295-prod-launchpad-15>
Date: Mon, 26 Feb 2024 14:47:13 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="9643586c585856148a18782148972ae9c1179d06"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: b076dcd65b8d199461b3c68059c70b8bf44c5de4

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3688923/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-088

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3688923
Your team Linux RDMA is the requester of the build.


