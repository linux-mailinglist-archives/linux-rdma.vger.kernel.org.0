Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F8876A017
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGaSNG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGaSNF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:13:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB09E4
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLoQZqmgM6sYu+ur0sPblPOkU/py7jn6wM0S39NisSmub8Mm1+ilq9s+6BDeB3GcQ/gircT6ENUuAxC/OmjYwmTVmsamyieH14KMGOX7n8RaJhen+zJhaA8chncJnj+mKzsw1J8cy8McoJptmuHCp9eZmuKCG9OUllMeHcOAlJUeVQK7S4iJYGFeUdoCwni7JdPyGgeLFeBOl9RiYPcJasWw2JkgFIlT9jPkHhnMdp+jcvyE9E+QD1eSUyXStVfYIS5xhHd3kRNOsNrQRFn9t6V1YALHjUmwrXKhOb4GCObTF78QPiNH8UmQ3gZLmCgHIj1BWa+kltAIb6O//R7mkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rebnFwqsaVU4y09KJyE9i+c2gV9ZaIIWKuPBBb6Jy/A=;
 b=KGck3ATHhR4KZKcXYPIUEb1FRwF4OFQiz84LjC+k5FH8L/KB3i3Z6zdeYgZhy7cF3cu03qS/ZG4SkP3BUhvhLbo5oZSKbmWI3PJHe/Nj1gNYRAogY0eTqKOF0t4Gi7f+MZ7iWol511gJai/YrvVRWiMx0yTSWQrD5+JuH64Mh0h2uY1S41Yg2ctXh7ViYMat/Jc0Ab9CS7YxMMlY567Zghu7UjJhooB5bfFi5+rh9TvxxrR9fqt8MQp0v+Fj8pI3m2ZajLNlDsVMc6qp/DQR9baM+cLXb9xeANsZ9/cJHKPT4T4aZyjaZDtacGk9eXcsxIGlFLvslMCsbKI2LAF+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rebnFwqsaVU4y09KJyE9i+c2gV9ZaIIWKuPBBb6Jy/A=;
 b=iQF/RRcpafjzzhw3N+78mFDs9zxHMg3TDcOyJNSZLqeLUoNU/50is3dCWCT3nsGFefC8zoBWH9IxO9X9EHIJjTdef3BKH7f8QBzd/50ndD2T/Ax5H3w1CHDrf3PoT+ukxyINoAPp6u8boH+D4RLJISWa0aYprpG99dyyqqRu/SKcJwAHI3VpLPf1Z+TFKzLFrI9U2HZipYfovcCgjSTrx+UkPcXMbS3363RVtYHv5CR6aut2+0ueMxNr9PJL9jctEAtN+3b+KyfcPkFagJ+2As1OtDqLlN8iVvgdlUG09KwwmB4FFlz2uNDst1Hto8bbNXS4jcJjTCtz50Be3ukAHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 18:13:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:13:01 +0000
Date:   Mon, 31 Jul 2023 15:12:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 4/9] RDMA/rxe: Fix delayed send packet handling
Message-ID: <ZMf5qhbrgx0lBv20@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-5-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721205021.5394-5-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: b6309cd8-7497-49d1-9c9a-08db91f1c693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWeCdlOyJE/4o6VbZKJicllZpjgfyvjFymSbCrPGt8bkj3oIx6rHwYuBOvb2Eaa26dB1ydW+tUSyxKkryRsHhc3UVEtRlLGsSeJNvoI41J3+lA6EgYWLgkhlQDitR9IfBjJtkV+zhHXOgbIuz158UEyf/fx0kKDe1eNL6XZ+5aSsGPD67OCedIyxZID87OfQYLvew36S2HERVJ0G4Wxjddlbue1W3yFEuMnmI7J5qsdeQnN+sRpWor5veF5hnQXjEuzcTrzmIOqeGLPZcjwxOH8Bz+7nvVSbIK/Qr7wqZxbwLNJlKLV1KWnL5aIqxRqFUb0BwUYxfwcyKSYpLEOKBvjnh7V+cJoQzxdUyuzvVGtXQZmuILJf/Di/0P8ZxG8whRZI0COJcFTdkjOek6dvkeQQ7Fe2yLNLgxFsl3hs5jvtH0StGafnE6bjw6RtiDBi2yFYZIIwxTgs5F10bg7f/MwYOVn5M78WLxqRRMB4rB8Ay2+n58VM53WC/loYXAv+puM4fE/c/zfmVQI4OaV8tXUqd2N85qv7VWI7RfteREx5Pxb8cM/FhTHO962Mr6IT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(41300700001)(5660300002)(66946007)(6916009)(8676002)(8936002)(478600001)(316002)(66476007)(66556008)(2906002)(4744005)(4326008)(6486002)(6666004)(6512007)(38100700002)(6506007)(26005)(186003)(36756003)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q94vzjiJh/GlT0p5EVjc14vExKPrTWkpaydEC5aId3pHrKi/bMM7TnvgZo6Q?=
 =?us-ascii?Q?NRgTckT8rF4d/cccvmQKsJ8lzXbW/66g+S25TsfneKLa3gp2xQcji0lFZxxM?=
 =?us-ascii?Q?3UcGKTWG7OmFCmTasw2TdoASgQxbqnHYtysz7QhSlRM4e8WAe5QJj3HPz8Zq?=
 =?us-ascii?Q?OWhdIkKJ/ghhKmdiri9cEfpF8e9IOSclMFJduun/uLA2zBKuNo8puAV/+Y1d?=
 =?us-ascii?Q?0n9tQpa6qop98TbkMdREqndKQOjPtzLuV1D1yYiSFrIfUgstevHdOBCAXL7B?=
 =?us-ascii?Q?9gMNFyC2Xs9TGF2cAiG/nHQln2JQwei89A1PebkX8LHUuRemTswgUo9FiV0Z?=
 =?us-ascii?Q?2CwXPQanxQo2PpP9a5k9+QP2/ozy973SjbP5DABwSsnksUk6vptZzOK5TmSE?=
 =?us-ascii?Q?hHMGv6RMkjKnFoeBWNQP6SknbJaaomYCPwtwdj7LFDiFeg8VZgHii6WCTfKN?=
 =?us-ascii?Q?kV2R7E8485L2GCFZo9/e/ZTc6eCjv0p+Ro6R9bDWjB+kOjJIhI/Wn71QLZUL?=
 =?us-ascii?Q?QziZbGuVKNWUzVZEgm3R2UrU8/b34kb1HxgFbmYtUxsPWzCmgkXlswubia0x?=
 =?us-ascii?Q?PeHTpoScOyjX+Mer23ztd468P7aOts/Lr3FAEj6QNw07pFDMS+CBwZqIKIoK?=
 =?us-ascii?Q?8U7fL1oXainuIWJ2xOWihKBX4LpQDZM2/4EgeeCvTta21+m+f559AKuV3t5N?=
 =?us-ascii?Q?taQM+0AfLokqHjrhhagJonYRsAkqGExNO05SEBIZSjop5pxUU7TAbM5rrJjk?=
 =?us-ascii?Q?Aogeo1FCFEquYlrusUjTZVX6Z/k5Lw+Q4y6D+Xv49k1yVZi94elKoBMjTvmN?=
 =?us-ascii?Q?M7irvzfn4jqL65I7whnPaf4Rop613tjh2HGiFwJgNo2teHn1MxrB8D6VASFt?=
 =?us-ascii?Q?tnjktw6UZmOztV2Qbc9BZttfOwe5w7tEM/Gq3+HHKTLsvSVNDKb3eTMWdk/9?=
 =?us-ascii?Q?mDm+cf0gPDdZQTIruuoTgf7zNxjGBYbE2Lyr/ONS+Z1Joy12drRwofi8ETAy?=
 =?us-ascii?Q?zQ+jSuCLutzzM5FveGR+W1kWOY9JLVeM1+LeSlxHSeYRK1EAzz6txbByT6s5?=
 =?us-ascii?Q?96pwuuj1qFZ364hmNq6C6DGBZ1pTVtqvEpjerdobodqFesRKdgN/jzoKfWm+?=
 =?us-ascii?Q?LbqFlm6DGcccS5nEaeqkNtYCgOHi5fVx2iso2i5Mg5bpwIQ6fK8j+dp0sW4C?=
 =?us-ascii?Q?+mNGvVHug8/NLgMhiuSnmQax/jjJtiDqr4KlFu5+xkdvelUwnhp+RA/S0rcW?=
 =?us-ascii?Q?nOxGk3fujwS2weWTKifCqmqyv0tbwgD2hqVriSjwkvdz99cAD+09HTrjDtjJ?=
 =?us-ascii?Q?jk5VtlnHzJtv+HLjTtiEm7lpOOzcLyGFyJxgLf4XLRODFkxBdurxszG3/aji?=
 =?us-ascii?Q?QN2MUeCLsOTvNU4MIOT4auT5X9cuMYMQtWvYCYiXilEdHDhL1h8YMFehXZvc?=
 =?us-ascii?Q?5GD6yYSrkB2Wca16rCD+thsc06kR/Y9z8vcWLMrxBSx3qdNjAyIq2xggu0+s?=
 =?us-ascii?Q?5wytGCDo4nMTD3xJqK4ho0ueC0o1cKd9p2kar+6GPXZNLRo393cDllEinigV?=
 =?us-ascii?Q?6z6vMWTp+zDYsEVvwFKQ78/HVExJVuxG3IWGrF+v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6309cd8-7497-49d1-9c9a-08db91f1c693
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:13:00.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXe9H6xzI4G+PGnhiLl2pPhUh/GYMIDg4ZNJRaWC0hlIPuiapKe9F8c9lffHduZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 21, 2023 at 03:50:17PM -0500, Bob Pearson wrote:
> In cable pull testing some NICs can hold a send packet long enough
> to allow ulp protocol stacks to destroy the qp and the cleanup
> routines to timeout waiting for all qp references to be released.
> When the NIC driver finally frees the SKB the qp pointer is no longer
> valid and causes a seg fault in rxe_skb_tx_dtor().
> 
> This patch passes the qp index instead of the qp to the skb destructor
> callback function. The call back is required to lookup the qp from the
> index and if it has been destroyed the lookup will return NULL and the
> qp will not be referenced avoiding the seg fault.

And what if it is a different QP returned?

Jason
