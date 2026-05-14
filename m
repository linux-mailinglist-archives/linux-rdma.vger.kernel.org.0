Return-Path: <linux-rdma+bounces-20734-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPaAGWUxBmrhfwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20734-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 22:32:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8EC546BFD
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 22:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6D9230167CA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 20:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EAA35B64C;
	Thu, 14 May 2026 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Wr8+JEki"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E33C0A15
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778790746; cv=none; b=PQ07DtzxlTtB08ofoMYlA++43f2rXJISuImw+bXyo2WZeCal6HYlaWzfnZw9JLu47JFC1fqxwOe4hxWcumX4TDY1pGFfj55Hwjrpvs0yfEJk3pWZlNVLBpIMGa2HaDD6ePyXkFaDQQVzR5329/20TS/cZSBs92Jhmj2KXU5zSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778790746; c=relaxed/simple;
	bh=l07ahBZA20y61eRgx6U2OsM9PLpcZdAlsQFZ9MM7eZs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=J678XadzKsfchPL2nn7kqxS09/GEEMbOe7Tt4efYon1ti6GXWejKKWBufHs4nsd3Kk6BocDqFSxKm260+J4zlgm0ikcf9+nN5563d+z0V+vm1PM9epKXdZ1qgnHdo5gvtqIPo0j1bZV5BcdJzXmOoYUWwUBHlswS3yi4oHGc5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Wr8+JEki; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 789A549001
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1778790736;
	bh=l07ahBZA20y61eRgx6U2OsM9PLpcZdAlsQFZ9MM7eZs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Wr8+JEkiKVDWhillKIUlxYVhgoaLO/SF3DiKQDqmjtSK0lCVWywUiYr5Ic10IaZOK
	 TP1j/qCPCxrSoSTDIMEUuhf2DCu0Btx6kgbWpM4z06+m2l6qPme0IY70MYt481XPN8
	 aUVyBdWT1gCXelprF6kCoC89dT6BGmeVRVuTm0qi8kbTClfBx5Vit76VfPuPDDrM/l
	 REamAm3hy6y0vRNlOvn2PFJWrbtNTn0IVLrtuVLYiqFC+p2R3ddTyJRu9KHABpk6GH
	 vWxyFBiTafqgmsyaiEOSEpe6docqMYRtGRpek3bpkY99rd+lKq7jNYAQMMSCFIOK/W
	 ZbceFiJR75obg==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id 6A642BD3E2
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 20:32:16 +0000 (UTC)
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
Subject: [recipe build #4039958] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177879073640.3147202.797713126718785083.launchpad@juju-98d295-prod-launchpad-51>
Date: Thu, 14 May 2026 20:32:16 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="21e17fefcf122f18da93c143f29f40ba940e464c"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f39de006578c2fec97aabcbeb3699731639a907c
X-Rspamd-Queue-Id: 6B8EC546BFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20734-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,launchpad.net:dkim,launchpad.net:url,launchpad.net:replyto];
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
X-Rspamd-Action: no action

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4039958/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-078

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4039958
Your team Linux RDMA is the requester of the build.


