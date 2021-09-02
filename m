Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839C33FF219
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbhIBRKT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 13:10:19 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:57536
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346540AbhIBRKT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 13:10:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTTbD2XD386X6h13vBptvfT5HRyXoVsHuE+gcnDxElADLu+8npN60rK8/Rp0+l8CB7fzBmhgu8qkXDjowhwNFiS7OROvZDrsyq+W57OUEo+O/GUx8zp+MVG90gI3BbeDNr1OwUFHUnCxotB+Ms2N7eltP+MU1AmedwPfbGhKuu6Rmq/Jxdkca3a4pKva7YswG2aerahLq7VTdh4FrXrzWTvC3c0Hv2Ixubxn+VScVts+7fAq9jBolq8wPugKsR86xVWXqcdkmNBQ7JtvSX6fw0TCe8Ufb6p00MZj30Ss0yj/e7QnNuAgyT7vmPYySRUdin7+jr+Nzi1tM2if8QaLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rNOK2AbJMhNBuqqpr2FTc5NN+KeG/4ZrxUaMxnJ3Ubo=;
 b=dheBWECkklwDROA1sWV9oKk8r0m+7OIORG2xcasPfo/X5zT0xkaMLCKj+2P7mdvyo0rRZbH2OkGwmDkE5Sb6hBZZAAfhlEDuWqZuxFWi3+rh3Fb2nCJddJJIxsgmpsNejDq7qf73zCr6yhrz2p78vSUBCz/5tnySajReDsT/+6KF/i+kpO2vBHnUwAxJKwR7PwkLEhl4lexcHWY3E496Lp/PM55xGgYDOwyV1vZIAiL3t1oIH6zENoCr6U8lyAXyZ6gBU0N7Zyd0prLWBNHECYnsM4rVJ8eiDVLEKBYaHuLeQuRAR1jXFVmmjmnTJP1oPx5e1zbOpJ1E3BLrn1rUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNOK2AbJMhNBuqqpr2FTc5NN+KeG/4ZrxUaMxnJ3Ubo=;
 b=Cers8zSgxZmI+ql+ci2/z7F839uNx1djqkJ95JVrzEN3VCDH5hCkdkpxsm37t1ktM3p+qXq+vEIixARqwT1lHxgToqPf0UFn8rLccrAaetc9Nf8Jr4Szkh66lb3nrd9iNAld5Yuh0E+KaA2mnTRdTTZIrPkOhTfv85IFG7jVMO/tNk29sfIkli3d9Dq6LCCItBIur7bT0EwWpxH93ApLwHbMzrYSq9YQrwzGhfjWle7oFfPK3Zvy/AtCqUwB3i33j59CZSGT/i3JkUUZj4HYVabA2NUGk3IGqaUZh7NH3vc6BPUPnEJCpT8boLRyyxhGfDU9LxawMUt4dK47+oDEmw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Thu, 2 Sep
 2021 17:09:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 17:09:19 +0000
Date:   Thu, 2 Sep 2021 14:09:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier for
 doorbell optimization
Message-ID: <20210902170917.GZ1721383@nvidia.com>
References: <20210810115933.GB5158@nvidia.com>
 <20210813222549.739-1-tatyana.e.nikolova@intel.com>
 <20210818164931.GC5673@nvidia.com>
 <DM6PR11MB4692DCA80480234AAD298313CBC09@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210819224408.GE1721383@nvidia.com>
 <DM6PR11MB4692BD4BB222DAA58C264000CBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4692BD4BB222DAA58C264000CBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:208:23b::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:208:23b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Thu, 2 Sep 2021 17:09:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLqDF-00APzf-RM; Thu, 02 Sep 2021 14:09:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c44f86de-34d8-463a-6a7d-08d96e3466bf
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5539000E0BFCB2A12E6CB641C2CE9@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcX33znJODRQrrJMNKoccOIenP/zScReZBRKw+Tnh3EnvS3hQKWG7UtnupGdXNXTR7VDxbvoIwxXYdvpBhRvU7jHB3s/zGu3e3ebuJI1qwuEJ+00nXHksYI0noLj/iZhqVCb4yaaEZUtwoesBCxw8jDMDK9uI9ls8UJcGWVAMW/wNrQbWRGRUlutV0sjf+2xQIqDHzUoQWS6cKOuDiAOu+JqpU+67C+s+ivQiF3dhsIgMwmLPzc+griqjo7OjIT1cWQ/uJyKC/fTfrhkGFvU96Dzj2ljOfT1QmGl/lVn27jEGz99qEDUZkAS0CpZQGZU8f4D1643Y51sOmM1dnwWFNdTUERJTywQd6xXg6p/PxZAWDHu6G7d5xCeatX33OOSr7qfZ/O5GXJ56p8+mGWSAq88vmjDX8DR6j+NRQ7zNa+cbJU1q1OrLzkKNkFbP4kLTvT6XBXGGn9NDEee/8GtP0EXFlZwrLfVUSyvT3e9mGIBGNOJnRAPCEW9SB5mmY/gwGtPDCx0THLAXfAzy2YeE9I7GZeRphlUSqH3yS+0VeEiCLnGT9uhLJIhdQ10WfX3j6DQ/SIM2mmjpgGRyCLJbJyyam0RDKRAqnHHJSn1GaMmOZ+QYajZQKqRTIhBH/Ie6+2EVomFGP+fUCWK4uibEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(66556008)(66476007)(26005)(9746002)(53546011)(9786002)(36756003)(2906002)(66946007)(5660300002)(316002)(508600001)(8676002)(1076003)(83380400001)(38100700002)(86362001)(186003)(6916009)(33656002)(2616005)(426003)(8936002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rZrWOijYksISO+VSYMAPJsu5hIzrNB4/OhJqXie79cDt61qNffRu26Q/JAq7?=
 =?us-ascii?Q?z6pTc5ETOYacZ7dRHT8htxtzfeRArolxAHqUzqXwU0Y63bsWyL7xiKgjXybX?=
 =?us-ascii?Q?SomNEDF3mneJJT3HcjrrpKWlQKeK9m2blVReN8Uxr3DiKIcfBi+2LyqjFinf?=
 =?us-ascii?Q?44JxfeyahwGxCQpKc0B9pe6Q5KaDLXUWpSN+HESObiKDFS2KwjPkUfFav4T6?=
 =?us-ascii?Q?T5h4DjpnebVCEaLMxcrR5FwZp4GNExW3zgnsNeKmon9EGdkEz5tHclSPvtiS?=
 =?us-ascii?Q?Ux/YfnQtLi6oG6s1mXiKu4+kX02L8bX+p6i5lFVkyB+sczyClV4PAWlQEha5?=
 =?us-ascii?Q?UAIDPCuS8fa3xqYAOpy3wp4vnRHyfsGkEKTA4df3AxMYknCA62zptyIwDlWj?=
 =?us-ascii?Q?pQwrtNCHD+70Ylirn/sutDEs96QTUlZBFb+ej+Rfwr2dYoNrGtzEGAQ/+cvc?=
 =?us-ascii?Q?jGoMgJ2tFyBBmSGGyR0MzLDcBytBV7KqHH4SylHwENynB3bySyjGABITu2hn?=
 =?us-ascii?Q?P7EFs9dkmSdEFhOQ6P9A8yywKqcnnYhvSybbbdFGpkfMzFBDRduyk5wVd93h?=
 =?us-ascii?Q?kP5XKE176sCS5+NFJEGVcyq5f+NxSBetQmf1XHUIdyWkM+/q2hzQ2FNpYaVL?=
 =?us-ascii?Q?3cA9lAN4ZWsvPHf9ttQ2X6PY2RwItCg6yvpHbvRwMJBEfJ6fqYzSPRgHXSZF?=
 =?us-ascii?Q?4xLab/InPZyVsoDPu52hSnFUUtdY8ABuix/i6oqWBx4tO45T858cF65jFyZ/?=
 =?us-ascii?Q?h7jxgxC34pQNKjJczZNO9MAbviZqph5VPk/xtI2B/+pEO79zOb0bIMKPB4hZ?=
 =?us-ascii?Q?d1gJBNuiJxRxHWE2UnpbyLhtbF6jnTjGQh7GGqke6QCmfPNIGYRa0/luPMxj?=
 =?us-ascii?Q?KjxnQFMtKOdE4mEvlmEJ2S78soveMRAZ+JU58ITQYgkldbLeuD1OK2uZ3abg?=
 =?us-ascii?Q?55fpkLJm2wnFNl1PHMkgCqwrd9m+ICBrh6i5WGJxjrO2Rwq2frQvkX2UYvTN?=
 =?us-ascii?Q?81dlPbigeRHSynvHDt/1duxgXANxWWwjCoG9sPdXAS1lwc0Sc4kh2SaI4VOU?=
 =?us-ascii?Q?b4hoAwumRGpolPTH2dSeUROuvgyArsi27fJ7/TpS5djbQ1QEVPjbYJuKLO6t?=
 =?us-ascii?Q?z8mE9nGQoBZhUcpUmP4IdLlP2jvdMAyM+edUIXOXtqB9VPjhC0e5B39FJjZ+?=
 =?us-ascii?Q?llcoJbYeuY6f3UuRuwuKAS+1gWSSOUg2DXeR8pDPaK28juord7hx2ahg+GSB?=
 =?us-ascii?Q?nZJMAXs2q2lEUueEuKaWExHGTt/1OwiJxSfA/3be/QK+dt8arT/jLx6jpBU5?=
 =?us-ascii?Q?CeAxQXYRpfbSHxfFa22idxEgi64hcuhXRZivZJWqpnEyEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44f86de-34d8-463a-6a7d-08d96e3466bf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 17:09:19.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZc/HnITupFgxtMJbE0nlRD4qaP+Kbnxf9/zi5cU8Jj13dam1xkINuPgDk8v0T8H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 04:27:37PM +0000, Nikolova, Tatyana E wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, August 19, 2021 5:44 PM
> > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> > Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier for
> > doorbell optimization
> > 
> > On Thu, Aug 19, 2021 at 10:01:50PM +0000, Nikolova, Tatyana E wrote:
> > >
> > >
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Wednesday, August 18, 2021 11:50 AM
> > > > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > > > Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> > > > Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier
> > > > for doorbell optimization
> > > >
> > > > On Fri, Aug 13, 2021 at 05:25:49PM -0500, Tatyana Nikolova wrote:
> > > > > >> 1.	Software writing the valid bit in the WQE.
> > > > > >> 2.	Software reading shadow memory (hw_tail) value.
> > > > >
> > > > > > You are missing an ordered atomic on this read it looks like
> > > > >
> > > > > Hi Jason,
> > > > >
> > > > > Why do you think we need atomic ops in this case? We aren't trying
> > > > > to protect from multiple threads but CPU re-ordering of a write
> > > > > and a read.
> > > >
> > > > Which is what the atomics will do.
> > > >
> > > > Barriers are only appropriate when you can't add atomic markers to
> > > > the actual data that needs ordering.
> > >
> > > Hi Jason,
> > >
> > > We aren't sure what you mean by atomic markers. We ran a few
> > > experiments with atomics, but none of the barriers we tried
> > > smp_mb__{before,after}_atomic(), smp_load_acquire() and
> > > smp_store_release() translates to a full memory barrier on X86.
> > 
> > Huh? Those are kernel primitives, this is a userspace patch.
> > 
> > Userspace follows the C11 atomics memory model.
> > 
> > So I'd expect
> > 
> >   atomic_store_explicit(tail, memory_order_release)
> >   atomic_load_explicit(tail, memory_order_acquire)
> > 
> > To be the atomics you need. This will ensure that the read/writes to valid
> > before the atomics are sequenced correctly, eg no CPU thread can observe
> > an updated tail without also observing the set valid.
> > 
> 
> Hi Jason,
> 
> We tried these atomic ops as shown bellow, but they don't fix the issue.
> 
> atomic_store_explicit(hdr, memory_order_release) atomic_load_explicit(tail, memory_order_acquire)
> 
> In assembly they look like this:
> 
> //set_64bit_val(wqe, 24, hdr);
> atomic_store_explicit((_Atomic(uint64_t) *)(wqe + (24 >> 3)), hdr, memory_order_release);
>                      2130:       49 89 5f 18             mov    %rbx,0x18(%r15)
> /root/CVL-3.0-V26.4C00390/rdma-core-27.0/build/../providers/irdma/uk.c:747
> 
> 
> /root/CVL-3.0-V26.4C00390/rdma-core-27.0/build/../providers/irdma/uk.c:123
>         temp = atomic_load_explicit((_Atomic(__u64) *)qp->shadow_area, memory_order_acquire);
>     1c32:       15 00 00 28 84          adc    $0x84280000,%eax
> 
> 
> However, the following works:
>  atomic_store_explicit(hdr, memory_order_seq_cst)
> 
> //set_64bit_val(wqe, 24, hdr);
>  atomic_store_explicit((_Atomic(uint64_t) *)(wqe + (24 >> 3)), hdr,  memory_order_seq_cst);
>     2130:       49 89 5f 18             mov    %rbx,0x18(%r15)
>     2134:       0f ae f0                mfence
> /root/CVL-3.0-V26.4C00390/rdma-core-27.0/build/../providers/irdma/uk.c:748
>  
> 
> atomic_load_explicit(tail, memory_order_seq_cst) - same assembly as with memory_order_acquire

Again, you shouldn't need the mfence unless you are doing something
very special, and so far nothing you've explained reaches to what that
special thing is.

According to the x86 memory model when you do a store release then all
writes made by the current CPU will be observed by the CPU that does
the load acquire. Which matches what you asked for.

The main purpose of the atomic notations on x86 is to force the
compiler to put all load/stores in the correct order when going to
assembly. The x86 architecture takes care of the rest without MFENCE,
and from your prior description it seems the issue was compiler
re-ordering of load/stores around a serializing load/sore.

MFENCE is about preventing future stores from becoming visible until
prior stores are, which you shouldn't need with the simple
acquire/release semantics that you described..

Jason
