Return-Path: <linux-rdma+bounces-17128-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL/wELfRnWn4SAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17128-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 17:28:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 780EF189CD2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB4B305A6F2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0EF3A7834;
	Tue, 24 Feb 2026 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="RnDAMSEJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D2D1799F
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950318; cv=none; b=Rka0y06b2fx6E/zAjgLnGuMVc31OHun2mntoQ0HGXFrtbMGszngdfU5xxWT4TABxkJM/KwT+H9tQ6fVu6lGXpwJCbKwhomOO4SHFrzMbNjZyGfgblWcEjj+1f4+pJvGwoVBsFajW25JG2IXTjnWy0AsU8MVDOshxxcczFW1KHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950318; c=relaxed/simple;
	bh=Z8DIiQD/1+KxEDySD273KbAhrV8+VtKe1xgmUnA52ww=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=OHmnZUM2pdHCi+SAHkcdn02kW/2Lvndi6JvsbaECo4g0Yi0EGLZ9uHcmcY/9NBD5e0LZ8y0e69AeXLLWOr+aHPF8d+6G6q0tYMzvk6zC8g904PTkmhMu2NiuGx7tGfIamG0HzhwbXHLW//0PWV90ZH6HkjL+xVoYLcoTlVig7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=RnDAMSEJ; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6C43D3F7DC
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1771949890;
	bh=Z8DIiQD/1+KxEDySD273KbAhrV8+VtKe1xgmUnA52ww=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=RnDAMSEJd9xcV8T7XyMlIXSNTinL0jExBs0vkDdxGNu6a3jGLrLeNqeJvIAIbGw/w
	 kZ43Yf5QCtU1p/ypNiW5b49nxNKn0qeIQvRcl7uREtHlFfIEoxVuEgWDH4Xi17zE7B
	 mqAt/cJPTIx5Ctza1lBW/IqyDGalZ3f2NQKVH+9M1Vz5m4VuKwciDsLvrpyGTr7C1P
	 NrZByOUxNzrNlfLe2LOFyW8EaHzBpMHTMRQVW7ya5WfUr0xvzlinP11etjfxXQyubi
	 6aIQi2xkSQ+zht3e/GxnzvzKdXOaeeGoWeDyTx6LABuEDI+566Lpvp9X/LSlqihJol
	 WDz6HtghhXe6A==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 17D15849DA
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 16:18:10 +0000 (UTC)
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
Subject: [recipe build #4011862] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177194989009.1121822.5169941242244774785.launchpad@buildd-manager.lp.internal>
Date: Tue, 24 Feb 2026 16:18:10 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="0cf96b78d7bf002eaf2ceebea991267c53522f61"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 4ae33a8ced9dd4417e14fe60b0b984e15b804f66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17128-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 780EF189CD2
X-Rspamd-Action: no action

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4011862/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-071

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4011862
Your team Linux RDMA is the requester of the build.


