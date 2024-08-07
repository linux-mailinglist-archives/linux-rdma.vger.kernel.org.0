Return-Path: <linux-rdma+bounces-4234-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0070894A8BF
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 15:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F5BB22056
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F241E7A58;
	Wed,  7 Aug 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Nd+DB4AG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006EE1E4EF5
	for <linux-rdma@vger.kernel.org>; Wed,  7 Aug 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038028; cv=none; b=phUbL3WLh97x4f7A0RFqxZHOc/bj8Cn/VpxnrntC0qNw7AaKP1XniyspHKgdjc0r7cpxrxL6wAz985hdRg1weO4PSMixWULQoD9fOaG18Z/2bkm5UfRGxTKrKlkD/9fo1wNpCds95Dhlb9iz1dMw3rIhmVcbbkxSRXPyoYdFCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038028; c=relaxed/simple;
	bh=ehdD9VJ5tPsIZLQeoKq/FI1Dopc+cAuTeq8rYVce1VY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=E87sNNijDAhC8VQ2Vu2DkB/Bgx7HTulyZMj8AKuc9LmNsrW2Seszekt+IfX3cUQVL8FQvEvJFRXF+GHcnRn0gX+xn6CfXb1s8tK4DXuIBlJVrIPbKtn33Y8ZMMwcDJlYT6NDIo7rm22LXA0M7gTJzBATTt4o9mF65FKGoqPUJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Nd+DB4AG; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id B9C3240EFE
	for <linux-rdma@vger.kernel.org>; Wed,  7 Aug 2024 13:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1723037587;
	bh=ehdD9VJ5tPsIZLQeoKq/FI1Dopc+cAuTeq8rYVce1VY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Nd+DB4AGSAdRX0Wet/GBBd8oVUVKdkSCqspx9DwwWCZNSMFxpaxr9Vi2U+9v2jZx2
	 Rp5IN6R0peRmifTdkZgjQVQNKbNSpsmtDaZigPFusRKvVjOGCqz6K96bnG6GZx3Wxu
	 cd+GsOs6BmiCGYbRHANjcyonRYUjc34IjzthoKKvTjq7ZLV6b9MS/TOZ8wB8iRxnJs
	 Ma15BrCpQgkDVej5yrkPHa1dSx4W5y3jq+WvaTdR8fMyioEReM6XsKSKCNVFReMUrH
	 3zAOOqyUkdqvzw35MY7hLaQ1ylc1eY6G9ibh22hW1yg7Ea4mqX0D5/pjCuzmY/agi0
	 ebvy0yWDhHmmw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id A0A157F25F
	for <linux-rdma@vger.kernel.org>; Wed,  7 Aug 2024 13:33:07 +0000 (UTC)
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
Subject: [recipe build #3768686] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172303758765.1635373.18131468865507741879.launchpad@buildd-manager.lp.internal>
Date: Wed, 07 Aug 2024 13:33:07 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e3ace39cea497a5ecb83e8fb6dd8e7e169f02939"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 8f96e34c1b7538495f5bcdee2df943068b889d8c

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3768686/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-041

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3768686
Your team Linux RDMA is the requester of the build.


