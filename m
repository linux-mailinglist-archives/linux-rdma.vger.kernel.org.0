Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9788C42C8A0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhJMS04 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 14:26:56 -0400
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:60001
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238569AbhJMS0z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 14:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnAcEiHO+15i9gOYi5buWiwtfIxaTqhA+tzFW9m6AwlHgsrJVipO6jOnPTBNDowMofx92FkN0lLNPylCIcJNh0XEI3qmYe0w/ROgeweFbO/pCKUO20Qd0bkakvopACCYiZASnym8S2GkDrngkXbBALag7iTCnJLL5hb/BU+xCOau0GtzN6syszTNCklhvzr/TVNZeyKt/XjMsUWaa0iXi3sR3EiQx6MBHFhtoN1tDPMG4BjQobVOye36K5BvCtD+eTgMInXyPyte0/VF6pIxlYyWUCzmILXtEbmoJcIc0VMzrthMLyKlKkHtZpjfbO3Up9l/5IsOZCpcFyA19mnVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukS6Qvioucj5+gsVbtd9sIFfGNIL0L05X1FBecqJ6/I=;
 b=Yeyf1FcVnYDotVbO8ZB9yJA9wWvli52yradXHgBcXnjnjmWZ9/gnPLhepDkZpoZ5CezPZIDatfBEMvNoy1CtfocchTx+bXX+iQQmplOVtFSBzJyXsCXlHZY8KlCjinLZLixLzxqougN14bCbEy+yw4gtdmmgs5VDBsY+GWD3q02ij17HKYHZczEbFwR7ohBeAWJ4QDiyw3O7dksZpafgezQxNNQNvJpxENroI+YDaGjzrWMmHExNQDQ/37As1S9pVDfVjXSY4xp4sJh95l5g1OCtvqZExxLveWOCTF1zL42wLD/i1+pkBd/9WsLTCBRfqxN0R3wT/QGZDycd/bI1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukS6Qvioucj5+gsVbtd9sIFfGNIL0L05X1FBecqJ6/I=;
 b=gkIqte/dKwV0wUg2cLG8R7sIjUg80dFRPyze0SUhGiD1SBceSFb/KXKLTjk4Yow4NtAMgvSFT8C8JKXti+jzuVDHgbhVtxjciKWg57FESrJ4b/mMuiwehOyXI0zw4NqCykOg0mIDlvBlDVh3kFUNdjSvzg/45dgnoaDs+MPvyzs8UHWHpGcT+SpvQnhjgEAw264Faf8LCc0EUmWlXiycq/tkK/D+id2DozcedQWWDPDCAYdRd9KQ0duzryBf1CRtowtr+UzQD0lPku0WJ5gio+WDehvrU8G+qkutBYISPXD80qC2Y26qE3CG9iNfaG3AgyOeWs5lCs0eLJvfBypdtQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 18:24:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 18:24:50 +0000
Date:   Wed, 13 Oct 2021 15:24:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, markzhang@nvidia.com,
        liangwenpeng@huawei.com, liweihang@huawei.com,
        haakon.bugge@oracle.com, rolandd@cisco.com, sean.hefty@intel.com,
        linux-rdma@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/cm: Fix possible use-after-free in ib_cm_cleanup()
Message-ID: <20211013182448.GA3489723@nvidia.com>
References: <20211013093016.3869299-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013093016.3869299-1-wanghai38@huawei.com>
X-ClientProxiedBy: BL0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:91::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:91::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.5 via Frontend Transport; Wed, 13 Oct 2021 18:24:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1maivo-00EdsP-Gr; Wed, 13 Oct 2021 15:24:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38c87a9c-c254-4e29-0ffc-08d98e76be87
X-MS-TrafficTypeDiagnostic: BL1PR12MB5032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50321E3493F6DA916C9496EDC2B79@BL1PR12MB5032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35gcyY1godTsjVB5irgRcga45fMZ90qQIc/k+HYD5QV26aoVX2PUEMxu31+ins+lc88qa2/+XqizPmiepRaI9vuXqOUfn1gK9TA9E/X689+zlXCpoZG/H/cIhK9eta24b6nvIm2rG2ARNnSO+9xPTCl2pLU/kWrW3K/15VgGo0pRANrkMCS3k/gFYSM6+CHrvtoOkkTkDBi9zlD6t/JI76cL2y3nBssGChBasl+ribNQKXPlb0Two1J5Zw12JtIn0860hzPXrI4kHF6fEI0aDuJNRVcHKhrwsLa5Yl1DWgubGB/FbAZWjJxLAcbP2+i3ONql03OeJfA/K0kyhgYu3ZS7OjRwejtBFVbFfVqCAttU0oQmAwITPD2XtiuRMAsUVOCqudD8L8BA0jScSl8u1/E55+KDLgYPbNAlpi5VjqWAai4QAp7N6YK0faZs4snMvwEnIiPV0ydbOPpd2zoWnmiCzCu652nhbGHLuqL50aSnwhSeWzl/Y8CZPTsWZuK+xGoN9mRkbPUox2wDlVb8vAgrmBMNJ9JU26fMU1A+r41fPbfe7NA1r5bOfIh4NN3L9ge2WauKywzMMO93W0jbgxScl7XGJHBFmLkRGljBrqCkNJhsWyda/UfbbBP0BU2WCkqBnDgGOj5OUh3gTy5SmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(66476007)(66946007)(8936002)(66556008)(8676002)(316002)(508600001)(33656002)(36756003)(2906002)(83380400001)(38100700002)(26005)(186003)(7416002)(1076003)(426003)(86362001)(6916009)(2616005)(4326008)(9746002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4uagSg474xWMbTebRCWZs+kMvp2F9mjIla+X8dfqmIEGoaIto50sv4vfiJU?=
 =?us-ascii?Q?fl0OJghnSxo/mb1PUSFYfh3Yj+nGHjToTWhEqVbFR5WJaEXWL2vj89Wdrv/4?=
 =?us-ascii?Q?pRvAEwObM8SnlRy/aWAr4JywJq4TT2NGKB1AbGmk1Xgll/w7Ec0vtsRN32eK?=
 =?us-ascii?Q?K/Y6xzcUHGIw7FtAD5Uozyzfe9LpvQV7bLhk2g8N3YEvBuVkrswnSfG6IXNi?=
 =?us-ascii?Q?ljfhcDKdwnChetDBN7DiBadaiFfnG8nfsyTK+b3xR8jadCUkvLZkcpnjLt8N?=
 =?us-ascii?Q?YuMBgOSMla5joNI+wgaUlsp9ZhcryFXEdCSTRvFy240kGTCa1AGKveL86+EM?=
 =?us-ascii?Q?FJbl3LwC+SzaCfF5vSxfbGZNlv21uL1h9pcuztcssmvsgSSSAE0oevhT+W20?=
 =?us-ascii?Q?VPaOsHfo91XGC8LpRP3G5m50bstUSKdTCGjW1o2RBzWxNROKis1mz0YrC4Rk?=
 =?us-ascii?Q?pBF9oHIBBMq9B8AOEZaaDGFMrcpNRaFu0rS6BUFsECK5o+eO4wCUrLdXJvb4?=
 =?us-ascii?Q?zHlPu8YUOC4K2vBHiWSaceJBt2zqYGMMeAj32PRYnvKMfMp9doYs0VBgULla?=
 =?us-ascii?Q?e1tMu1RMTFtzaEEVrGAnRBAK8rPbxIcj8SA9yglfTC8girbFTSmigWacutId?=
 =?us-ascii?Q?SXMCGD2iPCZu4K5LDN1eZj4y/mOdaj9R65vNtsmAJO4l9lbaHhdQpUF7gqhv?=
 =?us-ascii?Q?B5xlMsC9Rcyu39vpIZU2ixn9r4lVlySc1nfrmOHbH+TaGMO8Qhjq4aSbk1yl?=
 =?us-ascii?Q?UVmhP46ajgs33zyeoPhhyvYFdGa0+er33cNDbNO7g8rcVTQ2qF+dyZRKvR25?=
 =?us-ascii?Q?Z85huAeJCu1HwBUpOCt3jX6OTGm/eU+LouQDV3J8YpWSjTEAJHQQqPK7Nj52?=
 =?us-ascii?Q?TLOftAmJ6Icr8yfl2fWqKXcfVJEch1YL80gI6OHN9qldkIfWNUU3QA5srfBp?=
 =?us-ascii?Q?9oQ31w5HxzmlIBA8P5BUquLM3dt8YPg3q8qHvcWxBAe89k8HytZp7Byi4W0I?=
 =?us-ascii?Q?EqVy9OkUTj9mDg7EHPANFgz6/gdzN1MfXixDTiXuSq8Ka5VQxMf+eLprTQDJ?=
 =?us-ascii?Q?0xOC0vVgs8QrlmeWc/RDkbDPxCOM0OEYuD8bHR9EudpqtxRTPQXIHpGMy1If?=
 =?us-ascii?Q?eN6iOVDzgT7yKTRzQqEyC6N3CM5bohTbnGAYK2yVeY8xX7lDeYQtC3AsL4i2?=
 =?us-ascii?Q?fqX32FAQ3Lvb6q4SkCbA8EoAKHQQDYqhxinW9VodWxHfROEHVw2y2aulx3VK?=
 =?us-ascii?Q?F2Kn3IbnyHtiw4Z/Qx8MiH15DmREC1pA/kU1/w5exsi/rh6pd+WJ69ALtEVt?=
 =?us-ascii?Q?+rnd2OlevXBfqmAhCozBaCVt5kj/Asxfq3THfJcw0F03rw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c87a9c-c254-4e29-0ffc-08d98e76be87
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 18:24:50.6280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlzl+jeSxUvejcuUCpzxyC89MJQXi1Dz0kzVYzmV+aba9jKj8lGQfY3kXqRyAG+e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 13, 2021 at 05:30:16PM +0800, Wang Hai wrote:
> This module's remove path calls cancel_delayed_work(). However, that
> function does not wait until the work function finishes. This means
> that the callback function may still be running after the driver's
> remove function has finished, which would result in a use-after-free.
> 
> Fix by calling cancel_delayed_work_sync(), which ensures that
> the work is properly cancelled, no longer running, and unable
> to re-schedule itself.
> 
> Fixes: 8575329d4f85 ("IB/cm: Fix timewait crash after module unload")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>  drivers/infiniband/core/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index c903b74f46a4..ae0af63f3271 100644
> +++ b/drivers/infiniband/core/cm.c
> @@ -4508,7 +4508,7 @@ static void __exit ib_cm_cleanup(void)
>  
>  	spin_lock_irq(&cm.lock);
>  	list_for_each_entry(timewait_info, &cm.timewait_list, list)
> -		cancel_delayed_work(&timewait_info->work.work);
> +		cancel_delayed_work_sync(&timewait_info->work.work);
>  	spin_unlock_irq(&cm.lock);

No, this will deadlock:

static int cm_timewait_handler(struct cm_work *work)
{
	struct cm_timewait_info *timewait_info;
	struct cm_id_private *cm_id_priv;

	timewait_info = container_of(work, struct cm_timewait_info, work);
	spin_lock_irq(&cm.lock);
         ^^^^^^^^^^^^

Holds the same lock

What is your bug? The destroy_wq() a few lines below will flush out
all the work so it is already not possible that work can still exist
after the driver's remove function has finished.

Jason
