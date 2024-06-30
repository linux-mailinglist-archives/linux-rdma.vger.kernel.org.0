Return-Path: <linux-rdma+bounces-3570-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717B91D17D
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2024 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03711F217F8
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2024 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649874084D;
	Sun, 30 Jun 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="v40J0/ou"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267639863
	for <linux-rdma@vger.kernel.org>; Sun, 30 Jun 2024 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719748042; cv=none; b=d7Upo/q5V/Td1rwWEb3NHgsiIpf4Hm0aXGXdVYLZ7QNgDO+RH29Z9ovbYHBJq/Z8NOps+Ym7GsC0c02M5uLa4p+J1DbUB+uiSmiAJj8GFKjzyERHbc+JE34fk36ivmUE7MrbZExzi5xU1JJu4qpYaTPg1tgVM4oz8pqe1smDk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719748042; c=relaxed/simple;
	bh=otlMRihPbz4pL8wZnCRiq2zra0twm8Oa+B09s2bEN6c=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=jb0rwpcM983L+fXcsD1iIy9baOwB0Bim0UKPS2Vqiu25QLzmYRjKGmz2jwpeYPSS2IqHpha9wSmZn8qu3SWKlbAwDeVmxik7S4x9hUfruJwp/RBZvYtfs4oQDq24/euQT9iLMrxiYGyqQzazuah+NA/WKyB4WkQTIdhlmzMKkIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=v40J0/ou; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 987D03FA2C
	for <linux-rdma@vger.kernel.org>; Sun, 30 Jun 2024 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1719748033;
	bh=otlMRihPbz4pL8wZnCRiq2zra0twm8Oa+B09s2bEN6c=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=v40J0/oud6BnwIuUrN9skhL31wdhGIh+iVPrQHksMTJNzfNxrX8Z79lAep4X0Y1qy
	 3h8+ZfwRcZU8fobKeIc6AAgvYC85j1OC+Xo65wv4bqUpKemfef3CQepczyVg7x+1GZ
	 hGfwTlyTcOfx25QGTEWGOFJ9z/MERExb08bxVy5lb//yhGs2kCsoyB7naSntN6IMGs
	 itjn5EdZhLnUr+MGrindAP6jYetgIFctDtnqitD+DuSP/aXEIBC7MvlWmwzHEL2G39
	 zmQpDF3trN1TgXLUV7fjCkyR9umIfQ2ut9O/tJa3BpxegOIpNVhdQZ3BGNYKlGIGRl
	 GEkGf9hLV4v/w==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 834757E22F
	for <linux-rdma@vger.kernel.org>; Sun, 30 Jun 2024 11:47:13 +0000 (UTC)
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
Subject: [recipe build #3749877] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171974803350.1839645.176699002094138244.launchpad@buildd-manager.lp.internal>
Date: Sun, 30 Jun 2024 11:47:13 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: c921ee08598fdf106f3b81cb882645f94e803817

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3749877/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-049

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3749877
Your team Linux RDMA is the requester of the build.


