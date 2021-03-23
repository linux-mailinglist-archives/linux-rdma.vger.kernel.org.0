Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B48345417
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 01:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhCWAqb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 20:46:31 -0400
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:33121
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230453AbhCWAqN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 20:46:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch6Ra0AZJq3d8JHVsLklDIhImNWm10P1evIxJ+OqYq7PUbA6un99GnlLlP7cpbzxJAvyeqsmWCGETkbWNn0InvASGy238FViCvwUVny/AMp51eW5ejLIsGtkQpWzXwxUo6U9ydGYUu7S0jm1TaiqPzz7be+KQtPPh4t8A7SvrDrn6fL1ZT140IgsZqeeZJXg3423X8oduLdpfmudUGmh4+i2bR+VECX0CIGLbhawciJgxzaTcYbKMg3qyiAb/QVp2N6cuXMBhLuobAvhH/iZ90qR3O3rZ3dhv5I6EveZiyeBTsOqlSt5L95I1vqkQjvQ6cbgS18BHIdHYxnT136oYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCOprxDO65eF3UHeCwgsmfTIZiBY2sIATh+4ntsuP48=;
 b=J0BDzyPEDCfsElUlNOkTQLBml/J8r8PLHNy8ND1mA3YaQabYJk9mh6gECdJKjAkIdcKhiojwMK0EBrz3TwuVrU0GMc3dCpqE1rU+wsZFQ8Toi5Rjh4qIXIVemIpGHLEMqvj/T/5E8RR6/Maos7wpZEUpmHAzxbG6bD38+xEhTOvRF7nYeQjXgdFjAH2sIGa32oWCim+tK+woGkrj7wsbXopuYYe1BwDQANjF/ZgJ8hCJT+v+d6e3Dsyz10lLBPqRNFvqbmU3AwCoVlB30VqY6mcxcpuh/p3tAOLIWm9fz0hsF8U80Ep7mVhpkn1WjwFZIGeJfabBCDiESecQhT2Zkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCOprxDO65eF3UHeCwgsmfTIZiBY2sIATh+4ntsuP48=;
 b=RDw/l5JLZBsXoHrmTq0rbsvM6P3e2tdcmITo8spFsbnKV4mFBAFIvb9+9yzig8TqySEg4VVmi9Z0GAZoZuRBbOshth0hHeGInAzZqTUyPng7cQrw5bMIr2URNUKXRw9qPB03Xpqoz3sOM6KBZej3IAoDJkYltf24dxdTdFv4N5lVvArURuvW/7L4Zt5X8fhwTpDBXuSON29fGn2pfDq/EwBV50/XD5WxEydXqY0UQrm5lXDLigOwomaxC8Pz5sn69I6sg07rq0RB3koZYd+vNx/9sP7KivkCJWuco3fjnrFuTJbE5RGKDsZ8s1MUHMo33IG2A6z/tjcGqBt/Pvlc8Q==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 00:46:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 00:46:12 +0000
Date:   Mon, 22 Mar 2021 21:46:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next] RDMA/hns: Fix memory corruption when
 allocating XRCDN
Message-ID: <20210323004609.GF247894@nvidia.com>
References: <1616381069-51759-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616381069-51759-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:610:ce::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0168.namprd03.prod.outlook.com (2603:10b6:610:ce::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 00:46:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOVBR-001HZG-VK; Mon, 22 Mar 2021 21:46:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afe97e6d-134c-419b-0a0e-08d8ed950e21
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB020305E358602E749C627E41C2649@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoG2JoUAeP1YpqSroZLm0xlABWzVJsH3VLxozczHhyZesz6nqHBijzUa93i4Wxsk5rh/RlIbDeO09C10jhRpi0OFr9rx6+25KOfy1e/tmjSNPnshaS0B/5+n7PKUkscJcgRH6z6g9WfmoQCt6RH0YxqZqdMNIUKN3Zus/iHl3iHTYCbd8pfsqRvfbaRdLTYkT0zyw8oQ0RNCFC7WKLqV5njCY9qwjXaie+IQBFmRlguy3o3ONCnWyxo+sWH+8+xSt01Ydh20wibVW4CSQ80skliLKqxljpfaye5KccuKtXt3QqyIge0vFku7/R6BnPex2rboESVmANnbkjfMj7HC4FHxZ6Kb43nGs5tf6MBkRbYTNOV4qpspi8pRR7pUCI65It46oWMLvZUYgP2MHx47jc6ypkRQlyOwoz/0s/0alrHLNkFj28fh7dYDGYV060EyAwbDw6DJ9eHFbaJT/ga06bdRw92wTACkyWY2Ya8doh57m067iYJmSQW6tg1bZm9TtutOWZT4JJNopUfuq2nu/NlXTql+uHjf6pKiCx0FfBQbzzN8A2yA549h214wtNC1PKvkvLCM0khCmM4J6EFxUbwtYQ31Jk+UI60sm00iyJixhoQc48nznr8LFLSYk0ccalTgTYCd7aXxSiVu1D/7wyT3TgfohTQLdBtKUWXPFaiV0kT8av8Ob7Gj2TRgeVA3vveghho1v5MhA/SCBfbDU3I0jeiUECchnCiUy8zxT0FErCgJhLZa/zsdfdu2sywMSLJ3OQ/c5AMuZzVGZc8xrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(36756003)(33656002)(38100700001)(83380400001)(6916009)(1076003)(478600001)(966005)(316002)(2616005)(4326008)(2906002)(26005)(186003)(426003)(9746002)(66556008)(66476007)(8936002)(66946007)(5660300002)(9786002)(8676002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SoTkzxl4fI5vqlQag5742I3Pgp2Xr7XXjhILdaGAba8vgeBIhUgF++WQnjgo?=
 =?us-ascii?Q?8gguEdal23uG32Tav56peg/yZKcCqwCyJMIiMqIKPu1Rf7/kHOqM82Kq/IjN?=
 =?us-ascii?Q?Gg90xoUaulab4aJslQjSIx141nEm7kulp1dYU8E15gVcKbLv+L9EDvOGfbAu?=
 =?us-ascii?Q?qHSOZlb0pslKyp8L9MyN4mc8wt1HTUwO9FLfRUudI3MdOrRxrwRuBZvOTKRL?=
 =?us-ascii?Q?O+VrkhLya2D7xT8+Pnt8VRgtTl2DEMljdkh4LT1UIh9f7GHklPMsAN/DrF+V?=
 =?us-ascii?Q?J0t1vpYyapsYupCPAJLvnhsJZWJ44XO/MXak8LMHPG+bqv2C7wi/APZJhGFT?=
 =?us-ascii?Q?NvCFvarJlelBq725Vx7zAF81qBPAcT1h4BMJHId1PeTut/yKn48KHua0phZo?=
 =?us-ascii?Q?+4EqrgcfYIvrYH1ZngYxZkKH2cY22nE5puqnbm+d0P7663wkcBzvqiHfr1Z2?=
 =?us-ascii?Q?8bpgJbajRq3DthZ7gPPz1KauYFu1CVOs6WH7uz8F6NDAnXTo78kubAZe13jN?=
 =?us-ascii?Q?XObBN3MshLZaROhVGUIXlkvMspIrtNA788sxz5OfHjP1eK0+YdBnEPwtTRXV?=
 =?us-ascii?Q?QqV7QE84sX1Vn1FXe0zoO5oYjcKtuzy6JproTBNbu6nxtcp23CG0dFcabUH/?=
 =?us-ascii?Q?3GO9AUt7q7t9SKh1FQl2TTLwr0CcmryW2GXpQYNaG3g3Ph9lrWVWfE+Kwl7W?=
 =?us-ascii?Q?+eBVEn0mvPbmc0IulM2GE92GmfrwYl9Y9N6p6rsFqeYSCCdFXDH8Ah45oWEB?=
 =?us-ascii?Q?8ek355NRXPn7iMBJF6cSIbLIKdyN8NIkcMRZdulatXMazxejubpUEjsBhWuT?=
 =?us-ascii?Q?7hgQx+FST1L9UfMqtSWmGVKl2BawMWnqck0EUcxOO2iGadvrkerzwPD8/hK7?=
 =?us-ascii?Q?V5/OlBxuj9/JEfrHXW3+PK6evfyjuHI+1sZ7b4bzGw86zl9pI9a1zQ9t30aZ?=
 =?us-ascii?Q?5b4de489Q32uCqTfv9K1DErelydQPhtLqcv03r1Ppfai8HZ1VdiFrgeVxn/Z?=
 =?us-ascii?Q?dmTEFglrWulAsC7vR1giCW3IRYYhRAaV5esqAdmQFuTlolkJms/Un6PuyC2D?=
 =?us-ascii?Q?+4MJ/L+OJMK796cBiM4J6Z1FTrGW/i8z8Xk36nID5YGwVkWneNceAJEykNsK?=
 =?us-ascii?Q?BBcmsK16DMfkDP3rBz1aL8md1X2dXkpnECBth1gPFTwMjblo9Y7cvx9az3iP?=
 =?us-ascii?Q?i50pMhkoywRmAa58msU/4vzg9RlwFdq7eH5e31uSx/8PozPKkJh8K4BO6t73?=
 =?us-ascii?Q?8mLoboaZhoNObCWq2COPy/6ZQQSzz02I1td39zcjAzqGY33Wtis5UJI8CZI3?=
 =?us-ascii?Q?Nr8XVkdYoehnTdMP5iup5xct?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe97e6d-134c-419b-0a0e-08d8ed950e21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 00:46:11.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eEKlwAhqK2cOPBUkV85oQ3PouzFhsjUBzXmZKgqsK2fv8f+ZxQkausUL2SbtSiZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 10:44:29AM +0800, Weihang Li wrote:
> It's incorrect to cast the type of pointer to xrcdn from (u32 *) to
> (unsigned long *), then pass it into hns_roce_bitmap_alloc(), this will
> lead to a memory corruption.
> 
> Fixes: 32548870d438 ("RDMA/hns: Add support for XRC on HIP09")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changes since v1:
> - xrcdn won't be set if hns_roce_bitmap_alloc() fails.
> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1616143536-24874-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_pd.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Applied to for-next

 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
> index 3ca51ce..68a59ff 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_pd.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
> @@ -140,8 +140,16 @@ void hns_roce_cleanup_uar_table(struct hns_roce_dev *hr_dev)
>  
>  static int hns_roce_xrcd_alloc(struct hns_roce_dev *hr_dev, u32 *xrcdn)
>  {
> -	return hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap,
> -				     (unsigned long *)xrcdn);
> +	unsigned long obj;
> +	int ret;
> +
> +	ret = hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap, &obj);
> +	if (ret)
> +		return ret;
> +
> +	*xrcdn = (u32)obj;

Though this cast is useless, I removed it

Thanks,
Jason
