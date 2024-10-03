Return-Path: <linux-rdma+bounces-5190-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5052C98EAB5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 09:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE4F1C22619
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763F12CDBA;
	Thu,  3 Oct 2024 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.b="esfW6yIA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020F2CA9
	for <linux-rdma@vger.kernel.org>; Thu,  3 Oct 2024 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.77.200.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941457; cv=none; b=RvZk5GYYcy9s+tVrPSRfGDpIOebZOXv9z4D/OhB2Na63ErdygvM2YaySZhHaN3n1PZY60KnZc10MiVNr0pCx3mqfWHA8hXT4aJm6H97uxMD1S+0jgJyuxQHRpbGSObbJdNeImBIZiwjveBhBjzjdmb5PQ8cCLrtzo8dL+wOoCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941457; c=relaxed/simple;
	bh=gOI5ox5w+BYujHJVax10g0bnWMseCY1IskmL92jHvas=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=Fd2FgtNSQRV6rYo2e9k28Fzn71cCt9i6ayR2AVwPxRtpa0zVRpN2XduCuVf70TiW9rLkWo53VkRETQXElyWkvuh1WcsNRUL/TX9vCDAIDQTiubd97W5hMJEx1xIHYP1owlyqu5nCF2D+nJ1WpAgeBmvIzj+vX+WsFuLluds6cfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univ-grenoble-alpes.fr; spf=pass smtp.mailfrom=univ-grenoble-alpes.fr; dkim=pass (2048-bit key) header.d=univ-grenoble-alpes.fr header.i=@univ-grenoble-alpes.fr header.b=esfW6yIA; arc=none smtp.client-ip=152.77.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univ-grenoble-alpes.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=univ-grenoble-alpes.fr; s=2020; t=1727941451;
	bh=gOI5ox5w+BYujHJVax10g0bnWMseCY1IskmL92jHvas=;
	h=Date:From:To:Subject:From;
	b=esfW6yIAruFTssggADWRQd/0nHFFtffvKaw5wQCqB63uWvaVwCuRtR+wcJkbl6Fyl
	 gGTlIhSexIXg1JXTUyERAukGkYbot3ialXAdEqA2viMYQ5SqQPnzyUFO1H5CDUGYRC
	 4XVWLyfqvHAYll0/yvmSC8UsOv26GVrfo6192XuNfvsscUt7tx4wzELGaT2zIA5qUW
	 Zk54zJHNqdnKrW8qmQNvwq7qKd83IA7RGXiZsFC1LvnivcD7z+PiDG7OtJdeKSgOBy
	 nLKi4xIumXJ1O/XlkQySrTTvC/A/3g/i1v//k5y+dT4D3lyOxImybObT6fI/ExbiUT
	 3+SzHEug+AcAw==
Received: from mailhub.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
	by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 2AE3940265
	for <linux-rdma@vger.kernel.org>; Thu,  3 Oct 2024 09:44:11 +0200 (CEST)
Received: from mailhost.u-ga.fr (mailhost1.u-ga.fr [152.77.1.10])
	by mailhub.u-ga.fr (Postfix) with ESMTP id 282D510005E
	for <linux-rdma@vger.kernel.org>; Thu,  3 Oct 2024 09:44:11 +0200 (CEST)
Received: from zm-mbx8.u-ga.fr (zm-mbx8.u-ga.fr [152.77.200.32])
	by mailhost.u-ga.fr (Postfix) with ESMTP id 256BB60070
	for <linux-rdma@vger.kernel.org>; Thu,  3 Oct 2024 09:44:11 +0200 (CEST)
Date: Thu, 3 Oct 2024 09:44:11 +0200 (CEST)
From: IVANE ADAM <ivane.adam@univ-grenoble-alpes.fr>
To: linux-rdma <linux-rdma@vger.kernel.org>
Message-ID: <1837235494.9324983.1727941451114.JavaMail.zimbra@univ-grenoble-alpes.fr>
Subject: Performance issue for a simple RDMA PingPong
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.1.1_GA_4660 (ZimbraWebClient - FF115 (Linux)/10.1.1_GA_4660)
Thread-Index: 7V4j/ibp8zPuE0UrjnmckwbJB/ACJA==
Thread-Topic: Performance issue for a simple RDMA PingPong
X-Greylist: Whitelist-UGA MAILHOST (SMTP non authentifie) depuis 152.77.200.32

Hello everyone,=20

I'm currently having a performance issue to synchronize two different nodes=
 with a simple ping/pong algorithm.=20
I currently have two different simple code to resume my issue :=20

The first one work as intended, and loop as follow on both client and serve=
r sides :=20
- post a send work request=20
- post a receive work request=20
- wait both completion, acknowledge them and continue.=20
This little piece of program work as intended, and I'm able to complete 100=
k request in 2=E2=80=933 seconds.=20

However, the second code is as follows :=20
The client is identical as the first code.=20
The server do :=20
- post a receive work request=20
- wait its completion and acknowledge it=20
- post a send work request=20
- wait its completion and acknowledge it=20
When I do this, it happens that the time to complete a request can take up =
to 2 seconds (most of it inside the "ibv_get_cq_event()")=20
Furthermore, we observed that, this happens more often when multiple thread=
s try to do this in synch (unlike first code).=20

Nb: I was able to replicate this issue only with send/recv, and never with =
read/write operations.=20

I try looking for this issue, but found nothing related.=20

I was able to test this on multiple configuration:=20
Linux version : 5.10.0-20-amd64, linux distribution : Debian11 & Debian12=
=20
We have a Omni-Path network, configured to 100Gb/s ( Intel Omni-Path HFI Si=
licon 100 Series [discrete] with the hfi1 driver) Firmware version: 1.27.0=
=20
Or a Infiniband network, configured to 100Gb/s (Mellanox Technologies MT289=
08 Family [ConnectX-6] with the mlx5_core driver) Firmware version: 20.29.2=
002=20

I tried with the latest version of rdma-core for debian11 & debian 12, havi=
ng the same issue.=20
The program were all compiled with gcc, with the -O3 or -O0 optimisation, w=
ithout any change in the communication time.=20

The full code for the exemple described above can be found on GitHub under =
: IAdamUGA/RDMAPerfIssue=20

I'm not aware if this is a usual behavior or not, or if this is a knowned i=
ssue.=20

I'm relatively new to this domain and i might not know about the different =
tools that could help me debug that.=20

Thank you in advance for your help.=20
Best regards.=20
__________________________=20

Ivane ADAM=20
Doctorant LIG, =C3=A9quipe Erods=20
ivane.adam@univ-grenoble-alpes.fr=20


