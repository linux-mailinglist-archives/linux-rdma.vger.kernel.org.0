Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD086119A6
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 19:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJ1RxY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 13:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJ1RxX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 13:53:23 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E036E1D73F3;
        Fri, 28 Oct 2022 10:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBgqYXsT2CJjwXIarMN/TWGTJFtwK3GdTj7glEmJObwVG3HklaLVUbf7Igcjgh1fGovcr8xuQsZOBlhTvmPDthPm7cZk3OXFo6Yt//1J2qVHz0Q/FVjzbbf9fLwt2o+zX5Mclv3PI/Q08eZlkQBjmZ2I+tfHs/gYQh5Gm84i4KDBun7rXdziGIG+4Lxb8iHEA0oqZ3YExe5MwEko/cYIZtXD2dvUEXL3TlSXERtnZgrSa08jDmx5TCMoL0Mqp2lqqRq0sYjrUXGWhtiy6BgEVQmpX79m3tQnFJDGHM0MdpyUkuco/3zLroFK2E0CNi2H+4lcmsihMC1yonxRVYb1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COAc/VWCk1owMwsW7l9CucQscm4pKbxC6tVfGVidpnM=;
 b=Pzsmxgg0a47Bx9gymRH5MRMblELX6+pDmrNxY4ApI42oxeRzMBXks5C0loWQhQBPSiugc5sVQeoQmvePpBh1p1ZQzM9gnLm8+zOEeo+yLuamS97wFuy440z59khc/blgrOV7qk/TZhp41Kjb6OXJVsRqmJ5SxIIipCClsgCUvao7A3nRHIqm/3U/dO7KX9hknJb2aueRHqAd9XrSkViZgUTKXjDL+mRXQ96ugBytA+ftIzw5oJxODczFDlMufTM/Lcob8SzXmKjNUVVsk/TTuKpNvL8pDPgvjtw2RE6a79YIJoLkY07C+KuCYc6gqItf/mbC8sidv83jekFyYeJnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COAc/VWCk1owMwsW7l9CucQscm4pKbxC6tVfGVidpnM=;
 b=GRG1R8LYnuDPMlwvhToWRVioBleqDAl7M8xFs303I11s+XJJAafppOFVB6YV/XnEZTXB08iTGohQ3Ofk4ySADnlzU1D16nnpYNYuH6R9zfnHBEQPPJVP68Yv3PI54BBcca0jSQ18q1+GvbNAJn0f9iy+5WuT5vAf7V3juwO+vpMMcIwU9EAUEcUKo1+L+hdnMzCF5DnCbf1RUB3f+L8oksANFS2TQoWKx1Lcm9zNZnuz0S6Q7eXL816xMWD+d7WYKmiwU8MEbmGU5w8TfUkCZGbf8koq/8zKkEJUzrg65+HeskeQ9hEehQINyQORlKdAb97bOjNXnQzmFITI1tjiPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 28 Oct
 2022 17:53:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 17:53:20 +0000
Date:   Fri, 28 Oct 2022 14:53:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH v5 05/11] RDMA/rxe: Allow registering persistent
 flag for pmem MR only
Message-ID: <Y1wXD/cnIlGUANBY@nvidia.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <20220927055337.22630-6-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927055337.22630-6-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:23a::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 45362f0c-c5cd-4091-4318-08dab90d4d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hlBdiqvzVDm/Ejbj4ibjIe2kZ9cI7XMA8R8m0feWBgidUAFns3RJLAo+zjdxVn4++Twop7KpyQssDxuOLgg/2pyLv8wlJcc42itMSS6ZCuy62UcJ1NgqfmAlGJiCMT/OT8CY4u9vS8lfrr2cLZH9SQqwjvbBbTs/iylE9o6cp6yPuFp5wBUnBQFqMMw62YYvJuB/AAyNXtGxpLhEYudSzO6hpjrT9exdoEeLB/NLZWtnu/JC2yYo6E56RUEYpzygFnPWaCICHFrzHfCXg0dkL12x2Sm5Zabr+tBaTBXEBp8dV4dTnFwk9SYQBBVh9yEncvyZRjJ9/zjzguLTU7SW0weHCu/iGJu+owoTPCxfqy8z7faHaiDxeDy/64RZk7+WEKpvVq/uwy9cuiCVuGE6ge1GzJ8w6xe6ts0yF2jxfZW6B1Bze13Gx8ev8fIieed/eOsGbFQXViYafYGE1CNnJVfA0p2zXtHN1klPGhZ+LGBzkLYAiRBpOo+GY9J5mYmm7utLDTxqbU+MYhZdmim6LRXbQyA3DcKR6beCiJn/Ywpufr+kmuxV5gg8rJE5r0+jIEsY2O00Y8J9Viw8YNcfYhvGUgfpv9Hh6HSn3qcIs5l24SUH9pfKudGVAxqrvuRbCFwwHP6MjsVoWvjlCn//Eeojkzz7b7929YBRfH0NPQfCPu6vsN/sIqfy5dPTTuwnr4FmBs0J2woyIFX59IaZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(36756003)(86362001)(2906002)(5660300002)(8936002)(7416002)(6506007)(2616005)(186003)(6512007)(26005)(83380400001)(38100700002)(54906003)(6916009)(6486002)(316002)(41300700001)(478600001)(4326008)(66946007)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FZt8sh5j7pCBSa/9SiEKW16MojOPrb4sWz24x6XsFyhwhuSk5ytRT9tT2iqP?=
 =?us-ascii?Q?V10B1m7WthlNXl7DhHiVdNNoPRMTnHyBx0uth0kDJi/pkIQDXTqXTlO3v/kM?=
 =?us-ascii?Q?GL8w/3oaaardNKgf5EuS113vbBo/eaT+HN3jhZBUmqVGwHpDj0QgfNONevk3?=
 =?us-ascii?Q?Z2Zlc2pCvwRWQI1FzENda4ZpDoQcGp/iMbyPqxiDrq4NR4yzdVEMvP3zIsOU?=
 =?us-ascii?Q?VBOMKG6LAxlyeLYqKnKNGjDI//Ckery9k3VRPKQx4ep4klxyvfhXXhR0ZHtN?=
 =?us-ascii?Q?6cYhM88Vy9ubaZacT4l1ew9tSugZPdWMvAdJBR4PWYGIkWFMwtLmt1oEXUYt?=
 =?us-ascii?Q?iJtSNZ6wxabOiCfIXXughobmXdf4+SyqxziRHfm4BhLzZsKlQcWnRdbFTmA1?=
 =?us-ascii?Q?IKDxbr+e++svLEicjwGIdnYADnrmkQpTRVIs5b61WN+W/39Wa/4M80rE4ZFg?=
 =?us-ascii?Q?Z1E28zvfHRZGAah39iC8BDZ3St5YLMhNNkbINfSCg5rp/OPzsOq/q+QTezGA?=
 =?us-ascii?Q?iNTNghUGS+DYHlvPJm9+ZiXHN5kaV5mOk5DmumfTnKtr+QXgZNEOY4elt7Tl?=
 =?us-ascii?Q?F4+wqKMyo++6WkrY/6jROJGM7yNSO91E3K8uKS0bK66xoGYHZadjKj627T/F?=
 =?us-ascii?Q?4iJHR4ggj+FUy7rGJKWLmAfNlNnXric50N17gtIndhPJMgGx6gjDKJBgY3cy?=
 =?us-ascii?Q?fh60L+M01vhNo/C8V7741lLinutYbNFQU3/ai3DWr2w8UkjLtmzdwdLojlwV?=
 =?us-ascii?Q?k3FK2/mE19KieJdooJFEuwozoxUmmWuLQlpLWbJ1JjjgAx5ot0q9bkd/AlUd?=
 =?us-ascii?Q?Cbpd/BRx21QMyl0Yv/D9EbF2UyKPvhKVJpJGgheztWvt1SiiwZAQJ72pRy2F?=
 =?us-ascii?Q?mTlQjCFGDSKjPik5CEIqiBKXMK/BzXA0e615+Po0zACYPPUexZS++5zsb73r?=
 =?us-ascii?Q?0HDryzo/br0sEc6EKoQZ5dysEvYUup5RLDKhcCVcO7cb2bJpJdbpoxLQEf+2?=
 =?us-ascii?Q?FuLt/S4cMjjAp/0D5GAujv18Os0ecfGBmahkx10LY5T/iD1yksOdG8d8fhQ2?=
 =?us-ascii?Q?Ug8zAYnryKsecVL+iw5IjJ+gQd7f/rvliZ7MKnww9iWcH/ZpNvY81tXkmv/+?=
 =?us-ascii?Q?AFCXeJDHLF6SpeTvtYjafxB0khuRBkiKBXSOfMPY54rfOKiz9NbIiIRhsMDK?=
 =?us-ascii?Q?pL3786WdulFyZzfsSRZOnJ6bIEGfcEsz9DavtxRReN36LYZqEekgnto7zIMX?=
 =?us-ascii?Q?5tQdOKTyietaDhMHT4PBD1r+PWBcq0gKb6tYAxfxZMSzB2gRHnxnWO81CxLr?=
 =?us-ascii?Q?BfvOmziP+4DWKzkusC/1nb82DbUJGHI30ZiHo0OT167iT0ft3fIsSZZPEBIC?=
 =?us-ascii?Q?6ycb64hPIx13hplJxu4FYlRObbmldmVHxC5pLkYVl3TLQ143IaOTrJW/JHhD?=
 =?us-ascii?Q?i1jmaqFwu2hhIwjctRdgkvoh0+zeo5y9bF/GkN5FtJLADNV4V9KPZ4roCy/7?=
 =?us-ascii?Q?SBmX3xQMtPYCuJbHO+3nml6scI9WuRTQQ8GMZdk4VwmzosBDznkDFIFGzYks?=
 =?us-ascii?Q?6PsKPZAuYE7K8jjSPkI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45362f0c-c5cd-4091-4318-08dab90d4d17
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 17:53:20.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnsCMWoNiJ502Up/DGQ2175mSE34fyBOe2chp4sbivbEkme56NKE435yZhVLwjm7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 27, 2022 at 01:53:31PM +0800, Li Zhijian wrote:
> @@ -122,6 +129,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  	int			num_buf;
>  	void			*vaddr;
>  	int err;
> +	bool is_pmem = false;
>  	int i;
>  
>  	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
> @@ -149,6 +157,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  	num_buf			= 0;
>  	map = mr->map;
>  	if (length > 0) {
> +		is_pmem = true;
>  		buf = map[0]->buf;
>  
>  		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
> @@ -166,6 +175,10 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  				goto err_cleanup_map;
>  			}
>  
> +			/* True only if the *whole* MR is pmem */
> +			if (is_pmem)
> +				is_pmem = vaddr_in_pmem(vaddr);
> +

I'm not so keen on this use of resources, but this should be written more
like

phys = page_to_phys(sg_page_iter_page(&sg_iter))
region_intersects(phys + sg_iter->offset, sg_iter->length,.. )

And you understand this will make memory registration of every RXE
user a bit slower? And actual pmem will be painfully slow.

It seems like we are doing something wrong here..

> @@ -174,6 +187,12 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  		}
>  	}
>  
> +	if (!is_pmem && access & IB_ACCESS_FLUSH_PERSISTENT) {
> +		pr_warn("Cannot register IB_ACCESS_FLUSH_PERSISTENT for non-pmem memory\n");
> +		err = -EINVAL;
> +		goto err_release_umem;
> +	}

Do not pr_warn on syscall paths

Jason
