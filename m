Return-Path: <linux-rdma+bounces-12459-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC1AB10A3C
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 14:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ACE1CC3AD9
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B52D12EE;
	Thu, 24 Jul 2025 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="bqK/L8xq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AFCFC0A
	for <linux-rdma@vger.kernel.org>; Thu, 24 Jul 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360312; cv=none; b=owI/iObR5P/7El1LFGK+OYo9eMlfBv++T40xLjXyZ9e0+0PDhFnvdSRpCiu3qHT6w19a1QvE9VZAjBExu25kc0vj7+7tGA7K9KpZruJ+t0sTaaGK6GC6qinODKoE9phEiLk0jeiedA9viNbyFMwL21Y77onUmu1QcifTXk8fSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360312; c=relaxed/simple;
	bh=Tyl5ojuIZxfKjwH0N58We83J6dLiT3f7veoAB79vyLE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=YC3FW9i5TmupMhduIvxRrictAdTJwCZnQ5VlfAzivrDGvnXIkJN2VAOyn72hiZFwvy02peVFcvrbLfPHr7TQr+0/3MPmtykjN2lg1nsuzWLoWihYX88AvGBy1o9viQuLXuGvtqnhHGO12O42WjlLmDHYyrvObtvL1rOPhtg1bJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=bqK/L8xq; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id B661D3F0BA
	for <linux-rdma@vger.kernel.org>; Thu, 24 Jul 2025 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1753360307;
	bh=Tyl5ojuIZxfKjwH0N58We83J6dLiT3f7veoAB79vyLE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=bqK/L8xqNkxa2ccsTgc3L2uTkctzUKHcZQa2WH/8Pl663HbXnOL9txGkbp0g+uHPi
	 Tr1MLLt19zIAZxL+zOUc4veH8qPAP/ex5obdw94WsRj0n9PrsZ0I5/jc1hXNg9giVs
	 f44+dX9+dfBxQl6Xo6q5plOCCp6lrCKWyzAF6hOaAmJexhLz8DgCSTGYJAucP4cYHV
	 GN4Mmjc3XFe5A44bk5GCCmUKcd/2M2y1R5XPmwnoBd2M/raHKZelyZ+uppWWn9iNNe
	 cphi8zsbTVm273XbgZBLsOIAAKv2OUw+dhdyW235KE7tnGFlfgMIZ4sV00qpJ1ebGK
	 vly341Ga8pGfQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 9D0D984716
	for <linux-rdma@vger.kernel.org>; Thu, 24 Jul 2025 12:31:47 +0000 (UTC)
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
Subject: [recipe build #3925729] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <175336030763.1714934.7584978798265906187.launchpad@buildd-manager.lp.internal>
Date: Thu, 24 Jul 2025 12:31:47 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bd06841ed8708d847f33096b5527f49720e929a6"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 58b647ad9b9c8eb3c087ad869c11f8c467f11086

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3925729/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-064

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3925729
Your team Linux RDMA is the requester of the build.


