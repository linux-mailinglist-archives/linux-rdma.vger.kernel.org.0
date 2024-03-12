Return-Path: <linux-rdma+bounces-1404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA71C8796C2
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 15:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C161F223ED
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 14:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27D7AE7A;
	Tue, 12 Mar 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="vXCGyR2t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776017B3F6
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254888; cv=none; b=Pnrx3UTMjUrwOawCd+oxenIj+fSTUpzQRmO5zOwg8mtVtgXnB6z0Lujg/EFtSxxZ9HP8L4/9A3fy1SED7XFSD6t/AM7JMiriPOvpnkcB4DxIB4PEuwx8+7u+7g3MSwk20+1ZwjdOfHzsta4sZCAS+eTcOeWGPWiwmWFqqh3dnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254888; c=relaxed/simple;
	bh=fQjBNvOgRgD1rzqBNOntcyFqWnDvyel1trs1SZ5JP2Q=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=YY2Xg4XpuQgKpx8WyxTlyL97BKhqExGdwDj85ppHmSljJUrQkiMWSzCs6kIYINilBtkyamcJstMTI5OVwN3V8NS3MU03tFxjy0NhFEUjfkQAXMp9JT5eNKhv6f7RGAl/0bmexHPXmqmoc742B/EIHS75F6c3jMKQgXHlswtvLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=vXCGyR2t; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id B0ED6421D6
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1710254878;
	bh=fQjBNvOgRgD1rzqBNOntcyFqWnDvyel1trs1SZ5JP2Q=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=vXCGyR2tZyrHBceDPObTY4DpgdeqhkqiLOjpVYyU4XI4iQER+2cDpGcuuohwYLLYI
	 z6bvoGCqX4FRG9ypW9NpmQnbPlIS769NwLH9pKOSFIRMIQUeSk4JZgB+/33S7wQla5
	 vou/JidLViEztZBLvr9g9zGOEQYT+ge2TDLMWpWmUAYutPUHd/aU7tmTyNgIClfNeD
	 6A4dlOhiM5NVzaSL+OEHKnjRDug+OL60tX+Bpt8PRhmQalRijSQvSzlxZ4mbBVcTzL
	 d3Fj1OSbmTMjiuTDbCzBCF8vUY1mRjOqsYlL1VbteozRnNpEOia8OJ2kO2H77YXwH0
	 tEymLEv6+Ehlw==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 90E2D7EBCF
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 14:47:58 +0000 (UTC)
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
Subject: [recipe build #3696091] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171025487857.1939111.4083912658075713726.launchpad@juju-98d295-prod-launchpad-15>
Date: Tue, 12 Mar 2024 14:47:58 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2e4955e3d556e61e2eb54acf7a827d17e9e46822"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 97d235010df2b5c3130462bf7232474b39e8c9ea

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3696091/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-042

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3696091
Your team Linux RDMA is the requester of the build.


