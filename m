Return-Path: <linux-rdma+bounces-5318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19349955E3
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 19:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C894C1C25112
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9920ADDB;
	Tue,  8 Oct 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="hkl6sfD9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7852071F4
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409352; cv=none; b=OObYZc+X2wSs2eJCQ9p71sz0EDu8EDohDcbBUfYDJHf9eeoa0Qj7qsm3hH3KiryzLBSRxn/K36EcWC8bUzcm8YAU717gZ5PhjPidvpf9S0/tUZ4GO0UMu6mey3EdhAqMVYbEgs2kOJiB3HS+16dYeTPerfxXvO9vafJELwKJ1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409352; c=relaxed/simple;
	bh=msyxyku8KzzbrPkqPHYHuiMBZOCti8LPtlkbzpTt5Ls=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=Bv7uTvEIOSGgAGI/7ifoINKQaLwOHy8j4K0j9hbR+OsG9RnSk/J+Opwnmg1ISARpie499XB8QiJh6MTl39IjYsr+KVaS5IX74zVadL/R6lCk5RogRAkP3L06UtcbeARD6rx+yyp5Aclvaw270JBCZtd9ZwX0UoCuwJbxG/g5MB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=hkl6sfD9; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id B00153F77D
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1728408770;
	bh=msyxyku8KzzbrPkqPHYHuiMBZOCti8LPtlkbzpTt5Ls=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=hkl6sfD9qXXivjIIQGdL9KnknCvocg+s5NNn9uSstHLvX5NJZMFqfAPEwVU/qUGDn
	 709UDn4h4sKpwk1ZgeXwpNRKqQiBBzWuFGibIL5uGqTbthSVSupkBeWBRpEUWPKsjf
	 VuhLukrPz/oWOvd6zNKjtzIJWzxEOj2q4j1KVAzg19UjThtyjKYwdjeshr0xYgPlHl
	 2itjAJT1ZnZ7mO2jlXWps+SZsQRPL1lgW0TE+v6d90Tyt+viseLQxDKgvbnUkbcdhx
	 YyxDr9kw1O87bySm+6nngxDv5NOQMb9xUYXGywTquNHs4vZI3tOHvnbQd8svR3+2lx
	 NZZaFLO/1kdlA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 87ECA7E257
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 17:32:50 +0000 (UTC)
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
Subject: [recipe build #3797910] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172840877050.2320347.7690941332906241971.launchpad@buildd-manager.lp.internal>
Date: Tue, 08 Oct 2024 17:32:50 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="6341c735b243a0768c3cb66edf85737937cab327"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 36870f2c73bf9d904318c0841fc8ac2a2a2cfa18

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3797910/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-054

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3797910
Your team Linux RDMA is the requester of the build.


