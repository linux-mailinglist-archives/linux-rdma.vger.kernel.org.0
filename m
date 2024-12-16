Return-Path: <linux-rdma+bounces-6551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C124E9F3A76
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 21:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F29F1888A3D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E221C5498;
	Mon, 16 Dec 2024 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="AVZRlWlE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE47339A8
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379820; cv=none; b=ULtQIoF+3/9Wa1tslXsd61UtzH+Ewi0Gqr1ARPknvzCSgy2xaGFExYbwIsIye/Ol3hsUpRlIjTtw9DT1WWEJHzVoeCHywV9ZChXjz1RPK1D0yi/b7OMGAgLRgqZHoAVY2m4oPxVmxEf65FieXzr8ISIhJ9wGP6A3U3bk88Gje20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379820; c=relaxed/simple;
	bh=pg50lQCST1x79G6HkGMCaidFGJnnGxfx7ENsFFmGxNo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VGnnv1tnsV8G8Nujoc8knsBEdrhGr1ZINJxqx5eMCobrkWHVjMp8zlTJ5wg6HYJBdJjkn5L5iXigLpG4uwh0BZ76iAX5OyAqLmeHu6uOHIdzwmzeeDwbSCV1PejsIWbWp9Pfx+mcObL4fVEhDB900By5MXNkp6kujVNoSN3EuT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=AVZRlWlE; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 106218285697;
	Mon, 16 Dec 2024 14:10:17 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id pXn_TTb3ALew; Mon, 16 Dec 2024 14:10:15 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 1EA1D8287A94;
	Mon, 16 Dec 2024 14:10:15 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 1EA1D8287A94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1734379815; bh=3eKfZyFY0VL796bY0N8OcQemlHeO17YWCFLjXi2yCrc=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=AVZRlWlE6sys2BIH6MIv9sMJdPeUZbRsPOUibcv/KWewNso9nqjUQJBbKghk5Yuam
	 PyaTbnCL1T5tN86UWYk381EDpN8IAKVV7XRvACUlCqXUH0VtOdSoqcjqKqNGzvUESD
	 GJ/St+Fj8j7pFPhndIRjjgLI49Ta6a9wjdbxgTYo=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NSxZbfX3M5-E; Mon, 16 Dec 2024 14:10:14 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id EEBF28285697;
	Mon, 16 Dec 2024 14:10:14 -0600 (CST)
Date: Mon, 16 Dec 2024 14:10:14 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Rudolf Gabler <rug@usm.lmu.de>
Cc: linux-rdma <linux-rdma@vger.kernel.org>
Message-ID: <1960002764.45894075.1734379814889.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <420F7218-5193-44B3-AD7F-ACED38C206AE@usm.lmu.de>
References: <b602d5f23ac94d012ba301c1eba40304.tpearson@raptorengineering.com> <420F7218-5193-44B3-AD7F-ACED38C206AE@usm.lmu.de>
Subject: Re: Infiniband crash
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC126 (Linux)/8.5.0_GA_3042)
Thread-Topic: Infiniband crash
Thread-Index: yKy6rIc6eQ83W6Ja6G5Opk4JuVEp1g==

Ouch.  FWIW kernel 5.4 still works, but I guess it's time to put these mthc=
a cards out to pasture.  aarch64 isn't exactly obsolete, though it still ha=
s a ton of problems vs. amd64/ppc64el -- when even tcpdump doesn't work pro=
perly, it's hard to ever envision aarch64 as server grade. ;)

----- Original Message -----
> From: "Rudolf Gabler" <rug@usm.lmu.de>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Sent: Monday, December 16, 2024 1:56:14 PM
> Subject: Re: Infiniband crash

> Sorry but I never got a solution and in the meanwhile the ia64 is out of =
any
> support.
>=20
> I tried with a firmware upgrade but this didn=E2=80=99t change anything. =
The cards are
> ok but the driver development changed so much, that only very old kernels=
 are
> working (i have a sles 11 which runs without problems beyond the circumst=
ance
> that it is totally outdated).
>=20
> Regards
>=20
> Rudi G.
>=20
>> Am 16.12.2024 um 19:06 schrieb tpearson@raptorengineering.com:
>>=20
>> =EF=BB=BFDid you ever find a solution for this?  We're running into the =
same problem on a
>> =EF=BB=BFhighly customized aarch64 system (NXP QorIQ platform), same Inf=
inband adapter
>> =EF=BB=BFand very similar crash:
>>=20
>> [    4.544159] OF: /soc/pcie@3600000: no iommu-map translation for id 0x=
100 on
>> (null)
>> [    4.551873] ib_mthca: Mellanox InfiniBand HCA driver v1.0 (April 4, 2=
008)
>> [    4.558690] ib_mthca: Initializing 0000:01:00.0
>> [    6.258309] ib_mthca 0000:01:00.0: HCA FW version 5.1.000 is old (5.3=
.000 is
>> current).
>> [    6.266272] ib_mthca 0000:01:00.0: If you have problems, try updating=
 your
>> HCA FW.
>> [    6.393143] ib_mthca 0000:01:00.0 ibp1s0: renamed from ib0
>> [    6.399038] Unable to handle kernel NULL pointer dereference at virtu=
al
>> address 0000000000000010
>> [    6.407865] Mem abort info:
>> [    6.410662]   ESR =3D 0x0000000096000004
>> [    6.414419]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>> [    6.419748]   SET =3D 0, FnV =3D 0
>> [    6.422806]   EA =3D 0, S1PTW =3D 0
>> [    6.425952]   FSC =3D 0x04: level 0 translation fault
>> [    6.430842] Data abort info:
>> [    6.433725]   ISV =3D 0, ISS =3D 0x00000004
>> [    6.437569]   CM =3D 0, WnR =3D 0
>> [    6.440540] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000008086f600=
00
>> [    6.447003] [0000000000000010] pgd=3D0000000000000000, p4d=3D00000000=
00000000
>> [    6.453819] Internal error: Oops: 0000000096000004 [#1] SMP
>> [    6.459412] Modules linked in: ib_ipoib(E) ib_umad(E) rdma_ucm(E) rdm=
a_cm(E)
>> iw_cm(E) ib_cm(E) configfs(E) ib_mthca(E) ib_uverbs(E) ib_core(E)
>> [    6.472263] CPU: 0 PID: 100 Comm: kworker/u17:0 Tainted: G           =
 E
>> 6.1.0+ #55
>> [    6.480297] Hardware name: Freescale Layerscape 2080a RDB Board (DT)
>> [    6.486670] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
>> [    6.492636] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTY=
PE=3D--)
>> [    6.499624] pc : mthca_poll_cq+0x4f0/0x9a0 [ib_mthca]
>> [    6.504703] lr : mthca_poll_cq+0x1e8/0x9a0 [ib_mthca]
>>=20
>> Since this is apparently hitting two different architectures, I suspect =
the
>> problem is in the driver, not the arch-specific code.  I may recommend w=
e
>> upgrade the card to work around this, but given the rarity of the hardwa=
re it's
>> not something I want to recommend tinkering with and it may or may not e=
ven
>> accept the new card in the first place.
>>=20
> > Thoughts?

