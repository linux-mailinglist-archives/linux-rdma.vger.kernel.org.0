Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB03705BDC
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 02:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjEQANt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 20:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEQANs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 20:13:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDD2189
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 17:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv1MxQmVXlPDdi7nhyFdWjQ2APrCfGzldK8GOpGq6T+wGrEp7UmU9gIUQ4hcS54CXFpISJdJGX/pBdCBT48d1Pd8vjo0laDRsoSw2WHOVjPy2DtUA4jA87sfDXygTqJhxFcNWkSUIoVlmeJzyJE7xEgR/Gz9OGXCXiFkcjc1hmziE5beS7v4gYn5kNG4L29EvvqaA8b7+oztOoKvNu5L0ZQlxAQYIwxIxsKBWbhWK/27fGzEFEc7jKFAjUH+9t09MiDX1tW4lwxWQIBm7QUDKgSVq7EswleOpLqJCYJSdkeHziz0fuKXj1oe5h4kfDeQx4NCKudWa0IqBEHNPswSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJF1pPwSvdWJw6Spijkr33l8c4fJX2tJEWyNY6jNdlY=;
 b=iwUmH8x28Oz+QRCJ3e8EdqJEVF/0H4zlwVebahz7LdA4Zs0zV8cY8OMRUnjtOp7cE8YJSmy4MyOz4QTAyq2JMsgTWaW6tPD/BMOgha3yBKD6C+kGyTkoR7jdX5fbKn0ILOdLUzOl5CMy2OdZyRf4vXYUkGKCkCK1saZVPBxqtsr59vDcVvFDm9Ly5k5mPyWckLIQD9VSf3MlKR20GT0Yx5gvm5+bhfDiX6gPbsr2/OsT/VlFy7rwySHHTRFAslTL6DlZUrlB0TnnJaoBwH1xRKFgIKMlF0v8FDAH07LUjmcTkCw35BCv3DbxGCcG7qwCliJ8af+lRTBohkQNVWEAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJF1pPwSvdWJw6Spijkr33l8c4fJX2tJEWyNY6jNdlY=;
 b=cpnjmJWeXii6/6h2dQbQZzza8RrNQOX25yHPWUZe6nUr08wwrpgz7GStoMVQ37qvd5jiwg+r5IcTf7rX8UwJoEWZb1uRTN1Rf6VwDnmhWIWkP+j2iyPUaRM6h4VP44yzzc06fAFAzP2QDRHUFOVVV/76RBDkzeUfts4pIWtiqqXSDhry5ZcxP5YagNHa3b1EJwpfC3lvtC/idKGbcEOnzsP8zjVvVj5FswLpdgdXt/wk1N69/GBQbzbZ37Ouw4knvFm+anuSwhGihlcW2HHLcx8GQWsfJRR5tnaT9kciAHoEOUulsV2eGXoPDoX4GjT7+rtCVe8tW2dOOl4Iifp0sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 00:13:43 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::94b9:a372:438d:94a2]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::94b9:a372:438d:94a2%7]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 00:13:43 +0000
Date:   Tue, 16 May 2023 21:13:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ynachum@amazon.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
        sleybo@amazon.com, matua@amazon.com, bbarrett@amazon.com,
        Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/efa: Fix unsupported page sizes in device
Message-ID: <ZGQcNh3b/9xzlt+u@nvidia.com>
References: <20230511115103.13876-1-ynachum@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511115103.13876-1-ynachum@amazon.com>
X-ClientProxiedBy: MN2PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:208:236::29) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: af9dd3b3-394e-4f4f-3f74-08db566b934e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMF0aLxdp2zvQSD1Q3D4q2CQdMefAokGP+5NhauWgMeMwgHcfCr84Jxj7h8C4G/h+lmHlfJc35yNkPTKsrUct/bdA8qIhueRhC2gvf3h5yMD/WIt6W0uFhwlmp0yaAKJj/1PZ8YvW1kPEveWrfJ9IqoUoClbj/6jtHaVxOUfzTPFmo5h77GNWcsTzFgtQltrnndAcCKrjoEmwu4Dtehzg1dD7TuSplRuOGIbvaXEnLY94yKgxYCKy8+UD3Ro781PYHDyUwJRtWrSR5C/Dkz9OCRJhu3JoJRtX8Il8EUEvjhUpxPPMKQ4fEG6t/38TOeGieb0jcj9NXkLFPgVdZJ9a2HAdXOphi2FT/+RPgrAJtLipcwf198XiqvZI3p37H//kJ4xx7E9z8LpZCs1EDlsxZdHASxrQbfmAuQ+6/311KSZbbYKuY2fRq/Gn/PopvpGkBQZu06hRhupcpAwgmtIszWggaSMDL3uaOrN//T16kXUa7wmWZ3txJBJM2cFYD3/eCElbOA2b9RCYjlALkaIrlgyAQUR9ybzqu8n+FGFTY7hDo5K2eVBvzb2fSObLYRB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(66946007)(4326008)(478600001)(6916009)(66476007)(66556008)(316002)(86362001)(36756003)(83380400001)(6512007)(2616005)(6506007)(26005)(186003)(6486002)(5660300002)(41300700001)(8936002)(4744005)(2906002)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TWCorvkiVdV8XahSf5tFRDaYioibGrO1tjH23YN+bB0MPE6wpaEwdJuRvEnc?=
 =?us-ascii?Q?HZax1VRd+thBpMDdR22qxlnC0bo61TVNk2A5wn2XFHjO5cG+/XvDEMWdlzcM?=
 =?us-ascii?Q?HllHgnnnCdKseAExsGe0mDZRgyOPT7ohchWCOfbSdSQuyQYKwT51j0XPkJul?=
 =?us-ascii?Q?Vh6kLc7CLwU0GHAliA+T3XpHZ8jPopotyiLWR8l4NceSu5sDl02wfrZCKCJv?=
 =?us-ascii?Q?x7Nm+cc8lAoQJtxVNMaQpvtyX2Cj13hhyCXflVLtRzYaFPEqrObxY9EXS7Po?=
 =?us-ascii?Q?LxRYyKK6bfk7l/lUsmY5Aydsp/A5HT0ue+g+bmWmItoiF3B+3pErzmuG9p3C?=
 =?us-ascii?Q?sdBp4BznA8pYpS53aHUtFE8QQR1hfQYDxYYQUhfj01YmYHGhKeyS4L+GGat0?=
 =?us-ascii?Q?y4sLgHSeCE0pZ5qWZUNeWgo3fVLAezs5FdBKuefqyds+lJYB448PrW9tmf93?=
 =?us-ascii?Q?5Ca3kdeKuaQ6SJQSMmSMPsyqkZg00QHLWzpz4QTeDFETmMLt15Ih1vEtuj5K?=
 =?us-ascii?Q?8cn2U/DGIPKfaJCfoafpon9SwpWk1UkukpYxFG2XoRYPlfPMVOtJU1dBWg8z?=
 =?us-ascii?Q?v1Rcd5tGOh4xdWElGx8JsSSUsiwnYWwO9s2pnT3zy+ab0wSL7AFUzA28ke5z?=
 =?us-ascii?Q?m0pnDgrKHdnzBNqA/p5Er4ggNzPNlAJ3lt/IE3cbq4zgcQwYSCz4xi91qtQL?=
 =?us-ascii?Q?VhMV+i+BE+43vw44jZDVaaUx8FghLf1ENJ/u/QHNR1Bdq2MfWHVboPFbxTuU?=
 =?us-ascii?Q?dIwpAzwZNhz1RSSY7bXfgpUKBifI1UNPR1Pwl3uydpYR2+UXxN5Mq7QgClB9?=
 =?us-ascii?Q?Wk9GX9wQDV0UAD4BeKwbIyg4REDAVzOSVNKJFR27V//vyJkqqqxdKQ6HXVJ4?=
 =?us-ascii?Q?dXvy49VwF38Gvt2YHdKxTGz6aPfuDbc9X1VZnLsGfHJL+AJVdej7uKY6MJ89?=
 =?us-ascii?Q?7tJnM2fk6MuypSHHlSfBIxg4yrcK1HdTqSf8xdHpEg1cDUFQdARMQZRx6V97?=
 =?us-ascii?Q?hXuQljVeQVgttbV92tQnNa4pykRVVT1r5L9Xy3mDx44QZY372QWRIREjADoM?=
 =?us-ascii?Q?iiKdx74WRoC2riIDDVVIf31v9TMMxzMATgW+btBitUDv1lsk6Zwdp81s4TnO?=
 =?us-ascii?Q?hMYXMNUa9pair6+B1xWPtQUzS7Fj9cKGsCCr6AJrFk+Iwa/nqqrwivX8CTiY?=
 =?us-ascii?Q?EpC/kmZzSJ20cKHE44lPUTLDvGlFmenQnHiUSkA2gVFvWW6KAPaQM3grHfv6?=
 =?us-ascii?Q?NIHiplWPSNpS19UDvGFfaJC8HiIb2QVuF/RrBIB7r5yomtoflFhx5PdWw4MG?=
 =?us-ascii?Q?xqRp9bG3EzWSgYwN0I5GfnzK7ir+3eOFpblzda/FWt580SImuC2H2NyOODQR?=
 =?us-ascii?Q?ubNRyYUZU7zZ2ZnaQugmB3fTYZIfdq/6Y4VyHS1ejNsDI+Zw/U6/BxgfygP+?=
 =?us-ascii?Q?4NKoNA6LNSlbkwYi751/EOtrI2evj/kl96EwovMfQDG5IB0yyBNLWtl4Ei5D?=
 =?us-ascii?Q?jv0lwSeK1j8OEKglD3s1R1VinF25By/zkb5I7xEe9+Gr2YYTQGjb+2Q87Bcs?=
 =?us-ascii?Q?DUQ2rFxNY83xTl07BRYtq+oT3T8cxAe/gyuDbA2m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9dd3b3-394e-4f4f-3f74-08db566b934e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 00:13:43.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcXix1LNI39PObiaOy2Ed/SLuiqbhb8NnZWunTK8Xz+VXOHPPr0h3xlWhY2lipeG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 11, 2023 at 11:51:03AM +0000, ynachum@amazon.com wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> Device uses 4KB size blocks for user pages indirect list while the
> driver creates those blocks with the size of PAGE_SIZE of the kernel. On
> kernels with PAGE_SIZE different than 4KB (ARM RHEL), this leads to a
> failure on register MR with indirect list because of the miss
> communication between driver and device.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
