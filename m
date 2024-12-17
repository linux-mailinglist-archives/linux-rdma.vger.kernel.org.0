Return-Path: <linux-rdma+bounces-6607-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF429F570D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 20:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF007A51CC
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 19:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD711F76BC;
	Tue, 17 Dec 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="oIS/Uf7k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B61F7569
	for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464561; cv=none; b=WE96yq7DGz8WwZaLjBCWyM7d4E6qTpimrCPUxAguCvxLyfRPNyc5ML/gSncu2CPYu9EcDfwkEYC8xYZ7ItFnjjMk1lP/r2ktJSXWFEkkvHSMAREGLe8vuovnr4xWzMMCCsAdLGTyUHDyTXlY397hbB9eNrGa49MGxxJ4r+vnTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464561; c=relaxed/simple;
	bh=VmgBgBD+VOsvwM5aq3kx4vU2ZsIrGHbIfdQIKSKOgcU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OzmR6NM6/iCHgf6Sex97j/+KiuWZWg96twmw8ZI+tHIXQPwPN1MVV6A9xU94gqdavx0qEAte3c43A/iF6VQLeVpDlBUZIi1hSRtHLOyFOtPxrpVR1uYBPf6U9uSgz4BsAUjHaSvjp2t2YB/ch2+q+dyCE8UslgiMkgQExscV2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=oIS/Uf7k; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id B111B82853FD;
	Tue, 17 Dec 2024 13:42:30 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NMDeM5yMxRoh; Tue, 17 Dec 2024 13:42:29 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 722EF828541F;
	Tue, 17 Dec 2024 13:42:29 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 722EF828541F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1734464549; bh=jjSwA9HT7uO6c6DBwxj99/gNx09mtbBceD3TvfUc8W4=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=oIS/Uf7kpQoy3gR4BYkLEe1hSQyssdTYvGqMPifuIPvJbi9+ul/yV6GsGqgQwBNBP
	 oxzhePtvjScV6hFy9G0xPGgJp7O7ZgKperr26c8FpRJZ/ML+dtEFfc6Po2BUbypSxw
	 Nw2+7nx4No1OPa3drbQKM5QRkZgLgoOeGY73o1zo=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7SWH2tEDcigL; Tue, 17 Dec 2024 13:42:29 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 430F082853FD;
	Tue, 17 Dec 2024 13:42:29 -0600 (CST)
Date: Tue, 17 Dec 2024 13:42:26 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Rudolf Gabler <rug@usm.lmu.de>, linux-rdma <linux-rdma@vger.kernel.org>
Message-ID: <1817311893.46094970.1734464546878.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20241217091042.6a4f1759@samweis>
References: <fba3779b3e870b9f26bb97a9e5c5b0e4.tpearson@raptorengineering.com> <20241217091042.6a4f1759@samweis>
Subject: Re: Infiniband crash
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC126 (Linux)/8.5.0_GA_3042)
Thread-Topic: Infiniband crash
Thread-Index: USnkt+vQCT98z60BUTUOnRj5d6WEpg==



----- Original Message -----
> From: "Thomas Bogendoerfer" <tbogendoerfer@suse.de>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "Rudolf Gabler" <rug@usm.lmu.de>, "linux-rdma" <linux-rdma@vger.kernel.org>
> Sent: Tuesday, December 17, 2024 2:10:42 AM
> Subject: Re: Infiniband crash

> On Mon, 16 Dec 2024 12:05:39 -0600
> tpearson@raptorengineering.com wrote:
> 
>> Did you ever find a solution for this?  We're running into the same problem on a
>> highly customized aarch64 system (NXP QorIQ platform), same Infinband adapter
>> and very similar crash:
>> 
>> [    4.544159] OF: /soc/pcie@3600000: no iommu-map translation for id 0x100 on
>> (null)
>> [    4.551873] ib_mthca: Mellanox InfiniBand HCA driver v1.0 (April 4, 2008)
>> [    4.558690] ib_mthca: Initializing 0000:01:00.0
>> [    6.258309] ib_mthca 0000:01:00.0: HCA FW version 5.1.000 is old (5.3.000 is
>> current).
>> [    6.266272] ib_mthca 0000:01:00.0: If you have problems, try updating your
>> HCA FW.
>> [    6.393143] ib_mthca 0000:01:00.0 ibp1s0: renamed from ib0
>> [    6.399038] Unable to handle kernel NULL pointer dereference at virtual
>> address 0000000000000010
>> [    6.407865] Mem abort info:
>> [    6.410662]   ESR = 0x0000000096000004
>> [    6.414419]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    6.419748]   SET = 0, FnV = 0
>> [    6.422806]   EA = 0, S1PTW = 0
>> [    6.425952]   FSC = 0x04: level 0 translation fault
>> [    6.430842] Data abort info:
>> [    6.433725]   ISV = 0, ISS = 0x00000004
>> [    6.437569]   CM = 0, WnR = 0
>> [    6.440540] user pgtable: 4k pages, 48-bit VAs, pgdp=0000008086f60000
>> [    6.447003] [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
>> [    6.453819] Internal error: Oops: 0000000096000004 [#1] SMP
>> [    6.459412] Modules linked in: ib_ipoib(E) ib_umad(E) rdma_ucm(E) rdma_cm(E)
>> iw_cm(E) ib_cm(E) configfs(E) ib_mthca(E) ib_uverbs(E) ib_core(E)
>> [    6.472263] CPU: 0 PID: 100 Comm: kworker/u17:0 Tainted: G            E
>> 6.1.0+ #55
>> [    6.480297] Hardware name: Freescale Layerscape 2080a RDB Board (DT)
>> [    6.486670] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
>> [    6.492636] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    6.499624] pc : mthca_poll_cq+0x4f0/0x9a0 [ib_mthca]
>> [    6.504703] lr : mthca_poll_cq+0x1e8/0x9a0 [ib_mthca]
>> 
>> Since this is apparently hitting two different architectures, I suspect the
>> problem is in the driver, not the arch-specific code.  I may recommend we
>> upgrade the card to work around this, but given the rarity of the hardware it's
>> not something I want to recommend tinkering with and it may or may not even
>> accept the new card in the first place.
> 
> which kernel version is this ? It looks like the bug fixed with
> 
> dc52aadbc184 RDMA/mthca: Fix crash when polling CQ for shared QPs
> 
> Thomas.

Kernel 6.1 -- this is a custom build for the rather odd aarch64 platform in use, and v6.1 was selected due to the use of Debian Bookworm.

I can confirm applying the patch referenced above resolves the crash.  Thanks for the pointer!

