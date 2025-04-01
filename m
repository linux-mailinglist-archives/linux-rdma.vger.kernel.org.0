Return-Path: <linux-rdma+bounces-9075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0578A77B9B
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 15:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE81166372
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D4E1FBEAA;
	Tue,  1 Apr 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ogyTu+JT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910A29A1;
	Tue,  1 Apr 2025 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512660; cv=fail; b=W7JwKgasr31W9O/omdiHqHFCRsCQBJuOWp/WTx3OzyaamseWMnOXaWR5S41VEK/zvKDO80NoqI8SFNikdRzilsKZakZjOCF5/5TCBJVozcUQB8zUfvZnirOA5oTiaxR0R33BV1zk9sLhPapBSBLf0cKltWIxhIS9H7nsCVIUCVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512660; c=relaxed/simple;
	bh=PIKgh9ZoRmHD7iBuVMHLTnKwIlfQmKSRc+py9JfGcNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MNPNzufYhq9T33AnsoCG55mTHU5Mf058p/VJgGcLPWyx9k/4kHqQRuprp9SK9kKLRImtA+TCc9tLQ6+Vg8fr1tx7iB8hSeOaLS4MAHni4W828Mz0PTkxSsR9jRA1ayNsw2yIXNaNSt/MFtafN+SbpMEzb/G1d7gd8RPWXQ2YW7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ogyTu+JT; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnol2gCWIYKfK3EgpusDeuLn1KXmEunDwkQF5/PA4fe6pdkARVzIpIXfw+pN0GusXcthPQ6vgJi1pEBxEiCKOymFEX0Q7M1IEj10T7K6y1QMDz1PqGP08dbx2LAv1HSh4znVmZWy16gGfVvhFSyxPBjB0hgrpKuLGh6V9nzjwgSbT5eW9Q9YdvyIMhI3NEpPY1+7XDXhAS7Ijlr5NnGOZGZKfYPweureDMkcoBEUyzL93fNWsu8v/ICecGt/gA/caEGE+7Xn9SZYQnLGdif/5Tw2aJZemwSjFmKnQTGX4zv0i7dnLpgkfhnvIqIRUqLvGTjyoIAeO6gCpgue+7Pf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yY3/6g0u6cBNxXQ3+Mqy0twFahN4yc2JdvSXNVS/mg0=;
 b=I1qtVjrKZJSt2cy6fsEvAYxOvYbXjI+f5+nCohAUabQ4u4nSUXp9YxgILS1mIyOTIcfeq393yjANtg3riiavT2XjHbg9KRrAgt8mKbh2nko3eLeisoTQpCHBbQBXcLDFJb+8Ah6cYDYNHTG/wzRx9Vh3kDI1HeNmaFgVy5e1BBqZXIwtuMhBY7SAnSl0ww1SA2N4Zp2AbvHunr3/qMPbzix60P0pW3t35hnu68XGhpm9+ic02+BS/Y/VYGn043u4kSudwP5tAMlJxLxcq3d2kAULWT4D3vBfeeScPNm2L50pLYYpMEv42i0pXgW+5dGP6Niz9TQnTTSMJ+t0m+9tXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY3/6g0u6cBNxXQ3+Mqy0twFahN4yc2JdvSXNVS/mg0=;
 b=ogyTu+JTeUzhXaZ+1B18cPO6q8okmZRgxujgX7aIEOnxhFzFDPa6kH0HQxEpVpuAo5hpGAiiy1pQVsp9Jc0G1R9nfio86iHvVsBXj3x02TYWiHHNRYRj3zP7Vt5FK1TO8OOMNBOPpfwpOeFO+anQQWT6JkiDwIpgmadSDSM2DfFzS9k4C97EOzv80dZ4ae3puUYgRup4A5QIcZk+8YujzeCGecHxjYhHLE8ZiSoOmQWWbPS8DYZMzAm++uVy1eJDPIh7Fq/sRyGL218NM0JH8qQEVDj6ymJ9++f8f8FjnRd+Vuew1TGuTLw2eLJLgLfxnMzYIKR4CKMbnUeOTTTmlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 13:04:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 13:04:14 +0000
Date: Tue, 1 Apr 2025 10:04:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: Bernard Metzler <BMT@zurich.ibm.com>,
	Roland Dreier <roland@enfabrica.net>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>,
	"rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	Dave Miller <davem@redhat.com>,
	"ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com" <andrew.tauferner@cornelisnetworks.com>,
	"welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250401130413.GB291154@nvidia.com>
References: <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: c24393b6-ab86-4759-10eb-08dd711db3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XD7fmAL4OFt7txBYsxC8NJas1kK2Ysh4EIyQtFedtpFVnJx7eFJSoVOYNloU?=
 =?us-ascii?Q?R1FHcV77KDh6yeOfJiiQ/hTBaASqb4qpRj/jo/hn+OB2iPzTLwPxdvh86Bjy?=
 =?us-ascii?Q?845Uop8cl8i8WHKwmL2/EBiiaNvoMpmrtH0hDwlWjY6OeUWCuxuRMZv1LJjd?=
 =?us-ascii?Q?NS5xicn6fpR+b+vySHHohXXyyHLEGNrSb2gEOcZWRIEMGrsZgTQLq3VCUqme?=
 =?us-ascii?Q?xGeQmTFtlNMUg87EcFIoh5Uf2YJmq6QMm6NUNzCZMMOlQzeX65E4fGObgdXv?=
 =?us-ascii?Q?3n1RX3JHZaDuHddQsVEO14y1zXl74uci3fjkf7Y+usOJoRsynTeyoT4racNY?=
 =?us-ascii?Q?ZtIkKAPs3sRdjhOXDgnkwGOACeOBjnCyAVeGW4lrrUS0dKVFYMIbXNvIbvoR?=
 =?us-ascii?Q?s2h9lDqET4e/xSuvEKK/IJLXBQaAIZdHvu7JIKPfv0QPye8Cat++39lbx2dN?=
 =?us-ascii?Q?hcUOOM77N9s+S0gDLq4HYmZAsnX9BeLQ/KHTd53aOvMVnsMTtwSTgKrFEfJp?=
 =?us-ascii?Q?8pbsZ4KsRgeDhdQsKIIFwoqMm0DkSZL7jGjCui3VL41SxXYm7lfeYGyMMwBa?=
 =?us-ascii?Q?NbCF2DIlV3vn4YXzXVaG75UwtENXYigiw31DLpzwt5iZnQuy6SeyTD6AIc35?=
 =?us-ascii?Q?F/9M73E2c0GteOYRkZX46TMYO+dSLFW01nKW3Div3ZjxDgC9Q4bOTXHv/KDT?=
 =?us-ascii?Q?0u3Atvo3Je4/3JzIyVpRj/JisGpPTFS5k6jvNgrnulsAmMh9O7wO8Z7mxb33?=
 =?us-ascii?Q?haURQqOoJJSictw0aIctQQJ6LTQFsW8o4rlu33C3Xe5Yj88YNC+tJeUtGFBT?=
 =?us-ascii?Q?CDa9s20mPP0OZaBIJ4IHhIGcswvPewZtPw3H7rlxMDivJMkPE0CLzwJT7z0k?=
 =?us-ascii?Q?sZCoiBMA8E9cN+rOYBr2Ty9UKC/auyEV1uKApWRYVakwBGCTUG91rcz3KPvc?=
 =?us-ascii?Q?wJty0ld/sL0N0MTlx2dAmMpoBkGi0OIBYOBaG8LCS0RRREZHltF4yHoPU7gz?=
 =?us-ascii?Q?c2VOBJOcUiLai10YiV7/WiiqU+K86PBVgxvUS5pA7cKWNGdPv1ZYa/etfGNz?=
 =?us-ascii?Q?HswI5Nm0KQL1lx8FNO7m0Jcpypwens73oI0WCy9J8QEgG2pOFBtGPvkIcpfK?=
 =?us-ascii?Q?QWu7LKza+hV5bX2XlgvxOZk22dUYgdXxRfgKzlSSCiQG5cU/yvXdHc/Ly6TV?=
 =?us-ascii?Q?2qoMljZWUAsWNAR/FhY5dT+sVmiwhfPu1QYqfxnHqyJGugQbBnlQtAp8/HlF?=
 =?us-ascii?Q?cg48lLK7509C+G4YEmMPk+SB52MnQY4PfKAb8Gy3WAxfFKvMnuxyI0M7gcG5?=
 =?us-ascii?Q?i6G5I7n2fT66xNUMxBgEyldY4Ye182yW68yP8eCKGPg3UYOM8ufKtW6zKvKn?=
 =?us-ascii?Q?D4o6S/AmxpFkzyDXQvc8QOnc+lXf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VKidv/EpUzWwjsMos6KRcdUCKRGigu7QeLj98NtUkOPRnCm2bFlHRqnYpjr9?=
 =?us-ascii?Q?z4Lg4rO6xn4UCOwWcDSMzsAu1pwlkVOwLIOghSFHdl/q7P3KM24sJQ/nEIKy?=
 =?us-ascii?Q?BOmmPHME/viu1pc3F++ki3Bhxt4bNeziNWQR/Vcp2PDkMGctWR3o3ZKPqd9i?=
 =?us-ascii?Q?121EFMav9QJAqKX9C1DnmzvNnRQ8RPR2WeGpUBjl6iVmWJ8CkE3LQWmxtqzt?=
 =?us-ascii?Q?q27Kpg1YLfhYRwCaspiV4bHUR+VIPmz2cT6XeeqjnfgMcj2aSTxcFepL55RP?=
 =?us-ascii?Q?bMRuLU2/cDw55dzGNp4qb9bKAbUTw41Lwmcg1qAwHTOi0TH1WRvLjhbKReat?=
 =?us-ascii?Q?m9PW/NNfk/z4Hr+VytdqDt9ZWWbbPtOqvMHVWhYNqQyTFIdq3rJAsEYeY0cp?=
 =?us-ascii?Q?vsxM5L9HXlH+Ge3D0UVSKg9PbgE4sQ33qNInpimksD2yFLrWMwkKCTwjoLC1?=
 =?us-ascii?Q?Db+J+Cn0vehu4U07QdIerSd7AIsrW5YUIeLviV3bfoWdqwgNmMqCPzNLNlne?=
 =?us-ascii?Q?CuHuS3o5mBfYfjWOL6hH/f/muZ6Yv1PJkCGZMT68SXCGqAQ6oz1fdMkVktzg?=
 =?us-ascii?Q?4+1v1M080Jp1bFn6H9B/KUtkzNe1mN6QzBmT8YiyNO545GT/C44n1TQtXbj5?=
 =?us-ascii?Q?aFgo3Y+tbizcGy32ZtENVb6Eq0/hFUzN4oNUnlCgtsqu8mVKzBvnGkM3k4WF?=
 =?us-ascii?Q?5gLtZoP50EFDReef1q7I/16mMcbqQlNtkiEuHd6ijPll9L2QKjZNsqf0t5dC?=
 =?us-ascii?Q?iQgEIqgmLd/EwdjvDe9A6XE0dTBuzzf/zgVagwpC5BU1/zhQqqh8tTkuYLBk?=
 =?us-ascii?Q?8uNOGcL2ZYKe0bTR/t4a/Nt34AGmLg6SRof7rSzG3BnSF6g7vE4ImVuGJ8/f?=
 =?us-ascii?Q?eRjgJXgyJnhHDzAlygQdOkXVeogQdYZMSk3FuWsvbnQzpsIFVYVozXQsBThN?=
 =?us-ascii?Q?ET5CH1mDOZgy/HMjBp0to1G0nrgQ5e2+Smj85BXjqz9GqJniRw8aKIlGLD5D?=
 =?us-ascii?Q?JFPvPcUYEZoK5ChG+JutTmngyekWEqF+kmVpHlSDlIC6qVhbaHe7/32+NWCB?=
 =?us-ascii?Q?Wr4jmgrrbMF9/OZLLIW3Vo4+ZoPhfA0XRrUHb292UXcUQEaxVV3o1Q1Knk7q?=
 =?us-ascii?Q?v8vXHMcJm+JdHae7PEHDMKVFfNpfVphqj5LCnEziOw4rBssGYqHV6oKilDeM?=
 =?us-ascii?Q?wdWu4qBqfVj1DpgjLs6t69H7QiTvjDef5CRdjfzU1yeMnD7n3IzPAz4x14VX?=
 =?us-ascii?Q?w8inC4Y8tivPs+vfpwjaiSzQeTkpBNUHhu2l0JzakSC3fIK1s13c9DoFgMNb?=
 =?us-ascii?Q?n5L3pJIs6x2/fWCOa2TlBwH7pnY5/cDcwtEFgTAJ9HYrD6ikf0EqFXR58xY8?=
 =?us-ascii?Q?CrnBVMLJ6ohUsrpKAFCEx3ETdaK4twUjmzcvHQV9Uy11EfVErXJ23dwXPzfb?=
 =?us-ascii?Q?Xo5Srtr7UmVsNQ4IYKOFUdfIkWsW7nO6mBYiU3wo5Pzqyv7QxYNyWCNsfhRQ?=
 =?us-ascii?Q?lT/G2ekRtRDV+QknbyXygiztZUIcW5phT7+/5OBndKXxpn4XZyAfG8NtVWkd?=
 =?us-ascii?Q?dkhOqEPX+Xpbv7rm57kXEjAnoNAYav1z6EZ5cj2e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24393b6-ab86-4759-10eb-08dd711db3c2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 13:04:14.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaQUiFunJpOm+IR5vQAaPJRW+r3WepaJqd2cHV5aACuyZoheEZgvfy/7sdEpOspy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463

On Mon, Mar 31, 2025 at 07:29:32PM +0000, Sean Hefty wrote:

> Specifically, I want to *allow* separating the different functions
> that a single PD provides into separate PDs.  The functions being
> page mapping (registration), local (lkey) access, and remote (rkey)
> access.  

That seems like quite a stretch for the PD.. Especially from a verbs
perspective we do expect single PD and that is the entire security
context.

I think you face a philosophical choice of either a bigger PD that
encompasses multiple jobs, or a PD that isn't a security context and
then things like job handle lists in other APIs..

> As an optimization, registration can be a separate function, so that
> the same page mapping can be re-used across different jobs as they
> start and end.  This requires some ability to import a MR from one
> PD into another.  This is probably just an optimization and not
> required for a job model.

Donno, it depends what the spec says about the labels. Is there an
expectation that the rkey equivalent is identical across all jobs, or
is there an expectation that every job has a unique rkey for the same
memory?

I still wouldn't do something like import (which implies sharing the
underlying page list), having a single MR object with multiple rkeys
will make an easier implementation.

Jason

