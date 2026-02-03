Return-Path: <linux-rdma+bounces-16490-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4WKgFChrgmkpUAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16490-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 22:39:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD946DEE57
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 22:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B3F4302BF48
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 21:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78550F50F;
	Tue,  3 Feb 2026 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="lB40vyh6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E0201278
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154788; cv=none; b=bfPSbhjRRYQGvuHDTZfvAmhG2unnL1DSRSICifS4R5WUE0oyyBwz8EwEMXu6iknUzc02JNcnzlvp00lTMmOmtQga9RAcpW2NTmWVg5F3xh2VT6C7O/ACpzvToVYQIVwavAF/VOQE8tj7MTuSeLekdU5Oi8S0AW6DqO8FWVxqVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154788; c=relaxed/simple;
	bh=/pl+FNK6hTIg4hX0gxNWMPaCC2rEB1OyIe6vVuMaPKs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=HPlVY6vkaOuNNKeIOg+WSpLGATmwktyRDpXX0Z4n0glILZwcAjxhHbPuIf2Gpd6k8c1QfHaCMsd3VJcUV+zmcdIF+U3fJCjMoK/Yi/pZpBo1kyrejkx9aATK/3yDHSebyxYGh7UcEYXvswOOyqO18Y1AmrrNRjZ1C+AwLGytq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=lB40vyh6; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 034F73F1DB
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1770154330;
	bh=/pl+FNK6hTIg4hX0gxNWMPaCC2rEB1OyIe6vVuMaPKs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=lB40vyh6zQFBQc6yrsYcM8zjfb1mTTlfhDkiqTdfyELkFKMEwxOfD0m7UtTWtg+D/
	 N5KCpoJCH0FPcTIqYLbF9lFeJ2LwU5JmRQoGJBPYpgdV439Xqxc8W/Jfj4qqO1b9MI
	 z5bv9IJXT1tQ5cIOZeHWnhpV08XrDWtC7qFCdFzccdfhEA4DCOCGQpebb2I/Eg52Tn
	 lOKMjwQmm34ksIAox121yLG/qUxOTWIGCQ53skm9gXCM/9MZe08AFUs5WSybk+R+rJ
	 Qt7mX6067asGa+x1JX3sh7NUfjp6wG5I4fcLF36o/IIdWa3v6F/Dy9hJZq+QLNTZ12
	 iYla5nkCZtWWw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id EAFD07F136
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 21:32:09 +0000 (UTC)
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
Subject: [recipe build #4004880] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177015432995.1615174.16847005850516222011.launchpad@buildd-manager.lp.internal>
Date: Tue, 03 Feb 2026 21:32:09 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4847db153920c8fbc330ac275b92a72279fa07a2"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2a38a75fe1327a6197c66bf122aba62628f547ff
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16490-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,launchpad.net:replyto,launchpad.net:url,launchpad.net:dkim];
	DKIM_TRACE(0.00)[launchpad.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[noreply@launchpad.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: CD946DEE57
X-Rspamd-Action: no action

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4004880/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-032

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4004880
Your team Linux RDMA is the requester of the build.


