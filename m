Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D41622CA3
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Nov 2022 14:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKINpK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Nov 2022 08:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKINpI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Nov 2022 08:45:08 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9370D2C2
        for <linux-rdma@vger.kernel.org>; Wed,  9 Nov 2022 05:45:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nogCfF4uP+gaHt1hr2j5QUiNato43MV9jaO3Qb1qah4K4qhh4XcbWH7N3YVD0JFioEmU/5z4SRibIhxPGOIOMIM5dZspxZb6ZRJQJxewh09ksHBJSG3Z+TXD05P6dSm+8loJx1euJYqcEyweZfBOx/5mBkGZOAKf5rr/n+v3Xwiailh6Ky5uIncodokl6UBtTWRFBkvV9Noa8X2gVVT+vaRBxAThUPn97SeIIEXiTwxLnOLSGlbHY+t6OQ09Gm5wfMDET9znUmAylV+AymILoIPEruGMlwSzvtcau7GOsj9ADzqLADN3oK8vRvJStHq9Jw9uAcjJJR0g26A6Y0d1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvcoDsH3E2tLTtM4vOADfiJtsPe7yMtNjenW1jS9xX0=;
 b=nUzCROZduAfccTWIV9B20GfHx5weioc9KLXVId8i1GakPjRP+FxFi9V1O+lMuMU8shdVGZFfZHocA8x3Rn6dcGuF9Gz2I819hlLwSqY42wJvVxJrvv9tGdKO7pAOpjyNnIlHZOwdQ3DW5kE/TS5rt8FKKf5CGVjq6Q3zAfighUvE0oCk+lh6NGVNgQxi/gazvU2mqLZoM0v2L9inajrVK/H6fbkBFWjT+12uSff2vBMkby3lOrzqXE4kRnPzKW7LMyp0+rqBEtCZxXKXMka27fSymi9dsRExjbyMe8ZovaBHsFx0C+CvAjpyXHdp7slWg13aL04f76c7jxk92siQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvcoDsH3E2tLTtM4vOADfiJtsPe7yMtNjenW1jS9xX0=;
 b=FGmNj7vr0NR/lGkBM0OIV+wJYDs901jfi5AHDyymYgBmluZar8v9qVfp+B93RmYtBPimvobf5RSmRPTDygSvNtsxg/zRyyz1XNmFwA5rM3xQPqOBLA4C47XcGHs7JtLWTm9QSUsAn9zISiyM+FmL/bfi6ZfscgRp5jhlsJsSWqlN2O6asETNuLPYlgoc4eN0f1heKyiXCKudANIQuzYs8BSJLVEOK9qWarWERMq9sdvdUcZaoGiU2zrWg4Ac104YNEpctQd0056GmBPoLY/Pj1x3wUs9f1NTlOuS4ad7fHEQqpHv+EBc4YGE3TrvldDpYavQgb02UwWxFx2AjIm93Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 13:45:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:45:05 +0000
Date:   Wed, 9 Nov 2022 09:45:04 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Message-ID: <Y2uu4HfKADHiCzGx@nvidia.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210902154003.GW1721383@nvidia.com>
 <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210920232330.GH327412@nvidia.com>
 <DM6PR11MB4692B56B4C7D1E790B50888DCBB89@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20211014233644.GA2744544@nvidia.com>
 <DM6PR11MB4692B502C54F459A2EF9E79CCB399@DM6PR11MB4692.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4692B502C54F459A2EF9E79CCB399@DM6PR11MB4692.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR01CA0028.prod.exchangelabs.com (2603:10b6:208:71::41)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 813200a2-0a15-44af-b608-08dac2589b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UB9P761bw3lV9v2u9BrKBCnQW8MbYGXA4GdUUP2Ni/itXoCrPmbYXYD1mhKxJqbgcVU8EunGlYq3b69/70W6kY+2xDawU5Y+9Tf2jNFoih9HJuEQs4hrDctZO3YzxPyl3cO5tPN2CHjnzKCbbQxgKp/zzdy6Pm1J9LPKjxubB44jdlLp5kbIdEWZcLuSkwg7nrBOBy5/wIh+S4e9VFllubxL7dLQGVICHSuKJGZSYtJUZ8R0zrBudR87uwKWSTerUbiEKwqtsdte7y0n0FokgO9EiG5no/w/aoH2n62k0+3vB1yuD3n2H2wnj98ZxR04aoedl2GXMA94JnMHge8TyV6rl0ltBHgMU3/NeEZYGfyVF9UmQHzMJgtMqyBQy+4ytMyovCYeBnDxG/z5AHYlgf/loza6UrcltJj9VNaVbp5yspppTPQF1lIQCTZFIDYrUu5uxcrfiNLwiwnZ1T/vG+7HVAShidiT85omPCdgRE3Fx0C57yW/PDIWO2VkdoAZzq1/kNW0QWUy07WFkZrKjhWQjFvgUPzluzgV6Jm+JLb/Zt3LIeJ+5Uw4+LeeqvGsop1CmnPPkbUbUfrqAnZ1PjccFNJp+SKRVdud/LDCFvQXGJU1KuB96vxQM1q2D32H/sZ7vXVdlf2R135JRcmOynpe1yUxGrZFZ4gp4y3iCySHphTQ1pFLfnN7beBwH9Hj9uJYJNizdU19S1tIF63mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(186003)(2616005)(6512007)(38100700002)(6506007)(6916009)(26005)(5660300002)(2906002)(8936002)(66946007)(6486002)(41300700001)(478600001)(66476007)(8676002)(66556008)(316002)(54906003)(4326008)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OIdIZ1W1rGqkocG2ahlYYZAATFvjiNjwAKifIr5LITXC1JpN6jLL7G8ZVpmZ?=
 =?us-ascii?Q?SRsoXnaC+3ui9fxOqv88ps9PdK5f1INQntp0c6jsD1UZuae8jSIOhJJEGk7u?=
 =?us-ascii?Q?bj0lmQZiTSql2UZ6PKBYzHJ87jBPbhSjwbFjgiLh2ksj8VhRkE+o/JPmJNQt?=
 =?us-ascii?Q?PI+N48rEcx9FX1sJXLIvhWgv7ixP6GL8RW/97JBlhYRwFX7OEo0fdQDWtGWJ?=
 =?us-ascii?Q?r8J1mjWTrYmUiC+KFGVWjfdz8uZevhQZxCmpMJ1M8rc0H5tOqbdcP7pijEZn?=
 =?us-ascii?Q?SJXeo+HaPGOX8N5gMh/NdGqonuXji9G576heTWzC0eE4kGXCvBTHaw5ZAdzG?=
 =?us-ascii?Q?Iygn2CYZGgHf8dARLfW0qqA3n9qNCvP6wet6SSDDXaQ7ykRAVwILos//Xk4U?=
 =?us-ascii?Q?N58GrUtz3lRuBz9HeaS3C62FhcT145hZRiKkKyZAxpGcMIEDbC5o31HHur6P?=
 =?us-ascii?Q?jf6BWVK0UB+HkRDEC3LbSHyKkYdKWnliP5AD9oD78ZS63PdG2bsA5k7xy6et?=
 =?us-ascii?Q?O2PNcUQ+8F4dV2CZ8/xN7BYGygWMlf2+ib/K9Aqys54uRSOWH4vaGJxOL/zZ?=
 =?us-ascii?Q?OJ7EOFr6hUQwtLyY9nAjKbsuVsUfh1ENzEKyss3LEwMat0PCbm57Ayw9IPb5?=
 =?us-ascii?Q?vmTv0EHA+GM4yp/NMtZ47H5y8AW6+OwzMJOlgJza+MqBf2exBjJprGJ8bTeT?=
 =?us-ascii?Q?ngW8zr3CywDU+no9rLkzxUnTHczDyy5eNUWaJnxsS9Oruj/sqirobHMcUaik?=
 =?us-ascii?Q?L0Du7pkTsAMuiW6oD4adHGj2Uni/MCNw8CZmqF4vgZdBFRzy0j005oycSsBi?=
 =?us-ascii?Q?ucSPZS6pSMsG8sIkC+m7r9da4a7CE8p1AZueCix7XnwNQ7sJuhVPiEjB/Whg?=
 =?us-ascii?Q?pq9ISXDI92B3QpgpCgpobh/ze+Rq0Z9L2Yun1WANxthIuS9AaanXcog19osn?=
 =?us-ascii?Q?ET3hB8AESUbGtgK5q9AV6+mXCafdhfn/ktC6CM4en6j6JdjlTwLyhpcO7IjM?=
 =?us-ascii?Q?FCbK4xKMN24lccpvKZ2z0a8Fjdsw14P4Mx24S4c04NsKCVU3m8pnkhr+UM6/?=
 =?us-ascii?Q?akPZAxTCX+l1H4jEGAMJNY9pTZgp07Hety+sng6edk2FDP4CqhfoWQzTqvyy?=
 =?us-ascii?Q?t5xIqPrLz+al4PMuHl32s0AVeX6RUfqjE15hkbXMEBnYWDVjJ+ZzYGSI7Opg?=
 =?us-ascii?Q?ORs0jZbS93RL1X+Cr0lWP0G7HGH/aXqraGjaWsRu2YUncI7gmLRDc4p2hx4f?=
 =?us-ascii?Q?5JECcuMBwhXV8fn8g5r00Gfgaox5YNn2s/RvNjjTpEns7jf3BV67pZfAQRjs?=
 =?us-ascii?Q?Xc0ePTb33w4CKy2mASQZ5J+UtzB/a9h/PWYuebOcwgu5xueZuomWoCJ4b0Eq?=
 =?us-ascii?Q?y64NKC5J7xqiTny7UNbMqS6Hizv8vwymjua5qaYAypNCfD7nDl7JdKcOvodn?=
 =?us-ascii?Q?mxMURlv+DT2etma5UT57NhkKpgXPfHoc73MNGq7bvAcu+CEU5xJPx822eNhF?=
 =?us-ascii?Q?FGomfWrIWRga7YuRy+Tx8MssVJisiyL+Ri8sZJM6j92NHJwlhXvwjNMXRkuA?=
 =?us-ascii?Q?lQqP2i++BxcHaicgUxM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813200a2-0a15-44af-b608-08dac2589b87
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:45:05.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7htwLw4SxpuVJyhJiV6Rtsi4gmagfNbsFl+WXhLQPY8ok3DpZXy6UBwXSnPMqlYf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 02, 2022 at 04:40:20PM +0000, Nikolova, Tatyana E wrote:
> Hi Jason,
> 
> I know it has been a while since we discussed this. Based on your feedback, we are proposing another solution for the irdma kernel-boot rules. Could you please review it?
> 
> > > udevadm info --attribute-walk /sys/class/infiniband/rocep47s0f0
> > >
> > >   looking at device
> > '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/infiniband/rocep47s0f0':
> > 
> > This looks like the problem. For any of this to work the infiniband 
> > device needs to be parented to the aux device, not the PCI device.
> > 
> > mlx5 did not due this for backwards compat reasons, but this is a new 
> > driver so it could do it properly.
> > 
> > Then you can use SUBSYSTEMS and so forth as I first suggested.
> 
> Here is a patch for irdma driver to set aux_dev as the ibdev parent:
> 
> diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
> index 4053ead32416..e08fbfe148ea 100644
> --- a/drivers/infiniband/hw/irdma/i40iw_if.c
> +++ b/drivers/infiniband/hw/irdma/i40iw_if.c
> @@ -90,6 +90,7 @@ static void i40iw_fill_device_info(struct irdma_device *iwdev, struct i40e_info
>         iwdev->rcv_wnd = IRDMA_CM_DEFAULT_RCV_WND_SCALED;
>         iwdev->rcv_wscale = IRDMA_CM_DEFAULT_RCV_WND_SCALE;
>         iwdev->netdev = cdev_info->netdev;
> +       iwdev->aux_dev = cdev_info->aux_dev;
>         iwdev->vsi_num = 0;
>  }
>  
> diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
> index 514453777e07..835a087a3329 100644
> --- a/drivers/infiniband/hw/irdma/main.c
> +++ b/drivers/infiniband/hw/irdma/main.c
> @@ -279,6 +279,7 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
>         }
>  
>         irdma_fill_device_info(iwdev, pf, vsi);
> +       iwdev->aux_dev = aux_dev;
>         rf = iwdev->rf;
>  
>         err = irdma_ctrl_init_hw(rf);
> diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
> index 65e966ad3453..f2f86b882cef 100644
> --- a/drivers/infiniband/hw/irdma/main.h
> +++ b/drivers/infiniband/hw/irdma/main.h
> @@ -329,6 +329,7 @@ struct irdma_device {
>         struct ib_device ibdev;
>         struct irdma_pci_f *rf;
>         struct net_device *netdev;
> +       struct auxiliary_device *aux_dev;
>         struct workqueue_struct *cleanup_wq;
>         struct irdma_sc_vsi vsi;
>         struct irdma_cm_core cm_core;
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index a22afbb25bc5..f1304b6b58b3 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -4549,7 +4549,6 @@ static int irdma_init_iw_device(struct irdma_device *iwdev)
>   */
>  static int irdma_init_rdma_device(struct irdma_device *iwdev)  {
> -       struct pci_dev *pcidev = iwdev->rf->pcidev;
>         int ret;
>  
>         if (iwdev->roce_mode) {
> @@ -4561,7 +4560,7 @@ static int irdma_init_rdma_device(struct irdma_device *iwdev)
>         }
>         iwdev->ibdev.phys_port_cnt = 1;
>         iwdev->ibdev.num_comp_vectors = iwdev->rf->ceqs_count;
> -       iwdev->ibdev.dev.parent = &pcidev->dev;
> +       iwdev->ibdev.dev.parent = &iwdev->aux_dev->dev;
>         ib_set_device_ops(&iwdev->ibdev, &irdma_dev_ops);
>  
>         return 0;
> 
> Here is the udev output after this change:
>     
>     looking at device
>     '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0/infiniband/rocep47s0f0':
>         KERNEL=="rocep47s0f0"
>         SUBSYSTEM=="infiniband"
>         DRIVER==""
>         ATTR{fw_ver}=="1.48"
>         ATTR{node_desc}==""
>         ATTR{node_guid}=="6a05:caff:fec1:c790"
>         ATTR{node_type}=="1: CA"
>         ATTR{sys_image_guid}=="6a05:caff:fec1:c790"
>     
>       looking at parent device
>     '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0':
>         KERNELS=="ice.roce.0"
>         SUBSYSTEMS=="auxiliary"
>         DRIVERS=="irdma"
>     
>       looking at parent device
>     '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0':
>         KERNELS=="0000:2f:00.0"
>         SUBSYSTEMS=="pci"
>         DRIVERS=="ice" 

This looks right to me

Jason
