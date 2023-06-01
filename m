Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634C571A36B
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 17:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjFAP4o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 11:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAP4n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 11:56:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04AF1B0
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 08:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oexdz0glcFottD+XxtOUY9ZW18++YY4QfB9Td+hlIWX3dbcDkyJmMqE+0DRMWmeZ/Q0tnXpiZm+sIk9nXuXUCcoZ/urSDq0VJt7ztM0TWUmOEsKFsihmn0gNKe/3DUTyp2wUrkjGry6/5i+MhQx25y528h+s1RE6QpGjrAfwDS3JH+ixpYvzQ4xM2Ggxqee5DXXizbsm49LZZQKgQFqhlah2dp6BGABSRHR7gZYbsWdvKJiTDWKRy1EFxbrdvZemuAcGbKyAQrmz0lgDyoBbuITMZNSFoZ4CUUammuHjIpn5ZNmwyc74dA0/Uilc6V4pMCN7UlYTiVOwYBI9ZaIWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0WWm5eW6LZWl3UqaPDtOmnJ4OlDBliu+t6bkLE4GEI=;
 b=bg+PoqzmFBcm+ywzrIPDbOV5+P4cKnvQCL40fMHcEt+Owruz4I4Nxle0luQE3k2EO5cE5KA8kGsanQf/DvH7ciFU2nygLXVxBOctnNFr1rUmWdFgoqWKX8In/8nQEa+5f5fL/h5sKOYXrv1v1ON2QJ9yk7uR6Ezq6NAHJBprgh2iW2KNHWYsTtns3qH+mCIorl0zwE65660c7L+oCL+1Qp+zDWhvCgd8WSLtxUgd82MRae8gkS4m9OF/O9vtzWIU+GJ/0iScuE7YnyIm19EDHJc+swMUZlIX41N4pIrPPdelQZu1a9UC8YvE2fH8r8IG25tb2W4R1arZKP7nySWb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0WWm5eW6LZWl3UqaPDtOmnJ4OlDBliu+t6bkLE4GEI=;
 b=mpDjT54Tq9xusO1O3JQfeiDSXxSnosWVtUgZh3FSt/cdrw729l09NmogeP1RCRjX6YPc6AoX1HvTipBISUtBUlSqUsacm5u8vBmLl9qKDIhdDrWEdB43B1Y68hvQbXY10hM6wN61CHZjiarmfql10mHSv4vi+PtVcFU8OgPUng4EMmnMRVRurn1H0KS0M6FWYfp9ot5iXCjf3c0Y1Il33JLS99IRLYIzXjH03EwznjdPbIwpnvR0fVuE07c6Yog+KPsEfWyFh2ClyCeJXKAQsd/zAw6NNOlSqPsK0BHcwzMYj6JRKGYIUjP3FesrlxyrNcVo6dmUhK4sM4ARw5VhOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 15:56:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 15:56:30 +0000
Date:   Thu, 1 Jun 2023 12:56:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
Subject: Re: [PATCH for-next] RDMA/irdma: Implement egress VLAN priority
Message-ID: <ZHi/q1Bu/J4KJnKl@nvidia.com>
References: <20230522155654.1309-1-shiraz.saleem@intel.com>
 <20230522155654.1309-2-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155654.1309-2-shiraz.saleem@intel.com>
X-ClientProxiedBy: SJ0PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: fd988bf4-55fa-4115-686e-08db62b8c3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcH+yYr71bpWjKdiknrRQGm1yzKUMAw153Z5JE6Eto/7K/Q+JDDMENB9YLCcXy4Da1RK8HRIe6c+6jIgaZPSEd+jCiHtrBmtobKirxRGTXi4s+AwHjTEZm5C6jnM+M/S/mqE/EL8zAVYwIeSNsgA6VPMVNvvFN+MnAGXhA16itlU+qi5JanDUYVqiqnnQi8O6L6PLI9R9mjdBSai+3YNfscrm/udiXqmPlytG8fI+mTxObjLp6uy8y09lHM16rDwYbnoqZtov+DHg91+Y0nehqa4PxTso6DnbIKvaH7NgF7O/PfY2GjDeOKtahrytSzFsvVzvZII8kjfEasof8niquSlXm5jdjLCUXxA2oya6OMlnPXtSBjEM3+OKSubrgy7O7+QmhNXQv1tZzPmncORUIccnuLynRbVUYIqUhwEiwDhWGpfGJWD4Dy/wUgK9e1vADP+Y3w52YBvx/C4zgYf3DtbdaIFe2BbkR7wpHTBC6lfGcWHzBLTLi5PNXrhLAqPj/72Zbn2HiUerQb3Y3Wc2Ud+ff5jcUj7HbrYywDWjfhPBDfKDhFuphXbhfaHzQj4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(83380400001)(6486002)(316002)(41300700001)(6666004)(186003)(26005)(6506007)(36756003)(6512007)(5660300002)(4744005)(8936002)(2906002)(8676002)(86362001)(2616005)(38100700002)(478600001)(4326008)(6916009)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yNkA5cA4pSQUk4Lh1MgP/NFVxdgXU0OPBJdR4igdCj03Hywk520T+RR4T6Cb?=
 =?us-ascii?Q?zjEFUMxmy6wWLq9n3n4kG70pTkjuY4FMbSifrtw2rtQciEOwG8ZP0xP1jMob?=
 =?us-ascii?Q?B77Koie6oT11s8+Ya3krIt3IC1Lx5/i/jq/h5QUHExaakoXknawCIgEflvcT?=
 =?us-ascii?Q?fWJBOT9D1xDdB4uW4ROWM4ldJOMicGC7f+fTWg3/1xSinxNtgRRRJ1ApOyZ2?=
 =?us-ascii?Q?ZgiiI/6BslJ2iDF/7dFfFWiBSSxgkvnzSWBYEadAZTBuaMeuoXm6uxzZ2BKN?=
 =?us-ascii?Q?RKDgIxOUb4hDNM8qNqFyy5wRFgV0ldcKionI8oblJxpJIeEZXmDH1QSJPhVw?=
 =?us-ascii?Q?ZWGEd+4cya7xibj8J//MnT9OrozB+MdnIpP9/OQfD/0+7LTKmwtMMKiiFUbo?=
 =?us-ascii?Q?0J3ob7SUQZxDX0goE1svyrLKUqPA6COJ7Xgiekqrx1D5m1haS3ZTbt1KiB+o?=
 =?us-ascii?Q?v11yHIN7Uowafk4bNpOmMeJGgq2Su7GD6KjOMC/KRzlunXs1sax9tZP7rD2z?=
 =?us-ascii?Q?mOSqztZyhPLaJpllti3xj9K/9VTSxWaXnaHCbSNtMtCwcz1WmnyzG5a2Yd5M?=
 =?us-ascii?Q?ZwSaWoXjBikicjChlfjdCnrXrosnRMsrgAdYq9ns90N+atR3uYlmCxqr38xZ?=
 =?us-ascii?Q?2ewuKNGWpTCs7zkWer8MweP/jzV0rzPWfT1FLuXCYy2aPrw2RpMfYh5SWLlg?=
 =?us-ascii?Q?qYYaRNZ/9FMV6wvaYkBtJ3Uy51TuVZMQzfNG9IhsI1vrvQUMnwcDjH4e3vFQ?=
 =?us-ascii?Q?uPEiJ5ZHulSfKnGuJfSRZPA/MwDDCXoZ6KDMwB/feuFZr1K3cw3S77bwizTJ?=
 =?us-ascii?Q?3tpI6Jag+ZFnqH1q+ZLdqlk4ZBcYkBWetZkPdXphuptRBA55vY0g+4wmXUpd?=
 =?us-ascii?Q?QYQiLgucM4PkWdlSgUU4Ax4xrr/QBsswyLHkglrg8f2Gp9/uazsW/aB1niUu?=
 =?us-ascii?Q?Qr1tv/aNYXOQoKDxC2OTdL+HeG5JizFyiLPDywLNLoR/gC5w81ugA71BOKdU?=
 =?us-ascii?Q?yzSP9e3en9EpliQ46RZHmObKJQbOXqMQLuwlvbuIHX+1y33GkXfVPFA91/PC?=
 =?us-ascii?Q?eZFu4wvvTMI8252CX4Pn10uqR1OSObk9m3gaWs7xZW4x5LhB2C2tY7DrK+kY?=
 =?us-ascii?Q?+3BODf9FtZHm3uyDdOdHvkfxJxTMAPR3OcZXu12FF5fTw4EQmZfae2H2IE0G?=
 =?us-ascii?Q?iGzvj+h4ozPpesnzg6p3ocMV/PWjOIIcuE5RABVp1AMGutX3RkE2g5XPDngc?=
 =?us-ascii?Q?3j3cDSKnG27+wIGSUelzagPNMgNzx6ML0i7nFxM9VCM+HhqvMBS9g7sSYBkK?=
 =?us-ascii?Q?XoYzNOWuHKX9n3+OxzGsvccF84O55V4/iIKr9bRXNtAR6lsZ60e89X961gFf?=
 =?us-ascii?Q?b/t8pG/uQeHJDnH06vMj/ieKB1nuQm6QQm1O7YUs5MlVZJqPL7/ZBzFz4c3/?=
 =?us-ascii?Q?wmJ4bBJyFtOsV4PUc7FenJtFlpRVay1qgRgHJhCsEZhscb7Zi46rfLcBd7Qb?=
 =?us-ascii?Q?rvjsb3B5CoL1DzfcWR0ttXuNXChoiEvxqlRK29JcoawxGGZvnQsVC/lQW1Em?=
 =?us-ascii?Q?3+9r1IkyC9FWLcVipANHUV6VI60zyS+Ah5bz0j58?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd988bf4-55fa-4115-686e-08db62b8c3ba
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 15:56:30.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkGSJxfVPl1mzghU6D7BHaDaqeXIcXX45UhMue3yZZhOD4QmXAaqclSu5n2r/tyH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 22, 2023 at 10:56:52AM -0500, Shiraz Saleem wrote:

> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index ab5cdf7..52084651 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -1097,6 +1097,24 @@ static int irdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
>  	return 0;
>  }
>  
> +static u8 irdma_roce_get_vlan_prio(struct net_device __rcu *ndev_rcu, u8 prio)
> +{
> +	struct net_device *ndev;
> +
> +	rcu_read_lock();
> +	ndev = rcu_dereference(ndev_rcu);

Well that can't be right

You have to call rcu_derference on the actual original load to get the
pointer, not on a function argument.

Jason
