Return-Path: <linux-rdma+bounces-3907-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFC59376CE
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2024 12:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03471F21AF2
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2024 10:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F59184A31;
	Fri, 19 Jul 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MBsRbt+V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2119.outbound.protection.outlook.com [40.107.241.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B983A14;
	Fri, 19 Jul 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386324; cv=fail; b=a5hdvACHdaitC5vNDqLADCx56TkCHw6YaUm6Vz17lGI+LHi3OzqgZ26MZwvnPb6CKEMQHtMEBzWfdkW6jX1dWnETgFWwSIUIiL+X/6u9vr+GAzaL5VeWyTSpfnyO5MEPfDGHWJ4xdXYyqs6ug/EPSs1XVNtOtVhx4fv5PNtNu7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386324; c=relaxed/simple;
	bh=5eDMh/ynt6yi5yQEJQ4M5UorNrVwi4p4Y3+6katbJlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=StoGVfnr88vVlqfCVLdDKI+cewq7Zq4qspWHE1GRw9Qde6GlxeRvRbwFg2ciGC9u7kXtZg/D3Jxm/KH4sw1q7VvhF992s1t750YdOuFmBE2DlmrLAORXikW3IPFR1f0NVi/7g0HFe4fe7fI1ok4BjEnqqzVQTSh6/XIoQYYBiK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MBsRbt+V; arc=fail smtp.client-ip=40.107.241.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2eS0SXB764iamA1iJp+aqp5h6t9g0mDh33B1Tu0hCl/UbaX3v2dj1Ifu2lqL3qej4kZRUT5/8gC1gkQ+WcN7fS8GrHKtpTbGBARssQi+GTIfGl74Y1eN7RFsbmr5Gi1URzfmpEEGL+o+5lsoPsyeOxEvigxx0tcK3oq8nGj6VPv/TDQ8BSygeLBI54tHmVq6WDuQu+4N10nJh8+RGeQi/DPDpcwjAR92NWGTFrSKtJXNr7WYsZV3P78/kjqxS7hoD6BtIsuna0rbEfmQSdjJZTEdUG4PuUG9eO9vkXhcLOGA/C3TCsYMqOC7wXRNGFFPTMmgVUvmvaLhQPHwU/NPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eDMh/ynt6yi5yQEJQ4M5UorNrVwi4p4Y3+6katbJlY=;
 b=kl1TuN8SqiMj39um9STnRFJeX3HZt5w46545sbI2e1/C288oWlVHvLQmyfGTlWmulSh6E+0senDMILgHIzj2Xsf8jxkP9a+HILxzBCULTzny1dO7Ki0CwxbpqdUmC6M2cTwgbHcn0YXMYXyMfQUAWjJ7oAymoUt0dBW8/QHA96V5OjxPPk9gO5peo+dYhigtYcnj4QXyWxCCL3OaR909D2WgrXtDeyvnQVL/rGSgrBWe4ih2ZP1KZzDdlCUnU3OlKsX1COFxjqCy/dBRp2eclIpvifKZiTShMlHQtrl1yzdCgrIDu4pgWxSTjhvwc1Mdfk11ixb4Unoj+4gWxtqNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eDMh/ynt6yi5yQEJQ4M5UorNrVwi4p4Y3+6katbJlY=;
 b=MBsRbt+VJNnRXtdpDci9pEmOBgU7gCu4RqPzBQb0Mc0CMTSGrxbcdRYWrfoebnebkVl8HJAIoSM2iveVM/xyXgZCaOIfwbMF8hgE/2/2yPqFBSEsgkZy4UVLD3wMJecAYgjJxfF0TtJ99p+MjjUI+YbWph+vQtsUb97PdELINP0=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by GVXPR83MB0805.EURPRD83.prod.outlook.com (2603:10a6:150:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.5; Fri, 19 Jul
 2024 10:51:58 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7807.003; Fri, 19 Jul 2024
 10:51:58 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that inline data is
 not supported
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that inline data is
 not supported
Thread-Index: AQHa2cmtxKb5mP8WB0mW8J5nkuB8IA==
Date: Fri, 19 Jul 2024 10:51:58 +0000
Message-ID:
 <PAXPR83MB0559FD4684B40F51A67D6AC9B4AD2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240716111441.GB5630@unreal>
 <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716142223.GC5630@unreal>
 <PAXPR83MB05595BBC92EB695753EB8563B4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716170608.GD5630@unreal>
 <PAXPR83MB0559D97004241D37765A151DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240717062250.GE5630@unreal> <20240717163437.GG1482543@nvidia.com>
 <PAXPR83MB05599E93C7F584D34D715E8AB4AC2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240718164818.GH1482543@nvidia.com>
In-Reply-To: <20240718164818.GH1482543@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c80687fd-ff9d-47ff-be4e-ae45353c8d16;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-19T10:46:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|GVXPR83MB0805:EE_
x-ms-office365-filtering-correlation-id: 5ccd40bf-c468-4e74-0741-08dca7e0d00c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1E5K1RjdFBoUTV3SEVIUTlUaVpGOWdrczBISDVkNG81S2JabllDdjB0YWsy?=
 =?utf-8?B?ZVBUbUMvSW82VFJVOUo5M2RQN1UraEgzalVUUTViTEVtYWRkZ09hazFxR3gx?=
 =?utf-8?B?YlM4NjQ5dktKZUdHeWlQRnJWeDBTZnA3RkRKbzQ5OHVTTGlOUmU5dngwQjR0?=
 =?utf-8?B?aUJBT2FiSUpGQS9zRGRlVm1uVEVBWldxck80Y1BVbUdrSFcrYzVFUTNIaCt1?=
 =?utf-8?B?M1l3ZENObnV5U21CaldGemYyMnRGMlR3SU93MStBZzZiSzV4Y0FJaGRHcXFi?=
 =?utf-8?B?VERoWVhiamNzem84dEF5RFVPS05GNmx0Q0hQRDJPTSt2WEJPUVpxTFBZSlI3?=
 =?utf-8?B?ZGJoY2loU20wQStCYXpnUkV0MTJWVmMzKzAzdzEwQkhVdDdhdzY2M3pqZ1B1?=
 =?utf-8?B?VUNlNzNMajVJNDlFN3d4RnpPQzFpUGFPU0dKN3JHcWt6bjVEbUtTd05MTzhK?=
 =?utf-8?B?NTZ4RktzS3hpNmZiTWJEVnBHYTZvcHpSbVh0LzREMHZVY2w4NEdVRE1jS0Ez?=
 =?utf-8?B?Q0R0S2U5K3pOTzFxMzFxSzd2NG9FL2w4VzdWRmxrdnI3OHlXVy9hMHFNNWRE?=
 =?utf-8?B?Mm9zMklTdURxcHhKQUhUL0tqQ3QwaTZ1NmJhRFdlU3ZOUHpRREN0ZnlrV044?=
 =?utf-8?B?Zmduby9USytjVklOanZpb0Q1UGhpVnNoS2V4bU82SGR5MjJuQUNMRkxEenhJ?=
 =?utf-8?B?MnNmYkJDYUhzRlJPbTRydFM5dGljQnVsclROYjRWemFOL2h6ZnNnNUZoTm5S?=
 =?utf-8?B?MzJyUFZ2ejB5TSt1a3pzTGR1bnd2TU15MEYycWdhMkhyenFPODhVT042RFM4?=
 =?utf-8?B?dzhxU2tVN0p3RTgyNnJvNnVadUJneXdNcHR5N2tFRzB4MHNoWnB4VjR2TkE0?=
 =?utf-8?B?UjlTY053ZmFKS0FsbU9rMFk5ZkpFQng3eVRKUHBpQlN5Ty9JQVlxQmM1NW9t?=
 =?utf-8?B?QkNaTUxJZzZ1aG9Ra2NGdTdGYmhuOHhVMGIrcmIyUjR5alUwa05NeVNQVEY5?=
 =?utf-8?B?clZBZUREcW4rTEppbm8rZlJ0bHhmOEQxWlZkWGllWXA1UnFxLzZlcEdJM2E3?=
 =?utf-8?B?TWQ3cUFoYWJ3MkVyVGZJZUppUHQ0ejlRZjVhYXIyVkx2ZFBpRkUwRlM0V0F0?=
 =?utf-8?B?SmVwcndtWGgrdlNBd3JqMUlrT0hKa3FZZ0tuZDM4di8yaWFiTWdMN2xYZEFj?=
 =?utf-8?B?V3Q4elpXRWlEb043RG41ZXU3VVV1SFZYbUlFcWFHNW9xSXExL2UydWJ5YXRN?=
 =?utf-8?B?bVJzNDVhMENhWEdqMjUxbXV6WXV2SWtoY2lkTjVaRU50WkR6NUVEZFFiNFZr?=
 =?utf-8?B?c0xkam5ydzl4K295eXNSS0NzdVZ5MnBCWHE2K1NHR3ZOeVhzbnlpSkpRazJZ?=
 =?utf-8?B?WHBaRUhWRG90UzVhelVLV2NueHRWcXJpVndrV1FlcjEzalREU0pqTWtQUm5o?=
 =?utf-8?B?SnZqczFMbGhjbHVMQjlLT1g3a3RqNk4yalVjbWhTM01kamx6VTlyemxvaWlM?=
 =?utf-8?B?ZFd3OWdmdmIxZFVDeHB4ak4yMU5yakhaYUJJOC9RdlhqaHU3emtXcTUvdGc1?=
 =?utf-8?B?b3lBd1pvc0RTZWF2ak9FRmJ6d1lOZHR0WXZzb0VCSjNla0dtL3ZneEN2MkVm?=
 =?utf-8?B?cVlpd0JOYnk2a2NDeWt2a2x2UTFxcEl3WVpwUVhwa1h0YWFwc3BZb0tHdDRV?=
 =?utf-8?B?emdFaUhmTkJvMGdZZlh2MG5kNkdJa3E4SUpQMHZaaFdtMGZkeWJ5L0krcHFL?=
 =?utf-8?B?dDNDRkxVcVNrcnBaZzJYQ2hCTitrdGdvdGR2VXBaREpxOHV6NnhEWi9NaXBE?=
 =?utf-8?B?c0prRDZCcnFFeHp5K3JML1RMbDFlVkZtQ2xCTjF4U2hVRDhKaWNvYzZmdjZ1?=
 =?utf-8?B?Y1NtOXRDU1NQU0s1VGhmTlkyajArOVE0VjhQVzZvbEYvNXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0xScmNRbjJNa0FJN1o4Y3VKZit5dUZCdmVYOTMrYk9qUUNnOVVpSTdlekJN?=
 =?utf-8?B?dDZwekM1Z2hpVmRHY2FBeFdFZWp3eHozMmkrUDJ3VVNOYlJkVkw2SG45eHlk?=
 =?utf-8?B?ZnJQTDYzQjZRZGordGhxcUNjMSt5Wm9HYW85ZmMxVk1Jc3B4dE5UUUk4cVVu?=
 =?utf-8?B?dTZYQ05yRWZHRjJuQTVQQnVTRitJdmNZcGFmK3JIMlRJazBtWVNzZElTWVFN?=
 =?utf-8?B?SEZ6QjhxL2tidHE5cDBPWGxLWEZQbXM0QlBLV0NaWHJKcmxKYmd0VmFOaEtF?=
 =?utf-8?B?UzdhMnNEeFBtQTlLTzhRSy82YW1obnFCQ0tvcmFYWjQ0RXpzbFhHNHpVdEIy?=
 =?utf-8?B?TTlaOU5VMHlpVG5NOW5kRnhJL3RBamRrWURBZmdHdTFqTFplV3FDOGl2c2Jn?=
 =?utf-8?B?WGJ4MmJkWkd0alc3cm04RUtqanRROXhydHo3a0ltVnBZN3gxd3BWSGlqbHpV?=
 =?utf-8?B?VTZlNmZCc09NMzMxZTZLeXBWLytLZ2hjOW0vTHQ4MGM1d0VUa0h1VkovdjZL?=
 =?utf-8?B?c20rcjRNWjQzUHFKMjdIYVRoTnRSOFRRaTlDTWZoS3RHV0VPR2Z3dHFGbnQ3?=
 =?utf-8?B?N1Rmd2RvZ3Y3bUhobTB4WXRMdTFkOHZSMXNzRFRBcCtTS3ZZeVhhQ3B0eVRQ?=
 =?utf-8?B?WEVHRDhoa0tsaS9mTTB0QmYvSklETER4TlA0dGRXNHNxMlRnTDFTMjVTT2Jo?=
 =?utf-8?B?N00zbG4zRTVsN0FuQjYrRmxqeGJCZkJDNHZEQlVoVkVMVi9LdndzaHVJK1B3?=
 =?utf-8?B?OGkxd1J5d09UU0RJaVRsU0FucEhOMkthUVJBWHZhS2tqT1o2cVFObVlTZ0N4?=
 =?utf-8?B?M09VT2FZbSs2K2E4RENBYkk4MlNSTnY1OExLMlBtZkh2czZ3dHN2NU8zSm1N?=
 =?utf-8?B?WUZiZGNodm5LUVh2d2M3T1BCaEdsbFArSjYwWExSUU9NSllVZjBRUzd0ZHU3?=
 =?utf-8?B?aGxhZEw5Q2FFd2lIeGY0QzcxQ3FJZXdoR3VvT3oxbVdRelZlUkszTXJUZkRr?=
 =?utf-8?B?V3YzZmNGdkc1SHBtVkc3Q2VjZ2JxTm5RZzJNcWpERnlXY3orOFhEcDBaM1Fm?=
 =?utf-8?B?aGE1Um1OQnU1eDUyWFNROFZkMHMzUHJPTXFMU1lUbExmSFY0ZGdOenRRVGZJ?=
 =?utf-8?B?OEhTeDlwVWRRTGh5V2hTVGpMMGVmS3lTSDkwNEVwbmswblZxQXd2bHdGYUlG?=
 =?utf-8?B?bmQyczBRa1JlZWZ2YXJuOUpBYmp5MjEzNWtPL3pOTDhBTzhrcCtUZFBpLzNS?=
 =?utf-8?B?elRiZ3lVL1h1VVVzbmZtRkx3bW5PYVAwaU4xcWJ1dDRKelVtdGVuTEt1ckla?=
 =?utf-8?B?Y3NNMXh2VUh6NXAwa2xBc0ZkWEZNeFkycEpTV1lzZ1JEZVlTclBacm55Mm02?=
 =?utf-8?B?Mm9DQVZ4SGNCWVRRUXlURDN1VE5tbWkzdmZ5ZlFsOC9zZzFxWTdkZlQzQ1h2?=
 =?utf-8?B?ZC9VU2lGVm1NNWR4VXlqc0IxS3dmVS9RUW9Zb0QyRmhGNXYyN0ZWYVVrOGNG?=
 =?utf-8?B?SUJtZjVmK3ZSaVZiNlBSeWl1OWJWM0dGMkJmd3doWU1kQ3dmRU5vdEZ4Y0Zz?=
 =?utf-8?B?dS82ZXd1bVY3SFdtSWk2dW5sMWJiYjM5c0hINC9CYldXb0I3VUVrNGxoZis3?=
 =?utf-8?B?NnpoTk12dVkwWTB4Z09MR3h3Umd2U3ByNHlMTFB6L0Q3VW1EVWduUm5tK3hz?=
 =?utf-8?B?czcwL0dEalZ6eWdaNTNsWCtuYlh4N1VMMUhPREVlQ1ROQzFOdkdQalRpOUZU?=
 =?utf-8?B?WVJrdkpRa012TnJpNUEwK1R1MFZRQllzY0xmUXVRc0lCeWhqanIraEZVTVV3?=
 =?utf-8?B?cFFhTjhBenNZUFNZT2FGMGFNVVNmK3VEVzZDd1hxY29XeXNQbXAraXNnNzF1?=
 =?utf-8?B?citvN2hQMFhhWVJQd0llZ3hSK2pkMEx0SHZyVm9BeDRoYmhkSUJoeXRXZTc2?=
 =?utf-8?B?RDVrb294ZGxFUWlBNjQ2NStOeFRLOTR2VTEvT01UMEwrYWg0cTRoZ3RrZ1ZP?=
 =?utf-8?B?VlIxWjRDSEJ5dmg3eDF3WWFpVGJQYm5ObzVVQWI3VklQOCtuaEZXdmRlS0Ew?=
 =?utf-8?Q?2lIwby?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccd40bf-c468-4e74-0741-08dca7e0d00c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 10:51:58.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1earJ+QxsrWuEgiMB2emKtyDSLrpGSRzGEWpsckKQBAZB6NmlOgDzuTalWsPCZ7BMWGYQfEBOknD60qJ6W9Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0805

PiA+ID4gPiA+ID4gWWVzLCB5b3UgYXJlLiBJZiB1c2VyIGFza2VkIGZvciBzcGVjaWZpYyBmdW5j
dGlvbmFsaXR5DQo+ID4gPiA+ID4gPiAobWF4X2lubGluZV9kYXRhICE9IDApIGFuZCB5b3VyIGRl
dmljZSBkb2Vzbid0IHN1cHBvcnQgaXQsIHlvdQ0KPiA+ID4gPiA+ID4gc2hvdWxkDQo+ID4gPiBy
ZXR1cm4gYW4gZXJyb3IuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gcHZyZG1hLCBtbHg0IGFu
ZCBydnQgYXJlIG5vdCBnb29kIGV4YW1wbGVzLCB0aGV5IHNob3VsZCByZXR1cm4NCj4gPiA+ID4g
PiA+IGFuIGVycm9yIGFzIHdlbGwsIGJ1dCBiZWNhdXNlIG9mIGJlaW5nIGxlZ2FjeSBjb2RlLCB3
ZSB3b24ndCBjaGFuZ2UNCj4gdGhlbS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGFua3MN
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIHNlZS4gU28gSSBndWVzcyB3ZSBj
YW4gcmV0dXJuIGEgbGFyZ2VyIHZhbHVlLCBidXQgbm90IHNtYWxsZXIuIFJpZ2h0Pw0KPiA+ID4g
PiA+IEkgd2lsbCBzZW5kIHYyIHRoYXQgZmFpbHMgUVAgY3JlYXRpb24gdGhlbi4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IEluIHRoaXMgY2FzZSwgbWF5IEkgc3VibWl0IGEgcGF0Y2ggdG8gcmRtYS1j
b3JlIHRoYXQgcXVlcmllcw0KPiA+ID4gPiA+IGRldmljZSBjYXBzIGJlZm9yZSB0cnlpbmcgdG8g
Y3JlYXRlIGEgcXAgaW4gcmRtYV9jbGllbnQuYyBhbmQNCj4gPiA+ID4gPiByZG1hX3NlcnZlci5j
PyBBcyB0aGF0IGNvZGUgdmlvbGF0ZXMgd2hhdCB5b3UgZGVzY3JpYmVkLg0KPiA+ID4gPg0KPiA+
ID4gPiBMZXQncyBhc2sgSmFzb24sIHdoeSBpcyB0aGF0PyBEbyB3ZSBhbGxvdyB0byBpZ25vcmUg
bWF4X2lubGluZV9kYXRhPw0KPiA+ID4gPg0KPiA+ID4gPiBsaWJyZG1hY20vZXhhbXBsZXMvcmRt
YV9jbGllbnQuYw0KPiA+ID4gPiAgIDYzICAgICAgICAgbWVtc2V0KCZhdHRyLCAwLCBzaXplb2Yg
YXR0cik7DQo+ID4gPiA+ICAgNjQgICAgICAgICBhdHRyLmNhcC5tYXhfc2VuZF93ciA9IGF0dHIu
Y2FwLm1heF9yZWN2X3dyID0gMTsNCj4gPiA+ID4gICA2NSAgICAgICAgIGF0dHIuY2FwLm1heF9z
ZW5kX3NnZSA9IGF0dHIuY2FwLm1heF9yZWN2X3NnZSA9IDE7DQo+ID4gPiA+ICAgNjYgICAgICAg
ICBhdHRyLmNhcC5tYXhfaW5saW5lX2RhdGEgPSAxNjsNCj4gPiA+ID4gICA2NyAgICAgICAgIGF0
dHIucXBfY29udGV4dCA9IGlkOw0KPiA+ID4gPiAgIDY4ICAgICAgICAgYXR0ci5zcV9zaWdfYWxs
ID0gMTsNCj4gPiA+ID4gICA2OSAgICAgICAgIHJldCA9IHJkbWFfY3JlYXRlX2VwKCZpZCwgcmVz
LCBOVUxMLCAmYXR0cik7DQo+ID4gPiA+ICAgNzAgICAgICAgICAvLyBDaGVjayB0byBzZWUgaWYg
d2UgZ290IGlubGluZSBkYXRhIGFsbG93ZWQgb3Igbm90DQo+ID4gPiA+ICAgNzEgICAgICAgICBp
ZiAoYXR0ci5jYXAubWF4X2lubGluZV9kYXRhID49IDE2KQ0KPiA+ID4gPiAgIDcyICAgICAgICAg
ICAgICAgICBzZW5kX2ZsYWdzID0gSUJWX1NFTkRfSU5MSU5FOw0KPiA+ID4gPiAgIDczICAgICAg
ICAgZWxzZQ0KPiA+ID4gPiAgIDc0ICAgICAgICAgICAgICAgICBwcmludGYoInJkbWFfY2xpZW50
OiBkZXZpY2UgZG9lc24ndCBzdXBwb3J0DQo+ID4gPiBJQlZfU0VORF9JTkxJTkUsICINCj4gPiA+
ID4gICA3NSAgICAgICAgICAgICAgICAgICAgICAgICJ1c2luZyBzZ2Ugc2VuZHNcbiIpOw0KPiA+
ID4NCj4gPiA+IEkgdGhpbmsgdGhlIGlkZWEgZXhwcmVzc2VkIGluIHRoaXMgY29kZSBpcyB0aGF0
IGlmIG1heF9pbmxpbmVfZGF0YQ0KPiA+ID4gcmVxdWVzdGVkIHRvbyBtdWNoIGl0IHdvdWxkIGJl
IGxpbWl0ZWQgdG8gdGhlIGRldmljZSBjYXBhYmlsaXR5Lg0KPiA+ID4NCj4gPiA+IGllIHFwIGNy
ZWF0aW9uIHNob3VsZCBsaW1pdCB0aGUgcmVxdWVzdHMgdmFsdWVzIHRvIHdoYXQgdGhlIEhXIGNh
bg0KPiA+ID4gZG8sIHNpbWlsYXIgdG8gaG93IGVudHJpZXMgYW5kIG90aGVyIHdvcmsuDQo+ID4g
Pg0KPiA+ID4gSWYgdGhlIEhXIGhhcyBubyBzdXBwb3J0IGl0IHNob3VsZCByZXR1cm4gLSBmb3Ig
bWF4X2lubGluZV9kYXRhIG5vdA0KPiA+ID4gYW4gZXJyb3IsIEkgZ3Vlc3M/DQo+ID4NCj4gPiBZ
ZXMsIHRoaXMgY29kZSBpbXBsaWVzIHRoYXQgbWF4X2lubGluZV9kYXRhIGNhbiBiZSBpZ25vcmVk
IGF0IGNyZWF0aW9uLA0KPiB3aGlsZSB0aGUgbWFudWFsIG9mIGlidl9jcmVhdGVfcXAgc2F5czoN
Cj4gPiAiVGhlIGZ1bmN0aW9uIGlidl9jcmVhdGVfcXAoKSB3aWxsIHVwZGF0ZSB0aGUgcXBfaW5p
dF9hdHRyLT5jYXAgc3RydWN0DQo+ID4gd2l0aCB0aGUgYWN0dWFsIFFQIHZhbHVlcyBvZiB0aGUg
UVAgdGhhdCB3YXMgY3JlYXRlZDsgdGhlIHZhbHVlcyB3aWxsDQo+ID4gYmUgKipncmVhdGVyIHRo
YW4gb3IgZXF1YWwgdG8qKiB0aGUgdmFsdWVzIHJlcXVlc3RlZC4iDQo+IA0KPiBBaCwgd2VsbCB0
aGF0IHNlZW1zIHRvIGJlIHNvbWUgbWlzdW5kZXJzdGFuZGluZ3MgdGhlbiwgeWVzLg0KPiANCj4g
PiBJIHNlZSB0d28gb3B0aW9uczoNCj4gPiAxKSBSZW1vdmUgY29kZSBmcm9tIHJkbWEgZXhhbXBs
ZXMgdGhhdCByZWx5IG9uIGlnbm9yaW5nIG1heF9pbmxpbmU7IGFkZA0KPiBhIHdhcm5pbmcgdG8g
bGliaWJ2ZXJicyB3aGVuIGRyaXZlcnMgaWdub3JlIHRoYXQgdmFsdWUuDQo+ID4gMikgQWRkIHRv
IG1hbnVhbCB0aGF0IG1heF9pbmxpbmVfZGF0YSBtaWdodCBiZSBpZ25vcmVkIGJ5IGRyaXZlcnM7
IGFuZA0KPiBhbGxvdyBteSBjdXJyZW50IHBhdGNoIHRoYXQgaWdub3JlcyBtYXhfaW5saW5lX2Rh
dGEgaW4gbWFuYV9pYi4NCj4gDQo+IEkgZG9uJ3Qga25vdywgd2hhdCBkbyB0aGUgbWFqb3JpdHkg
b2YgZHJpdmVycyBkbz8gSWYgZW5vdWdoIGFyZSBhbHJlYWR5IGRvaW5nDQo+IDEgdGhlbiBsZXRz
IGZvcmNlIGV2ZXJ5b25lIGludG8gMSwgb3RoZXJ3aXNlIHdlIGhhdmUgdG8gZG9jdW1lbnQgMi4N
Cj4gDQo+IEFuZCBhIHB5dmVyYnMgdGVzdCBzaG91bGQgYmUgYWRkZWQgdG8gY292ZXIgdGhpcyB3
ZWlyZG5lc3MNCg0KSSBxdWlja2x5IHJlYWQgY3JlYXRlX3FwIGNvZGUgb2YgYWxsIHByb3ZpZGVy
cyBhbmQgaXQgc2VlbXMgdGhhdCBtYXhfaW5saW5lX2RhdGEgaXMgaWdub3JlZCBieSBody9wdnJk
bWEgYW5kIHN3L3J2dC4NCk90aGVyIHByb3ZpZGVycyBmYWlsIHRoZSBjcmVhdGlvbiB3aGVuIHRo
ZXkgY2Fubm90IHNhdGlzZnkgdGhlIGlubGluZV9kYXRhIGNhcC4NClNvbWUgZHJpdmVycyBpZ25v
cmUgaXQgZm9yIEdTSSwgYnV0IEkgdGhpbmsgaXQgaXMgcmVhc29uYWJsZS4gDQoNClRoZW4gSSBn
dWVzcyB0aGUgb3B0aW9uIDEgaXMgYmV0dGVyLiBSZWdhcmRpbmcgcHl2ZXJicywgc2hvdWxkIEkg
YWRkIGEgdGVzdCBmb3IgdGhlIG9wdGlvbiAxPw0KSWYgeWVzLCB3aGF0IHNob3VsZCBpdCB0ZXN0
Pw0KDQo+IA0KPiBKYXNvbg0K

