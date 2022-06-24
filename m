Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CDA55A487
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiFXW4K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 18:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiFXW4H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 18:56:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A768988953
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 15:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKAddifXaqCaJxHkVZRlMIH96rBvJ7f9iZX2bzC85Mh20uHSlwKqIRIQbn+4zl2XqLty27Fyu7+fexC1mqz34gpAV2jrDCh3QNxTMIf7nrM4rLe8FGcPgTMDGAKjm06Sjg9L3FMFNyQbK1XIsAIEscJ7cxMBylrkKYh/JnIB7taVXJl7sE4tHU/4o5zyUWv+aV7AV1fFLS8r5sp8jO451egLm1tvEs0CuW7iKuWUHI+xKh5gjgGl/RwuP4Nbs2cF/tc/KCXbV4Ck4vvbC4WXe2CGt2jx2fGFxuPBs5i6wqm7UFRlSepnwIS2f2fv8ZOHtsZ7mtqeRXYIW817fqqODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWLBhSdUSTTaay51p3Ey31EEZbyeRhCbMhc2wjcx2IY=;
 b=dLxMUv5eMHy8SEt0DEwvZNtIv0sJQcsvfI91tQWMGeDoJ22wBBqe7tk5v5wQiWcVRe7ylYBb5AGSDjzXzs9DpB1o95GmAWUyVvg5UYXypTUJKO871e7OovKYE9JNcCIF0ZH+JiI1gVxxoxx2uKTuyAwcw3x1FrV8toxheGj1BcJAxw2vtIu99o0u7JW89phaxbSPYwBodf9ChTQWOtPzeU+loNGBV0jFcwKDAoEi2d7A006+/VczRIleeUacPjEBEnJUVzRSDnxEZc47tCf35grhhC6gXZkEcF48DXXxb2Rqb+NvJuTghyxTC3AXufNYVZjdAp0pnkwZ9h1pmWuvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWLBhSdUSTTaay51p3Ey31EEZbyeRhCbMhc2wjcx2IY=;
 b=pTQ8R+9hdMQLC+G13VC6EeRICABQ3m1I6AhrkqttzWkJbzP/A2jwq+wcpfF1GGI1UwVTBxv5Yu20VkYzeZ0d3AIThW7KTSBexRNLYHQDis35P1pTfvWYRPQ26mYz8hOZaMidGfdK1J4WwE1pqhtAhPqJwhAuPnnabDUi9Ff9fku18LDAX8wh53HflDXO5gFX6DGcwFoCAZ2X4Q7rxIwFjK6JHhehSHPV85zTInrR9bIgRigzZWCUQoRY5Jb7ae8aZCvi6PsdvmBCtR3U0BM+Ue8vb+U2rak9lFVggiLr4aaRu2w2AWBVVDcaMbtwWPY2m0OPKZIsaCOWsp7bgtaDog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 22:56:05 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 22:56:05 +0000
Date:   Fri, 24 Jun 2022 19:56:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Remove useless pkt parameters
Message-ID: <20220624225604.GA303488@nvidia.com>
References: <20220623131627.18903-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623131627.18903-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: BLAPR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:208:32a::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e0ec07c-90bb-45bf-898e-08da5634b7e8
X-MS-TrafficTypeDiagnostic: CH2PR12MB4151:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9kygjU37stVX7I4/capuFHl+aMAMxHVrhrMZn6WTAbRL8L4N85hi5C4HoR0NtUZ04uKdqMaBogoQrLxIJmvnB11Iy/tQ4br59kuM5bNMVBdk+sERlDX1Fp/7otF9kJ+5L8dTl30gPLG4BgHANc11MIk2+UejCZu+xmexkAK8nYnQRx+XBrOY4rPJg0ZPFWlfS7LXYcOXDZEyCL7fktwbr+HUiUu6nHVsiLH3gJENNjO9Qn0YMrYkTU06MRkRc94d/m/CS05bW1vMc3iEh+KgeFmz0yFn0W0dbTKDN5h8Oz/d+Bt2/jIkZCJT7PwznLc57KSAhOYNafltW3ABymJn8K/G780QuGeVwM84mveddNZuCgLmUkxRQy8zLRdA4qFLiQEVp0zs8VWkpFFBkqrwyQQRworXoZVP/xuCFeZ4+qS4cQpPPzQ4fhP5yw/dmCGmJrmrZ0faH/ib+EO3u7A2iBPQy1th9Zwb1hpMtqhOnqd4sh4haTEZSOIhmntrFTzMo0LNIomW+K9i4M4+IJBg6ElU0QkCquSWaekYUcXaJfOfgUCFBFCgNgaG/BwwiiOnjfhQvPb2hWy3rdsTdT/zOBLxM3wKhX/ban0RhNITUZAutRfAzg7m3T1qmkfQ083GrlkOxUxT8kcPj7/Zk9HvJPZL6gHKsrmZtOnb02udTliC6TyKDIaO82woscuALA235j0+f7wGCNXTB73RTeJAzDjw9pssqZS7CWoaKbYQkaY+XNmgmc0LR0cfJKEenwhOGpZMI4dD6n7xpOMdcwGFYvGtg19N+ON3qzr4giH/aM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(478600001)(33656002)(83380400001)(6486002)(186003)(4744005)(2906002)(5660300002)(36756003)(66946007)(4326008)(86362001)(316002)(41300700001)(54906003)(8676002)(66556008)(6916009)(2616005)(1076003)(8936002)(66476007)(6506007)(6512007)(38100700002)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cZKvNb1iawg4MHPngOaumEGuxjddIQ4mHtcPpWCyQEOfQyaaSx7TN8ZL6g2J?=
 =?us-ascii?Q?aA+CRq5IQ3MYQMWc3WwinVhcJUg9OU/VYe/YGXv3Zl54ULB/lO10VDtcza6m?=
 =?us-ascii?Q?6w3KuBPSS1cPutSK67yGvfJghoWklzBopx02gwpMmqr+Goc4TQRwS1dtnjzb?=
 =?us-ascii?Q?4YcABFLEVhTg/3bBPu5/CWe6vN7JV1wE4zMcuNtf2DyJb5ZY5nspi/vZbcwp?=
 =?us-ascii?Q?Mpg452BMu5Lms7dWnERXiXI1vvuI5qlXWgmG+7DoAnzyRj4IhGDIk5X5hV5F?=
 =?us-ascii?Q?FSvpACCd6mmLeX9T96NhFJsdzKOeL2Y9MwvKJ+CjpYA98XwupQFF0x6ATW01?=
 =?us-ascii?Q?74hwNCD4a70pdcSwLXFCcYrAZh0FETZBYGsz92KoEfr2VoPsIfi62gAbiiWt?=
 =?us-ascii?Q?CwzUX+sKxoEb+40ke9xhVwBl6yuRoGbBelOhOvthC5+kzeD+EnBoFXne3kYP?=
 =?us-ascii?Q?POvsrILx00DwZympoRR/sGNEt3nbaebHnBhueCGY7KDw5m1TA7qosQ5vm5Ih?=
 =?us-ascii?Q?2W57uxO5FH9UrOZZbc3a35BAAW+rr15FhYdPFR6KhGeI+pi9suHoQY9O7KN3?=
 =?us-ascii?Q?pbJBIH4vN0Dl6BCTPOG5S4Ke9ZquPeK+kOZxZxiQUDOmGiMuIVW2/cNlLsXo?=
 =?us-ascii?Q?Q7UpZS3v121woj5K22F6Ro4C3CP+z9FaKda2/dYpB1MFH1/qHTdu9Lk9KBWZ?=
 =?us-ascii?Q?Jrjv2JidDvpxfmKohTSfGwWXvAANIIc+p6QNoqWapZBUpIkIBaXxYBYavfMb?=
 =?us-ascii?Q?ImYFw9TxiN3itTG1lhDzDNvzTryn3DmSBXSgqvS25CTHdLovhWTNIC7tX/6P?=
 =?us-ascii?Q?Ia76EMsMaUbEFn7usp68ktD7vKyygjvmtTqDxlDlg+93sMUq35n36MJ/8cv7?=
 =?us-ascii?Q?Bm4I6ydqR6W61NMiy5JhAKo+zYQbsZSlwGlofIeBsKk6V4niwWGsYTkKz7We?=
 =?us-ascii?Q?hdyaKwPjmzjmJqE/78LWWqxovHgTWK05V95wYea1+y3+zuJ6msFXByUnMgSm?=
 =?us-ascii?Q?ljQ3tgANlED3OorbVW36PLnFwktM4SZLZJcckKsyKBrIEBOJvuXoxDeeldvZ?=
 =?us-ascii?Q?cudLDnDexj0dEGUuUm4RfCVAiARXB9I4hGlXMrCSSqGGJvcsGgscBTuATENB?=
 =?us-ascii?Q?PCYkbQg6bWkMb1vN2WsZ+ch71AI7RsUw3apdIdxuRDGtZC2VMLYNjFI7EOQu?=
 =?us-ascii?Q?GWESwnWPFDh8Aix2Grobu2nUzahJV0QOOTe8OieQOfmGqi2gP0fPRNZDkZf8?=
 =?us-ascii?Q?WZeJRtSUANtvBWboe/s5OyTVMB77uOJj4Q2RaF+kRGzkX6h2BrIJMCcvlHXW?=
 =?us-ascii?Q?9eVBBu0VEkw6Enm3Yk/Nss6Y+pJVcBmRnHmLBdKWZkUxXD8S7niyBB2g1emU?=
 =?us-ascii?Q?pAiWEiJ8vsOvgZmMr9ob+f4G3zyfj7NlJKjcPLliwktBwVpKM6Ihkm3YIYAW?=
 =?us-ascii?Q?iAR3+BV9dWu3fA+iVT7HliNRRQEEQ4ZTJ0eb/PNOQV/68KUhOqAcmW2DMn92?=
 =?us-ascii?Q?JAilKqQRhK3t0CZYlP7kbLhCjV4jSYZMcFPvsV4YusQ7k4xIA2955Q5i0CWV?=
 =?us-ascii?Q?Fsk7soPlDpODszDN6iA1V/NsjNVFVw8Q7LdIMPFw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0ec07c-90bb-45bf-898e-08da5634b7e8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 22:56:05.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUevF6oRQIsrlBXSu7QNBo15p8FPs61Do+lSSp27lH7nTnIlEJwaGp4V8EA+a0qx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 23, 2022 at 09:16:27PM +0800, Xiao Yang wrote:
> The pkt parameters in prepare_ack_packet(), send_ack() and
> send_atomic_ack() have become useless by the following commits.
> So remove them directly.
> 
> Fixes: bf139b58af09 ("RDMA/rxe: Remove unused pkt->offset")
> Fixes: 3896bde92d03 ("RDMA/rxe: Fix extra copy in prepare_ack_packet")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)

Applied to for-next, thanks

Jason
