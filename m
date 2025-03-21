Return-Path: <linux-rdma+bounces-8889-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D332EA6B63E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 09:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D542C46592A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E81EFF99;
	Fri, 21 Mar 2025 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="HsGv0jpS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACE1EC018
	for <linux-rdma@vger.kernel.org>; Fri, 21 Mar 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546862; cv=none; b=SBEeLkfousSZQkesyaIwMHCKSsDd5vRsJHj84i8pN9iTmHXMXRuLXDgXNyVHTEIbo/Ig6+X8so4PJE6EoLzNnJ4cmTb9M2qeF+TCJMKajApFmJIcSMspAfrJ4rgXhHhwgs7LxuQ3tYeyCG3qShUuyXx66kVLvzb8ZNhAerPSAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546862; c=relaxed/simple;
	bh=btYXTpf6eHPUARTu7P/vn9t35BFqIC7LHaCkBFAsfyQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=sJbmBRyjuy5CPrRzlgRJ+eXjRKvinCvrYyrK1kGIfvLd1Mzj+WbKZ1ByqRC+XBVlblq2l56iUNEhKbf+Xki64TvQk23SaWJ4FK25XlliyhbHC7kpkhUx7n74W51qf/sblOxJERlTAPVjnkxSu4HAvM7gSGE50JZ/MpspDcWB7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=HsGv0jpS; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id B29253F914
	for <linux-rdma@vger.kernel.org>; Fri, 21 Mar 2025 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1742546851;
	bh=btYXTpf6eHPUARTu7P/vn9t35BFqIC7LHaCkBFAsfyQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=HsGv0jpSz77wdqFJJHCSsaFfWjrzN48GqgjaTkdeLXObSaDTvxDxqVPy5MuMozw81
	 5udoB+/xjhbVL3iaxH3zmqGn+XcI7MstGQr0yDZK0IV3JJA2yONj3lwf2Of7bZ42t/
	 ZaiConeZreTXt4LrY/HE12PWoJo++BcOKcAZkA1oS0CuGroV4DsfD36QJhzEqm2vc3
	 dsRjW1RKSq4nktWKW9ualWkL8w5y0M3/QzGEyWhs6m2G/Ogp1LLU5a5U354hOMaCMj
	 ub/8ChafVjccLv3rgQ1/U30s1MojsqaMyluVn6XRG+CeoA/v1Oxkf0SeGl5FUj/Fsv
	 0zAABtWv+XPUw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 9D8FD7E236
	for <linux-rdma@vger.kernel.org>; Fri, 21 Mar 2025 08:47:31 +0000 (UTC)
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
Subject: [recipe build #3871036] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174254685164.4188075.3826743814505704344.launchpad@buildd-manager.lp.internal>
Date: Fri, 21 Mar 2025 08:47:31 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aa29ae0fff49e4e804b39147c9f259d2fb023199"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 9f222b1a2bddb8c6489b2748d1ba36986f87123f

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3871036/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-094

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3871036
Your team Linux RDMA is the requester of the build.


