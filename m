Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B89272E7D
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgIUQtp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 12:49:45 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9412 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgIUQtj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 12:49:39 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f68d9750000>; Mon, 21 Sep 2020 09:48:53 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 16:49:39 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 21 Sep 2020 16:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltkbtIRXvCTshZqKyCvqyyO2HLzyjuVgwcVawUWDM0W73oIOIsldnonqEBMfsFzrxrCV9LeiUMEmtkC9aq4zYO6VX9YClzZeXjKKbnAgsfhhH1S+e/WDIu6EBqGGPsebKUBEkcykKQeT0/1qPdMG9E9rIGQovY5lyV9Jn/rUq3CM1RcBwee8NS6FWiwdBCTvFZEpw8dhcEJ1HtCjl0O4oAm8PFGiyCoCwsOVDA3mosYFPc/R+UDR2AUukUFEK+9IOXrWoD2Qi2iGFK5Xg8CGXH9Yi9n9Q8jDv0JLye1TsAB8Ub0sBFAuRerpV/Vx305d18sUkx6JsJXPrj3NBWkkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwVNcm0KnMT3tdEShwoxrx1OQ4A9VEj0sfpdRls19Pc=;
 b=HSE9FZ4EOslvjsnWHxB62D4eYh9WAMua5tx2azq8yRlhip1laNmFSQIksOuOYzWjjRfQJkSxBDhz7Znb0RsWAqFvNg/qe333HA1HCLwLP//DAxi48yammlK3+OcfHry8IObsf1klIg0ldKvqzlsFOtlt61ZpKOlYgw4Ls0ovqQFQWGnHWGvWw9XsHek09NfU/GwfRIURwAWP3px6T8/gMGKoFa2cj1u+b0XulcbBE96F3LRrBKBzi6QTTngElaMrxAzyMyT1t8dEYeEKvKGayhp+Oh6iMQcQeOdk4qDOJa6UrGGnnkg5kj6dbcCzC3JolSH5HelFHGDVWrvs95kevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 16:49:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 16:49:37 +0000
Date:   Mon, 21 Sep 2020 13:49:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: Re: [PATCH rdma-core 3/8] verbs: Introduce a new query GID entry API
Message-ID: <20200921164936.GW3699@nvidia.com>
References: <20200914063503.192997-1-yishaih@nvidia.com>
 <20200914063503.192997-4-yishaih@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200914063503.192997-4-yishaih@nvidia.com>
X-ClientProxiedBy: MN2PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:208:23d::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR06CA0018.namprd06.prod.outlook.com (2603:10b6:208:23d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 16:49:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKP0S-002fzv-28; Mon, 21 Sep 2020 13:49:36 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebff4b52-5a0f-4389-d653-08d85e4e533f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28609478F00B9B834FFB11EAC23A0@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGpCy5VhATmCr2NYs2uXnfjnnnU6Su/CdmXaZVUoJF3Ubgwvlz7YfB/f5iGZoYJhYXjtpGtC5A8stjIeF/cl9BDdbUTIDesaG+sv8XnRI+o9iwFJvBGHVGx59D8y60myhszEdDWpPnj7/M5IzfUjT6q/T95OopBrNvl8YFObrXtl04COKlWFR1y/PIqTdrp12y3/fKuilyAF0e0rBvt/20M256+FD0cjRmgifXObDkSGJRx5FmqoamAzxFB+zwu/OCY/yJ7pAb747yAGCwBsDzvYh5TbefphkYLijsL+GKBffQV5jP0ohA8W2bh9Ylub
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(2616005)(316002)(6862004)(9786002)(478600001)(107886003)(6636002)(26005)(8936002)(9746002)(4326008)(426003)(37006003)(66476007)(66556008)(186003)(5660300002)(86362001)(66946007)(8676002)(2906002)(1076003)(4744005)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0lQ459OG0XpmoQuhFlh8H/IuYQ9I5zxwEYvNm+K/B43c9yVPHxbM3JGK/R2QrsN3y7YM3zf7H9dV3cU6CwpkYXgbLO/3Q2LDYJ/KBAlpMIqAfAlhneW9R8d6qDzMsk8ZMvl2/7Ore3SOjRZGbjGdiPM7xbIXk0IV9974O1sbZEPBywSszTcVOgDCcs6+kavXl3m7oK06kx2I6PP3RvqyDPflqeC6+rP9BIP/GetEKEl4/RCUzRyBZM5A3TnsIef+vcISr9mXiS45y0Rqgb+1bSbm8BOmCys4wZNBrEAqQWjDxEntxxdgG0Y25o3I7Qx4weLxMaRtgXnj0W35LFT0MxHNaglYOfm/eeLQGIhdedayNa7t5wCNDTkZ4rmpMEnjmxlNN19PFdGCIoR3raEhlk+QyfOCXvIyFrtzqmeUyqjqJQA8JV46RkXetamNZ38+51NBgspp+xzz6o25w3hyaD1FoHohuozcxJ1QDo9diyitJ0QmvIDOaORB65EU+R/HRMPbjBqhzGTx2xpbUDdYBaVXYKczT4XhBTuW7kCCHaszR6NClW5Wdolol8b+FEBDJ2bNVQlKZriquL36rqYp4ezz2XS2rhOi3LmgDpmM/DPARsQHeO1QCQmyVXVXyUvSdoBA001kodnuXDGMbg/9CA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ebff4b52-5a0f-4389-d653-08d85e4e533f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 16:49:37.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ROrEmyA0vvga3S2sUxCS11GZZsy1UAaktJEz8MFAFk/CEN6/Ue4e7gtsy9zm/oY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600706933; bh=hwVNcm0KnMT3tdEShwoxrx1OQ4A9VEj0sfpdRls19Pc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=kulfWIskYIs37nWOlkYG8DETIfFrE++TT0Xp3IoN1ffo8MnkEVlXINFiel+ic/SFK
         hURElHaDbSR9vFoSRx1xODIyL0ePzsbDFa31LDEkhZiWMBK/Z90QC4k46SMK0IvzTK
         dfNiMcfu55dr8ERXZijq2qmkt7SG4/fYvvDoqu+YihemxyiaLGLHVGblN0rdCywQVk
         HL5OvjLpj15wClubQHzIJjAlu3eCQcqQ2vSiqAuIBfmzFqBBKUtJY2DENSaRjbv5Zc
         VGP/EIeGwdFS0vc6Et/A8qpZDjkvCKiSXYaJMXHNq6toZaPRu+JKbIpSEzmzLM59NI
         IOnNvZWPj7b2w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 14, 2020 at 09:34:58AM +0300, Yishai Hadas wrote:
> +static int query_sysfs_gid_ndev_ifindex(struct ibv_context *context,
> +					uint8_t port_num, uint32_t gid_index,
> +					uint32_t *ndev_ifindex)
> +{
> +	struct verbs_device *verbs_device = verbs_get_device(context->device);
> +	char buff[IF_NAMESIZE] = {};

This init is not necessary

> diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
> index 9507ffd..9427aba 100644
> +++ b/libibverbs/verbs.c
> @@ -240,6 +240,14 @@ LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
>  	return 0;
>  }
>  
> +int _ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
> +		      uint32_t gid_index, struct ibv_gid_entry *entry,
> +		      uint32_t flags, size_t entry_size)
> +{
> +	return ibv_cmd_query_gid_entry(context, port_num, gid_index, entry,
> +				       flags, entry_size);
> +}

This extra function seems unncessary.

We've been creating C files for each object type, the gid stuff could
go in device.c

Jason
