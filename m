Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41CE682F7F
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Jan 2023 15:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjAaOmU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 09:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAaOmT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 09:42:19 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FD43933
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 06:42:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/WZifrBBx/B5lJpdfkkQonr0JzxtlwqYWxiHSqJd5qZa3/nQMf9BTWDX4bSS5jITVR9vd5L0X2+kz3uN1UbUEGdgNfP+k0aOmjy2Rl/OMMaS96vwpPv+xNzW3lrRIj9CNiAhhyUeE4BnBHLIWT+/L4PhEuqSBXUOUwc3r7YncHJlI0wtX8BZRat9CgLH32rQfZfpR39S1Ym+0qAvmCFdd1Jo4fA2IxfE87XYuU2eFrkXa3+ZpeJfjvcFwwn21HkgEhagBn5os/ZQ3+uoZP24Oco5ECHdX7Ww4iBEoXKFp7iQ8L2QMEKGHnY+jLFG++yqm7chOgXYKvaSaaA9HMyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCJd9jjKIc0Z08h4GMTajxNpYQ9PLi3szGl54JiTpYI=;
 b=isJQToB+IqNNCMlb0NCEm4ArMzqTk/oONOqEArtmheTOFV+khyxLdgpEJuOUfoAEA6eWiCgjzMJWW8Zk5ef9KWpW1f1vI+POO7oNIY/HQ5fOlaWWZc0bBU9/lmm49fYgP8UxyszKzwBcxnbGkkOCEbNXShr6iEaGgME2aYm1jM1u8RYVY15gkimOAqnf3znlGtiyaI5VO460i0w6hV6kmrPyQhquHwsr4JPuWre5kEggBJBlBOqUfM9I/l0DOJSLGSsw5yyBLg7vD/6oAstLrLlk5A8gw4ytNCF3IweolChNRRJRIK6bMF6tn2qJKzcVujiC/WzZ6e4i5t/B8U2RJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCJd9jjKIc0Z08h4GMTajxNpYQ9PLi3szGl54JiTpYI=;
 b=npNlGXPdXy50pDnwpE4NFv8ZCIIaoV8i36TaQ/1c0Kj4roweYBflC4Sb83nHATGuLcOcP5vIAtFsr0fgzAKiJU8qqbW/GXAKoJOo/X9y4Q8TYnBWa/UZgVhcY8PN8gwJvfKwNZU9PSybo+4KZrHVwhoIZuUWFJYgmu4PRSY+rxBC2xEMQGiyOx4sznqzHy0JkgeJXO9RQF98HQhWU39oP1m5a2J5Plq8lR2ZE4CsK0K/0jKHDzwCIdWqFUH8IB0Tkqene/qadhJB9cNFbsI0oKnKpB2I74saWMaF3vd6ItlLOPjOcudYkhzWcwXEQXTnEhKFAOJ7fn9LaK1s9xA2YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 14:42:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 14:42:14 +0000
Date:   Tue, 31 Jan 2023 10:42:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCHv2 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
Message-ID: <Y9koxP+oWLzhlvZE@nvidia.com>
References: <20230130032407.259855-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130032407.259855-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: f768680e-ab4e-40c6-08bf-08db03995823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCvU1wAC9HgfxcGU31SE4p5WmFVx55tkfUBathIoeEY4dGLMnA11Jo/GpblSwMpq6H3RkEdRZWnAxBAXjQrd8pKNtD6S2+2H3beSmz0o1IbMeMuC6DAnNOCuThUV3zGPGCmbRFuUcrL6FefnazX1AKd1ydESxMcuPDMabjLW8FhYJur7W0jG87hL1RBdNEmox4g8ZlEcGEAskgDRXK3m4E7wAqXw/LMsokd9f6mJPGBcrBngkm6hpqjlJZgNzftq0krPpgdB4KpqWTDn1q2pWFPqb94BMeAQ2KL6latFSUeAKo6nZUCuFsDkY7Q+lO8yYG51gPcppTKip4x3WXcLuYmE+Juo57VFsHjASPuvHw39aZeuDWJAxI9hHEYIpzDk84S/nP7MGBMK5V86wOkoJHj+yFHZixT377dzUv+/nvYvZcKq4pxuWwrDJWCsfftlzw4UYAxZ7JomToBXqqbKRLtFzG8GBeZvkyfUOyZOVjfPo3DqBLaOx97o2tMlKoziLi2OWa72VS1qRDXyhsEmh7HZ546oVR4ALTtwfjfJGyrPiugn10hY67fHMdSckdJ8PtaorxKxHY32IVvBqPnaeyLdu8UeM+7NwlNOkEPDDjqKnBILYh2P9gsy9X3losy9r0FckpDs9LWO5doCJWKI70J2acj11RcTcX+H59sKLGfiwbWxvkIW+wQn1mjXf2B5aXpvQNqJg4a9934noDlf7/JXEoh/NeMs84h2pukyi9F05xPleZnmagTtIeOIk/9hdCCLdBjZUnEPVEcKJMzPRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199018)(86362001)(5660300002)(6512007)(6506007)(36756003)(186003)(26005)(2616005)(316002)(2906002)(38100700002)(83380400001)(66556008)(6916009)(66476007)(6486002)(8676002)(478600001)(8936002)(66946007)(4326008)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ohBYTXXJFTj0TCzO5EeOjSZaL0K9iKLfk5FPgK4EL5dSOQqLx5EFhK2PhID?=
 =?us-ascii?Q?KeH75GPGnhaWwa0QlOQq2ohqZEv/NVFJkYY3fo2rySqBDj0iXKBSYxBsrFar?=
 =?us-ascii?Q?mC7j3YkkmdV99pZN88p2hT1wO6jKePHiziCwBdsbXxuUf/ya10GrXlsgPecg?=
 =?us-ascii?Q?OdtX24EykV7Ah0PyeEsXHgdFzqGlVkbeqTT2IJIYTp7NZz5ozlO4s4FAIe7/?=
 =?us-ascii?Q?HdZZLeGfTmO47xux1pqWE83hf6yg02xiJsm3w3UDnmKMsGpUyIF0K2EOgm/L?=
 =?us-ascii?Q?iHDJx9z6vOIc+5MGT09a61u/A2lCS9s3trz1R0TJOLHyYFrN201KQj+RSJ3O?=
 =?us-ascii?Q?VcQQn79BYyT1wz/CK8TYMBHwWgJC0VYzD1Z0xCHmqHw2D+uMYRBPV6relKUN?=
 =?us-ascii?Q?3+gS9qWucPxnpph3qe16m88JZ7tRno6Nnc5cEo9FLYePf2MgJ7Qwl03EA8Jt?=
 =?us-ascii?Q?epnaouOR7qqUY69mMfOyy3cOM1GB4NF4Jg5417A0bR6R//XTESFqy3syxgK0?=
 =?us-ascii?Q?7itShtP3ly49KVzpU3uug5sLg8VOFlejio8EKAWO/1mjavXP4BDGz0v+rvd1?=
 =?us-ascii?Q?h7bEVxoOi946bkhWhDJrkUGsPZ/NShXCIXncJ/hteS0h5n/IA/985VTrTCs+?=
 =?us-ascii?Q?a7+iJBRKvp+q4d/4hhnAztGAGIMA+3AML7hAmk67wnn1J6WXo1+q1mzLp0HX?=
 =?us-ascii?Q?7lQ/aNfpyNXMAVTiEe4Mh5uBfMGgQrZJp3d1DegLnDCMY3dIWJwcFUlF+2ct?=
 =?us-ascii?Q?4TonbQthPVNm1yhj6v7idS8WqVmIjV1lEvUiPzq+qwUcWiRzyWIYAR19iH3k?=
 =?us-ascii?Q?8cD3TulY+ghBGiOihCrNknMKyB9Iw0Yc4ob7wz17uhwgFTuKTl62yiITQU4U?=
 =?us-ascii?Q?NdAYTH2cZ4jOerW+NsnQibEASALuIW4Z/36zwbI4S0aCHEUSo6IegrIjdEMe?=
 =?us-ascii?Q?MF5LnNyEfsJDDmujIhbQRVS89l8wacdKcgakvOKPvr+PwN1AdqBF+TycllqP?=
 =?us-ascii?Q?YL52E2xmjYBptBUzPQqek7ZnT4dBsHf6p8xwebzb9HcHKQ6JYAHoY00uLbqw?=
 =?us-ascii?Q?YybyACi+vGqc48iEM4YT3GHyoSe/kRWu/I4H0aDZsr4PWFsYYAFv7aZwiPa0?=
 =?us-ascii?Q?/VsRHb0ZJrPtv6k4ELzlKxnDpS9Jd9VvP2LmyC5ldsZJtA8QVcpcAGAcvf35?=
 =?us-ascii?Q?VbZIH8/Jwacd0SxclwKV8R2GOANpWQ5AjddYrW0GtNaW+6HyxKOjL1JaxDfc?=
 =?us-ascii?Q?oSX23xswDjC0yxAMTcZaduXMpAauifz+OX+UQR21BLh4BdmMNM2jQeyhlout?=
 =?us-ascii?Q?8KdGVSny4aM2v3Quo1GOQ4qVuHyQBxHFTEPkwFQojCkU8WpBL4/xG7zbSxlt?=
 =?us-ascii?Q?nckUQnAtF4GPwvJLKLVKvoZrrzUGUIsutOxXu3V60cOWBgNOQKE5IP18ocnC?=
 =?us-ascii?Q?kXavgNb5d1Fu0ZeswfmznKDeTX9bfjJaqPaxf6tWNvBCGk6zEuTvoH+kV4RX?=
 =?us-ascii?Q?rrNnPRdJbdxWFOudIgd2pxP/ncIcTQiuDDax12kCNbIaNCRh3VRkklVQ/Qxe?=
 =?us-ascii?Q?Tdcl1H9+wnTvPaKlqlxpd1NOaHl1ZprFOv3s0MRg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f768680e-ab4e-40c6-08bf-08db03995823
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 14:42:14.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aGWJBFBLE74tQC0qjn0X+KeOi5MJBfsWCQfJNdYiFPA1WRZX4rh+uvSIsNLH5Y9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 30, 2023 at 11:24:07AM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> This is a followup to the EFA dmabuf[1]. Irdma driver currently does
> not support on-demand-paging(ODP). So it uses habanalabs as the
> dmabuf exporter, and irdma as the importer to allow for peer2peer
> access through libibverbs.
> 
> In this commit, the function ib_umem_dmabuf_get_pinned() is used.
> This function is introduced in EFA dmabuf[1] which allows the driver
> to get a dmabuf umem which is pinned and does not require move_notify
> callback implementation. The returned umem is pinned and DMA mapped
> like standard cpu umems, and is released through ib_umem_release().
> 
> [1]https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V1->V2: Thanks Shiraz Saleem, he gave me a lot of good suggestions.
>         This commit is based on the shared functions from refactored
>         irdma_reg_user_mr.
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 43 +++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 6982f38596c8..a638861689c2 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2977,6 +2977,48 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  	return ERR_PTR(err);
>  }
>  
> +static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
> +					      u64 len, u64 virt,
> +					      int fd, int access,
> +					      struct ib_udata *udata)
> +{
> +	struct irdma_device *iwdev = to_iwdev(pd->device);
> +	struct ib_umem_dmabuf *umem_dmabuf = NULL;
> +	struct irdma_mr *iwmr = NULL;

No reason to null initialize these

> +	int err;
> +
> +	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
> +		return ERR_PTR(-EINVAL);
> +
> +	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd, access);
> +	if (IS_ERR(umem_dmabuf)) {
> +		err = PTR_ERR(umem_dmabuf);
> +		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n", err);
> +		return ERR_PTR(err);
> +	}
> +
> +	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt, IRDMA_MEMREG_TYPE_MEM);
> +	if (IS_ERR(iwmr)) {
> +		ib_umem_release(&umem_dmabuf->umem);
> +		return (struct ib_mr *)iwmr;

err = PTR_ERR(iwmr);
goto err_release;

> +	}
> +
> +	err = irdma_reg_user_mr_type_mem(iwmr, access);
> +	if (err)
> +		goto error;
> +
> +	return &iwmr->ibmr;
> +
> +error:
err_iwmr:
> +	irdma_free_iwmr(iwmr);

err_release:

> +	ib_umem_release(&umem_dmabuf->umem);
> +
> +	return ERR_PTR(err);
> +}

Jason
