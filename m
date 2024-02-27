Return-Path: <linux-rdma+bounces-1155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA38986999B
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 16:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501CBB28B78
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E3614533F;
	Tue, 27 Feb 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="cWqWjCnz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940C1482F5
	for <linux-rdma@vger.kernel.org>; Tue, 27 Feb 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045838; cv=none; b=hghGn7y/5dQAZ4EwaeL1Cvu9V3HQlZ3q0BIx5Nbs/B1oAB1gNQr0onAiUVoq0iE9UAgTVZVSrPunuI1qmO/tllz6u9tVqxZp4SCP716OThmoPcJLynnK2hOx27oUMLmmmbyh80fT8bEjtKAxEkwwFX57c6zZ8NY6ro5w/pm1FCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045838; c=relaxed/simple;
	bh=48Bs3kCuwRgyKRcXusIu6vROcODq5F8yKY7yyWnLlY8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=CGhr4BvYD6r5099LP4wPYsd1ex/NApIGij0JLcmbz8sWBFwPPOCSVZmHma1YuKb6a1IDBlAbtWru5TrrSuuX593vST1lFhCgMuFcZUA6rlfusOFJ5WURETlgRQ+N17HRXM1QmZlJ+DQ9tD0b4+oAQROiMEoaT1+4lMSiGRtbsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=cWqWjCnz; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 4C1233F831
	for <linux-rdma@vger.kernel.org>; Tue, 27 Feb 2024 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1709045237;
	bh=48Bs3kCuwRgyKRcXusIu6vROcODq5F8yKY7yyWnLlY8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=cWqWjCnzGkmzMvExmYsgLVYtE0aIG7In/qMYNKp6Rw6CaVl6V/b3BR/pw+wGTGMHd
	 tXWvIZW56ZpMdy2jh7VV6oKO/RbI9zMq27px8Z2krX/UIhBy1kNIMulFClAKbHO8hz
	 9rDuUa4ZKkfra6CFp2rKgrMTzh+9nelTEC5j+rnz+Rn/SUeReDcowLNb41T2VkbSzA
	 O1ugGUCj20mfrDPuCTNFfWmDKv3OI4MrBiIniVUEdoEln5WAcp4iTPg3nfyI1xg4M9
	 IGX5nT7wB3CyaQteUrC2y+UI38JGK/JMmEnh/MOZFo0TJREu7iSL6fAdb0qpKuoOQ/
	 ID9FtYW5cQ17A==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 5FB857E5A1
	for <linux-rdma@vger.kernel.org>; Tue, 27 Feb 2024 14:47:16 +0000 (UTC)
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
Subject: [recipe build #3689623] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170904523635.3580314.15223080638411430228.launchpad@juju-98d295-prod-launchpad-15>
Date: Tue, 27 Feb 2024 14:47:16 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="9643586c585856148a18782148972ae9c1179d06"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: eec80b457e15b015f58561556f2a762216db57ad

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3689623/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-008

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3689623
Your team Linux RDMA is the requester of the build.


