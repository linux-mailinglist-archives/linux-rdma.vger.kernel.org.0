Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8840025C35F
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgICOuU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 10:50:20 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:4880 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbgICORY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 10:17:24 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50faf00001>; Thu, 03 Sep 2020 22:17:21 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 07:17:21 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 03 Sep 2020 07:17:21 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 14:17:15 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 14:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDdiMfzxjP0UGfc2J0VYz7tHavtOmK4fUasAWPFmbiEeI2KpKG7vjuBG4BH0w5ydP+5SfkIJSl4N+roObitzHNMEe85j4dCxInOzAMNrPGDSHGZEW+8JJQgKs9+5Vk9yIB05w4ZvnmxksYPLZpkJQB1J66QyQjJ5AjABNLqFP87yWNLaq+gIxijiEjt/SzpKdFWYNkQVZ6lksvVay32Q76p4PHAdRzFkQhDfQSoCdUNU1bvGQqxF8ntgPYbVHDrIv+3bEdnczjC50WV5mwKHGy4bKFLkm96C1pnKCuzjubwnkYRIoLGCXiG43CooZ6F5NIczTOc2K+cnaOoGxiKBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOTHqnFT2ewrOZFnF7WlFYAVUB8xvbVaba73cuUd3HA=;
 b=fRyC9ocSJc0nGyUypw+WHZtMJ4NDmzpOhK1igg3MYFSJcYKLZQ9lnIj5SjlxnM2uROiC9lX/hnLGn72Djs88thV22Mrc01dTzzqoEo5JpBXlDytH435S6iq33MQCFrL215VYubECw7IxV01wPjNQzxpSW553CBhbAYaJ/OfuE9zkSyrO9GMKjRL60extLFe4MkqCQj6oeH1EOqQ/OzSt7u94X17bIT49GkbuNDI0PkO2s3oNaSt1eGJT8mxtAK7PU20xhZAuoDSHmxrua4PKnjlEU/zYSMRCGAC3Pv9kjYSOFbLbVK88V8LXVdzPuGuznkc5PPGTbiA8V4P8AFk/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 3 Sep
 2020 14:17:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 14:17:13 +0000
Date:   Thu, 3 Sep 2020 11:17:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 02/14] RDMA/umem: Prevent small pages from being returned
 by ib_umem_find_best_pgsz()
Message-ID: <20200903141712.GF1152540@nvidia.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <2-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <9DD61F30A802C4429A01CA4200E302A70107141173@ORSMSX101.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A70107141173@ORSMSX101.amr.corp.intel.com>
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Thu, 3 Sep 2020 14:17:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDq36-006WE2-1c; Thu, 03 Sep 2020 11:17:12 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d006c40a-0298-4407-fa8d-08d850140dc9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:
X-Microsoft-Antispam-PRVS: <DM5PR12MB114593585D86F8C32E8040C1C22C0@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HeNtRCvULDjtMoTkKxJDfyJg4PiNOql+E89d34qS+Aj2CMR8fdDM/Xx8Ps2oMaWwS/LUbIn84SHa6jFvXmirlnbvpPeTW4m/6ttxMMTLAsd1viJ/MwlawvU42rHUdNATpaxZUirn4NLPkDfUoaAm592902teXsBYyiyHB+a/mDyKtYlWcsmWtp1qeR2avnMGgWI2qpeF3reDpzb7KVcoD/MQP40t8dV1+et5x4imIa9R/7zd4jvkit3fZ0AFFxrqYQjcSesJFOuOsGyy+6UiQiGOnE2Myc0WDbCCXlfsDY/6EAJ5wMkbT7i7bOQxqLIZwQe7SNi0OzkAhZpchKsQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(83380400001)(9786002)(54906003)(186003)(478600001)(26005)(1076003)(426003)(4326008)(6916009)(2616005)(316002)(36756003)(9746002)(8936002)(5660300002)(66946007)(86362001)(2906002)(8676002)(66476007)(66556008)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9D8xl5zHyfeL1cfJGyyDj62Cv8OAcpMuFbUyRc8Q5FYga6Hrmxwh4usayC4GJEjEGZefNgK/3kaKi3ug3VGpyyjezvF/OQnW8fnGHvK7V/hlt/mFKo8jUkwO3ybQqvhzVFiwRnLnx3+X9Oa1uHwNpah0wOupnn7GNSYLftvmmgJGnD6gv4X7z3hoXNnAEjv7bc3G7TaFwEnO+8TeqZrluNr4qXTnlFCktmJzMFpkN2JBteREBl7a19c500JHXcnn4UHXJA5eZO2UVB/KsYCT2tySQ+Z5ToJOUqk2wT6wpO6VjbCU7W1dvP1NH/LiS+OH2wEFU2l9PQRXDtigYZXp8wWm6nP53wf+NY+ev3WbG1pp/87McrxyZYdJOBOJjtSmaPF8RSkiwu17ChzJ7It3kubMxHHuf/lE4I4CLLZuSqMWRE1X9lJ+h1d61YhPDAygX22fWTQUNy4sI0QAXnknncf0jWL7s4ZLa4P3/dqSlc/IC55gWp8ipFXDKz2SXU+OnaPoFA2g6SWqBi4V0seKZfuKwgQRSnJaZDAKe3L8JhIS5k9M8kqo9magjF2q+Ro2QB6YLoicI6RkbwW04FWZ5GlX8XwAnfjLqBWKsLVLuFLOK0G7JD9I6KI0VDH0V+7N+YBF2RQEqpOBlnQpjlbi+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d006c40a-0298-4407-fa8d-08d850140dc9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 14:17:13.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0DoqBG+quhytB5vZEychHCDWvRSxHqeb2aYOshPeev73zTD5DUZ3CvV+I9tSK5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599142641; bh=cOTHqnFT2ewrOZFnF7WlFYAVUB8xvbVaba73cuUd3HA=;
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
        b=pIqqFluxmrPtGWWmFPoz5fIiM8kj7a0LpEG5s6N8wutfzIPs7TtrBiejuxiZIjXd0
         Bc8xnWJyP+BqdikSi1lXfntdSmZcjEdOuWwam1IClZWK/DB1iX3CRKswq+/H9s6DYV
         ZLIxrGw6zlOmcYyM7D0oKk62csMnuCBuKPuSziWVT4alwMGvV7Bv5a131BnEeVIwRc
         PhputwqhrtlIp81JoSdk2x4d6juCGwqeHm9j8qmq/Xe01AbUEJlgIQiHDItvUAJR7w
         7kLbYo2Gnb+iu8EteZl9WDEk0VcDIvw+QyhcVHbVWiC4qzOw5p/cl04Y+ZLir/Khab
         h0yuo06HoPVrw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 02:11:37PM +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH 02/14] RDMA/umem: Prevent small pages from being returned by
> > ib_umem_find_best_pgsz()
> > 
> > rdma_for_each_block() makes assumptions about how the SGL is constructed that
> > don't work if the block size is below the page size used to to build the SGL.
> > 
> > The rules for umem SGL construction require that the SG's all be PAGE_SIZE
> > aligned and we don't encode the actual byte offset of the VA range inside the SGL
> > using offset and length. So rdma_for_each_block() has no idea where the actual
> > starting/ending point is to compute the first/last block boundary if the starting
> > address should be within a SGL.
> 
> Not sure if we were exposed today. i.e. rdma drivers working with
> block sizes smaller than system page size?

Yes, it could happen, here are some examples:

drivers/infiniband/hw/i40iw/i40iw_verbs.c:
              iwmr->page_size = ib_umem_find_best_pgsz(region, SZ_4K | SZ_2M,

drivers/infiniband/hw/bnxt_re/ib_verbs.c:
        page_shift = __ffs(ib_umem_find_best_pgsz(umem,
                                BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M,
                                virt_addr));

Eg that breaks on a ARM with 16k or 64k page sizes.

Jason
