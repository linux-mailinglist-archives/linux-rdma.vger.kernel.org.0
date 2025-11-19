Return-Path: <linux-rdma+bounces-14608-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB54AC6C53B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 03:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CD6535A220
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 02:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B7625A2A2;
	Wed, 19 Nov 2025 02:03:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5EB2566F7
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517835; cv=none; b=iosB0CfJVEvky0d4FMGc+evFegg1gc6Fvx5QWEpGJZ1m20U2Z+x96WoD3sk4SZCzrFWAYXJa3Bzi18+OzfzvweAUI01ena3VUfYQmwPDmADChjchkOcfYp/93PW01aRgZ6+69V30g+RBBw3+zLeXGCCoqMELPOlMzWWnAVRGF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517835; c=relaxed/simple;
	bh=5gzUI346GV4rn1suTYqn3N6OMvjSPKMSxEmu9AuaBT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pW0YO8c30zH5fD65QFOWdJzcrYqYfBGwwYbbyMj0wcCT4gogKKVADiBL7gaJ3myb1rHuWMcAnZSN/pOzqgNCOrnlhjBNtupZ7zloECIffrsBRSRwDsjb1X7k6VO4IImuS8JZTHMVGv21sfydR1SFwvtWFE6FpQYBLdPCaYuwXvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, "huangjunxian6@hisilicon.com"
	<huangjunxian6@hisilicon.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [????] Re: [PATCH][v2] RDMA/core: Prevent soft lockup during
 large user memory region cleanup
Thread-Topic: [????] Re: [PATCH][v2] RDMA/core: Prevent soft lockup during
 large user memory region cleanup
Thread-Index: AQHcVINZYLa5twxwjECtSFjMAFPff7T2pWMAgAKUKyA=
Date: Wed, 19 Nov 2025 02:03:20 +0000
Message-ID: <02011baf337649f6997166f223417417@baidu.com>
References: <20251113095317.2628-1-lirongqing@baidu.com>
 <20251117174738.GE17968@ziepe.ca>
In-Reply-To: <20251117174738.GE17968@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
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
X-FEAS-Client-IP: 172.31.3.13
X-FE-Policy-ID: 52:10:53:SYSTEM

> > Fix soft lockup issues by incorporating cond_resched() calls within
> > __ib_umem_release(), and this SG entries are typically grouped in 2MB
> > chunks on x86_64, adding cond_resched() should has minimal
> performance
> > impact.
>=20
> This is not true, I think this should have been more careful to only resc=
hed
> after larger groupings.. How much slower did you make normal 4k unpins??
>=20
> Jason


I don't see this as a issue for several reasons. First, this code path is n=
ot performance-critical. Second, the number of cond_resched calls added by =
this modification is identical to what was introduced in commit 928da37a229=
f3444, which has never been reported to cause any problems. Third, as seen =
in commit 16c610162d1f1c, the cond_resched call rate was reduced to once ev=
ery 16 packets - our current frequency remains well below this commit.

When I have access to the appropriate hardware, I will collect performance =
data for further analysis. Alternatively, if this is considered problematic=
, someone could collaborate on optimizing these two cond_resched in umem.c =
calls together.

Thanks

-Li

