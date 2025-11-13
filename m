Return-Path: <linux-rdma+bounces-14455-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD6C560B9
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 08:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B27833458C0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 07:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C44322740;
	Thu, 13 Nov 2025 07:26:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0526E703
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018780; cv=none; b=eM+PWeb1NI7Xp6kPrQMKwpPg174+er8LyWMP+6s0fxYYGzvFyKWma1rCRUnY1+DNbPPP5sWdaytpCBugMaphiJdfnIBZI7eTZap2hDsmdW+fdZGaHUj9dYcuptDIi1HdF/NzKpYDZU+HFrmj42yBi7hPX1X1/OwarryLbYvXzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018780; c=relaxed/simple;
	bh=ZWMlLOiOczqtncEJNimB/h6YXggrduJt+hsdviU2L5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YB8y5jKqYzLjG2wtOJ+rwInV+3vCRTZ5ikvpjHuglGe+wHMkHbZjMK3jb+m1ZslLy8jdmZeWl4S3pqVvErCToRDOzt/7/FuzSny3e9Fz2kJ/fh5hbfZRjGRWkJtd4yeqJS1+7dqIt0itdC1/i1negTrd/YDpwdOWlgFnmFId2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [????] Re: [????] Re: [PATCH] RDMA/core: Prevent soft lockup
 during large user memory region cleanup
Thread-Topic: [????] Re: [????] Re: [PATCH] RDMA/core: Prevent soft lockup
 during large user memory region cleanup
Thread-Index: AQHcUtj831ZC0pfzsEqn3ZVqQ3Xs+LTs2g0AgACGXmCAATJ7gIABpL9Q
Date: Thu, 13 Nov 2025 07:25:57 +0000
Message-ID: <7d7f66445da0443280c787cfdc243a22@baidu.com>
References: <20251111070107.2627-1-lirongqing@baidu.com>
 <20251111120136.GP15456@unreal> <5a9e07930f134ff283d4a65373a62b85@baidu.com>
 <20251112141927.GE17382@unreal>
In-Reply-To: <20251112141927.GE17382@unreal>
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
X-FEAS-Client-IP: 172.31.50.46
X-FE-Policy-ID: 52:10:53:SYSTEM

> > A user meet this lockup issue on ubuntu 22.04 kernel, after change
> watchdog_thresh to 60, the soft lockup is disappeared.
> >
> > I think his program registered too many memory region(this program has
> 400G memory), but the lockup should be fixed too.
>=20
> So please add this information to next version together with change propo=
sed
> by Junxian.
>=20

Ok, I will send v2

Thanks

-Li


