Return-Path: <linux-rdma+bounces-4726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F55969F82
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA882B22B02
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78BE848E;
	Tue,  3 Sep 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="a0fX5gkp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82A4A15
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371726; cv=none; b=mu9fQ8GyBJ53TjXAEygWzLEHsWnkr24eNFj3KBEbSQMDhk3f8ZDYZe6w7lanYjDuUOghwjhIGfWbWrZ/+mFcd4PcHOuyUSEsWY3sejThiHSOPVeCw9BPNqE26zRkU5SOt3RsGRs8pNlN1kh6N3qhZd6RZwGMy7QcbAVVGXNjsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371726; c=relaxed/simple;
	bh=GrlwmGBqsxT4xTtnGNKO21noBJHyUJfvwuw3xHqpG9I=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Sz0vSW2yk98FwcHNQTPPeBM0ooxLpgJSORtqAkpptuJ5E+D4utYXcQtC7hVudDwwp5wmKeSIpT6CBd4pt4d3i0aDR1GCWioR+fx4t8xzMqeyQtRiMNKJqUBpn5UQZsLQdk6MiPq8zzZodxU3T1PSchOt3sS0QMLOP7+eqKAkbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=a0fX5gkp; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id E41C93F85E
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1725371323;
	bh=GrlwmGBqsxT4xTtnGNKO21noBJHyUJfvwuw3xHqpG9I=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=a0fX5gkpBXXPjanTAAUwsCI/+RnNgxY9s9mYu2yUP5mbbVlfvle0MsJ0DCV+lQx5h
	 Pp1YPlEodbC8WAoJu31ETYk/k/d9XSNVRU02wZdK81O50vgpIfKVbLLra0YiTsfG4R
	 F6BPt8nKmmH6P6+pihAadZ4pPPft7Junixh2jkXD/ADyrtB3zGBgSexoo4/JGK6YY8
	 TxQiUGp+G5AnmLUgF4+6CCAUIfMcl8v3Jd4Zf+7OsJ/M69WjDMTYADfL07cAwLvaJD
	 EFjz9Z1taraxVVqs6JwUCOPssk9nl0xarPD6vZFGLpHN0KJqFZzaS551SQexvllzNH
	 tr7pw93l6PXjA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id B9BBB7E24C
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 13:48:43 +0000 (UTC)
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
Subject: [recipe build #3781355] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172537132371.1779024.10628569680662959568.launchpad@buildd-manager.lp.internal>
Date: Tue, 03 Sep 2024 13:48:43 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 7e242b88caa475e917f63e0e97b45410d36856dd

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3781355/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-032

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3781355
Your team Linux RDMA is the requester of the build.


