Return-Path: <linux-rdma+bounces-6695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C59FA0C3
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC33188FFC7
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 13:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B051F2C47;
	Sat, 21 Dec 2024 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwd.de header.i=@dwd.de header.b="V6MrUvat"
X-Original-To: linux-rdma@vger.kernel.org
Received: from ofcsgdbm.dwd.de (ofcsgdbm.dwd.de [141.38.3.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C871F236C
	for <linux-rdma@vger.kernel.org>; Sat, 21 Dec 2024 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.38.3.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734786992; cv=none; b=D0+8fy5duaJjzekTXuXOeczOxz/x1KZzossPWx4/v0VaU1lnjVv6uyWQMa/EpeB2K5KE7wgcxPBhpeOd1ckbw5wffJOxTZCUKZOfIaX1BZRxgqgMmFB3PLdPcn9RRbfwOl7SYbOy/Xdmma+ho5EoKR6i/UJi53Yu3jxH3oXkywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734786992; c=relaxed/simple;
	bh=HsHZXN21keJI6f6I18Ie3vd+6Bd8T4Yl3TMmWe+h734=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=md/rJDcFrJghR//LOLa+C63A0HAaEmzMOx7LWl1Zoz65amfkkatKqbYdYm+/v2/K6RTAZAQ5zQOeI05I6B7QCzZU/T+t237Z4Y7JA6Cy21KWHJW0SRZyq2wPHoRwpWwK7jurZIsvucNvXCYMQVeIgUktUsyaXReBa+71ZQWuuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dwd.de; spf=pass smtp.mailfrom=dwd.de; dkim=pass (2048-bit key) header.d=dwd.de header.i=@dwd.de header.b=V6MrUvat; arc=none smtp.client-ip=141.38.3.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dwd.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwd.de
Received: from localhost (localhost [127.0.0.1])
	by ofcsg2dn2.dwd.de (Postfix) with ESMTP id 4YFlCy2RBXz3vv6
	for <linux-rdma@vger.kernel.org>; Sat, 21 Dec 2024 13:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
	content-type:content-type:mime-version:references:message-id
	:in-reply-to:subject:subject:from:from:date:date:received
	:received:received:received:received:received:received:received;
	 s=dwd-csg20210107; t=1734786974; x=1735996575; bh=HsHZXN21keJI6
	f6I18Ie3vd+6Bd8T4Yl3TMmWe+h734=; b=V6MrUvatoC9El4+x5dopxO9cglt5F
	F1p7njWTs6ZtMfBYaHZaIAYL3bf+SAu+gU9d1Zqsp82cL99UnAn1ovpgCDAd67Ac
	9Gyzxk/BnQTjXV81zNJkYkQrsqE2PHJ28QrtX3dN4fZ7mbKbS1z5JcKOFaY67JbB
	AgelSnhuUrJdzTQGAzciCMRUd6Mt7s3+PkvsNuZB0qHkRMxeNqN29epzNynK681W
	sVMoGxztWP7x2XBo5LmyVayqqVHj9PaxxetE7UYByGJ55tNF5EnDEWkN1NyRhrol
	SekC1QnYerhRgYOiroQgJS3AfLz3cOx/0y9+HF32wWabNAq+vUogb7WVg==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2cteh1.dwd.de ([172.30.232.65])
 by localhost (ofcsg2dn2.dwd.de [172.30.232.25]) (amavis, port 10024)
 with ESMTP id hZAMX9HQT3Kn for <linux-rdma@vger.kernel.org>;
 Sat, 21 Dec 2024 13:16:14 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id CA1C8C9068EB
	for <root@ofcsg2dn2.dwd.de>; Sat, 21 Dec 2024 13:16:26 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id BEA25C906695
	for <root@ofcsg2dn2.dwd.de>; Sat, 21 Dec 2024 13:16:26 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.25])
	by ofcsg2cteh1.dwd.de (Postfix) with ESMTP
	for <root@ofcsg2dn2.dwd.de>; Sat, 21 Dec 2024 13:16:26 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Sat, 21 Dec 2024 13:16:14 -0000
Received: from ofcsg2dvf1.dwd.de (unknown [172.30.232.10])
	by ofcsg2dn2.dwd.de (Postfix) with ESMTPS id 4YFlCx6hYKz3vv6;
	Sat, 21 Dec 2024 13:16:13 +0000 (UTC)
Received: from ofmailhub.dwd.de (oflxs16.dwd.de [141.38.39.208])
	by ofcsg2dvf1.dwd.de  with ESMTP id 4BLDGQ9T032690-4BLDGQ9U032690;
	Sat, 21 Dec 2024 13:16:26 GMT
Received: from praktifix.dwd.de (praktifix.dwd.de [141.38.44.46])
	by ofmailhub.dwd.de (Postfix) with ESMTP id E6A964530D;
	Sat, 21 Dec 2024 13:16:25 +0000 (UTC)
Date: Sat, 21 Dec 2024 13:16:25 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    linux-rdma@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: failed to allocate device WQ
In-Reply-To: <7f0908c3-f730-4c5d-88d7-85677810082a@linux.dev>
Message-ID: <2a65bcd8-1be1-c288-b42-e35b4c2e9fd@praktifix.dwd.de>
References: <8328f0ab-fbd8-5d43-fbb3-f2954ccbd779@praktifix.dwd.de> <7f0908c3-f730-4c5d-88d7-85677810082a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="646786604-1624292732-1734786985=:411370"
X-FEAS-Client-IP: 141.38.39.208
X-FE-Last-Public-Client-IP: 141.38.39.208
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-9.1.1004-28872.007
X-TMASE-Result: 10--20.620000-10.000000
X-TMASE-MatchedRID: hls5oAVArl+Mp9w0tjqOxZObxJgN/hOx9mojSc/N3Qc++wvgAuuoRSGp
	j6GvmRpRIx7ovwFkS186/QBLsWwGZDX8L7j/ATlXEVuC0eNRYvJYMtqMzbYRNt/GRDcnsEF/hXA
	r+h4GfTClN85rH1VCXn5yrIDO91C50eczgee7i1Mc9jA4mLo8uUNWaKIdBIV4E+Ig87Z3yDmNRC
	PAFosOlJxWn6dtA5GQ38c9k6vg4OMWm1JUTIsfIENF5tKVli5KWmOfr3aLpwitbfN6thhUri4TI
	zFTm9BjfS0Ip2eEHny/CDcGwGd8j6u5ndjAQzfa9xS3mVzWUuDgwxMH5wVMugKmARN5PTKc
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-DDEI-PROCESSED-RESULT: Safe

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--646786604-1624292732-1734786985=:411370
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 21 Dec 2024, Zhu Yanjun wrote:

> 在 2024/12/20 18:10, Holger Kiehl 写道:
> > Hello,
> > 
> > since upgrading from kernel 6.10 to 6.11 (also 6.12) one Infiniband
> > card sometimes hits this error:
> > 
> >     kernel: workqueue: Failed to create a rescuer kthread for wq "ipoib_wq":
> >     kernel: -EINTR
> >     kernel: ib0: failed to allocate device WQ
> >     kernel: mlx5_1: failed to initialize device: ib0 port 1 (ret = -12)
> >     kernel: mlx5_1: couldn't register ipoib port 1; error -12
> > 
> > The system has two cards:
> > 
> >     41:00.0 Infiniband controller: Mellanox Technologies MT28908 Family
> >     [ConnectX-6]
> >     c4:00.0 Infiniband controller: Mellanox Technologies MT28908 Family
> >     [ConnectX-6]
> > 
> > If that happens one cannot use that card for TCP/IP communication. It does
> > not always happen, but when it does it always happens with the second
> > card mlx5_1. Never with mlx5_0. This happens on four different systems.
> > 
> > Any idea what I can do to stop this from happening?
> > 
> > Regards,
> > Holger
> > 
> > PS: Firmware for both cards is 20.41.1000
> 
> It is very possible that FW is not compatible with the driver. IMO, you can
> make tests with Mellanox OFED.
> 
Thanks, I did not know there was another driver.

I just had a look, but since I build my own kernels via 'make
binrpm-pkg' and then distribute them, this seems a to big hurdle to
overcome for me.

> If the driver is compatible with FW, this problem should disappear.
> 
Actually the firmware has always been 20.39.1002 and after the
problems appeared I have upgraded to 20.41.1000, hoping it will
solve the problem.

Regards,
Holger
--646786604-1624292732-1734786985=:411370--


