Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC853967A8
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 20:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEaSPg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 14:15:36 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:46145
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230288AbhEaSPf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 May 2021 14:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO4Sbb53EiJQ+FOYAsCz03wx0Bkr0p4+xqORfcVWKZ2I3bg6XJxyX6DMwQ/JYxqX8IOjZExgdaJrWCOJxmVHYBkEGGnLre7QdO2zJuIm1ifeB64oHxsuffHtCJ2eyub4sZa481vn/7Tf/aruSQidm+IsBHW9aBM4h4JHob/vTs47uvRaJWduT/rVaL6qOxV7ssE46ZueBxScdKLXl999ZnZ7g1OwWCHU9eCDHP3ryX2YwoEpY44FHvq3bmbaJD0EJAhD+eYE1OQeVawVPPEWMmnwiCGBTGX8M6vdNzwPc72G1Vpzen7Xfnv5xHcICVhJIZkReSX0GB9qsXMHLkaVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiiW9LyeA8IjjVaRkKbvVS/Nk7qMiwEFDw9orSRMxQ8=;
 b=EE1EUvb+78U599UjaG8a4Do/1k2gtiAUsY2pkMnV8F3zlQPkZy6Fm2TKJe6Zr7RFa42AS3TIw045w9kUKXctJUy2blGPT/+vGcmyCfPVIbbBGq5bc9Me2EG04EMyHFF5XYXvmUmcs0/XQ7rvfS00ZG7JAIPaFrnsOAyK1mP2nwj73baIBIW1QRLZdIgDxTPE++WYLtnX1leCUrBooDcbYv2RgE097QcbA534QJDllVc0W4REwrPZ5xYuXfySJrjY5ieZKEP/NmD+Nd+hoeXC2wiRVIrDzG02vAXE0P6vW8dv0wXu+YWmr/+RHdFswWKMbeVNRUCrLe5HQL2L1p0vhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiiW9LyeA8IjjVaRkKbvVS/Nk7qMiwEFDw9orSRMxQ8=;
 b=mx47gQvZZhgmDmiXImGyxbkcpR5TJ/fxjD6h8LVrHtfHZB/WeccqY9oe9oVeRcJbGtomiwgr36SA83UCVhY7Pi2XPBqwo2Y1ZZXZ+4NBIev66vlS9Thszd+B9EUfqDlnkuLZHQBUTrckv1bAHHU6yY1b9jDUkl5A7ISlR2FoM6LWP3gRp+sOrMo4t9MQ81KUlQjpZFwDsqEAs9yPccrxTe41IG9IilYATM8hqm3/YiJ+FcrCTFMQOeRADRtOorb5eIh1isjM6fXPb7LU5zL3ntxC3pxUDp7TigM1Hp00am/GPWHi/X2tpfurFmWTSB9ERTPKMf6z2XT+EjiTCIwQ8Q==
Authentication-Results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 18:13:53 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 18:13:53 +0000
Date:   Mon, 31 May 2021 15:13:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next v1 0/2] Enable relaxed ordering for ULPs
Message-ID: <20210531181352.GZ1002214@nvidia.com>
References: <cover.1621505111.git.leonro@nvidia.com>
 <20210526193021.GA3644646@nvidia.com>
 <5ae77009a18a4ea2b309f3ca4e4095f9@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae77009a18a4ea2b309f3ca4e4095f9@AcuMS.aculab.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR1501CA0013.namprd15.prod.outlook.com
 (2603:10b6:207:17::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR1501CA0013.namprd15.prod.outlook.com (2603:10b6:207:17::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 18:13:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lnmQC-00HD74-Nj; Mon, 31 May 2021 15:13:52 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58a9dcb7-7f9e-4401-7c9b-08d9245fd956
X-MS-TrafficTypeDiagnostic: BL1PR12MB5190:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5190A63E8FA823EB24477226C23F9@BL1PR12MB5190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Uzg0oR1vW/VffJi2/nYCRimcNgKPmvkA1xQdHaVfhToN6GKqBwZtQCBZigRDjEPSwPdvNYSGyPI3KFaQXx2IX2I4EUZHvGQOVYYcEax6KhDhK2rZgAmVdyN/ZSNeI0slR72luzYNaikHAtpi0y1VnRhIrJjuqNisz446y/rj5elY/22vU/1lO+z8tlzuC5DCuBqOeVoUsACBijy6MxMPxZYnmyT8cwM9xr5aFiDd3Z9MLxbQZlLmkzSz/9toLTjBATagz+Gsge8RW2sEbKW0mcyYm7gvKlh9YxCTsj3WkZlN/RA0KN9r0xoPUeDaWHMKPT5IzzXdF+URIjtbKIDI5lITH4GdAnPV90POHP8KqRRUGXVHrD8g6heJWc162L48nOZcinHm5Iha3sQVB6g0T7XKknL3s2gtGCeFQk7hSaZZNhLD1ClmrnXZ1p4vor0GO5eCaWDPJauIbfXPG+lTk4N5kvFuE530+totKo/sZYCrKElplK34t7R2VLq0VjVK1dXT9J0seE75oKeYhNWzZjHs2ztmWpXSGUf7SNfSzkNTU6j6LWgRMNbwPAIOUkKl/f/eqmG4bbVPf76miLjUsmHfgU8rJsRhSqAXqQZdAekdo/yz4HF9mXn7EKg0fVwpq+TZx79aKk1JPBmtmahgWumTUfcgPJ7m+bLZIRU/x3gur0NVlFQj/GqI1s1l1iQX0CLSFKp5YSt5SJaxBRy1O66dghadnmQH7egXNN3MDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(54906003)(8936002)(86362001)(498600001)(9786002)(9746002)(5660300002)(33656002)(1076003)(7416002)(66476007)(4744005)(66556008)(38100700002)(186003)(83380400001)(4326008)(426003)(6916009)(107886003)(2906002)(66946007)(36756003)(8676002)(2616005)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YXF9FBDtlcf0gkCApFKNorsbul/c/XEbnmAcc79KWDvP28hyxhjawvVf+OcV?=
 =?us-ascii?Q?pzK39jwCH0KuMD9EvN649wKmALmHmr5RQsFBTu4EpRLE1p8Zd07odn0NZtc9?=
 =?us-ascii?Q?k0T3HuENvNqL07GjF0V8sf7UYD1tVgA1P77ii1iPkNp8zLiY2LR/1iDYGQkb?=
 =?us-ascii?Q?kInkjg4uR9Lx08AJYgs/OxY4z7JS9w7UMN9LGotQEvJswPZUTICiRcxgi2dV?=
 =?us-ascii?Q?YUxDgj61CdD82EKoeTkjBxsdQSBZlIV/vl/+BAO+kML+CcZuEjMGisWTijti?=
 =?us-ascii?Q?9h2HkRfMTbXs9PNE1YMSnLBIDvqZW7QgTQsSwCP7TwZZ9fz0F8ZM62MDQy71?=
 =?us-ascii?Q?K8EAOYVXgfQ5awNB9S7l8/aH53TQnB5sfr2MfgL4etej8wArV3fEb3IFdyF7?=
 =?us-ascii?Q?GRqZMYODk5wa5iCJ9rjoxggzVPMUbmxr0gd7mBfLnOCk0dSM4lKi3DLGz4HG?=
 =?us-ascii?Q?Y0Vw+l++vslZC7BPZgwni+vZMmJi6ciCBfsUB8IeeEsSSy9DDtelKAHF12ZS?=
 =?us-ascii?Q?9VrUPBT77gIgF/OeJx7rs9fCXdiGRIqCWEu0r7UX2W0BK9SZTiLQn9/3gfpK?=
 =?us-ascii?Q?TjlR+W02IaP62+wgEpzSIQBO+j7OU3s+mz7OXls8bhesrc5IB/X2RCUZoYi6?=
 =?us-ascii?Q?e2NlkJhtDj34Gjgr3flOPpm7ws8b2LpqwojrsI0ShlMiNCO4kqSr3pNkcnSk?=
 =?us-ascii?Q?e3khApMO25bT/vEv3dKZNACyxtErWssDAHpWl4BmcuDkv4haFVDiZNy6DxF5?=
 =?us-ascii?Q?YllFILvA7Gxgv2XKzsTiCQoVtw6HAB0frge9MIXCqc96XnfttKKyWjECWLwd?=
 =?us-ascii?Q?oIxGQCLfhpxd2N9hQCxETyafQWK0xfm6Y0azTaen5ixNr5KRZkU+B3l7i4SK?=
 =?us-ascii?Q?RendSrZwSqqeI8yTlHRO5KzZbshB6RgevO1GWLNbrbQdir8BFjI0T95Pxlr9?=
 =?us-ascii?Q?gFvXMVPc4hkzhXvCAEU16PiuOn30i/PS35U2lFtIf0CGvArTZctxN8bKD4/n?=
 =?us-ascii?Q?YGPUcL6jPxQaA2+zuz2cnUH7Mz7R+B9htbU6CTgPOyytR5eiUTGF+1BM4YXB?=
 =?us-ascii?Q?VuPHmSoKZdD7gRUYzyho498lNIUT9et3BzJkw1Kn8TQM+SSn1uQQ8eoxgYpI?=
 =?us-ascii?Q?2LWLFZspLvDjEoLIz62NJpaoRgAzXJCC2PuZJ+KBsgHuz0jC2ELHWamu/ZAU?=
 =?us-ascii?Q?6SxV44JvltnAB1MBnA3x0kJsSkQHnIBsHeOIBjMzkIRkewGzrBEiPoBSnd2L?=
 =?us-ascii?Q?2g2xL3v6r9jwvQkhtYOYoHF0zB2wM4J96FHGpYhylcqNz97T4DR2jUjC5TF9?=
 =?us-ascii?Q?qjzf0wYI/f41rwCVHMlGPOsD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a9dcb7-7f9e-4401-7c9b-08d9245fd956
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 18:13:53.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQDEWw0R/o+1ukJggZwHFn5in2wDDVN2npR+xsL0xXJ9dDfCFSpXiW8IZ2/iZhCt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 27, 2021 at 08:11:14AM +0000, David Laight wrote:
> > There was such a big discussion on the last version I wondered why
> > this was so quiet. I guess because the cc list isn't very big..
> > 
> > Adding the people from the original thread, here is the patches:
> > 
> > https://lore.kernel.org/linux-rdma/cover.1621505111.git.leonro@nvidia.com/
> > 
> > I think this is the general approach that was asked for, to special case
> > uverbs and turn it on in kernel universally
> 
> I'm still not sure which PCIe transactions you are enabling relaxed
> ordering for.  Nothing has ever said that in layman's terms.
>
> IIRC PCIe targets (like ethernet chips) can use relaxed ordered
> writes for frame contents but must use strongly ordered writes
> for the corresponding ring (control structure) updates.

Right, it is exactly like this, just not expressed in ethernet
specific terms.

Data transfer TLPs are relaxed ordered and control structure TLPs are
normal ordered.

Jason
