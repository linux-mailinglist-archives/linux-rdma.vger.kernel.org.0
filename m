Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747714C2098
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 01:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiBXA3C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 19:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiBXA3B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 19:29:01 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D10437BEB
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 16:28:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv51n0mAr7WRuP0ilQv2sbppxCqsvPMoB1MbI2o0O91DMOFx9IeNY/4X9VakX/8jBER3qbLCq13TowAr0KMcoQq2Drf7a2UeuM2eLs99eSEIGFlvjGQK9kltGBk5H8ZxIaQWWC1lkrTz2df8nSwJHsO6mqgaCWHhpX3oCCUQBIAw9eHnc9x8fFzRcJwRVOikVuL8PsM5mmdujLSz6GbH05ekToS8sddT3EVMX/uF//jYp/vAEac97vaWZknGyQi62DRmTheK87cvxMjuvvf3Z+RC3M7pM92ZH7sDVzI8ilwKL5BpyO9k2G+aG0NffwWGKeWgUtULzd6Q6chIMH2Mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSqO+fn3esSTokYvTpwXXmrQd+EvNdnOKeAXJd6PYs8=;
 b=Pf2kE5LTAbAX71gk4KGpfRqFMTG36VfdPJ7bOOwiHuVE5m0pX/z08KQ8S663GEiUN/5cljQ+VEZU9gUlJOxVNelZnGcjaYgzxWklxWK73WGBbXQE75nSXuh4qpygoxK3Ne33qcyLmhwPiq4PDjEZ0QCMr97RnDpaDZTETitW9olAQk2gJTw1rk28nl5GOsfFPCPQ55CSKRa4aaahpT8/Jfw7TfrOOhWHllXPTejTCJ38xtkxRyQ6Wms1Rb/jpQr77VPk/rATFaBpbw0NaOsd8i5ZIZT1kE9+zzHykfA0V8sGYGWr2dCWIQNHLmZQ+HQTHUCYSwBZQa79BkWeXbuTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSqO+fn3esSTokYvTpwXXmrQd+EvNdnOKeAXJd6PYs8=;
 b=OQ9VgiRFCJbTRceshxeIXBwfWb/lZLaNi06yqa/+Q6cWz7myVIwlP8G37Gy2eTgnFA2Nd41MyYrq7l4dyCamYbOCywaQR4gnsxKzkYFIP/svvvalfYyN+FnWwEHOijvxHlxCjNeJpQwkDjLdAoFWNV8ZvvOgvO8s3WA/whOpZ2NeMTNjXlZ+l+ZcA46PrSaWWof0JI4qoiFAiUbDnODWouAEdIjyPv+t2lxMXAL0Db2i0J9KjZoYtL5jUdymlMZWZQir52wgNb5vQXdcWr+JURCzYR6ezldAnwupQ9POE547zxInOxX9JuYBPrKmIh7yARIvcKN8kHulB0/MU74PRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Thu, 24 Feb
 2022 00:28:30 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 00:28:30 +0000
Date:   Wed, 23 Feb 2022 20:28:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v13 6/6] RDMA/rxe: Convert mca read locking to
 RCU
Message-ID: <20220224002828.GC409228@nvidia.com>
References: <20220223230706.50332-1-rpearsonhpe@gmail.com>
 <20220223230706.50332-7-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223230706.50332-7-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:207:3d::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 049d3fc3-7e96-4a94-8973-08d9f72c9504
X-MS-TrafficTypeDiagnostic: PH0PR12MB5434:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5434EB078AA73D310FB762F8C23D9@PH0PR12MB5434.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxbwZShOs+pBokODCoMPf0CxRvBFSFtMxh2Gr8iln5OnQFq32mNbaaa6/L/r801Tlv9BR6XsQkIjWTDP+XZa2c1p40VLSlnt/IjjudabkDFnVRplE0onc/c0/WFm9fRfvWEB80TyKZedW2tSZHt1qvABtW+TCR3dM/4bY0aWh2ckyBTudT7i7CbK/hw40eBoMFg6dRdGjneP6l6QwIjpxCA/Z2/iy4XRF2698PMwHWqrHh//lpM+ilXlsvFkmoSeUuWXUwOKJl/E1A2c/GhgN2/f2bsqGJudvN1sJgk/OkAfWaN1yRlVI5Fr72qA2MsQn7/vk55uK4aAKm4Ge5cqBm3dYsQtebl3WNd2+n65ESreNr5LCEBiBKL0mmFmgX15objrPsyDVFHm9Uq9axhHJabWplP8T0pySPSQkXfocNTA6wbjjmZdm2X3jiouRSEU0D43GBPWb6d74WfD10g+07WHf210AwVuahzzuAZ7MuFaITRTShU8sYl0Q151+DLYLIv4m3+5fgjh8pp/SlonAn9PNYJyE3BS/wrUIX1JbSZgY1upQE+SXaaSLWuQUE4R04YCqyjEhVtBpJGFl5b79xZblerWftG3Z6YXT2Uk7DjMdw3oEzJRK7PdBuJP0NP95honGk2UW/h+YEKDuR8o/EKgxKJJbGAj/xYgqYLk/4C5W+PpBjHYIfxPneKSzXFH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(83380400001)(86362001)(8676002)(33656002)(2906002)(36756003)(66476007)(6506007)(186003)(26005)(6512007)(6486002)(1076003)(2616005)(6916009)(508600001)(5660300002)(316002)(38100700002)(66556008)(66946007)(4744005)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2LhtzelXn+9jZkYeDC0+28HVCk/NRsxgdgKVO3s+0N2zm56WGCCW7yeekUVp?=
 =?us-ascii?Q?JTvIrsyzT9yAGE6ahqO13qYZcSJtAGS+UP8MD46swZEQWbtbIv8N++isz6CV?=
 =?us-ascii?Q?mgu1eCadMh7yuNY/qmmDo/RH7V0WFFP9fUVQ+BhLisHqD5+P8uVO3i/xqsvQ?=
 =?us-ascii?Q?/TWjHFQhkcdt18EMWvgv3uLNXsMRZXrPwlMotN7A3JebPwaUgOPApDSS+M8r?=
 =?us-ascii?Q?g1f65L0JpL6f6xECqMTcUCBitkAWA6KwfRut669hoKSDFYFKGy9qW5RSwvCL?=
 =?us-ascii?Q?aK/jcwrJbfQdqo48eNftSZ5YUlfmtVfp4Crly7rJB0iqukLwnGhptMADQGSK?=
 =?us-ascii?Q?BjfAGYC2LtAqshMfelESa6PLJouBmCF7Mnuv2g8umqj9psg5EysDGQj/Sq7K?=
 =?us-ascii?Q?LIJgqqkmLAaIL3M7qF4euwhWYQ/1+Y+ZPH/NwNzHOEKh94ICsfRp8imwmfuV?=
 =?us-ascii?Q?5JeRzZQwlL6wMS9pgO1tyZVxVuWYfDHuy7w8J1CSnN8et0gS+95hroFLmDwS?=
 =?us-ascii?Q?WKj/dnVBHVAG2Vh6C6Jj2sIaY5ORUhE2DKjGTBoXu0D4pT3RWEgkTL9cTCSs?=
 =?us-ascii?Q?IbC2Q+WiV7rIK3QplKvczL1CrB4nAh5G9l0I87SQ+0J8r0Krku616mU1Zm98?=
 =?us-ascii?Q?gpjgBvOOUnXbh5Dmz1H4b3k+MW4oeRkM2JJ+l4ndPhYeHm9k0shI894EKJxb?=
 =?us-ascii?Q?QqVu+Hprd5fppRj/aRQJeJvR7L0IcKk3UkW8FN/xEEPGY2ZDqeFXdfk75Q8N?=
 =?us-ascii?Q?86nRADX/R0yY9FafrJxkSQ5dqbgGh9kuovkdyhItWwYymBN11lFUghDBWzzw?=
 =?us-ascii?Q?cpxEtbW0vmGpsYB13o434T8hopa2ZZirmczURmLkapVS3DgtIhYOlgXX0PAp?=
 =?us-ascii?Q?bgga+G30g+638thsidCH9+HhUy8c+e8cRTZRtz1JpX9MslN6b/0DJZA0j/dH?=
 =?us-ascii?Q?jXTUiFGlimkKTCg+7lwptfUbKqfcAkQLQipJo7W9PG3HC+q45227pATkORn9?=
 =?us-ascii?Q?z3ppn7nUseA5cM1voncmBSHcE6r0x0cD37KbbeP056U0iaI6e3LWdVRBty2m?=
 =?us-ascii?Q?hxyZTqcbjDkNUUA4bpd1KgLa5nLqfP/+OgNhSJbp3H69yVEMdp+NRNC8OnfC?=
 =?us-ascii?Q?kTad+zXoePSR9i+uq4+Xsa1qizxWmPJIe46kEN3KUELIwAsmbWT3piweKGYu?=
 =?us-ascii?Q?ecNwSR5urQpl8FeFAV6Ltef7V5wSindMnrD55g9LrWXSwSa9pGzKcuiDYtsP?=
 =?us-ascii?Q?fXmeqylCyia/s+1cWoKMmMYeb1ffyn9n4DnIfkt3Mu4Ur4ga0tRHVYeyrzut?=
 =?us-ascii?Q?zchPnTtV8adsiX/GNemWbX6j5mIh3HVNaD5khrTEV4YMEaSrx1YcTVGf269E?=
 =?us-ascii?Q?tMgt7BfP/K1dkkBVXh7zYtM/8DGkgjhtaKCyyPJNi/ermULE2FsrVaugyLlq?=
 =?us-ascii?Q?jUAUe5jB08Th1FRUV85OQWCibs84v8lFhXDZXSMszLeXd6yRlzQMAQfVAhfc?=
 =?us-ascii?Q?06stB19HbTZN+1G3JyNM7TTFUvf8PnDdBYIOHyCvTyTDETIMomNRDHGXnOHc?=
 =?us-ascii?Q?8pMNDHgRGi+4AurLmwc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049d3fc3-7e96-4a94-8973-08d9f72c9504
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 00:28:30.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xj56ifFLhAvKLTtcWTIuUY3FZsZ7rW1h+BHOFxGPYSlxzOwSWzldINh+BLCzCQtr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 23, 2022 at 05:07:08PM -0600, Bob Pearson wrote:
> +			/* schedule rxe_destroy_mca and then wait for
> +			 * completion before returning to rdma-core.
> +			 * Having an outstanding call_rcu() causes
> +			 * rdma-core to fail. It may be simpler to
> +			 * just call synchronize_rcu() and then
> +			 * rxe_destroy_rcu(), but this works OK.
> +			 */
> +			call_rcu(&mca->rcu, rxe_destroy_mca);
> +			wait_for_completion(&mca->complete);

What you've done here is just open code synchronize_rcu().

The trouble with synchronize_ruc() is rcu grace periods can take huge
amounts of time (>1s) on busy servers, so you really don't want to
write synchronize_rcu(), it might take minutes to close a verbs FD if
the user created lots of MCAs.

It is the dark side of RCU locking, you have to be able to work in the
call_rcu style async cleanup, or it doesn't really work.

Jason
