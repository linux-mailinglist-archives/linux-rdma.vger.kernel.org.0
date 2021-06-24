Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F793B350C
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 19:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhFXR5V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 13:57:21 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:43360
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230480AbhFXR5U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 13:57:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0qcNsVfsg2DiQBGV9Z7sSDvzg2zChe6RVDFPE6nZVfgr6ttw/BXiML1pUopTBiBJhelqWrxo4Cttcf7QkCncqjD9Oo8EFgRrGd9gpUAQZ9+v82l7dpXWXK8XuUljh1ecA+1IWQiVBecCMOcXXf+giG7Oio/MBKfPozfM98vAL8yJJaMMtZ2ssKXa3pCqL4tdiydApBzSszQjzJ1bglB+Zys72YWXI94gvscHHiyTk59Joouln8BcMLFeDzIOUsyUFoXhGhdBrnuI6DR0MTjuTEL+3eWRCdHNTO+/azMhYsId8iVzNFQfPFsYKjDynhGCHUmvYk6dryMzxC161PAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opRue5n9ZCQXl2NLIRzmYoaoprQbRQ+sTPpJ3pcG/Bk=;
 b=aOZ+aFZPsbAgx4L/aJqMBgewZz7+4QhRUn9rJZpW9v8qwzzYPfhrPF7Sb7bDCq1Fnp8jR42iYQAFBBM4mN6HMRCkw41ENtoao4oKqHrc5x+/i781YZx5K+OPoA+bV6lkGay8zMThco3drXdjP/ZFhMlLssEgoD/5RQ0lBD3X9qF51uOpWPSlEmo+ApJTM1l4Q0woEIxqXqGztd7kA7UbTt+rip4aT6G+Ffibr5N+KitMS273cs7VymRp7a0NzCVL8ygRKib4iEGUPYpSgCoVJeZdwDhCEwWUZylxyqt2I68HWhMhXgWdUr3oWjpMynx6aLQ6UIqzEOr9YCdbRHah4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opRue5n9ZCQXl2NLIRzmYoaoprQbRQ+sTPpJ3pcG/Bk=;
 b=oOMhWXEIlFeNvaLhh7vXDTpPEdr1juBb6L7DyepJexb/344cP84YFCvUtDS/CdIzltEC5UIo8bf6zM8OcHFzK+/PnqwvmkCornAuaYQgflWq0q+pMFnx0PsuQz/j0g7IWdFeowgvYEx3QHxVqOrY6b+M8P/6Q+eI8iVnTdnqXL6nJi5au/Byibo77sUf51NqPWdhGqmd4WCq66ODXrI0cfW2zWRDL6W2UA4IMNd2meUDKpmcuZGAeBAyNm+F+WKrHlCPy84q2y1BnB31FJJskUvRpSj8Hm4Ct0W/hZg15KtiFGslxyqcKP5IU1U2b8epQgvzCZfaNldrsscHI/UGqg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5556.namprd12.prod.outlook.com (2603:10b6:208:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 17:55:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 17:55:00 +0000
Date:   Thu, 24 Jun 2021 14:54:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, haakon.bugge@oracle.com, leon@kernel.org
Subject: Re: [PATCH v5 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
Message-ID: <20210624175458.GR2371267@nvidia.com>
References: <20210616154509.1047-1-anand.a.khoje@oracle.com>
 <20210616154509.1047-4-anand.a.khoje@oracle.com>
 <20210621234913.GA2364052@nvidia.com>
 <012d6cd2-5167-ed81-80db-444fd2741ea8@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012d6cd2-5167-ed81-80db-444fd2741ea8@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:c0::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:c0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Thu, 24 Jun 2021 17:54:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwTZ4-00CCKS-PC; Thu, 24 Jun 2021 14:54:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dff31ad-a732-4f8f-4ca2-08d937392f72
X-MS-TrafficTypeDiagnostic: BL0PR12MB5556:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5556904E8A5018740FD10612C2079@BL0PR12MB5556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yr5guM025AbAy3SRYFxxXW0xaP5AyjuYbN3fAPRXieugFlBXxEaF2iSxk6my2v4L9Qdl7PAdjXO0tNPpVczcbO3kN+xjuOgNnyY1X0B5d/d1DuMVaNOST4azwRU68a9/O2vEKdiGHHyj0SyHHtWWqL+Sw4LYfBKEev0r+3gEoYIH2Grkb4uOvFbC4ASpeTf5ceg9K/CqGhuyuhBauRLaAuBr3JEphLiXavBX/DCI++b0niX10cAPoRykbjK32q8jf2ry9bDQ7Ky8wcKcvktgCqxSYcNWb2UtKzZLkDgRlznesPeZTP2abet5Ne4PG01a4g036S/TjYywvUqeJeYrzor7DOyg/uEdR9+wsZC2Q11UIy2/zGNiEChP5Q5QPuNRqojiScR5sStMuSw7Qtwr3FsNSVCOK5E0befagibXjUfdd488Kptd0c4+kmAogkbOQV8KwkSIZVfRusIOgWQO17qVMQi0iG0OtQVGtXtyZJn5PTP1nx2xHMkIhwqArwFVTl+iz9SExPe/IcIbXrbxhPDN5GpqALnjEYXRpl/STrbsOAQbfI7E46bevJKG8eiPC/H5hiwoRhDoYuIR4zzhnyO1PqQTihtJoIhX2c8FG4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(66556008)(38100700002)(186003)(26005)(83380400001)(478600001)(53546011)(2906002)(66476007)(8676002)(36756003)(6916009)(66946007)(316002)(5660300002)(1076003)(86362001)(426003)(2616005)(4326008)(33656002)(9746002)(9786002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RXFirhRC+TdqespZB7ppF4tNF/NFf2PCffLTc0ASds36SeVPfQaBDeLJDEdZ?=
 =?us-ascii?Q?ZBO0l1irGAwef1xNd/h5qOB7sr1XI2QLHwlAJYj7GjOSe4OHQbOFM552iE66?=
 =?us-ascii?Q?3sCrNWsZetRRDH2t7nitM7fWNRfKWQxKCZP38PktckIqyz9wfbXb6eCveNJY?=
 =?us-ascii?Q?HRDaFnlx0uiZCo6odagoO9IPZk0LCtdp+DB+jFUYZJ4gGQAYU0q2whWoW8mb?=
 =?us-ascii?Q?RorY37hqxlkI8A1bfENoZa2hmMPQ+ZymTh9peg80gr0GUpw4aQoFOtgGNjTK?=
 =?us-ascii?Q?lmE76Pq1Ui3S2Ud0Zs5bVx3TGPEj/d3UeZ9b8/HA86KVk6JXQNNoE7V0EeWJ?=
 =?us-ascii?Q?zaL+u5UMBx5PPiGzgz+ziT/LL+VKBeL+9z4NSMY8Zb8lUkabUi9wMQg+ofat?=
 =?us-ascii?Q?r3mJGyYsIYT3bOyhT6IZY8pFt4FPMJjRe7Nq7FdXni2+0GClBXBuCo1c9Fh0?=
 =?us-ascii?Q?ZDvMjyyp3cExlH74/xqteF+i/MrbYa2G1WvCbbd7TKOF226DmHLwMGPAUaC7?=
 =?us-ascii?Q?Bd74C9mlXDbQywfqeBA4oTfkcWCuksoYTccvU5dBzuXnaFSGxyU8JXvRnDoX?=
 =?us-ascii?Q?8iiRfAkoyN4iaFhWN0SGsZK+Su8qCx5OvSLycVrE7jTFoF6cCADPOq3jrBRS?=
 =?us-ascii?Q?zxg51SX8gVu0YlTb9MDGQlaY0MCgVuSf/JHWOifL8uNfHYIhX65xwCZ5hcrd?=
 =?us-ascii?Q?WXWfkdiqnrOOTNze0xXOqpceqXEskaRe1MZDp1e4ttCDin3gWVVJPo9CBhTq?=
 =?us-ascii?Q?NTJta+zbCaTvJLrQZlO0RzJHHgUijZG2z+rLw3Zfuu3vL4gLF4O+URaJD8hd?=
 =?us-ascii?Q?74mAQsOAw9dvjoKj41B1fRTkx+6orT001lSIewW1gA30cfj7Qm4uUtVoNKBj?=
 =?us-ascii?Q?zTyzzxkBpo0+IEhPudWzJdElUkTlxMWo4yRN67l1zK/tlKHjtlL7a/4s8x36?=
 =?us-ascii?Q?iD8EWR5vppM1arkhHwHXbUzZNd8sEhwuUuFTQDkLeUD2F0Z90cSEEh12Q1YP?=
 =?us-ascii?Q?zTWgibC93cP+79o4IgnEQr/VrTf1etHrnFUdtHnQL4RclhGHoQy4BK12DdiQ?=
 =?us-ascii?Q?ybF59PCvXmy89/eknQHUnIIPkTXcgIF2h2sWRautdN1Qh5zbU0E8WFLBeVuT?=
 =?us-ascii?Q?GR/9eQTBOdM2VPDCFNQW5cKmDwNony6/W+SASlbNyqnldX/Wab2T6Z84VQG7?=
 =?us-ascii?Q?3ZUQuVEBVXv2caG0fRYP8CFu3cqy0WX1BclkDq5L4dhwg6FEXNQ9BIcaAEqt?=
 =?us-ascii?Q?x2XoVtZRbF+YyW4sxiVRmfSsIN1XOUrnPYkTAmgsfPu08en3z/Sqg6/X82sV?=
 =?us-ascii?Q?FyD9hxqSpQkTnqZFWSBqbGVP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dff31ad-a732-4f8f-4ca2-08d937392f72
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 17:54:59.9484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyDAxSKykLnHjg9660BUZUEbwfs/X8dDls7zhRvIfk4+oSdLP5VvbfbPAYDF4U0O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5556
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 06:33:32PM +0530, Anand Khoje wrote:
> On 6/22/2021 5:19 AM, Jason Gunthorpe wrote:
> > On Wed, Jun 16, 2021 at 09:15:09PM +0530, Anand Khoje wrote:
> > > @@ -1523,13 +1524,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
> > >   	device->port_data[port].cache.lmc = tprops->lmc;
> > >   	device->port_data[port].cache.port_state = tprops->state;
> > > -	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
> > > +	ret = rdma_query_gid(device, port, 0, &gid);
> > > +	if (ret) {
> > 
> > This is quite a bit different than just calling ops.query_gid() - why
> > are you changing it? I'm not sure all the additional tests will pass,
> > the 0 gid entry is not required to be valid..
> > 
> Hi Jason,
> 
> We have opted for rdma_query_gid(), as during ib_cache_update() the code
> calls ops.query_gid() earlier in config_non_roce_gid_cache(), thereby
> updating the value of GID in cache. We utilize this updated value, instead
> of calling ops->query_gid() again.

Uhhhh, so just store the subnet prefix at that point then?

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index c9e9fc81447e89..5c554ebd000e89 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1428,8 +1428,8 @@ int rdma_read_gid_l2_fields(const struct ib_gid_attr *attr,
 }
 EXPORT_SYMBOL(rdma_read_gid_l2_fields);
 
-static int config_non_roce_gid_cache(struct ib_device *device,
-				     u32 port, int gid_tbl_len)
+static int config_non_roce_gid_cache(struct ib_device *device, u32 port,
+				     struct ib_port_attr *tprops)
 {
 	struct ib_gid_attr gid_attr = {};
 	struct ib_gid_table *table;
@@ -1441,7 +1441,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 	table = rdma_gid_table(device, port);
 
 	mutex_lock(&table->lock);
-	for (i = 0; i < gid_tbl_len; ++i) {
+	for (i = 0; i < tprops->gid_tbl_len; ++i) {
 		if (!device->ops.query_gid)
 			continue;
 		ret = device->ops.query_gid(device, port, i, &gid_attr.gid);
@@ -1452,6 +1452,8 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 			goto err;
 		}
 		gid_attr.index = i;
+		tprops->subnet_prefix =
+			be64_to_cpu(gid_attr.global.subnet_prefix);
 		add_modify_gid(table, &gid_attr);
 	}
 err:
@@ -1484,7 +1486,7 @@ ib_cache_update(struct ib_device *device, u32 port, bool update_gids,
 
 	if (!rdma_protocol_roce(device, port) && update_gids) {
 		ret = config_non_roce_gid_cache(device, port,
-						tprops->gid_tbl_len);
+						tprops);
 		if (ret)
 			goto err;
 	}

> > And I would much prefer things be re-organized so the cache can be
> > valid sooner to adding this variable. What is the earlier call that is
> > motivating this?
> 
> During device load and when cache is yet to be updated, ib_query_port()
> should have a mechanism to identify if the cache entry is valid or invalid
> (uninitialized), we have added this variable just to ensure the validity of
> cache.

Unless there is an actual user of ib_query_port() before
config_non_roce_gid_cache() that I can't see, don't bother, returning
0 is fine.

Jason
