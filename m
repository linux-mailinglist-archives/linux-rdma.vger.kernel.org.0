Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1295672CDBC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 20:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjFLST7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 14:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjFLSTq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 14:19:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67771196
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 11:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIpHHJydNImsHn2PbVV5elK0XEqP6niiNMSeSWLa/Siz1m2Tt+/2KuSXTgs619c3b4OhMYL4ovoJKJv+JYz9LUB/VpAH6WwHUUE1P2ugOFhkUAx3WN21zF5WLqu7tmzwUPDIsUTzRGKfXVieBtkXGIZQ7p2dIfyiwBQBQ+AuHgKVGl/gaNTET3I0+eLmwZKVuSPq8Hs8gHa0FaL5GkqZ/VG124pJCjeVHKN1mTVTfBWJN+N47LOs9e5im1OG4pV5WBgXVfZTdRKQ2CyTWwXGVFfHSZDIjLoVOpKoufBWS/YddXcZB+vIVHIIMqjNEfNEIRT3PpS8XBDfyYScMMQfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnrF3nyIJ45DEQhueCmMmnFMQg93+0rxzBmvNPH9W3k=;
 b=CAD7U7Bk2YBYLiarUg2CD1BT/r8j1N0jL5nnw90Bs2QKe3Qca1ToNRXYfhG4ncCIquxmWZ+hDDgzbkn1sPwGW39d9DzPKvntptSOaDeAgXSmeeDzfTl8OUQRPlxhE68W9UyR9XiLVerWGFipMEotKRNBW3LejiZd5dpPTw4SbAGm1bECASE4TuyaCDh224QbMmJ1O+gXOPySAtzaWKczy4oL2i0gbhighGCjQatoAC1PLPx/wOFGGxFPiUQE2G4KXubs0DOfeSBeKCUr2v2Q5r7vDVlKFjAI4XiKr813pwoJBm5zIKBfgRZgZcjfLFhdil+XQ8ZAqBldNyb0EraIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnrF3nyIJ45DEQhueCmMmnFMQg93+0rxzBmvNPH9W3k=;
 b=LdaSPYOUR8PZpC2ke0UuhIk6sEPE86Jz3JcRAT1QyCIOntM9B9WOFE6c/G8wrOi47nYt5uorp8GqmJYBgX/jOnC6SwhlAe7/jzZRA+2gnC3vuzV8l649UEhxq0tyey1c+4i3t9IiPiOz4eXmDvUEOech5ppFYmEgd9c0F9SyDMKUdt8Kzdpr2abaUddHixJMyJk43wX3h2iEAJ6onNfZk7NALKxlPA6zXqV6bUFqKd+04Dq3wXSPU75p/SdWqxG3/eMVjnzmnP88v4irYSazt3prpmYaFK9JB1M4APQUfrf/tr5/HkVMP9cSwpYzRrcUzkQB/4rPQbCXWHvbP+Rbxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 18:19:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 18:19:40 +0000
Date:   Mon, 12 Jun 2023 15:19:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v5 for-next 7/7] RDMA/bnxt_re: Enable low latency push
Message-ID: <ZIdhunLGPLg6h5ID@nvidia.com>
References: <1686563342-15233-1-git-send-email-selvin.xavier@broadcom.com>
 <1686563342-15233-8-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686563342-15233-8-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: MN2PR19CA0038.namprd19.prod.outlook.com
 (2603:10b6:208:19b::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 61dd7695-c6dd-4926-3243-08db6b719673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTYmJjHuc069p/2KiizFVe47G+4XMnSh7mJNz7Am/OalOJnDBq/IufMD0ExEC96/jEeA8gZGh05DVOV/1zNct1oec4cOBRzwe1YUtxVgHDtYV+9FHWArHTVheBRbp8g0kSJTusNZpO4y59KHWO3B7u+5TApT5vlqJ8mLaI/Coxq7MtjMH1zZpDetf85BSIEVGppMTUr57RUi7xKT5MKMII3YtxVDY0VCsbLBQDvqZwaw7Zxzr1BaJjgnuVgxMbuGPdBM4sIG84NBX3/5Gd4ar17Cd0GqgFdl67y34D2/XZ7jZjodIESqN1Uxx4kDPbSziZwXBn/p5W42tDTDq5GmFHXEMy0a89lDJcCWo2lYtI7SMSKvQDLMn2K+rOiMszYX2IvrqsjJeC2I3aPQMW10uXrf4CQ7Tiu//HsD/9PMGxTmryZHWTYwMvnW2SihSb31RJoVqVH2LZeoudDGXVu11zTdulU3tFUxYqSFYhoJnvlpRTdwXP2c96PNqVQiXF4wYewON2+gXVVRKC0hMsYXcAMrE9C3meXSWMeWf1bj9bSLZYkc8MkxyIzTfjyGIzBi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(6486002)(478600001)(186003)(26005)(6512007)(6506007)(36756003)(2616005)(38100700002)(86362001)(5660300002)(8936002)(8676002)(316002)(41300700001)(2906002)(4326008)(6916009)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8SaYtEMpMpQYSuL1filVDz+OEmOr0CiYVx6LwvJznKYMRsEoYOBnxx+zGqrN?=
 =?us-ascii?Q?LEPjWnwOZGpMCq3v/gE/eUXyt93Sfv2eeMMgSBaU2w5U5Pr3Bi4VVoZDRKMr?=
 =?us-ascii?Q?te/tzgXWqUBDMxbkGMJgBmGvSJp4QFyHOU+Jct6F56e5RDAMpVxjBgHyNBTD?=
 =?us-ascii?Q?YgNPVfoR3Vk8FYFxvGBLOPhTojjtITLlx69LL6aEXwy14chFlRVURwVmKoNv?=
 =?us-ascii?Q?Ppd06HrI3wIjW3cO8mkEJRgDRWOoFlZvyMVUysu3yooV1kqJk1JQ/Hzvl0Bu?=
 =?us-ascii?Q?UFnesrZLUaynAcnOLDps9sWhQ39Z74Tg7yQiuNzExwrSFajhLCae3IwDtN2r?=
 =?us-ascii?Q?fM03/lrRG59JogCBRrr7706VAI7XN2HNeCrBdGKgBvoHV722s5YjuPwJM145?=
 =?us-ascii?Q?xdmi6/b+9FYHRJki65CzfDUU4riYgyGWaQAvW6FyKOuCDbyJXmk9L0gbREyp?=
 =?us-ascii?Q?w7CrKloV5JxpmCjJ1zRRpe2QrGqf8bVNEWZ3jJucKz2hChFDmCx3xgqntxWJ?=
 =?us-ascii?Q?28Q0xg/mjWhRntCxgzz4WsDX6KBHn4bIgrNL/fNj+6A90CHk8O/m2gW7qR9M?=
 =?us-ascii?Q?XAW3KODPImOtnzb7KNfFCW5ZV82ihi1Ynz3QDAlWNx8opd/ftATXms7q/oZF?=
 =?us-ascii?Q?EnuE14jXxJ54REwH8uKmVIeva6usQOj9YFzIo+KC4fjuOlmQ8YJMPxq95+yp?=
 =?us-ascii?Q?xbGN//6qHuWZha0HHGejuKuAfDnosfCRLVQbDRAiVwerymJeONMuQSgtZceT?=
 =?us-ascii?Q?oIpzcmT5fCAtDonFNOGZwnnB7ZyXCzdZ9tt5k+6UOpyQ2rHbxnGBiBfOMSAP?=
 =?us-ascii?Q?Nuy9gKSS5tpolz4aUxQXQvOpBSHYzpJwo3cI9wU9H0RDQh38pL/dX4ozzXA3?=
 =?us-ascii?Q?OeQGNyqC+AlmZP6ZXfMqw+9b7MVDJbnmSI9QdkjIoUOBEOPSXyngYVQkfYva?=
 =?us-ascii?Q?s9Q2R1KMAKJnpm116STmO9qibkJfBq7EZBys2KzfN3n6m31tWU6P6JE9vteI?=
 =?us-ascii?Q?FxfjSVXMId4GPIw/6oLi7xD7ht9gjax2Cclz78XfC3J4NuD1xyRx/8vgxTPh?=
 =?us-ascii?Q?ca5v1gsFMVsJv20dB+qQzsUlKkbZ2halJMoMVQADExR9/vCRlmjE9A+T+765?=
 =?us-ascii?Q?cCw8X4eO7xN5ccNLwJcvMOp14ZjPVQB5u4hXoBAVKfHDMRbqk/dJdnj9Mu1w?=
 =?us-ascii?Q?+05R83Pzkqf0OLfD+omVcoDgIX3aLAianmfo4ksWGrEO0tra7xssZpF3UZdY?=
 =?us-ascii?Q?xYXrQgWCGe7Lg4vBU1SZ9cX02+QBnVu3VQ9t/9EtME8FKZ5s4lcv4uiF6REx?=
 =?us-ascii?Q?VyjhNAcjREzvdL5djQ59Q9G5gh5ecKrTOr/Acgx6ex6JO8Lf6C1sPWgXqmir?=
 =?us-ascii?Q?UUuF8ySvETd99MO7ZaSrpyN8ndxyR/5k7a/fcjdkYkkc3EvK7HYAOvpm2pLU?=
 =?us-ascii?Q?KO7M0hYujmzwg85bzmgpcmqm3gw8S3I/9Otnoe7ehrFNmyzhqd3vuquj+d2H?=
 =?us-ascii?Q?aex1hSoJMxsG9UnrbkXzlS2HYKuOLDL2h0dtOYxgBnsSSDc2RwkaU5qaV2wl?=
 =?us-ascii?Q?g8vwS119TOP63VbRL/yGxKnRohI8kcMcw0c/3Mim?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dd7695-c6dd-4926-3243-08db6b719673
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 18:19:40.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yh43CtW4Sir4f+PafbnkQ9Z+YEd5KNz0C0FBIBfoj1B2MEHK+lexli7GOYjtn62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 12, 2023 at 02:49:02AM -0700, Selvin Xavier wrote:

> +static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *attrs)
> +{
> +	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);
> +	enum bnxt_re_alloc_page_type alloc_type;
> +	struct bnxt_re_user_mmap_entry *entry;
> +	enum bnxt_re_mmap_flag mmap_flag;
> +	struct bnxt_qplib_chip_ctx *cctx;
> +	struct bnxt_re_ucontext *uctx;
> +	struct bnxt_re_dev *rdev;
> +	u64 mmap_offset;
> +	u32 length;
> +	u32 dpi;
> +	u64 dbr;
> +	int err;
> +
> +	uctx = container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_re_ucontext, ib_uctx);
> +	if (IS_ERR(uctx))
> +		return PTR_ERR(uctx);
> +
> +	err = uverbs_get_const(&alloc_type, attrs, BNXT_RE_ALLOC_PAGE_TYPE);
> +	if (err)
> +		return err;
> +
> +	rdev = uctx->rdev;
> +	cctx = rdev->chip_ctx;
> +
> +	switch (alloc_type) {
> +	case BNXT_RE_ALLOC_WC_PAGE:
> +		if (cctx->modes.db_push)  {
> +			if (bnxt_qplib_alloc_dpi(&rdev->qplib_res, &uctx->wcdpi,
> +						 uctx, BNXT_QPLIB_DPI_TYPE_WC))
> +				return -ENOMEM;
> +			length = PAGE_SIZE;
> +			dpi = uctx->wcdpi.dpi;
> +			dbr = (u64)uctx->wcdpi.umdbr;
> +			mmap_flag = BNXT_RE_MMAP_WC_DB;
> +		} else {
> +			return -EINVAL;
> +		}
> +
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	entry = bnxt_re_mmap_entry_insert(uctx, dbr, mmap_flag, &mmap_offset);
> +	if (IS_ERR(entry))
> +		return PTR_ERR(entry);
> +
> +	uobj->object = entry;
> +	uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);

uverbs_finalize_uobj_create() is supposed to be called once the
function cannot fail anymore

> +	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_MMAP_OFFSET,
> +			     &mmap_offset, sizeof(mmap_offset));
> +	if (err)
> +		return err;

Because there is no way to undo it on error.

So the error handling here needs adjusting

Jason
