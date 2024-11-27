Return-Path: <linux-rdma+bounces-6123-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DF19DA5A4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 11:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BBEB21FCF
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 10:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B269195FD1;
	Wed, 27 Nov 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="fFxHBVSa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975D191F99
	for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702962; cv=none; b=sAbD9EgD4DiTTAZdZ9s4Byb+S5jwI+Vz24DDKULkKMGWai0GEOIyks0j7WX2fUyA4a2k7GBKD3Kuybl5L5mFQny17tfmyFHRTEjB5RqK5/DxKMpw7yPWysjLbzwbZs1QjFsmzOjmacYiF7nJU0VLTWxvyvqmch077Ivf9TEajN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702962; c=relaxed/simple;
	bh=2cJM4ipDLg5cwBWhoVF0NbA4tnCmigs37EOwByLVgUw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=al0bLu65uG2Pji1saKBEVsGMcbERP+L6rLvk9o7CSnWE/ZRy09lDQClLRICF/1oxbV6YpaykOoDVp/zvVB+QzWJZtbpvAQpdS5Ab5onncsL1D2g3TgKm+qWycBvbfnQEZFjmCFEuJNVjHnHl4cFRp5eoPnSSANt+6J3a2WOWRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=fFxHBVSa; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 67D013F34B
	for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2024 10:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1732702396;
	bh=2cJM4ipDLg5cwBWhoVF0NbA4tnCmigs37EOwByLVgUw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=fFxHBVSafbwXixkOZEsAqZ2M/UJTsaBd/158QeNMlcUo+nOvR86FP556C7w9GBVJH
	 +iwOAuinHelB0FDvilb5Iu00Tl/jn8yeHotxXgOmW9lbZDSEMOEw9+JK0pKizJ3JsP
	 1Uqhbdaay1AhvrD9atW7DQ4OuxlMJN/Isi0yZzsJkne+jaSdecHsFAq/EhmxZR8z9I
	 UpRIA9UrMqhmFNUh3QQSuVNop3iVe4yO1PeaTq7SqYEvVoYXV0zgk7DPIO8zsYo2uI
	 qceSHzAXZpt7hSgumt3OEDW/s1b4aboSY8A/e0rYom3GZMv2W9j4BdzbxWllLhFIfS
	 /3d7OVoIMZIUw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 49EF18491A
	for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2024 10:13:16 +0000 (UTC)
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
Subject: [recipe build #3818915] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173270239627.2106356.2665348778326224450.launchpad@buildd-manager.lp.internal>
Date: Wed, 27 Nov 2024 10:13:16 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="22ade00ab50b929fac63b8ee7252243aceda294a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 977573979044c3efac2678397559d21eb70fa1de

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 11 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3818915/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-017

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3818915
Your team Linux RDMA is the requester of the build.


