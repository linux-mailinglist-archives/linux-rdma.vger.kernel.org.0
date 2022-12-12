Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5651F64A1B3
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 14:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiLLNoH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 08:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiLLNnr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 08:43:47 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182B2FFA
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 05:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7MktW9LCHTtl2MDzKy1yos8F5AKb7YM4sefTpRqWcUtE3CXAqLno5ygGJHQ0GuRBSbSkvkSRuATKTMNkCzxWK42oVlGSHIxqsWsRLR1YUySpWMB9WT+WOeRBnVYGMv2cRfP/vBeRyrpf26r64i1lCzd4npL0TX/R09IjV1a8JtOthKNhaGdpxtVziCy6FLjdkGSOvKCEpRg+L8YwKqYd0+j5UJqoNxwB2x001r2io98IWF/5QTYaBgZHcTv9nEnSECDBcyfz7CdJPluip/pypSQhDLwNLQzrqTfzeCEOtJ1l6kCAH/Aa0Ho6LT1VBFdNK2dHooyCP8UxtlRfxrohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaKihvsVuFTXVe5seMtsnVPYdAyQ6oNDDUUg6T8GffI=;
 b=A5ugnx3qiEfOAMZpvrJ7AirDHEBAeIi3ddapBHUDAz/EA0uYYp0rLyP0EvYPBOQhPHwyr0OAfsaBQQ0shSop4zjMOZ3maFWX/KvY33yh93otjTaB1BbakF0odIFF7yqm/FlzWF36GaJR9rE90qOr7BqzlgdauGg61aslftM8HedIKK34DWmQ8ZqgkEOyV7Yn5QMiIr8UsoM25mkxPEYCXbalfyFCfF273s+vkVBkPDEk14RdY5v+jJnsiEkHUOLzOrxYnPDQcji3fRSiFEn8GUAq25WYxOm48HYLyisc7Wu9vLgyOUME8P91FMo2V03lzgjJiNa95Z1suLEX7yCYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaKihvsVuFTXVe5seMtsnVPYdAyQ6oNDDUUg6T8GffI=;
 b=TCzwh5vMQbfHuVfG0Iv49ti4JTk2D8BNfryHtNqMVYEZoVQISEmR9EXvAcaRrhrys0S3Pwv17Jvnvf9QdOMtgSvGgh2WaOCL1ba1qJtQA5sMvA2Lr6zA2aMSbkMXrAk7djhmEgnU6KD9yTn1UgXI3V9jS3giVrUoKv8+CLkCkdayiI1Ljr8+enGd/aVEkwPC9ypZc3WmV5quJYQsBo4SMl8ianM84fnutUhBwKjwLAdzcj6TnLUfKXAAuVt+MPeHJpA3qakhb6QoqTOlU8voZjDSpj9NI/lQEyQj1fCe4vwzrt9kYuAfuD7O5aouoD6mzuLcV2Ml3F5KcRoS3hyOxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:43:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:43:25 +0000
Date:   Mon, 12 Dec 2022 09:43:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Patrisious Haddad <phaddad@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Wei Chen <harperchen1110@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix resolve_prepare_src error
 cleanup
Message-ID: <Y5cv+z6cYWUV3ara@nvidia.com>
References: <ec81a9d50462d9b9303966176b17b85f7dfbb96a.1670749660.git.leonro@nvidia.com>
 <Y5csPTRDNOIwf49T@nvidia.com>
 <81008c63-50e0-075a-6795-71ea3d08803c@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81008c63-50e0-075a-6795-71ea3d08803c@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: ef99b6fe-1135-48d8-a40c-08dadc46d7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvEhSQmxHL0SwV3L53f7PpbN9tIIxQO9iGj8yh+vn++MnRY/qSbIsSLGksTQLMRePdfjSoEr07kqI/JNKj3zh0cNNQPV0D+6Lhq7pMIb+09b60+VmGXpMJY6EfbAcFoXBdNL0kevN+sFu9IePyFNAWw1VgMQSISYR3J/Xa5/mmGjQsdTXTatXUOL2cYg9zRKGJIAnZaed/kQZjEVPYQOXuOBBRGbx8pMvTY8aASc6dARtLU/dkoFl8SJrmRpvehV8/cnhZ/dFh+RIKye54PCxauPaLzHyFUzQ2UlDlGmpL9Uz7cR94aigvbzy+dB/JmWDAlxkMY+50FcqzH7Ulf/uUPdxnLyVxg7ZuUr9W0mv5u39heO5wKDrEIbcyeaJCZvXUhXqAjelavY4WRT3wy+qpq8N7Q5KsKaAuSVot3ELv5IAzgdipedOYm0enzCabrQmLy50VPBG5fn7M+PxCWIqu5x3DKY5hlKV6NDalqxH/UQQQ3W69Z0VH8SemzJt8/p4H3ar2U2L04tyrUBZOVBD+1jBL+Xi8UrHgGvWFmKvGLNQoTCJoGUgHuUBFQOoRIv609pSdA3wW1jDheWlhDUXY7mfrW7jC5M5mMQxrc6wYQTUkRbSh0IZBn30HOKGvaUc1T8k7CtCpUc82UPqTegcIVX/U/TRt3VoDQPIE/Z9VdtYEjX7O/n/aCi5i05Qjnk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(38100700002)(5660300002)(86362001)(478600001)(2906002)(6486002)(41300700001)(66946007)(54906003)(4326008)(66556008)(37006003)(8676002)(316002)(6636002)(6512007)(26005)(6506007)(186003)(6862004)(8936002)(83380400001)(53546011)(2616005)(66476007)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mt/gVDAMqKYtqVckJrV0zgt20GljJrUkqfo9Io+lbVvlSpFngyk2Hj92bj3O?=
 =?us-ascii?Q?0bQ8rESOx13XXnqbJ10FM2AomHDZEG98pWD7iHVGsH3RksXpdzgo2lE9HxMf?=
 =?us-ascii?Q?apXfSj0Z1Lpk6J8/zBifj0NujppAXzKU20xTEcG/ZvMU0wAfmI1Mshshnv0n?=
 =?us-ascii?Q?ptexoASGz4ghfhkv9aKcJRLOBoQoPwHPFPuX4WUz4+g237e3eSn7jVY8Qub8?=
 =?us-ascii?Q?Yc6lq6D2fm7aZClHWdHxEZzXEcK1s4mWwgZo6m+YEdKPu+g6I4WLsvlJ1VAp?=
 =?us-ascii?Q?Fr4SwtrdV7t9QsYWJB5ZxelQQrR7Bfuq5YDcMacnr2SenztBa2ozCwhHOkH2?=
 =?us-ascii?Q?C38E7WVEs0Uv744loMdLpz7AqMTEQNhwW3rPsE3pwZvIodU59FnfBmBBdlzt?=
 =?us-ascii?Q?4gZQik4ors3ceuQNEQYjnGaNL9YWWvKY8PjMXjt9dlTAe/i5BBxdRLC6DP/W?=
 =?us-ascii?Q?jlwkiCqnZIsPdvsklNs6I9iFfC5adt3GXWkUPIK0dj4s5//xjhWEp9nBisvU?=
 =?us-ascii?Q?ORin3BqrCzZ7diErAh1N+q6NckuNCZAMh/4+88gViTwVk41KUMuwvRRgDhI1?=
 =?us-ascii?Q?7PozYRhgAtMVHXGWLsdvA2ocr3Y8dEMrKBsEwPrzXiXJhJaXbCA5przaKenX?=
 =?us-ascii?Q?q4kRx4LKW0MlYck1Xl0CtNDDOD3dbdrPLo88eYVQHLax0CjNPjjFOr9WKCdO?=
 =?us-ascii?Q?vcugy44UQwm8MEF6HFYF1MMaB2BiZ0P2NfQcj4lVzbhHsFXRQRyv9XMT9IJ7?=
 =?us-ascii?Q?hfA9wFz6/doOmAoAzUU0YakZ8Uf+CELEP6bTbquZgKkIHxsEpd7skyuJHwUg?=
 =?us-ascii?Q?a0+jkbNRXgwjtW3bXegGxTB0Mey9gGTe5e2pUH/W1aZnFDn2qCvtgfLCtF2r?=
 =?us-ascii?Q?AWeW3CXTDopvpZp9WUAwb3VJ9//NW+7GKJ8ZOv5ntUFoqSJ23AVrebvB8wjl?=
 =?us-ascii?Q?MUu+7NEPFLxQ/YgqmPQIQZLm/VIiN9tX+Ed2HUmKO1SoeX6CAU613gXiKLk4?=
 =?us-ascii?Q?7QdK2nByJzBI5Fy4wspitK3+2NYAIcfMTocRKryoCl6tZqgx9aqy54jQA+D4?=
 =?us-ascii?Q?EcF9Llf0SDQvO8qDT3yF9uq2lutSonJlg2UOD3vJPIIhdaJMxBJFLgO6dSQz?=
 =?us-ascii?Q?Yy7YZtyQfUUjAno8X3RXcMICQ/I54xjdhSwHyb/BCC+Y7ikFx+PMMJa/4uzL?=
 =?us-ascii?Q?Xnz6aQHRKVJ0LfW/fCJVm8kY5tqpgBYsshPHs164ycl71GpL2uyFW8WH/yJn?=
 =?us-ascii?Q?kQcfWHRVGspJZpYOHOZ+L0QBICWXDqZZV+w2luibtx+IalK4JI/FwWruLpC5?=
 =?us-ascii?Q?stvWrxZLDi1KKOurFFJ8QZfGE87dv2YSCCH+ZlqlUKHf1tubEsZRuBSSIHpE?=
 =?us-ascii?Q?0J0n4/LfPoJaIcxJDLGxtXgtL1xGMUEMo56SJMs2V58p97OYTJyNzARhMV+Z?=
 =?us-ascii?Q?WrLnPtckyFOCHmnDNy+KQYoz0N9Aujz+MaGtEEY6tpArBlxio5VJCMQKyoSO?=
 =?us-ascii?Q?qcIfX0UNNoDuOq/5OAXAf0BARQP8qgWNcXXH90OGASFcGn832L/QL3TmzXqz?=
 =?us-ascii?Q?Pq86V7PbWTIrFxdNugE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef99b6fe-1135-48d8-a40c-08dadc46d7c0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 13:43:25.2675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44lx3V6d3KrHZhNNKIPnBNR5snVp8Xw4revdfJRO3yK6fWfhuXeqVo1gI0AzEyrW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 12, 2022 at 03:42:07PM +0200, Patrisious Haddad wrote:
> I think we have the same realization but different understanding of the
> code, please correct what I'm missing, rest inline:
> 
> On 12/12/2022 15:27, Jason Gunthorpe wrote:
> > On Sun, Dec 11, 2022 at 11:08:30AM +0200, Leon Romanovsky wrote:
> > > From: Patrisious Haddad <phaddad@nvidia.com>
> > > 
> > > resolve_prepare_src() changes the destination address of the id,
> > > regardless of success, and on failure zeroes it out.
> > > 
> > > Instead on function failure keep the original destination address
> > > of the id.
> > > 
> > > Since the id could have been already added to the cm id tree and
> > > zeroing its destination address, could result in a key mismatch or
> > > multiple ids having the same key(zero) in the tree which could lead to:
> > 
> > Oh, this can't be right
> > 
> > The destination address is variable and it is changed by resolve even
> > in good cases.
> This is what I don't think can happen, since one address is resolved(bound),
> it can't be bound again so each an other try of resolve would fail and enter
> the error flow which I just fixed.
> > 
> > So this part of the rb search is nonsense:
> > 
> > 		result = compare_netdev_and_ip(
> > 			node_id_priv->id.route.addr.dev_addr.bound_dev_if,
> > 			cma_dst_addr(node_id_priv), this);
> > 
> > The only way to fix it is to freeze the dst_addr before inserting
> > things into the rb tree.
> I completely agree, and this was my assumption that after resolve address,
> and resolve route(where I add to the tree), the dst_addr is frozen, the only
> scenario where it isn't was the resolve_prepare_src failure which some why
> nullified the value instead of keeping the original.

Then fix the control flow so it doesn't do the nullification if it
didn't change the value

You can't just change it while it is in the rb tree, that is racy

Jason
