Return-Path: <linux-rdma+bounces-15344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E055CCFE2DB
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 15:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC10830574D1
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EEE32C925;
	Wed,  7 Jan 2026 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="NM9HQBvS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F744315D23
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794751; cv=none; b=WfhQy6SKwIDP739KQwe9UB0gQUY4cnoXWjIPB6YE0WzTP5JYBBlIJKvTdXwK7FvsP28X8eWnn4oF9Ztd21D7RYJbVadu36mL35GgjWe3aQm4pDkswf4It7QDC2mvVP8rvcRidNgwJmsFdE8WmeRV+6h1z5Xmyzm5bSw9pJMvTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794751; c=relaxed/simple;
	bh=h0TjtQkfBDdSGpxFGZ5WgqM8qbVf4S6Vt2kI9L8ogl0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=d4z35137l4HL766NmgXZ3CwdXHuhX+pADheSSNlndwsGm70JUmqwRQYdUbS/pzny4r5qKCk7TPu2C/lf6PnuYNBfjbZBh2k9HQeiB6o+cBt4DBS+cnqqK/wWEWb+uTUbd3FtBxqLghjWWjbObmiCrI3gLorg8DrfB4HjWiA769Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=NM9HQBvS; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 70A29430CE
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1767794742;
	bh=h0TjtQkfBDdSGpxFGZ5WgqM8qbVf4S6Vt2kI9L8ogl0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=NM9HQBvStIVI0dMd5f00WJtOFdV5QM247kA+j1+tAFgd+00QWINj4e9w12RLBc4+K
	 BuHCMyv2J2yuTezJjL3SLdgvDAVNf3qblbarxNI3DoFrFn7Itqk6admfLPycNehngO
	 uO1uvZ9i9LC8ifhjSNp9AFb+Dgka+fPIlJWkiACWOTpfviZ2KVpXa/eCLF4nS9HgZy
	 MQWsEpiIciCEGh4FPqqtu1cKsLM4mtD/dqj+e6I3AbAJFGwfukeuSW3bJJGxCs2A8k
	 8ZkKBlHWPHEXkfMxDgZfqgMKTxSqlVpg6bbrF/STUe+D7CYxEHHptnUfiU0vvOkitg
	 OL2I17BndKvqQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 55B5C7E7E1
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 14:05:42 +0000 (UTC)
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
Subject: [recipe build #3995175] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176779474232.1103073.10447618047308620906.launchpad@buildd-manager.lp.internal>
Date: Wed, 07 Jan 2026 14:05:42 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 8c648ea3c08b68389653f12bb9e6e75dca39918c

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3995175/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-021

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3995175
Your team Linux RDMA is the requester of the build.


