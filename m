Return-Path: <linux-rdma+bounces-3460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A60915A0F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 00:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F41B22AD5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC77D1A2FB9;
	Mon, 24 Jun 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oXhgEVaL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4F1A2C20;
	Mon, 24 Jun 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269268; cv=fail; b=EgMBnbMq5vF3cbVF99rEjvFYskViBd1uc6aIO49QDBSVAg23uM11xXb4nBa3ut1RIiXqRX/51WilnUDY/abkVqrCvbBeSS2Tl2//n+njJo4b9/NacF3R6TxOX5rgN+CnfA9pY8c5L8UY05y2WS9mNGYJPwUAw3BjaP8KZYcF1eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269268; c=relaxed/simple;
	bh=IeoLhhb+zoCxeiiOKUdFjzyHuZEVNC+Oq8b2bHfPr6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8UHu7IYfLdO4A635ZK7vQQL+DCZRF9dlP2X5rFQEjdM7ykLWuRkPtXQLR4TO3NkpsFleSFNaNtE61OkUaUvJXZTw7qTczCjmFZBhW8mRBYQQztczr0nrNqB15HY4arieoU8SubIrL8QYjFhcCYVc1gLdan+FtVpGDR2vIt2a4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oXhgEVaL; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFymqRFUATqhmK6AA90H3SMcDCjrAvIkbaPGByXHEblruMI16DBQhrOodCAE1NDj7UJV275givfqoZDH4u+bF+W617Zc7ue0unvhmU0bp5/LPDb4K4Eq92eWzFDCYaaIXSfd5h15WRVQs/pqzIo7ASHmHHki71+tHWz023auq8D+ZynI//2H6zB2WAuxSl6nHRwqwWFglUCx8Ma8yTUTRMKP54tQWIUI1SKhP0yP76xIH8yMXbGnZLy9VhOScIyfR/mBSEyK4sBxsIVS5EppsGY8JxLscERjB9a+0b+Seqx0LFLuqrjhcNJlDyA7Hzheyq7aXw/MpKXQ0KKhXU08kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsIA2qdFHiTn26g0sQU23Rb8YT422wDFfTLZZk4P7cg=;
 b=FzTmGA1iksmCF6zxDKAGUY/+1MyGFQVilv4mTV7+u4elXHb/OkJLajFZRGkbyNvPpGpLizPHZq9xjAuyERvpWR9reMk+MRGi5ar25MEG7X7Ar1AnLXrvrkl0/VFIRhEtQfyFK7CIJgIhin0T7GSwuRf7cehQw9oaiVvRb5aVTY7Pvbk9XyWstQiieWIYP8TJIiOak8JmH+D2eMlGF/4u3E6gD+4oFjO2Mshvs5oDxmMZ9xRktBJTncAR95rR66m/8vT2Gn7/CaHLSsqa6MfqXbc/JktB0GxhNs3LL8lVl8JwvQ1HZCSG+xrJsTC6g4rJ3P+ZppVDqQl76+fem9sjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsIA2qdFHiTn26g0sQU23Rb8YT422wDFfTLZZk4P7cg=;
 b=oXhgEVaLsjyv1RpYLFODe6V14iJXvaN6NEZG1Cl5eNV1il1+j7iGP61K22h2an4XrapXsT4I00rZn9AAeRODjwpLPWIuoiRBSEF3fvZd0Z8JrAkDb9ndWMa9h1mBkcznmTS/6NFkf4PJjHVD9rBHMTvMRF6i1NKNY1bBZ4LnxRNyaz9RLbhKiUn3mhvZ9oB42FzuJb97gyaOBQkjBqynFTxqtbCvBQbZzD5UZn9ORpC9MlIYic99UM5CHs93fw7eQweYeFT+ug4hDPTfTu2lUkHuvqWzKSjOIaK32YfhWMYg01d1g55aEcA6eJXMQc85KbZsDg87/BcWfxIHrhWM9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 22:47:38 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 22:47:38 +0000
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
Subject: [PATCH v2 6/8] fwctl: Add documentation
Date: Mon, 24 Jun 2024 19:47:30 -0300
Message-ID: <6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0302.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::7) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: f945b807-24fa-47aa-3b53-08dc949fa334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|366013|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXpBM1Q5dENnaExXUmNPWGVlMTlHMEVsaDJNdFBhdXBSQ2l2ZEwyQUtJOSs5?=
 =?utf-8?B?b2pxTGZ2ZlVCSXJVM0M3MFB2WXE3VmpZdE5kaUkySGFINUdiaU1KaTRqOHNz?=
 =?utf-8?B?ODl5bS9lVTd6MG1sUkRPRDVSZHFiQVA3VnJCOUd4OXJmUHNUeENYcmN6azFo?=
 =?utf-8?B?SGRyWDV5b2QwaUVURGo0MVFWK0JHYzR2d2xreTZKSnFKU0hqK3hqTlZoWDdl?=
 =?utf-8?B?TXJTSjhac09qelZSOEtML0N5SjVUMDRycGVIRlFOUFlqYjZwYXhSalNjMXpZ?=
 =?utf-8?B?RjRJSjRjYmlhZGE1dGc4VWV1K0RWdXpNdVM3MXlOMlNZSk1IQ1BBbkMrWG5N?=
 =?utf-8?B?eVJSOG5TeTVvUDBTTVAwNm5uWUxVbWI1NGhtNE5QY0RJR05EUWdEQTlXQWV4?=
 =?utf-8?B?NGdmaEgycmNwU2Raclk1NGVkS3ovMFBjU3JLdGppQnZKN0o2cmpEZkM3SmVa?=
 =?utf-8?B?SkJBck4zeDM0Ymh5K2lRL3lqSmJSa2Y1Znk5ZVp5S2RTN3V1WXI3aUo4cUx1?=
 =?utf-8?B?WTAyU1B2TnEzWHBNdHJiemNqNW9nSU8vbzlRWnBLUDA1QWR0b1ZPYmIwRVhL?=
 =?utf-8?B?OHBrcnpubFB0cW5QZ1dUdEJVbGFaVy9WVCtxSU1adXBzeGRaU211UE1TbHNJ?=
 =?utf-8?B?YTdhaU9UeTJkS0F2MllsR3lNSVNabTNNUVRHK3ZBV01KMkxUdlByWGRncnRG?=
 =?utf-8?B?YTFBM3g1RkZXdThISVljWjlNYU04ZUZ0WU1KWG93alJRcmI1VENaSUErQUVt?=
 =?utf-8?B?UGZQNStjTVZBclhjZmkzVDUyd3dpUk5qUm4wVVJYcmFUZzBabkNJRFd2a1Z2?=
 =?utf-8?B?RkxWRTZnOCs2TUN0eXp2eDVaaVU3TC9HYWpqazBBMW5JejJKTGtXeU1aTWti?=
 =?utf-8?B?bXBpTHNTQ0ttUW9mWlI3TEpmdDNwdUVFYlpUczZUdmYzbjExanFaYUY2dlpV?=
 =?utf-8?B?Q2RFdFRhL3d2c2xDQnAwTHRMd0U1NmFtemJyZ0I4Zm8rSTc3YlFFdVFSaTFH?=
 =?utf-8?B?czI2Zi9BSzFBY2VQZEk3bTJiMTVLOWpwTnN4Rk42WE1YdEdnL3M2NUx1SDhW?=
 =?utf-8?B?d1R5eTJjRFVrTnZNZ2dlSlpiOEx2ZDZsWjNiNmhFVE5XTmpJQXVCNUpNYVhM?=
 =?utf-8?B?amxnUjNsUE42cGN5VWRnTTUwTEIwWmVldEhmbzF3OG5hN0dGRVJyOE1GK250?=
 =?utf-8?B?bjI4TE9qVWxRRHczNHNzMjhsK3JTUjlxNU9ZSStYOWk1S0c4OXpZR0VlaUZI?=
 =?utf-8?B?UTFFSy82TDVuN2NnQWN4Z2pkOFk0SHROcDlIZEl2eFRMSjhpOTViRk9zcUFG?=
 =?utf-8?B?WkVIZ2Z4anBjZWVrS1NhT2hQTElyaEhXK2htb3gzWm5QZnpEaFI4eEtxOGpK?=
 =?utf-8?B?M0pxY0x3WDliNDMwTUlFTXljaDlaZlhkSkI2dVB1UEdoNDVFbC9rNzdnaUs0?=
 =?utf-8?B?Zk5tZTcrZ05HUnlSdGE4eXBEN0pGNFdVOFgyZkxHa1R0d3hJRm5RdHNqZys4?=
 =?utf-8?B?SnhUd1FWdXNFNHRZa0paRmlHMkJ3TFlObENuRXZsVnFtWnk3SzY1ZlA3c08y?=
 =?utf-8?B?SDJTV21UYi9QTzQxMG1YU2ViTGtPS1dLai9Hc1N1UytHbHdrN1Y0aVplaEJN?=
 =?utf-8?B?L2FodGFRVSs1aGRmTDF2VFdDWnRiTmszYkhTYjA1cERNdEVtOHo4VzRjNVdu?=
 =?utf-8?B?RUVnSFgxWmRrZXBTVklwWVhPcDE2N2VQemZMTFNCTzVCQnc5cXZiQVR1bXRt?=
 =?utf-8?B?bjYydENObTBuYVFHWFU0bzZUOTFBWjNtNUhIMk45bUFUUzVOU0dZWFkvMm1p?=
 =?utf-8?Q?51zoEAPXbUmxTLt9yeucglKk8Na+7efxdvjoA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L21oOEFLRnZsZ2FmRVVpZlAvMXZGYlI2OGNlclBPSG02SnhWTkdwUnF6YXVt?=
 =?utf-8?B?ZEhrS1NQZGU2SEdnKzd3YnhaZHl3NHk0TlFqbTBUWnpOTlp5ZkRzOEdrNHJT?=
 =?utf-8?B?Z0U5ZlQyNTM2a1Uzd0h2QW54V0kyS1VGR2NPRlBnTnVRK0h4dFNQVWFoOVBS?=
 =?utf-8?B?UG9LRHdIOVJvZkoyMTRJK1NGcVVqd0JKQm05amFnQTRIa0lYdzk0TUpiSEgr?=
 =?utf-8?B?TE9NZHJhZGhHdnppSjVUc1BsVHYzZ3ZJcm1mdjFUYllBMHZNVlIxTnhidkpJ?=
 =?utf-8?B?V0ZsSVl6RHdBQWIvbWRDV2JYYXhnT2k5RllzdThha2V1Ky9aOUEvOEUrSzlL?=
 =?utf-8?B?Tk00cE5wQ3cya3VsWlRzMHZGRU43SmtFY0NKMWJvY3k5c1psb0xNRDBqd291?=
 =?utf-8?B?Rk5LWnFjL2p1WkVqU1cxaWhZWEtaY0QzbTVQTzl1M0FvV3Z1Z1pBdzczUDlS?=
 =?utf-8?B?bFJlVjA3eFBiWVpMZEZhL2ZmTHZZWHE3U3NMZXdLTlJSZ1lKZ3lndVkrKzd4?=
 =?utf-8?B?a1VrYVc3bDZxMTU4amJ3VWhIMUVJU2N1VGltSk5tbGJsNGRpUXFaRFEwVVV2?=
 =?utf-8?B?VjhoSWFrU1dyQXVKNk5xRFEwZW4vdGNESWVCZmlRVGNjSUx0S2twNWNhNzcz?=
 =?utf-8?B?bE53eWJiVE1HSnFMdkRxUllSUGRiNDdGVy94TTJlSjA5VThQdEYvMVJKOUZq?=
 =?utf-8?B?YTRybmhJeHdyNG5ZM0xnNENON2d6Q21qamdLRjNPOFpZcVI5TzlqK3dXaEcr?=
 =?utf-8?B?SXRES0pVUnY1L2h0WDhJcVN6SWNkYzBHejYzemZtUytWY1FuMElLdkZkRFor?=
 =?utf-8?B?Uk5BYmJZSld2NzF1WkFuWlk4V2FkL1JZSWdyZVpPQmlZQTRvY09sdkpVSEZF?=
 =?utf-8?B?UnAycTdEZVNlQmpZb0FYRWw1Yy80NzZOaVJGWkNOa2JjY09BM0lNalhBbW4z?=
 =?utf-8?B?MDNyN1VwbWFuTnVKTzhCWjdXbUFXV1p1SGp5YUJUejV4ZEp0WWw1MHB4Wldv?=
 =?utf-8?B?V2REMVRIYUM4Zkdzc1ZkVjdVSDdldTZNSm5zTFc2WE8yRUpTYnF5T00xQlQy?=
 =?utf-8?B?VVE3NCtoa29yUCsyd3NGVHExWWpCUXlDdXFEMk9rejZCRldtUkxuUGJJeFY0?=
 =?utf-8?B?THBqVzI1MTIrYlFZc2xieUFvek5HQ3RmWm1NTnR4eFlIVk9vaUlTcTlXdUVY?=
 =?utf-8?B?VktjYjArMzI5angrNmxmYld3blZFYWlRZXRKd0c5ZjQxWkx1a212R3RpMXpp?=
 =?utf-8?B?ZmZYOEJSRytnS1lreHF4SnJLL3lBdUh3dE0vTXBIT3JBNjJLVU9PQlM2VkJs?=
 =?utf-8?B?NnNyWnIzSWgzZXZDaVEvOVU3dURoNjV5bDlMdWZEQ1R0dytZUFYxbG9xYm5G?=
 =?utf-8?B?Y3V6ckJERHUvYzVWclIrQkNWZDRQUlE2ZXEvVVhpeG10Uy9TeGJ6QWNndDU4?=
 =?utf-8?B?ZUZ4bDlXWjk0eVA0TjRNYTExdW1rN0NsRDFrNk1FSWV2VWpBd055TWlDWFJN?=
 =?utf-8?B?VnBHNnRSU1BNV3dzSW5LbUNrWnRVZ0tFWVNORzd1Nm9lalpmK2l0OVYzeW11?=
 =?utf-8?B?RWlocjlIN3ZkbHdqelVsY1VZbHM2RWdZeFlMVDFkU29uY2hNOTRPeUUxQi9q?=
 =?utf-8?B?ZENZL01XT00xNFdadXRSYnZ0QUMrSFVSUlhwVTkvRk14MU5QTm5ZSHQ3WTJ1?=
 =?utf-8?B?N1A2RzBqWU9uN0srNWxOMzc2SUd3Tlh2VkVRRnkrQmtKR0dFZTNTdzl0Q1du?=
 =?utf-8?B?ZlJpRkw1VmozTW5NUHlNbXBVSmtaT2JURlh5eHRwMFlKbEl3blpVb1RJeGpn?=
 =?utf-8?B?Y1l0UlBQbThNY0FuYWNDSVV4Z0FrYnFLQlZGd3dxTG9oVncvcjlTMm5KYVI5?=
 =?utf-8?B?aXh0Z3IzcitndlNHZkhQTEQ4Yzl4ZTV4R1V2d2hmc0NNTHhrWlE0SitrRDFi?=
 =?utf-8?B?WVIwYW83czlMeUJVMzJyMkhvVTFDMURudU9FWUVqZXU1TnJGSHhMTmdEQkJS?=
 =?utf-8?B?Qi81N1U4cW91VjQ1ellsM3FVeEFmNFhtL01nMWd1d1NIdDlVVXN6bHFMR3Jp?=
 =?utf-8?B?eFc3RTBvZDRVbkZyY3F6OUhjNWlaNVMwenV3RWd4dm9MWEh6NnNxT3lHanhC?=
 =?utf-8?Q?GVZ0XYjVXeICrUGZ1ZwICJk0K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f945b807-24fa-47aa-3b53-08dc949fa334
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 22:47:34.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+B6lyDDhRwwB9G+EPv5n4u+PXIz72/khjStsld+NT3Vl+TC/NqLsSxjw9yLxMXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

Document the purpose and rules for the fwctl subsystem.

Link in kdocs to the doc tree.

Nacked-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20240603114250.5325279c@kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/userspace-api/fwctl.rst | 269 ++++++++++++++++++++++++++
 Documentation/userspace-api/index.rst |   1 +
 2 files changed, 270 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl.rst

diff --git a/Documentation/userspace-api/fwctl.rst b/Documentation/userspace-api/fwctl.rst
new file mode 100644
index 00000000000000..ece2db2530502f
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
+software-defined pieces of hardware. The evolution of this approach is largely a
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
+industry where single pieces of silicon are now configurable software-defined
+devices and can operate in substantially different ways depending on the need.
+Further, we often see cases where specific sites wish to operate devices in ways
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
+support, and FW-driven functionality that is not well suited to “generic”
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
+In the past when devices were more single function, individual subsystems would
+grow different approaches to solving some of these common problems. For instance
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
+device today may broadly have several function-level scopes:
+
+ 1. A privileged function with full access to the on-device global state and
+    configuration
+
+ 2. Multiple hypervisor functions with control over itself and child functions
+    used with VMs
+
+ 3. Multiple VM functions tightly scoped within the VM
+
+The device may create a logical parent/child relationship between these scopes.
+For instance a child VM's FW may be within the scope of the hypervisor FW. It is
+quite common in the VFIO world that the hypervisor environment has a complex
+provisioning/profiling/configuration responsibility for the function VFIO
+assigns to the VM.
+
+Further, within the function, devices often have RPC commands that fall within
+some general scopes of action:
+
+ 1. Access to function & child configuration, FLASH, etc/ that becomes live at a
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
+That stretch across all subsystems in the kernel. fwupd is a great example of
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
+device design must already provide for isolation and cooperation between kernel
+subsystems. fwctl should fit into that same model.
+
+Part of the driver should include a description of how its scope restrictions
+and security model work. The driver and FW together must ensure that RPCs
+provided by user space are mapped to the appropriate scope. If the validation is
+done in the driver then the validation can read a 'command effects' report from
+the device, or hardwire the enforcement. If the validation is done in the FW,
+then the driver should pass the fwctl_rpc_scope to the FW along with the command.
+
+The driver and FW must cooperate to ensure that either fwctl cannot allocate
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
+commands or push a kernel patch to block entire firmware versions/devices.
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
+ - CXL also has a NVMe-like vendor command system.
+
+ - DRM allows user space drivers to send commands to the device via kernel
+   mediation
+
+ - RDMA allows user space drivers to directly push commands to the device
+   without kernel involvement
+
+ - Various “raw” APIs, raw HID (SDL2), raw USB, NVMe Generic Interface, etc
+
+The first 4 are examples of areas that fwctl intends to cover.
+
+Some key lessons learned from these past efforts are the importance of having a
+common user space project to use as a pre-condition for obtaining a kernel
+driver. Developing good community around useful software in user space is key to
+getting companies to fund participation to enable their products.
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 8a251d71fa6e14..990b4c0710c99e 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -44,6 +44,7 @@ Devices and I/O
 
    accelerators/ocxl
    dma-buf-alloc-exchange
+   fwctl
    gpio/index
    iommu
    iommufd
-- 
2.45.2


