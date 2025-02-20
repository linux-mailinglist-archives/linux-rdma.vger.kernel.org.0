Return-Path: <linux-rdma+bounces-7926-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A85A3E7D3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 23:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F43E423047
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F438264F92;
	Thu, 20 Feb 2025 22:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Kwi8y0pg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C1264FA0
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092015; cv=none; b=aeeuhIste3sPjXswBExIUvDM+l0v8ZHlGaV1s7RCiZYrZPZjbCrWqxFpJipeqDzqEvywaGWTdUWX8aNsrFyENNgndX++fWtYKgYJqfjwxS8NFyxY0ErcJ7a62zMMMQLns8sAGa6sLQxBo5Ot5w8OpHzKrzHZHIOrdjFMJ36Cb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092015; c=relaxed/simple;
	bh=dDIAg7U+EZOTUf9TFVOdM3+fE3RjbfKPCE0OECUat1g=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=kxLT5D/SySi+xAP/2332s9+HvJX7WOk/h5oK7bNZyWF8p2kq+F5bfTxVzy1xh/7VqWkxSIXD3hmYHfPS8OekZxYiVpa6zHSGgLZRRxoyQNKl+A8AHx5R6uLtUgrkpcTAX+VIm7FqZx9d8zc3/rBumGoZUhke9W70mCvVpEvozZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Kwi8y0pg; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 55C6F41246
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 22:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1740092005;
	bh=dDIAg7U+EZOTUf9TFVOdM3+fE3RjbfKPCE0OECUat1g=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Kwi8y0pgEBqscRXMLkhJbsTHgPWTBKWd9B+4zXpdhn0BEmpIEqZ9XlDSiEzsOm12h
	 R2N0B7QS8MnaD7L+yY17GDHr4hQHd8VAF/p/Sz5Vl+GDQpo+SPxF/ts/69yzkl6rdu
	 VIo+YTpvM0QTW3PqPphIXAaO9yEY3GJZVzCM5pE2EczA0gee4eN5eamt8yxaMqOKa8
	 zfHrvVTGLu0J2q4hNmDoenDgurxXV0O72FepsfW0WrmxoV1K8Ypot3wj1OwUo47qo3
	 Ov6BLceei1WqkMnaENqgG1N32nXd7sMaALdK+l/uvcsVjqnmH9HheRWWXxrt+slGMk
	 RPXKE6yREsNEw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 4BE447E244
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 22:53:25 +0000 (UTC)
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
Subject: [recipe build #3857103] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174009200530.964601.9385406636550019437.launchpad@buildd-manager.lp.internal>
Date: Thu, 20 Feb 2025 22:53:25 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="78860d903de6d6d7dd5a0ade63efaca45d3467e2"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ba63cbad75701c590cc902d1da41ea4a6ff2680f

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 7 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3857103/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-105

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3857103
Your team Linux RDMA is the requester of the build.


