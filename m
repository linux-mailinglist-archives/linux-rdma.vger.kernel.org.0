Return-Path: <linux-rdma+bounces-6549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B929F38A2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 19:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0F4189238B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F77206F2A;
	Mon, 16 Dec 2024 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="KHKFF+oV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B2207A06
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372345; cv=none; b=O+GCiCKBK6tLdQHL5P9B8VMCVXI9vnMv28mzUW+kh1YWOJ/Z+Wk/LuL+hYdIGqwicNrGDpqqL6yMF64onrPCVmkFN6ZQSpwpuO3Cq2r13xC+vX9Wvzv2bpod8z3RLYW4blxU35LPMBhuL2RcjLPde49BUSu+rKK+AGR7G+S4nf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372345; c=relaxed/simple;
	bh=MdKLIkSAnubC0vOt9Z7hWJrvw0mpJzItYuVy0z/NlWU=;
	h=Date:Message-ID:To:From:Cc:Subject:In-reply-to; b=FQIE6eXplEYUx0IDJcjjiMLLWShS6tWnkL9AkLAXVS5UkEkmaaZat74YwNt04wLF8zTRCsZSXiaXjuhONdU4vD8BQ9aT8GD778AzNDfuAG5Z40Xa2OuykbsPvwNIAweUeaDYtP4AQU2UZ92W7AKP/JMowcRotZ51r23ShalQTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=KHKFF+oV; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id BE9BE828580A;
	Mon, 16 Dec 2024 12:05:40 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id s8iUA0j4AO3C; Mon, 16 Dec 2024 12:05:39 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8F5318286D2D;
	Mon, 16 Dec 2024 12:05:39 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 8F5318286D2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1734372339; bh=uKH2Fxkar68QLA/X67oOwZAUGc2Lc5NIPifaUJcWZI4=;
	h=Date:Message-ID:To:From;
	b=KHKFF+oV11H486nhYR/1HGaBAjwmm1rDhD9GZQ0cZ1B7cOKouLphDxs23hrI1Ff6O
	 rR1cpaynAhBPZEiYMy+z/1kcRYLELBniDxRpyr4jA0ey8SZytUSg4cEz+jBwtiLtdZ
	 qLfjukxhDdB23SBkbNKtqZm4/pdsPoCdDu+1rxIg=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kRr1PE5S4Q48; Mon, 16 Dec 2024 12:05:39 -0600 (CST)
Received: from localhost (unknown [192.168.3.8])
	by mail.rptsys.com (Postfix) with ESMTP id 6A064828580A;
	Mon, 16 Dec 2024 12:05:39 -0600 (CST)
Date: Mon, 16 Dec 2024 12:05:39 -0600
Message-ID: <fba3779b3e870b9f26bb97a9e5c5b0e4.tpearson@raptorengineering.com>
To: rug@usm.lmu.de
From: tpearson@raptorengineering.com
Cc: linux-rdma@vger.kernel.org
Subject: Re: Infiniband crash
In-reply-to: 20221014181651.Horde.p1jZxomAX1Dlqme6qIvYwJa@www.usm.uni-muenchen.d
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Did you ever find a solution for this?  We're running into the same problem on a highly customized aarch64 system (NXP QorIQ platform), same Infinband adapter and very similar crash:

[    4.544159] OF: /soc/pcie@3600000: no iommu-map translation for id 0x100 on (null)
[    4.551873] ib_mthca: Mellanox InfiniBand HCA driver v1.0 (April 4, 2008)
[    4.558690] ib_mthca: Initializing 0000:01:00.0
[    6.258309] ib_mthca 0000:01:00.0: HCA FW version 5.1.000 is old (5.3.000 is current).
[    6.266272] ib_mthca 0000:01:00.0: If you have problems, try updating your HCA FW.
[    6.393143] ib_mthca 0000:01:00.0 ibp1s0: renamed from ib0
[    6.399038] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
[    6.407865] Mem abort info:
[    6.410662]   ESR = 0x0000000096000004
[    6.414419]   EC = 0x25: DABT (current EL), IL = 32 bits
[    6.419748]   SET = 0, FnV = 0
[    6.422806]   EA = 0, S1PTW = 0
[    6.425952]   FSC = 0x04: level 0 translation fault
[    6.430842] Data abort info:
[    6.433725]   ISV = 0, ISS = 0x00000004
[    6.437569]   CM = 0, WnR = 0
[    6.440540] user pgtable: 4k pages, 48-bit VAs, pgdp=0000008086f60000
[    6.447003] [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
[    6.453819] Internal error: Oops: 0000000096000004 [#1] SMP
[    6.459412] Modules linked in: ib_ipoib(E) ib_umad(E) rdma_ucm(E) rdma_cm(E) iw_cm(E) ib_cm(E) configfs(E) ib_mthca(E) ib_uverbs(E) ib_core(E)
[    6.472263] CPU: 0 PID: 100 Comm: kworker/u17:0 Tainted: G            E      6.1.0+ #55
[    6.480297] Hardware name: Freescale Layerscape 2080a RDB Board (DT)
[    6.486670] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
[    6.492636] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.499624] pc : mthca_poll_cq+0x4f0/0x9a0 [ib_mthca]
[    6.504703] lr : mthca_poll_cq+0x1e8/0x9a0 [ib_mthca]

Since this is apparently hitting two different architectures, I suspect the problem is in the driver, not the arch-specific code.  I may recommend we upgrade the card to work around this, but given the rarity of the hardware it's not something I want to recommend tinkering with and it may or may not even accept the new card in the first place.

Thoughts?

