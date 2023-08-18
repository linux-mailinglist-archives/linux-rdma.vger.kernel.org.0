Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7B9781033
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Aug 2023 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378569AbjHRQVX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Aug 2023 12:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378603AbjHRQVF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Aug 2023 12:21:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E204126A4
        for <linux-rdma@vger.kernel.org>; Fri, 18 Aug 2023 09:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So8dPoCnUEFMq4ZB+sSjjthFCpRwtWliDolcf1grxpN0/Y05W+6d6CGLULGlH5au19PCH5FGQBoSwq4gd+vX2wD7YeTbvCKMiq6YTfC5RVnz/o5oBYjadkmyePKSAwJ5Wo5cfM46alxj0cD8nk/xYgrrhvE3ZHvV4eJdBRgPMw/1wJov9xWZ1G8kdhhwrvg2bTlyu4uuoF5Iu3hPAiLb8Fuj7D6EHuv7Tfwez3PX4srkIkkoe+UlqUKQAfTYYRkKVN/eAi4RPVr9O8rt60NueFTlTGCnffNn4Wvg7J1+yxJbL10B7UxtEA08V08aJCiMhYMAXD6hVlQ+rJyAUI5GBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1y7EF4rbqQkQifiXQC83Q/Ks2erpiL2l24rn3xFIoAo=;
 b=eb82AKWW7r6JjShykMEkhXPcEA0eKSIpa5cRr4dqxQ2QHdHiAKcqB9WeB5AKQjI1E0FiuWInzECfJSCqHfPzq+vnayn7mQrbJdf+U5fcWUz5Yu39fyLGzOnacCZ3IvupoKNTeSmM9One9SKNF7/lKjtlfMpF4gisCzmi/eHouUxfzpVg7AM+IPfdY5Kk1t0lkuBMhQibBuVt3b8T2TLuebfXS+8ckECldZdl8w61flBWH0MYYlyIJG0JoPQvV2Q7QcVspDvgz5rbebPI47u+nU/JRAK++r5/A63mFa6RT1HslDZ0bGiOr48CEr3Enb4M12t11KRae/HkY9rQAFB6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1y7EF4rbqQkQifiXQC83Q/Ks2erpiL2l24rn3xFIoAo=;
 b=F0FggDroHR+J9Pv2gbJGGu2QAC6vIUfSMNPH8+479OVRO7dqdTrxhkSUhu+Jf/ZAyQWolwu8cDublLktH1VWs8ZId1GzrTtScaXW2JjqQ12s9NcUQ8/I4Dh9OETTIe3yoHvEbku5kkQ3zzU1SepPQijJAz2htzEl5Sr1a9d2+1Q8eRSqXrcZUFGvAnIeZplkeC7HwQoUoFcbtDd7XM0UharAYVh4zWfNSu1kkJlpNrzlT1nzPk6Qh6tQ3OgCZNRQ7/jKn/of5hg1z+D8nx+nNvlFSY/WkZIBrt1UMUyftNMwuOF+vfRQhY1ekppqosMzjeLAB0t7VvnXlozKdTgHIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:20:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:20:55 +0000
Date:   Fri, 18 Aug 2023 13:20:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Protect the PD table bitmap
Message-ID: <ZN+aZiK+BJY98vmb@nvidia.com>
References: <1692032419-21680-1-git-send-email-selvin.xavier@broadcom.com>
 <1692032419-21680-2-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692032419-21680-2-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BLAPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:208:32d::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 558011cf-2184-4269-f194-08dba0071934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6Ldmn555bhJgF3rfN2a12wdtqNAGhXG42JtqomlGDfel7sNmHxx+OiIwRmPf76TUeEmSoxqJv0BCNOVut88LDieqno4ZHPQsM+Gkh65P8QGm4J/C1N5/Z7+ETBA1hMY5CRWm5Po6evrD8L4++IqvdGxw2s3id+B2RFplfIc6fMkJ7JUvAhoh0RbqO+KFa1DMwLpYxP7ILbU9MS+vqzxQ2hcPaLfH0rHa1RTNcPory0Nz8CQhqlUYWSMO5tW9P/E/fCmJQMIjVUTmKdVvXouyhWRRR3PpMgKE2PV27rLk+pqXbY5A2uh+XbgAv7VbUf/9p8GsdGRLc/KDOQm5IuyozKeBMUfUiH+vO91lkpOIi3IMefbmVRkhxTR/VubIGLLftIcaNECjuUOVDRT47bH8kAvVCGYPC9EBl6Ub/3jK/EuiAHrwQqH6jaiv2kpxsDFzWrAr7K3LByfdG0PRmKdn7ZF3vB6Ttv14At8GH3tedqsk335qYNjTNTlSIXvlE7drRzVPy2QTWFNSYL6dqZ5IP6yecwjMlnOChTDFytxUnPPkEvMhwDh8DS/ecG9bMld
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(186009)(1800799009)(451199024)(86362001)(36756003)(66946007)(6916009)(66476007)(316002)(66556008)(478600001)(41300700001)(38100700002)(6486002)(6512007)(26005)(6506007)(2616005)(4326008)(8676002)(5660300002)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?24EMvOUIjHfZm1LFeN6lzYc2cyfMeXQlX64C+x55jLr1nbU0Nw2FcvIJye4S?=
 =?us-ascii?Q?hnhKkCQZ5KzVGskLh5hBckQB0hlIabklKugjoGR9OqW2NeX4OomH9OdNdMKJ?=
 =?us-ascii?Q?LbZerfGJ0tX4Gv6ul5+d1yFwJCMF1r1nejMLIHCokXpCQofQUX+2j7wI5WwD?=
 =?us-ascii?Q?5vbASl0pu1pPPyJ1Qzgv7v62L7z8S6hwqjH9T6Z6skitqKObSCCNrz92AOly?=
 =?us-ascii?Q?c3EvfcM8txpPbZEIIKM1OsrFui28Zw9GokF05IDPfWHev0Z/nqAt6fP+sq1o?=
 =?us-ascii?Q?da45wqoXoel4zl73Mffk23VwGwM5uAX8b4sIy3IIv+dVn5MJzDT3n684grU5?=
 =?us-ascii?Q?1sO0Z54jbmQP/2XQNkOXxKJTmjEZwADlJAF42PV09fM3ckAABbnwIspZvsaI?=
 =?us-ascii?Q?tx6cZAJRLBt7TKqX1MXyH+e1WxiJYPahP9TuDApC4qCAhi3gSnk/oBJ0S9lg?=
 =?us-ascii?Q?Zhc9NjXpPzVMj/8nWLuIrn/2RzYX2nJ1HhXx+2l+TMS0mGqPaCimoDM8Jloc?=
 =?us-ascii?Q?HPqnvmJVr3KS1FQEwOz4E+lDCnmTv5QzhoR6/LxvCm6x3ZCpBJBqFI9K9GPk?=
 =?us-ascii?Q?2q7uzSkNZfNaH8toSQ1rlXZj2UtbSSv4DUPOfGDsAYUXXt0goHYxMAq7TlrV?=
 =?us-ascii?Q?pMWJtsjBsFuA/YVY/xOyhQzT4kkAJWOEIWK0l1CoWstWFC3AUZZ1fmyuwtuQ?=
 =?us-ascii?Q?AWKMJxPngtuKRblNA/EwGtvMhHfO+wPf8FY1+TB276sJQmb3XI/nuwli5OHw?=
 =?us-ascii?Q?5XBvIm4qKFjhhtcOt2uJnvywHp7kJT+BJ0BQvf+aK5y4GMFKFeGa5Zl/Qig8?=
 =?us-ascii?Q?s+Oo2RXQXgnU/zlmyCP03Y7L5foRbsX6N0RQ+Wcskmem07+h2zowDiaodPAJ?=
 =?us-ascii?Q?I9abJpWs27puyjpwcFjratBRDqh8wqeXMMe5OHA+lyoF2KN8LOPTBjb3GO3H?=
 =?us-ascii?Q?n0uNCdqBJ3S6DN65cCa2OU0QvH1xau7u1O8aU/IVnmiiaX4ldNv9fQ87OfmE?=
 =?us-ascii?Q?qFEwRVErLZdcCIBJFa3l3PqcxFMqCr8sj1ck1ZUOM0p8c8WRKoNvBEcRnb7C?=
 =?us-ascii?Q?0YbDavFd7zKXNwJEMlzaxnnfQU+od8t7zVPy+6n/qgRZ+ripEzPAshMr9QDB?=
 =?us-ascii?Q?+MHjxusvCEKFePSECXh8jhZnIBPJBPt898ewPWQ37U1fcWkOwMOAK3BCe192?=
 =?us-ascii?Q?kuvI245L7x5RQB4LAaDil1rxnUp3CrOXuSHmpRfpXIOv5hgPCwMiEAxWRYY4?=
 =?us-ascii?Q?goG2784XCQYnFIsOPteCxdOf1yU4+AOU/UqrM7lhErY8rtKK84xerCNGr3MO?=
 =?us-ascii?Q?t8BZG5RMosx33p0fypS84dnGD9IXTbsuuLYhZdGnX+hEgCG8mn1kxMFoZeKn?=
 =?us-ascii?Q?jw34AvHOTAjqgWLvABX/YrRMAibdKGQTFiBBG0Szhdcsjiz6cXJNJIUKIcD2?=
 =?us-ascii?Q?buWnD5TJkMeIK4Hq3z1es2WLEWpm6wWchXd4Ex8z273H0YJL5nQGVhj4JJaY?=
 =?us-ascii?Q?b4sBjRrTxFCL6b+S63fqq2hP5jlvk+xZjOIFr7tt7O6yeWbQw/mG8IdWR+Od?=
 =?us-ascii?Q?j4Z54wgCstvzL2r6cMFB65dVcA8JDyLnUL7k5OB3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558011cf-2184-4269-f194-08dba0071934
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:20:55.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APfE5b+01jcFhCcoMbAUj3dOEN+bRhLwghK2MLig6K1V1rYN0j/W+Q1g1Qvckn76
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 14, 2023 at 10:00:19AM -0700, Selvin Xavier wrote:
> Syncrhonization is required to avoid simultaneous allocation
> of the PD. Add a new mutex lock to handle allocation from
> the PD table.
> 
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 26 ++++++++++++++++++++------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  4 +++-
>  3 files changed, 24 insertions(+), 8 deletions(-)

This needs a fixes line, it seems like a serious bug??

> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> index 6f1e8b7..79c43c2 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> @@ -642,31 +642,44 @@ static void bnxt_qplib_init_sgid_tbl(struct bnxt_qplib_sgid_tbl *sgid_tbl,
>  }
>  
>  /* PDs */
> -int bnxt_qplib_alloc_pd(struct bnxt_qplib_pd_tbl *pdt, struct bnxt_qplib_pd *pd)
> +int bnxt_qplib_alloc_pd(struct bnxt_qplib_res  *res, struct bnxt_qplib_pd *pd)
>  {
> +	struct bnxt_qplib_pd_tbl *pdt = &res->pd_tbl;
>  	u32 bit_num;
> +	int rc = 0;
>  
> +	mutex_lock(&res->pd_tbl_lock);
>  	bit_num = find_first_bit(pdt->tbl, pdt->max);

Please make a followup patch to change this into an IDA unless the pd
max is really small. Don't opencode IDAs in drivers..

Jason
