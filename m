Return-Path: <linux-rdma+bounces-6181-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E6E9E08F7
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 17:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38038281E42
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B10C1D63DA;
	Mon,  2 Dec 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="wPJ9P13O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61662E3EE
	for <linux-rdma@vger.kernel.org>; Mon,  2 Dec 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158051; cv=none; b=DYNXAj46Ecyb1QQ/d68gvS3ZqyEwArLsM1xuNkbpWESwUfPM8ISOHqFWUo2KxlGJMULhMJhX5Pk3I0JoVi9eEW4io9eiuk7tTA+F0wX4FbyXKHyJYcsx9EwKi2u1wpNV6u62nRK0odieF+miFMtC35cEFZj1Vt0m7SyidbOdzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158051; c=relaxed/simple;
	bh=MAL945VeoPpgg1OjdyMjQ1TZBzZ18ZRy0tFJ/Qd9beg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=LG1vSwUKrGLDUIt1GnmXwPrWRThd9LT9LTlJTyPYo1JsITMT7tblMlc10TNHebFSAPJ+s6sUcQDLmJIQ7adzEnWU4iNLWKOVKMX1oI/n6yh3Eavo3cccxJ8s/BOkE9bjtZf1lFeK3Eg8Jyj93oNhadsv+D5/l8+6giNx6uy75ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=wPJ9P13O; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 8CB893F96F
	for <linux-rdma@vger.kernel.org>; Mon,  2 Dec 2024 16:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1733158040;
	bh=MAL945VeoPpgg1OjdyMjQ1TZBzZ18ZRy0tFJ/Qd9beg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=wPJ9P13OG7U+QtSvl9ENxOD4fQC0kZ2gHa7+hjYUBmHD/RetHPUKnoJoj5o5Ha5Aw
	 vIo13S5lBRPjc7YoeHbFkQBKGkxtJVKR4BZPjBoJosry7UB7sGcb+v+igxK4jaD7E4
	 XRm+SUucjzUQCDC/F6EC4Ga5QfGSQgSJMAob0oHx39ZqLy082gu0C/TD7VjO5q5gNM
	 sDHRCsSqxA0jOTumgJtJGWBQMgEWPBUm9kqTlbSL6FThVOILddmyIMJ55ibdA3tjEh
	 tZqBKPrKUAVLM0BsYor9Cha07hhnknMnuax8OhEwLjDlZBAJZ7m9V+PxQzvibP1IJn
	 0DSgwP1ngD2BA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 709827E248
	for <linux-rdma@vger.kernel.org>; Mon,  2 Dec 2024 16:47:20 +0000 (UTC)
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
Subject: [recipe build #3821152] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173315804042.3877677.7810610156519487980.launchpad@buildd-manager.lp.internal>
Date: Mon, 02 Dec 2024 16:47:20 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1519c6efe8e9bd78e6c5ebf2eb5bcb040b95ad32"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 63070da42a8c839b121dc27c4bb466e744d4e3b4

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3821152/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-008

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3821152
Your team Linux RDMA is the requester of the build.


