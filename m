Return-Path: <linux-rdma+bounces-3550-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C28191AE66
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 19:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224551F2990E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4036198852;
	Thu, 27 Jun 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="CeP5Y58D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7D4C9A
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510448; cv=none; b=GGqsYZbtgkX6eXtbIDW9TRTV+zNG7Lt6/0OTSF7wUA23M4m2/D8h6+H5bfQn35cW4uo2IvrQp6gAkYYiU4LSJBb+2M+C01ZTJGFv1VsJdKsPPnFrfybVh/4bsn3nEoG19xJX2CYBSPQSHh7kQda01eLVRcsafqsg3zy5Q0djB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510448; c=relaxed/simple;
	bh=1DZPmR/IeUYjk/1moJezDnKQie6QdOO4iXXfMNFZiyI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=h0DdqwvtYWwGSurw/8BIY93kMZIEp9ZvMycHUBElBd015mfzFNAgzrho/cVYYyfGyUTH+zRHss2QX72EidS+km7nRf9nAgfyZ/vvzBvGgrNwTufJgKAHNDuZJ7vjQP89LF7eUQXOl2NcV/guptNuNk8yv0OLFHX5A8YfCkjwIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=CeP5Y58D; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 731D73F58C
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1719510439;
	bh=1DZPmR/IeUYjk/1moJezDnKQie6QdOO4iXXfMNFZiyI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=CeP5Y58DBuLIdA66zv8T7TBbT5mFzangwUpA8ufnpLAPrp31Fz04cJ+SUE4Z0AzTX
	 4o5HLXDjzvipCC+BoaXhpE54YRk8sA8zrByQEsMZNUgajsWyRY/vZEzkcFCI13HqBK
	 Cf0vQm/7gQZhKMlhan092UoCi44rMnQcTDYb9pqWeQzJavsKda0Readr1qaWZun2Qp
	 njzhrDAS7n3/XvcK7ODTg7C+mMWGLieikDUbD+SOVdjtCEfj0QxhNj9Wp7Asr18MqF
	 zfNiLzwpvWpBjYLAgKTHrM+u24CMj7tpmkwhVN/aIb2UUjvtR7OiSgIigb4+EL7luP
	 ugaoF9jghd2DQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 58F3A7E22F
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 17:47:19 +0000 (UTC)
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
Subject: [recipe build #3748464] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171951043933.1839645.1736297249143265104.launchpad@buildd-manager.lp.internal>
Date: Thu, 27 Jun 2024 17:47:19 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 7ec87bccbe244d040653f76246535d3e851f5346

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3748464/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-033

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3748464
Your team Linux RDMA is the requester of the build.


