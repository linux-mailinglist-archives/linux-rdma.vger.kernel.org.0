Return-Path: <linux-rdma+bounces-5046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9076497EA80
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C155A1C2149A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4569197A97;
	Mon, 23 Sep 2024 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="EHuHXgA5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22B19645C
	for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2024 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089940; cv=none; b=Xk6TEqHLTCfQ5yv5/aou+/tX3eiH+Bmz+ehRe05dxWUezIib2Sqi4gDV7KoXM0GTPTF5h8Rlnzk/rHtHT9EA8zxQjVoxz9vov04mtcWmt2xZCnDrwVSxhWPMsq0OWcng7MouuPlH2ZzT5RlWXDWaOkyWWnw0u5QJdBOJ1SwrJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089940; c=relaxed/simple;
	bh=IYd+7ujFTGX0ZU1ho/HsNJRlhTGp1QaeTczLpNH9Zvc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=sEzfwozAAGm/SMggCPbGnA6k/ibH9ZNDhtIfqJZSeXQTntc8KnQhK2Ed+ioEwZ/DlKsf5F0vc+V01cXPjoLhbD9JIT/+zsM50JDGgv53p3VY5Rtox4fzDnFpgx9KgS13PIzC/1yApgkYqvOmjOAHiRwBKc/OPTpWMsP7BW2nGBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=EHuHXgA5; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 4E0EB3F218
	for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2024 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1727089355;
	bh=IYd+7ujFTGX0ZU1ho/HsNJRlhTGp1QaeTczLpNH9Zvc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=EHuHXgA5lDWlFMudaOdI0ND57tJ/8M8HMzhz/NBDyfrr3l1kde8m0H1RxRC+5NSRQ
	 hVEBWJwFd2PSztNeKM7WfOpZny6KXrTiJkurzLu2WBSbAqyFAGjMpdhjDajARpdqKE
	 hXu070BlK6+hwzNyQJ/POCy80Y5PchIZYOuc/8OSjHthxXzKVlDUVlyCVB0U5lhL+d
	 bZK87KB2zOpL3oErVXD1p7ZhmXC8pnBbWiFlthWJaR5yr9frJ47cO0Db79I92dKPiX
	 5Ovfj81hJcZi/LHihuJhzhuC/y5rViWg5JDCAL3GkOuJr2rtWBWvf6FF7QNcaEovv0
	 /nXnssbsYw5mA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 3BAED7E243
	for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2024 11:02:35 +0000 (UTC)
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
Subject: [recipe build #3790297] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172708935524.1181881.10779739093075352292.launchpad@buildd-manager.lp.internal>
Date: Mon, 23 Sep 2024 11:02:35 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: e808594991987630988ceb701f10030d9933c768

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3790297/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-030

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3790297
Your team Linux RDMA is the requester of the build.


