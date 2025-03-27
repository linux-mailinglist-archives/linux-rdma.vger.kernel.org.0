Return-Path: <linux-rdma+bounces-9010-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB4AA73357
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3121691CA
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43A21506E;
	Thu, 27 Mar 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oKiqw3hr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D32AE95;
	Thu, 27 Mar 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743082013; cv=fail; b=T2pNQjMDfBZnRCrtoV8M1gO9sxQei+CfAHdKrCibTwxKo3YK6b82/UDjoc/r4oXJMREguM3HUw7HalCGgZ9Y9bDmKxgwPIkRfTS9jwhwIfDH4Ed59b9LPHyiR2R3/bzEHKe5A/FPMd24ngmVbaWOnJWmFeO8greQfnoSrjDJH9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743082013; c=relaxed/simple;
	bh=ONJ0CbdYLDiOUozPzsneri+UzsOeAajlyZ/Tm2EoKn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tMKlFQ2h7dKTYnHSIu9vGt0WJYZxoo17FhTo7LM2m8pHMhJmyYAKB6uCoAwNHHdC2Wo81w3HBdj2e170FPNo/EJ5BoJvg7ur+0rApGSLihMG+/kAhiw6IZJybOEIXPwS2eu5nO0ejhMIVqAlfQsuB6y747HfyjCVeWlC/CVbOnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oKiqw3hr; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Te62zU16diS8qXKbI0TbbevIEsz6CR5rABGhwjR17tOtYP+nxynvWBvJRyEyJCQUMNN3TqIsyjvMsnKURtlBcVyMhOOPTB5zYHbPIhLKr3xl7VzhHM+NwXTVoNGJSUDI78tvFunWABqSTqiBynEz4KpIpkXscaWZLyF61wXc0EZQ/NXVdvDXB9TljfOhAZBnfRfreSAMbDLhifC+bpg+09cMjYRmJ2d5GvauYjGr9q73AKIh/QwqNkmAB/ZcK5FAHRRkju3kSkjpblaJZSnHq5qvZccgeApHKXef7QBTD2wYlC0aKpP1cfQQ3puKBF7Lk4lBARHtfm4CqfN+nHrFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjS+TA8GShJcDBD4o1edfur1vA0JrKnGRbE8bEz3Wh0=;
 b=a5Z0zhSDyZ1nLx3q/MCknTX0hSY8FcylfzutA0xwAYhYph/RDplieImqwuzdsXwlnnBTYNITBCIphLjc+qfWu5RDrtx8waxRdCi+UBnBGEAhvOPIh+VlctQmWjgQ7tF0lM1akjs597z/ZnZHWx0/LotV8cW4xzzYbUUZidgAlRvCLeySywxQJ7OvsBJHvPfIxF9AHKisq1KhQIjt4Yg0V32qnWtQbiNl7EwxgfxN2d+u2sVDOosDCt0Ud5VzpYgMjMYbKZQi7diVmEFQjkhVsDqWWa7Y8xTltMSWsBqvZB+0YwA5uoxc0bQWPlUmK5piCJZS2aulwW/L5RQ7jrodCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjS+TA8GShJcDBD4o1edfur1vA0JrKnGRbE8bEz3Wh0=;
 b=oKiqw3hrDX8Yfn23Ja15/fDU1hhHHue6YqWVUW2ZQtQAJ9uanx/NlgQeEILPrqEsGAx+jKgOk8+0v3BfAndLSr0Udi6pgayKhmIgI+2DJUgGDp2vuq19cSe6bbcTcDWu7xyjJUwY4LHY8HjuCJMY81MJyMvFg/ei709zl/0C1nHfKAqGZsP3zvoPWhIWSmTuDNqSVzHRp9OOtOxvtW2/Vyem36EBHj32w6OSDN71TTIdT54eIrQE4iIqdOWFg6BhFUl+bibSAfsq9TU8oq/7GlR0iOlDEjMctg8t0n7LIfVIOv/Ki8haKSYyuPEClMSXNSGhwa8ZwzpK5RiQ9vTHGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:26:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.042; Thu, 27 Mar 2025
 13:26:47 +0000
Date: Thu, 27 Mar 2025 10:26:45 -0300
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
Message-ID: <Z+VSFRFG1gIbGsLQ@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQZPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 50aa2023-02e7-4506-d3b8-08dd6d33060d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h3K/n+7/i+VOvMcVSX0bovd2v82ixewBpFUR84SWTKp1wyEzFzIOLqRlZC88?=
 =?us-ascii?Q?aTPP8zQ/YkyS23YvXuhlE9efDBtNq/aho6FtqXG2EAELvNjE8FmlJsQ2NPDY?=
 =?us-ascii?Q?2NP/x3y9OQmPFpiTQii7BHmCtWpQ8I0LEy0hkAdH+iSc8cyo97ez4C1E4U25?=
 =?us-ascii?Q?+IhAIo0+5tHBbeoa5oUQV4udNf92S0AJaHMSw1rzYLj4OJQbKPav6Ubtoj8Y?=
 =?us-ascii?Q?gufkt2eustRGOL4i5uq7YiBaW26DES3qUrtO/8MS4ia4j68TEQ/P3tO/gN+Q?=
 =?us-ascii?Q?BmZLE+hoTZ1d+csgGSMdYjqA6Fs+H72XRlJ3dm1QDyzG+aNNtZMbKmu1Xo+E?=
 =?us-ascii?Q?R8QGNA5yFXW4D+IAouYKvB+jjOsZddfgnWIpuJlfh5/ruDmbzUVmyRUUwJGn?=
 =?us-ascii?Q?d6ZHCnE6Zqw54o5uJ8acUTYGZYEh6c0Fj4yLDOndirv8WZdxCPohPqRjmCKb?=
 =?us-ascii?Q?P4Idl9WzkW8VGKqD0lwBYC57Wo1wrbZQy2QgVY7bwrXX8Hz8t9x7k57rcJJ0?=
 =?us-ascii?Q?HYyiUjXSZCwFEolKprrdwEtH0s+KxL+jqxOxo3Hx4f6kwFpQB+ous6Mc1B8I?=
 =?us-ascii?Q?WIh6k1ureYzvIo5rdftU8qVt8MN1M3tAxRuD/hZcTe3Vn2xZi8HNqvjv4TCj?=
 =?us-ascii?Q?7f30JoXtLenRoLfUb6slpgzK6612L5hrXjEpnQ6kuhN2Gdeb8W/Ln8rlUr+f?=
 =?us-ascii?Q?2JJ2gTkz9x2jl8I8HBEpBVVALryU5QxJlagAxICWV+DhXxEnwPqytcCwCuBT?=
 =?us-ascii?Q?z1i1TMTr5aQaFb9jLhNMWFVvPy30VVZwCXSX+eeczts1NsMebQ85PLxlYIXw?=
 =?us-ascii?Q?QEq5VmSpFTVo68m+GCSiEZLqyuXbdb6nACGU3GQPmbMGVyLH3/pkfw5lpqFU?=
 =?us-ascii?Q?Uz8vjT/TMAyJMHjM3H9zpfs30f5cZS5DWhqGb+9FmsMWi+CAfvnrtIKSUdsc?=
 =?us-ascii?Q?dk1BKj/89tzoMalnuI/rgDiGQGHuJsaSPHXQCEbXDIwFe0ZCs4otZOo6FKvY?=
 =?us-ascii?Q?4AGESB9vtTBTVpAOL2JRAzNJyukRTyX/wSBk1182j5RC7oXzwmq0CG7zjsjx?=
 =?us-ascii?Q?DXlQS1MWskmOUaU9wBoEMS90GJexQhWwxISjddEhuoRKTxLuqZqFxI+mBqPI?=
 =?us-ascii?Q?mKdGE/WEuFIy1ODGHmZrKXpXVtfjsxCeN46Ni3IRLQ7c1qqdHpHYq/OG+WsU?=
 =?us-ascii?Q?c22SNM8c32WWdWvkkLw+dgMIax3+t37c2XbD3QHhYq9UD+zXz/qCUsEOhAXA?=
 =?us-ascii?Q?SU2F9sBhppy5Gl9CrOsVXOnTv3KIPou6W4TB3SdBBWX26LihgSX+usjtoTzN?=
 =?us-ascii?Q?fIunK0LVdwoydeE/JFqJS1qnxHJxHa5xW99qb/ybMUO8ZIL3fyciKJ0oj7zF?=
 =?us-ascii?Q?eqCikN2SS/zuAplekrntZJNIkUrw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s7knw56gPD7q7Jro3+zAdD6RXUeqMqlZ6iW55h1lmX0UUwD/LyMcGXZ8i2wR?=
 =?us-ascii?Q?g9nisjsygTGL97uUNyQQ+aT5t3sUUnxMNxmahrn7mKbqpNy49tN8/FXzhQYV?=
 =?us-ascii?Q?kv39+akUAWXVc8Yt+L7LPPCXvkys8H8atsveSBr0Q3LnEmb01fcJHI9idSat?=
 =?us-ascii?Q?qtupsMgFSg9kjZ7XTwhz+VBQ3H7h0frrIOu2PZKPn/vUSoPMCLc/+9oBIYMq?=
 =?us-ascii?Q?IiCL6SiIAUywzfSoUXUrC2kuurR722DC/eYEZEGDvmuMxyIAVFcONKdPyCx6?=
 =?us-ascii?Q?jfIbU4Wa35mS6S7Ql/1Vu+zge1yYgoezIAnfdWcrc41l+uvN8XagYNcw9P4I?=
 =?us-ascii?Q?OxOFCGmxfEp31SEuCJr9iuvCiKR3Uo/CNWVms1RUsXkF7XDXrBtvN/eHhwz1?=
 =?us-ascii?Q?rkzJesp9P5vzb3EiiAjFrFxHqEVu5cWDI/cZHhpzhTUGUGQ71/4woNxPG12w?=
 =?us-ascii?Q?t3uIxNgj43tb+r+LFxl0KR3ltQegug+04QgeXeQiafwHEul7gOTfTgk9U4Ab?=
 =?us-ascii?Q?Hn4EOemFczuWGyk1NrNWF/y4QrvuMCUX2z0El4Md4N/0AwbxI8HTovdcNSFX?=
 =?us-ascii?Q?amBbesboziDkckGn2b+uNug2D+1V0oYAtj8DQ/AxxGzAoDiRYfpCf4Jvr0JJ?=
 =?us-ascii?Q?pxTBEWHykXcVtXbQmqIpIZhVDkqw4sfRNXaZGLbkjFX7Wnb0k94EmHuwDHrk?=
 =?us-ascii?Q?sAXvTRjUoIxMLw4ytNpK0Wr6KP/Gr/KosHWIbvcn5rQNGj4QdcZ53Lo9IgGO?=
 =?us-ascii?Q?7JC8eJN4QThkTbHZwSUfU9I8Njh7QLyL35YakaDDBfhtPmxu3mpjefveU+Io?=
 =?us-ascii?Q?jJFfTB80wfUzTERq5v6B6T//22PW0DGDbe9hm0wiTk4oqCUMxgPMqiF1bNo9?=
 =?us-ascii?Q?qnbXgeXYp8/IjWOEbRQ6RuwEIGcpkmqaroHRFSx/j/vPRtEwxYz6uv/9aEWF?=
 =?us-ascii?Q?OGK/jipnnzI5/NqvjiZ+86RuX546U4X9ULbysyQSYJmJAzBaXxdXb7kXH7G7?=
 =?us-ascii?Q?m0MivXS7E0PdMXFCufflvaj3BvCUgTsAHx7Mo0rKU6PLuMcLgKkjha+1Emws?=
 =?us-ascii?Q?f3c0+//bpnGOw1iT6ik9X67Fx8pWOFC19NEwJiyxYRqY6qloGbhV2kbhLYCR?=
 =?us-ascii?Q?THVd/m3BWe9rW/iXv3t4BfxquEWU0nTI7B/GFOO+RfB6JXQciT5ZNI+lA1DK?=
 =?us-ascii?Q?8d6dmPLu1wYFo8P1a+oBEjjLzXp9ABBnJ4P3508M1ji2xW6leI361z1Jug0G?=
 =?us-ascii?Q?wKcjN8y3E9yETui+uQEHWjiBRZYGORSdscuofWksx/vFy/GkcgbGmUb4UXp+?=
 =?us-ascii?Q?dz5EFpRxg8UL9BbuxzzsAkneMoa7rjRewhENi7FCtsVNEuG83Alo6JicWOsp?=
 =?us-ascii?Q?Vlw6eifAU+ZUdwrwUgXabjViQrN6SqSX6fkCwSTEjbN62OS+zlnc2yPozSNl?=
 =?us-ascii?Q?QKBP1tg350kR/TeMgjyvy1ifuaEW6fJefrqKuTwengdTz1FiWXvlRt6l6x0m?=
 =?us-ascii?Q?xN6CrUj7c9hUBgqy2wkXACMHNY6qzFRgq8L/hMdMIHwGUcT6q5PGogAqHAlO?=
 =?us-ascii?Q?qrQyVWucQJDXKRAgdscpcV5woRs9eoEMH26Bi/26?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aa2023-02e7-4506-d3b8-08dd6d33060d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:26:47.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf91RR/Lmt0rBWBckBr7t/gBWjfWi8f389UP0igoBD2NxouCasOYCVSx6ejrqdkV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695

On Wed, Mar 26, 2025 at 05:39:52PM +0000, Sean Hefty wrote:

> The PD is a problem, as it's not a transport function.  It's a
> hardware implementation component; one which may NOT exist for a UEC
> NIC.  (I know there are NICs which do not implement PDs and have
> secure RDMA transfers.)

The PD is just a concept representing security, there are lots of ways
to implement this, so long as it achieves an isolation you would label
it a PD and the PD flows through all the objects that participate in
the isolation.

The basic essential requirement is that a registered userspace memory
cannot be accessed by things outside the definition of pd/shared pd.

This is really important, I'm quite concerned that any RDMA protocol
come with some solid definition of PD mapped to the underlying
technology that matches Linux's inter-process security needs.

For instance Habana defined a PD as a singleton object and the first
process to get it had exclusive use of the HW. This is because their
HW could not do any inter-process security.

>  I have a proposal to rework/redefine PDs to
> support a more general model,

It would certainly be good to have some text explaining some of the
mappings to different technologies.

> which I think will work for NICs that
> need a PD and ones that don't.  It can support MR -> PD -> Job, but
> I considered the PD -> job relationship as 1 to many. 

Yes, and the 1:1 is degenerate.

> Sure, It's challenging in that a UET endpoint (QP) may communicate
> with multiple jobs, and a MR may be accessible by a single job, all
> jobs, or only a few.

I would suggest that the PD is a superset of all jobs and the objects
(endpoint, mr, etc) get to choose a subset of the PD's jobs during
allocation?

Or you keep job/pd as 1:1 and allow specifying multiple PDs during
object allocation.

But to be clear, this is largely verbs modeling stuff - however there
is a certain practicality to trying to fit this multi-job ability into
a PD because it allow reusing alot of existing uAPI kernel code.

Especially if people are going to take existing RDMA HW and tweak it
to some level of UET (ie support only single job) and still require a
HW level PD under the covers.

Jason

