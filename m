Return-Path: <linux-rdma+bounces-13964-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E59C3BF7ACA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E58F74ECB87
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BCD34DB53;
	Tue, 21 Oct 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UL+Dkt89";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YbBOLcCl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289134DB43;
	Tue, 21 Oct 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064388; cv=fail; b=Xz7Q931sNAK9FAOAz5jZjRxcRp+yNms8p3WP81ieXaPV1tUC7KxJaII6/IHZRwlGv0u/QlMqGrH1mOOVUb7ZORsA3Mm3bUgkRFSCc/QoCA/0kdREtiv7t9GCh2s2QxjMqKDbFYGUXNWbOEqJjrFWmJh0kJIOaiPwBMJnXeB4jQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064388; c=relaxed/simple;
	bh=AjgUzv4DF6WvbbEufbwR1iSrTu8/6CWp7dZ/GgiFcCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OMhPyBCqAsoMGW6U/Np269KuAh0x8dfjm9YCXr+sVoGCqyVtLJ3zR+oihGNuaCI2RZhJsZtPszwQGBZGamQ3S8aVYEILA4HR0aKoAOlBZuzIHloHOXhw98Yy45m2mDFe5IBj3n/IRww+0XrC2tgAgYqJNvOrX89WquInUH4sgCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UL+Dkt89; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YbBOLcCl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEJ9JM031143;
	Tue, 21 Oct 2025 16:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AjgUzv4DF6WvbbEufbwR1iSrTu8/6CWp7dZ/GgiFcCo=; b=
	UL+Dkt89QNysBfRICDzu0ERy2a78lTiIA3erceV2bvNf1vLyh64maq+9Gzn5DTba
	x+rLNFhFZCB5B2+qn0lcT5mIF5gZDlM75/GEclx6SyuPjhIyaD4x6BcUS6L2TYDQ
	EVast8yLizdZCFUcrNtRMn7CeRjT2WVGwNL+WuS5o7StzH3+2eZpmn9SXyp5AfB0
	8mjteuULiPptfyNnDZZWZfxg3SDPCk8hVFboE+XQ49kUx9W2BUNUzXmFd6IV6ydv
	IHedUHgIuEm4QBEmf3ahw4x2JtqKKRXyr8z5K86XnYOdE+cCq3+ouh6zytlDm+5z
	t1evEKEc2uXwwOLsIUg9GQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypx0v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 16:32:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LGC5Xr009393;
	Tue, 21 Oct 2025 16:32:58 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bdava3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 16:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0hWf7kj46ft6OcSgMpNoSLHnntPSZTeKQwhYJ38C/wD989ubfa2DdHWI0pOi0Vi/ijVPO76B8HWrHp6Wf2vTDmDTcEWqtogVW04ckGRNBNcO2Ul9lOeOCq1IOWHGCrGHtvQxlhTGtBaL14DqcpU2lmuTdxz3Ru6JhCZsANGLYiWONThTZw5WNyuZ3FrsywF8KQrTvjB1HhP0kj+vVxbF5kR30DXVKwquVFlD/N4yKVlx9/wZpN1kTlR+x3m3bh0qLLkNtXX/VCGgNgVz342H+b+n8srbKCliRrSAp0wAjRJuimfG3bZSo1PP3ipuNAmlVxO9aJtk2HBPq3mqJVPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjgUzv4DF6WvbbEufbwR1iSrTu8/6CWp7dZ/GgiFcCo=;
 b=MTKyOk51QqtOWB0OlGocwbQNno0PiA5WbQJoXg5xc9mmK7LDw7FX2fF1uTwxB3tT5zuU0+YI+dfq1EYu7m+BruEXVtHzX9+2qPyd4qhAj4vTzLeFDVRLkDYu8hyMBTlD43YtByJuMBvTwaPsM96nz2nb+nBAqiO+oJSjNpOU1T37YAILbgKsFcIvMb4ya3rLZg31beGt8LJQ4+fTHmKGHA2jA0W0IUTk6ji8KptA8gXN7w3h54S4L/OamW1WZQgoLbf3sa8o1YC2SXdHXaNBc+ItjVNeK73OLA+ET7iCn3b6DZSdE8EJTVvYZp50XkpLvNbjg1F+KDazIEq0WtAt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjgUzv4DF6WvbbEufbwR1iSrTu8/6CWp7dZ/GgiFcCo=;
 b=YbBOLcCl10EJlYZFjrQAJcAHNKNoYKRfa4oMS3tG+Ob15Lz46pKIJuKcXlqK+YaIwg57ZQHhtIGwUt7w13hw2n5axDDJBtE+bkiyLhZg5umBWkzilrTihSr3CdXrH6kc+n75Mfzejs7XH91IsndIQl68CNnQ6+raVSDHhLaElYA=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by PH3PPF44A241B91.namprd10.prod.outlook.com (2603:10b6:518:1::798) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 16:32:55 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 16:32:55 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Sean Hefty <shefty@nvidia.com>, Jacob Moroni <jmoroni@google.com>,
        Leon
 Romanovsky <leon@kernel.org>,
        Vlad Dumitrescu <vdumitrescu@nvidia.com>,
        Or
 Har-Toov <ohartoov@nvidia.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Topic: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Index:
 AQHcI8zHdy1KL4KXCkyexoudDHS8M7SV4d4AgAAFLICADfC2AIAcdSOAgAL71ACAAFcGAIAAHVyAgAAC/wCAAVplAIAADUCAgAAIjgCAABXNAIAHwgAA
Date: Tue, 21 Oct 2025 16:32:54 +0000
Message-ID: <20B80D1B-6D11-446E-8EA2-5696FA66494C@oracle.com>
References:
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
 <20251015164928.GJ3938986@ziepe.ca>
 <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20251015184516.GK3938986@ziepe.ca>
 <49A8CE60-DC8E-43F7-9620-D4D5F8EB2A08@oracle.com>
 <20251016161229.GM3938986@ziepe.ca>
 <6244F8C9-2067-4A8A-8DCD-02A4A2D117F6@oracle.com>
 <20251016180108.GO3938986@ziepe.ca>
In-Reply-To: <20251016180108.GO3938986@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|PH3PPF44A241B91:EE_
x-ms-office365-filtering-correlation-id: e2e90a93-4d74-4fe8-887a-08de10bf7cc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFpwY1lEUjJ0bXQzZ0hVY0QxV0oyN3laSUVtYjlLR1I3NkpBNDVmc0trMGpF?=
 =?utf-8?B?RkhtTWk5OCthTTlqN0NVcW9paFhBZkhBd2t1cmZLd2o3aTlNN1VCUWRRTU1l?=
 =?utf-8?B?T3IyUGdKT3g5NHJSemFoeWNETlJ0SVVsVWNoMEVMK0JjWDFJYjdWWVZaUTE4?=
 =?utf-8?B?MHMyZUpjUitLZG9rQXg1NS9IVXAvQnZJNllWZXhPNmQ0QVh3NlpURVEyUXBF?=
 =?utf-8?B?aVN1bmh6cVd3SzkvLys3QmN2cE51YUxoVndKamh5L1gybmlhaTBydzlUN2gy?=
 =?utf-8?B?ZXQ1MXkxa1dxbzFyeG9OV0VKK210M1E0Q2JkYSs5aGVXaUpMb29UTElVRHZk?=
 =?utf-8?B?WThrckw0R2IyaDJ1V29iWnFVNEp5aHNyY2t4dG50d3NCNWFLQkU2Um4vQ0Fm?=
 =?utf-8?B?ejgyVi9sM1pzUENSMkozR055ckdHZGNGSy81QkVqQlJBbFBjSitUWGlLaHJL?=
 =?utf-8?B?ZGJVcjE0UkVTK2MyakVjNnV2ZmlpR01EV1Ywa1RSY0w0bnBlRXVsU2R1b1dV?=
 =?utf-8?B?dVBDNXRtbVhBdThBV3RjTnRjc1ArTlVrYWh6dS8zbFFjczE1TEVERkZHQ0o5?=
 =?utf-8?B?REFZSGJuNDgyUEVWRWhlRE1pQk1PZHZoZzFXYnpweEJLNnhPZ0tScGtKY0Vt?=
 =?utf-8?B?T3Z1UkxNQ3RHbjNKdmVvdjJUZFJPUzV6anNGb1hob01qd1hzeVdRYzZybi9Q?=
 =?utf-8?B?MTFWYytOREFmVXBPNmpiTGZlc3lQc1Y3N3Z6N0ZWa1hJQ1hYTkwyRGNhekRm?=
 =?utf-8?B?dU9EbzJOR01RUVFHdURaM0dJRmg1Mnl6TjZNakZLdkREcHZLeVpOaGhPWU10?=
 =?utf-8?B?eFNGWDQ5OG9sSjJ3cTMzTTgrWVQ1MEN4VDVyN2V0VENXTnBtendJekE4SmYy?=
 =?utf-8?B?dUhhc0xXM0I3c2JPQUJ0WDZXNFFyc1RzZVc3ZkZST3VUaWgvMzJKOVE2cEFu?=
 =?utf-8?B?NWNkYkVYVGFxZzVQRzBTcWJZUjBtTzNCSFhMYUNjQ0xnclUvSFBaNDRKZncz?=
 =?utf-8?B?c1o3dGRiTFZHTXpSSGxmeHNZc1NQdGxyUllFell2ZTNYWXE4WE9tMDBLd0Mw?=
 =?utf-8?B?OG5sV3RLZUo2aWFNZkVGVVVSSDFIVnJrNEpSM044T3Z4bEhITnNQV0xIZGdY?=
 =?utf-8?B?NWh0UXdMMlZXRUc4ckZDMVFDTStjc2ZJQ2VWcUtvV2ZmUFBsb01IUnl3T3FY?=
 =?utf-8?B?c083U2dSZGV5LzdJZGs3UWpScUxjRDJLVU4vc05SVzhMak9KeHpTUUdhdGFz?=
 =?utf-8?B?NnZqbmJBM0Q4bkg0ZTg1U2daZVV2ZHBhV0Qyc0c4VUw3THNIZ092SUhJcXdN?=
 =?utf-8?B?citQcVlDQXFiamJUY2pxRkRTMlVYQzRmN1I0NWZ3d2g1Q1NXYXEzT2tzSzJB?=
 =?utf-8?B?SkU4QzdTYkxjcklSNENPa1hRc3NiTnRaL3ZYSjZGRnlSaWxQcnR2UndiR3NS?=
 =?utf-8?B?dkpMb2JjVTQ4ME1STklRZU44QUFIa2t1N1hIc1VrMTNlOFZlYnVZZHhoVlY5?=
 =?utf-8?B?aU9WM3h6QW0weDRHb3FBVlhicVRQU0U3M3AvK3JpRUNjSUJiQ1VKUXpmSnJM?=
 =?utf-8?B?RHpZNGI1bFhKRU40TzQwZXphR3diQmhmRzkwdGxFQXgwY1JoT3VDdnhRUWlU?=
 =?utf-8?B?cGJjc1RGaVI5NEVyUmJ0dEpnN3Vvb2wvVmpaS3JBeHAraWFuekNDZWdIMS9y?=
 =?utf-8?B?by9aODRwQ2U4S2kvN0l1WGhlRis2RnNXbUhrVnI3MnNtZjJCRmlDNml5dzNt?=
 =?utf-8?B?MUxUd0FHeWlqY3FwT29VYVVMRVhsRHZrYm5mZlBxZzVFU3pUOVo1bDJaQlYr?=
 =?utf-8?B?ODNvVzFIOTRKb3ErbzVnQ0tzL3N1VUdNdkgrK1dLWXRnQmhQeTAwRTJqb0Zm?=
 =?utf-8?B?SEJjV0d1R0d4RkhVTDdmNitma01zRnRoN3d2cXYzOEpvU2cyRHRZdXJ4ZERV?=
 =?utf-8?B?ZEgxYldScndocFRWZWdxYWZDMFlPUWdRbnIwOTI0eDBzRUZlRWc3bHR0bkZW?=
 =?utf-8?B?cWxJVEhvSVAxbzE3by9wNWF2eXVZaXRxSFNNQVdCaWIrZFlEKzVFMFhKUVlM?=
 =?utf-8?Q?mN8WXT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWtJS09ZankvN2hObGM4c1VkMXNTU0tDSm5OaUpIakVkbnd4VFZHVGpRL3I4?=
 =?utf-8?B?dEJ6RWZ2RUlaa1VxRFZqRnlkVThRTTNLQ2JUbFQ2TlB0cHA0N2ZxOURCdGNq?=
 =?utf-8?B?aHVaQ0tFL1FENG1mUExmNzFRQjI2NFFhYmtxMlV3UjlYQVBzZ1FtaFRKY0lN?=
 =?utf-8?B?YnVtT2c4dTg3QXJNK1hmVEhVTi90TTAwdUF6cEE0RFQzMXBzMHNQUWM3Mm5V?=
 =?utf-8?B?b2w2RTBJdEJSblpSaElHUXdjTFlhMHJvZmlUTStJSGZCYmZTMUZRZEY1Wm4y?=
 =?utf-8?B?emZIZkZQMk5Tb2NUZFg2UUtxWEgzUzJvZnNnUXM0ZDFlTjVEd29vTVFnZVB0?=
 =?utf-8?B?WDkxRTBQbDdCZGhhNWhUQm1QbzBmNEF1MzYxbWszZXlpdGVxcGVWOTZDRk02?=
 =?utf-8?B?cmNkWUlHRmxWKzkrZUF1Q284TGd2UkZTdnhYRjA2cW11a0xQNHNKN05JalBN?=
 =?utf-8?B?WEhMUWVPZ3hEdXh4SDlBUk1aVXMwcUV3MUwySmkwU2ZVYUVCYnp6b1FsRDlK?=
 =?utf-8?B?a25CSkNYZ0RmLzFqTVlxclVLOWpvazliMTlnRUtiWktkSFRsM014RnBLbW5o?=
 =?utf-8?B?WlMvb2txS2ZJbTYzUWNyNzlzL2ZjN3djNjc2M1NybVJrUkFNMzNXTTRZQ2x1?=
 =?utf-8?B?MXA3Vi9JMTlOT2w5Z3ZxMnhEZlM0UVVxNU40K0tHY0wvQjVIUW9GR29QL3J3?=
 =?utf-8?B?bTlUZ2ZPVEM5TVR5ZDIyTkZvZFgvM1BQTURzZmYrT2FRZnU5QXZ5ZitCcUZy?=
 =?utf-8?B?WHpubnVQWEV6QnpBeXdLZHFaLzQ5Mk1FRmZFRHdlUmx3NG1WTFhHMG1qbWFE?=
 =?utf-8?B?SlE3NjV1YThiV3VIUXkveUxYc0liVURGbWxiQnJ2WnNROTdHVUsrM3FzZWdk?=
 =?utf-8?B?QTl4RlZSbDljUFhtM0ZhV1Q5Q0NSS0Y3UkNlOHliQ2FXenRjSnZkbS84aExs?=
 =?utf-8?B?Vyt2bW5uTXBMVHl3TU0vMGg4UmplSnBXdm8yY1FuOC9MV2RsSks4Mnl6Tnlh?=
 =?utf-8?B?TnpyWEQ0eHNkMWRQSnVhU05IZ0VnRGF5U2orNHJwOEF1WTY2Z0pIVmZxTmZt?=
 =?utf-8?B?blhmeUVTa0RZbmZ5WWxqUXZZbmkwVVJuMDJqT1BJM0pPU01Jd3l3cGVDM1hj?=
 =?utf-8?B?byt5VzNqVWpIL2hNc3ZQVTdkdnNpdGE1SFVKdTMxcU9FRW9GY2x6eUYyamE3?=
 =?utf-8?B?ZExXQkhhSWxOM2IrZjVBbnJIbnJYckZ3Vkt4R0p3MWJXWVd1d0lrRUVTY3Y0?=
 =?utf-8?B?TUVVTmJpdlVHUExrSEVFVENwRVJaelJDNWxhZWRMaEhYbm1MR2dWdThEQWJR?=
 =?utf-8?B?MEhUYXhHaFkxQ2JMN3poclJQRlhVZzlETzFFLytONTgvUVhyRmsyK2h5T3Vy?=
 =?utf-8?B?RW5Fb0tZQVJ4WDlpSlJ5Q2ZNRi9JSmRwbG9ZZ0JGYVMzWGhXU1pUSFFmSXBq?=
 =?utf-8?B?Ulc5L0xVemhwZ0hsVEYrWWVrMjNOb0lybm9BZXJFRjVMZTlXRDlDOHRHa2pW?=
 =?utf-8?B?bzEvVVZjTnl1WDZMQ2ZqOHhUdHlvVWZtZEdFSW9YNi9SVCtGV0FkNnN2NzQw?=
 =?utf-8?B?TVl0VysyK3hjd05XMm00UGU2eERtT1NjcmZZZVh5RTdHTHZMbEovSWd5NHhu?=
 =?utf-8?B?WlNNN0NwT3VxR3ZsSlRpdTZuNjJlbWJvR0NiMzBZRXpYd3h3YmZGdndCT1hn?=
 =?utf-8?B?S2FYRGlwRk8rQnp1cFp0eFFTL1dPaEFYODhQdHZvQUtzd3pqa2hCdEM4cHRx?=
 =?utf-8?B?ZW5MTWlHalNOeU05d2ltUzhaWWRxQ3h1bUZhUWhoS3l5NHY0VEM5MW5PekhU?=
 =?utf-8?B?eEpSOFljUFppNkJTQ0NRV05ieXhxZ0tKRGMvbldvbnJEdkNEb3VQTjR2djc4?=
 =?utf-8?B?YldRWmpOMGFRc1Q1OFhGSCtYK253MitQRUZPMW9vaFk0L1ZYNlo2Z1NieWVR?=
 =?utf-8?B?UDlSYzRCNFlKaW1KcFhIQjBXbXliaVk0SnczYU4zY3FvS0UvSERlQzhPeGpP?=
 =?utf-8?B?ekNLTGFOR2xKbTBrZW13R25rMzlJSExGcTg2anQ1VTJ0UVpyOFJqWnUxRmZY?=
 =?utf-8?B?N0JOSXdTMGhXd0lGTXZUa24yWVkzVTk2K1BUY0o5cVdtTVdOQXlSZXUwNFlW?=
 =?utf-8?B?WlZ6bVNkR0VHbmFTbjNVSkd2Z3Q4S0wvTFJ1SUpQSmFJUzhYelAra3FseXJp?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A7300843C9AD645A305EAF35D28849A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V/C5y4x5wRP2LY6SWO+IVcWMmAraxOph0BemSsys/dmAUTcENpJCAO2lTAP/4ataGBVwuBf3ix6SZN0mhk2SM83ddWDaagomjBJdAZ+hwzmvsv73npDDYLeIwA72UOzCbYV4ST83dYAL3ctIB77ic4MUewtPk4M9a7asgVgh6L0CcTzI229vwSbIalSjtwhiovEAJZdrKRW21GwhAdJz3VNTmaE6sgdhrbl0t1jxKooVuvdbMgN0yFvzPoMFPy7SpdN0KG442BX4gmOxZdR4VJfGDkP0I/Ylp3C4h2WUzYglw38I1/YFkrHm5B7eU1NM4exnMFayuSLYi8an4nTFiiQ4mkfDv6lLzKqd6YWU18yfAzWe/KN2W4AP+1Z0sqn8gMUuLVom6NfCj953xnbpB4TRQp7YmyxSmcM0xgZUdCeYq9SefkeO4gff5AZujbeM3gFtB2MHotEPHOqTuo9/BFdnAoiGaRiFnomj8yQXjZyml1FuDa3Wq9HLW94+duDg45KfZhGZNEJ9HLKvubpMdNrSq3+hJ/goyqNnzH6OgQT8rC8ROWEgaUVHlHRzOHtPzqMYoG9Ttoab3XpWrbwXdd4rkIsFNgIcpPNyUQTeuTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e90a93-4d74-4fe8-887a-08de10bf7cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 16:32:54.7308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBpucMSxpHyXbssrMyfn9e8Zh2gIQSzepNR6zjVWcxOMkeglbBhuEKZqY26C+Jn4Y5M4iQyMEshO8V0SothkwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF44A241B91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=985 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210130
X-Proofpoint-GUID: yiy6HZOjSAtmL5PUCyVPTpIkziP3KqBg
X-Proofpoint-ORIG-GUID: yiy6HZOjSAtmL5PUCyVPTpIkziP3KqBg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX1AudwZKND8yU
 NXHU66wx0bgrUZInvoVNZCuYHrM74nBU3EKrxl+Q0sDZXPkMcQujaF7HlRz9b/yO1X9bwkNRKQy
 hUebHh9LJgOoXA0sro94nGDKa7SIRvLZJw7j6GPuWmRKeBuotL3iA/F2xQqyUTTpBIhj2VDg/8u
 XyegmOfABz+d3ASO941D9rD3mTcXkwiElYtNscenXmVDnjv1jhFG6HpSTx2JPDv88cqbHn5hkat
 JwkfcMJ5sg/UwEUFLO1NV7xNc4SOwy/Y8Z3uCGapvhYA477tgQhvy146Dte7BFi85R0Xa4cMsDN
 SEAnhnUR7oLyTPcs7WG8srxxUPILyaolRROEWQdHQq/ZYs4E3YQFzu93Im7AQtroRp2vrBTo8Sw
 dd6Rc0mzmTrE3lP54GlOSEiCi8YSa++Peo8puwRMlxH3DN2WZz8=
X-Authority-Analysis: v=2.4 cv=Nu7cssdJ c=1 sm=1 tr=0 ts=68f7b5bb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9jRdOu3wAAAA:8 a=5ns0EU3vDk4HAzMnoEAA:9
 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22 cc=ntf awl=host:12092

DQoNCj4gT24gMTYgT2N0IDIwMjUsIGF0IDIwOjAxLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE9jdCAxNiwgMjAyNSBhdCAwNDo0MzoxNlBNICsw
MDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+IA0KPj4gV2VsbCwgSSBzdGFydGVkIG9mZiB0aGlz
IHRocmVhZCB0aGlua2luZyBhIGNtX2RlcmVmX2lkKCkgd2FzIG1pc3NpbmcNCj4+IHNvbWV3aGVy
ZSwgYnV0IG5vdyBJIGFtIG1vcmUgaW5jbGluZWQgdG8gdGhpbmsgYXMgeW91IGRvLCB0aGlzIGlz
IGFuDQo+PiB1bnJlY292ZXJhYmxlIHNpdHVhdGlvbiwgYW5kIEkgc2hvdWxkIHdvcmsgd2l0aCBO
VklESUEgdG8gZml4IGl0Lg0KPiANCj4gSWYgdGhlIFZGIGlzIGp1c3Qgc3R1Y2sgYW5kIG5vdCBw
cm9ncmVzc2luZyBRUHMgZm9yIHdoYXRldmVyIHJlYXNvbg0KPiB0aGVuIHllcyBhYnNvbHV0ZWx5
Lg0KDQpXZSBhcmUgcnVubmluZyB3aXRoIE1VTFRJX1BPUlRfVkhDQV9FTj0xIChpLmUuLCBvbmUg
ZGV2aWNlLCB0d28gcG9ydHMpLCBhbmQgSSBzZWUgdGhhdCBpdCBpcyBvbmx5IG9uZSBvZiB0aGUg
cG9ydHMgaW4gdGhlIGZ1bmN0aW9uIHRoYXQgZ2V0IGludG8gdGhpcyBzaXR1YXRpb24uIEFuZCB5
ZXMsIG1sbnggdGlja2V0IGZpbGVkLg0KDQo+IEF0IGJlc3QgYWxsIHdlIGNhbiBkbyBpcyBkZXRl
Y3Qgc3R1Y2sgUVBzIGFuZCB0cnkgdG8gcmVjb3ZlciB0aGVtIGFzIEkNCj4gZGVzY3JpYmVkLg0K
DQpJdCBhcHBsaWVzIHRvIGFsbCBRUHMsIG5vdCBvbmx5IEdTSSBNQURzLCBhbmQsIGFzIHJlcG9y
dGVkIGFib3ZlLCBuZXcgUVBzIGNyZWF0ZWQgZnJvbSB1c2VyLXNwYWNlIHJ1biBpbnRvIHRoZSBz
YW1lIHNpdHVhdGlvbi4gSSB0cmllZCBhbiBGTFIsIGJ1dCB0aGUgUkRNQSBzdGFjayBpcyBub3Qg
YWJsZSB0byByZWNvdmVyIGZyb20gaXQuIFNvLCBmcm9tIG15IHBlcnNwZWN0aXZlLCBvbmx5IGEg
cmVib290IGhlbHBzLiBJbiBvdGhlciB3b3JkcywgdW5yZWNvdmVyYWJsZSBmcm9tIGEgU1cgcGVy
c3BlY3RpdmUuDQoNCj4gSG93IGhhcmQvY29zdGx5IHdvdWxkIGl0IGJlIHRvIGhhdmUgYSB0eCB0
aW1lciB3YXRjaGRvZyBvbiB0aGUgbWFkDQo+IGxheWVyIHNlbmQgcT8NCg0KTWF5IGJlIFN0ZXZl
IGNhbiBhbnN3ZXIgdGhhdC4gQnV0IGZyb20gbXkgcGVyc3BlY3RpdmUsIHRoZSAiZGVzdHJveSBD
TSBJRCB0aW1lb3V0IGVycm9yIiBtZXNzYWdlIGlzIF90aGVfIHNpZ25hdHVyZSBvZiB0aGUgc2l0
dWF0aW9uLiBBbmQsIGFueW9uZSBzZWVpbmcgaXQgd291bGQgcHJvYmFibHkgcmVhZCB0aG91Z2gg
dGhpcyB0aHJlYWQuLi4NCg0KPiBBdCB0aGUgdmVyeSBsZWFzdCB3ZSBjb3VsZCBsb2cgYSBzdHVj
ayBNQUQgUVAuLg0KDQpUaGF0IHdvbid0IGh1cnQsIGJ1dCBJIGRvIG5vdCBleHBlY3QgYWxsIG90
aGVyIFVMUHMgYW5kIHVzZXItc3BhY2UgYXBwcyB0byBoYW5kbGUgdGhlIGNhc2Ugd2hlcmUgYSBD
UUUgaXMgZXhwZWN0ZWQgYnV0IG5ldmVyIGNvbWVzLg0KDQoNClRoeHMsIEjDpWtvbg0KDQoNCg==

