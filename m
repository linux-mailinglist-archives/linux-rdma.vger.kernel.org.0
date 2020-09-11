Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B8D266076
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKNkH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 09:40:07 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14911 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIKN20 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 09:28:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5b79620001>; Fri, 11 Sep 2020 06:19:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 11 Sep 2020 06:21:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 11 Sep 2020 06:21:47 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Sep
 2020 13:21:47 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.53) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 11 Sep 2020 13:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdJ8gLOcu5YJDND6jRXpgfZEzCFXLd+IUtVLHzYHqh1kqu9ZELTgSkkLD/DG2DQC4t9YStzZc2EXVPv1QG0oScxyOd6E3XIFEdY/etrdzo2R22xSTx8AmzK8L3y3ymDp+q16x5unl0pRdMwFo7lYdSrV4N4Cctd0td2oV921ftJX2xFGVPtL1CncGRC7O2bJ+3/WL16AMSoL7enKICe5LYOav9ptrGKGaBFrNPp+4F0iRmBe5brPCXtNe2KZ/AcgkfwCGOYO1dIQ9ZMNIMUQGvvfKKKmB6z/RuucEBelYo8zOszir91Syyvtlccpsx6F/QXOqSTVgPGckWZPfI8S7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dDtkZEogAoHeVSg7NLTozsnk+Tlg5q/Wiza/rbHfIg=;
 b=FommV0HtuHm4QbhZF5hU9nHRch4fA1U4CqPS/d1bTF9qdlr3rm0vo9iD8jziJVsYeUda4SsEFVJkXv9FK2PevYDZRNj/Ib4oOllMNTWfmjhLs65B3zhgg5DeK+TRzIhqyRzdq6uttgOZuRxxRkkYJMK39ttryjQied8ANTQ/+MvI4mA6KEQpzWK/kx79is8ybzelZEZlFONUv0iKncOeC/gTBS0P4f8Iwe89Nq9oGuQNUNpqdFAKmMjguRS9EllVKwEojYwNUMzcptPHv02ICc6x9+IjVEmI5hjNLpsSRw3J733IYMLQ2ACVtQLG7A41Zjoftzt1J6EKLITE9O4myw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 13:21:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 13:21:45 +0000
Date:   Fri, 11 Sep 2020 10:21:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: Re: [PATCH v2 06/17] RDMA/umem: Split ib_umem_num_pages() into
 ib_umem_num_dma_blocks()
Message-ID: <20200911132143.GA1168599@nvidia.com>
References: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
 <6-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:160::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0012.namprd13.prod.outlook.com (2603:10b6:208:160::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Fri, 11 Sep 2020 13:21:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kGizn-004u5q-8N; Fri, 11 Sep 2020 10:21:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 340e8830-4088-4d34-25a7-08d85655a122
X-MS-TrafficTypeDiagnostic: DM6PR12MB4299:
X-Microsoft-Antispam-PRVS: <DM6PR12MB429932AC62EDBF4A61598A54C2240@DM6PR12MB4299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +L2Zy+P67u9fuLzNTrR3ScXfZYJfsC5E8JCXkIa826gLjJSm6AueYnsuNG/RqZtXAMViS0JDDDHvHURB3aQHTAzBuf//TFhpU+Gc00Jmts2J0+5SK3V6n5+6N066YXKa9IBmQCGT6AfQJjOPoogpX+KcfAiUHtcxDDXEeNjsUCELemUwa87qoNS5wFXbq3HNFsrmETjFBeAj//fs+wCmJdChSJzQBlsUBS8M7ilwOY/m/dqspV+KvFzYZNCgLXz5QS1xupe9dp+YzneRanVZ3cWjz5RHW7qn6BLwIMtYY+JSH/kpNr1FYMuy6YAmzK/9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(2906002)(426003)(8936002)(36756003)(26005)(4744005)(1076003)(83380400001)(33656002)(8676002)(186003)(478600001)(5660300002)(9786002)(316002)(9746002)(66476007)(86362001)(66946007)(66556008)(110136005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: j6Q+SeMLiW0bE3I0BZVWZYMR6VvxkC5U/AOPMXPaBpu6l+U70p4xXzv6sVVNSmwEomQQ6/nAHbrGp9zXRiSGe3gkfmbGpsGADrinYGcA1LsP/tsddQUn/iNdGEqRpHEyxirAX6lO9UyQ8DmoTZlSIKVud9FxPUpJ4O7cjdMXfsJBortDIPjnecuOo3rfjy9iIfoQJloCxQIUXlyUodYLa9a4MUYoAk1YCpIv7janbpl9eAgpvz+3RirsVfqL1iIUBlgTENh4CRNHEVxfHAj9DeoMrffKjxY3enlOTdsNPdO+PdLlAJiONuPg3hnSRruvBAESeruH9IE/HctdR2y6o+bFJY5Guhet4Awu/zEGEe8cu66S9klRSbUCJep36vpVK/fm+bJm9TcBvgl0MzxnZVf2uaSUrYCeL0bYj1k8zbFDwZW2mBDKym6V7pfHnPelmBhcGzMpDAhvRCKRXHay0diG2H9InIXvmbQaRUJLOhJvv0tI3k/8Xe7QRlujja49rPunUhpnEANiKMTZwhfjd3Vy7GCJL8D8U3nyOLoK+EgQ7uHMU56r9WWlblMFbnFqkFE/U62ZlVr4DAMBbS8pz+KuXvB5PxaFiiglaLXsA+YxXmHVM7z0RUgmVsbkihnpUF8sds6dqz2/BR/lWINu7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 340e8830-4088-4d34-25a7-08d85655a122
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 13:21:45.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o03S9i1aCPdFd1p55mZE2qIGd/7XpW3RgejfpKhyPWl4B2OND81n+z9GPTRO8OWP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599830370; bh=6dDtkZEogAoHeVSg7NLTozsnk+Tlg5q/Wiza/rbHfIg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:
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
        b=YsVKmu7kzrTO7I52z02saTF58dYlq51vNPHTORinRp+gkIiFr9l33x8LQQheDNLxr
         Wnoyfa8l7tUvE9O0/N6bHFaOMBYdscLwPDfg+YfUsumk5kBfTamdjTVlZXGt4HikdO
         gxliXR8myDjrI/895xzJQ0CO0i8IlmV6XVmUOkH2KsrZZv+36zRsESzbNF4NAJnvBL
         NXDB+bJB2AXJU4OsTUH8lk23At3pdKzx54gB0HvmeeVQgDEZrvHrPk1JPQ+mtYseK2
         5YP3Yg2wqTetB2geM1azYOUOa/7FDhy6EeuXOd6O4MdZvhz+DgTOWGfQwo61vaJSlt
         jjPVgcbzrxeBg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 04, 2020 at 07:41:47PM -0300, Jason Gunthorpe wrote:
> @@ -33,11 +34,17 @@ static inline int ib_umem_offset(struct ib_umem *umem)
>  	return umem->address & ~PAGE_MASK;
>  }
>  
> +static inline size_t ib_umem_num_dma_blocks(struct ib_umem *umem,
> +					    unsigned long pgsz)
> +{
> +	return (ALIGN(umem->iova + umem->length, pgsz) -
> +		ALIGN_DOWN(umem->iova, pgsz)) /
> +	       pgsz;
> +}

0-day says this triggers a __udivdi3 error because iova is 64 bit,
I'll change this to:

 static inline size_t ib_umem_num_dma_blocks(struct ib_umem *umem,
                                            unsigned long pgsz)
 {
-       return (ALIGN(umem->iova + umem->length, pgsz) -
-               ALIGN_DOWN(umem->iova, pgsz)) /
+       return (size_t)((ALIGN(umem->iova + umem->length, pgsz) -
+                        ALIGN_DOWN(umem->iova, pgsz))) /
               pgsz;
 }
 

Jason
