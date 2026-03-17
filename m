Return-Path: <linux-rdma+bounces-18244-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEsgKMIyuWnsuQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18244-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:53:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 207472A84CE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8CE13038A7F
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227F366DBE;
	Tue, 17 Mar 2026 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="OTQpeYGw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA883630B6
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744565; cv=none; b=ewx7NjJ0Ql3aZQs+LbHUvlb7gi972RXlp6RKSfoydaNlj60ZKHddSa7EsgcTb6MjPu7zjAijOA0fYWS75Dth0CxLF5IVrsa+6W39WbdhSaEPcDByAxN3YJ5cuIC0MeHO6n5pLxYQca85ePg/NQudvJf+TLb6AY60jRUXMVN4IHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744565; c=relaxed/simple;
	bh=89VoP63xON/ofF3qOuN5erN/pRdMO5bLyu1SoiYJxV0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=K4UBsEK4wGWLPJsUlkhFbBgp+5TzBbYg+UVk4+Hr3XSQT9jj509ykm+PEkor+0P9fKs83rchopOymHjOfs/h7qyYl3QFI4WnTDIwlVcjgSqPYVAPXcyakExykEFfjh1mz/QS+IxQ5048En0ppHIVghG0zsMH/ti/+SP+U2/Sy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=OTQpeYGw; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 523983F171
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1773744561;
	bh=89VoP63xON/ofF3qOuN5erN/pRdMO5bLyu1SoiYJxV0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=OTQpeYGw0r1dpmTyXvHLC0j7XVyICDZloiXiIsKSAJhs43zHELesOCnqlXjlwxRsi
	 uTFU6ApEXSIcWitoWV67ZLR461yWzV1gfXGnoU+JvXw0c1HIOKclD5bFEhtc2WXon2
	 RypKVHllrO8JZP3EIZzoM7FI8mnFWAMQmCGGeX42ekjZAqtVtIxnGpVYlbF7x1Qy9y
	 xvWrAZOs4bqrcc469BV1WxnrLLZsSyEbvjejDtIT3PjuzLaERw3zdFdBR3KMQLEaLx
	 D4t8wojj2JweG63Di56ZovDQxH3i78K+eDJ4xjpfRwF1sg6sOPWF+UyrOADagCF/8q
	 9pfItQQFOfnhg==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id 2F7E8BD9D0
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 10:49:21 +0000 (UTC)
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
Subject: [recipe build #4019508] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177374456112.31593.3810356362858157077.launchpad@juju-98d295-prod-launchpad-51>
Date: Tue, 17 Mar 2026 10:49:21 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="30ebb7e51b1d452d1afd137b32cca7f23d23d307"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f877f9d2a2ab1f7fa819adea86ccdbc1dc7cef3c
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-18244-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,launchpad.net:dkim,launchpad.net:replyto,launchpad.net:url];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[launchpad.net:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[noreply@launchpad.net];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 207472A84CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4019508/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-001

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4019508
Your team Linux RDMA is the requester of the build.


