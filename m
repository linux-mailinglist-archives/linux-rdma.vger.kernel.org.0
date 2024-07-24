Return-Path: <linux-rdma+bounces-3941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1401293ACFC
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 09:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C4A283C87
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980054670;
	Wed, 24 Jul 2024 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="mwZ/VqpX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC834C84
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804965; cv=none; b=HduwoJU/7rsRR169OI5q9embTJp3gUVrf0nKCRmKyOdqGJnt67RkcCXu88O34O465uIYqdq4QmlsvtSwB78MoWV7WeLMjsLy57+mhvviAABNiN3GGtA8zYYov9njj3HjmumzX5JcL50ulFncVG3fqKnjHscNaThdw8peAN5goOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804965; c=relaxed/simple;
	bh=BVnCx11pkv7T2JLitTh+9htPfTeTkF6P3/JO3vb384o=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=PrCqImvC0WIEEXb8h3wWJrAGu5j2m3Yqgxbfe+paizwXIAIGB2L/TSGbxdNNNQxWYkcx5xaZ/nH1UTEsclw5BHXv21X6jDFm5OnTzmvdlak3A+RB7oyZNLyBH7MREHgQRznDcZGo4EfQQ89TlViYgeA6aOzlpWESDEaBlkrnfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=mwZ/VqpX; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id EF59E422B9
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 07:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1721804593;
	bh=BVnCx11pkv7T2JLitTh+9htPfTeTkF6P3/JO3vb384o=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=mwZ/VqpX7rpJCTdUiDVs3J6MQEpcdfACBUZKmD1moxnGhxmsihNAjQykPl+bxFceM
	 Vven9rblF+eNS7hQ8tiQLY2P0qB1XxBudQJBY0RpdhRaOLp7NOmeUiixAXeh3ZijNs
	 dWro6LEuSztT8JJ0ujRRFO7jJMQp9xEy0yr6EdQJINbdPhDGgrrwXHDla07TawRomN
	 xFqqw9OVPegqaZ4POCXhJRQSzNcY6j4KvVIERXnDD7AXWwZ+r6oLkvS89qX0N6Ls7H
	 afeYH3gReSubeYM+bP/b5w6w0e3hA5JQERM7qJ7/drmmYq4DGpGQaK6wQxqxgA2FXV
	 TrsiKAFJXkA1w==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id D49A37E24B
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 07:03:12 +0000 (UTC)
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
Subject: [recipe build #3760652] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172180459286.1591207.1971092224057747530.launchpad@buildd-manager.lp.internal>
Date: Wed, 24 Jul 2024 07:03:12 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 117ac9b079989ccbafbe97bfc0fc6674303fe7b9

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3760652/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-039

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3760652
Your team Linux RDMA is the requester of the build.


