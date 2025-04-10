Return-Path: <linux-rdma+bounces-9331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9986CA844DB
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527628A0378
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34F82857DA;
	Thu, 10 Apr 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="OdHkcxLb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001022853F1
	for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291663; cv=none; b=Bj0PaugJdY8ow1oPLn9jnUA8RY4dY/f1EzvIcaIfVEecHhQj04Kq4g4uKOgWUGKMhNMP+Y5xvFZH2K2rmYWHEmkRY0tsBE0ykmbIaYV+trLfWncHBnOaUL7RKW5yvl55OB7tTma5PmbJyFYETgYLY6AnibILVcKsEU2zDACnkYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291663; c=relaxed/simple;
	bh=NwM/OtAW6dvTOS23K6B21jj7GDQuYEG2orEN1O8Fmww=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=D9oFhZEkQE5+EyHwZf2nQFzsRdEfpONQsL3lqbbL4x0a8e95eHkx0Quk1POegxCYae27szWDQq24Kl7CqzjDkFKa/xtMfM959DCBjBMa3/wNH/UK6i5SpuU/tGLlCdob2NcubkLzUpqE0rlOJyGqHtOBNFHcB68JBQUHcpgjT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=OdHkcxLb; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 0BE143F073
	for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1744291123;
	bh=NwM/OtAW6dvTOS23K6B21jj7GDQuYEG2orEN1O8Fmww=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=OdHkcxLbP6iX5wEMdXaqAweVGLUPTYdS91yxiP7mT6EwdEIcB/YVEBrlN4oc+4ilG
	 fsDo8FWN95qEPns5JLAFclQfoOTNy8czPtQIGOxrNChl0RJUdxMle4TxcSOXExSphN
	 waIN7JSZ2VWLlOEnLaVMc3bAtZMqKhmD3np0mVlKhkdGGKuukPVpjS0KiiOI6hy2sM
	 fEM8l0LK85SBpvw3/6LC/IEWjKJNFU2XZBH3sX5YOKLvkZcOVpyzi76fbzkZWL/bWO
	 +2Yud/BIwf3l2P0JVXxvEhUHatSZnux8+rSr2bFzYxN/oUE27wVVYYKGkX5dy6EYjK
	 ogWAv96ozdf2w==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id EFD8D7E25A
	for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 13:18:42 +0000 (UTC)
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
Subject: [recipe build #3880191] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174429112297.2962190.16800067597671480709.launchpad@buildd-manager.lp.internal>
Date: Thu, 10 Apr 2025 13:18:42 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e76edd883483c71c468bb038e98836435de44530"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 612640cd8823036ff3d993c4edc007cb7cf233a3

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3880191/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-057

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3880191
Your team Linux RDMA is the requester of the build.


