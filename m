Return-Path: <linux-rdma+bounces-12856-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D302B2F920
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBAB3A73C2
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09132D3744;
	Thu, 21 Aug 2025 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Ffd3acOq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3C2F6566
	for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780857; cv=none; b=Dci0p538NuoSCmPcs4j/Ukiuzv8pt102HkrAfculeaIcXcFEkHcesmVWMZTLzHnLOVI/DXWZ73BZDHFBK5JQobn8QU7wTnPjP9VsFdqymS3O1Q6I/EtYWFQ5fgM+2kToomWwGbEy4pXE/3dhdSzi8UI5EQ8kJ6dOFQnEcqu+6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780857; c=relaxed/simple;
	bh=XDQtR6gz3bbl9ueXPaS7c+/s6Hyzc47iY2O8/cM5OWU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=T5YKDbkr59JtmI3SPKlJ7FX7VH/05Ru+2KrJwu8mOO4sSWDxiBee/mTTmQFPUxL6nT9yBaPHw3kRkmjegVqgUIpdKtkFqYnb2aJPZBPulPS/ew4x4NNVw2nyQuCzvcRu7s33USxDru62Lshqsx03/MFPjGFpRoEtnBv6DFFuzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Ffd3acOq; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 4C5883FFE5
	for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1755780430;
	bh=XDQtR6gz3bbl9ueXPaS7c+/s6Hyzc47iY2O8/cM5OWU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Ffd3acOqQxSCnpw+BEYCsylSMkVUlfTa8JyReVcXX8mPCAw//uAHtRg8kbQ9kYj/I
	 et5e9ioorOk7nr8v2WL+sbgYzSMD8d7F1wbWfc/K18d/F3AZfpKirX/ALW+nMeR9Bb
	 I1jlBcp1YzvsXfFGFOdxCMNFSDfojEnzpKBHYY1d1Zb4jDaUzy+0pMGGYIxrI/FnOP
	 zN0Ff1/loMlSyYkecgWatHFSO4DtqxCZw0s1o5AgA9dVAdU1Ltpi8ZPOCF8EdyHBVO
	 Kb0SbBwtA9QI8FL1qTKxFCXqVz/vui1uBa+lRX4MZFJDv0Tc2TCAcG9sEu9UQizdr/
	 //hvqKxhCzupw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 326D27E759
	for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 12:47:10 +0000 (UTC)
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
Subject: [recipe build #3937057] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175578043020.369328.1774114170516227260.launchpad@buildd-manager.lp.internal>
Date: Thu, 21 Aug 2025 12:47:10 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="919009172d854f2b8e4e8262db447f12f11d25eb"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2663300c6c86c90614c375f4ccf9a49323375a9e

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3937057/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-042

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3937057
Your team Linux RDMA is the requester of the build.


