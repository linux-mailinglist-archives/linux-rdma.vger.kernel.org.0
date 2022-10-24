Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A372960B5A6
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 20:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiJXSgb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 14:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiJXSgG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 14:36:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A8B1162EC;
        Mon, 24 Oct 2022 10:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIYh3rexze2xp1NgF5CqJhTtq3HJLekLvFQHN5zuAngWcJ9v/M1Niv29P+JD4nty9LcYnc+e3zs8rGjBr+HJLPfTK6siN7p4cEOaKpgBcBetnlNUxJIuHoBTISsaGwpAepJEjL6dHSCK6wH2Pdnhp4kjcJCL/12GRUe4bJCqQSvzW+boZY+4obn3vLpVIJkQmJXtYuP1Ptwhm/1D6nS8sBwf/LT+Lex1iQCUHCcVHgNNv3fxMlalDzllYzIzKXT+sa/t7Nk6/QOkorcpub8BaGegK8DPANprrYO+4qinedT88XNhKf5CK//wv0m41q6r0AbB/Qol5FlKpS1xz8inSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kxpyKrSkWucJfYsgJdcYZHfI40qgK6y2OWHKq7kGwg=;
 b=bhFdwSmLRMkoupbDeAdLEy+oYXJUJBkHK8JsviCKX39M+3BZ0BqvCUj64dqnl9vEruLNjlKOQwC/5didbkP0pPpfd7SKrJbuOXc55pGu4TsbCy0DkBHkUhLqSNA+5C6ZggKI1gDo+fmg1H3vjo3UmmO4P11xN6jQZSZ9WOZW58Cekn6sjr8gPRWSbfPZ46qr8RSYhrJswClk8OXG5uSbt9fVXLhwrQogXbNrtBZ8Fa7WVcTL6fmzupN8rXC/XqalBcTnGRTKWgqGyodzZWh6k0BUCCe+TD7edF57qPtQH3dyGPGVle0O7x89pxrLB/Zi3jLQz8MxtQalNlGNQH9tGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kxpyKrSkWucJfYsgJdcYZHfI40qgK6y2OWHKq7kGwg=;
 b=CP4UEfX28+6QXQF1UAfTp0tFEElFevDwVtKRZlZJekKoYUFGvKpaS3lvc6pd/Yg3u5/7SylFCX2uIzubDFo0xLgBwMWLL5vLVj6doYytxPB6z0lrRqP4Bv28Ls1mLNMWa8m9u63UapgZHgdpxOApuLDCkJ1cmAVaB+MUpvOn9LvXIzuUS+fBilKEWA9wfEs6Zp+SNpqH6zJrodUaJ1ZSO7RQSH0o76yEv2JWWVnRFdPH0q5YsZwgA/8u7ukz5qrHxGTRhZcFK9HguQ/LnaHUfXx3Tyj2A6TJUDZymrZZbLkHBkB34M/X36BeJ6lxTNVU8jgQX+R9WxVGGNycLbvGzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 17:16:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 17:16:15 +0000
Date:   Mon, 24 Oct 2022 14:16:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next v3 1/2] RDMA/rxe: Remove unnecessary mr testing
Message-ID: <Y1bIXuP6BwA+XxHV@nvidia.com>
References: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666582315-2-1-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f30a32b-79fc-4f15-13cb-08dab5e37505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJ5WCyt3ZsJ24XY2LueA+mUu1ENp1Jhi0PYDs2vBrkZXv909R167bnmLMhFNiGAvZo3CJhP4b35Ck2FoHINnMNPc9MH60keRB6y/mNBjyk0qJMI8eDw0eafv6i/7ex/VVfdQRgeNEYHje9k4Pdp/asgqG7GCU0vAcbaygbzJAbSeQhX5zlKbVQ6VFFlOd7TuVp0r22re3EOT1qiqUMmnCC+qy65xKKSmboCvA4KMBOUWj/KYMS2trlSRzaHocygVD4fNPux/YSF0DXFkxK8S7ARHH1OSH5nHVqzX57VJbFPyaVi9XucGTiD0RWbtvsuGfIJbHhlIOOO1busoNjhTA5EMyxeHbka45onYHWqOUh1X5nsPB51R7rMmLOsBobSBbb1ILkvYKLxvyHVXx2JhIpMG1pPZFiK5fN6HATat/0IEQt6SRe/DP/auKmabSc/hbXMmI6pd3IXP7AD8zGpjcG7O6A/QiJsnHWaTzN+UXhQa1iaxKJzf0Zk2meVv44iyKkPKRAbl4xib/T1sxQ0q36tPwm/y8bE8j/Xz0Q7VrI2DYUsxawqKUxGUjAyXbBShCng0vD51DwUsjCX9Rr13Ida6X8F0Iob0Xu8cM88T60T0IY4GQvC3wox7Tf6tNA/4zCcDTsLVgxE9E7Eg6vqeigPRLSvG4dX4SH2qWr0/gozqW+tEI3oI302hleA8Ta/ZBy2RsUU0TF1NL44H68iOx/kt3VM2xT4NO/65OqWdzgPSySO9LqnRdOyzhwHmYbaSauI/4rlm2eUNDz/nzpTFe1SSJI+jc+iDUBqb9x0jUF0xbFKODdURBQ2Bo3h1EOIOo3ZhDD6QdQLRuA8XAAyplw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199015)(86362001)(8676002)(38100700002)(36756003)(316002)(66556008)(66476007)(66946007)(4326008)(6916009)(4744005)(26005)(2906002)(8936002)(41300700001)(5660300002)(83380400001)(2616005)(478600001)(6486002)(966005)(6512007)(6506007)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?leEylSZtZRNhfrflBIShx83ZoOV4h4/RIzgp+SWuA9vBpe17UuMssp6ivhdG?=
 =?us-ascii?Q?e5DSkwEQnYCu1Unk9zrb2BXQKZhnhaU71ybGbWQ0P5LkycLuadTWaRIdrzdZ?=
 =?us-ascii?Q?/fyuSD/250GK15mB1vfaUrNgs7YDZcMLbLjPskNsCjOGc55Xd8g5Y0TEKoK4?=
 =?us-ascii?Q?yJ6VC9MZvMkXd4VfviT5HA0i8MvzFBvfhNNPPcDlePmxERCRReJNsulUI2Hq?=
 =?us-ascii?Q?ugJyA1hFbh5pyA9lR/G+WdxDpge5YfMz8OnurRs5e9sOufZCKUnA4s6X0wia?=
 =?us-ascii?Q?+0vE5q2ALO5SLxUdU5C50wjWaolVNWBLodWAB7oDjAIxoOAeYXALmhClkLLa?=
 =?us-ascii?Q?5EjnXTZhsYl0ztHdjspOAh6Z2AunG5V9TaPHwUrJZkN65kla4EaXyHdBTGYa?=
 =?us-ascii?Q?bDMePWgvbBFYFXvMYgZHISVqUE6VpYUStanTaR4wZ4qkksZQ29JXzkmK52jI?=
 =?us-ascii?Q?YusJ4QT9qPrThLi6JfAVcn2B4DhK+/ZbSzvm2VNL5XvLCFtbQbyUkUK3SIZ5?=
 =?us-ascii?Q?ytJNuCPOPMFwP4auGq9EbuiDy4pQVAFt8jCkkTgnt00hfz4RQoxqr0X4QNuv?=
 =?us-ascii?Q?DqTGKwUQAlRUwZBLr9lwD+C2CWiYagZGN6CKofuaRH8arQBBOpoO/GGd5CGd?=
 =?us-ascii?Q?jlz4bQmszMFd6JHhajZxEN7nKdtwXxnj2gwPpWRM4rSgqkdH7EaSGFGO040d?=
 =?us-ascii?Q?6DW5V4BfT6JabBFP7ZZZTSDBpfn35OE/jHEnva92fdfyAQ3WqZJeARri5Oyu?=
 =?us-ascii?Q?Z+AVcexGaALY27scR9Ka/dBohNcCaZcU4OpdyodUUW4I+lWBjUr2eHEY4YZ6?=
 =?us-ascii?Q?9QDRLLPTVahekQctIJ7fMb26QqxSSMcHJ9GxOrM01IbEHLn9oq6azK1K/g0J?=
 =?us-ascii?Q?VnCFblrJcfWabj3QaGH6fhkpYuJaiAhajh/z+e58xqnUPvlmwhcvWX4RVifk?=
 =?us-ascii?Q?69NnsTWanmSmmfPpFMbbVaxUHUxuWAWYr3aTjV2PnEWNlBEFk6bpWUiTjRd1?=
 =?us-ascii?Q?HihxlTTFx0gZHcGV9kn3pnhP1XtjuydazlQTaIyletqd3Q/18WeREJ6NbMxe?=
 =?us-ascii?Q?PZWQyuzdI0GZEh7dS1sqggD3m5B9Dm7LVu4e5gybbKI+wVvu9SL7U2rqhHBo?=
 =?us-ascii?Q?iF61mmynaxhjolTcwkA56BPrJADnH6Xc0i3F4pw3eBWIlZm5A9gvdUTde7DH?=
 =?us-ascii?Q?VpumS+u38AGlHI9cF0rOOhSm2tv7loYv+F7qwwLrD0nNcQYP0AGYE3/8CfTK?=
 =?us-ascii?Q?HM9iPCC5wY0wUpJqJDVeiGbgQ1mJz8gie43ozyVCCOjN827tt0K19xrtUkfN?=
 =?us-ascii?Q?GmsCJD1F8I3uC88OnHKQkq6v2BW+rZ4MJ0tuRtZ5iXcBZdHGyftLfHN64xmd?=
 =?us-ascii?Q?vfOr7MdMWVDRo6h/1cjSVZDedGmbm9grSf1yrmzIydKyK3bdlE/KC/Aj+QaM?=
 =?us-ascii?Q?xyosMFZ/VuHNKcCraa+34Qda/fpnEOZii8w+9Hwa4OfitVqdjGH+bKEcttb3?=
 =?us-ascii?Q?MDoikocHXM1qxMrSMur5FwYkUOijToMwQzN4s2fYp2XUfzTQBMoyNMUMppDH?=
 =?us-ascii?Q?xj/LQ8luGwrL4HF9BQ4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f30a32b-79fc-4f15-13cb-08dab5e37505
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 17:16:15.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ySh9t8l/kC1YmW7wx9Hnaov4vkntQBvoN7l0xOv6hV4put9hq0koRIMwR5NY/u3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 24, 2022 at 03:31:54AM +0000, Li Zhijian wrote:
> Before the testing, we already passed it to rxe_mr_copy() where mr could
> be dereferenced. so this checking is not needed.
> 
> The only way that mr is NULL is when it reaches below line 780 with
>  'qp->resp.mr = NULL', which is not possible in Bob's explanation[1].
> 
>  778         if (res->state == rdatm_res_state_new) {
>  779                 if (!res->replay) {
>  780                         mr = qp->resp.mr;
>  781                         qp->resp.mr = NULL;
>  782                 } else {
> 
> [1] https://lore.kernel.org/lkml/30ff25c4-ce66-eac4-eaa2-64c0db203a19@gmail.com/
> 
> CC: Bob Pearson <rpearsonhpe@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> V3: remove WARN_ON # Yanjun and Bob
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next

Thanks,
Jason
