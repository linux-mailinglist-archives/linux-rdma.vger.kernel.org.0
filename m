Return-Path: <linux-rdma+bounces-14780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE6C886D6
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 08:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7184354691
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF35285073;
	Wed, 26 Nov 2025 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="bGCzOTJv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C428727E
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142350; cv=none; b=mHX7NBYN+RnWSpBsj0EYY4uIw30wEOFBEMjGSL0LkaZceD23eR9CPB44CsDVhkZx1t4rjdhVz9FqFzWBjXS8RBfZotGM56YgK8KgJ79uDiPdip3lWm6X2Tk0LlKcYUQMFwg9hC9vhCrH7PYOi5rKBVLr4RXD2qTGcnYwoKYzndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142350; c=relaxed/simple;
	bh=SWaPAh5Yl6vPqBMg11hB8mp0rJMBTW+TDz/DBTDc3Bo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=K+z4ctXYrCaHELDsbqEF0cYs0k3DhNCgM12SJJ7CVF8VpvWUwiaYikG/hv8aDrJbZf/NfVRg0Y/PqvijNg58O9Aalm4Ic9C6EgfpOJurZPPx/0B6eVU2aTXpTQcmFKAHqmlKhZLCCgPhnj8+WtMG0QBBhWA5JXQxcTxFQufDYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=bGCzOTJv; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 7537D44F12
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1764142340;
	bh=SWaPAh5Yl6vPqBMg11hB8mp0rJMBTW+TDz/DBTDc3Bo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=bGCzOTJv6/4KOt5sCKj3DJxzp7OKZQzWEYMMHxDjC0+XOQl6wgzODSSAPekYsYOlN
	 yvPXcNLU+iBXXLqh+8FisGhuupYTp9IFXPRCFQ9b2jZNoeXmFnCfV8uRpvA7cCRIQA
	 yK5hZv2TNHhghMAF0lQ0QlJ0kkCkgqFTg0W4/zo0dMVnJ8V47Ha67CqCtWGw3Btfxx
	 iVvgL3aZzvJCMALfYiw30HrajSLujYNgO3r8VmT6FesvVBW1vI2adqq8kFEgSl1bAZ
	 UQ5zTOZzf34QHXuG8Yjq9q3bqbTXpSjisT2SM+ec6/uGYMX1+d79sFPPQ8wSDkeU8r
	 MD5F9qWVSHNkg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 5962F7E7AD
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 07:32:20 +0000 (UTC)
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
Subject: [recipe build #3976909] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176414234034.791410.10818673859249643640.launchpad@buildd-manager.lp.internal>
Date: Wed, 26 Nov 2025 07:32:20 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 3900fc12cd752ec71b0270ff828feb7fcff35c5c

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3976909/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-065

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3976909
Your team Linux RDMA is the requester of the build.


