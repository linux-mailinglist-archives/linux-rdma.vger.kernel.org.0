Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E92388DF8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 14:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbhESM0r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 08:26:47 -0400
Received: from mail-sn1anam02on2079.outbound.protection.outlook.com ([40.107.96.79]:8494
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238053AbhESM0q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 08:26:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHqp4V+T2uZVbxh0/OdxLLuo8t9uLAgKAnWgTgYEElE0/aKU/4L+65XZryxUWB0jdDKHCPH1Ptgi1HoAPrFYGSzYWnoqAzcSmhUdv+RCyzhsVHhrENHESIR9Yah+s985qICUnT72vnuYGjl6+FAgislskRKKaluPlNBIf1rC5XyJH0F33c0C50gNcTAuaD8NODX3CZdMlrONRAlBFq35ikQ7eNCpwacBw0us0v4w2Zzo2HOyZdEzsDOcL5JrVramYhXYQcFSKdWcs5hLqV+tYdMP2wsCftQYgJqzytbG1E89dnUCPOBrQ7Sm9YpggtBRlkzeQJ+Ag9fHoRbTvklUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27H/hhV11cnp5Iq4JapJDabUZshzOZ7a38bG+QKTW0s=;
 b=INDDCDr7a5oFmTrsMQmZdJVDsU1QgH/iG1ttXRUn3as2JmlFACVmXgIyttdC8uLXBo8m5W0kxcJhpCK3QS1rhb/VX7LzJdQk+IBgoTpaxHY1j0H56juL36TJMfWkaX0BsYnM+O1/p1eUMAjKSPbvTtjq/ZBeRjodoWK0PTg18ZBA5AzwR3ROIFQKRTXsYobKqmymvyfUITGzy1tSIYMbHwAPQecm+1ZlOOsavJGTRdANo4UTJQMh7CX6lLrCAY46N5L0FnbDKmYfR/myrvt5y7wqqhv5kESPy3hPnhzQMt1lD5237tEI//RUuPzYKyrhrtPGZqFmMqLR0j+UqXzgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27H/hhV11cnp5Iq4JapJDabUZshzOZ7a38bG+QKTW0s=;
 b=LUm1yO+i7rnwOM+z507vr30e8iau2+Qhm4BErF85oj8pJTRyyt7EvPTWOpnNyYUUcsRY6ZAPzzLYgRMQdepeNSJ9OMvhXZG2yGzFV7UNNP8D/AkPuPrBTYXVCQo3cUptEn3jHcSun9kIbDAcrnBLul8/Bkp66/XhUl6shwc9h0rOzoaJynRDxrT4qEQh297a+0O2/i05/9LYd/DteEmTRBIlZBtFD2d5F5WnrZ48VZghanyqkuzud1SauuJg/pnB1XU02DRAi5RJWGQXFN6HPnKwa909QXacgy9kvz2UIu6gGPmq42HfLnmYN2JXcOFICtgApgP9v4dboGaD0iB0TQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 12:25:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 12:25:25 +0000
Date:   Wed, 19 May 2021 09:25:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Message-ID: <20210519122524.GH1002214@nvidia.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <b6045737954e4279939669a1f229c835@intel.com>
 <20210517231045.GV1002214@nvidia.com>
 <641e6b83b8694f859281e74ee887c6b3@intel.com>
 <20210518002028.GX1002214@nvidia.com>
 <91089ed56df74ef2b1f0199ce7aaec5f@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91089ed56df74ef2b1f0199ce7aaec5f@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:208:234::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:208:234::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 12:25:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljLGO-00Ah3o-BZ; Wed, 19 May 2021 09:25:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4018981f-d68c-48a2-e08b-08d91ac12e00
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13380722AE5196C847877E76C22B9@DM5PR12MB1338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVINEUNpa3/qj1ZN+Ib83Rr6xkuyOb73t1OaQ21LR91wobBWz7CBF2yPTKasYmQrV7QNhC6ebZltckOZv4kGTwy54I4e+xwSvwU323/1noYh6p7SgLza63nj2a2dMAG9a5lD73XhlpYnuD/zumD61q3Hae4UCqjxrsABXy+wg30olnJetEQlkXXbajZqRtqjTdyYi9aERGCKIrn7/x19XtRFLc9L26NAOa59DG8AHstvNN19Eqql201ytBFkC99ByGh+UxJQdwfbh48GIN804Uk2VLEHnNZeqPOhIhQ2Kh3jE26KM6GuIzz9Op5mAwmky2ZTOHXn1ZLQgEIzVBX/MRxOF0pqRJjxpffSGqn0zeDxjeFg4EWYE0CywlVbh0jOZosyTBSViwlh77By/ng/dR1X+XQ00CBS2abIsxlOH97QQnyi82aYVlEol1+cxN5TM6DNlibRPeUk/FqCYIfoxav6jcUklNlU6oKDvB1d0IPINv/EFlcoZDWCIRDmh2GWX5Fj8rJITRbneK4GTTjEnY/Fz2S9T1dogBRKfFv/nikX4i9dS+q85L8hqqDXsoHWJ4QoGCvNc9SCjocwfr4FpZo4osVzqWzgwBr8NxsacIDx+mNhBvAJ37xIxouAoVqAXPgOkatX9KmRcSvSh1JHxyVUR4QnGs0qBZG5isRnLOY2j+AS8cyy1aX4hYFk/+x4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(36756003)(83380400001)(7416002)(2906002)(33656002)(426003)(5660300002)(6916009)(38100700002)(8936002)(86362001)(186003)(9786002)(9746002)(26005)(8676002)(2616005)(66946007)(66556008)(66476007)(54906003)(966005)(4326008)(478600001)(1076003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D8hzojEhuR4VsNgIvtzqZid6qSeZsnN4f7G70e/XJUvtLl3Fj99817zRslGc?=
 =?us-ascii?Q?p/UeLeV8LifedYiaNFUmox9jkIFJW7kjUvTM386yuDmPBP/90ISrPYQm2pD4?=
 =?us-ascii?Q?E29rOtPXl+WLnngIA2QGJgpQgRNdgDyT/LKkSZECom+csz1YFPH08HuDiKyG?=
 =?us-ascii?Q?ZrBjAQGOrwv/gQxfx6PVZAbYWZ2Lkzou6pOP2agOpGzqynj0rQ0aY7caAiFC?=
 =?us-ascii?Q?Vcdm1m1YEUq66cbWGiTU0Adx4mmhGfjd5Hhz/FBE+Wm/r6e6LZha3rvXs4h3?=
 =?us-ascii?Q?5Gd2+eufet4rthDUoWk9TDNIKeN3mH1wnYrM8jLEtJDS+rjvT2yenLeky5tt?=
 =?us-ascii?Q?RxHuY84wl2aCg7+tZZtjICjCIyCly8R9OMbeM3zYnLZXf5Bml+16fb0LO5Xq?=
 =?us-ascii?Q?j881G+LSqBmTf7AEmQhZBPzJRTkPQtvxLWrv6mXpziUTB8DBKLEhDi6TUYvo?=
 =?us-ascii?Q?/zLCh1CXLAzVagulAp0t5/xZim9ezTeKQ/MQw0fcZQi09xhGROx5rfQ/dxIv?=
 =?us-ascii?Q?KkD6Ahv7jVePLHv+Cs3rFfiG7C7zS+3SdTc6saZ9FdN8/c+Az//JYR1iIO0T?=
 =?us-ascii?Q?Ab6HqEnxWZpZxGY+bixTYvkI1p7kQUPpXlaoEmeXgzfMfE+rp9TjuO+iy+0b?=
 =?us-ascii?Q?qlR2zXKQphj6bPUB2nmwkg9j/M+kuMfiPxLuVpVDlg0iuvB9th/pgYknnX07?=
 =?us-ascii?Q?9q0of9uiblMGflexlTvyfWARHzwMZTe7/NQBd2PODBj7+WROA4UalHMbfiAe?=
 =?us-ascii?Q?ihehOABVUgX8jSsS1Ru+TKvVTXkxTPVxiodwAFxGU5xdfcb8ghLjU5FEv1f+?=
 =?us-ascii?Q?JdjdAUUhh3voMpHy6svsAZ5eJcw0httZc7vIcUnlPDwiFzRsjm7zRnMojgfT?=
 =?us-ascii?Q?z0lEZ3kUnqPYuByTHqFEdsYna37Ehb9MtHDdmPrMcmMPhtX1eXSZJlusQqZI?=
 =?us-ascii?Q?a+og7d4J4ihxijufXmaAMf4qe9yhxYvjfquDzMU2kmlhkC6uxS31QbLbUEDS?=
 =?us-ascii?Q?F9Ak/YoMjQ5D0ImXriaPbLe4TyQP53xmgG54vbOYlbjVeeQRuwMYdodT1RMj?=
 =?us-ascii?Q?yMrnoqYK1CeXr7HUJXiKiTHIeavvODlWFZbELsVILExnVGDXXBBH5NDfJUK8?=
 =?us-ascii?Q?O+QwSqeDdNVwsxW1TJ3VKXb4GWRFBy9mxlc/W0DAwBUV9mXVUQyp+je5wFNE?=
 =?us-ascii?Q?9rSJWQ8+HNrJc6ysyljBEqNhBrHk4gUG1wGBxMWhFw7Op3q+N2sX1yXgKeI6?=
 =?us-ascii?Q?ZrQYBmG7f5LiWzkIsd7QmS2bFw1R8XQTwJDhdAbS3jCklEmWn/DV9SVc49Az?=
 =?us-ascii?Q?rwpa+qw8m/YSI/MUpLjNJ4hp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4018981f-d68c-48a2-e08b-08d91ac12e00
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 12:25:25.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rA/zcSjcVxnH2j88SWXq4seG4fWVa6JUVtgw9Zu6lOx2UDxe5LXisq/xWFBwqBo/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 18, 2021 at 09:58:28PM +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
> > device variants
> > 
> > On Tue, May 18, 2021 at 12:18:13AM +0000, Saleem, Shiraz wrote:
> > 
> > > > What does the sysfs look like? Aren't there duplicated HW stats?
> > >
> > >
> > > Yeah it is duplicated. So we are saying for phys_port_cnt = 1, we want
> > > the stats to show up in only place?
> > 
> > Yes.
> > 
> > Imagine you had a multi port device, and assign the stats appropriately.
> > 
> > I didn't see anything in the list that made me think "device stat" but I don't know
> > what several of these do
> 
> Are we exporting port stat when it should be really be device stat in some of the drivers though?
>
> Most vendor drivers do port stats allocation only. Like...
> https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/infiniband/hw/cxgb4/provider.c#L392
> https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/infiniband/sw/rxe/rxe_hw_counters.c#L27

Yes they don't have global device counters, presumably because they
only have 1 port.

> However .get_hw_stats callback appears to extract from same set of registers for each port

Most devices should only have port counters

> > If you can confirm that these are all port stats I can delete the device stats in this
> > series.
> 
> So your device and port stats op callback separation feels warranted.

So should I delete the device counters here?

Jason
