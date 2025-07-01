Return-Path: <linux-rdma+bounces-11798-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F4AEF822
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2EA1889778
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567991EA7FF;
	Tue,  1 Jul 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="r0lr+H7d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293028F1
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372267; cv=none; b=R2/YqX0NX5ThRcJfo/vF0nKzzHIqpFkiq3ACtJMBfgSkidbuadZMtKlLKs69weuA3paNOg9/wiEkPFGUPEyzpmXSNXAlfo/SEcJQtnlxZtaT6r3GSJhWXtk6HrLFjgKR1TmJ/3cmPqtPBCfq9aBWVEBuUbrPuKIUXxQONvyq+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372267; c=relaxed/simple;
	bh=5k6MEzkQDRZQzzwCCA/jasmQtiV2aaxbApLFCB+hN/o=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=poUyhc1NOWqGT0tA//XJf7wrO7b8t+abQIRETJu41phFSf9d4pGKHcqJQl7yh3o0+xqV8n+uxLH32n3/0s7lHzxSRVw8TSZXErCPkEw4MTfilesTOdU7CeHFd8whAG1jjv9x1YZIfJO3adfypdFKW+NmPM1E2hoU0GkLzMFeubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=r0lr+H7d; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id C7F523F864
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1751372256;
	bh=5k6MEzkQDRZQzzwCCA/jasmQtiV2aaxbApLFCB+hN/o=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=r0lr+H7dWik4wi/xxvZt8FIhZQXOMcIEt//E7O/RFEI5dwt23KejD+lSzE0UiKac9
	 XHi/PsTglKiOp5eXl3fYvxL70k8Rl5y0aaAr6OtlVLLY/OS73o2+vJ6Ghk2z92GZxU
	 UhCQGphww6bUUBsCzA9Hw/G0uX9SHlaVbGYC/hnEgmpVMNCiateJc4LKA5cwrItMed
	 VIqauaQlPVG+2r14j2gh+R7bT9faFNoIzogzxTWiPVYz3RfAkd8KuHtFWbTGIo2Mby
	 1K1FsoOM0nsnG6Ovk7vHZY3/YppTiRLBnBMBFVtM69PSfX4qqa2p7aV9iRzW0Uv12A
	 x3iJpCaovYxfg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id B8B507E6F8
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 12:17:36 +0000 (UTC)
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
Subject: [recipe build #3916650] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175137225672.3196303.16549721654531658193.launchpad@buildd-manager.lp.internal>
Date: Tue, 01 Jul 2025 12:17:36 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="b5a18a1fb2c651898dbb3172b738994271938569"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: cc1b6c67e4df44e4b1a255c52a7624398ee1770b

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3916650/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-115

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3916650
Your team Linux RDMA is the requester of the build.


