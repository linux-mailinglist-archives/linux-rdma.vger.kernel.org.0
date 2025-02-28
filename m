Return-Path: <linux-rdma+bounces-8206-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE4A497BD
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F84C1704C0
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549D25CC64;
	Fri, 28 Feb 2025 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="oD4FXJnw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516C25BAA0
	for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739707; cv=none; b=amjKVl2pp5ZcWog640Uzc3p5npttp1lwwBGXke2ov53TXVY2f1Tnxk+T/Qnox1swpW3jjNU/kxnbCoXx9NL5khgWRjh6fnjB8bTIQMKziiFz8/04a+7xBtoK7tvHbVe11V3v/eCIC5Gv/BOitEq1KA5h3CkbFtDYoeHBWqFOsms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739707; c=relaxed/simple;
	bh=kFT/anEqSBkKdN+5pcxeXN91Lhtd16u3jWStzdQhtog=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=nfI51k0cneokmhmorXxK2tQ6i9rIxv53OF9lcsoe+6X4DwvQz5kcrPt2XuHZLA/V/F0Cr3jGD3xpb8mA6BeroU2xcyIRltHtLk0mbfnrWr6ZVVUB1q57LLumQDBxA/UUnNza99l1pCbUBWWHFGl+hEM3FPnW9yTTKofIZMWQwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=oD4FXJnw; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 34B2A3F7F3
	for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2025 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1740739697;
	bh=kFT/anEqSBkKdN+5pcxeXN91Lhtd16u3jWStzdQhtog=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=oD4FXJnwckL0/HPmKBXONY25htq4luNxllJS/VjUHCEspLQZ5i1z9hChHdSRzICjC
	 E3w5K3KormH7541oHwwrrXi3MY+DfNQMqZ55UscaMSLVvKjCWYO/VNkfWNyQl+IAQS
	 24n/PCfsUm4xD1Zqwn4Mn5SpW/AEYvRxFUAE19/LPTlL/7mwWe8TE4kAQNFaOa1+BN
	 mJIkNqFVA/drFTPSQGR/sOfpsMgKOB14XBxKc9GtiQvRCfdJY/yodKt/GPPwrpP2/e
	 wOOpOUf4SkGSipdAzmmNJWCF4mZTM21dfcUFTzvIf9tP8JNY4ItExCN7Ru67q97SLA
	 1fZ3To7GRAY1A==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 2712F7EBBD
	for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2025 10:48:17 +0000 (UTC)
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
Subject: [recipe build #3860660] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174073969715.3550923.15019491552787734038.launchpad@buildd-manager.lp.internal>
Date: Fri, 28 Feb 2025 10:48:17 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aa29ae0fff49e4e804b39147c9f259d2fb023199"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: a880fbde2fe6fc3340b9edda1966932b24a67eee

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3860660/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-073

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3860660
Your team Linux RDMA is the requester of the build.


