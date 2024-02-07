Return-Path: <linux-rdma+bounces-938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142784C294
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 03:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2CD1F24DDF
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 02:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87155382;
	Wed,  7 Feb 2024 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="TEVWd8Xd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A1FBE9
	for <linux-rdma@vger.kernel.org>; Wed,  7 Feb 2024 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707273790; cv=fail; b=q+4v518zxZkKfITniPcsD3tab/V5j3NGF/EBKJNaSzXx7tcewBMz1S6tJGnGAWEYhnv7TlK1/Z7JyHdP8RHJNeT3OIMKuQqmAMgDuYxJTXrPHYzeTdi9dbg9RDLRqpYYoaRkNd3f5HDkCSmws+iGQN/QqCIrMDwQ/owCOhvNudg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707273790; c=relaxed/simple;
	bh=9nMn25kfNLY/GhqbQFOy0AvBRmZqdyR4KbQ7ApO0UnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WkUx8eFpND6cFAjY9jQ7EPArXuJtCeGu/YXMyPjvnhi7PAyH6iDpvYjw/zNBVf+eGFNNU1fEjrDkaOh6jbSepdvrjb/DQLUBS24pts4WHW/IpL1stdVSMVU1o51aK0m2xVZrw4yhpGDf02L6vpL7y/XhAL4z0flV89bvTwp9RyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=TEVWd8Xd; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4172cR5T021114;
	Tue, 6 Feb 2024 18:42:52 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w3qsx2fr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 18:42:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsYjMQ0cPW9z8/CDWjzVxBT8frHjR0/Wb8xZtM1aW23e902Uhzq8Jb5ch/IuNILTKbdtvvqQ5lahU+Kitc2NttuhMejz3/Wa1CNyKkj/QvV3GeA36f2fK7ykjVd10ZLz+PMBA5naXDy/0v38JfFcLQgCzL6VyZo4EA3k1+FP06GiPzMgCHJykTrGkH7GQdEda5cb6bSDN7IG6I4a3MOvrJRM9eATGUaLne1r1lkzmYveTDSB8tN0kxgN7m6HD1Q+q1iWLbW6LkIptBCDmMAPLNLo2qd/LZumR42gQ7PZWBrz+SIKyTqfnBjYSUiiLeJOZjJ0YfarCJf/5k4JZ/9bcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLzfKLSInOF8ovCdHRCE3mkMC0xSzXx1HpczIMpUlEI=;
 b=gjXi7oHoDsPORp4VtZQ9wPQuiF/TjfxdE+qHOod7hmNpfgEA9KCwRHt/Hj0S0DDV/Sx3+kBko9fTB6WQEpVj44yp+MBVp1uRhD46OysEgFqd+ZKwpmwby5mEPFx7SHR+HWzyRHrchZ6C/V1wLzqkCB3Qpy783X19uKH4Au0BREnFequllY4KW72Mi09va4hOuQL2GOGLWbfEDK+nKzJJnnprlX57IO3dOcbk0DECAq1L//6r9+j1sP8TzOriMGO7KmsNjYF4ilDe8dWGCXGRzJLKein5oauwfh+a7y3o94T37Yt9bEv4SAmcSenbCptUwSH+wPhz2JivC+y6aDctlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLzfKLSInOF8ovCdHRCE3mkMC0xSzXx1HpczIMpUlEI=;
 b=TEVWd8XddxhRCDBp2xHcspTdkeueda9y2DE/BB1sSrPtw05z/th5p/r6dFj63aGdsL2dLLm2g+474G50jJkYzvzI6mBc0qeplhPMRk+iX6rjHChQaXuXpTJT6+niWnwb1Elnr1Vn9ZyWHcX2G1y5JPHfZ3OGybbrY2hW67gpC3M=
Received: from SJ0PR18MB3900.namprd18.prod.outlook.com (2603:10b6:a03:2e4::9)
 by PH0PR18MB5250.namprd18.prod.outlook.com (2603:10b6:510:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 02:42:47 +0000
Received: from SJ0PR18MB3900.namprd18.prod.outlook.com
 ([fe80::583:9edd:5fc9:922b]) by SJ0PR18MB3900.namprd18.prod.outlook.com
 ([fe80::583:9edd:5fc9:922b%3]) with mapi id 15.20.7249.027; Wed, 7 Feb 2024
 02:42:47 +0000
From: Alok Prasad <palok@marvell.com>
To: Kamal Heib <kheib@redhat.com>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michal
 Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [EXT] [PATCH for-rc] RDMA/qedr: Fix qedr_create_user_qp error
 flow
Thread-Topic: [EXT] [PATCH for-rc] RDMA/qedr: Fix qedr_create_user_qp error
 flow
Thread-Index: AQHaWSWlXSZr/VJ61EGybFLC0VNFYbD+LB3A
Date: Wed, 7 Feb 2024 02:42:46 +0000
Message-ID: 
 <SJ0PR18MB3900DCF73AB62C4AA839DD94A1452@SJ0PR18MB3900.namprd18.prod.outlook.com>
References: <20240206175449.1778317-1-kheib@redhat.com>
In-Reply-To: <20240206175449.1778317-1-kheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGFsb2tcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy05MDgyM2EwNy1jNTYyLTExZWUtYWRjNy05NGU3MGI2?=
 =?us-ascii?Q?NjZkMTJcYW1lLXRlc3RcOTA4MjNhMDktYzU2Mi0xMWVlLWFkYzctOTRlNzBi?=
 =?us-ascii?Q?NjY2ZDEyYm9keS50eHQiIHN6PSIxMTA4NiIgdD0iMTMzNTE3NDczNjM0NzQy?=
 =?us-ascii?Q?NzY2IiBoPSIzZGVONDFaL3VzMTY2djY2bW92Ump3eUh0bzA9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCZ1dBQUR1?=
 =?us-ascii?Q?Y1U1VGIxbmFBY1dZRTVySm5iRWp4WmdUbXNtZHNTTVpBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUEzZzhBQURvR0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQTlSZW5Md0NBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJs?=
 =?us-ascii?Q?QUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFB?=
 =?us-ascii?Q?RzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFBeUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01B?=
 =?us-ascii?Q?ZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtB?=
 =?us-ascii?Q?SE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFY?=
 =?us-ascii?Q?d0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3?=
 =?us-ascii?Q?QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?UUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFC?=
 =?us-ascii?Q?ekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6QUd3?=
 =?us-ascii?Q?QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0FaUUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFI?=
 =?us-ascii?Q?UUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJ?=
 =?us-ascii?Q?QVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUNRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?YmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhB?=
 =?us-ascii?Q?R3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFY?=
 =?us-ascii?Q?d0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNn?=
 =?us-ascii?Q?QnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlB?=
 =?us-ascii?Q?QUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3QnNB?=
 =?us-ascii?Q?R1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdCdkFH?=
 =?us-ascii?Q?UUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdr?=
 =?us-ascii?Q?QVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0Jo?=
 =?us-ascii?Q?QUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FY?=
 =?us-ascii?Q?d0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3Qm5B?=
 =?us-ascii?Q?R3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0Jm?=
 =?us-ascii?Q?QUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFi?=
 =?us-ascii?Q?QUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFB?=
 =?us-ascii?Q?QUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElB?=
 =?us-ascii?Q?YndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRBQnlB?=
 =?us-ascii?Q?R2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3?=
 =?us-ascii?Q?QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFIVUFj?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBT2dZQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQUFBQWFCZ0FBR1FBQUFCZ0FB?=
x-dg-reffive: 
 =?us-ascii?Q?QUFBQUFBQVlRQmtBR1FBY2dCbEFITUFjd0FBQUNRQUFBQUNBQUFBWXdCMUFI?=
 =?us-ascii?Q?TUFkQUJ2QUcwQVh3QndBR1VBY2dCekFHOEFiZ0FBQUM0QUFBQUFBQUFBWXdC?=
 =?us-ascii?Q?MUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0IxQUcwQVlnQmxBSElB?=
 =?us-ascii?Q?QUFBd0FBQUFBQUFBQUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QmtB?=
 =?us-ascii?Q?R0VBY3dCb0FGOEFkZ0F3QURJQUFBQXdBQUFBQUFBQUFHTUFkUUJ6QUhRQWJ3?=
 =?us-ascii?Q?QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhBY2dCa0FITUFBQUErQUFB?=
 =?us-ascii?Q?QUFBQUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCdUFHOEFaQUJs?=
 =?us-ascii?Q?QUd3QWFRQnRBR2tBZEFCbEFISUFYd0IyQURBQU1nQUFBRElBQUFBQUFBQUFZ?=
 =?us-ascii?Q?d0IxQUhNQWRBQnZBRzBBWHdCekFITUFiZ0JmQUhNQWNBQmhBR01BWlFCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQVBnQUFBQUFBQUFCa0FHd0FjQUJmQUhNQWF3QjVBSEFBWlFC?=
 =?us-ascii?Q?ZkFHTUFhQUJoQUhRQVh3QnRBR1VBY3dCekFHRUFad0JsQUY4QWRnQXdBRElB?=
 =?us-ascii?Q?QUFBMkFBQUFBQUFBQUdRQWJBQndBRjhBY3dCc0FHRUFZd0JyQUY4QVl3Qm9B?=
 =?us-ascii?Q?R0VBZEFCZkFHMEFaUUJ6QUhNQVlRQm5BR1VBQUFBNEFBQUFBQUFBQUdRQWJB?=
 =?us-ascii?Q?QndBRjhBZEFCbEFHRUFiUUJ6QUY4QWJ3QnVBR1VBWkFCeUFHa0FkZ0JsQUY4?=
 =?us-ascii?Q?QVpnQnBBR3dBWlFBQUFDUUFBQUFKQUFBQVpRQnRBR0VBYVFCc0FGOEFZUUJr?=
 =?us-ascii?Q?QUdRQWNnQmxBSE1BY3dBQUFGZ0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FY?=
 =?us-ascii?Q?d0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFH?=
 =?us-ascii?Q?NEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFC?=
 =?us-ascii?Q?VUFBQUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5QUc4QWFnQmxBR01B?=
 =?us-ascii?Q?ZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxB?=
 =?us-ascii?Q?R1FBWHdCaEFHd0Fid0J1QUdVQUFBQmFBQUFBQUFBQUFHMEFZUUJ5QUhZQVpR?=
 =?us-ascii?Q?QnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJ?=
 =?us-ascii?Q?QVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJs?=
 =?us-ascii?Q?QUhNQUFBQWdBQUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCaEFISUFi?=
 =?us-ascii?Q?UUFBQUNZQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR2NBYndCdkFH?=
 =?us-ascii?Q?Y0FiQUJsQUFBQU5BQUFBQUFBQUFCdEFHRUFj?=
x-dg-refsix: 
 =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBR01BYndCa0FH?=
 =?us-ascii?Q?VUFjd0FBQUQ0QUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdrQVl3QjBBQUFB?=
 =?us-ascii?Q?WGdBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxB?=
 =?us-ascii?Q?R01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdVQWJn?=
 =?us-ascii?Q?QjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFHd0FBQUFBQUFB?=
 =?us-ascii?Q?QWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1?=
 =?us-ascii?Q?QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFi?=
 =?us-ascii?Q?QUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3QmhBSElBYlFBQUFI?=
 =?us-ascii?Q?SUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFC?=
 =?us-ascii?Q?akFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRB?=
 =?us-ascii?Q?ZEFCcEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5B?=
 =?us-ascii?Q?RzhBYndCbkFHd0FaUUFBQUZvQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdV?=
 =?us-ascii?Q?QWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFB?=
 =?us-ascii?Q?QUdnQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0Fa?=
 =?us-ascii?Q?UUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdVQWN3QjBBSElBYVFCakFI?=
 =?us-ascii?Q?UUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZBR0VBY2dC?=
 =?us-ascii?Q?dEFBQUFLZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWRBQmxBSElB?=
 =?us-ascii?Q?YlFCcEFHNEFkUUJ6QUFBQUlnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNB?=
 =?us-ascii?Q?RjhBZHdCdkFISUFaQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB3900:EE_|PH0PR18MB5250:EE_
x-ms-office365-filtering-correlation-id: b3771d71-3f5f-4c7d-818b-08dc278677de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SV5B+44K36VVCbegnXPL8Oc8BeOWm1Z0m8cc74BqnIDWu+3ICuq+FRh44ulHuv76No7nUi+pDrLCjKL1LnFW2+QDPqNqUtOmpG2iagxNGcUS5EXve9iV7XtN3fAPMlPpBv2NVtL83Cd3LhC8r9gav4FnHxeEVdWBa1sLA769wKf6gQ8YLichS2tu0n7MtM+8xeOe3tDyq/x6Afv2+9nxvXUnBuaZyiNh5X1qGNezZURdabPeDc0uHmaCa8h7I4pEbAJaXN939xBQn/ptRSsHoywm5O1TQdPgFoGNx0Ed6gltj/TNMbKJfePMeQA9J3Aoz/Q44hyZFmc0EgUUHC2PB8TVWQz26DAWAhTSsLQ3yxIZZQGt1NrO/WX4ot43gOfdaCcI3vxVtr4p3BGRgGX3QjNR0jw5YWB6QJHPrB0Dk7oGjjw2szQz6rfqz/Z7svk6RDYNh+C3DRRarq387uAVClozjjkfXqUjXznsxmJXAcgSKZiY5qWOfSjV1mL9Oq5KPHhEoTSbNpWN7K94fPdYty0H9PymM85Qk8ZQ0IYWJBtf4hkyozYpfGs+7abwCmmR4Dlo+VdU5NOzAIWXK43qXiRzWofzwG9eZGWvjHiT3h0gfb1pz36ThXHP4x/d5ORK
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3900.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(33656002)(86362001)(66446008)(53546011)(52536014)(76116006)(110136005)(45080400002)(66946007)(66476007)(54906003)(66556008)(5660300002)(8676002)(4326008)(478600001)(8936002)(7696005)(83380400001)(9686003)(71200400001)(107886003)(2906002)(6506007)(122000001)(26005)(316002)(38100700002)(64756008)(38070700009)(55016003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ygLMGihMRb7ndBd5bshuFUKBns92WkQXK/m9+d9sPG994SOFG5vw1n5V9/ug?=
 =?us-ascii?Q?idEgcFYD3I0FwDzCxoJORFPzLFwsooXp1TlmhKKtBE1Jgu/3B86/2nRBYXWV?=
 =?us-ascii?Q?cnDC++Y6Lu3Z6aTpGFarbsMLCekZx48ub2QFy8B7jMOzn47popKdcC0zfehj?=
 =?us-ascii?Q?WxK7LXcWxmaYwzxiOwzdSw1+RwY3SrcauCkY8RbRj5fq0254DLFyZEXGoyxR?=
 =?us-ascii?Q?E9QEpuLoXgsWpqx2VLJG1NDL8dQhlUxB7uyBT42Qf4h2zCFYlCkawxS3wgVt?=
 =?us-ascii?Q?sQXDjZHvxJSBj+37Tx/U/u52cjp1g2TVMXfDzPg4tFm9ueKwVQY94c2HEIih?=
 =?us-ascii?Q?WYiaengfRBh+Sd3YGKLweaqcMDTCXo35Cx5g0A/LAKgD5E5g2ZdNLyRQ8Lkc?=
 =?us-ascii?Q?sV4zVFZkXLU0u8Pf0K8DY+GxRGtKPvqhWOGaiGSrf8TlH3RZf4vUdEoQYdr2?=
 =?us-ascii?Q?Fv8M2X/nfkEKoVbKDuvj745X+ms75ZL9PC8VPgUjoEOg2de5xe6E34sLyHv7?=
 =?us-ascii?Q?epCoPkH+NZE6JLLsMdAuljQv4dHX8GaHC6GbhCBqw2SVO5fCEEmBytEKoGgA?=
 =?us-ascii?Q?jldtSRas+JhlmIxKfW9UzR+J3EhlI+Ily5hKimcY1bHA3ZNQ2o1d2+4tKVz+?=
 =?us-ascii?Q?zYwJSCwcOkq7vVwsCkNkJBqgWcBQk5l5gYVPg3LEVUs1J4YQMv3sTv8AWjby?=
 =?us-ascii?Q?qbi9nKDJHzvTlWzmF1aTmBGWvT5H0aBcEClB5Ud58rEAWeeAX5jWoNc8KP81?=
 =?us-ascii?Q?1/sOtY+izXeI8nM/AWu9wV6AoXmzfZpkzlRdiKV+QlsO+lOZqxyKPhA9oUBg?=
 =?us-ascii?Q?ee6r2OMEO7TyaPsgVsPP2zJ2gMUwjppY8Mf45lIQkuprcWQa4QHpLjaxpd0s?=
 =?us-ascii?Q?kNVjaTHxs/JMiH8l2RunsbBpdofnUipPzLm7M3W0FAzOwpRaIAstulmyUAXI?=
 =?us-ascii?Q?e7OcnwjRGCqWdQSIwSuRT/RlPi5kNOVlXisYrxJu8WhZOIa8204h0oKcKY9Y?=
 =?us-ascii?Q?/C0SF31LOuHMJkj55+lOlDUHc6ku0kLSlvCuah5IAhM7RRv7K4xwgBYL3N/K?=
 =?us-ascii?Q?bV9P50jwm6x5Jl7t6np2lOWTsjR/wMnrStnBveNAHwrdoecLMv6Q4YwmpVz4?=
 =?us-ascii?Q?pnbn+YupTX2a2WqbxTNxD+c1EOzl5OLJqsRmhqB2y7i6lJi1i3GNW+qUW0WG?=
 =?us-ascii?Q?QnNlljih13fRNVHnp2YkPMTBS8sPhCfERlnxc60iFh9XZfi9fbftA1IG5y41?=
 =?us-ascii?Q?BiWHhUuMpvvSlZjW1IzRigN3HchQcu9TXuQKMRSafh/K0DLDosrEEkDWtxKF?=
 =?us-ascii?Q?aL4n5x2EbyFzztSXlSsIzBBJt6fYtjuy1k/hYVwBvy1PeM2l5wRz7a/yejsU?=
 =?us-ascii?Q?+1dVst27uu2rAMTiKFEfFHhNgUK7RZ4WgPeV21vlJ551EsMiDc1ZF3wiG7BT?=
 =?us-ascii?Q?VXQg4KSteqWfuswUx6iEJWkRkgHhu8HatPvPFbqdYrqMp4XNKBkfy0iNHDyY?=
 =?us-ascii?Q?/s5Uimyv5DQ/cESJRul7cvmC2CAU6xzNuGMEIs/4xrSxJTnQuLBJ8rzvb+P/?=
 =?us-ascii?Q?gKQbKCmIQ8aiSpoGxBoQA9OyZ8Y5G3id/96+hs8e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3900.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3771d71-3f5f-4c7d-818b-08dc278677de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 02:42:46.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yaN8FoaQYc3hHWcog5uKRcMtlhT/uhm6DxVbkAsRoLJRJemKXOnF/d5ah4Owu8x0nMSymCRrbgkWOGI/dQ0PZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5250
X-Proofpoint-ORIG-GUID: -wQpFqGFEl7RFufqhnuZ0SVcVOUw9o4f
X-Proofpoint-GUID: -wQpFqGFEl7RFufqhnuZ0SVcVOUw9o4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02

> -----Original Message-----
> From: Kamal Heib <kheib@redhat.com>
> Sent: Tuesday, February 6, 2024 11:25 PM
> To: linux-rdma@vger.kernel.org
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>; Mi=
chal Kalderon <mkalderon@marvell.com>; Ariel Elior
> <aelior@marvell.com>; Kamal Heib <kheib@redhat.com>
> Subject: [EXT] [PATCH for-rc] RDMA/qedr: Fix qedr_create_user_qp error fl=
ow
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Avoid the following warning by making sure to call qedr_cleanup_user()
> in case qedr_init_user_queue() failed.
>=20
> -----------[ cut here ]-----------
> WARNING: CPU: 0 PID: 143192 at drivers/infiniband/core/rdma_core.c:874 uv=
erbs_destroy_ufile_hw+0xcf/0xf0 [ib_uverbs]
> Modules linked in: tls target_core_user uio target_core_pscsi target_core=
_file target_core_iblock ib_srpt ib_srp scsi_transport_srp nfsd
> nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fs=
cache netfs 8021q garp mrp stp llc ext4 mbcache jbd2 opa_vnic
> ib_umad ib_ipoib sunrpc rdma_ucm ib_isert iscsi_target_mod target_core_mo=
d ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm
> hfi1 intel_rapl_msr intel_rapl_common mgag200 qedr sb_edac drm_shmem_help=
er rdmavt x86_pkg_temp_thermal drm_kms_helper
> intel_powerclamp ib_uverbs coretemp i2c_algo_bit kvm_intel dell_wmi_descr=
iptor ipmi_ssif sparse_keymap kvm ib_core rfkill syscopyarea
> sysfillrect video sysimgblt irqbypass ipmi_si ipmi_devintf fb_sys_fops ra=
pl iTCO_wdt mxm_wmi iTCO_vendor_support intel_cstate pcspkr
> dcdbas intel_uncore ipmi_msghandler lpc_ich acpi_power_meter mei_me mei f=
use drm xfs libcrc32c qede sd_mod ahci libahci t10_pi sg
> crct10dif_pclmul crc32_pclmul crc32c_intel qed libata tg3
> ghash_clmulni_intel megaraid_sas crc8 wmi [last unloaded: ib_srpt]
> CPU: 0 PID: 143192 Comm: fi_rdm_tagged_p Kdump: loaded Not tainted 5.14.0=
-408.el9.x86_64 #1
> Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 2.14.0 01/25/2022
> RIP: 0010:uverbs_destroy_ufile_hw+0xcf/0xf0 [ib_uverbs]
> Code: 5d 41 5c 41 5d 41 5e e9 0f 26 1b dd 48 89 df e8 67 6a ff ff 49 8b 8=
6 10 01 00 00 48 85 c0 74 9c 4c 89 e7 e8 83 c0 cb dd eb 92
> <0f> 0b eb be 0f 0b be 04 00 00 00 48 89 df e8 8e f5 ff ff e9 6d ff
> RSP: 0018:ffffb7c6cadfbc60 EFLAGS: 00010286
> RAX: ffff8f0889ee3f60 RBX: ffff8f088c1a5200 RCX: 00000000802a0016
> RDX: 00000000802a0017 RSI: 0000000000000001 RDI: ffff8f0880042600
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: ffff8f11fffd5000 R11: 0000000000039000 R12: ffff8f0d5b36cd80
> R13: ffff8f088c1a5250 R14: ffff8f1206d91000 R15: 0000000000000000
> FS: 0000000000000000(0000) GS:ffff8f11d7c00000(0000) knlGS:00000000000000=
00
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000147069200e20 CR3: 00000001c7210002 CR4: 00000000001706f0
> Call Trace:
> <TASK>
> ? show_trace_log_lvl+0x1c4/0x2df
> ? show_trace_log_lvl+0x1c4/0x2df
> ? ib_uverbs_close+0x1f/0xb0 [ib_uverbs]
> ? uverbs_destroy_ufile_hw+0xcf/0xf0 [ib_uverbs]
> ? __warn+0x81/0x110
> ? uverbs_destroy_ufile_hw+0xcf/0xf0 [ib_uverbs]
> ? report_bug+0x10a/0x140
> ? handle_bug+0x3c/0x70
> ? exc_invalid_op+0x14/0x70
> ? asm_exc_invalid_op+0x16/0x20
> ? uverbs_destroy_ufile_hw+0xcf/0xf0 [ib_uverbs]
> ib_uverbs_close+0x1f/0xb0 [ib_uverbs]
> __fput+0x94/0x250
> task_work_run+0x5c/0x90
> do_exit+0x270/0x4a0
> do_group_exit+0x2d/0x90
> get_signal+0x87c/0x8c0
> arch_do_signal_or_restart+0x25/0x100
> ? ib_uverbs_ioctl+0xc2/0x110 [ib_uverbs]
> exit_to_user_mode_loop+0x9c/0x130
> exit_to_user_mode_prepare+0xb6/0x100
> syscall_exit_to_user_mode+0x12/0x40
> do_syscall_64+0x69/0x90
> ? syscall_exit_work+0x103/0x130
> ? syscall_exit_to_user_mode+0x22/0x40
> ? do_syscall_64+0x69/0x90
> ? syscall_exit_work+0x103/0x130
> ? syscall_exit_to_user_mode+0x22/0x40
> ? do_syscall_64+0x69/0x90
> ? do_syscall_64+0x69/0x90
> ? common_interrupt+0x43/0xa0
> entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x1470abe3ec6b
> Code: Unable to access opcode bytes at RIP 0x1470abe3ec41.
> RSP: 002b:00007fff13ce9108 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: fffffffffffffffc RBX: 00007fff13ce9218 RCX: 00001470abe3ec6b
> RDX: 00007fff13ce9200 RSI: 00000000c0181b01 RDI: 0000000000000004
> RBP: 00007fff13ce91e0 R08: 0000558d9655da10 R09: 0000558d9655dd00
> R10: 00007fff13ce95c0 R11: 0000000000000246 R12: 00007fff13ce9358
> R13: 0000000000000013 R14: 0000558d9655db50 R15: 00007fff13ce9470
> </TASK>
> --[ end trace 888a9b92e04c5c97 ]--
>=20
> Fixes: df15856132bc ("RDMA/qedr: restructure functions that create/destro=
y QPs")
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/q=
edr/verbs.c
> index 7887a6786ed4..0943abd4de27 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -1880,7 +1880,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev=
,
>  		rc =3D qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
>  					  ureq.rq_len, true, 0, alloc_and_init);
>  		if (rc)
> -			return rc;
> +			goto err1;
>  	}
>=20
>  	memset(&in_params, 0, sizeof(in_params));
> --
> 2.43.0
>=20

Thanks for fixing it.

Acked-by: Alok Prasad <palok@marvell.com>

