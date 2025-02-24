Return-Path: <linux-rdma+bounces-8045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C522EA4286B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 17:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD43F3AF953
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50E263C73;
	Mon, 24 Feb 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="TFJM+6cc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B041917F1
	for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416051; cv=none; b=VALZXpq4peNsur6ApdDjJQbHOst2qdp1nmEw48mZ1v1pRci7F+VO4dNw3Nb/RHhEWpKLsTtaiZ1qNNrcDJqbVQKXDNQvY/m1uCXsF8ZQJNQZWNqS6IMuyyr5lwcnbxPWr6gE/ulnjs9W0McfYRLrMYKxmbKlS4M935n39/EXZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416051; c=relaxed/simple;
	bh=jziQ7Xw4+4L6I+Xu9BCu8ezIJZDuVqrKD+VJG3Jj5qs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=fEcHIGAVw4saYRQ0UlE2bZCO5iytIeNVlEaQSOQeugY93ADPD98kfuLTpPLxQu29l6LlT4ayp1uUvpd1/2xBx0QW+BMoNbzJ4mjsK2BRQtFX+rDt0MJ4vg95X8q/++yHRB5UEuJW+WDMWkFYF3umq0Dc/Ag4hDi3SrOLXRM2EaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=TFJM+6cc; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id B475343725
	for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 16:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1740415598;
	bh=jziQ7Xw4+4L6I+Xu9BCu8ezIJZDuVqrKD+VJG3Jj5qs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=TFJM+6cc80eYpnS77vHoLJW9N1LpiMUy1/LFFrQ0DrJCq9S/geaMYQ8Ljxor3jjEj
	 YjTbQpsDF9gRL9CIxXyNMFOWistwSHIGVstHGrfaU7PLgoFCLkLo3u0lL9EbZ0XJCo
	 KrmB3R/buk3TNbdSoY5nusvfmgnQB55j0eehZirDN+04ggTKMSHIyk0mwwTg6JEitQ
	 wDuPBEK/qgy4XdrNmZ6+6HX6BYmqJC1pg49wA7S4wefEp7qx13af72UyU9/8sptOGN
	 a+ZA9Az5Nsd1vs9Dlx4TPrTvo2JKKo1s+UjcbFnp8Xc690nkiCF3CR/dsc8a9kHWat
	 gr/+qyLMZXXOA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id AAF327E259
	for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 16:46:38 +0000 (UTC)
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
Subject: [recipe build #3858863] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174041559869.3550923.2516672767562734745.launchpad@buildd-manager.lp.internal>
Date: Mon, 24 Feb 2025 16:46:38 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aa29ae0fff49e4e804b39147c9f259d2fb023199"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 697c8cd8b4f918d569fc9f539c2edce1c2d0e92c

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3858863/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-088

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3858863
Your team Linux RDMA is the requester of the build.


