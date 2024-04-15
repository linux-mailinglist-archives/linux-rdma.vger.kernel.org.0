Return-Path: <linux-rdma+bounces-1946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08068A5DC6
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 00:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207E51C21326
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Apr 2024 22:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429C982D93;
	Mon, 15 Apr 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="nTUD5yI2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508D2E852
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713220758; cv=none; b=KLioGdlAjYBM5UHP/ZCkdCIUmg1u4FMSfVlt55R+wDEQrkCDEOsd34a03U58SejDlbH4sN/JveNeRKz3y6BW5dxYjnchalcjw1AITTR+7OkRXzt/Pfs8Gzox8NDCz5do8SjJpcYH+K1sMU8yfvo4OAg/iIQUUF/tJNJtpNCjbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713220758; c=relaxed/simple;
	bh=BRubRHn+bdBwk7hCnQWkyWL0lSsAI7e1QjvTouDvqj4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=C9JlgjoJ9aD0Nkp0gOTpxOE9RF5/hK8e9m2BgnzM5U9pau9ovqr4UJsY8qlpeG8SulqnwO0beIsAV0pVXmTDr82jAWayOicNm8pIiX1XhIkUhzplKuYmQXSxngl+PWrGWqBlMCch9JNSNVWq8bDQrDLr87unmYHTGKFclEfuBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=nTUD5yI2; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 40B623F806
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 22:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1713220372;
	bh=BRubRHn+bdBwk7hCnQWkyWL0lSsAI7e1QjvTouDvqj4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=nTUD5yI2LsONXjAJjbNUBoP2ch4jSja0wk0cpQR35+q4jzZS8FfNPqEr3wMyxdwq6
	 8Qr2k4I4jhm6A+lsEfQKR4gGHfiefO+KITAlq4L2gAHo25/Q8CfeFazrzFndet9VZi
	 emQ21wSE4vyJmWBDLyIMJ07k+790VOwdR1hD3gQcqu7b4WmWdUJYHS+gfEi6/c2GzC
	 g9co0g1NLO69UMjAgRZsX9V60ZAvfoy4MBpYIxnCKZ0b7ma+GLHJuEmvYIdwkzcFxq
	 eRbRf+76Up7WJEEbKf1J8RTHmFnj/w8u02yQxbD9oFSIdDCSFdjkIF5V9tLjaKo+cT
	 eCPtreSF96CkQ==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 2B1917E243
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 22:32:51 +0000 (UTC)
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
Subject: [recipe build #3712747] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171322037114.3971088.895989769744293623.launchpad@juju-98d295-prod-launchpad-15>
Date: Mon, 15 Apr 2024 22:32:51 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="67d34a19aaa1df7be4dd8bf498cbc5bbd785067b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 74b9cb0cd0ba5b9704cdb99d1cf3e55152284fe8

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3712747/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-032

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3712747
Your team Linux RDMA is the requester of the build.


