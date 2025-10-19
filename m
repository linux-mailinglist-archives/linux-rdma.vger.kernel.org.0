Return-Path: <linux-rdma+bounces-13940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D054EBEEBCC
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 21:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8535F400AFB
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 19:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92F7224AEF;
	Sun, 19 Oct 2025 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="ZIwE8kD1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99244156661
	for <linux-rdma@vger.kernel.org>; Sun, 19 Oct 2025 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760901859; cv=none; b=fhUkVhn1JYjCNayC0iTsQdDHifY1iseikwo3g5VewanuwxoGA9RRSiXsrMX2jQVOw7a8OWefVi4k/fg9zjVOV868ByIQ72Db5TmPImsp9TUIgBn+EtzLCvf9WGriy//md7RijEDC4BKlzsfjISKtbHCOHSSGOxAM2vL6WAbn68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760901859; c=relaxed/simple;
	bh=XxVmcW5eKnJyvVahObL8bEAEe04+li0naCzMzKHlFHg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=fbdDB65mPv/H/Q2RsdUANGM3SINKaDKIY8poSZvramRmAx7idheXBGDlhzpr0ZfWSL0sZ2vNULdCyg3XQLQSIEulpH2cDn43c4MeQo2ZDAccErDLq5WWw1JMv96JrETySWLP/9pYw3gJsCNI1WQYEvzchwJoMTqzlmXUe2WgPU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=ZIwE8kD1; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6348640163
	for <linux-rdma@vger.kernel.org>; Sun, 19 Oct 2025 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1760901418;
	bh=XxVmcW5eKnJyvVahObL8bEAEe04+li0naCzMzKHlFHg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=ZIwE8kD1wzHh8cCW5BRwTXhiiC1QAg+LTFQk5KCxvVuKc0d0qA5xyhls4IWJUpoQE
	 35FUVF3M+Yit2X7jW6zw8X02Iy+CA4bnVu+gfcimVHMbkY0J11SCAxeANxUNKXry4t
	 hNxCb2NZ9EqiLeDk2W0YXcdX28tA4dL1wgwPusOqIXJdqsRZuldu3EO59Jn4LwuKzn
	 dB0fk6cd1kPlXjxU0lCV2YbNRG6QzR1UfKYQSSufFJtg1nBeJkZmhfj++jY171Zqc/
	 zqPZm8hFZdu86bP3KdnWZXnNYWXmipIwEVjNDoTxBv7lPY8RnfmsIGIyJlRlcWQeGt
	 3irZDAifQTFLA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 4C2B87E79F
	for <linux-rdma@vger.kernel.org>; Sun, 19 Oct 2025 19:16:58 +0000 (UTC)
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
Subject: [recipe build #3960179] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176090141828.218743.4733861503861539383.launchpad@buildd-manager.lp.internal>
Date: Sun, 19 Oct 2025 19:16:58 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="304f53b38e34baf532daa616a9e3cb2ee8d98eb2"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 50bf78e6385496aecacaec1ed1fc36990be6ce35

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3960179/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-115

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3960179
Your team Linux RDMA is the requester of the build.


