Return-Path: <linux-rdma+bounces-712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D418398C8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 19:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B15294E6F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BD186AC8;
	Tue, 23 Jan 2024 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="SfpEJQ+f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA286122
	for <linux-rdma@vger.kernel.org>; Tue, 23 Jan 2024 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035706; cv=none; b=ftol6R79YzSP0Y16/VmucGXlqt5r1gEdx7WBaV5ZplWlBpBR1IvBhLLMbJhbKL+vFHnzneG6MMNM+BEQz6gulFuZ396iF2MnOQJaZCC27HRfXHRbjlXIqju4IwYe6AOk2jPND7/npsDdqCy6D7SscbzPKHKmq9h6mBSlcVxJrq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035706; c=relaxed/simple;
	bh=tBi/fz61lc/K/F0Ofov6sAJrJCdjFsERYvIkR4r2WZM=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=BCMqaCg+fxRx46sw6FDhmE7K6FUME8tC7T0HEqnIpis3p5AxLC/csY7IDUVqsfSBrugqs2c1LRilrMJGw5Ax273ncobdUNa6+oEYWxbgiUsiWzJR1KuFglDr1oh5PSp0zaZb/NsEn1X/niYHNIbznpk/L9GucE6ytFg+opxwTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=SfpEJQ+f; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D3E263F0D6
	for <linux-rdma@vger.kernel.org>; Tue, 23 Jan 2024 18:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1706035695;
	bh=tBi/fz61lc/K/F0Ofov6sAJrJCdjFsERYvIkR4r2WZM=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=SfpEJQ+frFnm4nvIb7kpFfjSWAgLNVqIijyRFhcsSWPVzsTn82sf8wpGg/fRYjZOT
	 XRePqzgqJA6tE3DKnOkFxolzwGOEj4Eqktn5N7zAqjAz3tuXVXZrvw9SWH6F3X9wat
	 bNaZaBj9V2KC7VwUTYeLGgSlxTL2SGyenKwWNRrjLcMp0Q42JoBkzK9MKHeWUFySdw
	 HhO+rAMiknX9mw68J1gF3pXKfheHI3GDOgarCT52Du6nq2sLitbWRtOF5oXDheEdGN
	 k7qlkWRqiF2sIllYhbsJWW42WuIULqUc49SxyGBvnEguUII63EZFa/ZxffxiliH7O4
	 2VUDupdK93Ydg==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id C22EC7E232
	for <linux-rdma@vger.kernel.org>; Tue, 23 Jan 2024 18:48:15 +0000 (UTC)
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
Subject: [recipe build #3671077] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170603569578.3774464.9921846788588195372.launchpad@juju-98d295-prod-launchpad-15>
Date: Tue, 23 Jan 2024 18:48:15 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="ff54b7050d99a0d84ff58e179f1b8e071713b594"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 08b4611497e088c4f6ca739b3c0859b3b58c3ba1

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3671077/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-092

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3671077
Your team Linux RDMA is the requester of the build.


