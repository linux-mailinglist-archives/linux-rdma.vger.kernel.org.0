Return-Path: <linux-rdma+bounces-5746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD9D9BB78E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1BE1C22084
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9D13C9DE;
	Mon,  4 Nov 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Hsz3oziw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648412AD0C
	for <linux-rdma@vger.kernel.org>; Mon,  4 Nov 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730139; cv=none; b=CFSR9ZGONeknWfvAVFw/tZopp//9IFya1bGNVYqG0f5f/FAGaN37PZQ9NHDthJzVULyuNgXGPsUojJ1o+F+rJgqtJz2VPYNLzuvxPJ1/ckR7BtPdeDplHzmoge2x2zuCaF+Em96a9mhNRL+aFp5G8OLSNRy5Q3wU//f4LD+HiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730139; c=relaxed/simple;
	bh=sQrsuO25qQ2IVRW3C+Yct4pPhGOO9f3lJd4KWsmI+eU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=ATiqWYRmfC4ZdqPJE5SdB1HjKR9snHcBmkj9Ihc3+PUg5unLtjYAjJVAv7a9MeVwAL9KiD0zxYtgWdcNyEVzaYsqwlJsrfYuoHgm1KzC91+6CUIkFcqAzvzuLqHWRA3rg4CulZvToy6s6RUw+dqPsWcyvm7GsVmIHi9GbXaYtwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Hsz3oziw; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 30E3140688
	for <linux-rdma@vger.kernel.org>; Mon,  4 Nov 2024 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1730729638;
	bh=sQrsuO25qQ2IVRW3C+Yct4pPhGOO9f3lJd4KWsmI+eU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Hsz3oziwXusxIdsHQIP9Pf2x7YsG317+rYg1u6WwbA4vxnSyusjUB0/jCwVO4qKe5
	 0naTMxijmQLb7XP2Js9xKzs58G7MlMYpMYZ2fAb0yo6JXXuRr6QMiVCABG9VXL+WIa
	 NTjHZh0VC/LiG9lGXXg3eF1M1UE9XWion5edzg36J1WhAnkH1P8EB+vNXEjLa5hHWg
	 TDoLd5xVNPYWXNhcIYeb7vua879q0rgU7VFvYuM3AgGltBB96yQPRgJM/Sa0u518yw
	 kJ9ddcWvVUkjWiSj9gqm2zKR5KcUUDAzP/1nA1Masfw3Ha+3udrqs5hzRNnL7ioDBW
	 CqWMATWdBjExA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 27960848FD
	for <linux-rdma@vger.kernel.org>; Mon,  4 Nov 2024 14:13:58 +0000 (UTC)
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
Subject: [recipe build #3809148] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173072963815.2172763.2093635359537122313.launchpad@buildd-manager.lp.internal>
Date: Mon, 04 Nov 2024 14:13:58 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="22ade00ab50b929fac63b8ee7252243aceda294a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: aab2f85ce66e6b0706542d537673ae2e33d24db3

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3809148/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-011

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3809148
Your team Linux RDMA is the requester of the build.


