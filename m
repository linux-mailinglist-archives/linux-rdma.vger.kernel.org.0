Return-Path: <linux-rdma+bounces-8648-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7CAA5F210
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A3119C1705
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 11:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E08F264FBD;
	Thu, 13 Mar 2025 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Wm8Zbya+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0F1EF084
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864349; cv=none; b=ezaGnp5xlmWymjF7QOK8jn3GZXFcSkYjoldgUJ9XPI2O661EekZ78kxKAOUegGOh3yzNp01tzSEIG+5a/FAc0yr5aVoSVmirvPssiolhB+FiO122S0MyIDCbHn3xkdrN8G0xa4iFv1OEhBGpiPwnahUo+iDz3oLLAPGjgooGctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864349; c=relaxed/simple;
	bh=oSaDRTVGzP/ZPdiE9jWYiMxXhKYQKxxhjHXW0uZjiBY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=nz3YuZQPS7+pqZ8tBh+HgoCgjKbHdHRqWiKrHO8isPaUiM13NADEgORJPOpMTZKbQibZkKy2GMPnBYaRPuj2N7O64VsGhX9a65HlqoOxJio0hKDVIQF4+ZJ4vv9Co6X/61Bxup8MDqAowKZY4snkBsM6KalG1vYyJ7XYpGsWLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Wm8Zbya+; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id E13B33F3E7
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 11:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1741863787;
	bh=oSaDRTVGzP/ZPdiE9jWYiMxXhKYQKxxhjHXW0uZjiBY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Wm8Zbya+GPIxG5EfE4265RVRscqBsBeFrrLnM6GNHC7/fNjJ/d6DNm+KInzqBZc9D
	 GWS+FllWCFUr2EzbzwfTT/bCV3Bnn/uIvpkgoMZ+DQzHGNWdLqRSp8rUKDppm/GCPQ
	 n/ABzZA5Rb/yE8zebRdQDYZkkrwrzg45AEXAqJLhF5RVxdmPGlSNgO+KlkF/49MHLc
	 Hg0Y5fTzEDa/jdX9xp5rahyLSclqlBIwtvhrNBkHKHAlV4ghJFll8LoaHjk0G7PAU1
	 lT9GWK4QpWz0qGY82HsMd0EH9hVfccMuaFLy4QzRsN8QN6k19fcu1jQR0p7C+BnUNU
	 Wy1Re5jmH1M5Q==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id D10377E240
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 11:03:07 +0000 (UTC)
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
Subject: [recipe build #3867166] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174186378785.4188075.5013721881844725498.launchpad@buildd-manager.lp.internal>
Date: Thu, 13 Mar 2025 11:03:07 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aa29ae0fff49e4e804b39147c9f259d2fb023199"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: b39d68fc9e6be3e7b9de2ad84456c4d0bad4ac69

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3867166/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-080

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3867166
Your team Linux RDMA is the requester of the build.


