Return-Path: <linux-rdma+bounces-7795-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E3A38A29
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 17:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925B87A37B4
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC6E22652F;
	Mon, 17 Feb 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="KQDU0eY8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826EF226530
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811428; cv=none; b=foV2pDIg+mDZKd5lYxQ02X4E2O8X6WNoa3hiiDhqyVYlLDmsMM0vobOpA5ehatC/2DbNdQDf0viEL0TCLuBK4lrH6JHT5eWijdrvsZiAW9u++eocbocqf/2ctfNybe7kbTdhj+Xhc0dieC1+E1YtRoxrNcv4OaxSvkjByz7doEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811428; c=relaxed/simple;
	bh=a2tlnSIuXmTP3hD51Pj+1owNmXhGviGtl3M8EU84sGQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=V2BDvVXKFUAyR0BVsMY73jUlurq1nKMuBk9BSVaZ7pCx6ynQ5P/B7CAbkRAN9/N0Ity5sG7gmzkr6GUBLVE0tTEXqEAqzO3zYsFnZ2wghl7e3FI9sl/4kf1YvChAUD5eisnAMZfYXta6Yc4wWqwkJH0ydSS4VRescSsWk/cZ+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=KQDU0eY8; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 05CF73F0DD
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1739810835;
	bh=a2tlnSIuXmTP3hD51Pj+1owNmXhGviGtl3M8EU84sGQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=KQDU0eY8934evRNRL9p0fj+YyA7WUxPv167Wm570vFR44m1NCfBiqeqtwW1LwsMxH
	 LQKzieKgy8w6wq5epOWyJiQMsZthmwrb59cAWvCBoqMkZTFr546XfEZFjL5PbGm7AH
	 +BIUVUCQ8wlMZswHHwEW/eySOJvtHEE0lqGvM0NCP6mCMCK85Y0p+0Kr4X2Qh0rbjl
	 DgJcmZUAK+f7bdzbLL2OzEtog54aKsk3A2Bw50SPEe174OSSnbu/iZB4NJFjRVkRbb
	 Qpq6SC0RNvIA4u8YLc8pjRO1nWruravnK+Lt9bYyIJyD4aDaG6F6WmB3enGgm9OFUz
	 +vrIh7sUHDhIQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id EBFFE7E24A
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 16:47:14 +0000 (UTC)
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
Subject: [recipe build #3855101] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173981083496.964601.17262959864397328954.launchpad@buildd-manager.lp.internal>
Date: Mon, 17 Feb 2025 16:47:14 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="78860d903de6d6d7dd5a0ade63efaca45d3467e2"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 03cea97eb275f9082074873aa8a2b3cc975a6eae

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3855101/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-044

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3855101
Your team Linux RDMA is the requester of the build.


