Return-Path: <linux-rdma+bounces-3274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F85E90D6F3
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 17:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAEB1F2493E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974B132C8C;
	Tue, 18 Jun 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YkSTs6wl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oz7xofKb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B94D5BD
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723583; cv=fail; b=usWOcseXhSzDgWdvX+Aix3Up27KJ7K0s/MyfMuVZN/OepsLYZl/gSl2/txpdNHuXlTWx7CV5/SXW5PcD6e6UOgA5pw1Ak2WF0ohKKLm6/U19PkmOG1psplOII6KYNdv6lH1mVjoucY11w7RjO1hl7EQCFjJkJ0MSomnybjaHv9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723583; c=relaxed/simple;
	bh=49EhQJ48CmIOpEmwucNRMbxQWIiWAfhnQCccW7n8MTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fl/CQdKgLFPze0uwWmFjIgM2pXv/p9GU+eyVWmtVqQZrep5W/KenW4yuZES+R+16mL+hgfrEy7FaXfV/MGI7AqAX1KaxTBNlmtLY74I4C9iyrTZPWMMbfawEzVIGwxg8FTwuKPWR54WVCvqPFyPXaJmkFyRS5gUudokXtXRqgrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YkSTs6wl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oz7xofKb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7tQm7014702;
	Tue, 18 Jun 2024 15:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=aiZjOkXiDu9247a
	myw/UvL4L4r9BtpK/ePCv1/i2+Fc=; b=YkSTs6wlOL+yvPDyipP+tA55OhgxAqJ
	gDGCkNddTQ4RlF1z4xj4g0VkDXcdcaOtUQ+fwccIX7eZ3umfFBOpfYHiWK8FreLj
	Cfx3N8prF4cNT4B/nvrNlOfAK+xdMLsXEdztW6PNDpMpNQ3wa6CFECGhpY8RQPf4
	ua2883wYNhYv9iE5ZRYoNug5SmwQcGB+/8DwU48yZ7u+MDkFfyDz2cPzECq6eVsZ
	DukSCxM8Sy7bFEEuBVfNwp55TYW0FTLNJsFxDmY0ubt5LDdkJ9qtGJ3r99kPa0Dp
	DVFDkhPgDLuXi4hv5rmo7dP8hmzUHEqF7qEowfft4ykGHASM3hs1vZg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1j0577g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 15:12:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IEARSB014903;
	Tue, 18 Jun 2024 15:12:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dea6hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 15:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eebJQhtpaJ2mWwoFNAc5GwmvWX43oTOTRf5TAbUf2JpZnf2eO4jGR0KRfI78r6OVXnDteeppIqc1DJGYLM8XlfKfQEFExiW75JNdEA5cBPyYLfLNbaoBA6yVsNHmhZmb4lXAmOsBEBQr46YZbBYeFE+AOjdJFBpu6HPIYhmFkdbxatAK1USN5ms+J4bI0TFFCTYuaHss2DwZXw7i54acvcDL2dsgqgEnLWLcjzTnRwlrNHsQ9k35DY4rxuG39nOQWkJqIrKm7fy/VW1w3BaDz/zM9EIDeQo6x5QWAsh3WGG1UP3rueYYEJAdLoyzTNGk5IFI0rV5P0tKfKObl/qSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiZjOkXiDu9247amyw/UvL4L4r9BtpK/ePCv1/i2+Fc=;
 b=IgDsQofUAocpgXkvKqZHqwPD2rLP+dfbIPyW6mO+fb9Vmqn/IPSYvZ+aUEuOpU7z2W83vMuPOtbKMQQmD14PhrD7XfxUsRpjVNwSNvkFjBsgfkTEbg95eTP8NfvqwzYXoNONveIcOl6eFaRRVGFaVMBKiL22bHwV/ggBJMEKcThJk/D2bowFBXEwrkcC3RywqNly2gINSjKHM+jyR7sjfhOgZC8rPMbAqJNrX5CKXdZ/skolza5ft16H8kwSk2epWcUv941/80wbtkzJ4ttWx7nlHbGgLpOCxv5gXh7vVKL7gKDXRr6O/jIgY31IK0xicVqYyAD0u2Y/OSBX00k48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiZjOkXiDu9247amyw/UvL4L4r9BtpK/ePCv1/i2+Fc=;
 b=oz7xofKbOvtIyqcVUhGBkjU539qIk92XacgW4EjCkrsM6cJ7SHT0lcI2PeAcgH2eipd75dNfObhTY+H4PsSziZ3wazw+511fkNcgiRtWzIF/vbhgeEMJlJfefLm7OPpOK2ww2m0tdHSIA/fy8s7bzGjIoE3ZhRazPB3BkBCP1j0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6630.namprd10.prod.outlook.com (2603:10b6:303:22f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 15:12:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 15:12:31 +0000
Date: Tue, 18 Jun 2024 11:12:27 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "leonro@nvidia.com" <leonro@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "oren@nvidia.com" <oren@nvidia.com>,
        "israelr@nvidia.com" <israelr@nvidia.com>,
        "maorg@nvidia.com" <maorg@nvidia.com>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        "edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH 5/6] svcrdma: remove the handling of last WQE reached
 event
Message-ID: <ZnGj25vWNgTKh6cz@tissot.1015granger.net>
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-6-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618001034.22681-6-mgurtovoy@nvidia.com>
X-ClientProxiedBy: CH2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:610:5a::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fefe3a1-c055-435d-bbc4-08dc8fa9133a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?af6D4TJ1LGMxqBjH4XFv/gnfwUE1Us3J+ETQgi60IK5KN++Th/KHSdj55RRO?=
 =?us-ascii?Q?f7tCf7I/ax01ygHPmMtV9a1NcjvW2/af8CQ5BzTVADnz/+L6hF0TAPE7uCKY?=
 =?us-ascii?Q?YXMJO2h7DrofRMBe7tBEnJOAVkN4D4nXXQ083Zs6MhkJzs7IbojJreEvXL2C?=
 =?us-ascii?Q?NmJDjy7/XRkExDbgNZloPklSDRi/Qi3tY2viexP73O5jeDP74SqALx0CP9OZ?=
 =?us-ascii?Q?0VtSFVDmcMwVQWLI4ykJWKvAVOL4fcMBvIUkhr/9A+FZvd3ryuaIY7bmGwEx?=
 =?us-ascii?Q?s6mbc/JeeqpYOOgVPbVxNl6aBlRgFxec/LVm00z3rwoDUw0rqLv1p19sbpny?=
 =?us-ascii?Q?CN/8P042E70av+bnFeNWD5jYA0G5rTmJd2SFuFOvbt9By29wgrPsqb5LBaCC?=
 =?us-ascii?Q?Co2H8aKUdhn1QkX82pmVKhEjkLQOgzybo7jlxxriXHNlO5F7JaiUPtAQyB+t?=
 =?us-ascii?Q?P827dxNAlfbOf2tS3TcoeV+fVrHY9bnVwgWSlJJomt0Un8VfG4wltjzv42ve?=
 =?us-ascii?Q?OHoDPTa4tXpBAuWNd4kSxY4WRna1/KPt50tkqulOfDIiV0KGtZAl/PIqFqer?=
 =?us-ascii?Q?Ht0nCk8JPMLVgOvMe44BP/OwHwnTU+VxY0/BXoMj9uUvf+Xc7S+/+8NsVy5j?=
 =?us-ascii?Q?DhPxnYjkrprJw5/E/QMeii6HbT9Sq7mjfi8atpIkGNsn2wgylwpqsY0TYRRK?=
 =?us-ascii?Q?1cb4Wav6wDOLDOJPrplaxttnOR7RnJs+sPWe1cS/kMoejxKdUTwrDqfKzJrS?=
 =?us-ascii?Q?0u0sv12NonK6Fn1pukxXdaQxQ2XcFKtYiqLI+0d4yjSr379Hc1s7Sf2MezSi?=
 =?us-ascii?Q?uOISKQ3fDuU1ftG4hAZ0w0d3MN9fXoHDdHqqJfsqx2GpTlrZWUyFNQmA0rpI?=
 =?us-ascii?Q?dz3i80o4A6XCV7Ri+4DOePmAFaPTlfk0kqxA9DtLDCMBxK5H3bwdB1fNf8wa?=
 =?us-ascii?Q?i3DFnmUZKJ+uBXrs0wC3szdIgmoT5w5Y1BeD8XYTmiiTOcU2ON9CLGWbaapY?=
 =?us-ascii?Q?uCPyrORixMAia+nbQh07ffCWMry0rS+s4x/BFYkADvpzOL1OY0gvGS3Qm/MF?=
 =?us-ascii?Q?+RPr/AQAqwSnJd9z4PmLPfCx4ORTVRKUUFJKAgdFg/BsVCylglNe88iJu1ZF?=
 =?us-ascii?Q?WAGYpvKCAuJabGF3OzrJujTJSu6vHlovtZ1KYlkOwrnJ6S74FqahsQ4ESa0/?=
 =?us-ascii?Q?Hpj7+oQfMQzVLjk8Jdhds9MhdiBH1gsNdDf0sGWD0K0EdhBWt2QZImQXfRz6?=
 =?us-ascii?Q?Kkx/4Cfz/HGptoddBBKQp3SJqCn3s32QjDM8gl20DHviSLVmHO0MlkK58Kau?=
 =?us-ascii?Q?+RRn5MCNduULUZ/7hBNnls0K?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L6uWN8+Dvjtut8xlPamvCh4ms1zJSEu9+xnablyho4X/P1vv97bWwB97LXAe?=
 =?us-ascii?Q?9gvz9JFVhnGwPkFlpf7R6t2dbR71n3MnL7JJRb9qiXEtF8NIxUhgDB0P/jDr?=
 =?us-ascii?Q?sQRSM6/M4b2QNF/46UE2PXdUfvHI5FiqX1L/9QRRmMIuyf2ynbS4jit1ZZTx?=
 =?us-ascii?Q?dyUVAn7Hfj5eFg1eq9KAuj5YFyD9go+CHknXXuwehDbl7tuWWuG36qcNr9Sf?=
 =?us-ascii?Q?pp7Dn6aOieh8eoS6AoTnweVVzg1Gs44I+dwbhpEnM6x1ubwLdkgEU/Gn+ZPv?=
 =?us-ascii?Q?cQzUTb08983s3QzR9XSCtCMfr81qz0zEbIAYGZrHshI4glVs60no65kWGT8u?=
 =?us-ascii?Q?duZf+K00d/cARb15DWZ6KTe2uITBFI1Im1EfYvU9ikKuo1kNhfcFJ2ScMr8/?=
 =?us-ascii?Q?hWtFZShmX/1EdbmFdAyXKQBYtMYPJQfKtek1XTpeTMqkyYD9C4zVIq5Lui6n?=
 =?us-ascii?Q?VARb6vKrtXaYByHa3cGK4dreCgPSkarHB1Qbu4le5d0gLrvZU9UpVenVl59m?=
 =?us-ascii?Q?S1ewgqTL7TuKTMxeN+f4OkxCpR6RsqPAg3O6Jt1DAjZJ0t2CxulFGFlQN8Rl?=
 =?us-ascii?Q?Q+ojTqf+eN+mdt9mXzuiTTUTBSra2w13Ki8tTTComd3cOiII825Y1kPQ4tnS?=
 =?us-ascii?Q?e55b4sU0SQeoMWGCpO+cLpG2c8U0WsnECBij3vSbinUGx3jdgx5S3cCtvssr?=
 =?us-ascii?Q?H9BFKmF0L7UHbq+JvaEvDzFLvvcACRT9xWjukSOjLUgsqdUo8xFADqyDo78S?=
 =?us-ascii?Q?JmWEuF8ViFnBrtodqzDJGHnWdH2wi0JFjdzj1Rv4drjE04j0tSiGwQRARv3M?=
 =?us-ascii?Q?un1qZCibjMrBKbDAhHyCc8rq1nv/uDMAxky5+K5jWefkRxLCv//nqSoTOotQ?=
 =?us-ascii?Q?ebNj/1xX5KrV/zmUszq9Zrpq75eZlQK+iAh5uCjikv9umCbs+a4Mn1biWe9i?=
 =?us-ascii?Q?gOSeQS+zRVhEc9kGXHIIef6/ewj2qDKoZA8V4tdWIy20E/rIpxe9ukaB5sjl?=
 =?us-ascii?Q?+/J9pHGc/7b50+r3uQyv4N3MUhfdbJPCjicuGwcaouzdgfftkffyQGyGMxlY?=
 =?us-ascii?Q?t402EHoyeWBl4hjL8kt7Hilc/1DIg5e0ktigjg1TOxV4hY75yh/Ihi12Ha1b?=
 =?us-ascii?Q?qpxRfEn5K3q+ZNoRhP+XnB4XDIccTwAiwPc9IDxoA090TfIR6PyhkKxfd408?=
 =?us-ascii?Q?5jDgvyyY6XavyKwpFngtTkJHcD8TAVkglOnTtG3dwv1FPjIEyOvbuClP/TGJ?=
 =?us-ascii?Q?3Je4hYhfbcBciRo4+FsSOS8Zby3anv/Bz3O2K9BydYyAZMLXT0xuF5/uasZQ?=
 =?us-ascii?Q?+ACL7RTCmO2DBzIiDi6pd8LgJftmxpjlATZ4OI+yK4buffQbf/8Kq+8ex0vZ?=
 =?us-ascii?Q?bjd2ucfKVUj92TYSlhJELro27n2WQ82eOWh4X7pTgekycEpsUHMi+BCqfU4y?=
 =?us-ascii?Q?Q43rTnw+ZgYdZ42AB6d1sjpjFp8PqyoPkzCV3UghNfx7WPdhiu02Vj2K3N/v?=
 =?us-ascii?Q?t7Ra8i+PBgxHr3u3AWlYh2mSEqytaa/idyXq7Z1MrBgwdrbPywbHsCkbf4pQ?=
 =?us-ascii?Q?efBwpOmio1bCjyexz6kdRX+NaeEZKeeIf9Sg4NWR9256brq9ig6IhTtHjp2F?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rArMgQISAq1zMl8rQ38tP5ngXBXBPUSnCtzR/b7LK6DcmQof0r2As11c2R1CgacNAZH2hAo5cEaCMuNKPlrVOMWEAdShfu8r9Lvc69MV/2uCdVExwqf4yMKjoPZ9zh/zKnN5UcAPc58/nuEF6xDszoFldIZlJKh7wsJThgD+lyuauN1x9oDrp23W0ZudzE/eoq1pqLZOKEevSQFqU8w6TQ/oaxxc5KHJ5tv4bqnCC1TovDkanaHKY+bxjp4XDqphPtMaM9SPCY1e9LOIRM3IV/xFsYkxLb75FaDy4Ka2rCv5iQN/f18QFwTNylXxXeCKyujZfuAQOOndjIS5CwTMJi0LOqVYpIf5JElwxkgMw2PenrrQtcJ0Bg67cMZhsfIzsGDDn3YCBkpTvLzwKiSCPOatyhssBz30dd52gurB0TJRzHJdWt5sTmT0OUs45x93p+ZeyLYUgRMpqmsWb605HZ/zRIX7054DDzLu8FMLrNh6o5E+DdrgyGDdYaUth9yfUnMWiwgQ/bYkEKM2kFNXFSDVPIo/mWvDKRt4t7v68yoIKxCfWu4xIlGf6G0EG6yi5E+RtBJ1bM1jYbp8vwdnoBll8oFvsOpJQpuKvRX1VLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fefe3a1-c055-435d-bbc4-08dc8fa9133a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:12:31.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNiFJSys319bgjXMDeC3303heefEWKGG/KfwQs+NXNEd5M7W/OoyUV2PFqhXPQFo/qYajtrV9Q62ck9UGvzaZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180113
X-Proofpoint-GUID: iBrrlssLk9wz64DrlUHdfyxEVkXqt_9t
X-Proofpoint-ORIG-GUID: iBrrlssLk9wz64DrlUHdfyxEVkXqt_9t

On Mon, Jun 17, 2024 at 08:10:33PM -0400, Max Gurtovoy wrote:
> This event is handled by the RDMA core layer.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 2b1c16b9547d..4bb94b02c34c 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -107,7 +107,6 @@ static void qp_event_handler(struct ib_event *event, void *context)
>  	case IB_EVENT_PATH_MIG:
>  	case IB_EVENT_COMM_EST:
>  	case IB_EVENT_SQ_DRAINED:
> -	case IB_EVENT_QP_LAST_WQE_REACHED:
>  		break;
>  
>  	/* These are considered fatal events */
> -- 
> 2.18.1
> 

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

