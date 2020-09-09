Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63050263042
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIL56 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 07:57:58 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5401 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgIILgj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Sep 2020 07:36:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f58b9030000>; Wed, 09 Sep 2020 04:14:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 04:14:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 04:14:24 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 11:14:19 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Sep 2020 11:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KssosVZOJ3dqm7lTZkiXqRH73X8zO+z7xVxAdTWRwFhkdD8KERxCEB9AiJFs/hQiSM/EWMYpkOZGyLkRgWkZcbCiiLsT/ITIv7n5Meg34KbK7AKTmXA2q856WKuFsqVBdsLWWQuBjt8Ib6ONaqtWhNyN45KK66PPhWxCuwYU78DeElGVmNJqIBlRW3Ph/Se2HUp0XREHLn+6kDKbAWYV6bwU9ML7qLYwjG4TGefuoq88QGLLv5rh3GvUoU132ExHkZlB9ocX5ucdwssZ7q5CttBgaK75A4V//Nt6ET6luIhjtiw/Qs+ijrb4g0wYMNfkhvZfO5hFuQ1jah7rQOa3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joyAHVEazuaUrv9dj0rNsi2QAiJDU+nTfi+0sVhiJrw=;
 b=ehuTef1vvCF0gD1GHvMr7JLxQ8BcVFfPHnQ562akBBoJvNMFk353T2MTIeXSS70YZOw56zDqkL1BQ9JPrUbmCHNPUfFotrNJIfzfoiBBvnHzWHeOeEP7YIZoI/g1g1H0CkG4ac5PPgbXQVFOcr9zrmn2TIIc0NOpi/seXCod2lO08S9F0Y6AMIEnjL3dM+T0f9pf0CJHIOWn+w8MX93dvE3MSwcNWL/DoVIQW9g/mdjoY2qpUavcfHSttIqxGSMRsLmp9TEncQCUyspEIbm79KjIDYNluy7wRztjp0hGMhkTos3ryKhw2HAUhMIszip1Lx9eWgbxqmi8YZU3ZB/06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 11:14:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 11:14:18 +0000
Date:   Wed, 9 Sep 2020 08:14:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: Re: [PATCH v2 07/17] RDMA/efa: Use ib_umem_num_dma_pages()
Message-ID: <20200909111416.GW9166@nvidia.com>
References: <7-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
 <d9cb7f02-86d0-25d6-1314-cc048fd1ebae@amazon.com>
 <20200908134852.GE9166@nvidia.com>
 <b1b96707-59f8-5c5d-d529-6f6d9ed16d9f@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b1b96707-59f8-5c5d-d529-6f6d9ed16d9f@amazon.com>
X-ClientProxiedBy: MN2PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:160::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:160::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.4 via Frontend Transport; Wed, 9 Sep 2020 11:14:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFy3M-003HKa-58; Wed, 09 Sep 2020 08:14:16 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45a4d628-4d1a-4468-88bd-08d854b17e4a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212FB865115499E481688F9C2260@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Z1c8W6sRnyhnTO/dozRL80dVwN+dw2FUQbuYTcvr2zy8UFTvMSiCKsJuibtPUfMou7m5XL12A33zL/wn3NXb5qnZTOFypS70TDooDcWSnNge2EVWuZKh8Kq1WX8hTQ9Ip+iXX54UhevMwPwBSx9g4OwNFFGiuoWFF8uOKmyYq4khP0Qe815PUHwlwscwvgUWL3V1wtYehkyk2ez0bqAW0fuWKqU9SK6zbjub6Ep7jBIEr6sXt9eG5tlpMuUjINvmTw5gJXpQNjnbS+CiDheCx79Fls6XeyXhScUZGLqO+Z6yxlI9BOOtzQf7+leng3Q2ENWXQgIEveKK07+7Bv33Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39850400004)(136003)(366004)(5660300002)(9786002)(8936002)(36756003)(26005)(8676002)(9746002)(186003)(2616005)(66476007)(66556008)(86362001)(478600001)(66946007)(53546011)(426003)(33656002)(4744005)(4326008)(6916009)(316002)(54906003)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3L24pS3Ka0H+YDRO09TKptlQ/R+3mJ92i0RcRv9l2KCebID7qk7aQXL5Rdp5PVRxvN0sK8HuiJbPNcGr4aKcj3STeU0q3KSW1GRfiRac5K+Vn3BO62aqW8zFCTUCm0QNvBJ5efMozYsSPEUmhVK/EBSCZ+Mg0aSy1yIqCj2J/snv1VU8h5ZuIZRkHZm5jmVsMb8csQA4m1syTf//Vz5LXw1nObAAmbTWPe7+TAxon+3s4JRGBI8Mrs1XIJD7WM/WG7kd1rQSMKEKHvEEKdvIOaxm2MwWODWEF8KpgM7Pp4xQpLZuc3XV+oldrwxiFnEyaXqvuK7c8CPAw8lrMewWAoHk9bzjf49lOS0mGRZa3LJTs206rruH5ibZbWHZydmSHYHn+cEuUajTGjTX31hZYau2xiQj+xcRcVauHC4TpvWuNmWvnR69waP/l6TconWuO3n4GPyBIAkWNsVD4XShoMtJAkA+9KfnEmTaJW/ZXUPo/9pwdMY7WE5Xps1y53DoNQAkqUzZbv5HS8nPI3KZQanYlV+J7phX+NbBsSAKdbfCCWctmPrZk5bQBmmhCMZ/ZJvmb0XGOhofKRsm7H21bf/WK8M948CqKFQfE9kVG1d1xDxUhdsp19m1nnDWz9c9zJ4C6FjqEAAk30uXrTwfBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a4d628-4d1a-4468-88bd-08d854b17e4a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 11:14:17.9242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWOV2OptuvzyzpzH8pLRDu4HEM6gxM9o4Rghou43cStlJhf4aE+gK4xif7Ota8yc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599650051; bh=joyAHVEazuaUrv9dj0rNsi2QAiJDU+nTfi+0sVhiJrw=;
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
        b=Nm5R2ViLyhM5YgaaiVaWIsFGxWRE39usdypQpD9PlfERNor2rWpvOPnC9m/CXiy95
         61cMfdyLVZQr+SNgMiG71dBsfTawfgh9b5aTbCaEFNB5qLMsBpI9xDbcGNpJIUTC68
         ozz/OlEfuMPW5b6T4qCOAIk1Xvus6kqo83z2CsrH80n/2DwpY/fypO3oUYZ2r2fewe
         YlyXmScEUwUmxrXD8VOtZ1ORMzk4UKFVVJQL6+I110LPZkVVSTGfoi0uY5976A7Dmf
         FpGs+VOg7bCJP9Vw+NnjYxwVxP39yjIGpV/2bfTGDgWpk1ApD+CQ+aj6SDZOWpXyul
         C3BkwGAYTW/JA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 11:18:49AM +0300, Gal Pressman wrote:
> On 08/09/2020 16:48, Jason Gunthorpe wrote:
> > On Mon, Sep 07, 2020 at 03:19:54PM +0300, Gal Pressman wrote:
> >> On 05/09/2020 1:41, Jason Gunthorpe wrote:
> >>> If ib_umem_find_best_pgsz() returns > PAGE_SIZE then the equation here is
> >>> not correct. 'start' should be 'virt'. Change it to use the core code for
> >>> page_num and the canonical calculation of page_shift.
> >>
> >> Should I submit a fix for stable changing start to virt?
> > 
> > I suspect EFA users never use ibv_reg_mr_iova() so won't have an
> > actual bug?
> 
> That's still a driver bug though, regardless of the userspace so I'd rather fix it.
> Should I submit a patch to for-rc? It would conflict with the for-next one.

If you care enough then propose the parts of this series for
backporting to stable once they are merged to Linus's tree

Jason
