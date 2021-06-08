Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E3539FE75
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhFHSGJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 14:06:09 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:22145
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234120AbhFHSGF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 14:06:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQqqTyYu0/y6Ua03hfn+OmBM/23xAHEkGaD71TtzBuIb/C1mKSEe1vKKltTOhS7WwjOOLkXBXLJinDrVD9d+9s4h8JozgLzCSd3rGnEsmvgH1AG0kktBEYMt7zZdLRH1wMcOdsz5QOL3ocHm73dLSPGvyonxyw/taB2+FKpVjN4hgAekMb3DwjidnD63GgABfRX35FlR0zpFGoVt1P2Aa81IMGVvCiRzjh7geyld1WDy9pzYZrRW4vCZMCChB2BD8gMdNxgy+WQKoG1p6oSnv6WD7JFfSyVgCPT5nJi31xuJCCbMo/UuUMbWA6JedfrWHchcMI2ILAQbscScvgAXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6+LqvU3qB7kjHdwrWXsVFeqpUYCwgbM5pBJQoLZ9fw=;
 b=BlYOdcu62U1zsUH+fdYUvQe8KhVCEqCj/ktI7oGdiH1ONwXYdre173dSIWXovU/Ny/ZYF4RqXH7u6Vuio/eQCtHQG/St2DZpdJ4gj+AliDMK0AAUnmoapj/4wsN5ZFi+CsPc0Rm+sifrwUfcsZqxq95zDRaLA9R6YtLeyZ/jefhitQQ6SCGLVXrcALWuYHVIyG2zEzaptDDFScgKhPjEm4cDNE2nM70tB8kiH0EdbX/LStWTxe/d94qjZoIWmIT9Pjgk0HQXfNW27ca19QFNRlGZn/QNgeUP7Z8VRWZu2SLUxbIR0CtfIPc3O4aCFvzo5ry4OOu5qBwdChnxd9OUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6+LqvU3qB7kjHdwrWXsVFeqpUYCwgbM5pBJQoLZ9fw=;
 b=KAcbLlAdKMSr8gYshTDsuxsDrJ6tZGV5GowkjH6hWmvwtL9pLCB280A6jZQJYfketcjsXiUbgR2MAULvzPUNM3qxafbkrEX1n/83F04hZ2k0mavKGsJKXINJ0LELLoru0IA4XRgpghpjg1QSwXXIIfQGa1Auh1s8dIadhgxlwMe0NXtBaY+odcNsvxpXgs6sizr7sJwVKQVVtETyxSqkxcm9KapgE9bJXFMhOlw83PB/x5bSWKBuvbuL37xJ/9h25rkx4DlllhAeU6yFujNHhyKXSLxlw5Gh+u+CIttPBQfCjxVkwMLjhEkxHqLIWWX7Pexd3LNi2RqUr98jqH+NKA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 18:04:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 18:04:11 +0000
Date:   Tue, 8 Jun 2021 15:04:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 03/12] RDMA/core: Use refcount_t instead of
 atomic_t on refcount of ib_mad_snoop_private
Message-ID: <20210608180410.GA977963@nvidia.com>
References: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
 <1622194663-2383-4-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622194663-2383-4-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR10CA0033.namprd10.prod.outlook.com
 (2603:10b6:208:120::46) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR10CA0033.namprd10.prod.outlook.com (2603:10b6:208:120::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 18:04:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqg5C-0046Qb-J3; Tue, 08 Jun 2021 15:04:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0e67852-fc6d-414e-c17b-08d92aa7d1a5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50306DF46A6213CDF69C2325C2379@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onhhhpXZG7mfnFoigPG8b9/jEcf763cktVgYaBWqedditr8VeUNIlgry8fYTIvUwBZqR0VTBy87DpOMP1n6nBzgaASWMgxA/xuRzbvecQULhiUB2cmuNzWXTpFOO8vphf0/YrBWP97E3ADU/bHuyGajpHiviaFwKtgb96takmgAFVUXj33V++4TT9V2lvec0iu7kwhAVDZtYFHCIqHV1YVUjkHvLlSq94GuQDhyf8lHJHZQmaRNmDCAvspWT7d5M2jeF2n9P+usO8V+luS31NxMq2ewhn71lcsBwMVeVjV1wM+CkRBn0nP6aWbiBvtVBu/22Rm7Q91lbEBXES5a3kmKnf7DlGSiTfgM7ELad2f16dNQ/NgwVXHMWQbHUKMVhnsb752TyJlFjbHe6bU2qIzeyY0AGysPKWd7FmA0cJ1XSBld83gc5Dw5sJGBe5nbdA8NiRzWuW/y0pnjgcDvq16zfdn9oSNQ6wUTFMFX7QI3RHRZDxVvw8hchoYRcVA1XVQw5AwbBhYB91LkeMoVflYy/qA1uQsQ+pMrj0e5hqaY2feAztTP9CWq/ObVjUERiyTwAQA708FAt/7fv/VcKX9a5rS+xK8I6XUhDz4nmEhEudP0gq8KuoTaV5vMquHUwBfK/NZrzLmQg5EHIBbxTzHjTFfxGv+WRdePAsI4BfT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6916009)(8676002)(8936002)(66476007)(478600001)(5660300002)(66556008)(2906002)(26005)(38100700002)(86362001)(1076003)(9786002)(4326008)(9746002)(316002)(83380400001)(186003)(2616005)(36756003)(33656002)(426003)(66946007)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M9ecgs4Pg/pUHWlP1PhJ7VEpklMdE4iUrtWVadYE4fS73UrIeeZbgGudJWzd?=
 =?us-ascii?Q?9DpqBpBZsk7FnApHOrqQxefvOfcxB2MLUYdl2JmYTCVVAs3fbZAR457kkyv6?=
 =?us-ascii?Q?v9RT+VIp2Ez77EXHrlJ18ZCSyVguP2rBsbVZ46Im9Qou3Q1quFXnSDI5k5Ry?=
 =?us-ascii?Q?+VuriJoMGw/Csm5D9o5gPS6lmTBVBDGVH8hq9fD6sqbNIT6vmcTAMYGd940d?=
 =?us-ascii?Q?uov3ZDjEf19hnCYVlISj23BOb7zHsMwyRB9qsRcaciO44iOrmaq8R3krECC6?=
 =?us-ascii?Q?3VEqssFOK1Qhqqx1DTBRT1qoTA73TB0xp2ugtpHo8Fre6w6QvQ+g7sVNTVT8?=
 =?us-ascii?Q?idVOFkzC8+QEmnHKlD+OL4Bhfo+DAPdsuj0IYjm9BL2/A8Defic2/IAowdAh?=
 =?us-ascii?Q?bb/akzWKA5hyI5GFnb2MeFut80JKrz20FDVWAWGOIgRDWBWLVQ4vZ9pRXsf4?=
 =?us-ascii?Q?rN9QjJiH9vGNW91ZyHZuZesKdE5q61LU6CWtSEPA03bZvJBtC3jvUsg+8kW4?=
 =?us-ascii?Q?M6wnqcx2nljCjFitcY4VWdgvoIR85B43HRDCJhYziiL9iYZyEHSxdhkiFRpW?=
 =?us-ascii?Q?unoJO8xlFE6D0innELhQQbLSOvEfYnzGuxYDSl1hKKY4xx89saPqvxyZMbxW?=
 =?us-ascii?Q?KFTWFKfB2zxH0qlVNaldjsFYY4w55QR2FRnj7WiFfe+p+wHzXT53f2hWYwkh?=
 =?us-ascii?Q?CX4UGAFyro4QZIF0A7ToeVYwdM3tX763R6xwAqBm7JowRyRm+q8S+ejhWkd6?=
 =?us-ascii?Q?TRwCSalhrxsStJ07ioG3rSjuN6F/F+zFZiEr8i88CW+tXWURdNOSYMAwums8?=
 =?us-ascii?Q?OUgoaegay9C6DjaanxL/uOeQsPhiRjxWttWor05aoqgO0AxqeRc+0aow7pK/?=
 =?us-ascii?Q?yneUEw1Tvl2GzVwowvOl+gEqk/iyWIimNo7pqC2uMgf09mM4L1dK56Yx0R/g?=
 =?us-ascii?Q?FOnhIgiVK/6jv0MfnQtUm6BwUFBfkcb0tW0wPSRNZVS830uz4uVLCm7XbJIF?=
 =?us-ascii?Q?i6tQ63UMMBUUzUtNEPV1bvo2iBFN0DzbkUTPW7+xXkCCx2Dib5Sw0pEYNSof?=
 =?us-ascii?Q?jHQbI30Ab5bP3lok2WvmXfEIxqWU+1nDzs14UdL8Eiye4b63QUDFHexTvn2g?=
 =?us-ascii?Q?lUnMbjddRuE6tTpAwqohj61QCqxqDQkTeJ1Q6n+P3MPXG+gct2eVQsi7GxbG?=
 =?us-ascii?Q?ne9C20ZrxbWj5kRMrb3kfmmai6rCIQQOBt49oR4eVBdnB1bSLU+zddy+XStQ?=
 =?us-ascii?Q?v6Q/tL5GyjvI3uyiGy9PSjYwVpu5vY2PGWOL/jLRNm+vxOKEW8WMXTxapukA?=
 =?us-ascii?Q?vOnP4GK+ohORwdyHZ+ku+XBf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e67852-fc6d-414e-c17b-08d92aa7d1a5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 18:04:11.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iag1rh4bmJU+QYc6GlXEGhuI9+B6H9W3OXOjhnEgAsyXBjp3Yqqka1wxqR3yU3DS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 05:37:34PM +0800, Weihang Li wrote:
> The refcount_t API will WARN on underflow and overflow of a reference
> counter, and avoid use-after-free risks.
> 
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/mad_priv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
> index 4aa16b3..25e573d 100644
> --- a/drivers/infiniband/core/mad_priv.h
> +++ b/drivers/infiniband/core/mad_priv.h
> @@ -115,7 +115,7 @@ struct ib_mad_snoop_private {
>  	struct ib_mad_qp_info *qp_info;
>  	int snoop_index;
>  	int mad_snoop_flags;
> -	atomic_t refcount;
> +	refcount_t refcount;
>  	struct completion comp;
>  };

Since this is never used I changed this to just delete it

Jason
