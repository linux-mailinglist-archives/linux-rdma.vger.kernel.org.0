Return-Path: <linux-rdma+bounces-21925-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mZJ0Loa0JWrzKgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21925-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:12:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F398D65135B
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:12:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=launchpad.net header.s=20210803 header.b=DFPuzFrE;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21925-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21925-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=launchpad.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C9663009532
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF672D6E5C;
	Sun,  7 Jun 2026 18:12:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160082BE057
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jun 2026 18:12:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855939; cv=none; b=jSw5EHBfXyT5qgGz0jHFarn3JubZu0rYxY7eIHyph6hDn5a53VbkkYeXj6t5VsQdtKjwtkDeAOwPz2Sl6solef8585eiJ85VTafYIyLdpn7aBXl9iNT/PoRRJFL23mOYFeFrDJBD4BS07USA5CaC0rsCRyRdKfV/X9iQF3Qg4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855939; c=relaxed/simple;
	bh=/LZe8Bi29kUkz7VQN3MW2ZKvLXmC0ZkMpAoOmKU8NH0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=bPacL4KmYSCALthJbgQSrOLWq591FtG0bnUocxWSGq2Lyp1hpQhvlWiiYii1pC+LnRUCHKYW+IALP9t1EBFwSH7Jrw9hjVVhmtQRWKR+dUMdYTGoR0c+q888uN2PgfBJR90bHKcbHZUENg26Qw/QzdTMBwItl2UEjKkh+hTIc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=DFPuzFrE; arc=none smtp.client-ip=185.125.188.250
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6FDD33F142
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jun 2026 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1780855390;
	bh=/LZe8Bi29kUkz7VQN3MW2ZKvLXmC0ZkMpAoOmKU8NH0=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=DFPuzFrEmZ0PbliDxH03j3ygPVT4jcx/TEpLQlb0HJAkMo+HYggVAWOOP4msXt1Wc
	 wenWCv+Z24+11WGlgWRuYLqN/SkMxfSPdTTr3T2hrTZ9oc8f6WPi9OXTfvbGMVXNyd
	 YPWOpzjJzOrD/9efNZrcqPxt8TBOr9rldBjo/XxOYc1+RDoSMrtdcj2JvS+kY8Lx6a
	 f5j00boTZdu+6gwaSGjBeolVRs8zRL+A5IwdaIVIocD8wQ5pG/ILwCKrhj3zy/iHYt
	 WEMySw2Sa4NLLAxEnjwm9DyckO9corjL09/5P0DDu35F8u3onkAqaPD/Fbj5/lG+92
	 PwzIlKL0ZN30g==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id 50EF3C2614
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jun 2026 18:03:10 +0000 (UTC)
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
Subject: [recipe build #4049277] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <178085539028.3806946.1044377097226568756.launchpad@juju-98d295-prod-launchpad-51>
Date: Sun, 07 Jun 2026 18:03:10 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="f85a4e13f5f1af0eb2d5aadecdf089bdd7783432"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: a6dd06a8ab0333d220e57311d1dd6ef9d981af32
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21925-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juju-98d295-prod-launchpad-51:mid];
	FORGED_SENDER(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[launchpad.net:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[noreply@launchpad.net];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F398D65135B

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4049277/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-008

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4049277
Your team Linux RDMA is the requester of the build.


