Return-Path: <linux-rdma+bounces-2794-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC918D86A0
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 17:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7068C1F24657
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FAF137902;
	Mon,  3 Jun 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hc2i7TyM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A6136E3F;
	Mon,  3 Jun 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430023; cv=fail; b=eUEsrySmAf4flK3kuytSjXguulrQy292t1hEuDeVlPrWP2SK9y3281JNP/WEoORf7XS5Vo7auycKLjTRJA2B2RgUxzGKw9vMAyN7cUQx/TGMRJAHnDeAmAS8TY6E9cn+qPNZ8a3dfcPl+NiDBq55t+iTvqneOK2T9DIAiUfbZhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430023; c=relaxed/simple;
	bh=yzd9LFChuvNGxQtPPK1v3a5VDRZ/rTTXvAaWOf/u1bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hLWHjKpnnNzAn6172lYhl3GBWjBq4ZvcsT84d+oCLQ7m540+RX+Bb9qIakARGTN9PpXFOqj8LjbUK0heUgFSG1gO1EBhw+yJCOk1SM/pkWa2g1oLz/PqPgx3EMGUSbr2mYAbDoCS1yPL7Yfip8gvz+2raowZ58tfo9R0z7TwSxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hc2i7TyM; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAXuw43w+k9oGsT8gtDDa13ypBXfHRjVk0dOp3ADjEhGstVYgMtuMPZ2q4ezvkNOM6FhA5saAna+Mq/W8hBNRgDibuHFWS2yAXjx1WXu8hgqhN7dbqmsDtKQMebBpxwObIVoHg9w/uROaIRXIfiAafIbaDIrLjUrzK5QRRCVEmohVMubDv4OwJaIj1PVZqEBK1uDR1uHq+MfJcTr/+2Nr7isGeNheaQOsIdNoOCSdl1lg8WgdVgzMqCK96IjoTwewfwrpr/Zj0Arn8q92hG34Jt+YyaPCdmEdb/3OU6bs4T0ZizgMITyXR1/nhRklXsTMhJaFjjN+dtfvdRkjX/YFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGAnx4YWzQEavI8LVDlznh8j1reXAQpI6iiRXSb7ilk=;
 b=HbCRcFnelAqpeP6BNXrG94pbPwuT4SJ6SlhCHjDn4T2b6jP5T2ByadJJzLVaUvzciDRB3WyUbxJZ40LuPZe8+VPNCXAp5GeIeNZ5aCLYR9HU5YDTca8/DIGF7F7V4/zW686UuaUS5OXzoBxy/1Zn8GrGbX/dKOyWdK8aOWXDYXzlG2ZS0Trvr1O8Vv/tVApf8FwFnNB5F77g2FQy3z6Yh0wFNTgn5x9+Xdccfo3i0yWDKLZbwGIni5JlNk1ILK/vw6k8qx4p9F1G8BbQpSHoeeLhrBpop94Yt/9z2F1+01twiSRYcY04N7fMmaQdYmAZJ82ZqDyZ71BR92r0yn0/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGAnx4YWzQEavI8LVDlznh8j1reXAQpI6iiRXSb7ilk=;
 b=Hc2i7TyMTuu1Tdl/c/rGI8DKDGFs/DHb3PrUAjfB5AB6/0z7cTTSwJfr3Mbt4uuxFnoRnJO47NFsexRrSAAIDZAZIUFhQ7CvGxpfosnUtaI3uOHFGCK7R+Et97EwrA3+gT6Ld9CG8gjvv6tbSVNgsEkRVp31x4rbdN6FlHRvS0EvyDLsIFyWNmHeAiGnye0eA/2NQgUSBPegFv/ytAMBK6eCIDC1lAKhJtnqEQETlNKAqMHgr33pmmOP/52SUmJAeQYuDGYeD9vJPFz4MhUA8cYBJ7JNUnxojXIcf+SiAQzJ7+7y5uJYeKXyMvRqXfOWuCdyCbzndTpSC149nq9I5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:53:31 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:31 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 6/8] fwctl: Add documentation
Date: Mon,  3 Jun 2024 12:53:22 -0300
Message-ID: <6-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 593812fc-76e6-4d96-6956-08dc83e54fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmNDZWVsUEJPMmhGcy9TeVhEWWlTUzM5R3hmc0tEcTRSdWtHWGsySmpTSWZD?=
 =?utf-8?B?ZEoyeGxaRkFvV2wyWTNjVnZNdGlWdHd1Q1MvSWRlamxwd2xxc3g4TXVVcUs5?=
 =?utf-8?B?UjhzcFV5d1NOZ2xjSUZWTHArVGo0cE4xSFk3WjNRUHk4UzQ0VkxQaXJncVJX?=
 =?utf-8?B?S0RERzcvQlZtMzIvbkJScXlUVVQzRW9KbENIaG1vSmw4SkkvcnRvN2tGdkNk?=
 =?utf-8?B?eE05aUdDVm9lbWE0aUN0QXprdWttck53RFlqZ0w4czJYdGMwRXJBNHJiMkJu?=
 =?utf-8?B?enZ2SXhFMnR4T1RNZmxRSTM1NEl1aDl6bGVQa1ZveG5yR2Evb3hnZXc5ckNq?=
 =?utf-8?B?SGpNYkpxQTF3NitNbk9NZ1V6U3lxRGNRNndlYkFkTk1nOGF1c0t0YWc2N1NS?=
 =?utf-8?B?cUdYVmpPallORzlzYlh6RDVoSy83SDRLdWI5V0F6MHVYSFFDWW9MTEJKSTgx?=
 =?utf-8?B?ajRNMkZQUStlY3dWOGZ6eFNIR1NsL0dvci9QYjBibWdsWjEzaVd4cFFWWFBS?=
 =?utf-8?B?cUhUVitMdkRNN3FQbWtxWjJFQWZMN2FhS0d1SmpYUVF3M3M0dGZmVUZQN2ha?=
 =?utf-8?B?d0NGcDJhaXNJWjVNN0JrYlRXQXNjZjU4MVNOKzhLaS9tL29Nem9rQWdRM0JE?=
 =?utf-8?B?RWc2YWxaazBYbXF3cVpJMmJacnplcDB6U3lBS2dTSityeU5qMHBKRXNnZ1R6?=
 =?utf-8?B?bFdpQndmbzBlRUpYOXYrK1VnVzlpSERpSXhvczV3b0dwZnpYWFBuQi93RzFT?=
 =?utf-8?B?RzA1dkkyNnl6U0w0R1VBVTJyTE9KeEpKUFNWcVoxUkFObXFFZUI5ZThsMlpm?=
 =?utf-8?B?VEQrVDc2WFNydnVQTlhFNzNtemFkL2lQTjdRK2dEdjJPTlh0N2tzbjNuZWRC?=
 =?utf-8?B?aXNGREQ0TEV2YmJXTm9WdDhpbmhocDd2Yy8vWTFLbHVkVHltemV6M0h3ODBN?=
 =?utf-8?B?Vjh1ZGo1Zm91Q201dTBKcG05NEhBVGw1UEVyQnRHYVc4SUtRVmNCV0VPSlB6?=
 =?utf-8?B?ekJObjNST2dxQVpQRXBDR3MrODAwZHpuMGF1WWduZ2hLRGdOTlhvWnhrN1Vw?=
 =?utf-8?B?VVVybVdXdjRRRVlIQ3ZlRWNlOHZFby80TSttNER4cXh1S1I3RjRPN0hEQkNO?=
 =?utf-8?B?S0JkcXdPNStOaTZDc2JNdGtpV1VxdUwvSmY1R0VGeTJEZVNoSXZ6MHVlaWNq?=
 =?utf-8?B?NWlVSUtTbTc0UkMvUC9OMGgvY1ByY3RxSStDQm92RG40eGFpSVJySVZrL1Fa?=
 =?utf-8?B?bGYvYjJBaG55OXNEWWgzdXFmdjdqM1IvWHdqcnFCa1Z3U241ZmpMTUxVVWhV?=
 =?utf-8?B?K0ZSS1ZSUjF3OUVNZU4vVGtYai92SXBIcnc0WnZCM2s3TW5yNE96ZkYrbmds?=
 =?utf-8?B?RUhZSVBBS1hBWmoreG9Tb1lVL0F1SGhKc253OE41dlYvek0zR2RwVzZTZDZT?=
 =?utf-8?B?TWJhdDFjeXE0dkNwNnFNcHp0cHB6dzVnaUxrSlFqTVhPakdwZWVpN2g5SUNy?=
 =?utf-8?B?YzE4RDJHMDBITjhpUjhZbjdrT2R5cHF3RG9TblBDbzY1L2NjSXgvMWF1N0pQ?=
 =?utf-8?B?ZDdzbThzVmY3TWRQY25sQmdxdm92ZCtqSTNsRzV3WVdoZnFqZEozaXZHM1Ir?=
 =?utf-8?B?UXJJcUxVYlZucTdjb0JZZEJHamF4MUpPM09nRHlDMkVobkdmZEN1TVVQWTdr?=
 =?utf-8?B?N3NSRlE2ZnZMUHNsa3lXMmk0SjZsU3JjeG5KYUlKQU5EZ1pCOHJheDc3QS9z?=
 =?utf-8?Q?oexziRzcmO4jfsuQRyLr+GM21xpHBwYzQos8SY/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVpwZ2pQd2pmTVZ2MC9hVGdvM24vb2ViYjNEQ1hLai9GRWlvdlVOTlo3eVIv?=
 =?utf-8?B?WS8rbU9BcysvaWhBS1E5eUZ6M0twUFlyNXlpVnk5Slc2WW4wNzRVdWJCbjZC?=
 =?utf-8?B?bGR2UmdGUjlmcWlWS0pEdGlNZTFhWlV4aWhaMjFieTB1N2xTV21DbVJPYUND?=
 =?utf-8?B?V3NFRWVmSXFEcExHNWltUVZOdlUxVk1NZnIrWnE3STYyNWFHYVJ5d05tUVNR?=
 =?utf-8?B?OTI5TzN5Z1Z3RHlMbHZSeWdTMmFGYmJtaWJNc0lJckMzRi9Ma2lwSit1emVC?=
 =?utf-8?B?VnhpcHB0c09QQUpUdDE3MVJjUFFZSjlUVk1hYkgvOGVHNjlBRis1NDNMdTBX?=
 =?utf-8?B?aS9MOCtwc1hoWVFnYjBHWUFBR2IvM2RFOUVzRTNQWWRuczNwY0ovNTBGY2U3?=
 =?utf-8?B?N210bk5FZWpxZm5VWEdSWjY4TktnaS9pVUJkZGE0YUJLSjJRZjJoRlhrZTBO?=
 =?utf-8?B?cnk3Mm5QUlp4RUtWZkNKemUxV3B3YWp4cmpaOXFkYTBQTmszVlEyZ2hDbmh6?=
 =?utf-8?B?NDVwZzJCN08xZDdQRlA2M2w5RVJtSXluQjFCcktmc2JldGdXZnNCMGtVRlFH?=
 =?utf-8?B?bTBCeWgyOEliV3ZTVGVTRG1LSjE1T1ZITnlSTTlmRG55UFlUSnFad2oreG9K?=
 =?utf-8?B?Q2FBZ3ROYnF2WEIzY24vRXJSRVh2ZE5yU0E3YUNhalpNb0ttWUdGb2x6OXFE?=
 =?utf-8?B?b0MwTE5iSi9nRFZOOXJVY1plRU82cnRobU5JcmxRZ2wxZ3FiU0RKb1Y4WVFn?=
 =?utf-8?B?YnhPUGFRbnpDL2RtQkpTYk5BdzFmTDYxd1Q1QzEwaytWOGxQSmtsOFZLOVJj?=
 =?utf-8?B?SW5zV2hhc2VJL1ZDckRRaG05WGhNTkxZMWdUTm1seEc2K2xiaENnQWNrYzJI?=
 =?utf-8?B?ZWhuWEpMNEp2Y1VyVmZnN21HRnlXeThoZWQram9xQy9qdWxLMUxSTUp1aXY4?=
 =?utf-8?B?REJrUzhYS0Q1K1I5NmQ5VmFSbUU3YUw5a1RXLzJWYmxDa1B6cjdVeFlVekVO?=
 =?utf-8?B?M25GMmF1cUxOTE9BL2swNFlZSDBnemYzeVVmNUpzTTNjTlJ0ZUYzTDZYOVB1?=
 =?utf-8?B?TUlhNDZhTTlGak9ESWFKSmo2T2Y1QytXM3JlbHN4S2x3TEkrRDNYRTJEd3RZ?=
 =?utf-8?B?KzA3UUd2S2N6RFJ1Q09RbmNCNkQ0OTNmWGk0bmVwRjR4MnRGQ3ZQSkFia29T?=
 =?utf-8?B?eUdaUFVXNEdXZkhqTEduaEJ4a09DQmpHUGFrMDlvM2drYWFJTGhDL0lLSHNR?=
 =?utf-8?B?aVhWUE9BSC96MktXSi9MeHBhMnE3ZXlmRStiMjNCQ1ZJT0VLYjk1QnY2UFJD?=
 =?utf-8?B?L1VRdTVwZ3NKbFBvS3c1REg5RjZ1Yys2VnlVZ0N4NjNRNzJ0OUpLa3N2ckRr?=
 =?utf-8?B?b3ZQY1U5aDFPaDdqcWxDSE9BcVUyaU8zTDA2bkQ5d1JBcDMrRGdkYUhxZlgv?=
 =?utf-8?B?VHoxNThrYkdHVUtuczVreXFyVldXQUxHOTd4NjhvVi9FNE9JTk5GTjVaVG1J?=
 =?utf-8?B?b2VXSVJjSy94amYrTURyL2dyYm9JV3dEL1ZBUlNJVEJnUVlvRGRLeGJhK2s3?=
 =?utf-8?B?dlpnRDFVSmpkTUw2eWFURkN4dUprWWRLZ3ZRRkViUEVTWUhHRUFMb2Rncm1Z?=
 =?utf-8?B?VVcrR1VXQUtUd3BGVHNJbDEwbGNPa2VFcTJZZFppQmtLYm5sWkU1aXdOS0lJ?=
 =?utf-8?B?TC9oS2xjdEZPYmkrQVJNdlpSeUtFMzkrQ2dnZ1JIQUVFbWVOYlZkUW5EUFNX?=
 =?utf-8?B?cXQ4UGx3bHhKYnNWOWR1SUY0WWFoMzZ5UzVDT1VETmFkRncxa09jMUVSQUVG?=
 =?utf-8?B?MnM5MFNSWDlZb3BaWWFUL2hMN2sxaUtEUUxuaHo1cmVHVzg5MEk2TFhLNHhC?=
 =?utf-8?B?cTZYU2xoTy9SMURhRkZGcCszRXhXL0Mzd3dCVlkwU01GVmxsRHk5NWEycUFR?=
 =?utf-8?B?TVlmUnVtVEdwREJrN0pIbnpRcUpiSXhiRHVGOTl1K2c2Q0lhRE9vNkVoWGdW?=
 =?utf-8?B?MHZJVWVSeFpqRDBuYUVod1BjblVBSm85dW5ydklrQ2RYNkx1V0s2TXY3SmFS?=
 =?utf-8?B?Rmc3c3RHeDRUM1FOaTlqZDRubndocE03R3FyWmlvTjhnOERwV2VDMDF1N1c3?=
 =?utf-8?Q?TOyT8YNvrg/b/zHRh3RptYf4G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593812fc-76e6-4d96-6956-08dc83e54fbe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:29.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuNUOgAn9lQMLWeV3fNUDmaRoTkorbcV9V5IiaRpjTBtONkjb3EZCJaEAlN+3ocJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

Document the purpose and rules for the fwctl subsystem.

Link in kdocs to the doc tree.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/userspace-api/fwctl.rst | 269 ++++++++++++++++++++++++++
 Documentation/userspace-api/index.rst |   1 +
 2 files changed, 270 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl.rst

diff --git a/Documentation/userspace-api/fwctl.rst b/Documentation/userspace-api/fwctl.rst
new file mode 100644
index 00000000000000..630e75a91838f0
--- /dev/null
+++ b/Documentation/userspace-api/fwctl.rst
@@ -0,0 +1,269 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+fwctl subsystem
+===============
+
+:Author: Jason Gunthorpe
+
+Overview
+========
+
+Modern devices contain extensive amounts of FW, and in many cases, are largely
+software defined pieces of hardware. The evolution of this approach is largely a
+reaction to Moore's Law where a chip tape out is now highly expensive, and the
+chip design is extremely large. Replacing fixed HW logic with a flexible and
+tightly coupled FW/HW combination is an effective risk mitigation against chip
+respin. Problems in the HW design can be counteracted in device FW. This is
+especially true for devices which present a stable and backwards compatible
+interface to the operating system driver (such as NVMe).
+
+The FW layer in devices has grown to incredible sizes and devices frequently
+integrate clusters of fast processors to run it. For example, mlx5 devices have
+over 30MB of FW code, and big configurations operate with over 1GB of FW managed
+runtime state.
+
+The availability of such a flexible layer has created quite a variety in the
+industry where single pieces of silicon are now configurable software defined
+devices and can operate in substantially different ways depending on the need.
+Further we often see cases where specific sites wish to operate devices in ways
+that are highly specialized and require applications that have been tailored to
+their unique configuration.
+
+Further, devices have become multi-functional and integrated to the point they
+no longer fit neatly into the kernel's division of subsystems. Modern
+multi-functional devices have drivers, such as bnxt/ice/mlx5/pds, that span many
+subsystems while sharing the underlying hardware using the auxiliary device
+system.
+
+All together this creates a challenge for the operating system, where devices
+have an expansive FW environment that needs robust device-specific debugging
+support, and FW driven functionality that is not well suited to “generic”
+interfaces. fwctl seeks to allow access to the full device functionality from
+user space in the areas of debuggability, management, and first-boot/nth-boot
+provisioning.
+
+fwctl is aimed at the common device design pattern where the OS and FW
+communicate via an RPC message layer constructed with a queue or mailbox scheme.
+In this case the driver will typically have some layer to deliver RPC messages
+and collect RPC responses from device FW. The in-kernel subsystem drivers that
+operate the device for its primary purposes will use these RPCs to build their
+drivers, but devices also usually have a set of ancillary RPCs that don't really
+fit into any specific subsystem. For example, a HW RAID controller is primarily
+operated by the block layer but also comes with a set of RPCs to administer the
+construction of drives within the HW RAID.
+
+In the past when devices were more single function individual subsystems would
+grow different approaches to solving some of these common problems, for instance
+monitoring device health, manipulating its FLASH, debugging the FW,
+provisioning, all have various unique interfaces across the kernel.
+
+fwctl's purpose is to define a common set of limited rules, described below,
+that allow user space to securely construct and execute RPCs inside device FW.
+The rules serve as an agreement between the operating system and FW on how to
+correctly design the RPC interface. As a uAPI the subsystem provides a thin
+layer of discovery and a generic uAPI to deliver the RPCs and collect the
+response. It supports a system of user space libraries and tools which will
+use this interface to control the device using the device native protocols.
+
+Scope of Action
+---------------
+
+fwctl drivers are strictly restricted to being a way to operate the device FW.
+It is not an avenue to access random kernel internals, or other operating system
+SW states.
+
+fwctl instances must operate on a well-defined device function, and the device
+should have a well-defined security model for what scope within the physical
+device the function is permitted to access. For instance, the most complex PCIe
+device today may broadly have several function level scopes:
+
+ 1. A privileged function with full access to the on-device global state and
+    configuration
+
+ 2. Multiple hypervisor functions with control over itself and child functions
+    used with VMs
+
+ 3. Multiple VM functions tightly scoped within the VM
+
+The device may create a logical parent/child relationship between these scopes,
+for instance a child VM's FW may be within the scope of the hypervisor FW. It is
+quite common in the VFIO world that the hypervisor environment has a complex
+provisioning/profiling/configuration responsibility for the function VFIO
+assigns to the VM.
+
+Further, within the function, devices often have RPC commands that fall within
+some general scopes of action:
+
+ 1. Access to function & child configuration, flash, etc that becomes live at a
+    function reset.
+
+ 2. Access to function & child runtime configuration that kernel drivers can
+    discover at runtime.
+
+ 3. Read only access to function debug information that may report on FW objects
+    in the function & child, including FW objects owned by other kernel
+    subsystems.
+
+ 4. Write access to function & child debug information strictly compatible with
+    the principles of kernel lockdown and kernel integrity protection. Triggers
+    a kernel Taint.
+
+ 5. Full debug device access. Triggers a kernel Taint, requires CAP_SYS_RAWIO.
+
+Userspace will provide a scope label on each RPC and the kernel must enforce the
+above CAP's and taints based on that scope. A combination of kernel and FW can
+enforce that RPCs are placed in the correct scope by userspace.
+
+Denied behavior
+---------------
+
+There are many things this interface must not allow user space to do (without a
+Taint or CAP), broadly derived from the principles of kernel lockdown. Some
+examples:
+
+ 1. DMA to/from arbitrary memory, hang the system, run code in the device, or
+    otherwise compromise device or system security and integrity.
+
+ 2. Provide an abnormal “back door” to kernel drivers. No manipulation of kernel
+    objects owned by kernel drivers.
+
+ 3. Directly configure or otherwise control kernel drivers. A subsystem kernel
+    driver can react to the device configuration at function reset/driver load
+    time, but otherwise should not be coupled to fwctl.
+
+ 4. Operate the HW in a way that overlaps with the core purpose of another
+    primary kernel subsystem, such as read/write to LBAs, send/receive of
+    network packets, or operate an accelerator's data plane.
+
+fwctl is not a replacement for device direct access subsystems like uacce or
+VFIO.
+
+fwctl User API
+==============
+
+.. kernel-doc:: include/uapi/fwctl/fwctl.h
+.. kernel-doc:: include/uapi/fwctl/mlx5.h
+
+sysfs Class
+-----------
+
+fwctl has a sysfs class (/sys/class/fwctl/fwctlNN/) and character devices
+(/dev/fwctl/fwctlNN) with a simple numbered scheme. The character device
+operates the iotcl uAPI described above.
+
+fwctl devices can be related to driver components in other subsystems through
+sysfs::
+
+    $ ls /sys/class/fwctl/fwctl0/device/infiniband/
+    ibp0s10f0
+
+    $ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
+    fwctl0/
+
+    $ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
+    dev  device  power  subsystem  uevent
+
+User space Community
+--------------------
+
+Drawing inspiration from nvme-cli, participating in the kernel side must come
+with a user space in a common TBD git tree, at a minimum to usefully operate the
+kernel driver. Providing such an implementation is a pre-condition to merging a
+kernel driver.
+
+The goal is to build user space community around some of the shared problems
+we all have, and ideally develop some common user space programs with some
+starting themes of:
+
+ - Device in-field debugging
+
+ - HW provisioning
+
+ - VFIO child device profiling before VM boot
+
+ - Confidential Compute topics (attestation, secure provisioning)
+
+That stretches across all subsystems in the kernel. fwupd is a great example of
+how an excellent user space experience can emerge out of kernel-side diversity.
+
+fwctl Kernel API
+================
+
+.. kernel-doc:: drivers/fwctl/main.c
+   :export:
+.. kernel-doc:: include/linux/fwctl.h
+
+fwctl Driver design
+-------------------
+
+In many cases a fwctl driver is going to be part of a larger cross-subsystem
+device possibly using the auxiliary_device mechanism. In that case several
+subsystems are going to be sharing the same device and FW interface layer so the
+device design must already provide for isolation and co-operation between kernel
+subsystems. fwctl should fit into that same model.
+
+Part of the driver should include a description of how its scope restrictions
+and security model work. The driver and FW together must ensure that RPCs
+provided by user space are mapped to the appropriate scope. If the validation is
+done in the driver then the validation can read a 'command effects' report from
+the device, or hardwire the enforcement. If the validation is done in the FW,
+then the driver should pass the fwctl_rpc_scope to the FW along with the command.
+
+The driver and FW must co-operate to ensure that either fwctl cannot allocate
+any FW resources, or any resources it does allocate are freed on FD closure.  A
+driver primarily constructed around FW RPCs may find that its core PCI function
+and RPC layer belongs under fwctl with auxiliary devices connecting to other
+subsystems.
+
+Each device type must represent a stable FW ABI, such that the userspace
+components have the same general stability we expect from the kernel. FW upgrade
+should not break the userspace tools.
+
+Security Response
+=================
+
+The kernel remains the gatekeeper for this interface. If violations of the
+scopes, security or isolation principles are found, we have options to let
+devices fix them with a FW update, push a kernel patch to parse and block RPC
+commands or push a kernel patch to block entire firmware versions, or devices.
+
+While the kernel can always directly parse and restrict RPCs, it is expected
+that the existing kernel pattern of allowing drivers to delegate validation to
+FW to be a useful design.
+
+Existing Similar Examples
+=========================
+
+The approach described in this document is not a new idea. Direct, or near
+direct device access has been offered by the kernel in different areas for
+decades. With more devices wanting to follow this design pattern it is becoming
+clear that it is not entirely well understood and, more importantly, the
+security considerations are not well defined or agreed upon.
+
+Some examples:
+
+ - HW RAID controllers. This includes RPCs to do things like compose drives into
+   a RAID volume, configure RAID parameters, monitor the HW and more.
+
+ - Baseboard managers. RPCs for configuring settings in the device and more
+
+ - NVMe vendor command capsules. nvme-cli provides access to some monitoring
+   functions that different products have defined, but more exists.
+
+ - CXL also has a NVMe like vendor command system.
+
+ - DRM allows user space drivers to send commands to the device via kernel
+   mediation
+
+ - RDMA allows user space drivers to directly push commands to the device
+   without kernel involvement
+
+ - Various “raw” APIs, raw HID (SDL2), raw USB, NVMe Generic Interface, etc
+
+The first 4 would be examples of areas that fwctl intends to cover.
+
+Some key lessons learned from these past efforts are the importance of having a
+common user space project to use as a pre-condition for obtaining a kernel
+driver. Developing good community around useful software in user space is key to
+getting companies to fund participation to enable their products.
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 5926115ec0ed86..9685942fc8a21f 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -43,6 +43,7 @@ Devices and I/O
 
    accelerators/ocxl
    dma-buf-alloc-exchange
+   fwctl
    gpio/index
    iommu
    iommufd
-- 
2.45.2


