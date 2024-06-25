Return-Path: <linux-rdma+bounces-3481-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0926916F8C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 19:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D121F2292C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE267173325;
	Tue, 25 Jun 2024 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="CUbeCJjX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935D4437A
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337647; cv=none; b=WlggliQlWlz1sLNmjOJnHEIhb2nF2d3mHuD/cFLcR6u48kUz3QXo5m9HodtsdGkgvYR+2yvPEMHFqa89TD0wV8jMSE5CNCdQqYwkcItZ+Lj7YhMlGljA2AQU7iZS0YPKgUC5OXw3XTg0iBvNf4W6mKwBkRbO1RKZAP7+I/Fn9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337647; c=relaxed/simple;
	bh=OFZdvz3GOA3yfB/4jVjTDEz6Xo/j/ITMjmo6ml2hU9A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Z25+MY7qy2vmZXjaNqweVIxlPG8EAIidJj7glPmpOFtNzfvGepmZrl1JlkjvrwB6kD5GvzxPfUS1oqYbr6h5CNjQP5dGwah4wN6h4X/ihFgrD1271pUgHe6asU2Lff1p82lQdntQOGXZKy49jXTddeljslkVZHI73cIHmn6dEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=CUbeCJjX; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id C591340135
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 17:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1719337637;
	bh=OFZdvz3GOA3yfB/4jVjTDEz6Xo/j/ITMjmo6ml2hU9A=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=CUbeCJjXYsXtP5FZZdvwiA2TSZxZ9s1BAmxQ29T/NFDWo4tSvQhbwiaJ63wEaIFF5
	 J8SwfBk6/hOWSW2227BwhCLY4UNzgKyYfX1spBdDbZwtWYRHvbeAXibN+ksF4tLVCA
	 fQHDJG14qHMDnpzzIm4Gus8ceOS+QDAfV6yfHNcU9Vr7AFt5RwI725ZXWdoPpr8BB/
	 43/snfYMSQts5pwQIPQAslNWlm5+DNd4VbKcCSTHb9n6aV7SAvzQE+S3QNTAUaej47
	 FfhPIGusrhacXda1j9UeZRHdfG5tEcQ2UYyP6QeV9TBAtwCmo7QJyVp4qGfZvaI7+c
	 yW8XApOFWagpQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id B7AD27E252
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 17:47:17 +0000 (UTC)
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
Subject: [recipe build #3747720] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171933763774.1839645.14226467328141401651.launchpad@buildd-manager.lp.internal>
Date: Tue, 25 Jun 2024 17:47:17 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 64be5542a17afefc33a2b0b1aa61a7c02ba26e6b

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3747720/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-101

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3747720
Your team Linux RDMA is the requester of the build.


