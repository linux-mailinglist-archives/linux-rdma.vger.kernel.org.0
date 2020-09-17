Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2729E26DBB9
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgIQMjG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 08:39:06 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:2806 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbgIQMif (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 08:38:35 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6358b40000>; Thu, 17 Sep 2020 20:38:12 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 05:38:12 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 17 Sep 2020 05:38:12 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 12:38:10 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 17 Sep 2020 12:38:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBs+trNhVYWiH2pfFoN5mfOERh38Rrgt8Gi2zlkVH3zU4LQBx1JuzZgeUJ951qjVmMY/6BTUclh0HBVQVkCw7m8K+fA/hxgnltxdz6zgftvuN+EXUPn84Ti3Sv9L2DNDMbnfrNNB6KrWsijKlcgI2rlkPFO7J5YC3cna1f46GWi+vOQ26VZ/KxH5au75KeT+JHuHiKGtgcWlexfsPUPUesBHZLvuhaq/dlWUA4WNBOEK8Kn9U9YsANAPIeHSIaYveHGvXa4BFFaJgPrOObJNdyibOGj+VWnFllQVPeQjEIgS7ZhRILQviL8B/2S4CbE/LVGDWblJTOwyFHKzDjScUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzKJVmXLGV7/+g8B9fCvyR3I0JgPfM3GbNWR32a1HnE=;
 b=A03XN/XDV7HusRZ1TB8Gjqo+cfx9UE4qVmY1KpABOTLLiCRpMH3vkze8dHvvVOOWkoj/wFT9OzfozHF16IGvpBteC2qv4+6CnFPs1+6wKfgoYEoFJebFF6butnBxl3cZY/vMStw30PQnhqevADh1dMBH6WtC6S4TTI1QKgcrEeQ4elpEoq5i4w25xkLc/660Mewhk8gCWTutXpVmRwahDz5KgSG4+MvlYqeO/cKBaunjDkE6HmlOVxJzecxpa0Rg+F7t5UYjsFArc1103qOd+zjjzufh1cnLxiIDFCcjQxySXLhF9jdSqfqDeZBjDipkPkXp4FHJcv4JKlTTLKSxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 12:38:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 12:38:08 +0000
Date:   Thu, 17 Sep 2020 09:38:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Liu Shixin <liushixin2@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in
 __mlx5_ib_alloc_counters()
Message-ID: <20200917123806.GA114613@nvidia.com>
References: <20200917082926.GA869610@unreal>
 <20200917091008.2309158-1-liushixin2@huawei.com>
 <20200917090810.GB869610@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200917090810.GB869610@unreal>
X-ClientProxiedBy: MN2PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:208:23e::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 12:38:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kItAs-000TpN-TC; Thu, 17 Sep 2020 09:38:06 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc19e173-6618-4cc5-9517-08d85b0687d8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4010:
X-Microsoft-Antispam-PRVS: <DM6PR12MB401043B183C4F080A15F89E1C23E0@DM6PR12MB4010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1FxkJs7YgeVNs4lYCnfjJSnWMK3fqRpC4GlXnrW50ry/IDiejdEfLepZCOranEC4SXBESXv1/Y+kkd28uO/uqGL+gzSQyIuXVV86HbG/WlZJYQwErgiiSt35zh7bROI2cahjsoiQG0B6JLAYxCZaE86RKvxpLtYPabMk8LRSAADik5Gi3zEHkNOKq4qUptz0Bt1cjQJZWOGdqNnJ46EwM6icgbJLTmRwTvdQMPH0HGmO+hU2ZN5tF+q+zGSacz9ygwZJ2O6pJCwfyWAtIOzYBBnE78hmX3WkrCiMZbhNjLby13gAfKQ3apWNMxhWQDI87L9dDeaxmMvJaKzNq28m8BXy7mnI3ymgGkxKp8pjt7+jOjlODBlO5ENyKBOo0xoCnuCvHDpo3rXG8WKNGZ3fNvq2MnkTiR4h4Gcmwz+dvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(186003)(2616005)(26005)(478600001)(4326008)(316002)(426003)(8936002)(9746002)(54906003)(9786002)(66946007)(1076003)(66476007)(66556008)(6916009)(86362001)(36756003)(5660300002)(4744005)(33656002)(8676002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4dzvWUarOHASVzkdyhw+yx+P5WnuvWYPRzDbCY/qYdQyREijCZ1nUcaaXLTcvU6Q13XdD1w5poD1b+2WpEIhJAQicc/ZZpTwY07n69EEhAxWU3tLdh43PSLGR1m0I7HrzySAlALwV5gVISjNs14O5OEyBhuVcGVIUmJ0oRj9/pBNqRPSdY+XqdpCjAD8s/NMWZb+vHpqpzvtsklhBfnq9xx5YGUCygY/xmsDBEBgU1/N+tN2dZobO+WDNWZKr4dkeOYrEGnzYBAGN1KVMtNvrXvOXJFVrfFGj/dsAu6kP9qxjM2bElRQE5rEYC7WkSzHytORLnYoAPD2ePFLDT/3TbwdRTs72OfuDN6KyY8mCauESMnxPNOD2VeTqftzClw/pKYbJOg/a7noRDBHzuaV0VZvEMjcIjophlLZK5sx5hxNDOLq/dTGWyv29wSkFG6ahkw9EGpexjnVSJhSpus/bHK9v0ib/HD2CnSUvvsPa8SpZlDnX37Nnl0yDNKPjS1QWBxXuCcankXec2gYEYBdiqvIoBzP6Z6P+UFOmOaVqCMU4oMsGkFTOqtoAru+noRTeEpIR1t/35+QQLS1k1yvQqcGJbqsG+8v48iIJOuyVFAmNJXJoI6Px4DnGuQ5pbMZ8NdwAnSXzjR+tbrzpePvFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc19e173-6618-4cc5-9517-08d85b0687d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 12:38:08.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poznMqpQyWc+Y12/yZwxnsU9TnhWbEaHhfjqQWReDI8SGpwKC0LYTcmcTjuxn/5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4010
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600346292; bh=xzKJVmXLGV7/+g8B9fCvyR3I0JgPfM3GbNWR32a1HnE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=l4SpQirHapd4SirahO45Gnil2ZU+hDZTpBPNkPt3XLazAJrmDYOrIt0+WdiRbuFiM
         YkmaQcABZOiczx1fhBh4yFNh71/bnmrrq9Ff6RosH3zXBj0+hBY1qPwrf4qRM4ONUa
         j/Jn05Zj2eRtbNe9/fUfo5L/2uPX4l8+ivVJ1+7RL7ZhyRQoKDtYHHPjVKxRh81rSS
         yt3cPMUr2zzqx5WhbFqlqSc1J6gVcz/wIaZU1278y8wIfAwMNcs90GH/BFoVS7Nvc0
         8CfyniqkN8F1V1L9N/JvL9lyUCSZWYjyirP62GmuWbZdDD+VvC5IXXwawr6l/L9gCO
         jJUq75Ua1BDvg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 12:08:10PM +0300, Leon Romanovsky wrote:
> On Thu, Sep 17, 2020 at 05:10:08PM +0800, Liu Shixin wrote:
> > sizeof() when applied to a pointer typed expression should give the
> > size of the pointed data, even if the data is a pointer.
> >
> > Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Needs a fixes line

> >  	if (!cnts->names)
> >  		return -ENOMEM;
> >
> >  	cnts->offsets = kcalloc(num_counters,
> > -				sizeof(cnts->offsets), GFP_KERNEL);
> > +				sizeof(*cnts->offsets), GFP_KERNEL);
> 
> This is not.

Why not?

Jason
