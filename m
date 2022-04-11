Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57334FC1C1
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346897AbiDKQEg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Apr 2022 12:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbiDKQEf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Apr 2022 12:04:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27751237D7
        for <linux-rdma@vger.kernel.org>; Mon, 11 Apr 2022 09:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/s6Sb/hbYgdh1JHMV1ijA+wBm8aKbxUeiCMURMvKlOCXEIim3v/WvW1mSVJDUNK8KUo9TfnX63Valzal9vIanc3RP6PVz03OUSVQpBN4rqSqtStPBM/W7XFvHdvX2MGoF9C+NUxlEvlIEcmnyEfZ4xOiPv98pbmir497iEkn03ckuL9cJVuuus9i+tARbtzhTG7ZtO3nckuQFgwEORkMyXNo1OEo3pp/BF5t+Od5dRu9OhhcHcDCfHDjMgTXVstuLWqGZQLFXRzsOyq7BAxRAJcltCswWH2bYw6XWXC2BZIMYih+i1vQhmNjF3PGGfpZ823gpA1jz9Sfa9O8DW04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEHmb+mTqV8MV4dV8ieWjVhUv2qvJ7TDoydMwT8tn1k=;
 b=G72+64Z54H8WwuBjWpLKfgiJ9GVw8BU2l6Zh4qxQap5E7F5W2DqeWDkbG08qC1WlGIdqWoKmVNS/tXbCC8OQT446Ppd/YOfoLTr2jobC+WBes4Gua+MPnD/lip/mYyUNaJ2xn43W4pExM+KH2zlgmoGkYEyZuRJYQM0gpHor6O9Al/t/L4PuGMptwEzqLmztM9ES53vCfFC57GrAw5eK6qGoFGxn2DF/56zg9lpMP+oJWzsZtN36Av4PZjH4ZeCaOm/Y7frLWz+/fF5YtB7BRs1r5NtjX5IXdqIPt6rqL/GYQhC4RvskzHNcDZT3xnkuPZW0KcSt7IVFOg0f2lFe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEHmb+mTqV8MV4dV8ieWjVhUv2qvJ7TDoydMwT8tn1k=;
 b=YqUoofBQTM5m0NFbalEGqhHE7InuHv7FH0KCSmlJ+OTGnLBFWgksiyEkZ0VqIT0akfhgYSxbORXEsuEqOPN4cLeBdiaO7lOWFQWyL0DTWAMb7SY3aDVs6G5FIXSFmRj2NwI2JHrqXFgA3qQFotth9CnN2s2yl3jEFt3HWd/7hyVTG6DMX7vpbflBmnR0NFyJb79XBTmdp9R0IE6a5sMp4RRS3MpS1lx6x4zPDwzImdNh9EuNZ+IYetHrfp3wdr9L6ZoGJZVFTjeP1kASbrv+NaVR2DlJBUlz4TiL/QXs4YTu9FE4Eik7imkBFkV0y6dGWxrscymmrd2vZivcjiR86A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:02:18 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:02:18 +0000
Date:   Mon, 11 Apr 2022 13:02:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "Replace red-black trees by
 xarrays"
Message-ID: <20220411160217.GA4139526@nvidia.com>
References: <20220410223939.3769-1-rpearsonhpe@gmail.com>
 <ec1de70c-aa84-7c3a-af6c-4a04c5002d1e@acm.org>
 <6296dc52-1298-6a52-a4fb-2c6fe04ab151@gmail.com>
 <20220411113836.GD2120790@nvidia.com>
 <PH7PR84MB1488692D33B6CA7445569DA3BCEA9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR84MB1488692D33B6CA7445569DA3BCEA9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
X-ClientProxiedBy: BL0PR02CA0087.namprd02.prod.outlook.com
 (2603:10b6:208:51::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250a46a0-b5eb-4875-7da1-08da1bd4a79a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3505:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3505C843C933E53FF2B4EA67C2EA9@BN8PR12MB3505.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dv+9JF7NoZLQUykhaLGGhCCi2ViAVReJsWwCn9oLn33A4bZTYfWBgnrtbhUZ02ULCo1mXg6TtwrXGCkNz5sKOZ2+HzVC9WbN6d/BE6RwUiMy21ClQSIAL8N0QDLN+zwHbtEZGVSEfr+L5cIrZDeVqtfDftUoLdHqbA0j+wbBbrBpwzRUUn1kclSNk52VSHCHasuKHS/stD03BDBvBk3630g0N3Rf6nHe0kaXTLzG5KNKGdifYRzbNIpZktUJlCbUwnnGA3e05CCYICVVzG0eCGqW4116v3DkrulJfG6KFixxPRm+XcBB6RXl8xczmsy0wKRIljB4M+aLkRbVMLfbMcAvI5XCGo+s/72GZSbUIUwQkaNpV43P+z3nkpCjIElPNfghcH5SeEh6G3XbnOShYt+M+WK11hX6Xmw4Glcbq7msIY6cWvZtDq3vX1qQhINJCf7iOogVLUS+5Aip40mbuaP4wK5el5KXuF6hs5cHVujHtaHSL7LiDNUxzA5N1DmT7WQ63loGpsDLUUEtJisbJj8kNp+gstGzV8xpdLPBgHcv3mpc5MrpYPu/PPOubXtaeX5HeONals27T5KIQ9x6uLjaJu6jR8pVcfqMnnJ5w/VDdMTmy1z9vRhLBXFUCjhA2yETlKlrJiPiCpl8sCn8A2l1V2ZmiS8gIne8Xeqj5WqR2EDpQPE7D3+hWAv8bIYlJwYja6XEqX2/7dhcGb9C4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(186003)(26005)(1076003)(6916009)(5660300002)(36756003)(66556008)(66946007)(66476007)(4326008)(508600001)(8676002)(2906002)(6506007)(316002)(296002)(38100700002)(86362001)(33656002)(2616005)(6512007)(83380400001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NAUOAikviS1csNoToMsvOhQMm3RcaM8hrBn6+B0Ow43woUpcuvBgYPR4RcdR?=
 =?us-ascii?Q?Ds6QwodxYJ0CxhJLqXOkKSmDy1fchmJaxYkBUJqwd+XaMe96SNAwphlzuSIQ?=
 =?us-ascii?Q?Fr6FXsXtTKymSpL/kauRh+vW7N3vmN/rcM8g/hX15kOlhEr04pGPwVKzYu/J?=
 =?us-ascii?Q?gKlR5QVmxATdsqhoT3fgLOs2bLqvJ0AmOHZG1Qy60YLqBL+g1tBMVAOBWw5M?=
 =?us-ascii?Q?5aDgk8LZAyGr/lI8c3MT93v5wwCg5yHwy3/a91s8QdOdT6YVO+HuugQPqxsl?=
 =?us-ascii?Q?UGxCqA2CvtSkgEIvqkL3naL2fkQ5Qq9JmtsuuwEBl/r0Ia+GcflYA4ZG3c5i?=
 =?us-ascii?Q?GspXQ16icqO9uLoFsdr9BUGbRM3XQIH5Pn093TjVEfLZI5ycXKuhxu150BvC?=
 =?us-ascii?Q?9TNX5Q5lAHCzTzGN96CjzuHXT7s/KB2gwNt4zfbToXrH/amOd7nFJsWqNSPK?=
 =?us-ascii?Q?A8WkVcNZgz21BjNdVMzW7ZORha8YzSPR5QF7P8+5z1tZKxep28zFSiyUnLwA?=
 =?us-ascii?Q?vH1Ja0Hz46j7qUJ+0QiA/Z/cChHuGeQbeKVKuTTtPN564TtwceeIQ50mnWM9?=
 =?us-ascii?Q?N+zCRQq3FRYsIAgZPYvcbiJPSLN+XQfCV50IlCTTggy3D3JkYJac5cucN4jS?=
 =?us-ascii?Q?uW1V8HPnQ70N8+fc67R8TjHvfiGn3+FXD9XCawNvN88145k2aDteqBtI/Smt?=
 =?us-ascii?Q?n366VHiVg4EIpo5iCphcwtIXaY06pMXA90x647/V7JmQFJrfwWUUl9q0sNC5?=
 =?us-ascii?Q?hS5g/51OlcxXPcaPUbOtASSeFUgrleN7FyVWsAojbOswzkru0LcjICLQgdmx?=
 =?us-ascii?Q?cJv9E5JW+TWZtL+POlAD1yq13Lhl5vWkoQBPqFda29L+UELsCw9S+ccdE5Tb?=
 =?us-ascii?Q?QWNN2UbmVIugqlddS+/sF2ZWyeUacXcdfdxpUpTo4MR2/2QaNYkxdIC4Ljs6?=
 =?us-ascii?Q?K6MOoXeW6GtD/gRGQ5uF9GGXqHDFUTtngzqEJXdhX18eno8ya6G8X3YLnSZP?=
 =?us-ascii?Q?pD1bkXZEzdRrVrZ5+frEsEUfiAiMugv2fFNcgm/Ohd1Eqvitbhy+8+/jZx1q?=
 =?us-ascii?Q?ZDoRYUgkPslNthsJvtWI64Raf/za6+4vIzgi6QYX3Myid5CEgnEvrc9EofSi?=
 =?us-ascii?Q?DM6Sc+oL7XMJWl9upSU3bJG6e8zqZ/R5DwiGxs2cQ48BrNnYGZUyPlTQuGYG?=
 =?us-ascii?Q?WyjHLuJw3l7qJgPgVcwEErc6fd/4Q2FGrb0bOsz+lbSD8nO/EhoTf41OchvX?=
 =?us-ascii?Q?QPhnIZxfBMSZZZFxbcC5kiRt4y973OyoHbkrZKBmtkSaRTriOxkA8srBuwiX?=
 =?us-ascii?Q?xrV7xSGY642WlgNryZ3+0BYWc3CXABmT4i+snRe3bePlr8finKUse+C5Vxn6?=
 =?us-ascii?Q?wT6cufXuatJonabn4nL8T7KqQOCmqBDU7++hTfnK0W6Fsp4Axyn0uHC8SKy3?=
 =?us-ascii?Q?Lr6hoBa7f8NhMJ1auy1NJzX2gZimSUZ8RqrDtOHqLiLeh9SESGcWFo06d3on?=
 =?us-ascii?Q?5SuLDrNvrsLRytYCIx2iN/3OqSSYtcyZjvKrYg351+Ut2BTyVx6ChxuB1xtf?=
 =?us-ascii?Q?AHyLVLV9mdE3dYCdvTA5t+ObcGyNz4RfalP1gZeTMC+/OXNJ+AoghgeY5xU9?=
 =?us-ascii?Q?Ea7pEnSTGGrfi9B6nbTIZkiRwZFw+B7AEZMMXnC6To+vLrzJhr1OtodLILZA?=
 =?us-ascii?Q?zqH7LP3miwIZ66/G8bAYhM6GPanzBLopuKkrV6wkEnba7KJ5ZT3HVO/ZA9pH?=
 =?us-ascii?Q?zdjKpqoHnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250a46a0-b5eb-4875-7da1-08da1bd4a79a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:02:18.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otTA1kw3xjpi4zlrAW9UfpevLhNeSKgb2npd4DdS84YAx/CL6m9cKXjcUXBa16dC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3505
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 11, 2022 at 03:52:23PM +0000, Pearson, Robert B wrote:
> 
> > Yes, you cannot use irq_save variants here. You have to know your calling context is non-atomic already and use the irq wrapper.
> 
> Not sure why. If you call irqsave in a non-atomic context doesn't it
> behave the same as irq? I.e. flags = 0.  xarray provides
> xa_lock_xxx() for people to use. Are you saying I have to call
> xa_alloc_cyclic_xxx() instead which is the same thing?

The xa_lock is a magic thing, when you call a __xa_*(.., GFP_KERNEL)
type function then it will unlock and relock the xa_lock internally.

Thus you cannot wrapper an irqsave lock across the GFP_KERNEL call
sites because XA doesn't know the 'flags' to be able to properly
unlock it.

> The problem is I've gotten gun shy about people calling into the
> verbs APIs in strange contexts. The rules don't seem to be written
> down. If I could be certain that no one ever is allowed to call a
> verbs API in an interrupt then this is correct but how do I know
> that?

rxe used GFP_KERNEL so it already has assumed it is a process context.

Jason
