Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41D334AA4C
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 15:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCZOkc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 10:40:32 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:2689
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231217AbhCZOkT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 10:40:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJN3sowUoAWPxX91Rj/V/DFkg9t9BUzmdHToIvgV09yvWZ25MrWZsitoUnZ/Yq+DFfyA6CjakAWcFT/7IFG5/Y+Lc6gyIuMUM5pR2XxnJaE/AsoNI1E9OY8GcR60xOHPnWv01nprEPBvplFXDVvBLUsOL7kWLpPz639YFgH8bfKdHC9SlOqS+iF6iUH3xD5fll13scxKfkl+JiRuauu0zqg7+stXg5HCreH1vA98OUyAupzo1iC9DIwVMOqyIPMZq3dUymF5NxYT6lO22cmJtsHkTY2zmes5ezXA6vccY4kWEgHRxEM/GugbAzxoC69v0WbJ1l+Ds/88XXynZBeexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccKu0utaXwRIouRszeuEclKQ9L/VNDgsM6huKFK/Rkw=;
 b=iKzBhBReWHdV9aF0mQO4jTGznyde0Se+6zWE7/K/W3Ezc2dq7Kanf+fZmU/ZVSvsfCWC9roSks/7IL9wA1E3TdUhE9hmcFn1Z8ccOFKSpwo8G6QGVf9c+gSdu4tl6o1fTLuhDWl6X8YsUgDhWwNSZ0SblAlHk7ciM+35D/yAfib1o4tJnqcntSODMnbza6jEyMDMR+m061sAJlGrh8Ly0COFIJ16QdEQP4jicl/e24re+dJUp2oVR9AlyweETEniEyPcMvnlYSExy2LOjI+eLpSYcLuxJG0S5+vS6M+NvTnvuk9fdH2UiOoZZIkP9kM4f1a2mYEjfBkIzuIVJ7lPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccKu0utaXwRIouRszeuEclKQ9L/VNDgsM6huKFK/Rkw=;
 b=oS9BmwcQi2UawLrte9ml0uBvJqMNAYyBZ1Tg5oquQ/4JaoVUCFI9SRfxoPJlLbPP8iy+CScSlyz3qMAlj7+Xw7RpXxfPWWZ6mk2yuD6g57MGRCttGTgpOKuET17VtJdLVnUOAs4LPv9F8ZcvZXc3K0bA1MWCKtNrJi0eNnAkIARUkQFEkYKTC5UUZauHlMUiZ1mRlMPCaOnSqqg/owrWOrmQlz1ltXYvQ7NMGt8G/65JzmODJhNqSv1M8AyFJhnqqy3rq6akEt9t+DJas99RagmIICiYpMsnytoPwarDQI4HsxfOwfD4wUJXIGlSi+sLM00YoFIQFY4eDVsaa5xDzQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 14:40:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 14:40:17 +0000
Date:   Fri, 26 Mar 2021 11:40:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH for-next 2/5] RDMA/hns: Reorganize hns_roce_create_cq()
Message-ID: <20210326144016.GA844532@nvidia.com>
References: <1615972183-42510-1-git-send-email-liweihang@huawei.com>
 <1615972183-42510-3-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615972183-42510-3-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:208:19b::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0069.namprd19.prod.outlook.com (2603:10b6:208:19b::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Fri, 26 Mar 2021 14:40:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPndI-003Xid-89; Fri, 26 Mar 2021 11:40:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 671fad41-007c-4976-3b56-08d8f06512f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11483593FBD474D3A250FC60C2619@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06oSZXTegnaxE6MiBEEow8K3Vz3rNifuP1IFAzpPIVvrM1kapy5k0DcuLcoxNo74dWiDCJiGzk3vt+uFBmQ21gIuttxwNpvk6txOwYBW0KOBI3PMLbH0JQK/cKDT1JSk86rTLF0dEK16goZztRJh1E+M0PPfYxWkAFdYyUqFkJ+VtZM6LMUExwIR1oj8z8yPJMiGSxBPm3ebwz4hwGsgeYOQ++TvD5QiHkMz3kN7UAbHAqO4+dOecW93qYVdAbxi4WCdmXeDngdHce0aRecV2j5MaC90fcjXtKmb7Uj30M1J2pG8uXoQqK44BLOXlikhtT6jiZHsEz7w3bgfRzPLdyOHGuIBSj38jZ/PkD8xHYZ/X0AnIopHJifj6ZC1lBzcJ9a8dM36sD+BMcgrt3cpFkvkFGIA2RGUtZDExtRsSx/7wO3WlYLiepZYjG5fQl/f6iXMGbmXJk3Gczh16W5O7+JS/EmBmMkKDDZ3oAWWG8P4G4j8Wn0LtlSuAHowmvFlRkqvls5oiduOIXgk+HcnJcMa/fLFjQEHDEX08d88Ix6vZJnlJ/ynvoNKB9Zcq90G7c+BCO5JpqgRDIrVg3XAQnJqo11hmHfg11jJdvrJb+3McXgmQ2LuOcguIZV7YAMoevGplAe/L5nwb0HmyZ2EVm/wPX6iZoVX4fQu64hqPeqCd0XWiBCx47v2eDjXNIzq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(186003)(33656002)(66476007)(5660300002)(66556008)(36756003)(26005)(66946007)(38100700001)(2906002)(1076003)(6916009)(9746002)(86362001)(9786002)(2616005)(316002)(8936002)(8676002)(478600001)(426003)(83380400001)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FcyfXDCsC0BhNNjiJNCTilGrEPkiSoZ3j7eJlVcxDHhZnrOmH4O2FAhbsX0P?=
 =?us-ascii?Q?of/udHgzttS6Y/Wa+LQCXeplCZpasCzNbLiqSdOTqBU7CIJ7RrQS1bTZ7zr2?=
 =?us-ascii?Q?WJ/VVeDJx5T7MmcKFbaRPHy/dWbvdkBD5DYX3VXt7I5RkqKmpXYJEmBRnwMy?=
 =?us-ascii?Q?hjez1PX1u5A7E54AQO4GUVQmWXKpLrxDfZ4MAeXGnacHi6QAwZt9A18fgQVi?=
 =?us-ascii?Q?h2ERzX/xG8ANuqkW7alZgSctO/BeklRj6esfkhBsZSwhY87QUhvROcf6lcVC?=
 =?us-ascii?Q?hyoy2EDFGvKmhNon1tUOwLmMHn10Rm4Dn28uXUWcIazDyi+WPUxWjxQg7uN9?=
 =?us-ascii?Q?D8S061nHy1FXWK44begmPuS7TyUw0tbItBaVia0qN+PoaUAeNxIIGhW52dZA?=
 =?us-ascii?Q?ZLBSg/5FC5PIQKavtBapeyzAnMaaMCYBvm7mg2GPCB/aVpHWoYmkMVH4BRsY?=
 =?us-ascii?Q?UGBmeLelqOeEWjOJ8DW/Ee6muEFxdqKmr/pcSxKtPUyqxzFzU0090whrJ83q?=
 =?us-ascii?Q?5pqv/HNLcl54FAtPDl8Lt8LZgDH/tg8rnAszLy7MPy6f8fKcJUazsUXYphrn?=
 =?us-ascii?Q?b5/VVXXWjFmJlNsZxGcpv0jxKSXYQNnvf0YkHeVmzdRa1NfrHbn0y/tk43T9?=
 =?us-ascii?Q?Ernx7Vl/4GiikCce9OI9ebTjmx7TWPUATee+SwDoGzwHAl3hGAx4XqKH/DBb?=
 =?us-ascii?Q?jJIOnC94jsDOL2i2Iob6A45OW8W9RvsGo8w3pBsSB9DsolEcU2w5bHQBp0GZ?=
 =?us-ascii?Q?+caSz7NysTzZTdAfsRRx+IqQT2h4onsnczBq32a6GcV+lDkpDvZdtc5KSTLl?=
 =?us-ascii?Q?jfMKf9Tg1SWmpWBc74RX3tnDgCyHKVxIy/HJmVgJ/Beg+hNMDiFv9uKJDpme?=
 =?us-ascii?Q?WiwmG1Sm7s/7MsvNcjB+w8DqlWCBV3L43KjJq49bab//zu+ebgi9jmYgagsm?=
 =?us-ascii?Q?gpwj34eElAkpXnqXWXSz3pRNQvYzwvAQjsQOXfzpIUbELWicnwHdPKPzdow2?=
 =?us-ascii?Q?C1rUmrEALq+PX6P8xTy1W5qgsIGHG4lvnBNXqiU6NLkJBpn0m/uL2fts+kPa?=
 =?us-ascii?Q?zm4Gg9HmoMc5mUaz4kOK7uIYuUCI6q1HxqYUWkgf2Oy4Dmw90WOpkE/HDcGN?=
 =?us-ascii?Q?C4nmE/nLNguvyd3Xzg2La3Gbvq+OIEtpHWcmXpHIUYn9ihFNqJBW4NvnucFa?=
 =?us-ascii?Q?k7O2bKCRya9k6JPbceh60i8fuxqxwOdRdU59KjVR5QXNpc/TFQ8UnKxmdmha?=
 =?us-ascii?Q?qbyIsCvt14qj/0AkYZFIDJf/8WE759Me6clMSIj2m+mqzVIK8Co7rCIV1Xpo?=
 =?us-ascii?Q?F2kU6e3jzv+os8SpgNTNCGPzRnEDZxEgF2oPpkBF3honpg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671fad41-007c-4976-3b56-08d8f06512f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 14:40:17.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzBXpuB221GpNPyhX7Mdv/QnT3ngSac3IDiIIIIHeJU5weZhnZTskyvaGthTALFu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 17, 2021 at 05:09:40PM +0800, Weihang Li wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> Encapsulate two subprocesses into functions.
> 
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_cq.c | 87 ++++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
> index 74fc494..467caa9 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
> @@ -276,6 +276,58 @@ static void free_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
>  	}
>  }
>  
> +static int verify_cq_create_attr(struct hns_roce_dev *hr_dev,
> +				 const struct ib_cq_init_attr *attr)
> +{
> +	struct ib_device *ibdev = &hr_dev->ib_dev;
> +
> +	if (!attr->cqe || attr->cqe > hr_dev->caps.max_cqes) {
> +		ibdev_err(ibdev, "failed to check CQ count %u, max = %u.\n",
> +			  attr->cqe, hr_dev->caps.max_cqes);
> +		return -EINVAL;
> +	}
> +
> +	if (attr->comp_vector >= hr_dev->caps.num_comp_vectors) {
> +		ibdev_err(ibdev, "failed to check CQ vector = %u, max = %d.\n",
> +			  attr->comp_vector, hr_dev->caps.num_comp_vectors);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int get_cq_ucmd(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
> +		       struct hns_roce_ib_create_cq *ucmd)
> +{
> +	struct ib_device *ibdev = hr_cq->ib_cq.device;
> +	int ret;
> +
> +	ret = ib_copy_from_udata(ucmd, udata, min(udata->inlen,
> +						  sizeof(*ucmd)));

Is this leading up to something? Wrapping one function in another is
getting a bit silly

Jason
