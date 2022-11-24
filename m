Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9D6637E70
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 18:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKXRk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 12:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKXRkM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 12:40:12 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747BC14FEEF;
        Thu, 24 Nov 2022 09:40:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1B1Zj4cQhETHwS2MPPum4oExp834C3B3p0RvdH2u8dJpFV04LaHG2G6iOFFen5b3euFRKgxI32UxuO9s3vfgTQDdotF6M4DTx6sDEM8RdyjQ9LtzTw2hoQrc5OclJm/YlfNd9IBDw/YT50AXZU9FHKjdVOab6w8ITd99fx1fOl6/BHpfNS0Yk/pxpUTjmalHClfEIAREBtjUaHNC9wBIRnw/HFhcj+DZ4xNI4c1e9FopehbbnrII/vqdiO71qwLDsLdre8twPEwrZwZ5chc7PuvbGd33oyjAzlFnCx3A2v5xtEO4da/nMnLeTYLhz+iU8zJnKNfSXpKpUsgRzH6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwGtA0e9fFNq5RXud0Su7J/lr+rNmzyop4WpaRpqtNE=;
 b=RvHigSr6bedYiJm2Q6EOwSy3wGjNUHyjkaDRpgaWopy/j6aklfoa3XwQKDM9aCWgUXHA9LD+kjoD5AqzRMHLBiJkoLcwJC+CnGxxSEU/tbeHnlIzhMrtRnsOmgUY2UuA0CUl035C5NllWV28CsrRtKquEta6PJKuai6VFKAblUB9pzTtle6qQJ+EChrhIS/+57jfRtZonSo1whz00wKMCf2f3t43BMJqXs4zICsMrM0UJXYiFdiEySuDCovIdTQfBqnDFb6wICKqbWJ3u3C4tdI3uq2NEGs/gBCxB5V78Qtd/chZ34y0ixj5tT2Nkstmkx4KAdLZ2GmlDvB80AJCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwGtA0e9fFNq5RXud0Su7J/lr+rNmzyop4WpaRpqtNE=;
 b=oFF82I1g91tVJs4txyarFZU+6PnR1sZjRuHMb7HUR5yCf8sR3ny+aWduBMUwXBDueneDnzxEiY88qYvHyt/biVOymDCWxLXlaX25xLiTSS9vRC3oGJQZecquRJVbyueIrou9m/1TVik+Zz8T3S93I/C+rxMDv17p8TYtp6NUEhHxcQ5mqTa/gMdVu0ASqv6AhjnFZ6tVJqDWSPf0t5ydiotdMVm1cLtkZgEHOteML0DoOUuadXZlByO2bjBOzV/kqOJj60SYTJWBtrZof/nuCkX4yCpatnbuJOk5g7KTPeVAiuZCt/5ZelaqEZw0EaNmdukYE0n3G0dzzSUWVxLvVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 17:40:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 17:40:00 +0000
Date:   Thu, 24 Nov 2022 13:39:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Message-ID: <Y3+sb3RZkEO3ISpW@nvidia.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-10-lizhijian@fujitsu.com>
 <Y3ziLoRuXFIOpnnl@nvidia.com>
 <9cf2a1c5-2334-dee8-8374-63453e23c5a3@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf2a1c5-2334-dee8-8374-63453e23c5a3@fujitsu.com>
X-ClientProxiedBy: MN2PR19CA0015.namprd19.prod.outlook.com
 (2603:10b6:208:178::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e6f951-11c1-43e4-95e9-08dace42e966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfzwbMwW9vS76z4aEp15Fo1bUfJ39npBazW15RtlO7jrAoWA2Dkz1GY17krhjtCfR1lkOXQC1/Rcyu6IzzrF2UripVoCsKfHMec9iYD9APRhjzSPwXHyad71Tth6Chix0do2H7Q3+cwkxiBHQkP7WEoe4l0CPitKyg5ptFFd5NELy30dwK2Cyblf2YJZiWuImtEM+ZJ9870ustYgCsSvvDz98wLQ8pt2EPXPUE2q0n190h9jMZ4Hbvi8y8KlAL6xiZXbrt2Sjbhjo1qGF0Hwnw5g5pwtQZrFVGdg7iGP8a46Be53ijlZbaTSDyne1fqEZPKWDtCXusbAdh/zElsbAlpNtl7qmGbxHaMNbnQoLKT56oHq9pqlJgswAOmaBeD2FN9o4NIZF20Zx6hFe/H7aWWgfbfYvnzP0olUhePvGVpMYmTZTbnOMixTG1jOt1ir0B3urcDL5RBrkWbqBuegyIHt++4vU4lUMIioX3u46jlZ0CKWdP/b/1Agb2+vSPHrnYwChiqCE/O5H0a19X3h3BNin3Jz0L6eaZrChoBC2x4skjejmVXBwDoTM07KUr5ABGt28hU0P79QiyP4z65mEMM+s3spTvLnytPseeV29CysWAOYctxdGCwgthuFiMSLHBKKuVtPw8CDAkcYm4G6qIUp0Gi15DbB6sj2m6XG+scHL1cgjS7O+2chsHkI96j7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(478600001)(6486002)(66476007)(66556008)(4326008)(36756003)(8676002)(2616005)(66946007)(6512007)(41300700001)(8936002)(5660300002)(316002)(7416002)(6506007)(53546011)(6916009)(54906003)(83380400001)(2906002)(86362001)(186003)(26005)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cOzYY9SxMH+TS8Dm7xN1aBu4kQ1urft6MDncpjJEJWsHdWUyajkF5WyrCGr3?=
 =?us-ascii?Q?CueuSIojxP7eqpAB6o0giC9PTXB2zkGZQ6i9tKfBj1hbwf8BQ+aQ4GxQJJh9?=
 =?us-ascii?Q?OqVI5peBZ4sOYigVRmEyx7mJMFxQd4PbPgttcO6Yupnj6U+4OPAUYjyx7i4D?=
 =?us-ascii?Q?5xGU39QonhU5SOofbwUf4a9i0tg/4vgHD0Zkae4XyMfKUPpCFo92R20Yj3kn?=
 =?us-ascii?Q?vmOk5BaUFipQh2/GrL2AdDjayspEEJ2ZmHbx2i8lUFx6hB6zdYm4P2o4w0fP?=
 =?us-ascii?Q?U/nvL+6aOrf1+EQqiglVOBkYme3YmrXtCDCq/eRj8Rx3ARf4Ztb+nHZq/ohV?=
 =?us-ascii?Q?/0OLm1M/6Qf32tgUN5Ru9KvfJsAL+LXDE5BfrFMynZbyw5nJj47VNfz82MnS?=
 =?us-ascii?Q?EZbHTLFa7ObjPYgDoLFyhodERQcw0dUpH3UxauJo3wtLiq/vsmAR/966Uvjb?=
 =?us-ascii?Q?bGVN6c7jFRkA0c1cz2JBDpjlHOpc/qzm6kgpqVTD+wq4UKYpQ/KDooHe6pHv?=
 =?us-ascii?Q?9TFl6fUiTARR8joc66VZnKSFCaW2INpU2L68X3xFrftN0fWjgJOYjF2RQwrV?=
 =?us-ascii?Q?kWNYSEWzSWOhClwN1vYNmZgwCYp07tfoCQQWe3+yUdG5f2lslmsJ6UFAbK0R?=
 =?us-ascii?Q?e1bDMh7LncefNvtiDMUXy6S+z65NyFZBpBT0Ohav+BzGP0gTk6cQ+5ylRrUF?=
 =?us-ascii?Q?DeI9JRhI629QIAkGhuJonqQEfE79SLEQ39+w4WMVAJ4YtF3hn5854fLL2zhy?=
 =?us-ascii?Q?zJ4svDF+bShwH5yM7zj4IILK7ewDSxIRizQfVO0UC460tQg7j/Ubr5jRtXQt?=
 =?us-ascii?Q?hJzHmiaS8q2PKqOrZk20fLmbQC6Dbm8J8D35P5xZue/Hrbq8ZM2gdApNd1f/?=
 =?us-ascii?Q?5TINRIYLhthDsq0jGgqdK4AFv5d/1NdEHRZ7LI4LwwzCvE02E5SpeHgWZ2js?=
 =?us-ascii?Q?XZ2hM0vtoSr7wZTpx0TpLy6kwI+NkEadsgPqAmeK1c/gaeJ4QTv8N4ioIXQK?=
 =?us-ascii?Q?ak6VxjkHhT8jXcGUi+CRwx6e1QYylDPb7F1SvWgVRdf6ZqHGukeU3AZHNQLb?=
 =?us-ascii?Q?BuJdjdX+899cV3ZzquRFv9el0vRBWJ3ZgNhmrQ3oAhD8KyrD6qfhram3gJ4U?=
 =?us-ascii?Q?vsiaRB8/uWZnwu9wtZbdeLZzpi+UxEFvFmeqsYCezvcB63MlHiEVxCIFQ0O3?=
 =?us-ascii?Q?7RrqaeYn+nvp5UqVBBDMh++2irps+TFJjc3sWMxB81eEiEdxyhLz/yp8BDUc?=
 =?us-ascii?Q?qwkMNAmt7/w32hH7y/o3+svMiTByyNLHwxoGg7ZhfkKBXJ1lCkZ4fghEa8+s?=
 =?us-ascii?Q?ui2pNKJSHJABWDtY6ua0Zgm4EkwyISRefeeCRgviHcPo5sFe6h0zDII20Bq2?=
 =?us-ascii?Q?Qk01OAz8h/DlT6lf2phYf8sLb6rcRQGe5rgblYzCWYserbeYA6oSPzbLt9D/?=
 =?us-ascii?Q?KJPVoX2sC3VLWHdzKRSAJg6Ozq/zvcarjkJ5+YMtSQT6/lTvr5QSmclyFLSi?=
 =?us-ascii?Q?1M5wMcghzywB3ayLec4hPLXRvMYhVCDd9SWv4/CUb8x5OgWle7T5Tn49Co9L?=
 =?us-ascii?Q?kI68lJ5w3+7h0q9R5eQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e6f951-11c1-43e4-95e9-08dace42e966
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 17:40:00.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDp5cjdsPYiO1o2RCdOlePQ4UuhI13W8UtVT1Vmg1kyMc69mT6eTON1JRtRQTg5b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 23, 2022 at 06:07:37AM +0000, lizhijian@fujitsu.com wrote:
> 
> 
> On 22/11/2022 22:52, Jason Gunthorpe wrote:
> > On Wed, Nov 16, 2022 at 04:19:50PM +0800, Li Zhijian wrote:
> >> It enables flushable access flag for qp
> >>
> >> Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >> V5: new patch, inspired by Bob
> >> ---
> >>   drivers/infiniband/core/cm.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> >> index 1f9938a2c475..58837aac980b 100644
> >> --- a/drivers/infiniband/core/cm.c
> >> +++ b/drivers/infiniband/core/cm.c
> >> @@ -4096,7 +4096,8 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
> >>   		qp_attr->qp_access_flags = IB_ACCESS_REMOTE_WRITE;
> >>   		if (cm_id_priv->responder_resources)
> >>   			qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ |
> >> -						    IB_ACCESS_REMOTE_ATOMIC;
> >> +						    IB_ACCESS_REMOTE_ATOMIC |
> >> +						    IB_ACCESS_FLUSHABLE;
> > 
> > What is the point of this? Nothing checks IB_ACCESS_FLUSHABLE ?
> 
> Previous, responder of RXE will check qp_access_flags in check_op_valid():
>   256 static enum resp_states check_op_valid(struct rxe_qp *qp, 
> 
>   257                                        struct rxe_pkt_info *pkt) 
> 
>   258 { 
> 
>   259         switch (qp_type(qp)) { 
> 
>   260         case IB_QPT_RC: 
> 
>   261                 if (((pkt->mask & RXE_READ_MASK) && 
> 
>   262                      !(qp->attr.qp_access_flags & 
> IB_ACCESS_REMOTE_READ)) || 
>  
> 
>   263                     ((pkt->mask & RXE_WRITE_MASK) && 
> 
>   264                      !(qp->attr.qp_access_flags & 
> IB_ACCESS_REMOTE_WRITE)) ||
>   265                     ((pkt->mask & RXE_ATOMIC_MASK) && 
> 
>   266                      !(qp->attr.qp_access_flags & 
> IB_ACCESS_REMOTE_ATOMIC))) {
>   267                         return RESPST_ERR_UNSUPPORTED_OPCODE; 
> 
>   268                 }
> 
> based on this, additional IB_FLUSH_PERSISTENT and IB_ACCESS_FLUSH_GLOBAL 
> were added in patch7 since V5 suggested by Bob.
> Because of this change, QP should become FLUSHABLE correspondingly.

But nothing ever reads IB_ACCESS_FLUSHABLE, so why is it added?

Jason
