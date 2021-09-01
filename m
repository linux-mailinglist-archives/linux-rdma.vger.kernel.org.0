Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6C3FDEC8
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbhIAPh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 11:37:59 -0400
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:7008
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244351AbhIAPh6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Sep 2021 11:37:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5PnrY1rNXSHkyUql0zPvZFTUQMfdXyMvc7W+KTO8XNeIm+qTf/B5xKY0bIx7L+QTMViJHnKQBJiS4beexhYxhweZbvIdE0iRhhnWlDMdQ6ZyYHcBdX83aiOe3ISCJNaKV6CcRCXOLdXuNG+I8HLiEfZ7f7p16gVSPjEVe6q+I2q9rSA89NK5k6n9/peL5mxJbvyDUEnVZOfKUoQyoG9EMhdY+q7p90iKT4hQKdGloOmfVCbOsQlPLJryCS1DRIAULFEbTzH7fBqiyUSjQenOhA7UB9XeWZ8dVxvmzLQvM/77pw21NdGOV+W0yGhwox75xn9uwV/1NRG/XJcmk/6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8ozbD3JwrV5DcppbxhZ0XINoFvFrGX2rKhEn/YYmNVM=;
 b=SsNrgoOOD3LrKBRWEoEIx5aY3ODpmwpC6TTp8hceNoRlh1yCO3gdwKxKMFKMU8RbD7XlH9XlgrW45Yk21JSKJ5iRRkVlkOyzlgS/yGlDGim9V5km493VUVy/6b7+4A9EWbLDwM2/2qEYdIxtdr2ME25Wu5rIFD76nzcBpt9ga7FsLy3LiY/GQmeG9WzC3JAt+4ddgrqmnDK1ivZBubb022ypUm+WRP5QbDeiiGXyd19sIFSqROB74xhL6lIGr8SXJE/+cOFtpb6rF7ubvRsChjRSBzce1DPLzVs3sPFgFupIqJY87/uXviWs5L2Pt2gnlBsS05bbHw6DQ6GR7hKRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ozbD3JwrV5DcppbxhZ0XINoFvFrGX2rKhEn/YYmNVM=;
 b=n9WsFadUKsKVOhsJM+fEFJccJmxn4m/VGh8YXiwVV4vDtb1VKNe9V1O2iTGOu50H3McpV2iB0H1gXIX8LsIz8qA23pCAoupOEaHaUg71h/v3yW8+3p9Bdmg7BE399Ly+Mw5Q/H3X7exeTQeafAaLsIgsVg47wJIV7wtg1OYQMT+b/AGq3DLD7LIFkdckQAa+F2D2VI/jC7J3NkDZ9DLLKkxShAXxxgFTTCewsJQ/c+y3zyRXsWEuFb+D1pJI6Rqa96wnMncyQEbf4N05dmKiWejxHH7byARb6JBTsIFm23Wx/S/yutfoIX2Mz25TqScMWXaY/cVqO+4oI22/WmPAoQ==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 1 Sep
 2021 15:37:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 15:37:00 +0000
Date:   Wed, 1 Sep 2021 12:36:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
Message-ID: <20210901153659.GL1721383@nvidia.com>
References: <20210811151131.39138-1-galpress@amazon.com>
 <20210811151131.39138-5-galpress@amazon.com>
 <20210820182702.GA550455@nvidia.com>
 <7a4963ea-f028-e787-a5ba-fabf907c6d6b@amazon.com>
 <20210901115716.GG1721383@nvidia.com>
 <c8549e51-47a2-1426-b44b-f1c4ade3dce2@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8549e51-47a2-1426-b44b-f1c4ade3dce2@amazon.com>
X-ClientProxiedBy: BLAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:32b::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:32b::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Wed, 1 Sep 2021 15:36:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLSIN-007rVS-Ck; Wed, 01 Sep 2021 12:36:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 197ec16a-e3e0-41c2-d6ef-08d96d5e56bc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5143:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5143FCC9B7B68411D73F9B5AC2CD9@BL1PR12MB5143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJW6DXgo6ekGcB2rHJ37MJDDZavfZ08YerxeHPRj25JKRGaXksghRyexHdAQme829W7p+lmWaNfvCteXDoVV/pQg1oJ3HCwvIhivvR1D/6aKBQ7tw/4fkLqq3v5ipRYCCcSyeeJN5TeBgeSzC64O0YMoMCLRaqjRgnU5XJk6t7wr29FLWWd7oCRmRM0F6DOV2DDHZZZs93Qy7JAKlCkXE+tXS38K+sLhAPtmtCsmRbss5WVaIqb1esoe8lknZq4w3/uSyj/FV2bOKwlbewA3lmdbDOeyLHIkJVolbD+vlMO/XqcaFw/BqmQh7FucN9kuVGtSMqF6koG+tVkfJsp8z/Wab9HXmw13nM/OnD/wSUwMTDG1QFewqei6FC/l9uQwAzRD383HMfrrPr5D+p9JrSA7cWQQsQTIQ3Gu8wZjaZLP335CifBAn1vbQqWPpeKlg1UkKxYAC+KZf7w30Gk5hy1UQx7j5DAZ8jAsWkbFJd8LczlZyPh7j93wj7Ez8xFnDMlqyKqTzuJiHLWRjQIP3tNSOi6/+HrtTd+uIHEwzERpMde8kcugxBS7Atpi94hSdeMdalFPi3mBtycAfvgmboafkVmsspRzC0r4nnMChJKlvilFPEq2CCy86NLNrjwn1d88/eRbTgNZJPJ7lskaXO96xOV6o4RtAqOnTDZrhomOjLlvG3K7luNjCVlxIFp8qleI0I5kfhgOrK+tmUR8JUMk9ynsQbN3HTzRwPNL/wke322wNo/jVmEFqpfF0xu+raZ0HuKxYf9QAnvAWxeKVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(2616005)(426003)(6916009)(33656002)(186003)(86362001)(1076003)(38100700002)(83380400001)(8936002)(54906003)(53546011)(9786002)(9746002)(966005)(4326008)(66556008)(66476007)(26005)(478600001)(316002)(8676002)(36756003)(66946007)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3c1hWLWKYmMzqXG+aLNAoH0zr0EFSgcI9VvhCZF791h7rJVALCEkVNUQVdVE?=
 =?us-ascii?Q?Tbg6NXNCcvuVll0gNam8KJN+6EIQ1I+0opSniscs1BtbkMZFCz6fUC/KSTZn?=
 =?us-ascii?Q?cKIF/iyB0EtzHJAD+yELACmnCo9hEN1l6GgU5Q96Z7kE1fagkFW6/rQylpXg?=
 =?us-ascii?Q?y0VGaWwbPlTpZRar3gE/VMH22jV5nzviP8hUBru7ECxDCXpESOKf7xIOyVe/?=
 =?us-ascii?Q?nYJyTlyjMRTch06FiwiuPqxx11Ns9Ry9j3DGjXbRr2DAVYy3zRTM1sEUxZ4o?=
 =?us-ascii?Q?dUhYBiS+8Kq1og1Ylnww8ZGGgiriINw7+HWJm/BDU95u6QO9vO0ZR9narJJf?=
 =?us-ascii?Q?jFT0RLVXnDW8co0paXUlcIr/c+jq0IOZDBDb5LIecMi8VyXhAJlVR94oHQ7U?=
 =?us-ascii?Q?6+zGznelwPfN2aMIv/JXFvuMe8vvz6mvqbM8y+XWe91Sb7DJDwXkP4WO7fQ8?=
 =?us-ascii?Q?EZt9rTrMNzstaWdE9Be9JUwcvxQkut1e8Li5AduSUmmZCWMB8oUQh7nsay3a?=
 =?us-ascii?Q?ffiWhfb5QAlt+9RRSYV2+pMSAypA8Rzjj2zUAAnf2C/w3XCV5cNk9bGsUOQj?=
 =?us-ascii?Q?mFmy5WmltMObYWkCRNPJoUb8KgXGH7rl5/yvXWoZ3ALGiZpwQ7gKGAavHR2Q?=
 =?us-ascii?Q?jsxIKeXDrpl4hhDpPNgAMOTa6eOypRhZATvkUy0V6EO1cJ5FbYxUEcgypHJo?=
 =?us-ascii?Q?66gTtaN/Kxfx6rQvB0Ft5Ic5c5lSnFaNWrSqTKjKsWPgWeh0OuviUESmPhOT?=
 =?us-ascii?Q?iv8zWWy01j5V+uxZyABfVspS9ZhLwydEzmXqmp2BbJVEH4EH0uGmvaMXhC/A?=
 =?us-ascii?Q?ECc8SM2Ek4KeuUsSlvx9XQ+wlkDDwZVumTVQXUTa8H1tqgmEXZK9m1QXPJYI?=
 =?us-ascii?Q?bSRw1GFu6/JZ4UfqmcBGJqQIuMJIVr1g0BgUc4VzA9KWHPJDusFkipsuyXA/?=
 =?us-ascii?Q?z7lS1VWdQUalzzI/YssqqYWpJRzBoi/iT52Na+H+4hM3HgwbhR4aXY1C/kNK?=
 =?us-ascii?Q?Uth6p+A1mw2Zqhh//TzdSChUfCSbju9xzPtZDbQEuzBTw94zOEOMXAvU5/Kn?=
 =?us-ascii?Q?IJ3+mQj/1gG7rjxJ7Npq+93khtSBpOUU6uuwg+fwg5BDtokRbJyax7scqKOK?=
 =?us-ascii?Q?NJacFygJ2QbrWZzZCFYh5/paytbL35mev/2lDAmX2gXfIHJqAuSO6SE6ojbP?=
 =?us-ascii?Q?teG6WhnX/LSEyr1W8Y/3UW7oBIb2wfpqJ/Acoa3KUHhNtK9QwDYOYOplMHuG?=
 =?us-ascii?Q?QCDLGLvF5Cfmr/HeAD4J7wqmxQ9x8JsX3XyZrikTb/Q2JWU+XP/tDQuA7KPe?=
 =?us-ascii?Q?mJMIQmom19VOnEM7VbDSyTcP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197ec16a-e3e0-41c2-d6ef-08d96d5e56bc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 15:37:00.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bn5nCeduHB73t6HX5KeirLgtkcUmM8NcnFF+FhRTC2aNS2LCZj2+XEfD8T93GF6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 01, 2021 at 05:24:43PM +0300, Gal Pressman wrote:
> On 01/09/2021 14:57, Jason Gunthorpe wrote:
> > On Wed, Sep 01, 2021 at 02:50:42PM +0300, Gal Pressman wrote:
> >> On 20/08/2021 21:27, Jason Gunthorpe wrote:
> >>> On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
> >>>> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> >>>> index 417dea5f90cf..29db4dec02f0 100644
> >>>> +++ b/drivers/infiniband/hw/efa/efa_main.c
> >>>> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
> >>>>  	pci_release_selected_regions(pdev, release_bars);
> >>>>  }
> >>>>  
> >>>> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
> >>>> +{
> >>>> +	u16 cqn = eqe->u.comp_event.cqn;
> >>>> +	struct efa_cq *cq;
> >>>> +
> >>>> +	cq = xa_load(&dev->cqs_xa, cqn);
> >>>> +	if (unlikely(!cq)) {
> >>>
> >>> This seems unlikely to be correct, what prevents cq from being
> >>> destroyed concurrently?
> >>>
> >>> A comp_handler cannot be running after cq destroy completes.
> >>
> >> Sorry for the long turnaround, was OOO.
> >>
> >> The CQ cannot be destroyed until all completion events are acked.
> >> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/man/ibv_get_cq_event.3#L45
> >> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/cmd_cq.c#L208
> > 
> > That is something quite different, and in userspace.
> > 
> > What in the kernel prevents tha xa_load and the xa_erase from racing together?
> 
> Good point.
> I think we need to surround efa_process_comp_eqe() with an rcu_read_lock() and
> have a synchronize_rcu() after removing it from the xarray in
> destroy_cq.

Try to avoid synchronize_rcu()

> Though I'd like to avoid copy-pasting xa_load() in order to use the
> advanced xas_load() function.

Why would you need that? Just call xa_load() while holding the
rcu_read_lock() if that is what you want. Can you put the whole
function under the rcu_read_lock()?

> Do you have any better ideas?

Other common alternative is to use the xa_lock(), but that doesn't
seem suitable for an EQ

Jason
