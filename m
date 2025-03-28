Return-Path: <linux-rdma+bounces-9027-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC68A74C6D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 15:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85A73A9980
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 14:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F952188A3B;
	Fri, 28 Mar 2025 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QOMtFZaY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB2B1F5E6;
	Fri, 28 Mar 2025 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171805; cv=fail; b=c6VyQnd+unvULOCHSiU/15vxQXjkc/C635gae1fW0z7k30LL4gLauvlp58i5YyGoV71LXd3t27Zpn0ids0osCMAEMsCylTJPsmDVviNAfX3+Ld9yB2LRjOVljqf6Jp7F2IG29L/iOhbu1WU58P32cT8WckDGOdySw20GfJUU+IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171805; c=relaxed/simple;
	bh=0oePHsNnybVbFMyakF1//mel5F+WVBM5eoUveYezl6s=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=A1uQRg3yXIWlmmXthccchlm5+TEV2QgKnHv6Qbky7V/MezkiDl4Tcih2zgYmCxsdYE5/uqUWPvjrSThVDol/+ysBLm3J5kG9CVZjcKLVvhQM+8mUZiA+xirNS05RvPZ+ZTfayYz9IGVZ9XHgKmU/VDhzN6fG/pQKusqgR8u//Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QOMtFZaY; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5Q68D5tCahIcrXY2E7m+gyS6nP+TX56A5PGjDg0hxQHaiE1Adr0vHdI8AzS31uIQW0B72d4izLXzh4YAGb2EZH+I4I0YE3XXf0avM8x4N715dRKVyD1EqP9Fcwblh3FH++tgJmRZX+LwPtqEp5KMPEdg0vvaeTmV2QmlU/cxczL2WqqFWKaKlv3BE6AWUmn3QWEqdqjFRUl337JqcUEyhKmgcwG7Y9F+HOZRSrLwJ4lHrsXsZabxwI5q+4CuHuFbv/O+3sWqIIw1tyYcCzQR1kjhvyGmJdP/FQDowPOoT6+2Wi7gu5CUFOkIRz7N+i4s8VCKfSfMJtYk9kK/XjXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3dZxCqjv1VLU2291Rb+o5DoddNBH5p1YJ6o/6rOV30=;
 b=bp3UqUD6jtnZii7KPLdWWYy5fzfKoAhiDQbz8Y7HxHRbhJ7kP9uythFTsP6H3nkJF6mVE3XrzLtzQyLEp25v0DnrOhL6R8E75CPRk0GqFdwFJ+RR1UZb2txu0364M20Xrv/RzKCt3P/VH6kIJxqJrSbsfm0OaJSwDEQnnib47OfPL0S9S89HV9wftW4JBkY+R5E/F/A+oVpVMRvtspS4/auN7K4Gr+AF//H4yz0Mi57YStE2Tpcg2ivncvRnehj+x1xuPzCIXWsLersq0MTewjxRogw3QjPzDvaybgCEORGyzRuJAnYdgtTqyeOeDF/Jvv/5ZQncxucHNYuk4IfNnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3dZxCqjv1VLU2291Rb+o5DoddNBH5p1YJ6o/6rOV30=;
 b=QOMtFZaYpC5J9DO+Hqgt2n8pR8vsztpWAgD9upqKlTJ5s+GENPwo+mT7hmFqpWblQPwShXQDy4pGs6aYV4IPpukLEp9/hI9liBNJlDAj+4K7t7tna64Nbn6s1vHClpgtJHOeIznZPkjuQ06ON+XWxOmfbcdM7kgZjL2bqoz/9HR2+v6BlEWGpYs9WQJSSPprZBdZniv1QGpk/01DAmpFp8JehagTA9HKKoiCoHKkAjCgMWdGAnHFbuclSUqkzGqVSYCOPDf7qVZRL2krpk5lsViyq/fIXHTzTeSXHvdQJOOm7wgBUPv00L/hU2BroUPFfsbMXOi+C/hKhmDIMBnwnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 14:23:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:23:14 +0000
Date: Fri, 28 Mar 2025 11:23:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250328142313.GA117859@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="21LmU7luxyFCll4Y"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0278.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: f7202310-ef02-4bf1-2f84-08dd6e041398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajhrcXB4UWlVSlhPVVg2Y3hhNE1rSEVPaGt4QVgweEUvY251dEpnOGxOL0g5?=
 =?utf-8?B?alBMcHQxR2FYRGxJVlozTzZIU25iell1VUs3VXB6TXI3emswM0lJMy9jUUJv?=
 =?utf-8?B?N2NPVkNuOHZWaGc2V3l2bHBXbG5UVng2alo1SDNiamI0ZE5HRHJ3aTNkeis5?=
 =?utf-8?B?aDZ3a3dYTmlVb1lteFB2b3RoSGlNMmRWSHlJRFRKcGdrVlJJc2t1bk5hRXUv?=
 =?utf-8?B?alNrekNQVWI3ejVCRG9vU051QWJnaW1jekVUc1NEQVVONlZ3elNudTdqUXlW?=
 =?utf-8?B?cFBDSFUybWxESHBselNLc1NRMllxUEhRZWdTUEFDdlN0TDhWNFhlMFdCYWpp?=
 =?utf-8?B?b1BadVlQd1lZcmdhLzFZQlNkNGhYT3Zhd2p1THo2alp5NFlYc0F3SDdiQ2dn?=
 =?utf-8?B?WGVEUnZIZ1JseWNMVTJXRE5Cd3lGUjVpbU5YdTN4KzJ0eGRySVAyV21UelYx?=
 =?utf-8?B?ejFFc3UvQnMzOGQ3RzMvLzJNQm80VTdYVklRTzZibVNEOWQ4T0FwNnVFU1A2?=
 =?utf-8?B?YmRyWE8xK3BFTmlnb2tDRWZaMG8vT2pkUXZZSytkQURhWUI4MVBveS94SjV3?=
 =?utf-8?B?akRoYzduT0RMVUY1VE9DUVEwdkEvc0RudzI5bkRXc21kRHIyZmdaR2dSVFR5?=
 =?utf-8?B?QzY5UEhiWHk4V283QlE4SElFdE9tQXhVa1FmbFhUdHFaUG5pM3BmUXBGcFVt?=
 =?utf-8?B?VzdNYjBaVVdZa3BtV2xBR2VzMGRpci9RaW1qZXp3WmNRNzFMdnE2dUg2Nkl5?=
 =?utf-8?B?WGJKUGorMlZpdllVaHFXVmFaY2dFUmJIb2w3SFpWaXorTkpqSnFzQVJUYjlW?=
 =?utf-8?B?NmpjL0lwK2J6bzMyRnZDSU51M3FZVm5yRVRCMW15TEU3MllZcTNZdFpFZE43?=
 =?utf-8?B?NC9xaWovSE56NzZYZVhkb3VWVFlURXl4SUlKQzBKem0vR0E1SHd2c2VONFFZ?=
 =?utf-8?B?b0xYd0NkSVJQNWJUeDkzMndmZDdCMDFFWFhNOWZIeDNTVklpTzk3RzRTWG1X?=
 =?utf-8?B?Yk96eGdGZk5xdkdDUDEwS2pQZlNvVXdrSjA2dkRYRE9Oem9LU3pzVkJoK283?=
 =?utf-8?B?Q3JkeFRlbFVFUWo1aThCelpqUjB0ZzhFaUdxMEVKdWpuQnlGU3gya0tLWVJO?=
 =?utf-8?B?N3N2aDN4aHhEa3JSYXlyYkVqVHhScmwyS1g2RVB3VTd5V2g4bU52aFYySHo0?=
 =?utf-8?B?VElNYnRkQnhUNnZobEVGWEtWUWgxQ3hyZk5NNG1Dc2pqcitOTFYzSXBYUEdE?=
 =?utf-8?B?UG9lVVdkMjA2bVdSa3g0NmNoTHZDeEhFaFFkczRRMkh6SkVXSFJMaWhTNURP?=
 =?utf-8?B?NzBjRDNBVXVUYmxMOVVKcytlK2FwSklvSDdiSkwrWHNFVUR4VllRTWt6THNY?=
 =?utf-8?B?ZlhaTnQ1Y01yVi82ZUNHVUkvM2hPSStuNVY0a21jbHJSemh5WWFoMTNmZVlR?=
 =?utf-8?B?U1FJWTFvWjJWMHQxcVh6cmJPOGt0QnR3QWxubWJBUXNaaHJBL3ZqVTExWXZ1?=
 =?utf-8?B?T3VKblRjWkZlOC9kQmlMelRvMzIrUU1zaEMwRjBzT2hBMUI0dG90VExtd1JU?=
 =?utf-8?B?UUE2TG5tdE81WnBoMzVlbDBsK0pzbHpRRmFoTkNib1RoanNtbEV1cVJMNVp0?=
 =?utf-8?B?cHNFUnhUTlY4Y25FeUFrMmppQWJFN3VYQWlHdHVLdVpvelppakNHOFZNbDNY?=
 =?utf-8?B?am1lcXVCVlA0c1lQVGdyU3ZNTVVVeUVQNCtRZEpXdFppNXUwVEl3aVJYcExq?=
 =?utf-8?B?cTQ1UXUvZTN4Z04zMkhxU05EOEtucE1XMEtJMzZBR1hIQXlWSDNqdmdZL3Zo?=
 =?utf-8?B?SmNxR1ZPeFFMUGk3WmVWMTFyclJjbnVveHhOZE9TbWhxa3g2US9jT203OWFY?=
 =?utf-8?B?eFlQK1Z3TStwSkpIZU1QWEpVRGRqVVgzZi9XZEhYaHBQSklsQS9HamNHWFhy?=
 =?utf-8?Q?g44V3MI4RFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVFiYzdZd0VKREJJNDBBQXdodmdGSTh6UU01bGovWWg1cW94YVVqWXgvc1NH?=
 =?utf-8?B?djVqR0kxMUNKOUxMcllvSmpxZndjRC9UN25FcDFzTVUxWkZPbFpVYkp6OWFw?=
 =?utf-8?B?R1lETHZMSithMEdkNGhKaEZUa2lrMVF4L0Rwd0RiYUZ6dDZUMCs5QTlWd0dn?=
 =?utf-8?B?Z0lUVENvdzRvSmQ3a1p5cytSTlNhdUZ5a3dRTEJvYUdxZWZ6RjlEeDVqWDBt?=
 =?utf-8?B?QW9xTEtKanJyMlRUQnd4TFdlS3ErTFRXUFZ1cmtvczZmcnJENzlNWmhSeGlL?=
 =?utf-8?B?aDA5aWdsUFdWMWpNVmZiU2lJQVhmNjN0TnN1Sm4zK1FMVGRjL0c5WElSTnNS?=
 =?utf-8?B?Z3Y4NUVEYnhZbEhsbjl4UThXdzYyN1RVSFNuYWVjQVcxZk16ZDBLYkdOVjdM?=
 =?utf-8?B?VGVvckxMeEF0c1BCWFdCTlhFNzYwYkxtemxZZ3BLZHVKWEovb2JWR3Q5N01Q?=
 =?utf-8?B?ZVVCWFpZSE9PQXFMMkNzVzJabjNRL3hlRXdyc2JuT3B2NCtNc2VJT2NYUmJP?=
 =?utf-8?B?RTROTHZ4UWtmbGMzOXpDY2k5ak8yMEZHZWU4c3RPcHdPRU5TRkZ3N3lWdWdj?=
 =?utf-8?B?L1p2MklpcUlCczU1bkV4am1aQnZ4cng0aE8yUlVoak5QVitWTllsK3NrOStC?=
 =?utf-8?B?cU1oMENNZW4zakpEbVJkMS9FN3VuMGdqdzFPSEMzaW5lOE52czNyVXZxdks5?=
 =?utf-8?B?TWVLYkRNeDJaZ1Y4UU5yT2cwcUFGdGdXZnhUQXpxdG5vNXJRemZCQzB0WVA0?=
 =?utf-8?B?a0FBRi9PTWEvRzZTbEY5N0N2Yk5TeldmdmY1MzhhN0xyMmZDSEFTTDRqTk5X?=
 =?utf-8?B?UkEvSHNOb283WkZLWjhXZHdpQndUSjB6Y2xsMmd5ditzMzRyb0hlWmdLU1RO?=
 =?utf-8?B?d2RmSWJtT2NwT2hITnNnQVFONjM4VGowUERVdkhXaGV4MjNiTXV6VXNKaDRz?=
 =?utf-8?B?ajMyUzJSOE0xaWFEbWhGWnRLTHBxV0VMOVVkekd1MkpKYktMZUZ0NWdEY1RR?=
 =?utf-8?B?RFdYdTVTWTdHUkxzWkdNMkYvRFJWWXNEdDZQTFVzZFVkYWduRC9BWUtaVUVu?=
 =?utf-8?B?RDI0MHJ6cEdPa0lBSk01Tzg5MkFtU2lGMGFDZTJjd1B0UTQrWlR1SzhYMUdB?=
 =?utf-8?B?Zk9MejNsNXVNcXl0N2J4OHdHcUNVbk4wTG54dUxZYmExUWY4UjBuRnhoYjc5?=
 =?utf-8?B?NkhEVXVSdEVFdytzdlBSOGdRb21qNXN3eDE4K1RLQ29RS3hleXN0Njl0NmFP?=
 =?utf-8?B?WFpKV2pUQWwyNEp4Rmd6SzNOaGpwZVNhSlppdXdHSVFaVXZSdFBSR1E3VDla?=
 =?utf-8?B?Z0dCbjU3Z2JIZ3hWTHBnbUhpbzZQN0p3TXU3K05GNjJKaFJsUVJTekxnd0N2?=
 =?utf-8?B?MENTOG5WdkZCL21ZK25INzR5dDhSWlF1VmFkS3lyS0ZzQWE5WkN1WVZudldk?=
 =?utf-8?B?NHkySTBMb25pNVIveUFqUVErZ3o3WFdpZzNKT0E1VnZnaDFuYUhEbjBXS2xu?=
 =?utf-8?B?bERITkRyNjgzRjdXbDg4WjJ3SGVZSmw4MmFKMkE5aVdHcytEY2V2VWtzbmZI?=
 =?utf-8?B?L0g1SU1BSDBhRUVvQlV4azFwV1BtL2h4UTBlRC91dWI5RjJmRjloRU54Y3B5?=
 =?utf-8?B?S0N0WlRKVUVyUUR5SVFGVGY0K0ZSc3hGTGJZOTNNa1NMWEpINVhBMmZoK21Z?=
 =?utf-8?B?UHVkL0F3U2xCTEhkWDh6NDJqUHN6eUkrKzYvT2NVUlV4em1OZFRpZkJ2bHBD?=
 =?utf-8?B?UGVyNk0rcTVSL05URWIzY1BQdUlWZzFiUFlkcW9IQ3dYSXJtZFo4UWk5cEZD?=
 =?utf-8?B?bzJzbEFJNXJnZzRleXlmanJkMkdNVlA4OFdRN0IvcFV2OTF6WVFsR0h6QzZ2?=
 =?utf-8?B?eXBHU3FIQ0Nvc3Q3OVVOcFNCVjROZDN2dzc5elpreEZPTlhRZXpIU012Undq?=
 =?utf-8?B?dW9CbjlydndUdC9MUStQcGZ2ckxwNy94TEdmTHJnSlVvaWhENVhYbkE5andQ?=
 =?utf-8?B?K1E3c0ZkNVB0aUYvS2NaZGUxSEdKbkZSMzZhL2JCY3h0ZWtPVmNkYTluLzRS?=
 =?utf-8?B?d3BPUXZ2UVhESXZLVnlZN2lPb09TYTZITGtkdUVMcUN2bWp6S2F1THp0K3Bh?=
 =?utf-8?Q?PcTCrAS+xOQAk29rvC0auXLG+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7202310-ef02-4bf1-2f84-08dd6e041398
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:23:14.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEBz0d+R1AWMHWlMSwJd5L01zYC8aeF/+BtR+YtQCJEFJnxCCS4zHk6e2N0uebXR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174

--21LmU7luxyFCll4Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

There is a bigger merge conflict in rxe against the rc branch. I've
provided the for-linus-merged tag with a merge to v6.14 containing
the resolution from linux-next.

Here is the diff:

diff --cc drivers/infiniband/hw/mlx5/mr.c
index 2080458cabd1ca,753faa9ad06a88..b7c8c926c57870
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@@ -2031,7 -2023,8 +2032,9 @@@ static int mlx5_revoke_mr(struct mlx5_i
  	struct mlx5_ib_dev *dev =3D to_mdev(mr->ibmr.device);
  	struct mlx5_cache_ent *ent =3D mr->mmkey.cache_ent;
  	bool is_odp =3D is_odp_mr(mr);
+ 	bool is_odp_dma_buf =3D is_dmabuf_mr(mr) &&
+ 			!to_ib_umem_dmabuf(mr->umem)->pinned;
 +	bool from_cache =3D !!ent;
  	int ret =3D 0;
 =20
  	if (is_odp)
diff --cc drivers/infiniband/sw/rxe/rxe.c
index 4e56a371deb5ff,e27478fe9456c9..c83e2cf8274814
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@@ -71,45 -72,10 +69,39 @@@ static void rxe_init_device_param(struc
  	rxe->attr.max_pkeys			=3D RXE_MAX_PKEYS;
  	rxe->attr.local_ca_ack_delay		=3D RXE_LOCAL_CA_ACK_DELAY;
 =20
- 	ndev =3D rxe_ib_device_get_netdev(&rxe->ib_dev);
- 	if (!ndev)
- 		return;
-=20
 +	if (ndev->addr_len) {
 +		memcpy(rxe->raw_gid, ndev->dev_addr,
 +			min_t(unsigned int, ndev->addr_len, ETH_ALEN));
 +	} else {
 +		/*
 +		 * This device does not have a HW address, but
 +		 * connection mangagement requires a unique gid.
 +		 */
 +		eth_random_addr(rxe->raw_gid);
 +	}
 +
  	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
 -			ndev->dev_addr);
 +			rxe->raw_gid);
 =20
- 	dev_put(ndev);
-=20
  	rxe->max_ucontext			=3D RXE_MAX_UCONTEXT;
 +
 +	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
 +		rxe->attr.kernel_cap_flags |=3D IBK_ON_DEMAND_PAGING;
 +
 +		/* IB_ODP_SUPPORT_IMPLICIT is not supported right now. */
 +		rxe->attr.odp_caps.general_caps |=3D IB_ODP_SUPPORT;
 +
 +		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |=3D IB_ODP_SUPPORT_S=
END;
 +		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |=3D IB_ODP_SUPPORT_R=
ECV;
 +		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |=3D IB_ODP_SUPPORT_S=
RQ_RECV;
 +
 +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |=3D IB_ODP_SUPPORT_S=
END;
 +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |=3D IB_ODP_SUPPORT_R=
ECV;
 +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |=3D IB_ODP_SUPPORT_W=
RITE;
 +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |=3D IB_ODP_SUPPORT_R=
EAD;
 +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |=3D IB_ODP_SUPPORT_A=
TOMIC;
 +		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |=3D IB_ODP_SUPPORT_S=
RQ_RECV;
 +	}
  }
 =20
  /* initialize port attributes */
@@@ -141,18 -107,13 +133,13 @@@ static void rxe_init_port_param(struct=20
  /* initialize port state, note IB convention that HCA ports are always
   * numbered from 1
   */
 -static void rxe_init_ports(struct rxe_dev *rxe, struct net_device *ndev)
 +static void rxe_init_ports(struct rxe_dev *rxe)
  {
  	struct rxe_port *port =3D &rxe->port;
- 	struct net_device *ndev;
 =20
  	rxe_init_port_param(port);
- 	ndev =3D rxe_ib_device_get_netdev(&rxe->ib_dev);
- 	if (!ndev)
- 		return;
  	addrconf_addr_eui48((unsigned char *)&port->port_guid,
 -			    ndev->dev_addr);
 +			    rxe->raw_gid);
- 	dev_put(ndev);
  	spin_lock_init(&port->port_lock);
  }
 =20
@@@ -170,12 -131,12 +157,12 @@@ static void rxe_init_pools(struct rxe_d
  }
 =20
  /* initialize rxe device state */
- static void rxe_init(struct rxe_dev *rxe)
+ static void rxe_init(struct rxe_dev *rxe, struct net_device *ndev)
  {
  	/* init default device parameters */
- 	rxe_init_device_param(rxe);
+ 	rxe_init_device_param(rxe, ndev);
 =20
 -	rxe_init_ports(rxe, ndev);
 +	rxe_init_ports(rxe);
  	rxe_init_pools(rxe);
 =20
  	/* init pending mmap list */

Thanks,
Jason

The tag for-linus-merged with my merge resolution to your tree is also avai=
lable to pull.

The following changes since commit 15b103df80b25025040faa8f35164c2595977bdb:

  net/mlx5: fs, add RDMA TRANSPORT steering domain support (2025-03-08 13:2=
2:49 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 37826f0a8c2f6b6add5179003b8597e32a445362:

  IB/mad: Check available slots before posting receive WRs (2025-03-19 04:4=
3:03 -0400)

----------------------------------------------------------------
RDMA v6.15 merge window pull request

- Usual minor updates and fixes for bnxt_re, hfi1, rxe, mana, iser, mlx5,
  vmw_pvrdma, hns

- Make rxe work on tun devices

- mana gains more standard verbs as it moves toward supporting in-kernel
  verbs

- DMABUF support for mana

- Fix page size calculations when memory registration exceeds 4G

- On Demand Paging support for rxe

- mlx5 support for RDMA TRANSPORT flow tables and a new ucap mechanism to
  access control use of them

- Optional RDMA_TX/RX counters per QP in mlx5

----------------------------------------------------------------
Cheng Xu (1):
      RDMA/erdma: Prevent use-after-free in erdma_accept_newconn()

Chiara Meiohas (6):
      RDMA/uverbs: Introduce UCAP (User CAPabilities) API
      RDMA/mlx5: Create UCAP char devices for supported device capabilities
      RDMA/uverbs: Add support for UCAPs in context creation
      RDMA/mlx5: Check enabled UCAPs when creating ucontext
      docs: infiniband: document the UCAP API
      RDMA/mlx5: Fix calculation of total invalidated pages

Christian G=C3=B6ttsche (1):
      RDMA/mlx5: Reorder capability check last

Daisuke Matsuda (7):
      RDMA/rxe: Move some code to rxe_loc.h in preparation for ODP
      RDMA/rxe: Add page invalidation support
      RDMA/rxe: Allow registering MRs for On-Demand Paging
      RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
      RDMA/rxe: Add support for the traditional Atomic operations with ODP
      RDMA/rxe: Improve readability of ODP pagefault interface
      RDMA/rxe: Fix incorrect return value of rxe_odp_atomic_op()

Dan Carpenter (3):
      RDMA/mana_ib: Fix error code in probe()
      RDMA/bnxt_re: Fix buffer overflow in debugfs code
      RDMA/mana_ib: Use safer allocation function()

Dr. David Alan Gilbert (2):
      RDMA/hfi1: Remove unused one_qsfp_write
      RDMA/vmw_pvrdma: Remove unused pvrdma_modify_device

Eric Biggers (3):
      RDMA/rxe: switch to using the crc32 library
      RDMA/irdma: Switch to using the crc32c library
      RDMA/siw: Switch to using the crc32c library

Guofeng Yue (1):
      RDMA/hns: Inappropriate format characters cleanup

Imanol (1):
      IB/iser: fix typos in iscsi_iser.c comments

Kees Bakker (1):
      RDMA/mana_ib: Ensure variable err is initialized

Konstantin Taranov (16):
      RDMA/mana_ib: Allow registration of DMA-mapped memory in PDs
      RDMA/mana_ib: implement get_dma_mr
      RDMA/mana_ib: helpers to allocate kernel queues
      RDMA/mana_ib: create kernel-level CQs
      RDMA/mana_ib: Create and destroy UD/GSI QP
      RDMA/mana_ib: UD/GSI QP creation for kernel
      RDMA/mana_ib: create/destroy AH
      net/mana: fix warning in the writer of client oob
      RDMA/mana_ib: UD/GSI work requests
      RDMA/mana_ib: implement req_notify_cq
      RDMA/mana_ib: extend mana QP table
      RDMA/mana_ib: polling of CQs for GSI/UD
      RDMA/mana_ib: indicate CM support
      RDMA/mana_ib: request error CQEs when supported
      RDMA/mana_ib: Implement DMABUF MR support
      RDMA/mana_ib: Fix integer overflow during queue creation

Leon Romanovsky (2):
      Merge branch 'mlx5-next' into wip/leon-for-next
      Add support and infrastructure for RDMA TRANSPORT

Long Li (2):
      net: mana: Change the function signature of mana_get_primary_netdev_r=
cu
      RDMA/mana_ib: Handle net event for pointing to the current netdev

Maher Sanalla (5):
      IB/cache: Add log messages for IB device state changes
      RDMA/core: Use ib_port_state_to_str() for IB state sysfs
      IB/hfi1: Remove state transition log message and opa_lstate_name()
      RDMA/uverbs: Propagate errors from rdma_lookup_get_uobject()
      IB/mad: Check available slots before posting receive WRs

Michael Guralnik (4):
      RDMA/mlx5: Fix MR cache initialization error flow
      RDMA/mlx5: Fix cache entry update on dereg error
      RDMA/mlx5: Drop access_flags from _mlx5_mr_cache_alloc()
      RDMA/mlx5: Fix page_size variable overflow

Michael Margolin (1):
      RDMA/core: Fix best page size finding when it can cross SG entries

Nicolas Bouchinet (1):
      RDMA/core: Fixes infiniband sysctl bounds

Patrisious Haddad (8):
      RDMA/mlx5: Expose RDMA TRANSPORT flow table types to userspace
      RDMA/mlx5: Add optional counters for RDMA_TX/RX_packets/bytes
      RDMA/core: Create and destroy rdma_counter using rdma_zalloc_drv_obj()
      RDMA/core: Add support to optional-counters binding configuration
      RDMA/core: Pass port to counter bind/unbind operations
      RDMA/mlx5: Compile fs.c regardless of INFINIBAND_USER_ACCESS config
      RDMA/mlx5: Support optional-counters binding for QPs
      RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow

Preethi G (1):
      RDMA/bnxt_re: Support perf management counters

Roman Gushchin (1):
      RDMA/core: Don't expose hw_counters outside of init net namespace

Selvin Xavier (2):
      RDMA/bnxt_re: Congestion control settings using debugfs hook
      RDMA/bnxt_re: Fix the condition check while programming congestion co=
ntrol

Shiraz Saleem (2):
      RDMA/mana_ib: Query feature_flags bitmask from FW
      RDMA/mana_ib: Add port statistics support

Wang Liang (1):
      RDMA/core: Fix use-after-free when rename device name

Zhu Yanjun (3):
      RDMA/rxe: Replace netdev dev addr with raw_gid
      RDMA/rxe: Add query_gid support
      RDMA/rxe: Make rping work with tun device

 Documentation/infiniband/index.rst                 |   1 +
 Documentation/infiniband/ucaps.rst                 |  71 +++
 drivers/infiniband/core/Makefile                   |   3 +-
 drivers/infiniband/core/cache.c                    |   6 +
 drivers/infiniband/core/cma.c                      |  24 +-
 drivers/infiniband/core/counters.c                 |  52 +-
 drivers/infiniband/core/device.c                   |  20 +-
 drivers/infiniband/core/iwcm.c                     |   4 +-
 drivers/infiniband/core/mad.c                      |  38 +-
 drivers/infiniband/core/nldev.c                    |  18 +-
 drivers/infiniband/core/sysfs.c                    |  15 +-
 drivers/infiniband/core/ucaps.c                    | 267 +++++++++
 drivers/infiniband/core/ucma.c                     |   4 +-
 drivers/infiniband/core/umem.c                     |  36 +-
 drivers/infiniband/core/uverbs_cmd.c               | 163 +++---
 drivers/infiniband/core/uverbs_main.c              |   2 +
 drivers/infiniband/core/uverbs_std_types_device.c  |   4 +
 drivers/infiniband/core/verbs.c                    |  13 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |   6 +
 drivers/infiniband/hw/bnxt_re/debugfs.c            | 215 ++++++-
 drivers/infiniband/hw/bnxt_re/debugfs.h            |  15 +
 drivers/infiniband/hw/bnxt_re/hw_counters.c        |  92 +++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  36 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   6 +
 drivers/infiniband/hw/bnxt_re/main.c               |   1 +
 drivers/infiniband/hw/erdma/erdma_cm.c             |   1 -
 drivers/infiniband/hw/hfi1/chip.c                  |  18 -
 drivers/infiniband/hw/hfi1/chip.h                  |   1 -
 drivers/infiniband/hw/hfi1/driver.c                |   2 +-
 drivers/infiniband/hw/hfi1/mad.c                   |   4 +-
 drivers/infiniband/hw/hfi1/qsfp.c                  |  20 -
 drivers/infiniband/hw/hfi1/qsfp.h                  |   2 -
 drivers/infiniband/hw/hns/hns_roce_mr.c            |   2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   2 +-
 drivers/infiniband/hw/irdma/Kconfig                |   1 +
 drivers/infiniband/hw/irdma/main.h                 |   1 -
 drivers/infiniband/hw/irdma/osdep.h                |   6 +-
 drivers/infiniband/hw/irdma/puda.c                 |  19 +-
 drivers/infiniband/hw/irdma/puda.h                 |   5 +-
 drivers/infiniband/hw/irdma/utils.c                |  47 +-
 drivers/infiniband/hw/mana/Makefile                |   2 +-
 drivers/infiniband/hw/mana/ah.c                    |  58 ++
 drivers/infiniband/hw/mana/counters.c              | 105 ++++
 drivers/infiniband/hw/mana/counters.h              |  44 ++
 drivers/infiniband/hw/mana/cq.c                    | 228 +++++++-
 drivers/infiniband/hw/mana/device.c                |  82 ++-
 drivers/infiniband/hw/mana/main.c                  | 103 +++-
 drivers/infiniband/hw/mana/mana_ib.h               | 210 ++++++-
 drivers/infiniband/hw/mana/mr.c                    | 105 ++++
 drivers/infiniband/hw/mana/qp.c                    | 245 +++++++-
 drivers/infiniband/hw/mana/shadow_queue.h          | 115 ++++
 drivers/infiniband/hw/mana/wr.c                    | 168 ++++++
 drivers/infiniband/hw/mlx5/Makefile                |   2 +-
 drivers/infiniband/hw/mlx5/counters.c              | 195 ++++++-
 drivers/infiniband/hw/mlx5/counters.h              |  15 +
 drivers/infiniband/hw/mlx5/cq.c                    |   2 +-
 drivers/infiniband/hw/mlx5/devx.c                  |  41 +-
 drivers/infiniband/hw/mlx5/devx.h                  |   5 +-
 drivers/infiniband/hw/mlx5/fs.c                    | 637 +++++++++++++++++=
+++-
 drivers/infiniband/hw/mlx5/fs.h                    |  17 +-
 drivers/infiniband/hw/mlx5/main.c                  |  77 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  23 +
 drivers/infiniband/hw/mlx5/mr.c                    |  52 +-
 drivers/infiniband/hw/mlx5/odp.c                   |  10 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |  28 -
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    |   2 -
 drivers/infiniband/sw/rxe/Kconfig                  |   3 +-
 drivers/infiniband/sw/rxe/Makefile                 |   2 +
 drivers/infiniband/sw/rxe/rxe.c                    |  40 +-
 drivers/infiniband/sw/rxe/rxe.h                    |  38 --
 drivers/infiniband/sw/rxe/rxe_icrc.c               |  40 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |  35 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |  13 +-
 drivers/infiniband/sw/rxe/rxe_odp.c                | 326 +++++++++++
 drivers/infiniband/sw/rxe/rxe_req.c                |   1 -
 drivers/infiniband/sw/rxe/rxe_resp.c               |  18 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  24 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |  42 +-
 drivers/infiniband/sw/siw/Kconfig                  |   4 +-
 drivers/infiniband/sw/siw/siw.h                    |  37 +-
 drivers/infiniband/sw/siw/siw_main.c               |  22 +-
 drivers/infiniband/sw/siw/siw_qp.c                 |  54 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c              |  23 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c              |  44 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |   3 -
 drivers/infiniband/ulp/iser/iscsi_iser.c           |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 120 +++-
 .../ethernet/mellanox/mlx5/core/esw/acl/helper.c   |   2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/legacy.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  | 178 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |  12 +-
 .../net/ethernet/mellanox/mlx5/core/fs_ft_pool.c   |   6 +-
 .../net/ethernet/mellanox/mlx5/core/fs_ft_pool.h   |   2 -
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |   7 +
 .../ethernet/mellanox/mlx5/core/lib/fs_chains.c    |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   1 +
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   7 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  22 +-
 include/linux/mlx5/device.h                        |  16 +-
 include/linux/mlx5/driver.h                        |   6 +
 include/linux/mlx5/fs.h                            |  12 +-
 include/linux/mlx5/mlx5_ifc.h                      |  53 +-
 include/net/mana/gdma.h                            |   7 +
 include/net/mana/mana.h                            |   4 +-
 include/rdma/ib_ucaps.h                            |  30 +
 include/rdma/ib_verbs.h                            |  30 +-
 include/rdma/rdma_counter.h                        |   7 +-
 include/rdma/uverbs_std_types.h                    |   2 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h             |   1 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |   1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h          |   2 +
 include/uapi/rdma/rdma_netlink.h                   |   2 +
 115 files changed, 4433 insertions(+), 703 deletions(-)
(diffstat from tag for-linus-merged)

--21LmU7luxyFCll4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZ+awzQAKCRCFwuHvBreF
YcTvAQDpCsAZwG5oCBH3W8MEwBmZ8e1Y8ZZt2qB9hfXWcoL4lgEAiqxI3jehV0XN
sxFP6BoR8zWhkozIhWAQ0G/Kw5caLQg=
=RP9q
-----END PGP SIGNATURE-----

--21LmU7luxyFCll4Y--

