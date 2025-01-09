Return-Path: <linux-rdma+bounces-6924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C73A07668
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 14:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A1F1883FFE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 13:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978EB215F5F;
	Thu,  9 Jan 2025 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="D5T2ckXp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB87BA2E
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jan 2025 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427812; cv=none; b=tRLbhrX36XasBtYNG9Z2Kd2zR2eSFagFZud80eVWUbRIGsFkLXWlmSwx/+vyBjHl9bWheX5Ju75GKxw/WkwWAF7H1WXXU82p6+szYT5aN330JFAQoy2GbfN5N5+/0rQ6p4UeSqBrNTjjZaq9u955yXMP+XoyjOO4rejniebq63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427812; c=relaxed/simple;
	bh=AMR0Er+6OqA7k6z9le3HpGPhOgnIbWFt7ypbCsllyZ4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=mM54SCBNlE59byKaTtuouMV+AuJWYE8GkZSFWdEQjOW+Hi7PysTc4zOBL3aBL8X43xcNqYZn0X/RFMNXOyukIEsX9MTH5MMy5cUP/dznreO1p3lePAXtTlaHkWdAxiDN1oW77yrodMgHHfhWIJUipMON8ZqXeJstPGm36dTS8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=D5T2ckXp; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 7E9D03F9EF
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jan 2025 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1736427802;
	bh=AMR0Er+6OqA7k6z9le3HpGPhOgnIbWFt7ypbCsllyZ4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=D5T2ckXp3yaKCgkaGgO80ENVwSYF+tFO7Ajf9TVKralDtgbT87lkLYOv/I/auhTxz
	 G9iHzrdmBsFOw54pN3Wq7cec7zNyIYHCNjP/w0aderIj4+TwzQ6wdzoiCnN5B8N0Ik
	 JxVZjKcmUC+9MvHKW4Xto8xsmMozQ16f5BJ05AsRBbuxPdtCjvwZ+lN1B/f8hST0Ot
	 bJnhMKrmWfk4gDK+fMOjdTUe6orL+IMRNc1U8WrcUIXzK0wkuXwcK+0+8oJF57xhB8
	 ubriWe6cMghrF5DZlzteHNEcmHiD8zveKQmu4v9T+BbR35S4g15/Fp/lk1CdrDRvys
	 3MVrbTkVSidoQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 688F382DAD
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jan 2025 13:03:22 +0000 (UTC)
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
Subject: [recipe build #3838911] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173642780242.775904.12216657039210833224.launchpad@buildd-manager.lp.internal>
Date: Thu, 09 Jan 2025 13:03:22 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="6394e03793719e8d73f5a60b5439440e693c92f1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ba55752148c5e7326e5dda0b023be9ac104de0a8

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3838911/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-040

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3838911
Your team Linux RDMA is the requester of the build.


