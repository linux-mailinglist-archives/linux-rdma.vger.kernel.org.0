Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B0A342F8A
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Mar 2021 21:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCTUiq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 Mar 2021 16:38:46 -0400
Received: from mail-bn8nam08on2085.outbound.protection.outlook.com ([40.107.100.85]:15072
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229901AbhCTUii (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 20 Mar 2021 16:38:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CouVkTWeGul/aZpemKMnaJsGF2BFNzTkaCbL3ADvioXiIM+lRpQsrrO4Kd8cR9EMKs0d7rsJ5kNWtwL9kjKNtUNzl+U3OhRPlUdmbYhOtjvpLm1pxOUKaqgHF4X52ZJ/86cdYhy5J18sJs44KrEI0KDdK4hik36r6l2YCFcTyQKSOj6vZzaWseDgeEdzC/6EHOywoBsWRzk9JZFkU2teojN+f8d0in7Bk3FEVuHmhC1dYfQkmDAPEdp6HI8KgiKhHQk3IqHyusUUPL2lydtaqdgsCt6f0uBgqgxs5HMZYuU6YBZHTrD9EbA8e5i7VgW5GZVaO0zmhFNnEV7lnHqkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/TBSlE3QBp2SL3ch0U/geWh8kge+rNvfmC8SW12wI8=;
 b=J+alY50URiyAbMABxATFdAil75lL2TtVHJ5mgPQ23mmzA6GX3BHaj/Sz3j1qwd0T/BF43ldPZdD0siTEEO73isD4Ll3iQ/CgEHGzEgPSzJdO2KQvhKGw3kmBw0DkJi6vJdxw1mMreETxMhfITXhKydMGxKsqxXvcjeLyrEbjYfVxmqbngvVCJyQmiW83LarwvpXknzJL9CUx+W0K8lOn3X4Kb2AgQMNxBsIAw6/m+IiMvlBaQ0gI/vPZUvx9HILKPTxOTM/sOQWhAaAiKfofoI/EkY+vjOoK73CkeinVInwJmg3jFrwzPHAzBNsnwrwcuKZwHrST8TSBpjIeLno0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/TBSlE3QBp2SL3ch0U/geWh8kge+rNvfmC8SW12wI8=;
 b=XdWpET3Wnf8ieZslMCsuAIAMWg3PrlCBqHgKCs7wF3/MQiaoHf7CZq/QyhzZgHq5vI6p5Phg4b6Razuwh+fgBn5zoilIK5l5EXeoA8sYkwPr+009squ0tjaKyrV5n0WfdMehVgPGU2QdrYcqfhA0JH5HjGbq7GjIhNK7Qk5aPLt0ChrNgo9gt68uUqwBA5EI2XHKpx2GBoQ6UML4qDxFUUyrymaW8OpuAxesXxiZO0XFiosMe7fFXmJWYYnw9NtIjvKuOl2719tgfHZW1WNArD8G3m2PtxnviOyivzTeucSg7/HwYDPnj4JUrGP2P0zC1/KUVkjCXligO9sSJvnBzg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 20:38:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.024; Sat, 20 Mar 2021
 20:38:34 +0000
Date:   Sat, 20 Mar 2021 17:38:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210320203832.GJ2356281@nvidia.com>
References: <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
 <20210312130243.GU2356281@nvidia.com>
 <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
 <20210312140104.GX2356281@nvidia.com>
 <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
 <20210319130059.GQ2356281@nvidia.com>
 <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
 <20210319134845.GR2356281@nvidia.com>
 <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:32b::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:32b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sat, 20 Mar 2021 20:38:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNiMi-000HBw-20; Sat, 20 Mar 2021 17:38:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 319ce7ea-f5d0-408e-fb3c-08d8ebe02156
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4513CC9FA451F2068D72FD7EC2679@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCQVy7liWBe8t0XNxE4DLLbRYbc6cuLWzPnkN5ncML0P/YhDh1JZUOGJyXRcI3+uFszjS8GDMviXv5sNIz7c/uX1KpAaZGBWF+jCCKVSCUJJO185gQ3YpeZEmGsaRiJKGScTOrSzeETKn5E2F07QzGQXaT4xoVATCqetrNI0FWy0B4Q50XTjGMhWFdmsJhETdQK3hI1stRMh6q3EOAe3foTGyWh9FHAR2QJVVxaToXGMds/ZShpN7kOCqXd3r5dFV0r079+Qldkca6mJK/sqAYmZ6CgkrGatWffYin4/D9BUnbvUwAZwLHR9KiWfmLeALUQcV394yLeT0S/O/mjvB9igbOEAI/f5+Zti+ta00ZzZLPh8mIfN12If5ZEux6Tza6LVrWoo0ltnwTmQ6+FaRix38yB4iC1yxSd4rt625J9YH2En81w2SfDo6GL06dJEM6M7w/RiYW51W4B+43NRBjj9Yd0Cqq4zxGuaoWRneRm1Z9DfkXnmnb0KHEJxvmK6+f0j2Rn10F3n991+VTIjzDW4fIekJHKgl58AGznMLp4jQVYtd0fqn843RDmFHPoXV+bDVGErD4thjToxdTt86thsEgnd+GEvCQOrw8pUdvha7jRsJ0Z9i/lz4sfHJY2NU1I2eHYoc6E0Fufaic8AFX8vIhPlLP00J6zd3hNZy1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(66476007)(66556008)(54906003)(66946007)(6916009)(2616005)(316002)(53546011)(5660300002)(107886003)(83380400001)(1076003)(2906002)(426003)(9746002)(186003)(26005)(9786002)(8936002)(4326008)(36756003)(86362001)(8676002)(478600001)(38100700001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Y+Koedwe1bLoDvJj+W1IlvJn9ETB5jJuuv6BwIZYa32Nnlqsv9KId+vNKtZ+?=
 =?us-ascii?Q?KTOy14qYvhd3dTlrCNUKlrqG2U22VKhaNmDJkzHQbfwAaxmAvqRczi3qKmeA?=
 =?us-ascii?Q?4/N81BABgQrR5dNC+TNnLjh3nLCmAjAEfAjY+JT2RzooI0uM6YpUqynyn93r?=
 =?us-ascii?Q?xZ4dpboOo9f+zQld5HhYA4+oIckbyEpOYiEeaSFgBD2NNCdP5XjWIYFSdMLB?=
 =?us-ascii?Q?f7gd9ygWKVj+ib/HdZiBMMGXmhhOlQ9/U1k2wSjwJ5ccZUcGiS4aVEmdTpf6?=
 =?us-ascii?Q?GwyEsDwmtrHC3J7exutqSWuI6kdyCkD3W0+o8cVkuHeLuWybAu2ca70l09pM?=
 =?us-ascii?Q?QaXckTvxHsGEqnPkdhEdJjbFh3rQVWmtjS2sJlhpG0DGC/KCdCwKfc0ylecA?=
 =?us-ascii?Q?bUfmU5q8v2pG6syia4uhIdwzs74zD5rl/DcKqUWqJ5o8J+0JsiA2yKIDZpQI?=
 =?us-ascii?Q?YlqWvTlYOWZM9OkMuk2hXCCFWUZ8qJM41fpyiyi7Ne5f3fH+jQjEc11gS19w?=
 =?us-ascii?Q?4HxyIFaiUpq8aHkQr38n0GRs2kKtIr+tb/ir0bnrXPmvjCXYrZH8n9jhxiYv?=
 =?us-ascii?Q?QaWCa3ZkLsNCV/hEl5ad0EK6wxBC5odSntIiiweTERk245Bc/0GWtBotLAdA?=
 =?us-ascii?Q?U7U+s8CG7HK11OvhcjZtI3YGvB0UF2poYrVh+O4qIIXOD6b6ueFxEDetP+8p?=
 =?us-ascii?Q?LUjtiX4wPvWkCFZXy4Z3W4OoWUmaVykempqqMwEzRrKiW9zmHMksFCn7CQex?=
 =?us-ascii?Q?IGvMHEL5k2LBd0XBz9XI5GdSxzfSaSV7ulx0CgUTWrraHHOsoquPOsOhYRj5?=
 =?us-ascii?Q?42GrqSlyzJAZBlF3KCX31ru6Ki8lLQuDeYDFgAm24XOJri5ZcjQbzWCf5qZi?=
 =?us-ascii?Q?LAgul4e0XEBGCQaaQ0GVVj9eEP5/RtCRxbN4iqFNy6gtIsGeBii0AUHHMYas?=
 =?us-ascii?Q?Y89mEF0fe8pZnY70BQoUsX7oWb4jdNaOW3i/QUxUD2MdBSMYN8V3EHB5j6Vh?=
 =?us-ascii?Q?KLBeTqr5/AaINMT7gtUvGjwagc+uPilra0xrzULU9lQcRLCCdTu2/7u4qh4v?=
 =?us-ascii?Q?b5mtsFZYjuxUE0ssMeBjH47owtB8rzQ2npGvrczpV8/tcV00mMHb2KQgFigp?=
 =?us-ascii?Q?5LPxQGfQ0Y+7RhKGe4g9bi+/IWXJek8kiK6jbAegiXSOSku8vnBdJw6415eA?=
 =?us-ascii?Q?r5exd6II0fZPCXW/Rm5L7hrk4p5CiElWWbd0xgyHsUAhJJTy7n1ckYiyZZPz?=
 =?us-ascii?Q?RpRfbFEKWbPY2HmFObvIOVlwTRG1jhZy+bzhi0ntDjKPXCe5De+av0P4+LwI?=
 =?us-ascii?Q?rhOfwpo8MvdCs+OaZFmsDqLx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319ce7ea-f5d0-408e-fb3c-08d8ebe02156
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 20:38:34.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDBA2doG7ChUkESaSRYcm6+aA4rJ3CEARrHscY1UuFffwQDUU+FBvcyDOT0+45Gu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 20, 2021 at 11:38:26AM +0800, Zhu Yanjun wrote:
> On Fri, Mar 19, 2021 at 9:48 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Mar 19, 2021 at 09:33:13PM +0800, Zhu Yanjun wrote:
> > > On Fri, Mar 19, 2021 at 9:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Sat, Mar 13, 2021 at 11:02:41AM +0800, Zhu Yanjun wrote:
> > > > > On Fri, Mar 12, 2021 at 10:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 12, 2021 at 09:49:52PM +0800, Zhu Yanjun wrote:
> > > > > > > In short, the sg list from __sg_alloc_table_from_pages is different
> > > > > > > from the sg list from ib_umem_add_sg_table.
> > > > > >
> > > > > > I don't care about different. Tell me what is wrong with what we have
> > > > > > today.
> > > > > >
> > > > > > I thought your first message said the sgl's were too small, but now
> > > > > > you seem to say they are too big?
> > > > >
> > > > > Sure.
> > > > >
> > > > > The sg list from __sg_alloc_table_from_pages, length of sg is too big.
> > > > > And the dma address is like the followings:
> > > > >
> > > > > "
> > > > > sg_dma_address(sg):0x4b3c1ce000
> > > > > sg_dma_address(sg):0x4c3c1cd000
> > > > > sg_dma_address(sg):0x4d3c1cc000
> > > > > sg_dma_address(sg):0x4e3c1cb000
> > > > > "
> > > >
> > > > Ok, so how does too big a dma segment side cause
> > > > __sg_alloc_table_from_pages() to return sg elements that are too
> > > > small?
> > > >
> > > > I assume there is some kind of maths overflow here?
> > > Please check this function __sg_alloc_table_from_pages
> > > "
> > > ...
> > >  457                 /* Merge contiguous pages into the last SG */
> > >  458                 prv_len = prv->length;
> > >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > >  460                         if (prv->length + PAGE_SIZE >
> > > max_segment)    <--max_segment is too big. So n_pages will be 0. Then
> > > the function will goto out to exit.
> >
> > You already said this.
> >
> > You are reporting 4k pages, if max_segment is larger than 4k there is
> > no such thing as "too big"
> >
> > I assume it is "too small" because of some maths overflow.
> 
>  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
>  460                         if (prv->length + PAGE_SIZE >
> max_segment)  <--it max_segment is big, n_pages is zero.

What does n_pages have to do with max_segment?

Please try to explain clearly.

Jason
