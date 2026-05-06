Return-Path: <linux-rdma+bounces-20057-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKqBOc38+mnjUwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20057-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 10:33:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 238EA4D7EB0
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 10:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C04533023D5A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 08:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665953E3C42;
	Wed,  6 May 2026 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="l8FRrM9m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C883E121F
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056346; cv=none; b=Vx48Zhp9k9k9/YIs3lIU9Pr7DUGKLlXfFc9DozLk7UHP4D0ZnIpCqn3T7bzsmF83xiHKBHYRR9f/6nNXO2KHDpSQ1PXC/TeESLZgYTI8ZrXOM7SYe4U+aWt9mgKqbOazoU33YrVv83Yhs3zeiEGFi7ImkTD7tGaXi+o273nQuOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056346; c=relaxed/simple;
	bh=1TIi3iv4kPYGZuLsbwzIT5xh5DkMuuf+PxmJrBo7ogQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=jURrBMewSEqfE9sda5PxJ07DrXf8jeXQcmERyekq4ApTGNmidn21SDQaMjU7aTYsLhwa2R8e3KfFcEZHwp0+R1hEfxFReBCd++Oa6WXPqsWcFpGuZ+1oGm9de9w/UKDHmkvO51odc7b2INxbVniU32Zgi/1S9wNLVjIf58JZDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=l8FRrM9m; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 04F233F20F
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1778055823;
	bh=1TIi3iv4kPYGZuLsbwzIT5xh5DkMuuf+PxmJrBo7ogQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=l8FRrM9mfefcyzAAxjvb16JYWZNVmPsPzFiLxffezmxSI5/MDAhbbVsvaDa9BB6ur
	 rtgYhr9SR5nHdNzjLW2JlYi6xeP57pHoLR/59YB10k9yQxA/u7Om6y1jWSBRIeOLET
	 2ADrIHfVHuDyKoqdW+YFKZxC7TNyE3dxASJtQ48WAa6Ty3mtYE6OrsxPD9ML4Dp5Zc
	 tvqoCLQBSH3XvwxiNlOF9Jzl4QaeWzqGNbhCizk9V3lTLyYzGLNJU5nLBqNqKJXKmH
	 bW/n5VLZygtPTEc8yvWAdtGIBDm1DF0aCT49vaPxdcqNseBHAljZjXS8Uax+9fefm4
	 x+3xOgvkgLiOQ==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id D2DBEBD9DB
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 08:23:42 +0000 (UTC)
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
Subject: [recipe build #4036921] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177805582280.3417725.245281353004851872.launchpad@juju-98d295-prod-launchpad-51>
Date: Wed, 06 May 2026 08:23:42 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="91d5f4cbcbec62cc98ca9991c8ad99af4e21f85a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 586bd28c3e732e27c5d57ff138019e31543ac758
X-Rspamd-Queue-Id: 238EA4D7EB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20057-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,launchpad.net:url,launchpad.net:dkim,launchpad.net:replyto];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4036921/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-064

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4036921
Your team Linux RDMA is the requester of the build.


