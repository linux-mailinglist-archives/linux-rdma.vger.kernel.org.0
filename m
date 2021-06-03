Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB339AAB7
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCTNx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 15:13:53 -0400
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:59873
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhFCTNx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 15:13:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diAOxVxYMeuB/99mUmaRCbKVVt0xsvr5/TJgJgLo0Vbno3uwYpMOyLj2iVAc0b1rtkTF1AyAoJYiQ5RBm4a+Q9TauCd28C6mstic0oehzPl1DVWhmsTFnVZq6EkmSul6m3vamRMXx6qdAJR9o2xyxdf6DkMWpOezQusxEHY61kvZLpF38zpFdq8Nl8h3IAVQ+vwtQseM4ozxDPI+7T3b0xXfjSYuV7d4O/ARX/XyaDkhtqmQdsoxzt/KJVxlRjwyP3f4niXE79GX8z6AMLTmaftNFxgZKLtPFTLDuVCga3oGbP4sRdJESqh8p3ssK+ptgeYKUznMp/I18e9lW7+oDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwGRroYZm4PGFZQ/4DcBo8R5LXTuxuR4LFatJA+dF3Y=;
 b=I5ucEgNll0GqtRBkZ1NQNiNswiU8B17lW9JJ1R5tGLVJqIaffnoAtjVJPSwH2rCm4CIURwTH9Nf+KEhwX/5ArpDK5/bCAvN2MNM58H5sXBjT5cO2QjBPIqEvm+v4fbNexF26H0DGTu9VB+WgdYnzKMI2vk3or4lWr2s/xdzH5nMTpWsnE4N+m2MBIh+7sjSYuoAisJBzhHS0T1ZT/UcZxymWlmCzRR44E2a8LqxPkeR61lxnSolzHUFzKCj3xCUBgY4ZhFg8/c6wikx/x18aF2lcOBhl5K0GoV0NNJscIrkFEvpuSBKNQGIgOTXaTCVa4eU2rS8ywJnQ7s30WRGxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwGRroYZm4PGFZQ/4DcBo8R5LXTuxuR4LFatJA+dF3Y=;
 b=Sqd73mMMDoVTjdUBSq9kOAkw9EiN1/Y5qNCK6/dHlH2uaLAVKCWdu92Q20fC/ahP5BcYc13PSviVpyTa0D7LWC67i+AeANsTjgG1LWy+phfQQiHSp1Kb8A6I7cETJ5nJjAYcXzLr70neqLPDiB6pneVr43desNcC0ghrfupuvFQ732Aek8rlZZ5UP5Wgvbr7wIhwDDp7eLl6D+T4j43yveDezhJYija9lugyhtPTEM6xxR6cIHgbBXL7Iu3DGTqSq7q+uHymGxjcCgv2cJrNbL8Bbl1zIGMOJ4KbzXcraMGzRA8rcB5M5BAEWNjivk0dfivhdKvMvwwRh5MD6xOg8A==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 19:12:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 19:12:07 +0000
Date:   Thu, 3 Jun 2021 16:12:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Refactor hns uar mmap flow
Message-ID: <20210603191205.GA318515@nvidia.com>
References: <1622705834-19353-1-git-send-email-liweihang@huawei.com>
 <1622705834-19353-2-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622705834-19353-2-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:208:23e::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR14CA0020.namprd14.prod.outlook.com (2603:10b6:208:23e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Thu, 3 Jun 2021 19:12:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1loslB-001Kxe-Fm; Thu, 03 Jun 2021 16:12:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fd9c9bb-cdc8-4858-e475-08d926c37a98
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52724EF56ACEFC04392DF3F1C23C9@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7JXMksy7Yca0R1QGwsaS7bi3OG2WygFJnlOTNcwoVJzYRo862nlWxZMBq2iPtPh0cpJWNCfHxK45x3IBSa3Q3g4AIfe9dwdEqIH6pCyjeGLF0/ECDeaZ2ohThW706yhMP3DjImNsftrIdSt4cJfHlaYFbUcMFVvbxokpffl/Inj8jZUn74i0ySLNHhSHK6yTKAjkReR0032Sfr4urQiClegnsuCXTNodcRWd/k5Dxt16g4yUHV0+rha2IwM9QHf5JpIGI4aas0kP00TZmkJbFZF7IshI02fYn2FQ4eUKQwQRRpSCw/Ye4k7COADJp2HPA++TY/u2lPO81ApHEtfmwz6H4FRta9Pnw6BdPjTSTvfe3ZsJN5+oAvJKfopGCypfwaB7o0PQL131e0DUBkcTCWqTpEMJWL2IOMHSxspPPu8xyzHt0pk+JGwBFl0g3YGRZMPOXUNOL9nt6ewJ/w7kjHYJ7PmWmAZ1WxVnsA1Y5McLBjCPSZYhT2WbqFOUAJCBvM8/h6X1krsS02PQQtvaDXmoj60YU3EY4uDg6Ev0f9W7R7hrNQH/WHe81XEQU+spDXQjwU+MxSAwwx/f46SUzmEOFX7i1Zi+9ojWapLdR7GUQR/CwBcy1rzTPbLF0H77/H0CwXJDupTxiCNDwVdj/EB08Id9eyElca8DrPfIAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(4326008)(2906002)(36756003)(186003)(86362001)(316002)(478600001)(83380400001)(33656002)(8936002)(8676002)(38100700002)(6916009)(9786002)(1076003)(426003)(66476007)(66556008)(2616005)(5660300002)(66946007)(9746002)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uzU3GKjeA65GUrqKwOmPI+PYNDjQikzfdbHD16wJa4NyvEnTvfSsrU+lD+0i?=
 =?us-ascii?Q?oAfd2a5hr2BgqeFa5sWOhJLs7g/2eakDFEHa2Qe5wd9L88C4OaO0q3M3yLos?=
 =?us-ascii?Q?IDhhEP1ukOmho3oVu7cqgCmHs1CgMvRbU4E5n3nlVORAltpbpQQ8q/Q9xuGN?=
 =?us-ascii?Q?crVOWfOQMaowJVMKbJUh5vRX9/ffo2Ax2qPOHYrL6N8/JRHxLT2AtGbQ3vXH?=
 =?us-ascii?Q?LpR8KOytul8oH+jp39J4fRj8okYtEAx1CEYbbjPzNanBoQ18nVBEV8yOPdNs?=
 =?us-ascii?Q?ZrnM98lGJp0iY97JI8MDJR8sIqYxOmaZNQEdX6JO/zA6xE37UgwmcxLpbNj2?=
 =?us-ascii?Q?C5uW4iGGAjldrNxtwfEoxyK0rVNgLx2dfZqlwORLwcv7oJrrvpE2lVP6S1dM?=
 =?us-ascii?Q?74pdHZMkzWVQyMquTP2Wq+tu2JB54Tb2F3pV4O3D9S3Dz234VX0v/v0IfdAu?=
 =?us-ascii?Q?C+jNS4db28fUQwLIFDNTcVLgrwtCMREbV5INNQwl+P3oo7bfG9hNTN8+e4eH?=
 =?us-ascii?Q?dHtKR44eFKS1sCJemV67aFoyRjqRdxmZ5RqdJfQZKnrp6FghuD3/UWNmC6Yr?=
 =?us-ascii?Q?YtQqqoygbj8RMmLdTh4EEhutrmIkqGugk4sgdTFGT6PzQUxjXLMGZz5NAod+?=
 =?us-ascii?Q?p8P87EboIzEs/u3tybr/ivddy5iQeLzSFyBX7ylLshdiU/aFf/2RrR2nLmBM?=
 =?us-ascii?Q?XIb4CJw5Pw988U8RIm8WDSln1xudDaZiQzBjt7d58SrAOOpTnw6NsHmOwuc1?=
 =?us-ascii?Q?48qbl8I+nkjTJJ6sSckvZSLp8ulIX/s8BvOVIoHHwNm78CB3GdKmCv2nSb1e?=
 =?us-ascii?Q?Phkxz9xoVH3ImI0d3MQJXSJ/NGfQV647wymWZXOFLc0GNlhTf2NQc08TfLjE?=
 =?us-ascii?Q?DZDWGrG0iN4P+np15qBCODszhFnvGrlpKYfZHeLNH7s2biTTWHk6718OCp+n?=
 =?us-ascii?Q?/azUdF21Sip/mTORMULrr+heiTvYjHOhYjRFLUnc901FcVL5hpV9/j0rteLG?=
 =?us-ascii?Q?J1M6jUDMUUYhjA2CjM5yCipTZnhCQrJ8N4sf0c462hYLMJhOEGXql0Bq/lKa?=
 =?us-ascii?Q?gxl5mGH7+qy6403gA7mZabg1cdSKe40vpx+49Nrgb8fGyvKLuVBbFZ5sZVmb?=
 =?us-ascii?Q?/8eLMsBhz/lzAZXjD9OYm0kOuPOkRr335YcAQl4hsgmq7WRC5/922rVLKLiS?=
 =?us-ascii?Q?g3XMyx4sj38hlvpWyHR5sSp5nMwhh/sAP3jwe6X9oCQE3il4VJ8o6MuBlc0X?=
 =?us-ascii?Q?6aehxE/95pbAWW0nhDBOzOH+GW7Gawe3HByCMTwEc+twX9nzfvGto2sHpH7k?=
 =?us-ascii?Q?H8DsXwRGPjFEhseqzdLI3M2V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd9c9bb-cdc8-4858-e475-08d926c37a98
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 19:12:06.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGgpxa73fbfPLVdfJHRVv3Q56oRHm75E1pKltQQvWuFnBUrU8VL7DYD6e6PbMh9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 03:37:13PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> Classify the uar address by wrapping the uar type and start page as offset
> for hns rdma io mmap.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_main.c | 27 ++++++++++++++++++++++++---
>  include/uapi/rdma/hns-abi.h               |  4 ++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 6c6e82b..9610bfd 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -338,12 +338,23 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
>  	hns_roce_uar_free(to_hr_dev(ibcontext->device), &context->uar);
>  }
>  
> -static int hns_roce_mmap(struct ib_ucontext *context,
> -			 struct vm_area_struct *vma)
> +/* command value is offset[15:8] */
> +static int hns_roce_mmap_get_command(unsigned long offset)
> +{
> +	return (offset >> 8) & 0xff;
> +}
> +
> +/* index value is offset[63:16] | offset[7:0] */
> +static unsigned long hns_roce_mmap_get_index(unsigned long offset)
> +{
> +	return ((offset >> 16) << 8) | (offset & 0xff);
> +}

Please try to avoid using this command stuff copied from mlx drivers,
especially do not encode the qpn in this.

The proper way is to request and return a mmap cookie through the
verb that causes the page to be allocated. For instance specifying a
new input parameter to the create QP udata and an output parameter
with the mmap cookie.

You can look at what the mlx UAR stuff does for some idea how to
convert the old command style to a the preferred cookie style.

Jason
