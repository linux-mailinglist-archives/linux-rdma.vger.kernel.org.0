Return-Path: <linux-rdma+bounces-1490-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909FE880DE5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Mar 2024 09:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC93283232
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Mar 2024 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E113D0D1;
	Wed, 20 Mar 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="XszWENjN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3DE3F9CD
	for <linux-rdma@vger.kernel.org>; Wed, 20 Mar 2024 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924772; cv=none; b=p5sYswIwI0ABJ/dOI1Wy8p/6vmX7/D6cwBhjZ95B54O4xn+wNQYQGppOcEo7gWl/2MHovMhVt3S9tIaph7OtNDEK67iIdG5Yhi4jlNEmHhJp2iepVfKYeMmpil01GrzaCpQfYFqD2J0oLkEJ4HxsRGUf4olnS0hIViaLiAhhPZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924772; c=relaxed/simple;
	bh=UBOuYltQ808mlm5HXoFn7AmVjFwUm/kTtcTWFGoR6Xg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=G11mvwd9w6hBUgiJ4dLWuuoNrA0JvrMxey+djuWVr0y1MZvKYIUgeYTPIPMnExdsrPHkTmPGF2HlM2GEU2TEOEdaOk116aRyisLCig7GoUqLtFswiGKngUKG9bml7h0xBmqwaYAJoMciDa18cBCQcRh1ymib6+SgS5Q4O5fp/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=XszWENjN; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id C448C40D1A
	for <linux-rdma@vger.kernel.org>; Wed, 20 Mar 2024 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1710924421;
	bh=UBOuYltQ808mlm5HXoFn7AmVjFwUm/kTtcTWFGoR6Xg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=XszWENjNB8IBF8uDbfClG+aYVFejbuL9fB5SlYLbTCx4E0wE1Uzve+rAWRKNHZBX+
	 kwXuTlmLh336JDlrt8K5I45/Ssha7if+rzANhv0CVx7DM7WRAXKM7knVNXUMrcQ4ND
	 MXde3zeof1lu8T+Os5ZRclLXFo3k1Tl60KTRbjFpG0+sPdVDg+hVNZbdlcSnaWIyFy
	 WbHSk9qXK5mDZakOCpUrbivjNkZTWuERPvV0QnOWOCvORNx10KJ8HtZB/MtmKshzT6
	 5jjL7490zx+/Vg0rT//BXg2J/uCcEhz941BKNyi5uYi5bMwZEit3r/+VM5uRXTFl+v
	 29CB04aXaHQKA==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id A55FD7E23B
	for <linux-rdma@vger.kernel.org>; Wed, 20 Mar 2024 08:47:01 +0000 (UTC)
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
Subject: [recipe build #3699855] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171092442163.2452654.6045918109753592264.launchpad@juju-98d295-prod-launchpad-15>
Date: Wed, 20 Mar 2024 08:47:01 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 99fa88e3b3a0aa4d9126155c6fb66ea1f5112f8e

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3699855/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-068

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3699855
Your team Linux RDMA is the requester of the build.


