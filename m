Return-Path: <linux-rdma+bounces-14093-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ECFC13391
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 08:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA001A654AD
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F95D19E96D;
	Tue, 28 Oct 2025 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="bj1qBTYL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860DB17BA6
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634848; cv=none; b=Iw+f6UFH3XhjkOyOD7iMi6A//6LuKmhohyDb9V9LQcQ6RsU1aYf4I8Hg0KZdyQO+tTHXY/8VZSpT7YBruBlo0ZqfSHLk+HfJ1uY8GhRThyiODucAWGijcTMi60pDzCBkIoeQKJcFH3NiVA9G5yGLLFlpLIL620ANgQLpytHmGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634848; c=relaxed/simple;
	bh=xnznBsXgDv8AAC/sF+uiI4F56CFjH0JFHcRwD/IRYV4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=RZiFpiAdVsxvCO6lMvKYj61PGSFyKooVdKZsfEqaInxGuZFpmKj0Mak/9z4tm/thoikfaF93yoUMICksLeGXqkuL5EBQnoyew67aVdaJTBn2ZEG4ACqJ8t23tZCN3HoV8v/gOetxSAr/Nd2wJbHLpeUWGT9OtJrPUjp/3gMYN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=bj1qBTYL; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id D38B53F1A0
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 07:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1761634837;
	bh=xnznBsXgDv8AAC/sF+uiI4F56CFjH0JFHcRwD/IRYV4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=bj1qBTYLPxCkjmkNM7HUhV4Qf9gYv92kxYRuKSNCaRSIxsY/nkpI7ZL5J3+5akNqr
	 yI4k/bNovBBYc1HftCfa415nrfBd4OH8ltJuot8UC6zqpNgTOjPfS/8Hd5jAtC2gMs
	 roA9Hgn7cwEtPP45SlLwbkJnSaHMcU2Oh/WgIRG6VlH+VaaSWFXM+e7OhfiTmmvcha
	 FjdbCYesNLWUyDqK3RG7eyYypurr4zBnb021MTsFiXwEjIjFXYaJHO/MifKlK0itY+
	 ZptB4R3VGog/4bZxegBQG2w09g1cwNMzhxlMMfJKBWAWEopxspyD3qbF/Or+SUxLc4
	 l0DzKvSTX/Lmg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id C589F7E878
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 07:00:37 +0000 (UTC)
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
Subject: [recipe build #3963816] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176163483780.155868.9086354398145623087.launchpad@buildd-manager.lp.internal>
Date: Tue, 28 Oct 2025 07:00:37 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 7e74490ff721aba86ddca0881503f1f212ac7d34

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3963816/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-075

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3963816
Your team Linux RDMA is the requester of the build.


