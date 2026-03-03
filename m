Return-Path: <linux-rdma+bounces-17426-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLTSKzg7p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17426-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:49:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 724401F6596
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 487B73087FC5
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE37E377EAB;
	Tue,  3 Mar 2026 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iPAGI/rQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A339768D;
	Tue,  3 Mar 2026 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567292; cv=fail; b=FjqaoOufZTd6/oMl/tuENMrMvs1N6DIrOkfu/RmmCg1qAy2gdiwYwCvNNBzO9yWX3Sqd3oLnVp8RGW44uFrlghge644Is7JiSXNuBWhr5xyqqG2G23kGn+PuACFsW/lBHvAETaKqZp2ShvcBODR4ybCjSzthksniu7Zwc4A4RDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567292; c=relaxed/simple;
	bh=8c9zUjArykjHmgaQOexeFaQaPOvesJwfaZ7ms5uSMUI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ps1uTqZqtSyh3EpiOCkQw1rbJ2qfP1oNR8tGiYhPsZrs0F7cNqmddOoO97AnAXSIs/bM/XtahnYtvqOQfeBDYRartC3urz31LL9GqCxR6UoEi8RJb28FZUdJ1/31Kc4vUNQfGA5bwy1otZIRpccqM+k8/QfG8lr9Xp3xqninTyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iPAGI/rQ; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWP79PNPmHDn6lBXcdOnRbWlKM9MPLPK7kHalp7yX+qXVpOxeRhTOxrP9l9BCjCO4auNbShl8mfh1CVsqBQIVXm8mUXpSOhcIDWQWluJzK15N3QrFJJhpAyyfhPHYhvFACZ29tSsnrDyJbw4g5JyjmZMvUn7mjLAxj+rKJaD++i71+hRPv+JQXIHMkVwzD0m5RAg1I3dAY9uaZp/zDJHpWIWNWmhZo86w52wK6uDwBFx6AbtlF2GlljpwuZJ1pewb5Q2roeO8i9NKzn1T35+eAptdx9TAKi3FF7PeTgB9Uqg08FNlaPWc/2WHzdSgQBj56xictQh1WsJlT4FQUtMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c9zUjArykjHmgaQOexeFaQaPOvesJwfaZ7ms5uSMUI=;
 b=A6RukGTa7vYcaWQ3fTJLCLm+iYsr7wGCnMHyV3/M5OYTfx8FhDTVkieWNEC14f540/ljfi8jkOo8pIgLfb6rgs3gyQC32DFlCdYlBVuBMbneFAxh0sGhBpeHOdQnMYcB+iVggvzmI0/5eJJpsuwGBG/ODv3qxez136npb+XNaPSusqe/qbvAZzYl73rRG2wNisvPsGtgf1dAUC0sMECH65Bd2oq+h3QsDQhvDM1tFZGuOZs0Z5aQnht5nbh/uWrJ4DxjfaOvcThwA2+XBhUcRKCStyZruZ/IVuDWh+Bdqqi3B+K6kZTpyCi6FXa7debFJdKUz+8mBwdED0YTuvySdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c9zUjArykjHmgaQOexeFaQaPOvesJwfaZ7ms5uSMUI=;
 b=iPAGI/rQf5PDmz9LxFeuBAKvm5dHE/4rRMPC6Ir+ZTbA2EeoG/N5NdIyfcUkF/bKxIaoxmIx+vD93gcposZirJsDHoBsuoc8Vdu98nnuq3WC9wEDAnQnr8gqYWrcTZ5+3RmP9MibljmO2xee/7uEByV+fE0zvY7gA2R80N44SKFE7XruwF2vpMMQuxqnCHKFEpcBbub9YY42NeiQgF6zLJZ9bfNijXvYBNv4Za+TV+BpCCchWS9eLcc6UBAjxRNvIULLMaVnQkOeyumA0gHVMU6DFl4z5Wvnq3hHthqtQubjNghLP3ESfGtnG8Kch4dSt839pBE/jQLXDRSOCVxT8w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:48:05 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:48:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: John Garry <john.g.garry@oracle.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v7.0-rc1 kernel
Thread-Topic: blktests failures with v7.0-rc1 kernel
Thread-Index: AQHcpvcwQ4wuN59YckSu4sxsMI434LWUs9WAgAiLiQA=
Date: Tue, 3 Mar 2026 19:48:04 +0000
Message-ID: <6d202338-4626-445f-920d-bf0c25a9b82a@nvidia.com>
References: <aZ_-cH8euZLySxdD@shinmob>
 <15ee757e-6140-4151-a1dd-cccb781c89a1@oracle.com>
In-Reply-To: <15ee757e-6140-4151-a1dd-cccb781c89a1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB7005:EE_
x-ms-office365-filtering-correlation-id: d1087ce9-2a54-4993-3720-08de795dc93a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 k4TRy3xSO/x+yMkIl7kk8HeahMpcnmMqKpz38+fohQbJkioyuTFS4mCfCJcILaisQwU+0QSkrfVogyUsI4j5iWqon5U90Siabhzjpeu6wFWLr8OAmHtWibly0VaPK256v1d3aDQw/yOCAwpsEc2+UBj9kk693dBOmew4yTjPasrvtcCnjKiOALHoO+tkpMP/w+5WkIv9VVkxjlW+yIWQcYTSO3WKOZZr+/+JH/sH5YSnQ2VgP/H4+he9AbhzVfwXndX0Dds2ebTZPySZHF3w5/CcKFHAD+hwFssXXuMHyjFuqMxvYp1Tlumbgs3Kn6OAEJvcT/k62EUWWViLLH1Onkj/xvKLu4T4XY0fbIxfcc4fGOnR6Th9obtIHwthkpVwSHtdyjJLKn03QZ8THOm2MCFFev67UN3zJQIkJoi2/Hoj/ePzXB3uNIAHceFHzATrkaFRi5iPrWuDNh/o045boh3ABGr3MMM6tUXjT7YiDh0SwfApwbczEuV8XUfv7f8gvTInd68otoRZDn02uAm0tdtDM+DEdmV/SQF9z2oiAQDA7WKh6n4mvZPAIT98Lqp6LTYoNY8ZaJz+ADE8X/3YVWfeOUMpVgpJpZzKZfZiNu4bIAHXGHzhssmI+LD+6cDrfiKxnoq7YQlfp/zWrNGJMPbhz47bpwY3C06tnJjhEN2aWaP88EcXbUB0ZPf2ETQcxZgVKZqlCu0NXii6J9piO40o3JUZ5qx5bbOwU65z8+D7JLooixjkvcJ2MCDTwrH2RjGAoq1+kfFEMjMT9eDhqjHBjxy2dcgafKWevaHgvxk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWFJVzZLQWlDM3RJR2ZRUThWckhYS1NmL20rQWFxMXJBUDh4UDdCMTl6Wkdk?=
 =?utf-8?B?Sk5RQWRWbjExd1UzcFhvVktQZTN0c2xDVUR6VDJSd0kybFRhYzZ3alN3NlBn?=
 =?utf-8?B?Zjlrb0xmMXJvL3V3U2JoWlRHa2FRaTBMVGtrTGIvV2pXcHE1VDdoMnRsdUFV?=
 =?utf-8?B?NHdvRDZTVnlSQWU2Y2s4cE42V3hwUGkxcnFBM1k4M1lHU3A4dktKaWpiU3lp?=
 =?utf-8?B?NHJKSlgzVGJFakxDalU3V0ZhZC9EcWRRaTlPQlFpMjhnT3p6ZlZsM0tqZkFI?=
 =?utf-8?B?eDJ4ekpOUDJvRm1nR0RsYyt6YzRCa1dwK1Y4d2xjdzZ6NEw2d1k5bk94d1o5?=
 =?utf-8?B?OTlHcU5Gemxmc2lFblo2Y2lscmh6bUxhcUdmeEFnZENSV1FDMndhNS9mMi9B?=
 =?utf-8?B?b1hCTXZ6R2NlOFRjbnN6NGYyUDNrcE5DcCtta1RRMzNOYUZPNEFrb1BaNVI3?=
 =?utf-8?B?VG5ST3RKcXRXYktOUjFzWFI2bUlvZWFrR2g3Z3VReHpsaGpnU1FjVHY0RzhL?=
 =?utf-8?B?bEZJTlNyM1ptZHlCcitMRVppMFFSZzZBMXc2Y0c0OHJwemRIbzZFYkd6eU03?=
 =?utf-8?B?NTVXWU90blNWNzhab1dRSGRoV3V4YlUySENDQVZrcWZCakhRay9FVExPUWNS?=
 =?utf-8?B?b3FMWS9kQVRHQnh0Ulh4a2Q2dUVqaDZISGhrZ0Q2MklhM01iY1RBYVJCZkNk?=
 =?utf-8?B?bFJSK0czOUxIKzdzK0dwWW1ObzQ3bUZMcDVWaVUzdHVRbUFOQmdqclZVWm11?=
 =?utf-8?B?K2xNejBKc01RUCtmUXEvWXBYTFVFZlN6L3BCOTZxbDROZWdTcVUxcUN1bmhQ?=
 =?utf-8?B?d2JMdmI4VkpaMkRZUm9HeGx6ZmZTUlNOY3d2TWxDMDZ0bkMyZUdKdC9HZHp4?=
 =?utf-8?B?anpWMHYyTklRU1dCZ0RPaFd5dnVtTkVwa21kb2JYRHp3cU1LVEVSMDg4SnF3?=
 =?utf-8?B?dlgxNmpWNzkrbkl2eUtvWHhnN1ZYcGE4ZFM1VWM5VkdFVGd4WkxHL0RVQzB1?=
 =?utf-8?B?Q0NodmZWYWMxbnJHMWZzWmhwcDMzWDFnc0N1K0JPSmVBMVdoU0E3akxuYUpO?=
 =?utf-8?B?SFJJVDlCZTQ5OTdJeDJuY0J5Q1ZmS2NPYS9wL2hjZnl6WE9NZklOaUIvMkda?=
 =?utf-8?B?cE1rMDZPVDUrcmYvbTRDZ3JZczlMRldZY1p3T29wV0lmRmpzSzdXQXRDKy9R?=
 =?utf-8?B?azBiQVQxQnJmQUwralpENndKYldoblQ4WGhWZHNJcGQxRWNWWW1zaHZIanB6?=
 =?utf-8?B?ZFBGNFh4VTIyU2FiVGdyQlJKVlV5T0RBb0thd0xWM3NOa3JrendyQ2ZHdFBI?=
 =?utf-8?B?RjdxT21EamRyQUF4NFppcHFOUmJhQ2QwQnpQbXR4RWdXQ2pGejBxYXVPdW4y?=
 =?utf-8?B?TjhOc3hhRFJaUGkzaUdQVHpFa0lUVERkRmVEWURHKzBWMzVOQXJ4TTdyZURk?=
 =?utf-8?B?NUNpVkkra013cmpFblNBTzJRTUl2THlWS2s3aFJ0QmcyYStMdkxqSjZPWGU1?=
 =?utf-8?B?UzdOSEFIbjY3c1RtaWFxdFpmMmRveVN5SUhOYlBBYmZGWGFQa2IyajFsT0FM?=
 =?utf-8?B?L091a0ZwREFUSlN4d29HdDlsblBvY1pNcE5mbDQxSHIrTVN6T2E4Q05CakNQ?=
 =?utf-8?B?bUJhQUVqMEVMZlA4ZHpxZUNLeVFaVmxvZzZPbFFwVjNJbytaSjBpWGF0UzM3?=
 =?utf-8?B?Z3lFY1ZHQ2FTQ2phS2M2WTUyR2N5bDY3cU1meVQzdUt3TnBBSnlYTkp4Nmg5?=
 =?utf-8?B?UDVYL2R6OXJvd2lhNjBOVmlGKytkamJrSzFBald4RjlBMm94U0xNWkQxSVJv?=
 =?utf-8?B?OVhxOG5CYy9jSnc4S2JaTkI4OFFOWGpKaFppK1hoTEc3RGhZTlorUERNdklu?=
 =?utf-8?B?S0xHTUpCOHJra0MzRUN4UjF6MmRSTU5kcnBwa3BEclJrRytRMVpIV3NXaHBw?=
 =?utf-8?B?OSt5ZFhwN2JlSDhPVHlRa21mQVh0WmJUNFJGR0xhSnVUZ1FGZFVPcmRwT1Jw?=
 =?utf-8?B?TjZOMWdlOUd1blJpZlpBbVJlTlZudXFhOWQxWm1URHk4citTL0JKUXJGVW04?=
 =?utf-8?B?VWYvSmVnSXlNRTdhV1o2QVhoaGhPYUR3aGF4Smk4dS90RkhLcDF4OGVTQzdo?=
 =?utf-8?B?STA4disrTjV5NHYrSG0wTk1kd3pSL3BITXVwOTZxZ3JzUGR3NEkvMUp4ZkYr?=
 =?utf-8?B?V0dPN0psd2FWUVM1bFlYcjRxSWhrQzRJOE9NdWNHVE9XVFI4aDh4L2lwTXJF?=
 =?utf-8?B?cTRLM0xiZmRYN3BjeG5jejBmZGgyOXFwUlNjTFViM3h5by9kRGE2MC9aSkx2?=
 =?utf-8?B?aVdIelNqcWZoY3JZWW1lZGcwekcvUlFmaFN1RlJxRk5hVGNUWGlacjhITVYr?=
 =?utf-8?Q?+lp+IEfbXKAWqDaTAf24UNK4/dBGUOix/guqxONP/UPtH?=
x-ms-exchange-antispam-messagedata-1: eObCeJGn1Mmkuw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <276644E3D4FDE149A175017B835963EA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1087ce9-2a54-4993-3720-08de795dc93a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 19:48:04.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIA7iEoDXfFAuAn2aCEo9dpD5rI1jaqfUHNTEKT4Ep7ZzGyRggZR3YpImPl/pvPEmgrbcmOt/y7Of7X0ZB5wzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
X-Rspamd-Queue-Id: 724401F6596
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17426-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanyak@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Action: no action

T24gMi8yNi8yNiAwMToxOCwgSm9obiBHYXJyeSB3cm90ZToNCj4gSkZZSSwgSSBzYXcgdGhpcyBz
cGxhdCBmb3IgbnZtZS8wMzMgb24gbnZtZS03LjAgYnJhbmNoICo6DQo+DQo+IFvCoMKgIDE1LjUy
NTAyNV0gc3lzdGVtZC1qb3VybmFsZFszNDddOg0KPiAvdmFyL2xvZy9qb3VybmFsLzg5ZGYxODIy
OTE2NTRjYzBiMDUxMzI3ZGQ1YTU4MTM1L3VzZXItMTAwMC5qb3VybmFsOg0KPiBKb3VybmFsIGZp
bGUgdXNlcyBhIGRpZmZlcmVudCBzZXF1ZW5jZSBudW1iZXIgSUQsIHJvdGF0aW5nLg0KPiBbwqDC
oCAyMS4zMzkyODddIHJ1biBibGt0ZXN0cyBudm1lLzAzMyBhdCAyMDI2LTAyLTI2IDA4OjQ1OjIw
DQo+IFvCoMKgIDIxLjUyMjE2OF0gbnZtZXQ6IENyZWF0ZWQgbnZtIGNvbnRyb2xsZXIgMSBmb3Ig
c3Vic3lzdGVtDQo+IGJsa3Rlc3RzLXN1YnN5c3RlbS0xIGZvciBOUU4NCj4gbnFuLjIwMTQtMDgu
b3JnLm52bWV4cHJlc3M6dXVpZDowZjAxZmI0Mi05ZjdmLTQ4NTYtYjBiMy01MWU2MGI4ZGUzNDku
DQo+IFvCoMKgIDIxLjUyNzMzMl0gDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBbwqDCoCAyMS41Mjc0MDhdIEJV
RzogS0FTQU46IHNsYWItb3V0LW9mLWJvdW5kcyBpbg0KPiBudm1ldF9wYXNzdGhydV9leGVjdXRl
X2NtZF93b3JrKzB4Zjk0LzB4MWE4MCBbbnZtZXRdDQo+IFvCoMKgIDIxLjUyNzQ5NF0gUmVhZCBv
ZiBzaXplIDI1NiBhdCBhZGRyIGZmZmY4ODgxMDBiZTJiYzAgYnkgdGFzaw0KPiBrd29ya2VyL3Ux
NzoyLzUwDQo+DQo+IFvCoMKgIDIxLjUyNzU4MF0gQ1BVOiAwIFVJRDogMCBQSUQ6IDUwIENvbW06
IGt3b3JrZXIvdTE3OjIgTm90IHRhaW50ZWQNCj4gNi4xOS4wLXJjMy0wMDA4MC1nNmM3MTcyYzE0
ZTkyICMzNyBQUkVFTVBUKHZvbHVudGFyeSkNCj4gW8KgwqAgMjEuNTI3NTg5XSBIYXJkd2FyZSBu
YW1lOiBRRU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwNCj4gQklPUyAxLjE2LjMt
ZGViaWFuLTEuMTYuMy0yIDA0LzAxLzIwMTQNCj4gW8KgwqAgMjEuNTI3NTk0XSBXb3JrcXVldWU6
IG52bWV0LXdxIG52bWV0X3Bhc3N0aHJ1X2V4ZWN1dGVfY21kX3dvcmsgDQo+IFtudm1ldF0NCj4g
W8KgwqAgMjEuNTI3NjM2XSBDYWxsIFRyYWNlOg0KPiBbwqDCoCAyMS41Mjc2MzldwqAgPFRBU0s+
DQo+IFvCoMKgIDIxLjUyNzY0M13CoCBkdW1wX3N0YWNrX2x2bCsweDkxLzB4ZjANCj4gW8KgwqAg
MjEuNTI3Njk1XcKgIHByaW50X3JlcG9ydCsweGQxLzB4NjYwDQo+IFvCoMKgIDIxLjUyNzcxMF3C
oCA/IF9fdmlydF9hZGRyX3ZhbGlkKzB4MjNhLzB4NDQwDQo+IFvCoMKgIDIxLjUyNzcyMV3CoCA/
IGthc2FuX2NvbXBsZXRlX21vZGVfcmVwb3J0X2luZm8rMHgyNi8weDIwMA0KPiBbwqDCoCAyMS41
Mjc3MzNdwqAga2FzYW5fcmVwb3J0KzB4ZjMvMHgxMzANCj4gW8KgwqAgMjEuNTI3NzM5XcKgID8g
bnZtZXRfcGFzc3RocnVfZXhlY3V0ZV9jbWRfd29yaysweGY5NC8weDFhODAgW252bWV0XQ0KPiBb
wqDCoCAyMS41Mjc3NzZdwqAgPyBudm1ldF9wYXNzdGhydV9leGVjdXRlX2NtZF93b3JrKzB4Zjk0
LzB4MWE4MCBbbnZtZXRdDQo+IFvCoMKgIDIxLjUyNzgxNl3CoCBrYXNhbl9jaGVja19yYW5nZSsw
eDExYy8weDIwMA0KPiBbwqDCoCAyMS41Mjc4MjRdwqAgX19hc2FuX21lbWNweSsweDIzLzB4ODAN
Cj4gW8KgwqAgMjEuNTI3ODM0XcKgIG52bWV0X3Bhc3N0aHJ1X2V4ZWN1dGVfY21kX3dvcmsrMHhm
OTQvMHgxYTgwIFtudm1ldF0gDQoNCkkndmUgbm90IHNlZW4gdGhpcywgY2FuIHlvdSB0cnkgZm9s
bG93aW5nLCBmcm9tIHF1aWNrIGxvb2sgaXQNCmZyb20gY29weWluZyBzdWJzbnFuIGFkbWluLWNt
ZC5jIHVzZXMgc3Ryc2NweSgpIGFuZCBwYXNzaHJ1LWNtZC5jIHVzZXMNCm1lbWNweSA6LQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9wYXNzdGhydS5jIGIvZHJpdmVycy9udm1l
L3RhcmdldC9wYXNzdGhydS5jDQppbmRleCA5NjY0OGVjMmZhZGIuLjY3YzQyM2E4YjA1MiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvcGFzc3RocnUuYw0KKysrIGIvZHJpdmVycy9u
dm1lL3RhcmdldC9wYXNzdGhydS5jDQpAQCAtMTUwLDcgKzE1MCw3IEBAIHN0YXRpYyB1MTYgbnZt
ZXRfcGFzc3RocnVfb3ZlcnJpZGVfaWRfY3RybChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpDQogIAkg
KiBjb2RlIHBhdGggd2l0aCBkdXBsaWNhdGUgY3RybCBzdWJzeXNucW4uIEluIG9yZGVyIHRvIHBy
ZXZlbnQgdGhhdCB3ZQ0KICAJICogbWFzayB0aGUgcGFzc3RocnUtY3RybCBzdWJzeXNucW4gd2l0
aCB0aGUgdGFyZ2V0IGN0cmwgc3Vic3lzbnFuLg0KICAJICovDQotCW1lbWNweShpZC0+c3VibnFu
LCBjdHJsLT5zdWJzeXMtPnN1YnN5c25xbiwgc2l6ZW9mKGlkLT5zdWJucW4pKTsNCisJc3Ryc2Nw
eShpZC0+c3VibnFuLCBjdHJsLT5zdWJzeXMtPnN1YnN5c25xbiwgc2l6ZW9mKGlkLT5zdWJucW4p
KTsNCiAgDQogIAkvKiB1c2UgZmFicmljIGlkLWN0cmwgdmFsdWVzICovDQogIAlpZC0+aW9jY3N6
ID0gY3B1X3RvX2xlMzIoKHNpemVvZihzdHJ1Y3QgbnZtZV9jb21tYW5kKSArDQoNCi1jaw0KDQoN
Cg==

