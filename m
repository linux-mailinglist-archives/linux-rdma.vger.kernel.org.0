Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B348C6379D7
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 14:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKXNWW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 08:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKXNWV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 08:22:21 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05C073B88
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 05:22:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kpr8ALFGf26oJTF5rIILeyTGEFGB4GyrlPqV9E63u6byk/efNrrf7+6qP8+D9+gkHi1E/7T2pd/fZ3cVQmgsWlQZMYcJwyP+xSjCwlXDJgGQ+QYSUe6S6xkbxw52QZ3Fl86DZItaNNNXPIrPTnCnlwvpRrmK5y2uFI7tCJfvPjIUnjveCTKeibxQ3qewbyYjoCBv3Go5CTyNt12Z/NuhAofnsSv/lg1LP5ylc3IEy9zpBKCPbHr0U7Zo/ek49eFojWMfGG+m75016KkNffNx2wCi+i9KGC1sGeO5F+yJFFEL8xA+RmZ9FFwIbUinxmazYKXBT7mcGQ5kOVGrQKaskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rwArE16YPlkyV0gFKtZwmFPHG+LXjSZdRuoQo+2gVA=;
 b=dlvl/HT08l1Dh++/nRhDb7xXF+oMmqJGsFDGkDWWP4GsEp3eRxNwcS1/Sv/BvjYtWAbeA+xIXp78oOYOF+k/0chobC1e8bnU5X6ExRydCsXpyKjj9TTOoUJLgEGms4gWPHqo03Nn8njs/qW9Yo/hl98xK0goP3XGUDjKw27akDrzyuRHaAumUsqvs6Jro+rbX5WXKvRsz/YGnOeUhKPiPo3xRd+CHfv7Gs/RSaRLlsge0AdDOW3tyG+uHMGXyakxvar2b1lND2vlWUg3N6mGyaFTC15oyDzKYXDM1o0x27/r9FrbmW9l31uosm+ueA6AbPGrZ3iKt2rzM2Rqxr0tzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rwArE16YPlkyV0gFKtZwmFPHG+LXjSZdRuoQo+2gVA=;
 b=aE6Jx1rXxClQRKwiHe183gdC01RBPhj+2KrKyRhiJU+mavZqHT8qkx2G4SmQIckE77c6St8mmuggI2QfCTHTHhCSOVKsyfcZFISoARbm/cK2Ck70ERwGKRxkJdkTjdZkiKwtDMLsPQ5yhPI2ly/SUcPiekK/iIU5vG3AybJEN3+EgOuH9Y3HKEAFRmEUUrdIpIB54ih1a7tX50p5vAzez51KQUWi+SyfAD1g7UCxvK1J8avF+TmuU9bemqRjfuOWOSzIxqyYzdmS4n+Mp6owcdUhlOTk6crY6kN/LYArhEBNUuhrALXqhXCZGpycjPOXl4PvjpYJr6a0jCZZg1fgyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 13:22:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 13:22:19 +0000
Date:   Thu, 24 Nov 2022 09:22:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [for-next PATCH] infiniband:cma: add a parameter for the packet
 lifetime
Message-ID: <Y39wCnlnAkZFDbDa@nvidia.com>
References: <20221122090206.865-1-lengchao@huawei.com>
 <Y3zX4RnA5yrZHaqV@nvidia.com>
 <b33b0ba8-264b-340f-071d-7494c958b081@huawei.com>
 <Y355I/a/62kl0e07@nvidia.com>
 <c581c96c-b9a4-d5e8-a8ba-d8fce93fe32d@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c581c96c-b9a4-d5e8-a8ba-d8fce93fe32d@huawei.com>
X-ClientProxiedBy: BL1PR13CA0420.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: f39e7f9c-1c3b-4027-f6d6-08dace1ee99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Byz6xIvi2SryohHh+NUyKug6B1KMPDV76gqLG9yzl3KxkyUc93NV09xoDewSqCWfRfmKx6hwb2XaTiEVERgeiIWUK24UXWRp3rTKnw7VkHgJCwCZIqEeS4xWxuMNkjz3Bqll6xF0KxpvRrI6Kp9iNLAnCcpXL6MdizhJfXIXYBQimelvUBWq7ApWeDnwvThO0e0l7wUctJa3OzflI65qtH2IbpXvjG92ylYBofa6mQWmGW/s0AjwoJkJ9Q8rjdBefUEvW4DJ83JQEfPXI3TPtGluoAJh+06HKAmaS5mG87abR7qHjy7aKPZIiBGPaZ+IjT9rzq8b8/7K8SKtztCiCidFuibFNnfvSgjolQmni21rUg41Hv5i18nMZdOVVNxnR3mM3IEjV57y4gUv9uFP6lOWtq3VvIr1yLOdobjdRN6BU9T3JWpCFPmQavHibZflAXaVmkeZq/xl1VsZ9sAur3LIaHvReU2qg/GujRrYpPIhej11D+dcFrqrZLN1QrF5nVUDilBCC7eVGEL/dHW6vIgD7u7MxmLpwdJE9OKkFg2seU472TxJFvYAz8W3mdcgvsQ1K0XE6/37hK1595WblVRNXYpuBrOD3XlNy8Q8Twgj4iIgHHbvVs1rRmQ5hJ76B6XqT0D6FRbpxk8iaMf0Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(316002)(6486002)(36756003)(6916009)(83380400001)(478600001)(6506007)(6512007)(26005)(86362001)(38100700002)(186003)(2616005)(53546011)(5660300002)(66899015)(41300700001)(8936002)(2906002)(66946007)(8676002)(66556008)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+BklZ3l5bLAHIDlmZAnsf5zjMMmIob0EHFBRhI+FTSXf1AEUf5u3FBq/taQd?=
 =?us-ascii?Q?BEHXwjVTcujhfIOOH5SbAxd8fP3UF7f0JaNpih4laVZmI3NoM69soqI4028Z?=
 =?us-ascii?Q?kvB8dPihEQ/Wuc+3GsK2k7clRhiQ+4a5YZw5CVn6lfTXPMu/eLBS4007TC9T?=
 =?us-ascii?Q?65upz12FcRLQcsgyV57jmZXzBOQ5INvRmLiuKvk9Dwo+e5gRt98iYmymlmuj?=
 =?us-ascii?Q?7m1JqNzydAqypamDKNMJfiG7z+AVt9IFtvINvpXfT/9B2IhkahvXjbA4hb6r?=
 =?us-ascii?Q?feJ04v86XphR1/h4hRA0DPnAAenwGcRtz/T1cvhJacp8PewWjwSzDpnrpCIB?=
 =?us-ascii?Q?f7KsI0Lr9+MlpsdfkrBV/rPjgdGhM5FCR0Zt6608rbjW7wC1ObagKAZAoaok?=
 =?us-ascii?Q?6xvW7sZ78gkAS/V7COytGBkhqYZV8zo3u3am8Qv4TeWi8VbmO+CL6IXnxEGT?=
 =?us-ascii?Q?/2u0v+IuenjTDhgVxWjDKRWPFeAB7w2TsulSIHRy6dI8uXcbSSunoISmOdpU?=
 =?us-ascii?Q?sRyJMFGuQGCCyW2vKanfIljRhDHKUUNhMjn6MBXlrThDtKHqu4Bm1hs8qdvj?=
 =?us-ascii?Q?hmbQe2hcMBduUH3OCJtZ/oAqsUTI/AKJCDl9Qw9yYDauBwnsA7dD6FR6xBo7?=
 =?us-ascii?Q?B4pBn0Y5T9jVD41jXRKWp1lIUTdK5IES0aDb/soC1B8vMWaRiEfX0t3DIvqh?=
 =?us-ascii?Q?O4FyUzTxPY1I/98LlvET3exgqRhQ8agbysMkuhKf2Em9G+VdkUre+gmQKjGZ?=
 =?us-ascii?Q?DzvqgoRl5Iw0L5Kb4/A0YDkeIGYPv2ZIdAmzWySnIWICcmicAIMRIehirfGu?=
 =?us-ascii?Q?qOgMVmZjxOtWfwxbgI6LOu8T0H/pB3nSvR5bXvn9QMPKdwfwUahwxmQWwYCJ?=
 =?us-ascii?Q?A778a5wsdLWJnkgGUu13yLRu9nRjky9Mql02h7UHcIO+XjXVy9T5F0Q4GWfm?=
 =?us-ascii?Q?cAZDHVZZ8pTmvrSWPES8P7ffnpqbvEWacfH1S6S+Lm1EsNtM+0+RGGsYt1sd?=
 =?us-ascii?Q?tjH2DIVClbjjg5IdtwRMZA98V+KX6+zaSjwfXuCyw5WcAgdTljBhc4mbp54H?=
 =?us-ascii?Q?/fyqxsbmljvkykul4nXIdTTZYCuFmk1OJyCXAuQRAoePtsB1QCQL1x/rz7BF?=
 =?us-ascii?Q?csw6vI8j6yGah7bvZeGrzvDUka8epi3OOyF73tkEUKVbZuCC6kL9oKwXXGcD?=
 =?us-ascii?Q?FCmEhZ9/gZDzdQgGcBX/0j/06L5HmRns1lT+2CRib2WHEw/Tp5703Qcgors/?=
 =?us-ascii?Q?Jt6X0v+jnnA69Rj+t6H4H4gxZgnBk3sDsycKEni+uj7m6znZ9+Pv3v8N1iNa?=
 =?us-ascii?Q?UTGJXKvkOCQhHiDX7zmWqWh1RQh0YbSzb6Nn+oSQL1pmtD76NpER3pYB1Ri2?=
 =?us-ascii?Q?bjEuIyQnEhHIRXpgpOqynsSleEjHQZucKIH1r8r9lDAnboYM/SzfAyVupnd7?=
 =?us-ascii?Q?FxbCubDcmj0N7NrLgr+SqpN/kP0diege8WsvXP4xnVmQ2ujzGQ4Avw8InrhY?=
 =?us-ascii?Q?7dBkc3//G3GPnoUPIMPKTTdGfxhhqF2s3iI5VPA3UQIQ3coPKwVizKs4cTyq?=
 =?us-ascii?Q?vwPnrT29hFObCm8LnFE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39e7f9c-1c3b-4027-f6d6-08dace1ee99d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 13:22:19.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bq2wvLbLZ0WT8TKRkMFII3xv/2EdKcrNbQYZq3Ihf5SXv3Yfc1CIKyeEXeiTJPpW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 24, 2022 at 04:19:35PM +0800, Chao Leng wrote:
> 
> 
> On 2022/11/24 3:48, Jason Gunthorpe wrote:
> > On Wed, Nov 23, 2022 at 10:13:48AM +0800, Chao Leng wrote:
> > > 
> > > 
> > > On 2022/11/22 22:08, Jason Gunthorpe wrote:
> > > > On Tue, Nov 22, 2022 at 05:02:06PM +0800, Chao Leng wrote:
> > > > > Now the default packet lifetime(CMA_IBOE_PACKET_LIFETIME) is 18.
> > > > > That means the minimum ack timeout is 2 seconds(2^(18+1)*4us=2.097seconds).
> > > > > The packet lifetime means the maximum transmission time of packets
> > > > > on the network, the maximum transmission time of packets is closely
> > > > > related to the network. 2 seconds is too long for simple lossless networks.
> > > > > The packet lifetime should allow the user to adjust according to the
> > > > > network situation.
> > > > > So add a parameter for the packet lifetime.
> > > > > 
> > > > > Signed-off-by: Chao Leng <lengchao@huawei.com>
> > > > > ---
> > > > >    drivers/infiniband/core/cma.c | 6 +++++-
> > > > >    1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > > > index cc2222b85c88..8e2ff5d610e3 100644
> > > > > --- a/drivers/infiniband/core/cma.c
> > > > > +++ b/drivers/infiniband/core/cma.c
> > > > > @@ -50,6 +50,10 @@ MODULE_LICENSE("Dual BSD/GPL");
> > > > >    #define CMA_IBOE_PACKET_LIFETIME 18
> > > > >    #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
> > > > > +static unsigned char cma_packet_lifetime = CMA_IBOE_PACKET_LIFETIME;
> > > > > +module_param_named(packet_lifetime, cma_packet_lifetime, byte, 0644);
> > > > > +MODULE_PARM_DESC(packet_lifetime, "max transmission time of the packet");
> > > > 
> > > > No new module parameters
> > > > 
> > > > Maybe something in netlink would be appropriate, I'm not sure how
> > > > best to deal with this.
> > > > 
> > > > Really, the entire retransmit strategy in CM is not suitable for
> > > > ethernet networks, this is just one symptom.
> > > What do you think to change the CMA_IBOE_PACKET_LIFETIME to 16.
> > > The maximum transmission time of packets will be about 500+ms,
> > > I think this is long enough for RoCE networks.
> > > 2 seconds is too long to my honest.
> > 
> > I don't have an informed opinion on this. I agree that 2s is too long though
> > 
> > Do we have any information to back up what this should be?
> Assume the network is a clos topology with three layers, every packet
> will pass through five hops of switches. Assume the buffer of every
> switch is 128MB and the port transmission rate is 25 Gbit/s,
> the maximum transmission time of the packet is 200ms(128MB*5/25Gbit/s).
> Add double redundancy, it is less than 500ms.

We also have to worry about HCA processing time which is driven by CPU
loading more than anything

> So change the CMA_IBOE_PACKET_LIFETIME to 16,
> the maximum transmission time of the packet will be about 500+ms,
> it is long enough.

That makes sense to me, put it in a commit message and send a patch

Jason
