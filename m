Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03654714EC9
	for <lists+linux-rdma@lfdr.de>; Mon, 29 May 2023 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjE2RLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 May 2023 13:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE2RLB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 May 2023 13:11:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56093E4
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 10:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFx+wzsPpNKGg9AYf7tOXCIzD/2Pn3CPd90LQipCk7JsqGDt6kzJFmPrkKD2eu4BUsoNzl7FKlloM8FIoLMmlpra2zQUhVpWh3iXqpL62w35CQyqmC5QlozJ3cNI/6mo7krMZlXaIKVc4AYAEdFgX6EU819rTYYhRhvGeD//leLeLRLH48xxzDLHSMSnRc7h0sFqnEFgCAzNLaRaz45XCvHDyWyzYQae1kGhhQg+pw4ceis2hbGiOTEkUUX6Cg/yqMgZPJkRbTw6A9DopHBNDqWI3rpo97BYKLSCvCtZjOngwD20rAjltynSDw9ihEyE/gVr2OC5HbtV3lbMoJaEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOZZxu4nQ+a7ugIo+ZTdPRg2qEuKEWeQYbtCmZoSyI8=;
 b=PawvWK98aWLlgiQHh+j9SBQtRGPXdW4fBXLS9l0CTPdjN6tO+q4D8BwJpHnZ6upO5c9pYK1q8W6Iw73v287aTR01BsaXK+F6wj5AOYEQSApdTGMdCzUSURSj9x9V1lZptKZx8rY1fOthVMLmdz3wqQA69V15oPeXWblqN00OaupewCHLf70MXCnVo7IO9XP25nMejYhVjqC7z7fRLPK8SJXpYuw7k7dIctBGZzSLo6l/w6EpcsrtBFwbVyR3RWosNfKgocAPxqyJm9MAseg161vd/xGhCV1nrw0sLNrJHH1z16LtFtkugwuvC2KixjeEgJll0Jp4T1O5RWQ42TcKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOZZxu4nQ+a7ugIo+ZTdPRg2qEuKEWeQYbtCmZoSyI8=;
 b=rzKMZHD3nwlR/TqB0Un8MD+B79MtdbCOiwaF6NvgWF5K4w8SAdPXZVAIE0UQ3RScF46otdLqon+E6CmQVZ/ZI8a8zXu0o175mtzTZecThE9iIU2hPnABEdZPC0OpPxA8UGuJH5MWNK4kZTNEKq0sIJwBx8MQeWtylKU6olvhdn6eLuiWNtJhiXr871qK5MoxEBbxB7HVGaD4dIDoCLdcpBhmofCDaQaACOQtGgQ8IvKebli0rXiv1mUk2Bs7kH4Dd1s1kb9UuaYvyu4SFUpeyMZCJwO0JB12cbV14C0uP2qYxFHyYaHmeC0NlYCFEOnJJaHoU/bK8MF4QjnFi5mGaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 17:10:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 17:10:55 +0000
Date:   Mon, 29 May 2023 14:10:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/2] RDMA/irdma: Bug fixes
Message-ID: <ZHTcnSeIIjTrSLzj@nvidia.com>
References: <20230522155654.1309-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155654.1309-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: BL0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:91::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b7900f-d818-4e54-d9fd-08db6067a9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9ZaC30OEXPGOzxzmeClQO91QQrkGRsfG9EHFa3DGX+TIkvor7DoE+VvHbXp8K3Gjiu9njy2vHPuHyB5whB0Wv4hbzboJLTBp6mbGKY90roUHibqO6CgY54s54mudmScfMR2rRba1HIpA1H9cDq2SBsrfqI1X2Ck3ZAHrkXKkcGGKSwgw8MMixGFGv/dHeIssCQrpnWRTFGo3IfVRFXmjMAH/yp5v3vOHygoDGcgAdsxEpv63YSn1ZMBA15sBa+WZDzwnaaQcoIA2oSD+BEMyvatr3Q0gG93L2nxICAaxNK/g6MDZHVL1+mPdTaYyOglyS3ZwAuyZjvzSZ56YDj4CHWalyz3IUISYnnrMRnKo94M8H8mWNA87W36gju3XSkQjMFYoGxBA8WZM3uBbWnjuAxnm+d2Epq8SDWk4xKp39Z+hruXWpI1pkwjkd1+9ycYhKISwGjv7qs88s9C9E9sR5w5jnlkjEtRxHLIc+AEecFoqmU1DJqye/ifzsnJL6oL81W+Flwy9mSgMumzXhoNIZynPNHR05jHtJ1D1fkO56NpFz4tejQokGwgzapnWuZs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(38100700002)(558084003)(41300700001)(316002)(6512007)(6916009)(4326008)(86362001)(6486002)(8936002)(2906002)(8676002)(2616005)(66946007)(66476007)(66556008)(36756003)(6506007)(26005)(83380400001)(478600001)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gsAwjCg3XWViq1nXqpJx6pm4YnusKCH2n8Zo5BpB4+AHlzrdyD2FNhPbfXaO?=
 =?us-ascii?Q?k4PouQivaF59hel0jsOCSBC9CAIm43zp+13XzFAf3M5TR05EhhCl94RDBiKW?=
 =?us-ascii?Q?YGqSwAQiyPvO86aM9Bqgb2E4grXYSSv80uJkd26siWzyMz19b2x9Lz3+HMxa?=
 =?us-ascii?Q?k2JPOQEF8NJqlVdCqiox6AGuBvUFefVs2fplHp2eH4YYdRmd1nmDlEGT8CI/?=
 =?us-ascii?Q?ZMUBZopLBltMHdGCUYddRFGY9ltUe81yghd+u5qgixHhtqdMGZ4daGjEnLFg?=
 =?us-ascii?Q?vw8DDvd2us30XaOXVhR13NwYwQoLI+dJ+hNXkZ6qWwiuMq3YITyZDq6PzWiz?=
 =?us-ascii?Q?vN+JdUN3hglhk8f68vNckYcaFdCvh2CgvbXlZfTZnIArH65vnZtxngQi5kfo?=
 =?us-ascii?Q?0nH+oHEVSJHsZN/GPIGlgyMUOaVcyoN2yEyACrd2oYpsuU31ezkwEpVPxnNP?=
 =?us-ascii?Q?0hGo84DCaNdX3nKtUt3kUtoO6PZgc9wdBUvpwLs98Zr0QdI1cfksxt0XAtzv?=
 =?us-ascii?Q?Xdv3NSrVtyCidBkMD1XPMbePj9rZjArrYfpVlgVGNK0fNFYN8FmZJzRZDeu6?=
 =?us-ascii?Q?hMhmSLJp5xkwMGd4mOlji7yfnqwnQ8ZysFpc0E616b2A03/uDULQR3+qEglO?=
 =?us-ascii?Q?ZN5iyiNcK34rYGBDbHSWOovBUiyFpwg3PC8HBEs0qZ3koNNqJaOpBmD7ajB7?=
 =?us-ascii?Q?VDuk/fUhtUpGvG4SnbcRccq+I4audAii5Nw6DHC+SennVQN5GfmpaUyum7CJ?=
 =?us-ascii?Q?Xevf/LGjBSATEqKKx6bprj77ACeSAstWWig//lFScQbpDdVYZVqU/nMmvKqr?=
 =?us-ascii?Q?HJlsdfCsK526Ezv+OhEdYUqvwHxxvCmsVSLYAqlI0rm2l8MUwjz2+VnrXOCa?=
 =?us-ascii?Q?o6DHef/0jzBT7hKunKs6iDcCX1b3+CATWQjaha14BlAkhBBMAtS7A7oMbZcM?=
 =?us-ascii?Q?bNIWZKKtYlNcFEqzHpdqS3FwkkcahLJpNQLlmx4CQDoUQ58VgdzvIGw9zsuF?=
 =?us-ascii?Q?yXIFvNk6tOdvIwOMMdA7U2XbYTmJAfZUJfP/K4Lj1ypLFfnRHGfo5uiAVm2i?=
 =?us-ascii?Q?GCJE7m3AKc3heLh2DEX1SM67XU3vKpbJAbxaAAgHNKmi2O4RzT1Q7LmSllYr?=
 =?us-ascii?Q?azn5n1R5xWu3XcM7P/FlFzTopUmeUcyQsUpDJhqxpYEsj+iQaMB8n3KbS4aF?=
 =?us-ascii?Q?exe2TxhY2yhx7yuE2BCyaUUl1uiHxuDIk+ysx5B5oHnXhCO/zWl9XuYLt7Ek?=
 =?us-ascii?Q?v10K/n9kpN+gwtad+V6inewgNxwYCOQ3OmyRnnvpEintvGDvD1Mc4hHKAOyZ?=
 =?us-ascii?Q?Bh9r7x+3lmAXQC8whPkDhTj5Q4VEn8tbiG/UzR08ucxBy3cQXZqYO0TOLXaE?=
 =?us-ascii?Q?kVnVRlBEIuVviEIePVPgRVY2bmuniouTn0/vRG/vOK2KkKgJJeiOQ7Dh5Gew?=
 =?us-ascii?Q?JN7dafueHjrbZkpYGnL5V1xTbGJE3UCxIMh/fyEPkNO5ziYv7nYbPWV/tYrA?=
 =?us-ascii?Q?9w+bvDr/fzOFM0BsZ37pu/d+9bV2MvkejRQptr5Gpn2Ajrcooo64wR0ArdD9?=
 =?us-ascii?Q?leiYeYs5Ctzh3zMvz5RwCArbO6YUnoToqP1rHJRQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b7900f-d818-4e54-d9fd-08db6067a9e3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 17:10:55.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bW7Zhn5PVW5YeXopa8m72aJLYADI4/yeEriKH0uuZdur0067xE9wA+1VcAyYh7O4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 22, 2023 at 10:56:51AM -0500, Shiraz Saleem wrote:
> This series adds a couple of minor driver fixes for irdma.
> 
> Mustafa Ismail (2):
>   RDMA/irdma: Prevent QP use after free
>   RDMA/irdma: Fix Local Invalidate fencing

Applied to for-rc, thanks

Jason
