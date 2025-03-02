Return-Path: <linux-rdma+bounces-8230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF19DA4B0FF
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 11:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D843AD748
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A7189BB0;
	Sun,  2 Mar 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="OTEI0qD3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396423F36B
	for <linux-rdma@vger.kernel.org>; Sun,  2 Mar 2025 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740912439; cv=none; b=YGrfVDwXazayZ1hJT9q0rhZGNVv2MrgUMXJ3wpBMybdObZB7fKLOB6djh5PT35pA5G0kXHoy9NTJ+FHWxQzPWhHamMPaFc6nKza0uMcpIfKwGFAxcsZlfjt1i5sGKV9MexdrfaHJdF/kSXFoOsqsAW+0OEu1LYiyjeCs7tF+Qfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740912439; c=relaxed/simple;
	bh=qtXLCQpWSN5okE8xeN1XvepfBO01esbybD6vGQ5/lOQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=fHlZu8u17mwRQiH3Dv9L2T1zngrpPQBUxEHoTv5NgxBN/mhVhICbjPuW9Iwjz3Go2BgS3YYvG+2uUYwkBj1qD4KcVVekfEKrPso7hXXsNqVyZduDHzvcjY82yMBhT67I9hbv34OKikBruGH6URia6697IZBzx+griM6g1FlXnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=OTEI0qD3; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D800D3F802
	for <linux-rdma@vger.kernel.org>; Sun,  2 Mar 2025 10:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1740912428;
	bh=qtXLCQpWSN5okE8xeN1XvepfBO01esbybD6vGQ5/lOQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=OTEI0qD3diOcI7AP9g4WSoLKrIdIgKhsaWRicOXwNfbI8v0gwivYsIao7oasIFLe1
	 dGzneY/izinWlLdu5jhpR0WLCQt3ix04nptniqMyvJSq1oY1VNWmhSgojyiFFb2QoE
	 dFKuKiGOj9Ih6wbSgLnCjLQeQ92JvT9pns8S126dYppREXUyHaWkX6d9k0DhFbIEnO
	 +wJ6Dy9dhq3m+ptbOcDXUZEbgb3hh8sRgnYRRq0BPsELHsgfSb3A7G4RYRNWEt8t//
	 2dTTrBjKeBnx4UAqssGingTEHC8OrCuMNWYWWkGSN4n1dFBP0XMSweeih3JruPfk5/
	 6kTI4ifqoYZJA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id C53DC7EBBD
	for <linux-rdma@vger.kernel.org>; Sun,  2 Mar 2025 10:47:08 +0000 (UTC)
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
Subject: [recipe build #3861653] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174091242878.3550923.13441980079872141798.launchpad@buildd-manager.lp.internal>
Date: Sun, 02 Mar 2025 10:47:08 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aa29ae0fff49e4e804b39147c9f259d2fb023199"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 6d9ae1a48620ff0f296cdc06e622148765ac30dc

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3861653/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-073

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3861653
Your team Linux RDMA is the requester of the build.


