Return-Path: <linux-rdma+bounces-12470-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC128B11541
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 02:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6400D7ADA2D
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0F134BD;
	Fri, 25 Jul 2025 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J7W2Ddf8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4E2E36F0;
	Fri, 25 Jul 2025 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403499; cv=fail; b=Pi+GynnUW4w8VV8Yqupr2a7aCzQjnuIQUSjCSwKu15/+gKgsMWAbJjE1iwEQ+67I0XDEMsuIkkEv8qXr6c0dk664I0uY0YubeYHk6eHcQYHxtg0Da7muHHrzgUFymHLFLKqbojg3AisDkcfHJl7zNRgZlGMNPOGTP9y6SoT7ff8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403499; c=relaxed/simple;
	bh=mpNbLUKELftryn0vn0m2AnLDT35Cy91d127e8IwjAMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sXqcIgHiA0vQ07iJVu0l9ePYURZyFEDjcls/ahGaU6VXy9HmYdmbf+DcZ/8BoRpJgK2lxiVorKAAJ5qC0bybaQhSJB/opjmPA7a9cO4ey94IFio+v8E3pXvSy6OvZw91QEraBatBuDnubs6EV0D2WbIZQqdHnd4i/3j1C+L0snY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J7W2Ddf8; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAkKw/SWfGoeG6tWtKOQWLeIHyfinuo0xpUyQeX0h25uOpJUgfB38lBBGudGOEIfjkgogH1v7RsWZMHXjrpl8UKV2EqNzoyDaEH40+MR3mx2bePOH537/YrqepP4J7eOagqrogLNDOVGyNzSxwxSswuJ2Bf8CH6tH79NvRQJdftAbJ1X373mA+7eSpZlQCFh0V3FhpwpYWGb9yseokpj7BiHiXdcX1WtKMRe4tFF3t0GUT0Edu6Olx+t/w4drsLeJYKHZHtjHRT+7j7ht7nrqj5RRpZ/nXlCYjuIYU0l+fmMncOOEKbNhJZz8XH70a/JUrmPFd8Blxt5Z52f0DAs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McHpF7fs0ZtWgt9rj63Lo1qjo0W28rnoOicxQ79ZbcA=;
 b=plvZSwnRaMDXVPrFERstflsxALr6TYVJlAq1nu+sbopDXjwaiMg7lAsb+BneA2qAhkqLdF2T4Al5jMg0+b0BYS1y4ZZw/Rix5ndjWhnLIZWEeHVgOBPHUD+UsM22dgziBEKnJp48eZjvb+x74KIK8yLA5vEE3jQhnnROJ20jQMKSExZGU+3yH1pbUFC+S5B95WuZMChAClj/UXnmHuyaGnfcOAWh+l/XnGUtR7QF/f1TW7N+GGokHSKE4MTqpQaup8TlvqLT59NiWnZ4Veg2faFTkj+v0ka7BLY0hCa0v9mXhbPuxuz+jjbz/PDbeJusqnPWFGEoXLnsVXj5ZMCqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McHpF7fs0ZtWgt9rj63Lo1qjo0W28rnoOicxQ79ZbcA=;
 b=J7W2Ddf8uZLTz7e0M5fPxQ45OQiQRxLObxojJhQZFkIbmyoi61vPz/LawJvUXG4LnsPEF87+nN4UdDkYFgDDULjZ+bb95myTZHyo6g53pZ6jVgBTsPuc2lHJ5qYmRaLt0/e8YO28WZ0B+xc4zi0Pitq1hDO5p/6JEe/u7uds+b46f9RqX7/pIzrydS9QOdb0a6qwXPRDJXpCuAmtixBcAm2dWimvsNIWl+ZzRmDBk6Cc6MchO3ilGlPcRkqLovc4hTNAmpS8faDOQ87mtEjjCs0eyfe4lEUdYbXwknwEY4LgTS5gW/DqtBANiD6J44ltBETtu9CER9IFW+dSU0B9XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 00:31:30 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8943.029; Fri, 25 Jul 2025
 00:31:30 +0000
Date: Fri, 25 Jul 2025 10:31:25 +1000
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Matthew Wilcox <willy@infradead.org>, 
	Yonatan Maman <ymaman@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@nvidia.com>, 
	Michael Guralnik <michaelgur@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, 
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>, linux-mm@kvack.org, 
	linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
Message-ID: <i5ya3n7bhhufpczprtp2ndg7bxtykoyjtsfae6dfdqk2rfz6ix@nzwnhqfwh6rq>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-2-ymaman@nvidia.com>
 <aHpXXKTaqp8FUhmq@casper.infradead.org>
 <20250718144442.GG2206214@ziepe.ca>
 <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
 <aIBcTpC9Te7YIe4J@ziepe.ca>
 <cn7hcxskr5prkc3jnd4vzzeau5weevzumcspzfayeiwdexkkfe@ovvgraqo7svh>
 <a3f1af02-ef3f-40f8-be79-4c3929a59bb7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3f1af02-ef3f-40f8-be79-4c3929a59bb7@redhat.com>
X-ClientProxiedBy: MEVP282CA0051.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:203::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c29ab5-8a14-4095-279a-08ddcb129984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OK22Ro7AaxJnGBLNRBjxz0+pZf7WaIzm118c9VTKX6diHqJwk1YF3ru/1rv0?=
 =?us-ascii?Q?H3Hab+Ja4U94vAt0EG46vuzVjOXwAopEOAPmLbePyeDnPC04faSGyJKtN9UH?=
 =?us-ascii?Q?fGWes/H+/GaF2NK3GbJhc6oJh6olzK4UocX2OyztliCyLwHVWkRpoQslIYOV?=
 =?us-ascii?Q?PHRIROHX5ARTrUiPFxpA7IG7yqcHa8d9/aKFxEyC7kJI7IabsX0mFBeFTbxT?=
 =?us-ascii?Q?40mMm+216dU6Zlji6J1TmamE76vtmB1QuZ15JUXJDZ4HNGJLeSFubWr5siEE?=
 =?us-ascii?Q?Sr0Nvje+Tz42d4O7IL0wo9s52FaGlNokDO9oYhz8JyyS/jcyE0mdiuH02Oin?=
 =?us-ascii?Q?+9ebPBU2zMd9XmQd9yGinvvbr5YrEbaD1hWh4TazZK+aAY4Ycg2aBe0GorAc?=
 =?us-ascii?Q?OpzZmjMkfu99+Fb/tUni/0YcbiIZ0plpMBHQn+J9CgUM3ipkrCUEopbKhh4+?=
 =?us-ascii?Q?CEy2Tu2LKB8NiJhFi1L6dHGW6jVR65kle1wpjIXq3l7pjIP9P6G8f5bN8IrS?=
 =?us-ascii?Q?8dV4x6OIS4oSQeVcNQQxH0mCLKIYxstcGRd0Z5v98V3Q1rfKPpaNEBCTNmpk?=
 =?us-ascii?Q?aRgSQIsH3+0Qagrm2nUMgZPPKOUz4P4ihzOpx93P7PEuLIbxtvr70DdCSLF9?=
 =?us-ascii?Q?a5fuSoq9ICUbuEFaZm/qTvQyKrF2EPDW72yhCZC2NODIVVwFAJYDzZmDDq08?=
 =?us-ascii?Q?7/TU/oOUmuOJs13pqDH72VRjfDbKdzmyRcxttPBp5SFS9i50cC4Uv9f2oliq?=
 =?us-ascii?Q?W4UyRJm4vPd7gZiV3gMTPWljuEX5TP/BtEVhnVOt9svUdNlTc3VcFK6elUEF?=
 =?us-ascii?Q?3pbBlnpn+Y2FGor3NZ5uvsn8SBO7lqR0TlavdMO5C6brgJX5E0agAPOk7Sxc?=
 =?us-ascii?Q?3H+3C32/OCbKrXgVAlt1Z480oDnu2hRNAJ9R3e8AdTtGaJ5BTr6GaAoU14wy?=
 =?us-ascii?Q?Ohc4qG88GpQdENvLqqqTnx32KxgmhTrROiwMd9jTEpLXksTyOcCiRFgDnwBV?=
 =?us-ascii?Q?8473D2fDFrFlx4VSAy4WPCuSM6eD4V0ElnbJYioV5N70dkgVpCrwGtWEGcK2?=
 =?us-ascii?Q?fyHKATyI+YeXHKCvWLgjyCDyIQLRBgHmEUisRapc63/Qx5BFqsghtu9ZS4Uv?=
 =?us-ascii?Q?8oKJH3pyiT/ONLzwVzKcqLc9E/yWS/WyJ+vdhKD6n7qJto+nrOzRtj4NaLlz?=
 =?us-ascii?Q?rcCzwp8FSOlFwGSRivEdLnBKxirAb4IuhfP98WYeAiN/wipjgOP8WqW/3oxa?=
 =?us-ascii?Q?lJMeSmx4yIGYLk6f2NKnFj0q0JyvOIqE280PkXNH5t359FH5lAbeAn0Vh70n?=
 =?us-ascii?Q?dHnCnGHYQk0kstfX5ivYpR8J+dKX154LVEeQBOhG/GroIqPFSKBVSp3IOGaH?=
 =?us-ascii?Q?hg5V8lNMMvcwWz078CYAodzXJDEqrG1W6ljC0Zt1ifelmA8lmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/zma5Eyff7c2na5r7ZCFgcTDee4MhnuqC9+5+8M8L73ke4FQqf99IN9XzCd?=
 =?us-ascii?Q?nmEates+6gXZ/jBRtXUOrHPGCqgeqPaA/n+OFzzY49nnyly3RufBwgm6ts4J?=
 =?us-ascii?Q?duplRlTTRD0gUsJSUywsOpht9o4uyMzRbAJaAkfT7Wc4X2DCDjg7wswQVxtR?=
 =?us-ascii?Q?zGJZtszuuePrEf0ix1S93E6SaL9eEocYith5rSWkPkqe3qdgPsFgGzzaO93R?=
 =?us-ascii?Q?oWt/2FNQf6+1QOB/E3a1F0YflhOtRmIFhErCHaUiB70WV/6xWso1zN3qrbF5?=
 =?us-ascii?Q?WJXYrqFY3bI4XaTp7dRQ5Mec3s8CPZLeYNiwsQlWOUOWZztLgPDT39CHk+ZX?=
 =?us-ascii?Q?9zaA+sIq/yYrLwMnG9ZO6wWaQ9k83qOB1hT/MVMJZGFmzxMRhWlHoYb8ESv1?=
 =?us-ascii?Q?2ZZb28OHLEYZoOBhO7RIg7Phiz7Td+sDykOP4x4EWdKqnYwPsptjJuClFFIf?=
 =?us-ascii?Q?9bT9dAouC9Fkk4ldAp/emyouHB9pm/j/IKoELQmUZStLTctAq08m/4txXWsq?=
 =?us-ascii?Q?EtISrV064ZVaC+7nyjYe5lj2EGpLg615CeOsAc80SKzg7y75qFKQb/NgeeyE?=
 =?us-ascii?Q?9ldIXMMvcPmEToCh9m1geZNNYdU4qVUKuyk4x4wBEdxgy2LBXGRdm0TEZ1yj?=
 =?us-ascii?Q?oIbjx5hy56wWTCxxPDm716fjgWrKK4qbb4wukG/hgdLu3WyaIn8cnJehaZMm?=
 =?us-ascii?Q?LuE3yu+GC1u2K1w2zHnKgvDUe2o7akLe2+faMyHEI4nnjiO09kR0eFzKErbd?=
 =?us-ascii?Q?tYodfwfOEKzTqbngjimO/Wxyw/TB8Vlo7jHtOl1Tu9eGYiRwzr3QqmM9MWJp?=
 =?us-ascii?Q?45cSuklX4BMtcI9V9ayTxn5rKSQDauW77X33v0uHIuW1/k3LtbB+ERRRGgi8?=
 =?us-ascii?Q?W8iJWOJ0yfVoTivRfq/b/sPrKU5mYV0E+N0sxUmVMBCpX+BIErsqUj8g0UYS?=
 =?us-ascii?Q?BRlvxLzTEiRCuANS/shTX2zL4NOFBThMhLc1sTAopacH8iEgeeTS3wBBDt/d?=
 =?us-ascii?Q?TRNXgHojXDwewwUXbyE5fQVKOVvmyMXQUcFRp2h92cBuJUB32rgQOmxQ9fB1?=
 =?us-ascii?Q?bFLLBYIHc87uFwjr4Brk5hYwOl5yev6YxByvyehNZZfNM2SjuMo7pPUoPBLN?=
 =?us-ascii?Q?b+GhC/7hqweuhy3BZXmDMl5Dju12jSITg3vf3rNcQ0Fa4m1neZFtXHMvbpQm?=
 =?us-ascii?Q?3x8HmAR/nEPoJG+nxxm34XRRMlBDfSk0L2ZyIcYLIUV6oiB6Ykcv6hQtVL7U?=
 =?us-ascii?Q?Qz8Bz9v1I6tQuryX7HZKw5p7+gYXzi9E+R6w+E3OciZA/v69v3JvKk71cHtZ?=
 =?us-ascii?Q?WXLykcDrGRzCo3ksLy2bRJnahujuwt5OMlMVZBufePrDvkhjh8sIHQxErLjr?=
 =?us-ascii?Q?aZ67nazo2bo1tZMVULzfCDtVbpapdrtBpjBv+cJcq7dVIQnLitQt3hXe3o8F?=
 =?us-ascii?Q?IrQNhYQzMEWgOEt6Td+dyRTuLXpGbCNQJZ2CilFMB9JnTaZkGdXJLuwObUMR?=
 =?us-ascii?Q?SsfVySypNcTeFJcTdA5aulx1Va8eZIRz/rvRhVDIoD02Oo7/HoQK8CzME9Rb?=
 =?us-ascii?Q?DVpdHYJgB3KnzWUWfdUfBU+tuDUHjsn0a5WVdS6v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c29ab5-8a14-4095-279a-08ddcb129984
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 00:31:30.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 094nw2hLueplsYc+eRIO8Amyqd2gg5bYrbCJSEE6IUVohMppScYPFhind01gK9qcL4gQ72cS0fCCwtMzP2Z7yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949

On Thu, Jul 24, 2025 at 10:52:54AM +0200, David Hildenbrand wrote:
> On 23.07.25 06:10, Alistair Popple wrote:
> > On Wed, Jul 23, 2025 at 12:51:42AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 22, 2025 at 10:49:10AM +1000, Alistair Popple wrote:
> > > > > So what is it?
> > > > 
> > > > IMHO a hack, because obviously we shouldn't require real physical addresses for
> > > > something the CPU can't actually address anyway and this causes real
> > > > problems
> > > 
> > > IMHO what DEVICE PRIVATE really boils down to is a way to have swap
> > > entries that point to some kind of opaque driver managed memory.
> > > 
> > > We have alot of assumptions all over about pfn/phys to page
> > > relationships so anything that has a struct page also has to come with
> > > a fake PFN today..
> > 
> > Hmm ... maybe. To get that PFN though we have to come from either a special
> > swap entry which we already have special cases for, or a struct page (which is
> > a device private page) which we mostly have to handle specially anyway. I'm not
> > sure there's too many places that can sensibly handle a fake PFN without somehow
> > already knowing it is device-private PFN.
> > 
> > > > (eg. it doesn't actually work on anything other than x86_64). There's no reason
> > > > the "PFN" we store in device-private entries couldn't instead just be an index
> > > > into some data structure holding pointers to the struct pages. So instead of
> > > > using pfn_to_page()/page_to_pfn() we would use device_private_index_to_page()
> > > > and page_to_device_private_index().
> > > 
> > > It could work, but any of the pfn conversions would have to be tracked
> > > down.. Could be troublesome.
> > 
> > I looked at this a while back and I'm reasonably optimistic that this is doable
> > because we already have to treat these specially everywhere anyway.
> How would that look like?
> 
> E.g., we have code like
> 
> if (is_device_private_entry(entry)) {
> 	page = pfn_swap_entry_to_page(entry);
> 	folio = page_folio(page);
> 
> 	...
> 	folio_get(folio);
> 	...
> }
> 
> We could easily stop allowing pfn_swap_entry_to_page(), turning these into
> non-pfn swap entries.
> 
> Would it then be something like
> 
> if (is_device_private_entry(entry)) {
> 	page = device_private_entry_to_page(entry);
> 	
> 	...
> }
> 
> Whereby device_private_entry_to_page() obtains the "struct page" not via the
> PFN but some other magical (index) value?

Exactly. The observation being that when you convert a PTE from a swap entry
to a page we already know it is a device private entry, so can go look up the
struct page with special magic (eg. an index into some other array or data
structure).

And if you have a struct page you already know it's a device private page so if
you need to create the swap entry you can look up the magic index using some
alternate function.

The only issue would be if there were generic code paths that somehow have a
raw pfn obtained from neither a page-table walk or struct page. My assumption
(yet to be proven/tested) is that these paths don't exist.

 - Alistair

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

