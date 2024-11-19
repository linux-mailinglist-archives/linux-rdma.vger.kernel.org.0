Return-Path: <linux-rdma+bounces-6040-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424369D2CDC
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2024 18:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A9DB3D2CE
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2024 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530D1D2B04;
	Tue, 19 Nov 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="tD8iOCpK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806241D1E7C
	for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037005; cv=none; b=QLe3oXWWEeyOCeiKqe6aqFdDkYObHS7NB//d8s1pBI0WiaBhmcRdJpvN0MwsCJluIcEt2+4l7c8/5XjJN/5+Iqi9qrVl4aBSNtC6gs/2WOvjMBpGI2SUuwl6VTY0bpf9b8/Ow/g5HWsnEZtZ4YkoxTgA+PCVH4TQ77Sq0/qTy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037005; c=relaxed/simple;
	bh=HUyjdu72bvwQjGnPhdeBL5iImXOi/JGtoCSJjDTh1tY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=L2q4BUmfrLbyRmFb4qiaBYZ6XcsRQtEWAX+iAjYtsl3ycvkLGgedCVpSRHK2nu825zZcnwCs0jII2mTeB6iEPrEt4bSbHVV4LtE06fSgYP3ySKig94RHGqc05kCMsP0l7us/teIFQmrDWO6W3hxwZmfWOI3RNrFCPxrDfvx8dJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=tD8iOCpK; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 95C3A3F151
	for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2024 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1732036995;
	bh=HUyjdu72bvwQjGnPhdeBL5iImXOi/JGtoCSJjDTh1tY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=tD8iOCpKU61CFtdIkJfMlW7oIBhV2ntzVGOK8ZB9Y/RASoiyn/Pcd9YejG7LcvmvG
	 IqmThY7M4WOZtZ2DC6J/wfyr1IfbX649IPPiSpOOwrhqEMGL//6xej54WerwUeKHcB
	 24JbquweOZB2Ct2KZi4YagCR85Xf5/fuKRDpOarBzfqlZXMgrwXq5293Vf81Oh2rYA
	 4SstE4LZcJxefSi3anWzDD685pKFVhVz5KI0T+rSJ2JEhB0pveO3NAsTxPEINyMzoM
	 excFtmlb1Q+JI9Rv4dC/9k6V4EMuP9+mGQh24ACFhD9MKVVDi+nnTInxARfZ6CnZHR
	 SfqJcbxUy+H5g==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 1DA1E7E24E
	for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2024 17:23:15 +0000 (UTC)
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
Subject: [recipe build #3815065] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173203699511.2106356.15787536051039745427.launchpad@buildd-manager.lp.internal>
Date: Tue, 19 Nov 2024 17:23:15 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="22ade00ab50b929fac63b8ee7252243aceda294a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5e9f183fc49b7cce625581aef3591c454c664e2b

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3815065/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-117

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3815065
Your team Linux RDMA is the requester of the build.


