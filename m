Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDDA266892
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 21:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgIKTL2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 15:11:28 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5215 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgIKTL1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 15:11:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5bcbd10000>; Fri, 11 Sep 2020 12:11:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 11 Sep 2020 12:11:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 11 Sep 2020 12:11:26 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Sep
 2020 19:11:21 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 11 Sep 2020 19:11:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nK+XozNXhi5jCkxBlT2GydX4MgRDUDMT5OmGFY4XY3zvYYHfo1HU9MMs4GZrTyxMsy02uXDHFjAxd7tqAq8dHEJRv5K6EzbgnGv604dLi2SO890Y6/ahP3n+5UskCiNI+QSJO9hD1uAX1gdyHaX7L9PFh/fQMCmJijyZqqKxUnM/cjFlgiubxmYxF9SXqoN/93g07NcKdQWBqZJyDU8NfJQcFRzIMKoRfTReJnJ7aKZ3OvkMtyPR/QOi+7+dvDzO1FY/tIgT1Bm18hk4yhrYr0AY5X7EE6Wd0/oszguUnIledBUBOmJLgHm9MM6y6oIXRgA0CdGc7/2gGYPvEN/jEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quEd518RRqDfgk3JuQNoHRk7MslAA5vw5ZTkL74mqvE=;
 b=HcQx5TkqgK9Zxj1GI+jRnidijyIT9vigKwodiFKgf+WHUQID1Tp1CT6LYw+iQYgeLre3UoDJbi2DsEUlNrEE6INE8ypMLtxTfPpfrfF6arWpf19JcglPrq99oFjsSBhf077FWgGIIDsyhTblky6r557P/c31CuC5aihTjfmP2GXipqBxr+hYrwWNEScmgr4xkHRfNJbWmJNZK9EmVipP04DNwUkLxGLhktfLl2x+xU4XJ9tZV+pLM/mcxnS/z6I/Py2azr0fLcZxCzIMN5dZlssxTBayrcEepyXVtFv9Al3N62qFSp/ohmyVZfi8oHC4SsaxGFRSKOtRndMjEjD0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 19:11:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 19:11:17 +0000
Date:   Fri, 11 Sep 2020 16:11:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Ariel Elior <aelior@marvell.com>, <linux-rdma@vger.kernel.org>,
        "Michal Kalderon" <mkalderon@marvell.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/core: Modify enum ib_gid_type and
 enum rdma_network_type
Message-ID: <20200911191116.GR904879@nvidia.com>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-3-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200910142204.1309061-3-leon@kernel.org>
X-ClientProxiedBy: MN2PR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:208:237::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 19:11:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kGoS4-0059K8-6f; Fri, 11 Sep 2020 16:11:16 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dc6e67d-6faa-4773-771e-08d8568675a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33075EE42710DD558D052161C2240@DM6PR12MB3307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KV3QJ03B5tqmUKgdvb3lfuezfkURObS3J9oXx620I4zJMrjueUINWhSDfiN8FYQObYIftVl2Q40mLP3By6qlz3W1R1VHnFSqU+d+O5A+jX79btKsbL6I27cRrX3SdYso/hDavLanQbahLWv/IICORcNxiJ1fQaG14a5rpTmyr1i+SzIIy46Gq1W8QeSpzPsaUVnF7nCg/hKd8V/7Pfj5yTWonuN8tuiSxV4/CLTf1T3Vfs29LQAzVH3iM5xe0bYSPa4/i19kfUWdqc/nzKc3NhoswSp/x49SmHuL/3pf9sPyCsRABHtfEStaTbAsxSzeQejb1D4qOwMw3U+iu+iQnGrZ0HIo4YEOfP8ddHGMFKe+XXbjHi6S5L1LALri3K7C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(8936002)(2616005)(9786002)(8676002)(478600001)(9746002)(6916009)(186003)(4326008)(54906003)(26005)(316002)(426003)(36756003)(66946007)(66556008)(33656002)(66476007)(5660300002)(4744005)(86362001)(2906002)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: naMgGRNHxIdAuxt34nwf+wgvgrMSVFazIOXiwyIr1+CIywbyqvSsv5/USa1BvW7Ta0EN+LuY5dhrGNRP+HoKiXLEFnTBXx+63KJ8vD1F+aHHiRDB97loPOnZcEc3gD25XB/T2gWbF52tqfjG0Jm7M0TYq33W/I7XjbEcf2c1E8xuQTLgedbdJPXsl01CF/dd4IMt/iw2zuV9iEU1/rEDCh4mdSlUee2B1f5KxZ4tJdbtstGrddXrEfBiHcyBqT6dgew6GRP/qaTr3q9VhIgWbnKm0/N+8OzcN35hDu5RXJKIx3BlmMOXXgsghqtxPYjPsTnJPRo1EeLruMotwUXGLnzXwHyo28+g2luZQB8PK226Tyaam1AoQUitr/aNGCfjTtQJms/SqPkoEsLE6nZ6k9Y60VQ/CC2S1jWVxlZPqUeRbzb93J1TOzgozTM73ZDYdn7jlsDZPpYqHQLStxRE4XEDbtZiS6QFX8eHdXZXsd2l54gVnZVjsHaYqPCLXUxEXpqEVI/y9F0ZKEQWjBg6XWHcfO9xsibaXL0BzIX83JEDkvLRsjsAtr3vwxsrLKFE7nvoZG8Swszv5yEDiQFCeZhuPyz0xrP1S8BVECWAqc7e2ZozcKX2r1UsgBk6U6JAQuJ0l0gxQQIl4ch43M0i7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc6e67d-6faa-4773-771e-08d8568675a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 19:11:17.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVBq+HUovC/bkhHg3yGu/aEOAv91l9Ts4JlrlN5eKvXO6teGpAsdbC7OlXyxUJzg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599851473; bh=quEd518RRqDfgk3JuQNoHRk7MslAA5vw5ZTkL74mqvE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
        b=cW7+mvzXTus0nihFtITyMiMaDBNzrAicTgQIGSWPd0PU+aby9IZgYCbQV0hnEa9dA
         iBDBV01E6Z9Mvs10HRQytQA6kwPfNEkj9HL23LuHzvVzlIap0peD7Mv8rp+ODmQQFA
         SFAAfVu3BcKfCNvYAEpxCtQTpFDElkQLkpKunUu8toKRNGDhUIgR46dS3Vuwmb7Xih
         f5E9HV8uHphPYdzaGEN0fnApmsfpsxcZfuD692H23l4NwuAO3eDvtMI4Ms7fZLCm4U
         no9K9zEb2xGPD3zpYRKeKgS15mS66+BMRXuwtB6l5e7KuIBFOwh3sWdW/IErXL8j+o
         72uJHFzoHKuPA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 05:22:02PM +0300, Leon Romanovsky wrote:

> diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
> index 3c1e2ca564fe..f1b277793980 100644
> +++ b/drivers/infiniband/core/cma_configfs.c
> @@ -123,16 +123,21 @@ static ssize_t default_roce_mode_store(struct config_item *item,
>  {
>  	struct cma_device *cma_dev;
>  	struct cma_dev_port_group *group;
> -	int gid_type = ib_cache_gid_parse_type_str(buf);
> +	int gid_type;
>  	ssize_t ret;
>  
> -	if (gid_type < 0)
> -		return -EINVAL;
> -
>  	ret = cma_configfs_params_get(item, &cma_dev, &group);
>  	if (ret)
>  		return ret;
>  
> +	gid_type = ib_cache_gid_parse_type_str(buf);
> +	if (gid_type < 0)
> +		return -EINVAL;
> +
> +	if (gid_type == IB_GID_TYPE_IB &&
> +	    rdma_protocol_roce_eth_encap(cma_dev->device, group->port_num))
> +		gid_type = IB_GID_TYPE_ROCE;

This logic should be in cma_set_default_gid_type() so as not to move
struct cma_device

Jason
