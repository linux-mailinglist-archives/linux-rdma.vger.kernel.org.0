Return-Path: <linux-rdma+bounces-8440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE1CA55A20
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9872F1898C37
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 22:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEED20408A;
	Thu,  6 Mar 2025 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="NJT7ZWKN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071A1FC0E3
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301275; cv=none; b=miI0RUQYV0L21D1yM4gCfN2Hi13MRcK469MAmVJAg3tj03GuBmgNCkdtW9FKubdqVXmuyW84dJszKultM2aokVej+NMrB1f/0AvQXf9AZB5HHGUeePmkRDRz4xCyyfIYqOoVJYXORQigPSRxn5dSFOohShqKoyg6JpfaVY89VBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301275; c=relaxed/simple;
	bh=CKmwinvN5uos2qbiZLYRA+mFBJ7Xwnv19+0tgT9g6hY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=IK915W/e7qIHo40n40Sgv0CsivU8aJ0Y0bqHOQueozTW8IET+Aq10zX1w6Uh9pKz9QJwgJjqHO/B+opGXPTfXqS0DRlZBvd0nc5Hd48r2c4qAIZRoYJ0uxUuuaQ+3uDKBJbjQIu1EFRAevitHl/stb1nwVOw+KVxUtrDVp3Ka4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=NJT7ZWKN; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 42B5C40819
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1741301265;
	bh=CKmwinvN5uos2qbiZLYRA+mFBJ7Xwnv19+0tgT9g6hY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=NJT7ZWKNwoNchTxndNm6sftfnnv4ySA0QYoqEABUCUEDudLaSJBrXtAFOe4oCRZso
	 xZ/DsbzXDBRrid4wWLjmMGx2pi+xGIPkQw86YDwxgo+OfQfSdyUeycxhLd1Nxl6K+q
	 xfK81CjbZxNQBjbNzKXqgp0HkjtM7FQ60wqVZONmXWop2cIUoS0vHA9bGJ4ivo0dux
	 MrlvXOSbO3kuCtm/gOBw8jEAaOKLxFRcbeaYxKrtptvjz8hef1Ik8GdDee06KAwpDL
	 uqZXjzlIoCtMhvJ2s7XwiMysrxcGuZmFJ3j0MjkN2elsgr9cAWvZ1odYjR3tgP4O/4
	 nD8X4uNd6T4IQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 2C4677E240
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 22:47:45 +0000 (UTC)
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
Subject: [recipe build #3863800] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174130126517.4188075.10382032676157456145.launchpad@buildd-manager.lp.internal>
Date: Thu, 06 Mar 2025 22:47:45 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aa29ae0fff49e4e804b39147c9f259d2fb023199"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d9c6d172af87576cea702d18ea04ea4b70ef0b6a

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3863800/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-100

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3863800
Your team Linux RDMA is the requester of the build.


