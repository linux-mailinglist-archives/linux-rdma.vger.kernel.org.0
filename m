Return-Path: <linux-rdma+bounces-6686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0B79F9874
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 18:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEA4161A9D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80242288CA;
	Fri, 20 Dec 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwd.de header.i=@dwd.de header.b="Us8RKQvE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from ofcsgdbm.dwd.de (ofcsgdbm.dwd.de [141.38.3.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FF21C19B
	for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.38.3.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715241; cv=none; b=NXnsKMqrVDP6rqFg5RM0zs7BBlG7preBAdPK2ShMv5if+Rtn8VqHte9FmVydYmjxOJf7OUVHkdoDDKXpq837pBL0jg/TB3XR7xEK4/pxi+MlAKyJAKvSBH/BYsCPv5uHduJ+Q1UAcDYv7h7A9lrbow6nSf6rRzcXZO/GRB0or9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715241; c=relaxed/simple;
	bh=/0AQXtKnlfstruO3vKaibzufsMl7kCMfHSA0BvHgDDk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=c7ONUSMtXq9Q7slyeOEs8HJDJMGRIoGoPdvHhHbwHreOEIZySvdFrUIBgEQdM58hszf2RO3+RfArxXx+8QLY1yKn/0Nn3AN6MpQiKaztO22lAkTnk9FQ8SbfjXX1h8FuRINijJvZIbsXzXkVMhtpy0ykBejp0Oyq6aChIyMRIKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dwd.de; spf=pass smtp.mailfrom=dwd.de; dkim=pass (2048-bit key) header.d=dwd.de header.i=@dwd.de header.b=Us8RKQvE; arc=none smtp.client-ip=141.38.3.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dwd.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwd.de
Received: from localhost (localhost [127.0.0.1])
	by ofcsg2dn1.dwd.de (Postfix) with ESMTP id 4YFDS63mSxz3wsk
	for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
	content-type:content-type:mime-version:message-id:subject
	:subject:from:from:date:date:received:received:received:received
	:received:received:received:received; s=dwd-csg20210107; t=
	1734714598; x=1735924199; bh=/0AQXtKnlfstruO3vKaibzufsMl7kCMfHSA
	0BvHgDDk=; b=Us8RKQvEOaBJasP33O5oqC9Kw/wcA3J3zFK1b0S7PMvuJtDu9f5
	99wXGt1uxnXQvLsZZJCIzAdkt5/Jy4y6iswktTJu1MNIjq053Gw3jeU/qFt5jb8+
	hL1dxGRkG/E7bGCaoAz9NuS2iqEX1fudgf7OWD98Gyd9F/xCzhmQJg4KoLGjVVA8
	/ESTULx10O84f9oohC9u8ECxX7J8aIJwvBNXVtlB75t4vnzoozUWk4ejAR4cGUQe
	qsE3fZ8tyF0BKo0dKMBhVQm7d6EmXVU+YRoqzNa0x6E8MkDimSqzx+OHj+4Q+i+J
	K3Vlede6A1nOhj2vZwjcDM/8yBPGFNcqboA==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2cteh1.dwd.de ([172.30.232.65])
 by localhost (ofcsg2dn1.dwd.de [172.30.232.24]) (amavis, port 10024)
 with ESMTP id vFw5Z5IFC9dt for <linux-rdma@vger.kernel.org>;
 Fri, 20 Dec 2024 17:09:58 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 984E8C906BEB
	for <root@ofcsg2dn1.dwd.de>; Fri, 20 Dec 2024 17:10:32 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 8D16AC90685C
	for <root@ofcsg2dn1.dwd.de>; Fri, 20 Dec 2024 17:10:32 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.24])
	by ofcsg2cteh1.dwd.de (Postfix) with ESMTP
	for <root@ofcsg2dn1.dwd.de>; Fri, 20 Dec 2024 17:10:32 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Fri, 20 Dec 2024 17:09:58 -0000
Received: from ofcsg2dvf1.dwd.de (unknown [172.30.232.10])
	by ofcsg2dn1.dwd.de (Postfix) with ESMTPS id 4YFDS618Yqz3wsk;
	Fri, 20 Dec 2024 17:09:58 +0000 (UTC)
Received: from ofmailhub.dwd.de (ofmailhub.dwd.de [141.38.39.196])
	by ofcsg2dvf1.dwd.de  with ESMTP id 4BKHAWZe007584-4BKHAWZf007584;
	Fri, 20 Dec 2024 17:10:32 GMT
Received: from praktifix.dwd.de (praktifix.dwd.de [141.38.44.46])
	by ofmailhub.dwd.de (Postfix) with ESMTP id 062F8E25F1;
	Fri, 20 Dec 2024 17:10:32 +0000 (UTC)
Date: Fri, 20 Dec 2024 17:10:32 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
cc: linux-rdma@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: failed to allocate device WQ
Message-ID: <8328f0ab-fbd8-5d43-fbb3-f2954ccbd779@praktifix.dwd.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-FEAS-Client-IP: 141.38.39.196
X-FE-Last-Public-Client-IP: 141.38.39.196
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-9.1.1004-28872.001
X-TMASE-Result: 10--2.752800-10.000000
X-TMASE-MatchedRID: XQoK3HqFntBQgCX90x0ZfqzGfgakLdjaeQ2UkIAUu3tu2nYtSdFm0IIk
	OetmK5M4D7+3bU6CmpfgqUlnicmmewjt4l5TmF6fVfLHMdWDkKjbLuvAgD3xvJ6fSoF3Lt+M8Wk
	jUyUpHj0lyItZ36xSGZsoi2XrUn/JzhtqOA7SSC8UGm4zriL0oQtuKBGekqUpdvpxIsTHHHays4
	MQjA230E7abOrmtkeVBeYzNOg44AJ7IHyMjS7MbjP2Baz7nnE4nl2mZXQ9hJjYqwSmPUy4lRw4H
	e0X/RhwgOCwf8YblpOyfl8uZdQ2rhuJyuskHg4AzM2FBO7i4hJRYW5hfzhEW0CLmZDDvMfdqnbn
	7VT0BbY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-DDEI-PROCESSED-RESULT: Safe

Hello,

since upgrading from kernel 6.10 to 6.11 (also 6.12) one Infiniband
card sometimes hits this error:

   kernel: workqueue: Failed to create a rescuer kthread for wq "ipoib_wq": -EINTR
   kernel: ib0: failed to allocate device WQ
   kernel: mlx5_1: failed to initialize device: ib0 port 1 (ret = -12)
   kernel: mlx5_1: couldn't register ipoib port 1; error -12

The system has two cards:

   41:00.0 Infiniband controller: Mellanox Technologies MT28908 Family [ConnectX-6]
   c4:00.0 Infiniband controller: Mellanox Technologies MT28908 Family [ConnectX-6]

If that happens one cannot use that card for TCP/IP communication. It does
not always happen, but when it does it always happens with the second
card mlx5_1. Never with mlx5_0. This happens on four different systems.

Any idea what I can do to stop this from happening?

Regards,
Holger

PS: Firmware for both cards is 20.41.1000

