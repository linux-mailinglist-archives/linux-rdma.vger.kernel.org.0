Return-Path: <linux-rdma+bounces-21955-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6TWgLTK3JmrobgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21955-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 14:36:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2E2656395
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 14:36:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=jkf5upZ1;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=BR58kOXs;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21955-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21955-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8654C3054E90
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 12:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C2D379C4A;
	Mon,  8 Jun 2026 12:25:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB021E097;
	Mon,  8 Jun 2026 12:25:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921543; cv=fail; b=OPsb/XUAOrkZnJoN2A7R2JWwIBj22bGuk4JPpcmQfFvvuo9KtExsWlRNyepZ6SsiJTHJJr6mOgrfCb9unhuaszXtYBQxJ9taJ70EhOM6jTMwMBPgKifphtZaQMcIHw+uUhQJJNZ9AhGqKXqlMxD7PU5lcnpWLBiWihdXJOJsxH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921543; c=relaxed/simple;
	bh=mSvGWMI6WhzIFwPZawtKv/KSFx84hUP6XzCzep28/Do=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PAPexiw3F55c6mtPLx+s3iCbpgFWMyvh/o7UXafcUB/5xsLV4YEADeXonMcR8AgNmLxmVuoGTSWMMVxjHNEmGMsFBpKoJKAIdR+fDjHLWAwVupbjdEZ1qnTIOrr7c73QlAYg1jiX8qTwyGZJCRGUVOC3lDAb60WT8WKM76IpVUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jkf5upZ1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BR58kOXs; arc=fail smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6588Orms3034841;
	Mon, 8 Jun 2026 12:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mSvGWMI6WhzIFwPZawtKv/KSFx84hUP6XzCzep28/Do=; b=
	jkf5upZ1QtVe0VaYtCVhEo95UbJg3wINL5g2zjXr490onHRDcZvxRNVWZj76StWM
	BPsCcDqSPbgtetbK8YbXTbBw5Q5GUF2Q+01ttjFi/9BscDmVQLWsZGRXHwqb/7O2
	YCSAo7lv7YZZPeI2zQF34A7z0ROM9yYZk+ySxRv5yrWdNcf4WCojmV7QFdCyyVIL
	XZ73349XfOeqiZDqewOBESv8jDeEhOwcy01rLLHBmqyJ/0RKh7Ha/0rxRfMuk/pe
	RNa5uOK5AZaPMin+L53RvXo0uTK3WMOgXhEdVOYUNs+f1lzjMwHTBUCbWWJvny4B
	bR+Q/l+3RaN0Fj5ooCN8hg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4embkjabgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 12:25:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 658CNVj2010389;
	Mon, 8 Jun 2026 12:25:37 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0nqxar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 12:25:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EA6w57ZfpiQOh5srPBz5EaRT/G8ndAWXoC6mkIan54ffBZAn7GiHn77rBi//91m0nP9WIBWDzjQ1iIX3iiZg2G1oWQKZ6mmtd7kzIHL2y6+qWeOw2bUXv9rNbPpWGagaW9MVlOjEkIa2u/wC55cNNHnz5OiEnEXDqR5zZLoGdstrSR7V5yKXGZGo28GHc9zr45is9DkNJVBdFm+P7Dc4mZvdySr//qYvbEBHIqXJNsBN/oK3EmcFvpF//pWpFKWT7ozWmplZ+yRd7xa//S5vTfaPCNw/vxfpWOc8Xz2qG3NS1gP2ul5DAT0qp0OHEk8NIQanmVkJS2DT/qsydKJ+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSvGWMI6WhzIFwPZawtKv/KSFx84hUP6XzCzep28/Do=;
 b=gh8jra5+YsbL1UEtHLNB+Oe10Mj5vpExRBw9AvinIS5r9TFkN9lWxzF+a0oRmpm+pbQkORXV59ERWM5OsfNuhgFGYYnIR+pdk0Ul7bSEMfxK4TH7ZK9iK4DD8s2nDB6nwZqlImx+PoC9nlTjcSrETOs/gmXTr1zPZEotFazvT/LU8PPmqMh3QPoNBUORMgyBcrzZGqkNg5sWHfvikJiEDXBv+SddbYwLHAKcvwI3Xtj52fKkAzKrOpRaGeFnN7nHbv23jwWAmjgYdOuQpWX52c6o53TH3bx3J1gd6joPJ5ZyocTXuGp0hIrTZonkyO/b/vB2u8anTDSsrmas1SYO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSvGWMI6WhzIFwPZawtKv/KSFx84hUP6XzCzep28/Do=;
 b=BR58kOXsL9hsArk0XhqUkCKNg/3I7eeDvsAvDpJ9Cwn+inCUxsTxfFePK+2VRg9UgfE1UDI/ML/JXxZrOOG4hU8itLV8Lo7/KOZJHPm3v+pSHt/RHwhOPfTXK8zW0UWO6kWbDxyiEmn0237TK9JEbVFwy/csO86JX+mqVNVMOUc=
Received: from BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10)
 by BY5PR10MB4355.namprd10.prod.outlook.com (2603:10b6:a03:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 8 Jun 2026
 12:25:31 +0000
Received: from BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260]) by BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 12:25:31 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "leon@kernel.org"
	<leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anand Khoje
	<anand.a.khoje@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: RE: [PATCH] IB/mlx4: Fix stale CM id_map entries when RTU is never
 received
Thread-Topic: [PATCH] IB/mlx4: Fix stale CM id_map entries when RTU is never
 received
Thread-Index: AQHc3jjr0HhjpKMY+0mdP4xVBrW4SLYsIrkAgAikZlA=
Date: Mon, 8 Jun 2026 12:25:31 +0000
Message-ID:
 <BL0PR10MB2820B250437BAB1DE4AB1CC98C1C2@BL0PR10MB2820.namprd10.prod.outlook.com>
References: <20260507154755.452008-1-praveen.kannoju@oracle.com>
 <20260603002614.GA1080033@nvidia.com>
In-Reply-To: <20260603002614.GA1080033@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-06-08T12:24:42.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB2820:EE_|BY5PR10MB4355:EE_
x-ms-office365-filtering-correlation-id: 38badbad-5790-4343-f186-08dec5590848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099006|4143699003|6133799003|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info:
 IZeMEVSItT29bWQ+u4T5LStJtBBV4P8LFDTE+HteO/2WhY7PPv9YhC5bQoQCkgXPGAKQq8BPXX1uz4yxXx9JtfvKs00TKb4Nz0VRpQiQ9vgbmUdf3PPXf864XeKL/1AMjwAzkD5A/BvzBP+8Uf2Xg9xdcSkwKcoHCXZTlgidb7RM8gkIW2SbQxZcp4uemFVu9hBqnQUMInZW6vh5ISpRrdS+u5VSY12OSZT8mIK+WP4pJpx3KZKjSC4tfUdgQ/blfjOCfR/yugxXZecm32ByMAyde/xSR63BxiWXvJ5I6X2zxsTAkhebcal9P0qssxVktyRNn/WfpMS5EVJKMhTiWtUv2uwc1AOxcjQeO7JOiU5UIPcXCdA+9xL+M7SC89QQklPnTes6I06VA1IFwaJyE0gQOmtNpLFpLTZN5jsASCtwOwGrnMqGuRNxDweyknY7SYwtapGWa50PvY0P4xSYH/omYVOuF2nLC8gzQJuoFtAN1caMgcSXyllIn1gxpVgZ2wsI84ZoKpYR/Fe9A0TWl2cSCT6fNiE+EiU56TAgqXzzmNZA2tBXobkr8pXEr9d8upujkBH/IcgWgZ3gGO2jl4gry7zHDnEFaC9JO4owHpvY1preNC+/9pbx05JLKe5962/zucs/5h4dZZeSEY1dFXFnHky9uCrt+QOVZ+W7ntM0qPg8KKbbjDupszPK2akw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2820.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099006)(4143699003)(6133799003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjRMdmdyTitxVk9XKzRNREdoNlpPdnpjQmpFQUpISTg3Qkd0QVBuWGpVMjBC?=
 =?utf-8?B?Z1IzeWpUUWpsR21VeGcrVi9LVkFtTjY1UVVGZ0NBR1JPZEs5MHMra0xlM2hE?=
 =?utf-8?B?cUJGKzNTcHI2emtxSmc1M25zVi9mQkUwajdPVVNQUW8yeHVTZUUxY1VMa2Z4?=
 =?utf-8?B?OFhNcnBqQ3ZxZk1pVWVPN2poOFgzSEhHaDU3Q0xCTy8zakJQd1BPV1dxNCt6?=
 =?utf-8?B?VzJwVkJuNlpESWZGWUJyVzRCeWU4MGErWXU0M2hFZW14aVBSUTFVUXk5TlZm?=
 =?utf-8?B?Z2ROREhzZFRkbWJoSlpFSjQyVHBOVWdWSGlnMGtJVkpGNkx5d0dESkFqNnZs?=
 =?utf-8?B?RGdPdGw5czVFRTBmN082TUlxR0lsUTJmODZnWmJmZDBYZEc4NHRncFp1SUF0?=
 =?utf-8?B?OFlDcnd4UENDRkFsWC9QS3dsUXBsaUlRZTVQWk9WN08yZC8wQUtMUDcvM0xW?=
 =?utf-8?B?dlhIZm5hUGF3TDZCR3o5dDBRWFRNNlhpeUJNUjdPMVRxaTA4ckU1YjRlbzAv?=
 =?utf-8?B?aE9seEpvUCtqNDFXRkcrbElKQVlleFY0aXdLNjhCemd0a2h3c2FQZzVHYW1r?=
 =?utf-8?B?NWp5cCtqRGZITyt1c3ZSMm5MMUJuMXYyQTQrM2pGV2hONzJGSEZSbFIvRWVl?=
 =?utf-8?B?TzZTekhzVldGRzFXY1kvNUp5Qm9qdjlxd0pnSkNWdGMwTlcrTTlqOE5UdUhh?=
 =?utf-8?B?UnI2c1Q4aW1IbXd3M09hYW9TUXA5WTNmSEpnUHdRNFJmNkw5RHBUaTJudm1D?=
 =?utf-8?B?Q3BZOEoyT0FqcUVjZUo5eEdSTjRrK1ZvWWlSL1A0N1Q4WFdBUjZLSXYrKzhD?=
 =?utf-8?B?dFdZWEV4REhYOUpUOVpZazZCSjl3UGc5S1hZWTZEUld2QUxqNUNEaElVU1JP?=
 =?utf-8?B?a202UDJZcnJNS1Y1cTRmTHNzaHQ1dm9VNzVrRlFqVXRhbVcvc2dNRnpLdXJD?=
 =?utf-8?B?bkRyV0VBZmFma21FSTFvWGNueUJPK3lxRjlJUGt0RW5MMjFod1dYaGtiTXpN?=
 =?utf-8?B?MEg5ai9DN2R5eXZFdXAwaGd6eDhobzB3RG1GRG5peWJmT1FBazZicUErQUsv?=
 =?utf-8?B?REwycVZ0MVZlYm0rTFNoRUh6bjZNdmxjMDd2b0hSN2p5Z1J1UXo1dG9MZHpL?=
 =?utf-8?B?MitGMG1tQzVvUnRMT3FEVEdidWM2TGk3RVhxMURRSExWajRiNzk0RXZ4V29Y?=
 =?utf-8?B?Nmh1QWE5c1ZhSmR5MlBNQVFHMWR0RUhKc056RThGMWtNK0lFbVBxanMyVFp0?=
 =?utf-8?B?Zy9xMXdRN2Z4RitnenJOL0UzNVN3K0ZmWGQwNEY3eXRYNmRMc1YxdWVLSng3?=
 =?utf-8?B?VmtPOWVqVGlrdWFyaHE2aFlEaFoyQXlXd1M1VlNpc2RUNSt3Y3kwck9DbnQ5?=
 =?utf-8?B?Qm9hYXorenZTV0xUdjZoSHdFREF1VzVrcHJkbUdSblRWS2dEYS9FOXdFZ3lU?=
 =?utf-8?B?YTVTNE9FRmtMellvRENMa3JUaU1Rcy9BVDR5NTdEcmRibCtYOEE4N2xTZjZt?=
 =?utf-8?B?ZktYMjlpTTFTUWVlUnhtSTlJb0diQmlTT25LRXdiNDhIMVVDcUV0RWZjUFpK?=
 =?utf-8?B?YTd2Um5xa1ZRb1Q5MXJzM0t5bGNPdzNNRCthenJzcEQ4dTU2blVQK3BhZlo0?=
 =?utf-8?B?M0xyMVFTSzBHSjZ0amZtTVZJRnFxWDVhdUh2VWxkOGdlUE9KRjhRTE1RTlpH?=
 =?utf-8?B?MW9nQnAzV3hacy9BQlhKT3NYNjRpUDVDQUxkMjEzYndIcHhKNktlNVZVTmdZ?=
 =?utf-8?B?ZXJiVjlYRmxLTFJ0Y004T3JQNGR2RWEzblUvaDZ4MzZEZS9lbVhtcllONUp4?=
 =?utf-8?B?aXVTc0U0WTlJSTEranhzWVEvSDZ1UW9uMjBwMG5EWGVPTUdhR3RBV2ExNS9h?=
 =?utf-8?B?SG9xanpVelJMSXJIbFFVZXhwdmo4QmFXNEVTc21pVDV0SVlKNzhTZXcxZVpX?=
 =?utf-8?B?M0ZpTjQ0VlQ0Q2dqNWRCWU8vOTNuT1BHbThjQ3F0S3l2dDM2T0NBRWVEZ1VN?=
 =?utf-8?B?cHphMkZnazhnR2VtRlRRYVRZOStlTnIzNnBXa2dBcFArbllPYW5aNG84akhi?=
 =?utf-8?B?M3hxWVpYU1lpNGlXeElJcEx3K2JQQWoyMFZjTm84Y0h0ZkJRbGp3U2t6ZXBH?=
 =?utf-8?B?cmRuaVJqTVBxRW5KYmRxME1hT0k1NDNvbDh4YWR6T1ZYdlY0NUpzbU1SU0ls?=
 =?utf-8?B?dFhSYS9xL2tiNE1XUjltaW1pQzd3QlhtMGk1OHhJUFpwdmdBdGp0NlgyZW94?=
 =?utf-8?B?dW5nN2ZzcWJnUlJXZ2V4aExFSzNMSEVVWktqTUQxcWYzT0dPSG9hREthWTFy?=
 =?utf-8?B?RGxhcGlha0RYRVNsdnFSM05QZEFHenh1bVVEWjcwYThQdzBmSzlGQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dONh2nK8j13hxpkzjzwGiwFYYxppceLl7F4l2mxZgZgcBiZaCkW0QvG1Lh5Kdz4DN/fsNCqRyDQjMQyqHzUq/+fnPDnNFkaUC4SFJmHipIloeJ9iJmNVa9ON9gixRyMngeWzMOYzEwr/2oOsns5adGuFOvNOR9h8EZ1iMED0VNk7Lp0vATBbIEiCJZx7uw2gZKIHW9EsVYo2/Iq2tOrneFPcBehWrBEEgf3kaCeX3maIJI+PDw+SBLxkex67OnqT+B/jQ8SXOh2SZGRQEgEheDeDB2L8fMGRD1ah6N5ke3rvXQ/TqOLde/VoRiNGm0jNAXTAJyyEV+b21our2Y5LIg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V9KJU50vWpP7bBkTstxcW5EnQYnAYoqL4qjIbB8tJx3TpV7YTQj8373raE4iYpbSDavjvMtMncikWBG9a9fL1dJ9CwNK4UBE3FdJldrTqzhiPqofsIqK5vS6cibtgzoYk0AxcP6cVGDU82RotSrouTzS35YBMwiT+KZmQ+f4gRCGa0sjRSmvsvTs0LHZWgPUZ5IIYEgbsCguxm/8ULk882HjBQ5oM7jvE59hvVNMEkAN4GNZ6FPBgW1Nlxfr3F/hVU2YUrMQgjpGBxz9HIIrWp6YAyaHeecCamNWuewBCKS4zW2zbm9QSY5Sqzh/bz4rAb0JTkTyH/aR8TnrjqmnPfWBay8OZgj+GxkZDGgeT72Uw2fJcM8cbz5C+/RVJaIXvkQeuv/KN9L/16j65fEgfspHe90SVkT6YbyXdAPGvqjUFAYXPcMVoMPwlb+yKUAUB1Ee5ZWMKSjoMaS2b5keEi/IMfGupk+l/ONk8mJ0kcnK8p4wSOu+s82RpAkXBl9zZh/gswhaHBjT4QsrCWG8zjeD6rBNnHkjrin9O2c/js4fLWnEwce8fvBr6USRILsnIqlOtbXwz3BaBKPrwlhrnWrKE3YSENbOKgLh+Hc/tOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2820.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38badbad-5790-4343-f186-08dec5590848
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 12:25:31.4364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5gaq1zPO7t19rNYDSvnkFGB7LLwcL5CfjI5XfTFOm2U/ri7vwCVvGiq2vQNmGRVnoL3jjzCqZMALdA8s0P44SFiQaZ3lFDEmQS1YbtxOQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606080117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExNyBTYWx0ZWRfX9Br/9KGW7ZcD
 eR/NxwXFBn09Jtm5XPJaigpea08dW+6xQyKu4pIz3pSPXBLo9X+JMOVxcAa+9OpMQnnfxk3v5kd
 9Re1M5gZH7bV+bRVMac95XGFyTNE2XRQTzVBHjHpPpK5aa9+BCW86nU35SmMnsmFVxQQXI+ek6U
 WC7wvjEmNV2vXWwNmTHXM4ixVYyHEe+6y9gQiy1UUZyazscr4yMk+haCECszeQrRlPgZqDqg75K
 m+ehGnAs9N6OBCFkqlOTGktA8bzoXpzRt3doEOh/inJ+zni/6mjDQ2tZ6e9XF/j0cieZ/FXLavd
 YKrkDt1pEZKZcMO4p6tYipGPy7SxitussxqM5OdbK/wB27voTUdXNPwBHsLaUIfmvs/tT8+u2CY
 BsFg8v0ct0siA6y17W+uZ6uIkmIImVihFwJ9DomWRBo0AZ0TpVNAPuDGFYNS54JEUMhtyO9OQcX
 uSeUI8cDxm0zC9VmOMRqg/QMQyzAkmjJs6KMzM+E=
X-Authority-Analysis: v=2.4 cv=ROSD2Yi+ c=1 sm=1 tr=0 ts=6a26b4c2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=c92rfblmAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=jJl7Fv48juAVDVWjJ4IA:9 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-GUID: uVRGpYIucye2T4Z6LApMPTUN-rVjY8GD
X-Proofpoint-ORIG-GUID: uVRGpYIucye2T4Z6LApMPTUN-rVjY8GD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21955-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:yishaih@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anand.a.khoje@oracle.com,m:manjunath.b.patil@oracle.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,oracle.com:dkim,oracle.com:from_mime,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A2E2656395

Q29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1ZGluZyBFeHRlcm5hbCBSZWNp
cGllbnRzDQoNClllcywgdGhpcyBpcyBhIHNlcGFyYXRlIGlzc3VlIGZyb20gdGhlIGVhcmxpZXIg
UkVKIGhhbmRsaW5nLg0KDQpJbiB0aGlzIGNhc2UsIHdoZW4gdGhlIHJlbW90ZSBub2RlIGRyb3Bz
IHRoZSByZXBseSBhcyBhIGR1cGxpY2F0ZSwgdGhlIHNvdXJjZSBzaWRlIGNhbiByZXRhaW4gdGhl
IGBpZF9tYXBfZW50cnlgIGluZGVmaW5pdGVseSwgd2hpY2ggbGVhdmVzIGEgc3RhbGUgbWFwcGlu
ZyBiZWhpbmQuDQoNClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgbWUgdG8gdGhlIFVBRiBjb25jZXJu
IGFuZCB0aGUgcmV2aWV3IGxpbmsuIEkgd2lsbCBldmFsdWF0ZSB0aGUgbG9ja2luZyBhbmQgbGlm
ZXRpbWUgaGFuZGxpbmcgY2FyZWZ1bGx5LCBmaXggdGhlIHBhdGNoIGFzIG5lZWRlZCwgYW5kIHJl
c2VuZCBhbiB1cGRhdGVkIHZlcnNpb24uDQoNCg0KQ29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3Ry
aWN0ZWQgXEluY2x1ZGluZyBFeHRlcm5hbCBSZWNpcGllbnRzDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgSnVuZSAzLCAyMDI2IDU6NTYgQU0NCj4gVG86IFByYXZlZW4gS2Fubm9q
dSA8cHJhdmVlbi5rYW5ub2p1QG9yYWNsZS5jb20+DQo+IENjOiB5aXNoYWloQG52aWRpYS5jb207
IGxlb25Aa2VybmVsLm9yZzsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBbmFuZCBLaG9qZSA8YW5hbmQuYS5raG9qZUBvcmFjbGUu
Y29tPjsNCj4gTWFuanVuYXRoIFBhdGlsIDxtYW5qdW5hdGguYi5wYXRpbEBvcmFjbGUuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBJQi9tbHg0OiBGaXggc3RhbGUgQ00gaWRfbWFwIGVudHJp
ZXMgd2hlbiBSVFUgaXMgbmV2ZXINCj4gcmVjZWl2ZWQNCj4NCj4gT24gVGh1LCBNYXkgMDcsIDIw
MjYgYXQgMDM6NDc6NTVQTSArMDAwMCwgUHJhdmVlbiBLdW1hciBLYW5ub2p1IHdyb3RlOg0KPiA+
IG1seDRfaWJfbXVsdGlwbGV4X2NtX2hhbmRsZXIoKSBhbGxvY2F0ZXMgYW4gaWRfbWFwX2VudHJ5
IGZvciBDTQ0KPiA+IHRyYW5zYWN0aW9ucywgYnV0IHRoZSBlbnRyeSBpcyBvbmx5IHJlbGVhc2Vk
IG9uIERSRVEgb3IgUkVKIGZsb3dzLg0KPiA+DQo+ID4gSW4gdGhlIGR1cGxpY2F0ZSBSRVAgaGFu
ZGxpbmcgc2NlbmFyaW8sIGNtX2R1cF9yZXBfaGFuZGxlcigpIG1heSBnZXQNCj4gPiBpbnZva2Vk
IHdoZW4gdGhlIHJlbW90ZSBzaWRlIHJlY2VpdmVzIGEgUkVQIGZvciB3aGljaCBubyBtYXRjaGlu
Zw0KPiA+IGNtX2lkX3ByaXYgZXhpc3RzLiBJbiBzdWNoIGNhc2VzIHRoZSBDTSBoYW5kc2hha2Ug
bmV2ZXIgcmVhY2hlcyBSVFUsDQo+ID4gYW5kIHRoZSBzZW5kZXIgc2lkZSBtYXkgbmV2ZXIgcmVj
ZWl2ZSBlaXRoZXIgRFJFUSBvciBSRUogY2xlYW51cCBldmVudHMuDQo+ID4NCj4gPiBBcyBhIHJl
c3VsdCwgdGhlIGFsbG9jYXRlZCBpZF9tYXBfZW50cnkgcmVtYWlucyBpbmRlZmluaXRlbHksDQo+
ID4gcmVzdWx0aW5nIGluIGEgc3RhbGUgbWFwcGluZyBsZWFrLg0KPiA+DQo+ID4gRml4IHRoaXMg
Ynkgc2NoZWR1bGluZyBkZWxheWVkIGNsZWFudXAgaW1tZWRpYXRlbHkgYWZ0ZXIgYWxsb2NhdGlu
Zw0KPiA+IHRoZSBpZF9tYXBfZW50cnkuIFRoZSBkZWxheWVkIHdvcmsgaXMgY2FuY2VsbGVkIG9u
Y2UgQ01fUlRVX0FUVFJfSUQgaXMNCj4gPiByZWNlaXZlZCwgaW5kaWNhdGluZyB0aGF0IHRoZSBD
TSBoYW5kc2hha2UgY29tcGxldGVkIHN1Y2Nlc3NmdWxseS4NCj4gPg0KPiA+IFRoaXMgZW5zdXJl
cyBhYmFuZG9uZWQgbWFwcGluZ3MgYXJlIGV2ZW50dWFsbHkgcmVjbGFpbWVkIGV2ZW4gd2hlbiBS
VFUNCj4gPiBpcyBuZXZlciByZWNlaXZlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByYXZl
ZW4gS3VtYXIgS2Fubm9qdSA8cHJhdmVlbi5rYW5ub2p1QG9yYWNsZS5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L2NtLmMgfCAxMCArKysrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvY20uYw0KPiA+IGIvZHJpdmVycy9pbmZpbmliYW5k
L2h3L21seDQvY20uYyBpbmRleCA2M2E4NjhhMzgyMmYuLjcwMGE4NDBkNDkxZA0KPiA+IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L2NtLmMNCj4gPiArKysgYi9k
cml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9jbS5jDQo+ID4gQEAgLTI5OSw2ICsyOTksNyBAQCBz
dGF0aWMgdm9pZCBzY2hlZHVsZV9kZWxheWVkKHN0cnVjdCBpYl9kZXZpY2UNCj4gPiAqaWJkZXYs
IHN0cnVjdCBpZF9tYXBfZW50cnkgKmlkKSAgfQ0KPiA+DQo+ID4gICNkZWZpbmUgUkVKX1JFQVNP
TihtKSBiZTE2X3RvX2NwdSgoKHN0cnVjdCBjbV9nZW5lcmljX21zZw0KPiA+ICopKG0pKS0+cmVq
X3JlYXNvbikNCj4gPiArI2RlZmluZSBSVFVfUkVDRUlWRV9USU1FT1VUICAoNjAgKiBIWikNCj4g
PiAgaW50IG1seDRfaWJfbXVsdGlwbGV4X2NtX2hhbmRsZXIoc3RydWN0IGliX2RldmljZSAqaWJk
ZXYsIGludCBwb3J0LCBpbnQNCj4gc2xhdmVfaWQsDQo+ID4gICAgICAgICAgICAgc3RydWN0IGli
X21hZCAqbWFkKQ0KPiA+ICB7DQo+ID4gQEAgLTMyMSw2ICszMjIsOSBAQCBpbnQgbWx4NF9pYl9t
dWx0aXBsZXhfY21faGFuZGxlcihzdHJ1Y3QgaWJfZGV2aWNlDQo+ICppYmRldiwgaW50IHBvcnQs
IGludCBzbGF2ZV9pZA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywg
c2xhdmVfaWQsIHNsX2NtX2lkKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgIHJldHVybiBQVFJf
RVJSKGlkKTsNCj4gPiAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIHNjaGVk
dWxlX2RlbGF5ZWRfd29yaygmaWQtPnRpbWVvdXQsDQo+IFJUVV9SRUNFSVZFX1RJTUVPVVQpOw0K
Pg0KPiBTbyB0aGlzIGlzIGEgZGlzdGluY3QgcHJvYmxlbSBmcm9tIHRoZSBvdGhlciBvbmU/IENh
biB5b3UgcHV0IGFsbCB0aGVzZSBtbHg0DQo+IGJ1Z3MgaW50byBvbmUgc2VyaWVzPw0KPg0KPiBX
aHkgZG9lcyB0aGlzIG9wZW4gY29kZSBzY2hlZHVsZV9kZWxheWVkKCkgYW5kIHJlbW92ZSBhbGwg
dGhlIGxvY2tpbmc/DQo+DQo+IFNhc2hpa28gZXZlbiBwb2ludHMgb3V0IHRoaXMgbWlnaHQgY3Jl
YXRlIGEgVUFGOg0KPg0KPiBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA1MDcx
NTQ3NTUuNDUyMDA4LTEtDQo+IHByYXZlZW4ua2Fubm9qdSU0MG9yYWNsZS5jb20NCj4NCj4gSmFz
b24NCg==

