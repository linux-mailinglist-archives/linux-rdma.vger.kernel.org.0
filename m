Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257194868C1
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 18:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbiAFRjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 12:39:45 -0500
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:19104
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242030AbiAFRjo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jan 2022 12:39:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLNh2aQFCitrpTFvch9ePJKbOkAq8UbtrJJCM2voi1PPPS/ZFlmKPGjFzWQXzpBjzrQaDRn14pMjEYfeZERAhaJOrfr9GotE/WasHOOm/2Vs1pcN2Tl3fnc1Jcvf7uudN0PU9bq64Pl5WPayr0cUxyQUMhqzOt1ZrjVZ9mAr4BdOWQb1kcuGI97yXgLgaR67nJIH7Q9ssBWnDcPoBO4f+Qs0H1xn8xa6WXchGYL+wUl2jVgVNHjBRuisQ0WOLZoYQ8UrAGRVlKXaKG1ktrLB1kwuevo1qAAGQRYqw7+1CUq4PyoCVugq0DdxbwU+kf05oN6POOruqC29gxM85Qz6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPhX/iNU2c544+YoCPwps9ijEdizx4y1XrpD5O4MLkQ=;
 b=ZURrKyPNP4KhWOditJiS774zmkK4hJeE5uD99RFtijUcSgfZ8F3Er9HVoRPC3xa2nskQmC/UbpKvwUGBXCpADjYxp0z04dySdDQWJuhb4mVh3lnZH3YkVn261wXGmFAmvAPOpQwmNp8JQmhpOjOdRAYihQaQ+wEZKxxyR28Hl/cUydbLiLFSP61X26YRyIuRye/A8pkFoPw7l521++h2ODNv8/eMShrn0U3hezMTiu9PH+7nOldA29BSpgNowsr0av8MhezxP3kGfWxCT7R7vvlx2PiTbEW5gZPWTm+KDCh17/m7SuAX7rTdBYRB2Nzg3D9xbk7vrydrphy4yn94ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPhX/iNU2c544+YoCPwps9ijEdizx4y1XrpD5O4MLkQ=;
 b=M1I+rfxDPCPgCN0GFNnqMGKI/sbxbjOJEQGtIJUSqjsR4ZlHdny+eQM/ogR4vqa7xzLiVf8ChO1/z7CV4WLoSjUIzl8XRXF1X33lOD+m0iubpWZCpmCt1JEZSscvmKtkwR4WzmHIOJ+Pehbomb2uerdKS94IbLUVv0v15jXYBGsfltDOzvT6mAP5aI6TXkCLClKnmK3PyJRHcwBCmYyY37b4kqOeZq+L8hkY2TiZMZrlIfPOtOVsWPKUTTEvpWYorbuISjQq1eJFw6ui9srTzAmU7iOXWTV61DJTJd8ofQAks9+RtvNFtubjFHHoiXlFdwYHQItxR8SwQU8+8GnE7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 17:39:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 17:39:43 +0000
Date:   Thu, 6 Jan 2022 13:39:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Clear all multicast request fields
Message-ID: <20220106173941.GA2963550@nvidia.com>
References: <1876bacbbcb6f82af3948e5c37a09da6ea3fcae5.1641474841.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1876bacbbcb6f82af3948e5c37a09da6ea3fcae5.1641474841.git.leonro@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88e8fde0-b9a7-4c1d-999a-08d9d13b85b8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB50963D2748E6B426B27D59A7C24C9@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U25iuxjbtorRiP0ZJoQPby8OKQAVRcrpNi0NcXZlMIYI8EdTfeCbyDv86w54xjOzkTIDTBsZoq+ELD79j4jx7osnYp+B6QDR3ERjLgAukCHZuGu9fbP9DT/MhQ4BQLMeFDrOd2obrGavMkNuxdZM0jvrX5eQvZtNHTNfAmPjV2Z2q/UXRrUNanKRukMhdK4+r0ML6iRR4UO5d872iCXTLx+y8S2AxDB8+m/srPuTmJlBaXV31Qh9fNEr1VZKiqCtBDrtFHTz7eY+PW8Nd1PUsPr+ozpGa2qnzLVXqNCc3enS9vy2+W6/lFX7FBqJRzdH8kinIymrPYAu6DtKMoLkakEITAqde5Lpp0EBeIcyPfw9YtUXxSJUfDn73+FKpXSgg8HKN9w+R+gYEQZ5vJ2+ZCa2smI+K0rdQ7CkJEf3UI9tRbigTMrKyluGkIni9oL2Cx1ClZnfw5Iq1ccRinYI+zrs/Yq5SiiQeC/UIu9EE2pBbjNA4kl/QOMZ+O5Vdg/FTj4XGpdji6pq9HjtnW/TNQz50XiIyuNE+YxMp8vjg/9B7Q+Kp16aocNmK3ibqC0jEdURtAhh/1S+5dpo3q+/4hRzj78VBAmtix9KInmpwivdlU6J5WMM8ZhEELJ5/SKCUqw21U4JQTh2ocnXyj4pjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6506007)(6486002)(2906002)(186003)(26005)(66556008)(33656002)(6512007)(36756003)(86362001)(66476007)(8676002)(66946007)(1076003)(6916009)(8936002)(83380400001)(4326008)(38100700002)(316002)(5660300002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LS2+c32TYI8A4XDgvnCpb688pfSp0aLRQY2bKCHz9l6m5SW0M14rN8meo7UH?=
 =?us-ascii?Q?uT7pCTXkBOxKAh6jT6LwMtBGtd8y/J6K8YrY3VHhFF9ZqXAWDGOe6/2IjTbP?=
 =?us-ascii?Q?L4pTukco4/pLDabzxmAKdIBU9rFXVz0K1IR53tfbRJ4yaaF6rD+8CmOKvk4Z?=
 =?us-ascii?Q?O1hVOCCvVTRtBzlRcMkYyRWjWheFDgnvnFM4ED9/v3+7hmYwBXe1gfqJuJi1?=
 =?us-ascii?Q?QSJWBZO1uRORfAN9NFE9Tq9PW3yn1SnqHigTmgde3k1mYLSu4XOoJy+j2AC6?=
 =?us-ascii?Q?8ZwYBrknYAjHwg22lf1zYPyl8FhkpdQQzziFOylvuk79NVqVhHRt7Yfnjl4u?=
 =?us-ascii?Q?8XX98KZg13FLqOKcH3SLZ/RKxssDNZ0pzMj1k1wmihYlK455DR5Vq3I3Kxn4?=
 =?us-ascii?Q?WUZoZ4Fpl2PKVe3Vk1rMcRXyQvD2O2GpaJUjRj/YQbJoKX8zrehzfyM4YMLv?=
 =?us-ascii?Q?1Qoa/HuVdlHh5KzcYPNX3bshObQN5cFZz9M8C5NTGRtb+StBjw94vicfof1s?=
 =?us-ascii?Q?hfkd63nt1PZ+zrzdIJMXbXeB0nwLUXfy7tP0jsaesrUQwvm0pXSpsatg0d2I?=
 =?us-ascii?Q?vJOMgMtCEahUqASCjtNG9xiuLEjQY0fSUZEwePO005ITsdnDQ1Teq/gmhrIH?=
 =?us-ascii?Q?8YDLNxAMr3VrFmv6LtreMEFRJSiFA7oxKDdxnoHfK0G73DMp2ZMGIKezAIQ0?=
 =?us-ascii?Q?kJlDc8uAfQO5ILlmX+5PpYxqr/EjngUcHZfmvJcG83je61Ra18fDeMFDR/+d?=
 =?us-ascii?Q?Lb+t4Vb3KewJdbiqiNBA0ODdDwSyWfaxnXWkYFux7I+S0efoQu5dfbTZgyVZ?=
 =?us-ascii?Q?Y+j82obnqkytB7c/F1gwJDOr+k5sf7SDFAr8T8yOM18M99MEwafw47IopTsC?=
 =?us-ascii?Q?Woy2Eif81fq4DpNtWov3EHDoKSIfOJwlrxnEqmIGqQCSU9UOE3Bm598HqwnE?=
 =?us-ascii?Q?sJ0oEHqhkHLjwn/kddUvDz42+4IptgGbk5Pj3DdwMWbwol4GzwiBy9e8cNzB?=
 =?us-ascii?Q?TTOgYJ/e06bSOIDqNr4emW1/oXvxM9d2ecJt9tWCDjlYQ5VIh60EkO3p9XXH?=
 =?us-ascii?Q?oYrBXDrmVo1fz7AlkzRBWRE8oXdk0kgHFxew0rfw+mQvin9L8flSpJ8i2rdS?=
 =?us-ascii?Q?jXKNUtwInIS6vqVfXX3c8bLgRxRRjq7T/aCjFwMb2wYV0uZwy3i2eHISbEgH?=
 =?us-ascii?Q?9kntAHeabLTZiaKW9ILgqCseXfAp7GU8uufH0WbbISR31fy9ZzKIgY9WYmse?=
 =?us-ascii?Q?zjyXnesiBu6MOzu14UcZHqWpwSlOuFrjo6bhDHAmp9SiSMW8WoSbe8LqMftX?=
 =?us-ascii?Q?Oi32W1gsBcCUG9UMO1no97x3RJqyhxFwDRq2hz3wrGQonumtD2LKte1o8Do6?=
 =?us-ascii?Q?4DvknJffncLIztJoSxhDFhYApf7mvbGT6lk16wVaEkE3LzzP1YlUlLjICTV5?=
 =?us-ascii?Q?5ITxM9lhSOvrbhn7jdErGTwKiJiGl2m6uwlU6nMW/cCKQPaUE55vUBXNmLql?=
 =?us-ascii?Q?E73w75s4gP5/uXsk70BRgeiqLvyftLSNsL8y0+IG/dAfxhFUrKzU3jnC8kIT?=
 =?us-ascii?Q?GxuDvHAvWkQAOeJjelk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e8fde0-b9a7-4c1d-999a-08d9d13b85b8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 17:39:42.9659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /irF11hFWpx2ZgMfNmH3j8qLIo5V+AZr4pcIUrZlJtHiEd2F+GHIS9RUXxL6n0rL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 06, 2022 at 03:15:07PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The ib->rec.qkey field is accessed without being initialized.
> Clear the ib_sa_multicast struct to fix the following syzkaller error/.
> 
> =====================================================
> BUG: KMSAN: uninit-value in cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
> BUG: KMSAN: uninit-value in cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
>  cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
>  cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
>  cma_iboe_join_multicast drivers/infiniband/core/cma.c:4782 [inline]
>  rdma_join_multicast+0x2b83/0x30a0 drivers/infiniband/core/cma.c:4814
>  ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479
>  ucma_join_multicast+0x1e3/0x250 drivers/infiniband/core/ucma.c:1546
>  ucma_write+0x639/0x6d0 drivers/infiniband/core/ucma.c:1732
>  vfs_write+0x8ce/0x2030 fs/read_write.c:588
>  ksys_write+0x28c/0x520 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __ia32_sys_write+0xdb/0x120 fs/read_write.c:652
>  do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
>  __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
>  do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
>  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> 
> Local variable ib.i created at:
>  cma_iboe_join_multicast drivers/infiniband/core/cma.c:4737 [inline]
>  rdma_join_multicast+0x586/0x30a0 drivers/infiniband/core/cma.c:4814
>  ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479
> 
> CPU: 0 PID: 29874 Comm: syz-executor.3 Not tainted 5.16.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> =====================================================
> 
> Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
> Reported-by: syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 69c9a12dd14e..9c53e1e7de50 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -4737,7 +4737,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>  	int err = 0;
>  	struct sockaddr *addr = (struct sockaddr *)&mc->addr;
>  	struct net_device *ndev = NULL;
> -	struct ib_sa_multicast ib;
> +	struct ib_sa_multicast ib = {};
>  	enum ib_gid_type gid_type;
>  	bool send_only;

We shouldn't be able to join anything except a RDMA_PS_UDP to a
multicast in the first place:

	if (id_priv->id.ps == RDMA_PS_UDP)
		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);

Multicast RC/etc is meaningless. So I guess it should be like this:

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4744,7 +4744,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 
        send_only = mc->join_state == BIT(SENDONLY_FULLMEMBER_JOIN);
 
-       if (cma_zero_addr(addr))
+       if (cma_zero_addr(addr) || id_priv->id.ps != RDMA_PS_UDP)
                return -EINVAL;
 
        gid_type = id_priv->cma_dev->default_gid_type[id_priv->id.port_num -
@@ -4752,8 +4752,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
        cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
 
        ib.rec.pkey = cpu_to_be16(0xffff);
-       if (id_priv->id.ps == RDMA_PS_UDP)
-               ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
+       ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
 
        if (dev_addr->bound_dev_if)
                ndev = dev_get_by_index(dev_addr->net, dev_addr->bound_dev_if);
