Return-Path: <linux-rdma+bounces-15326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8918CF8B6B
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 15:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE6EC3042916
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798172DEA78;
	Tue,  6 Jan 2026 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="MLvtF0lD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0429992B
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767708736; cv=none; b=aLSHC63ZUJrJAXT4auMeSSDTt3tzy65yfggN5V0Ms8anGf31PbhpCnRgx8CfgioTLPxXBvEhQb35zRcsgVmhTOgrMI/HXd+UfxxKsYF6n9f+vqaXWOyUActvhBzYgD/bvHWLaYPEo355Bn8N/xxmE/8hyx+lkKEm8zGLEUsLEuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767708736; c=relaxed/simple;
	bh=YAXr6f1Y3LAoTbnUT94stSUdDD4y+SCQAFBG0j78w9E=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=mFHfh4W6h5dl1nT8dsMwLbY3/+s6TTBfV8s7+g/YLlhWEP08xixRzO8GlHran+dwGOuIAS2o9NFCzbHF4cZSh20bBcLZxoFfsRuEmTEO4l7R4p8rrd8+qSo8Tgg62t+QmatHxJh3161/MQC2YTO8MDFxM6lzBWf56fSZFQazjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=MLvtF0lD; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id A3EED3F178
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1767708248;
	bh=YAXr6f1Y3LAoTbnUT94stSUdDD4y+SCQAFBG0j78w9E=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=MLvtF0lD+KbdScZpZjuVT+II4uFnHt1ebFiBtQyzGZLfteq2yRqARElfIZxPV9Tj7
	 8pF4CStyn9FzhpJg/UP00Z9tG4Cba/11it4pJypArQmh+m6ux/VA3Djy6GrSCocsjA
	 5UtPwPl0KXEhs/rgOGLu/tD192r0NuJbU+blhzCStpva6mCiqPiHeyedIxNXiv6+Ri
	 Sglh9+wWCrKckPcr5zf2S/7Hp2zxH4YbFtOZY8d0/NZfnVdE/JV4c7wFaQ7MWuZ9NG
	 k9pzDEtcKVcvzwMoOlJc+PwdalpI37RotYhfq45otLDBrW8pDV4B+rwq2OalXDPrgO
	 EofE1yyrMo+Jw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 6EB987E780
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 14:04:08 +0000 (UTC)
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
Subject: [recipe build #3994601] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176770824841.1103073.6448124532289649136.launchpad@buildd-manager.lp.internal>
Date: Tue, 06 Jan 2026 14:04:08 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 73da21c5e84241a603329f3532aea7e0084ee945

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3994601/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-046

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3994601
Your team Linux RDMA is the requester of the build.


