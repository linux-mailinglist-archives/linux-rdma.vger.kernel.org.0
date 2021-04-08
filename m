Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0A358D55
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 21:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhDHTQD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 15:16:03 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:45796
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231451AbhDHTQD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 15:16:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSH8QGi2Pca7915fnJ5RdFU+JYZYhRxG4mxLAIAMormu+AG52P3ujV5kKn8CNPFxSIiUsTThqwqwILby2m4TaD6BkDSp/JL+e6YaKUApgl09LFP6w998rH1rHuhlv4d77CaPBz66E+12c3sYuInQblwr7EZPhvkwpSoGz/TtwN0p0XO/BYoRlauXDQvV0OO+8JSq24Nzjgwvz3bAl6XxQP6EDLTVPFk1FfKkuFI8GmfELqTw/FefUiqQ2u+M+od1nHskjW/Rh/EGhIFXUkVyHZFspctWgBm67YYU5lcgOLIqpnNbUu/dop5NKNgDZey18C11oFLSzGQYjR0k1xHWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug4YtgDx37E5KGwmTSNGlr4ILrg8v2O6UlgHC/aZN3s=;
 b=P69xTO5OiqJN5fWMf4u2bojgi2CkGOmt6iV9DeVHcDHw/DA3X7IYfnKK57tRMa+DtKpmo3M/Mde+q0m20M4/IdPMQ15sNpmxr+YyDvblm8vwV4yxaH14fH74W/Sfn4mTIYJQ2kJyBC0jaigPVXDptsgyPxIY6HA0jpyjWw1RGYnQZdEH6U98jL+COW+k4UAXptAvGcfKTjympiKYTDQBrI2QGk+5DKZbIX+JOoBEIPXx7gAFDXM26n1g3II+NGwnI57ioQpVBXzD+rkNU3OM6Cmi6gQ45zqpggn9Td+XrZkIcsnf3MDt2/XZeFZMT7CYN9ihkLQ9m8/98evPw9X9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug4YtgDx37E5KGwmTSNGlr4ILrg8v2O6UlgHC/aZN3s=;
 b=daIOkjHvGEFVVjSnPLmmPv2hH1vnh3GN+Yze5UmYPRAeK2wMrg4RRzSlRnVCsVK+K4KTsUkIHCzMjfXLJbw2x/kjYAcu7ZUF8R9Bg/kIM26sdGQcSWnTcg0PUsI26al2dtmWoQZqdw3ngoVHYqyRbcMf1t4piJJILXzrK/JKfq0ANz/is0UhnVYKFWs1zxIMmbcCgwk/ZsDPadYAFZj52qIUHQZVsiXGy39vdRtsrRpB5NNAdpiTQwZ2k19AYnpcU4yM0NRbEXLLf1CtgV2mFb1k097wS+IwOwVnh2eeJ82sVzvzjcO9tddaxU8aY6odklmPn84ARJebip9Hu2Y3qw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 19:15:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 19:15:50 +0000
Date:   Thu, 8 Apr 2021 16:15:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/addr: Be strict with gid size
Message-ID: <20210408191549.GA696365@nvidia.com>
References: <20210405074434.264221-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405074434.264221-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR12CA0004.namprd12.prod.outlook.com (2603:10b6:208:a8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 19:15:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUa85-002vAN-7y; Thu, 08 Apr 2021 16:15:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1491ba79-510d-4c41-5707-08d8fac2b8c2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4042D28A15EF8DA2A2384FCAC2749@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFsSBvfKnJX1d4YyARBu8Ocm/o0PqPGpl/PdziBFaVa0ao8nT3xVjCoHrWAT+Xq5KJBevdEOWG4Wg85m0gbztmbhbzT81nPd7Y6csox2LGxaJrMJe4w4t1EqydHRuy64oL5blTukRGZEpsDr8h4QoCk8yGncGPHZ57jk5bkgJ+j2Om6jUXUpyOk/SjBXTNqHzwBl43gHYQgPlPneLXtzWYtJ/xEvfL6hJfYgtvaw/QL6h5hbGWADC8EFlDvZhR/ymPiTnmPUBxZFhvug3Yihb4E++QlrRy2r41148R9YSPHAik/ZM6EDczMCe7pZjWvEzzn8oQofWp6F8ailGnLq1JhN/YwvbLGfDAvOuLmxRyWoR5IR5pEyVevVILJEkj9jDPVf9Qqqw4JOC8GgqTaqYDHN8WeO40e3tdExvnSuFqoAOyhEzM1hTnRUeiryQjMXcXiss7GZEzKl8UcYPub1imufmJ6Cot26Fj3ni68aAOVo9adSDcIsAaaQAKq/kXQUYQSRVlE/AwbDNSw6KRO478/24t/YfKSNxSnjVJsPDb+0Eva0gj0Bv1WswdHJ0O1XKoYsKjNsQSIKh6tnyKYHVcwNBdgj4K4MIYV43gfw57N1tmMCQrVv4eedye/95KIlVaHSjNk2TvweswCJM5aI75i0OukiiBRNNJveiSxhtIzv6TGL5ET2iPNw3CO/kR5x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(2906002)(5660300002)(36756003)(86362001)(1076003)(33656002)(38100700001)(478600001)(26005)(6916009)(107886003)(4326008)(8676002)(9786002)(9746002)(66556008)(66946007)(316002)(8936002)(4744005)(2616005)(426003)(83380400001)(186003)(66476007)(54906003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?p+XGYJtppHhyiWW9jt0gFNy/lghTwlu3sW4I/MR9AHducvek/Ky5giemr2FH?=
 =?us-ascii?Q?zg/A8DyhdNuP9P0Qb0OHDrQqTiaaWWcsU7P1eVTNeI6qo4hjzM5WXC6soqOX?=
 =?us-ascii?Q?d4UnWWo5T+7TijfeyZA3Y+WeVmezwAvNZmnw1jCKo8QcEW2AVI8zuzAS8VjE?=
 =?us-ascii?Q?yKRKfapvFCCfkNhvE5BcfdQRucgQspVzFm/l3EUKf8bFepFFqMWPRUyauMci?=
 =?us-ascii?Q?KtN8uF9TpTcAbYbP0LPXW++G3cAHsISGZJ3cncGH4oc5YcfAJVUYdKq47oyh?=
 =?us-ascii?Q?Hzagb/xoz8X2c3s9BZqlJJOWR8D3Z0r31WgXrvctOdTba8JV8bMmndw4uwv5?=
 =?us-ascii?Q?osjhDpnXXANwQN2Qw67aa7PC/WdjUd7GJEWH3xEHXgB/MA/nFU5VB3ihePwQ?=
 =?us-ascii?Q?QpkOSYU9ugW0N7eNK2++nLLMDO3T59MBhIcJqOuuMtggBeF0vR43uRtFy2AO?=
 =?us-ascii?Q?OWMOHag0YuviEIOc8qrl46RqeoKwjvXWzr5JAyML9lzUBNLhsN4L7NPhtrwL?=
 =?us-ascii?Q?+QrOnhy6T7Z6HMEuHcngZ7ec9shiUF+479BAKRKMDyftRa1A+ylTzbIzZCqc?=
 =?us-ascii?Q?xwOHybCWRcBrB3nHnqQYziM0N00TZIymGJcrRIURwv3Udh+EofrN2wWOKWNM?=
 =?us-ascii?Q?s3am9HGVl6DOQWRLarAzvQaPtExx0uU73wbDDGDRSoD7wvg0/ZZCuvAxVIif?=
 =?us-ascii?Q?LVjqoUJOwhREx+kMzHsMx3nGUsUd2Nu9Pubc+1RwRHhsWpio57GZJjep4gdr?=
 =?us-ascii?Q?vaMBn8cOvAUMtUGB5lXoYPrHdhqHibkgXx0N+UPMO2JokcMGfbHpforKLNsb?=
 =?us-ascii?Q?nClU4wLWeXuEz5573oNnyy6lap7kdGC7G1XgptQVKPP/apgL4Rg+4jvHepOs?=
 =?us-ascii?Q?dlAG9aoBi8pAGit2FwQ6kZCDQP6ZmtnFhcTKMFwbeUysWbCkeoB+2V10zVfe?=
 =?us-ascii?Q?VQBNXb5hh9XzqPV7fA68RXixNYB4pfof7dY8gTGtpR0zxWpXKc0//8RPFrqy?=
 =?us-ascii?Q?EcDOFIOjwx2NVbh1ykcJ3ZCp3wSFO2fThXIKdxKap2Tu4Faypg4C5WQ/HhuD?=
 =?us-ascii?Q?iFyDI9beFifQJhhcVK18JjzQspoB+PEkhhbK4QFAiQAjA+6kCuqBy8kXE6IE?=
 =?us-ascii?Q?DCaCqDiLwZm0+xB/yt4VYHlJl2vSEe82b8kjYITFeMX/5EwRxWklYy2UD3l1?=
 =?us-ascii?Q?Kb9BDOHrAwuwdn9VWdxKmthxlJI3ldJg7Sgy/Ow/pCcifpGTSE8f7kx7LjdQ?=
 =?us-ascii?Q?7VOuQeILrseHrl1AOFIsSX2ryek9X0HXWgijpcaHHW8LuoHRpTLcEVkMyKjI?=
 =?us-ascii?Q?8orhI3EcTrORh9gMgaq9axl9Vv5bxsL7+Kow9997GhT2hw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1491ba79-510d-4c41-5707-08d8fac2b8c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 19:15:50.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfEnvNRqkw7e9KeIHXOWxiS7nA5q8bcqLZErv7UMWUtmvtSujUdbnwjCPNb5EXyp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 05, 2021 at 10:44:34AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The nla_len() is less than or equal to 16.  If it's less than 16 then
> end of the "gid" buffer is uninitialized.
> 
> Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/addr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
