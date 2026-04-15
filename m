Return-Path: <linux-rdma+bounces-19375-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHCrAzF332kATgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19375-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 13:32:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEAE403D0F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 13:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81FB230087E7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E3333B974;
	Wed, 15 Apr 2026 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="k9TEEA7U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4741754
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252718; cv=none; b=RhUPlK3ddcYoqHW6UHcbAZdI9gdRO0LhWevJXlN81Zn8QRx+9FsgVrl4zyOvqyLpkMLj/sDVPP217A1kUjbg6uL/l8598KMiVPpGAkZE05oybkZQKPHryia0MEzhfZcbzOUhs73t3XEuywdbEM+5GUTvT93R09pn5geb7BE/KeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252718; c=relaxed/simple;
	bh=fF47Cp84OwmVkojNTvAza9KfhzAguQ7qcU1hVajL4b8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=p2tXrQs/hkRKRq8ZSkuMwHb3WGAVFCqGrb5YAC9ZJ/cKN3Lf2OG/ZDm2DNDRiAcsT4lUnX0xJ5k1DsmimdBf+bt9dJPTTI//vP9iyfnsPoDIXCAg9TwiQFo2PIKxTX1RLAXLymFvt+PJMeZYfXI9gg/m6xLZjUTmEGZHUIYBs70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=k9TEEA7U; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id C83B13F040
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 11:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1776252282;
	bh=fF47Cp84OwmVkojNTvAza9KfhzAguQ7qcU1hVajL4b8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=k9TEEA7UlWrz5WKdOTTuigWIUon/LndYcv3tEl0CIsEBiJbKkqrVEWdRRr2yQsP36
	 kwT5kmLsJVH2h7uoLRJZrnPmL105TS0N8b5NMycbBMtq768ukhVj3pTWscO30/0lpD
	 pqnAxfX/70nsRmADwUVl9R0k/wrUKXs72Cmw5yafpQhtkNQv2EM6GjCSMnar0CmpEY
	 oEJfWPC6DDAS0RAStFcIkToNKdcVmYkIAqjtrP46QWiB69BL2H6I+5uZ3bJrXYs3xo
	 p3e0+/YjXwsvkWhbGyKB3j/OA4ASKmhDKI+aKLK9nw32B3cHmKPERixh4lgvB/slKD
	 aukqYqEIwQBSA==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id A1D28C10DF
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 11:24:42 +0000 (UTC)
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
Subject: [recipe build #4030553] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177625228261.3282238.14319066216217133664.launchpad@juju-98d295-prod-launchpad-51>
Date: Wed, 15 Apr 2026 11:24:42 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="866d07beecca8ac2e3326342adf6c1740cd3e7b3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2f7e25521159d078d570ca2f0a2d2fed967338a3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-19375-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[launchpad.net:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[noreply@launchpad.net];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 9BEAE403D0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 9 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4030553/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-076

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4030553
Your team Linux RDMA is the requester of the build.


