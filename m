Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050013D2313
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 14:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhGVLZh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 07:25:37 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:34497
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231724AbhGVLZh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Jul 2021 07:25:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESqGzTCLxOy1HSspm9MPv5clCRTpz5bc8J4DjxBcP9mZBQgcK/4PNAzQhytRLCQlHZKJaimxfGacmGBnnU1wxL6HSw1ln7gwM2dVw+FcHNYaILpJCtGhiziN5qX1tf4C+Z7mng2mAUXUTD3cgEIcvyPTjgEn8jBa4hZmUrksGtXly2l0GO2rU3l+RRA6BcblOtrCyIj+AWiL9ErfDgENliHBGGq63LF7psU4GBn5x796LDzhnwa37K7lKOvw+oCUVgc3S63ni5ZhZaiIrSe6jTdaMi1wVnrcvxK9FjnWrhZC5L53SbQYTb331oHGepEMcv7t/hwUwNH9lbWab13qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC7idlCfV2m2ZkM3cZnZHBIXt5P7Zff1FjoSwxO0Cjc=;
 b=Fo2C0WsjQLjhraOOSzT0C+oYWrCH6JmtwQhxFxGM5hsQyB0zv+UgtOh0KDprdp9tTvkcBPXfCecLlBew5CaBtttC+rORpg1lbnE8SlApeboWMTsVdKe/V2ymIVWEUTFgGG6+qf9UY0TMp3Ts3MUu6BDAaUrDBewWG+Sv4AhPveQRsNvgnKEKb0I7T/U1mnWvc0AOai7hgX8bUjuYnqpSj10ho/mPktRxIMhCC5BPR1qiBMRd0UqXJ7QBr2DPAxzrEikysGgZ4RJ2KVRze7Eh59NhmPptm2Fe+mHxJ4sKBNpE77qNiv2rq95RM+vDoix0+pyfC6CiIkhh3dS/HUSvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC7idlCfV2m2ZkM3cZnZHBIXt5P7Zff1FjoSwxO0Cjc=;
 b=swazMXLslxbOV9YdgtXyPaq/THMwzSE6zfMwFtBcGQYC6m5FVYRarG9XZmJevD8IiUVLKR6FUM7UHLOsWp2NA187kPLVE17uQ40ChLwi28C00DUXxMnrzrRrxCpyXmUcZeL11unVS3Be/jAbJrg/Zqn2hZeJUlrdE/Ah9Ll0lwcY6Ul94/tVDpFjatzv6Tx7vlQnR6ip5P+AeMM5YGqsh7Q50LVZHFz/u547RBzR5m2Urk+3170uInyLQF1m64maj4uG9jk7qKOMQDH/72gYH9zXBkEUE8LU9HV0c/k59wEDFQgnw5q86JYlVGsdRCA76XuMnLHaSXi5Wk9m2JI5bQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Thu, 22 Jul
 2021 12:06:09 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4352.026; Thu, 22 Jul 2021
 12:06:09 +0000
Date:   Thu, 22 Jul 2021 09:06:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dakshaja Uppalapati <dakshaja@chelsio.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, bharat@chelsio.com
Subject: Re: [PATCH for-rc] iw_cxgb4: Fix refcount underflow while destroying
 cqs.
Message-ID: <20210722120607.GE1117491@nvidia.com>
References: <1626866515-17895-1-git-send-email-dakshaja@chelsio.com>
 <YPkhhDkvYY2JVM+6@unreal>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPkhhDkvYY2JVM+6@unreal>
X-ClientProxiedBy: MN2PR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:208:237::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend Transport; Thu, 22 Jul 2021 12:06:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m6XSp-0063Ye-Jy; Thu, 22 Jul 2021 09:06:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c0922c2-8fb4-4bde-96e1-08d94d091726
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:
X-Microsoft-Antispam-PRVS: <BL1PR12MB514479DB46A3B594A269B02EC2E49@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqU2AAgGHVeoqrpkwk0HycZokb+1OoA6fp/9GiMR4ev8bASCXNiVPPSZ5zksStYgOHzufbuePyRa2P9Ea+cVzXAHzmG9+jSifwhlsscQ/DM/lONgSkwcyQjZDbrx2gJVo8U9zGjgt6azfICh1Hh7iNihedPb0P+EG19XUqFwNNQFxgBFm03GdYsDGHRzHJSBymUgrMtxCTPg+gKcC8VJ+g8DoJauWirltripENsMBaATz9Qfm/7D7aJ2vcSkoChEWqWir/u+dFG+GpA8yRSlsbI0dt6lKx8XF75CewO7VewopJ+7mRm5cmvcszDOL9BewxP1NgKY+rYluGGa8iXOQLuif3P/L7kr36H6Acr8zz9rgdTl+t0mUl2A3dUHyagxjuBxuPWFbgWDrp4lXh3u3iiVzUjctv7f3a3+4p0PXCUtNHbNrCYQHNU70M4jKnGPf4xCGlp9FYT5YZnzB1ppQTvtvDnEhNEbF2AZJujYB9Xzf0OubebuCjvTPyG6uDJd8bOz9fld31QWfHbvukbsMeStf7mJaKeO/ew6sCNb34jAVsw2W7lp+DgOuZiek5EqHQI4GdOKFohpTj1Vel4CevSfjInil4Ksz3d02Ppv06QY59mzFkHP3gjmf+Fl6cwlvC8bKENDr52fmNENlvCC8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(316002)(478600001)(8936002)(186003)(83380400001)(8676002)(4326008)(66556008)(38100700002)(5660300002)(2906002)(26005)(2616005)(1076003)(33656002)(86362001)(9746002)(426003)(66946007)(9786002)(66476007)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGx1SHRMSHNtQlJuQ3RtN2FoakJHRmxpZzdsS004ZDkrMFA2eXhTZVYzdnRL?=
 =?utf-8?B?VUgxOWtTZG5xMUV0UzMwV1J2cFZ2VUdLZnZqYW1aeWdJVXBTaGpKK0o4UGdx?=
 =?utf-8?B?QytKVlE3ZTJ3MEZQNnFXektpeCtMK1ZEbWFHQ0p3T0JPWjFzVTRWNkJETFc5?=
 =?utf-8?B?ZXFwMS9wbXVncjZIVkY1cEoySU1XNzlkUmJwT2JSRkpqS3daamgvbzVqNWIw?=
 =?utf-8?B?aUdEVU5ITGFNd0cvRTFwa1ZQTHpmdWl2a2NHdGxqQk9ieUNHa01yci9NODRZ?=
 =?utf-8?B?dnRHUUxjcERkYWpXeS8xbVFjcmhTZUczajh2bmdzVlRhTFJNVThGd3hHL1Ns?=
 =?utf-8?B?ZFgxLzB1bU1BQ08rYWt3bzJDYnprdktPZkI0VzNmN3BUZ0c2VU5BRzRMN1hX?=
 =?utf-8?B?RENnMGdaQ0FTcHU2YzV1c3ZlNHBNS0U0WG4ra21xVzMzTzVxZHNzMnVUamhV?=
 =?utf-8?B?aFhzcnZjQ1Z3WFo3RU1NejZxMndXWTVnWitvSWM3OE9KcTlIaTVjTm5za2J3?=
 =?utf-8?B?c2xxOGZWV1BkRTYzeUV4SXQxTm1LZjI2MzlDaDRJRHk3YnVZT2lGRlhudDlM?=
 =?utf-8?B?QlJtZkZhZFQzSUdTTXh0eitmRmVyWEFDa3BHb09OdC9HZktoTWFXa2M2SzJX?=
 =?utf-8?B?ajVHaExra1FLbTVybE1WK2NRWlFzVjFiT1lkTW9ESXo1NHZjb0VYNGh1eWZl?=
 =?utf-8?B?NElYTWc5YUozWWJsWFhSU0hVMEphYnZyWHlRbHp5SWpuZEswZmhNcWhhZ3A2?=
 =?utf-8?B?SzBRRWR2SXdOV1ByQXhHTkRKVnVJTEpCNnVFaWppVjg3OUtUcG5ob1FVV25u?=
 =?utf-8?B?aStXWWN4M2FhM0FFWmwvR2loRERpZVZwMDVscDcvTTEzOUhMakZWNkprclhv?=
 =?utf-8?B?TUxESUpLWXk1cmYxYU42aEFYNzRlcEhDMlZFK2ZBSEk4WWVpSWhRbkdQRHlO?=
 =?utf-8?B?Qlk2RCtEa0FRcGQ0ZnhjekxKMk9DMXY3Ry9VSzF4djV3ZHFpQnNuVU1oWlVC?=
 =?utf-8?B?eTZ6YVNLbERoK3pzVDVYdk45dzYwdGlDbE8xWnFid2gzQWg4aHQwcnBaMGVk?=
 =?utf-8?B?V3lJWXhOWTBOdCtqbGh3clNCUThHL2F1b2FST2xHUjh5WHJQeG5MRFJRazZS?=
 =?utf-8?B?NDdjZlZ0MTRpbE1FK3BVdFpCK3o3dEU3d3hRSW1xZHdqYlF3WGdNRGlvYXBk?=
 =?utf-8?B?N1BNOFZQVFFUZGJHYTBjS2pRL1NPcGV4SXlkMVJlZHV6ZzJ6TWtVM2xQckFi?=
 =?utf-8?B?TVZVS3ZpTlZmZWswZkM3SUZSNlZtNUJxcmN6WlNLZXNWTDJYamowSEJoeVVs?=
 =?utf-8?B?dkVCMHU0VnJ6UzZiZS80K05Ya1BRaDBucmZaUVN5R2JLenJoTWVPditNdTZP?=
 =?utf-8?B?N1BjNFNQVmFkb0RoQTZkY3hQS1gxUm1TOG5VK3NJeVhhU3JtekNDOGJXOGxt?=
 =?utf-8?B?bnoxR1ZIRWYzemR2aWZ1dEg0THdRRi81TnJyWEltbk1VQzFpZGNFZkV6Z01x?=
 =?utf-8?B?TlJrTFc2NnQ3dFBDUldFcitiNVhRLzVHbEw0TjE5eWhqbitiWURjZDRLZXJY?=
 =?utf-8?B?R3YyQ0dlbC9senk5MGFCTGcvdVNXREVYT3l4alVQakJJSTY1NTFxbm9SNS9S?=
 =?utf-8?B?elZ5dUhjR0JxbkdhZ0RVa291aWlzSUNaejhZWkxvZTM4aHhNRFRROXhBY3Iw?=
 =?utf-8?B?biswQUx2Zzk3eVlWdzc3Mi9VTWxxSmNRT0p4S0NLdnlyWjFWVis3alZQTTRH?=
 =?utf-8?Q?o8ZQuiDVcQaEDnE6LPpBJ5UJX0B2EpvhiqfeMGq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0922c2-8fb4-4bde-96e1-08d94d091726
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 12:06:09.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YCIDOxC0IFq7q0H1A3Ke3KSHN0ecmN+1G8bIpW8z1lJuNlG4czlSLXCfkooQALd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 10:43:00AM +0300, Leon Romanovsky wrote:
> On Wed, Jul 21, 2021 at 04:51:55PM +0530, Dakshaja Uppalapati wrote:
> > Previous atomic increment decrement logic expects the atomic count
> > to be '0' after the final decrement. Replacing atomic count with
> > refcount does not allow that as refcount_dec() considers count of 1 as
> > underflow. Therefore fix the current refcount logic by decrementing
> > the refcount if one on the final deref in c4iw_destroy_cq().
> > 
> > Fixes: 7183451f846d (RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting")
> > Signed-off-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
> > Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
> >  drivers/infiniband/hw/cxgb4/cq.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> 
> Thanks, 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> We have plenty of such errors, worth to check them:
> ➜  kernel git:(rdma-next) git grep refcount_read drivers/infiniband/ | grep -v WARN_ON
> drivers/infiniband/core/device.c:	if (!refcount_read(&ib_dev->refcount))
> drivers/infiniband/core/device.c:	if (refcount_read(&device->refcount) == 0 ||
> drivers/infiniband/core/iwpm_util.c:	if (!refcount_read(&iwpm_admin.refcount)) {
> drivers/infiniband/core/iwpm_util.c:	if (!refcount_read(&iwpm_admin.refcount)) {
> drivers/infiniband/core/ucma.c:	if (refcount_read(&ctx->ref))
> drivers/infiniband/hw/cxgb4/cq.c:	wait_event(chp->wait, !refcount_read(&chp->refcnt));
> drivers/infiniband/hw/irdma/utils.c:			   refcount_read(&cqp_request->refcnt) == 1, 1000);
> drivers/infiniband/hw/mlx5/mlx5_ib.h:	wait_event(mmkey->wait, refcount_read(&mmkey->usecount) == 0);
> drivers/infiniband/hw/mlx5/mr.c:	    refcount_read(&mr->mmkey.usecount) != 0 &&

It isn't the read that is the problem, it is the naked dec.

This common pattern is just being done in an obtuse and arguably wrong
way

It is supposed to look like this:

void ib_device_put(struct ib_device *device)
{
        if (refcount_dec_and_test(&device->refcount))
                complete(&device->unreg_completion);
}

[..]

        ib_device_put(device);
        wait_for_completion(&device->unreg_completion);


Not use refcount_read() and a naked work queue

So I'd say these ones should be looked at:

drivers/infiniband/hw/cxgb4/cq.c:       refcount_dec(&chp->refcnt);
drivers/infiniband/hw/hns/hns_roce_db.c:        refcount_dec(&db->u.user_page->refcount);
drivers/infiniband/hw/irdma/cm.c:       refcount_dec(&cm_node->refcnt);
drivers/infiniband/hw/irdma/cm.c:               refcount_dec(&listener->refcnt);
drivers/infiniband/hw/irdma/cm.c:                       refcount_dec(&listener->refcnt);

Jason
