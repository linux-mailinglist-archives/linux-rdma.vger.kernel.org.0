Return-Path: <linux-rdma+bounces-12945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE51B38046
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 12:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934BE364828
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4FC34AAF0;
	Wed, 27 Aug 2025 10:48:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD734A334;
	Wed, 27 Aug 2025 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291725; cv=none; b=E5/GxLLPGt8btHHzRXSap/kKINZy8zmS4ZO52bGUm5eBH921IYcunRiixKtpJmt1M7PijDX3UyvvshaUFv1XAH4jEfW/7V+FfsMIu5jsloW909/SpZdqYQ+YGBBvUMwVf8hq569gjCGgzC8eNvixVIS/gzfkcSaL+dU/loleHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291725; c=relaxed/simple;
	bh=4QChEoRjqWHTne5COgEK+7FgPenEtjJhU59F2PQTz28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UeRi9ek2SeGM1oW/onmGJjfu/g490kh5co9BUQbDQ5n3KXaZfd4ZmGxip5PXXTkCUCTuUbOejS526hzypxwJKMpqj6HKpuF3GHauyPJLzs1b8JTLzDiXAU12Yf2y8rFEymvNaQas3ufhkOEn30ATZ7Hpi7wr2cz3wSuhH2fRSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cBh5L2d6nz24htl;
	Wed, 27 Aug 2025 18:45:42 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 0588B140109;
	Wed, 27 Aug 2025 18:48:40 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (7.185.36.143) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 18:48:39 +0800
Received: from dggpemf500015.china.huawei.com ([7.185.36.143]) by
 dggpemf500015.china.huawei.com ([7.185.36.143]) with mapi id 15.02.1544.011;
 Wed, 27 Aug 2025 18:48:39 +0800
From: "liujian (CE)" <liujian56@huawei.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>
CC: "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
	"sidraya@linux.ibm.com" <sidraya@linux.ibm.com>, "wenjia@linux.ibm.com"
	<wenjia@linux.ibm.com>, "mjambigi@linux.ibm.com" <mjambigi@linux.ibm.com>,
	"tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>,
	"guwen@linux.alibaba.com" <guwen@linux.alibaba.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "guangguan.wang@linux.alibaba.com"
	<guangguan.wang@linux.alibaba.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net] net/smc: fix one NULL pointer dereference in
 smc_ib_is_sg_need_sync()
Thread-Topic: [PATCH net] net/smc: fix one NULL pointer dereference in
 smc_ib_is_sg_need_sync()
Thread-Index: AQHcFmKWx5M9zwvyZkS3sfn5/yfKorR0KFsAgAIq2qA=
Date: Wed, 27 Aug 2025 10:48:39 +0000
Message-ID: <9ae4d764df69431cb77f5c5c32eaa911@huawei.com>
References: <20250826084442.322587-1-liujian56@huawei.com>
 <20250826094138.GA67990@j66a10360.sqa.eu95>
In-Reply-To: <20250826094138.GA67990@j66a10360.sqa.eu95>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: D. Wythe [mailto:alibuda@linux.alibaba.com]
> Sent: Tuesday, August 26, 2025 5:42 PM
> To: liujian (CE) <liujian56@huawei.com>
> Cc: alibuda@linux.alibaba.com; dust.li@linux.alibaba.com;
> sidraya@linux.ibm.com; wenjia@linux.ibm.com; mjambigi@linux.ibm.com;
> tonylu@linux.alibaba.com; guwen@linux.alibaba.com;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org;
> guangguan.wang@linux.alibaba.com; linux-rdma@vger.kernel.org; linux-
> s390@vger.kernel.org; netdev@vger.kernel.org
> Subject: Re: [PATCH net] net/smc: fix one NULL pointer dereference in
> smc_ib_is_sg_need_sync()
>=20
> On Tue, Aug 26, 2025 at 04:44:42PM +0800, Liu Jian wrote:
> > BUG: kernel NULL pointer dereference, address: 00000000000002ec PGD 0
> > P4D 0
> > Oops: Oops: 0000 [#1] SMP PTI
> > CPU: 28 UID: 0 PID: 343 Comm: kworker/28:1 Kdump: loaded Tainted: G
> OE       6.17.0-rc2+ #9 NONE
> > Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE Hardware name:
> QEMU
> > Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> > Workqueue: smc_hs_wq smc_listen_work [smc]
> > RIP: 0010:smc_ib_is_sg_need_sync+0x9e/0xd0 [smc]
> >
> > diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c index
> > 53828833a3f7..85501d2c1f1b 100644
> > --- a/net/smc/smc_ib.c
> > +++ b/net/smc/smc_ib.c
> > @@ -747,6 +747,8 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
> >  		    buf_slot->sgt[lnk->link_idx].nents, i) {
> >  		if (!sg_dma_len(sg))
> >  			break;
> > +		if (!lnk->smcibdev->ibdev->dma_device)
> > +			break;
>=20
> Why check it inside the loop?
Ok, will send v2, move the check outside of loop.
Thanks.


