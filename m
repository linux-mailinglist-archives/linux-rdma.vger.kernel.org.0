Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3E5215F1
	for <lists+linux-rdma@lfdr.de>; Tue, 10 May 2022 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbiEJMzp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 08:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242095AbiEJMzO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 08:55:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0B55BB
        for <linux-rdma@vger.kernel.org>; Tue, 10 May 2022 05:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxdlFlr/mF+E2lBLPvZeGRqTHGN3jubF24YceZh4OMVkGDZjFY7GpQ3P4CxYCtpoJJrnRC+HybIHSb0DiXlszYZnpAPtYWL/vcusUcbu7d6njcoYAqlbsi5DibOj7UC+PjS08uV1CDdlAN2Tz9BwWpVB0xGB90dacQUzxQKSF80oeRKwnO2FpouCJRmQHQ4oGnWrc40g5scvbYEAyz4KSe7oH4Vl0plk42wsGtYFvvU25MIubibiythsSOESDEGag//0GQtsGEgUCeqjgo/YnSe3RBUNTv8JvOUmSNqIj5G0CuwaS9bCetcDhAXn++n/MU/sBxvNImXuAa4xQT8a9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGmrhLMBPCCEGS9lngDHua0aiWudn1grPCkGrsh3VKI=;
 b=Aog53RDFTmTi69CM34W6Folr7biENeN1dsRIiHCEfwr8qSTkWVrzLc1xhPfuutxgQ3EClbtyYnNOKtGl/teAMQ4d9ZcpBWJerEl9r3RVxEh8ROC4eo/X6dKpgoAf1gQXAfl6m06JjP2t/uizWsL9Q76arBa9b7DvYtx9Tlqq48Xr+uciEZLJm8+X97AqjwAkJlQiDC66qur+beL0t4eyjmgQri1Y4wdkXvBFLKpfUztCLp/l+QSNYdk33vzlaFirHL5nduC1H+NdL2ISOQUtYWBL9sqSgGRd3EdsbIKKSKpDQe9Dyns8K3Nf5xAR4ZlDGZjW0VQEc7dFXCHuwkaeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGmrhLMBPCCEGS9lngDHua0aiWudn1grPCkGrsh3VKI=;
 b=EkDnoixLzb90e7+ZjApv04kN/KFZ+OQEzNPg5t47yuZxIC6oZIibMnl+dXwl40J9lYwK9wm21eNlBNhQY7Z6stmLA0jI8f8CxQ/3pm46OnnI3Zcgakc+1SrAXXGzfsBNjVlKpDwYcOtuZFB8QVBcF2J4SLiwbboalEohXWKSbVuEI/TpvD3SSUh7IjJlpMJNQu7zD9OZdOXPb3vvDqc8WUcCidES6SuW9ECTR7870Vy3L1H0t286UkgYUyE6VPy6FQLk1GicE/hq5Ijx7Jo9nKXxDYNBhD38CrZrPUUKs8kCD96xn2tWdSWERDqEHPgtzi9BiHdZjQm3f7YjnIGndw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1279.namprd12.prod.outlook.com (2603:10b6:300:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 12:50:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 12:50:40 +0000
Date:   Tue, 10 May 2022 09:50:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v7 00/12] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <20220510125038.GA1093446@nvidia.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421071747.1892-1-chengyou@linux.alibaba.com>
X-ClientProxiedBy: BL0PR0102CA0017.prod.exchangelabs.com
 (2603:10b6:207:18::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00321bf5-e281-41a3-489c-08da3283afd3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1279:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB12792EAFFEBA640A0860CDD4C2C99@MWHPR12MB1279.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FO0jky8P4262+1v8QHQBYi3s5WFP5rKSz7Oibxvg3WBDTn/868GIm3swJyQWOWxW5tuWzn43stQ/GPizP4WC/U6wvL8P1GSID/3AoPo9Pj0bUacDjg9yisCirNM2qx+y12JH8hEeW7M7mRBkxZ2lWS3gQtfpGd8w1rB+zWLpkXmpe+bcNvbF83Mlic6dw5dDCclbgh+Cv8u5qsabCBuTBAnv/UqaaTELjSS1L/vO+BptXZv5kFgn9L1tRjAhuQc/gYBk7iHl5LUeibyqzruergNcza5u7Knke9rlGL8Dn4+5c0zi8fqPmJPrMZIpG62QVf6hZTifTpqwtUlV9u/s2t75ZCM9Jcr03sRCO6U95bYFA5QCHYWqEgXZwCZNLp+UZz+qxM2pv7+A5DLIjsqgcHOQ8I5FRUKOLd+IO9MNJ6jiZyJHbQxMfVIUtZpolIsfU4CM9bPp2go4sMN76UQT25z1zWNIc2jAsCZ7Yp3subveUNLcHEc80Karg5IOQmuzfh9bh8Db5C8G76hjECiD3UvJ4XovhEoWEcbj4Q4t7T1ar81y6OahdrjUuy/oG3D7xnkKeZqvingcHNQ8S/FlCwNI9kVnclvI04P/EdzkABE5UPDKMfXNZi8XljNP9VoBK+RymaDi0+92bmA2qnHPbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(1076003)(36756003)(86362001)(6506007)(2616005)(38100700002)(66946007)(316002)(66476007)(66556008)(6916009)(8676002)(4326008)(508600001)(2906002)(6486002)(5660300002)(4744005)(6512007)(26005)(33656002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ep6RwnkRs2D/eVXsPc0TrFicsNWCQHcgyUHzrnYSVztly05oBCiHx8q1CDFn?=
 =?us-ascii?Q?vhixcg441kz7XQKWzy1quNjYlXzeVP0EtCaKPWshv86E6Auc9gsfsHZrMago?=
 =?us-ascii?Q?VgwHiTSSGLjtPr4PuzRAG/ZT9TtIwlQ0KaT7UQwPAA08KEh+WXVjrulAb4Im?=
 =?us-ascii?Q?j5xSElZ9tgVDGQHdNrZy17DoCIIbmntctNOG7BbP8TV5LpfCnN24mfd5MVf3?=
 =?us-ascii?Q?x5gqHtY7by3upTcJP/LePUu9FgfPPj4sm4GrZZmQ3xoRx0VlHxztlp3sFSSF?=
 =?us-ascii?Q?qqyutX1BgCYnf+g4p4j40R2Us5qkfUxHwvs/lhKa+V/AtdU0Sb1njCyDNUkB?=
 =?us-ascii?Q?6Q/mtgLrTH6a9kW+MjqH+QXeWCxwPOUjGgf1geExC8nao5zKJF/fWxfNs8Je?=
 =?us-ascii?Q?vN92yeh2cg4bdiHlETH4YjATGdwV8Tu9LsZM87R7JSXfraw4hZnQ8/SmXTS2?=
 =?us-ascii?Q?o1OSyfTFP/P6fgqDqgnBJapgeqdcxS/oju4pAOZ9rCzk3CDZDcatN3+FpWr5?=
 =?us-ascii?Q?A3imOZQMYN/DEbzsQbIXztSDCn9/Y1U+lN2hasJ38b6BM0OAjkiZBtSJJSx1?=
 =?us-ascii?Q?c8yIMzTtfPmgvyvLKLeDATPdZ+9v2gKNveEJ7ghVI+GN+dngy6ST+G4dQ06P?=
 =?us-ascii?Q?te1GZbY4Fi4hS9j5+XLsTySOG20lGpxuIQr3Kw1DNtKcr0zimPB2wLBLOGTg?=
 =?us-ascii?Q?Gl5QYV5AQGR/FUV8A9ZcIbYItw8VmqgI9iOJpOTYRshMrso9bieX1mORVftz?=
 =?us-ascii?Q?kyuhP+6MT721mnp7kHEMEUBCJ5QP3viyzvITlomZ74RkXMgLjpYhWAisGW23?=
 =?us-ascii?Q?a9l8vCUmH0MAkoUXeF3+RbD2f6hL/j3hnvX7s5V2LdMs344wNgH/1oRuwr7a?=
 =?us-ascii?Q?fN+Mk2Tbs5g0eVrOrHJ4/iGI8Z3Qisk1lRnk2zi1L9zmBAd/6CCtI0uLyZ3G?=
 =?us-ascii?Q?KBayBjjUwEsQNhXYpMi6JS4M1jtt8UaVqilATywpmlCetpJQudGmKGkcWm02?=
 =?us-ascii?Q?5o8FQlJA3PmzpzeUvDZqXBlBZFNbCzX7IXR9Wtnc5rhoQAju9uym3WePbUg3?=
 =?us-ascii?Q?jrWfxG0RKkiu+lBwgC8I5idmcziI7Ri51W3SaKMyQmkRBJoEERpHGvtVcIvJ?=
 =?us-ascii?Q?GmLnk6g5BTbdut7oO+4iz9Ja2eFW2/NZteY3b4lIz7lLY2v2Qyzdhm7gO1PY?=
 =?us-ascii?Q?0lRWDKSgF4bBX5bWW6O0PlvYdRE4V6ffNrnv25bbLVEgMi+sc0Zv7oQ8izWM?=
 =?us-ascii?Q?rqIPguGyFYHhMJ+ocl6Sgmo5lAiDYbGKQGgS+HeAJ8Lu7+4GL667eNiP3F9k?=
 =?us-ascii?Q?L+EhIX97mruJU9vJhOQwHb10szf87rIDSXrGkYbRLE+8lSrc7u+LqxjIV8lR?=
 =?us-ascii?Q?siYGsQAeHH+/UXQz2l9qnmDnh+uqZrftOlyGFtEADqpOaOf6aRNxt7yC9/zJ?=
 =?us-ascii?Q?msmLS5CLibhBvkLlJ6JGkb47FnzLcSjwCwnk9uUdVtXWdGmI+IYeKqvfNp5T?=
 =?us-ascii?Q?c9IwyCz0oqGS8tqgsgoLDND0oQS3pbc9aPlMLxdQHrWboix3YovSpWdntCRr?=
 =?us-ascii?Q?A1nPCH02hJp7VKAuVQSv2v4jrQ57ivC5PgM41HQQZ8y8RcarfJwq5u9+i8uz?=
 =?us-ascii?Q?h31K+A+H0xr6NDReXk721ryRNF5WW8/aNHy9tm1iP8YHVqVOW3d2J6JUX5Ya?=
 =?us-ascii?Q?ZFMfC/uz6O6AM6BhsC2qIG9TiNChHzkN3UcEq8cspeqRe8d+HqUqKv9fAEs/?=
 =?us-ascii?Q?n/bmyx0e+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00321bf5-e281-41a3-489c-08da3283afd3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 12:50:40.0966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSy4AU9f2sZfedmvISegloNNbl6ifgSLdc/BIb2RJNAPnErtLEdJmj3FpLmTe55I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1279
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 21, 2022 at 03:17:35PM +0800, Cheng Xu wrote:
> Hello all,
> 
> This v7 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
> which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
> userspace provider has already been created [1].

It doesn't compile:

../drivers/infiniband/hw/erdma/erdma_verbs.c:291:8: error: no member named 'kernel_cap_flags' in 'struct ib_device_attr'
        attr->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
        ~~~~  ^
../drivers/infiniband/hw/erdma/erdma_verbs.c:291:27: error: use of undeclared identifier 'IBK_LOCAL_DMA_LKEY'
        attr->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
                                 ^

Jason
