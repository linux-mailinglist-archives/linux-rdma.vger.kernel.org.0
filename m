Return-Path: <linux-rdma+bounces-754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CC583C2B9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 13:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970471C2255D
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 12:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB37048CC4;
	Thu, 25 Jan 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="UN8an8F/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00FF482CD
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186816; cv=none; b=DR1iIx9vXewAPBelZEHRhHS70F92A/fObsDLyFEDQomWbNLSllbdCapgKkaRxlY9LH8oAn2ZxWSD07JE8f+LF3ga19JHUrVyPu0UtIZD2QxJu8ivsXHl39l1hTmWNiSOLniUCiiMsyWe3uariLQylEJH5ue6JeVZrNbbmr4jAFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186816; c=relaxed/simple;
	bh=h6EzDWpDyTUNW99fr2wMUjlbLGjwW/z8Pyi+09GMfag=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=S8kAJ9RnyCFQxXNB2vBwDOcBlkGqHh1SRJepBNY3w+CqA+AyOE7/3PWHm5eJ2K4BxRRAjJE1zq5lZCwZSS1k89m1ekwyCU8hZhFj8sq6cEjPc417Is9QxrLMny5mvyiYfoj5KhUoj7th8Vl1YpB54sUZ8drqMeQWuKVHFW+DnDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=UN8an8F/; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 3DEEB41AEA
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1706186806;
	bh=h6EzDWpDyTUNW99fr2wMUjlbLGjwW/z8Pyi+09GMfag=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=UN8an8F/v6wEH4CL9WFotvd+g33zrgNtDSr/dX+fpB5Xw17JorDJmpuiCkwqMGGxZ
	 /Fi2X7MKYFDLS/yiqWo42heUk4h9H3p++K+N9WSNa05ShfTkqwGR7kqLcBWM+Z9N9y
	 CQl4dtbdvhhZXKpcmYwaAiOR+yv1TgZVYqA0fGjIQsThLDTIjeATneOvgnaH0noDCN
	 fpm+3nZq68fOzqazzYY+dD8aQKJoxXQQDLFUnk/4W5Ww3vKZbfEzAmzgrIUrEN5ib+
	 3MJsjHYeVyVxMf6QMs8zkAsUR/jdlDSIuYL1OBfzlktco/irBQm3pZZomjfviCQEx2
	 elxyICA+SXMKQ==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 2B3687E5CA
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 12:46:46 +0000 (UTC)
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
Subject: [recipe build #3672277] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170618680613.485762.8178680260042760037.launchpad@juju-98d295-prod-launchpad-15>
Date: Thu, 25 Jan 2024 12:46:46 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="666c6bd52ccc7c38c7d6806b807b117caa7d8b6e"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 51602a1d5e6f174031e2ab3d0aad3bc16ed2f3c0

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3672277/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-038

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3672277
Your team Linux RDMA is the requester of the build.


