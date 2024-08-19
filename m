Return-Path: <linux-rdma+bounces-4420-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F02395735C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 20:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BC2283574
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04518950C;
	Mon, 19 Aug 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eGCHG8IU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2094172BD3
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092428; cv=fail; b=T/HFAXV6RcOyYTNDzRZTB/Ak2YraRVhUXMOGQri30lkeXnc2+w2/Xd+s+tbFcT6EIaLfhaUQn7rh/puRAETtip3IxXAkAyetvjWehckj44aIWvsOi05oFTjLV2fZ2KYUfjHkGts0KRZJ9cb26R0BNlKBf5JacPuM5GYXFknRPm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092428; c=relaxed/simple;
	bh=z0PEPqMFPM9n1cULRgh9TVRktepP86h3wI7d4OgUJHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nb88Enx+GEc48SiyIX67oVGlmLGN/pkYvIMp7gvuoDdR0xq53L7uif2tZLg/i1q4eLSLtn++/BLIZV/zuZc0RcXeiQw1FSo8Pycep2jqSIOYp0lya9/iqKzYSdmLv8eQBfT/W+V+nBpaqOrBWLkUpG29OX0FqQujCT+BOAWqVUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eGCHG8IU; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfE7dgYJBKsn72zpf6YWO+qxE3/jRoI2oHlGBE2XS25sQhqFHsTCVD9NYkHCADUy8UPbk6WxmT1wTYapCSHcZfKmAkQDQiXG07M7kHJoR4AcT76qF2YvXroohPTxeN61Gpzju3Mnl2qzlHyk04xoaTCumqc16vcwhHEVF60yWk8o40JNLNuBQUVM4m3Ee/YWdUYAY1G3So4sF2rmjtn49vRlQnKRLLoirXK0hkK/BBfZHnl5aFOryonzHkTt8gtPgR0F9lki/cRfkNiV2Hj3vnNRjvt8d7G3ymDkTDO7gQfCfp0ulATAuqP0fceCbdsZhRo7tdpBGq+BireBLtFURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4kFr4ENHq5n2iRFx74wP/mk7ksYnDEr358ijOmMcVQ=;
 b=K+G+rbBSZ19PQPSeuC2T/eXF0uvzuhcKrW9QpQZHEIUwfFYUsTVeSrafPXbZnsDDwHziwzIrpIf2uAxd++XBw6/s4uDTOhbrAaIMdQ0dXeOL5SxapxigZYyae7e0CACWez7Tx1Tm37SAfeNVsD28OywLapaLxq0ugeknWAql1RRwIhZb7Xnwl9AinF8CTex+x3e2kh3bqk6Cu3W/Ysn92CXtXSbXIHACV5L2UZDQaa1lR4VmPIjQnmv2jxe8/CHKBIm+nUIgAP0lSumqc36wlsJ3u8S+DH7HzqkH4RQf0+ZwqQPCHG6XvF9DSto76VNdfyG0wOTK347aBSI6iOUVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4kFr4ENHq5n2iRFx74wP/mk7ksYnDEr358ijOmMcVQ=;
 b=eGCHG8IUsnPe/PohAinyAs7NZMNKUlyXts/YZRJXU2exvS+Kt5ooqdyNkO1cpqJCmdYF1WIHKC7/sAgBRoyGgQxOh2goLa6m2a3VOgvnqQxlTgcJ5Xwnv4i5t66bHPY0r//g1ThB4OhJcgNNUIrbKIjX4Li799qlv/62kHkphNMFfEeSWSAziyRIGipN3ADkbNCLvIAD2oDsSzKoRaqU8nga8rYAXzj5Rfjf091vy4HNuI38x72tggZxgSczXJ4lvuBLCKLP/+KUzUHw5GqeHUy2mvIWjU0x3EydKFzIt3fzrBQTRNzAmcwZozMc2YZJlYNquAhQrCUrr99gqFjOhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:33:43 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:33:43 +0000
Date: Mon, 19 Aug 2024 15:33:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: leon@kernel.org, phaddad@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] RDMA: Some clean up in header files
Message-ID: <20240819183342.GB3482615@nvidia.com>
References: <20240818055702.79547-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818055702.79547-1-zhangzekun11@huawei.com>
X-ClientProxiedBy: BN8PR04CA0043.namprd04.prod.outlook.com
 (2603:10b6:408:d4::17) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: caeaf92e-4893-43df-c902-08dcc07d73f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bjYaSe2asUUtCnxCuTZkERKap+sqJjx1x429i4wZAeACf5/odDw0kQJGnT5Q?=
 =?us-ascii?Q?Cgv/DLg807pX0qG0r2e8uZnhPocSHqhpDk92osUjEiqOlP7UVMheeIVPmxfI?=
 =?us-ascii?Q?HwRx4x1Jd+N0J0WmABvy6D8HPWTfpxyL0LAHdDFiVOi5vH/YLtJzrwGKOLIF?=
 =?us-ascii?Q?tg7/2yIr4WpTIbWCnJtJumSveIkYUkZDRqZSl/vCqjIeZ14RuC6q7ygs4Dv0?=
 =?us-ascii?Q?91/Gode5Ag5bVyZQ1SSnKq6IdcXu4iE2oFxGdzlWBF6SGP1jpPiKYM53LV39?=
 =?us-ascii?Q?p0MRixUcJF4SK/egdH8Wf2Z3tNmsF/Fjq7AULQaj8ZfxOBIFwdulYOMugN3i?=
 =?us-ascii?Q?ydOlKJrFfrfNZ4l88Mwv5P7d0MQ4L/6EFJl0dWl3xwrO0V9wnk7RGFNLWypk?=
 =?us-ascii?Q?nQqpr+eLddITXPwIvJ6LxXAZxbRlnwsPtvTOGuR8CWhI3B1ImErN2TZ+oXVn?=
 =?us-ascii?Q?2hgQMtQNFkiwNcN+Hg5ugD0SxAccFmHHkDIoBMV0Z1dyfw8r5nIeGi/wYD/f?=
 =?us-ascii?Q?RyC859fPO7hKWYTDn0ORPC9Ko+mU2fwQKRpO+VnqLuxzXNR5jj5SK3UjRRk9?=
 =?us-ascii?Q?QEbHFFaqGLtzRkb5WcohLvW+lswrC/XtczyKWlSb5FDsgSVTMZSAN8uRDY12?=
 =?us-ascii?Q?9q8kTj3q9N0qjBGI6M7Q5XenBUedwDk9Qu8s3Hgei8gUlyZIyAYmd+rZqvPL?=
 =?us-ascii?Q?4HfnDiKoiZb1JkmJURTjcQWr1vDgQGlBJFRB5I4NSahzu9jpyLV0Wb6cVKor?=
 =?us-ascii?Q?azDmTf5mlAKkKnjo85ggzSjFsYAOxD+4Afb4c9b+tmCJxqXR74tOP37GNpfS?=
 =?us-ascii?Q?RjQozIFsjXx8bSSKsoHRhmDpzvoWiAuk4vhoHH5yD/Qq3SSEPxwTPQzf/njE?=
 =?us-ascii?Q?SElruOuY17Eh9/P5jh8S2DEo23y+H6fDFMOItyo+y+5XknHRbQiNlQYr3R+T?=
 =?us-ascii?Q?+Worxgo7OjEJSVWo7Pn0mJUJ3a+Q0B6e80GCNjID4If5n1nMzQaMLbi4a4KB?=
 =?us-ascii?Q?4RPSg5MDHNeV9t58cXoK76Pps1ogAn/AnmkHex7POtCRXgdPrgo1n4cZ2G08?=
 =?us-ascii?Q?Aw3O7Y4pP22icqHUms5dLhH5QQnUH7wn+OeLshfU1CDi1NhLLC/CEOZrKQyI?=
 =?us-ascii?Q?4fHi3qA2sxDZbJqH+bLe+EH4kmzJKW0ayvVeo9t7zE+Un2ZFIX4c1qoR020b?=
 =?us-ascii?Q?SUXk8qAUDt91XyHdbggluWESN+xKjoAaz/gaOc4G2i1R5xmtE1kBLTKdX7BF?=
 =?us-ascii?Q?OeJI6hKFOf2YtQ19nZ+zGCLUtcYc50rLzZJ40S+HqYMqswUYQRCoaUedPvX1?=
 =?us-ascii?Q?Obc6I7zfcJFEycPdn4VM5qtzrEWMQTMfL/YqvliYxnYPAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GcjS8FX+M1KhtvKQ+mDMDGa1Ob7j+EDKLFjc64g+0bbbBeObD208UJaG8GLG?=
 =?us-ascii?Q?0/sQQ37SKHDpRqbe5loxcBmVVLgaBNINe41bB3seALy4666YcYoV2CsoKQJ1?=
 =?us-ascii?Q?yg8UHUJkjV9AWmM2ucvPLgPOrl7tmK7LrTrEWTSuKLCjBWKqUY3HIiadB5U5?=
 =?us-ascii?Q?XOofgTlvOxHGoXIpzDeIVP1tWVIkjKCZv9jA+Y0dWABm/WwFz1L96Wsm996e?=
 =?us-ascii?Q?hHEinTw00cebMn+IGnTEkf0ZfQqkuajRwiTRckzKEO9eTH/Q5kKBHNMoNkX+?=
 =?us-ascii?Q?HkrB7HuPdIn0bFE3LTtM751gqIsUp7JKn5SYPkUbvnTQ0h/9d9EFKEpQxc0N?=
 =?us-ascii?Q?IDNIUvC5ce4IfKfmYP5lpC1SVr8FdttkJrlCTbYE1gUiUwjZzKrAg9f0sTYG?=
 =?us-ascii?Q?lHc9aZNDNwuVq6JdFjrCqIeRRno4glSoGn5TKnonhCa+WEz14usxCpPa+DVF?=
 =?us-ascii?Q?cQV+9hQeUsGIklPyQ3m8eZEwkRCfeMM0cFe0W5FMQ5ABqxDsLNO8D8pFVOJk?=
 =?us-ascii?Q?39y+MWk3pZHxbv4notct+5Xuol6+HQ3ZGQZDi9RTQzcXWtKAoDxePohXJpFq?=
 =?us-ascii?Q?MYsl5h2b7Eu//IrZu2bkzTXwz7yRfRt7RBjRxvp8QktkBp8OjqnBFhmDhZRl?=
 =?us-ascii?Q?Znid/kQvoMQbV0NFSFC1eA6u1cFGDDlLUrjYo9f0Ch4f+qzWAXvZShE42odH?=
 =?us-ascii?Q?NinJO2Q0nhlzyf7Y+gVcobENUWsVfrtuuVjupX/y74XnQxR1B4ABxW/69Ero?=
 =?us-ascii?Q?NzAsUO48QJshJ1bjneGTB/633poLo2w9ibLWRN/FWEJwt7LDZ5lnceO5OTag?=
 =?us-ascii?Q?wzfyav58qUThLY7D25g1ifY5msYqUT6OcfnX+0o1WCtpYH8HbCoRt1ryYSpd?=
 =?us-ascii?Q?ilFMdJItQgsaDKm1mjskjdM9yX6CRocdfZdslRkD7/5CUbkDmvkp07+1dbkw?=
 =?us-ascii?Q?qDQeqmUnMDLJhY/AYwbyYPmQPi4crRt15f2psE1XM5uvh4VKZ+eSFGFCFNP7?=
 =?us-ascii?Q?EW5LXRozVSd7u+Fi9S933rGb+kRgGBNnaJf0kvc6oslc+vPUM4+V2+fjidjT?=
 =?us-ascii?Q?9krX02+fgJmuQPupoSOqeQBBh19TlsGpUk9y0lnM2VBkw024g31E55ASgGbY?=
 =?us-ascii?Q?wAfEDiWQuaAVoE6v/lEiPY4Yvuj46QJ9Vc/tbo/7YV2fEguZDnpIg/a9YYzZ?=
 =?us-ascii?Q?6C0iqJ1uuJL7nbawb3pqToRwKxj9PEUB4Ic/7ocDxv3mW5uTmsdWZ4UksXyp?=
 =?us-ascii?Q?5HaR5qBzSa3WVz6COKrN9s79XdTYoazfy/EfgEZPQaBLX/5rCVXMc/nm++Q9?=
 =?us-ascii?Q?Eef2/8fLHdgFUsFumoXID3qwyRoFpnF2XfVALrdKx+nNv9w6RaMYeKifEn72?=
 =?us-ascii?Q?NuWZyccmuWU+v+ZVsD1m9NHo0n4LKBhmuOBUdS3BIzizdv8L6UXfZohNWbzJ?=
 =?us-ascii?Q?FqUE7ECi8u7EAlYr07BOrnU/pkQ8XoDd2OKd0I2ngd/F3U5b0IvFoNhB0cie?=
 =?us-ascii?Q?3YbZqCjwz+xtiHoEA5VqIRVLqfjwzns2r4lgGJGsfYPbPRatd3kmdILWOv03?=
 =?us-ascii?Q?KcKmLQCP4zjgRBMbyDahtk194fZgQoW2XkBZfyv8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caeaf92e-4893-43df-c902-08dcc07d73f2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:33:42.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NH64909+fKFSErvOPiv1ImRslpeV+nWvcJNfPx8upMzJ6IjfzhyDER6b4yviyDWg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427

On Sun, Aug 18, 2024 at 01:57:00PM +0800, Zhang Zekun wrote:
> There are some unused declartions in header files. Do some
> clean up to remove these unused declarations.
> 
> Zhang Zekun (2):
>   RDMA/core: Remove unused declaration rdma_resolve_ip_route()
>   RDMA/ipoib: Remove unused declarations

Applied to for-next

Thanks,
Jason

