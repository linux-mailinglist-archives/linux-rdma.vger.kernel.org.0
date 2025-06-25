Return-Path: <linux-rdma+bounces-11616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1A2AE766F
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 07:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9943B8BBB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 05:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7921DF252;
	Wed, 25 Jun 2025 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="PkR4icjP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2F182BC
	for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750829838; cv=none; b=FuH3stMpWYDjDDgvtLTTZ/Emhr6KXTsKiq8qJflhJQhpyGGB0O7wWW/rTqY0nb+lPJ4MmMTktewl6vCLyglFKjb/KV0zJXiYRNM+wHoFXz29VcAMxkMhZiVzwApPdJ7jFZKWVlnMRaav+7xdaTeiV0mXGg0abVk5wJkf3oww3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750829838; c=relaxed/simple;
	bh=UsFy+wuhJF6sCsz991zWDP+lwTnqDecURDBX/ufBWoU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=eyjQBfHNwPKDDskLbe7/MwrN+ETJ9DhSdkzLl24qCIvLpvRkgYt20Id72IxyOFOusiVRpmI5SRPKRewQOhYvUUesPwxuEdmxLv1dUEDRLQFhfeX5ICzQvDfgykUAwWG9o21iZieK4fQFi6pN5UTD+PWrRmzjawz3LK0hXsxfOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=PkR4icjP; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id AC6B33F085
	for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 05:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1750829518;
	bh=UsFy+wuhJF6sCsz991zWDP+lwTnqDecURDBX/ufBWoU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=PkR4icjPHPHtEP28yC/W2c+fYUWtBQrod2qFz1ETBhewuXmNf/BTJFkYSOpS3mE+X
	 Vzwu9M2+7lwkZ5Qptej50G9gOxTpG28INRX6UU80Y2tw7COYnXyksfv0U77nh9sxnf
	 MGa+IcaWht0A1YbpfXgU+3gG/VwQ7yRE7aHLT1YUvj48oO/f3eeifDzEOhXdfxIwt7
	 Vjg8PcT4ay9XKUj6D+hisQ7/mZRb9VtiqBjtpYjwGQ8lXzQ1iLdsr+lq3k3Ib8gRCi
	 4FgeiubSge/WoLTlMlUEcNLCZS4VUO9BUAPnK9OR1BY3TBrZF3il4bd8jMqU4hcP+X
	 Sun0XBPHwiuPA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 9D5147E6E5
	for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 05:31:58 +0000 (UTC)
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
Subject: [recipe build #3914063] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175082951862.1739946.12554498543688347910.launchpad@buildd-manager.lp.internal>
Date: Wed, 25 Jun 2025 05:31:58 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="7aa962af79d02042917108fba5eb8636b85ecd02"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f64f2006d6464a59923ca37f77fa9cd44e2444e7

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3914063/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-075

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3914063
Your team Linux RDMA is the requester of the build.


