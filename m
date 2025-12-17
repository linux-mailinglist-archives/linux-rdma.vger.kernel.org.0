Return-Path: <linux-rdma+bounces-15049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9367DCC8508
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 15:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE3A130052B1
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED4437A3F5;
	Wed, 17 Dec 2025 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="IlvhEYMv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FD35A92E
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765983174; cv=none; b=Jb4z0s5ZZQQ/afSgUyQF7UE4D2qdwerY2AXknRi6c0+h15L7Az3/RaIKA9HE33AEIOH2S8ZqFD/ibfUh6iWSDCFjZA4eoIgQmiygY7evXDh4Q4TGNAjjsMkw/OCMsqLN32TbyhXLNvXXCv0IkNjfZ9C01Qymx2Y8IY1oqUSKNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765983174; c=relaxed/simple;
	bh=muQdwD2TpIvfI7Ox/6m0qX1MAkh1rR45gC0Kn3g35Hw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=VzY4ehge+QJV9HDl4TdkT779MINR5yDFvKgvtUqgjVz+fChZvtwnVZNyyvO2vPV/b5wYZVzAMQqEGzHkuEL/67DtYJ4GIyOMAdiuZRIOioirqEU4rgi8BWpiiqGjA5QDUWj4hVQMEUGksb+U+D9Q0W9wmGTqfNcnenZkcJGsn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=IlvhEYMv; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 411F043291
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1765982775;
	bh=muQdwD2TpIvfI7Ox/6m0qX1MAkh1rR45gC0Kn3g35Hw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=IlvhEYMvgO8jH1y8tCLKPi63im0bdcIQH5FuIyLTXbmVHLCvt2/S0doMBHuDu9gqr
	 +/A7VbwCBkf9J3V7WZKhu8JMOdUFu3abwGufgvcnOHTkqguxLJ0Iihd35NhybBmF/h
	 vDOgT6/Tz5I8Jk+FrxE9B8r3broS8aILqr/dMrWS+Oc/DpVfFzKRZcWB3kYk7LCiWh
	 CDCdoQICJhS26TuoRHYjcIwh8sfp77A+89bc4EVn//LvkoxOWLHgGidWrPg+VYSyV0
	 mwuNMIOcruuzJCddO+w6JxAGSdAi7IjkVjffBmRgPT7eJO9nXWIa5o/eFj3pq4/b2z
	 J08MP9wZFOCdw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 209E57E79E
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 14:46:15 +0000 (UTC)
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
Subject: [recipe build #3986665] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <176598277513.2912269.14472458973961587365.launchpad@buildd-manager.lp.internal>
Date: Wed, 17 Dec 2025 14:46:15 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5b935eb96ac96a548ba7a71117b28379c3948c87

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3986665/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-021

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3986665
Your team Linux RDMA is the requester of the build.


