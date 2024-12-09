Return-Path: <linux-rdma+bounces-6341-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D29E9EA8
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 20:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72676167C2C
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2F219D8A8;
	Mon,  9 Dec 2024 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PIL5zzR2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A27190685;
	Mon,  9 Dec 2024 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770562; cv=fail; b=rfg7EsSwKnq8jfwQYxV8DOt7P59Hx3ApwjkOpCOBgsMdXjxPm2+1rfDiy7gE4ZLvq11TW+605dFiJ8ol0jkRaxiXwYjSSjd78aDRvdD/A4VSqTHighDeEdkgC53h8BXSnU36tr1jPrBRJSi2cqUDUL6M4hFFlOs0mMCBE/PC9x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770562; c=relaxed/simple;
	bh=baK/X+pR5BKxiEmtmRL8F8KlO9yGWw4/RCVk1V/2IIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OC+bPtlTqALjSyRmOLVNrKz3LnwrO3lxYq2xjCs2Ez7VUASCP/PUKNrEpnEDY6CsULCPw5iF9xFTAhTTzZ2XCRmDcYH2X/QGyahp80jAfZAnZMjwXUUTqodtdZkZ6nZhaPrze3eBT4gDnarqUhnygwHpiKGM3y7tUHZA8spiYy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PIL5zzR2; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiKyVzDULEgqN+lfh1U5JVXP83ECexfiovmczbLZiFTAgBUGou2HQHK2Q0D5v7mP6um/wLq6G+c+AWrgqMftbww0wk8ptnxJhe36qFp2j3mQ0yoZuP27DBykf5UoUvboN5RbpFLiFn9cW1mRSeS/g57V0VUtZIoXdGi4KcdOVn62Yg5zKR2gCziHBAkjEN1Xn3oE1ahIzpQG6tzn1Ush54QShqOwckW1aFLMw5P/FjC649b+lkoP4ij09XTXSKop6+VpSrH5odKIzXApoR7nfA6spzDDcLzlutT+iM22irwfy80+tQVLU2dZtCeIUbAaP7Tk7uD03uAPI4Q3agfH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0Jr0aUfla813UeiRm1RhhWmFpQRl2PZnurwH/1GyeU=;
 b=Ihe7BkAp++48eEfYME6AN4cGLQamb2YQo3wErmf1GCjfgQg4Njy3htWLjgJrDycLXonYrttEY2MyjwTtwSwjk/oR+Vkjxwa7d90k6Jed9XB5zr+Lnues65bNN5puiPD2dOlVe+L91oWunwfgJm9Y/xH56VBnnpUFhCRjgCWzz4JyWkPqMxifnxMFspG8qpyUWTUBHPaignvB8xHT+oshuWzdTIGVMzDxPfP+d18vyblH7LFzs9beASJpUr02td7m/23FZVxq97ZtkZmL/FI8XRyO9BNyMPXL2+HM8JpgfAQvol2IKv1/tNTs2g7CB/vXj9RAtubb+wgZVXAkZ2zLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0Jr0aUfla813UeiRm1RhhWmFpQRl2PZnurwH/1GyeU=;
 b=PIL5zzR228l9QXqQZy6DHR1ol1EAwJp6C+pKSOFwQm3AtAHWZQ/1jEDItTi6afD3ij95jpqK1oHBaTyVEI3/NGxWq0JJWU1/BBF3ZA4gpTWLcB7DvLtKGOA1QqeE0cyVlmSCUJX0ab7ZSNDCMoi2IF1PoakHOzfgmOWtP4N40W2webLGs6gTKbH9BfMWiMtr4vhMysDzRg5cdVmaJ7cE7+7pS20F410dA9fXvlmPiDXLrrGa59kjA4i7Z5kUXbO+Z9MYG4kGO2EQEZNJ6gWl75npY2GbjfcXTp4iqdBjyQXpZ29n+zHh2FRASVTQvA2E2KEsU1HZPbfBhilLvceAIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:55:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 18:55:58 +0000
Date: Mon, 9 Dec 2024 14:55:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Atul Gupta <atul.gupta@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Casey Leedom <leedom@chelsio.com>,
	Michael Werner <werner@chelsio.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxgb4: prevent potential integer overflow on 32bit
Message-ID: <20241209185556.GA2367494@nvidia.com>
References: <86b404e1-4a75-4a35-a34e-e3054fa554c7@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b404e1-4a75-4a35-a34e-e3054fa554c7@stanley.mountain>
X-ClientProxiedBy: BLAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:36e::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f410bd5-bffb-480d-8e8a-08dd18831db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n8AdM/3R27H4zVO89N3yy6TGG+o8YS466VruW3KJ77ii2xjNY0YJDxcsL1mW?=
 =?us-ascii?Q?iOVGnBhB6CyD0lhfwZ8boGcF/QX5nK47r9Sxq9dhO/24fyZEkhA9any8lsyT?=
 =?us-ascii?Q?y42i/ZZVWnzrlDSFgVCnaLSKCGd/MwO6RAaSNqyD8krorL7If7qIChhHY51o?=
 =?us-ascii?Q?07qZ1iZeUZiDv6FUMLgGwDtlKOMzGGayvYyxu30gaBqphm+2BDhQ9DsdNPFB?=
 =?us-ascii?Q?gpRbDiHTJXEv2UXNHjhBgZcSS0KMlvernAyiUsPTcDorNy6Z/xYmaRTS1XqU?=
 =?us-ascii?Q?IItEpDPXHK8yAftoUw/drifqsvMCNg0bTzfN6NB2dmNwWRvj3uDg3Ocdfzbq?=
 =?us-ascii?Q?BCpXX40oJ/0TlsRN4Onb7m+UUZY+AnAs82ukOq6nU3HEackF/w5btrNCsRwr?=
 =?us-ascii?Q?tQPxl3BPoT4w9BG9I2LANcH0hET0Oo/Z4UD8MzacwJ/kHLXRMjFF263Gl+Eu?=
 =?us-ascii?Q?uM2eHizrBSp+nSkpNOGRZjVWOGJods4lT863X0BB0yiqbOX71wh6/hB+fnyp?=
 =?us-ascii?Q?xtjZ97e9O4BrOs7I+Z0mx0sk8XYMg6inOHD3St3e/DmqZKXYl8PVIYRXK9q6?=
 =?us-ascii?Q?IS2yyeXwm/iXh5DrA875eVHxBR7Cw7kVYkwPLLTPHGDAc3tX45LEcqm7gADi?=
 =?us-ascii?Q?kBC1AbCs83glPClLiZJbjVQbjhYte0nvDaTr5xAnZHTzXuu1k2uBt2w1hlEN?=
 =?us-ascii?Q?Tpc1hPfGWzFiiDZXwq2yLG6xyyfl4/ehI+NEfs5XhhTwvY5W2cVYHbalJQwA?=
 =?us-ascii?Q?eUVqlHhSbNlql1dwC+Z999KYdmwvKUk5dteYdb5sYAcqK3EzZOph1yhibgsK?=
 =?us-ascii?Q?uHu7egl0djCJ/0TuPf43bKMOWmNYRi84A5ny7/Wo+G8oRYJtXddFrFMGY7+f?=
 =?us-ascii?Q?Cx/ayo6sdiEmEqj9Vmexn8b8SqGa20CP/9HJsXmI1CZFPQ/UbMbxUhdy65I0?=
 =?us-ascii?Q?DcDkhys3LyTYbrf7xZ4f7klKrMvgUpNiDWKuwrRwz21vhXEJEqth3cTte28Z?=
 =?us-ascii?Q?IT1ApNxGeRqJgkC1ai2/lqV4HyT4Dc/YbKCtYbVo3uw3oETE015cgfT5wxG3?=
 =?us-ascii?Q?me14in/EEfdQS8GyTzLjqQb/r5bMgMdyt+7IUFJhmG7rlTHfFD68ZhjF2Ox5?=
 =?us-ascii?Q?vSFk0gWy1wEuk6eW3s3iLkjGaWlcrhwIi1hicS1OjhGlJQB2qgpyebwX5bGu?=
 =?us-ascii?Q?Dmz/rTjgpj2/Zt1sstOrRXFr6GQKWDL8LjZCwcbZPWx7k6/TtLTfUOdv610r?=
 =?us-ascii?Q?uFtV6NTDzzG7Kjx65QpJMDGAH2G1vzRpuM1roeAs7NE822/IpIbkzhxsCU8V?=
 =?us-ascii?Q?0jXItNOjXPzEoL9KM4B7wgO/Qw9y8zL+MoNzaLTOw4fY8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TkdXBZPVddbRWHROwZtzHhSFs8OWQPG+FC02D3XalpCiA2wrTKW4n3Gipe/?=
 =?us-ascii?Q?690bbZRydsB/OBAPWhOc55h8LxauapSX4h52y0uGvPh/lZ5jBDwGBjYd7vEK?=
 =?us-ascii?Q?Q2JTFxxgye9SPzqP2+6yQkWPIcEBp5iyORD4UfJibVkOZqJWdJTWKthPmGFP?=
 =?us-ascii?Q?ggKRjFAcDjQ6onNaH963DIty+0zMKs5MLUu8icW7KiuszYPTiCbSVTNZErwo?=
 =?us-ascii?Q?C9t7NX6QIqY9YA0q6TaeyPJnBBKp52JoEQmxNB/qCJnEn0Oa9AHOXDG0FpaN?=
 =?us-ascii?Q?7sDDYnP4Py8qKk5WWUTKhuBYANDx3FQKQv5Uo+PcdMROmS2ruD3gboRXrKSI?=
 =?us-ascii?Q?reIRj3rpStAovDMkQixsdFy8nwK3/LZgFoWgE7Xloj1Yv0kOYxxj3GPyvGVg?=
 =?us-ascii?Q?VS4IJWofKtlJUYwrjW8DK3E8nJ2NnEurTqW/g4cY+OUNcXqGrhhFyTtG4xai?=
 =?us-ascii?Q?lyBf2d2Ws7NP8BUoLFZWFgo0f/HQYsJpnedB+UuBFuU1+FdS/HgE0f3rwfnH?=
 =?us-ascii?Q?MYaRGdbo8zonmD1HQj6evyrkLcr0QBV0HqtdyG7AxVbePWNmeAn4XTgHe6tY?=
 =?us-ascii?Q?vsNRB8MpL4ceHLbHK7Vr8Pc1vsXGSsL03pXFhB24XEKmTu8WuwuMU3kCpitM?=
 =?us-ascii?Q?5ReN8JKj/dUffQh42hs+oFSCgDM0LEEJj/2jNnJJ0BZyCJukdXJFmX42GXmu?=
 =?us-ascii?Q?gjefdrevAsY22Xy4lqshlXFiHo29IOEznma4usMEj+Q/KuOx3gxbQNmNSGj5?=
 =?us-ascii?Q?GBT8JQDDTNGB9Mhx2VVOUgvpCGfvNprFMsQ89YH/rqCzREB8i0T9+2Yl0qwj?=
 =?us-ascii?Q?yeago8/vz+aybt67e2aFnb66GAJ3qCDWw2v8fMgFLnjiSEZq9Vz+d0bjccQJ?=
 =?us-ascii?Q?Sqnb201IRvqrYYcV+c7EueGxXPcNTfU10xCvUX2IxrHLVP3pm2HKKCozDpv6?=
 =?us-ascii?Q?CVrROjMFlaXqtkMWyWhfAA3VOIwSeYK53c1boe9VtTw7Y4aeeuR9v+GN3NHe?=
 =?us-ascii?Q?12jxcsAj2kOSHYAATQnzJTGlLVNB/Xg1qiRICWPdu2SG/oyisrYTTCk+wljO?=
 =?us-ascii?Q?QPsn+woKoDk50cvgoAI7qe2FzjtmkNInZDGvV2ok7zFXHHardn2D50BmAzDb?=
 =?us-ascii?Q?dYL7uo+F1y7vxeQNh0Si+it/euobtSym50g3thcbSNMpdH+Eq/ul3eFykH4N?=
 =?us-ascii?Q?8/N/zADC3bFQebKImonuSl37mshO9K1pVsuApavHq+muvs7x+zjfVM3xdOF3?=
 =?us-ascii?Q?Iv+1dlz0hyDqVb3xgilyfervfuBF0EReiQRksL/Nk2A3c9yRt57ls4XD3R9j?=
 =?us-ascii?Q?HYkHinlVG/hszLyvV8zox/IYdwD5ttq29EyaSpxOQA1BVhTXspmDPsOhIbkd?=
 =?us-ascii?Q?SV5cQdcnxOEDjxHGs9D738R/4Gfq/9Q4lsSIvvaJfXY77xCafN6KxtEUuBC1?=
 =?us-ascii?Q?RSsRdwjd+PjVkgOTt3qeo+yzZe/HyayKSTrFpBfcY8NXxbV7ubsZBbzn3gPQ?=
 =?us-ascii?Q?BdfYThWAEPTwxjd3os9beKJkmODOGB+C6YXQFYyx5C46Q9UdCNPoJ7AVNNGj?=
 =?us-ascii?Q?EYwlehXnPIuDFclmfeQuoS1xP86jMZRZbsFO2gSV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f410bd5-bffb-480d-8e8a-08dd18831db9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:58.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QRSQsC1F6m575DC5imiyo6qcMHqdGU8y9VwADbL6m//vTXRdAaMyZRhub4B5GwA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

On Sat, Nov 30, 2024 at 01:01:37PM +0300, Dan Carpenter wrote:
> The "gl->tot_len" variable is controlled by the user.  It comes from
> process_responses().  On 32bit systems, the "gl->tot_len +
> sizeof(struct cpl_pass_accept_req) + sizeof(struct rss_header)" addition
> could have an integer wrapping bug.  Use size_add() to prevent this.
> 
> Fixes: a08943947873 ("crypto: chtls - Register chtls with net tls")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This is from static analysis.  I've spent some time reviewing this code
> but I might be wrong.

Applied to for-next

I fixed the Fixes line:

    Fixes: 1cab775c3e75 ("RDMA/cxgb4: Fix LE hash collision bug for passive open connection")

Thanks,
Jason

