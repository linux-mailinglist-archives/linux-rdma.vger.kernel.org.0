Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011384F9C06
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiDHRy7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiDHRy7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 13:54:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF92103A
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 10:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EukbWzYmnTu4guzAZ0XAKsd0N/pAv2z1fkfjjjCmnw12HZLEMUTvjZZQT+kKFGCt0IvnOR1P0T9EeK63UgbQoUqdWfgfHPJhi6VClP02BRDjo0vZXHKfiekDVNAA0I0hYPTyRPkuTmAGpg/mYpeJdZEmMC/O0MwNRHARMkFVFg/bqYWR0PaoWkSOHMiRnRSf+ZD1RTf4LS4S04Wkuayt8DGljYcPn8xSaAUrG3IXe9GmI1rQrvSiUzJb3JO400l+V8itCPWRPR4jABedwPxMDLbKqVbll7B9AvDaCZyvFzI/93eVZJ9hPlDWM2BVaeIrqPbQmjSxlFuCll4092wMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsLcUGmyCaQze7USVpaORo0tl49+/KVqYxjTpvw93XY=;
 b=bRkb+tHT+N5ifzuAkoybjxuQlKFWztAVC+k7mVFt5ZuTMmzImMKV08wTdPL+fZSQyZqsNW5DyLZ4aiYuTJvnf9HPlJP/7UKelkPMNSU6utmWkZrdBMQBnynwtCPuycW7c0gRDMrdKd7iUe74/JuFKwd+4lAcmQXpigqkaLFj9B+schQM0Lehl863mNVtTpuJ8L9N+8FxHdkxf+Nut/cdG0ap5XtYYuhzt1tT8SCVVPrmVuyBZAAObt+Z7nYuacWr073c9lYnTkIhF2JCVkMELJkFYi6zQdiNqeUEPej9/TK7cV9G2fmJSKM+iXMmyfWD9bN1m+s0UtTsRm9XlKt4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsLcUGmyCaQze7USVpaORo0tl49+/KVqYxjTpvw93XY=;
 b=ZdJ/zZMzPwXcJ7CL6S72+AgtEQPxbQctrjcPiCUauXGCU7N7ty1vooSyfBeLRbdFAlh8T/UNaLEOFNwC535pIGNmfwtK1Li/RQpDtKG3qzk+jRgkq1OXhKwS/O0CrZ8JJMR3eNiw+hnFhYm2YGGgPDrH7/wjh64JFXPzQbgKTBueBwRQKzsiieDoSZYcxzsrq8tmYj80AaY7+nMaCbWHn7gENaAwORe/qM1V9x7q5/EKMNl1H85D8kEabjv0ElyDvxg+uMoaGygYXAKBEnbsIYb1/FstnzAEZTE9CQ12JeAnQSof6+ABoJsRm7Nz5iS4ThMli+r2HeOPCmACcBKu+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3753.namprd12.prod.outlook.com (2603:10b6:5:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 17:52:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 17:52:53 +0000
Date:   Fri, 8 Apr 2022 14:52:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v13 03/10] RDMA/rxe: Check rxe_get() return value
Message-ID: <20220408175251.GA3644777@nvidia.com>
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
 <20220404215059.39819-4-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404215059.39819-4-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 868cb5e6-1264-428d-4081-08da19889b01
X-MS-TrafficTypeDiagnostic: DM6PR12MB3753:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3753C7916EFFFFD481526BEAC2E99@DM6PR12MB3753.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mL/b7iCiOsMdiHsKhoRZuR87Gvj9d/gjxVqEpFwvC2DEYs2huQC3ks9mxN4SoDg811U7OQeMs5ta60Xh+Ir+gY77F00QDUfVEyUIUQOavFaUDnRodL0LBaZXhjhSXBEOGjpLxQjJoGE2xN92Zq9/PFDBakHdtTVI06WARNKBEGy0JpT7wJNN30R5NVo+hN4+j/stRgFuwIangPXkdzkQl9kUeWm38CuN56bbI+cl/+Ab7aZnYnIpFeye1J7hApT6d4baJbTixHjYbKFOS6KGyQBv5BFARCxHxc7rStcWVxmbNlSsJrKeMcwCL0rAw3s+9BETyLDQv5IVOtBfO38Y8MLhwYI1bZpvHrkLKaHPZEumqQzC1DI+YcHwwZFRrMMRPXl8bE1C5zKzUWQICqyxOgZltkN2h4McnRE588rk/bOClaYUzSjfQIVmy0pmsqVU21fDk+tk3RehCKZS+z0vLjYlTs4RJj7h3338fcowEgl9wkWul1b10P1DNuQmDvBk3DU7I/XZKNbSkKqo0PokgcBAqlV8rJ4xNFIJ6oIBrqXK5SXQAy8yE9dXnNNFYdeNaZmJLHF89o2NWoRde8Q5I5+nX6VihECIRbHIvbIYoJoPJVg+lJyA+rNPMiDc9pH6z+9bP1WgJk8oxfJesrhy+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(508600001)(2616005)(83380400001)(6506007)(86362001)(66556008)(8936002)(33656002)(6916009)(38100700002)(316002)(186003)(36756003)(6486002)(26005)(6512007)(66946007)(66476007)(4326008)(8676002)(5660300002)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2TtN0hMa4XHRbhbV64snsgWKln1Pu/6hKv88R91mk0z4TkPu6MPVy1MgZRCW?=
 =?us-ascii?Q?Vs8ZPAp2vcxUcNanUZq7XWhV9X0UOYxpmwviJ7l7yHQdyD2G5ms0f8eUdAmo?=
 =?us-ascii?Q?QTIRSR5/7+zt0ev+/NANjMjU0CoFiJMU36b5v+bxwFzs5hQP5qDc8Db6bUa/?=
 =?us-ascii?Q?tNKNQ9EnfdTJQdcoLLHXoT3+HOWcx3ub2fI1RzenRVQbgeK/gMlTAN+dKMij?=
 =?us-ascii?Q?68Eckcl24B2himidbjHH5KFCfrwpmrvBx4+vMfBhgaxu3CPEjAY1punqdFAx?=
 =?us-ascii?Q?CxQpnKIrdpFNL2R4Pa3Peh8Jej4qDFBlXohZbtjwalS0EpoNNXNWP5whkETb?=
 =?us-ascii?Q?8R9KR6Rtkd43RfG5jwNqMuL6re0C4xCiancQRxO1O0l1FgqSH0ZnxPIMLyvu?=
 =?us-ascii?Q?XT8BXlsaJz5MhrPMZQbR92VVOzC0i+WAO4xD0tjWSDcrrkQHu5AB0z12zS3W?=
 =?us-ascii?Q?HB0dQYvRCxGb8QnQqL9n6yy+dR+M/GNXU+7UHWSDm5RFc7tNFayvcI0Smnbf?=
 =?us-ascii?Q?wLReuTfQP1JcIrlmkVNv0qKF0H2waJCM6FAHmhDmpSCu3+FCs18PynhgS/Ee?=
 =?us-ascii?Q?6G3CuSaNbtEXU5nuXFM2PPJrmcLBfnuGHTCmBZ1gMN2EwcZny/VMFC1kb0ze?=
 =?us-ascii?Q?wuSGzCM2a6r8GvOwVncKJjfbysc+ocK62M0ZG18wuOjQJ2Y6At5MojgnZkos?=
 =?us-ascii?Q?ymjRbknJLnNQUwVeVl2L2fobeYTv0rTLXc/Hv19dZnKlmTjHbCLh7IFkWSTr?=
 =?us-ascii?Q?AKgc+d1mRo5sQg375tTDBo1KN5fKKIOQFrLNjHm2ivAE9qq4uWz9LxjICvXq?=
 =?us-ascii?Q?S7DOFZQm7x9xaaWmNFCf/3o/uyDDaoD5E3QCyXOHLSgyU6/8NRmx0YQ/u1aQ?=
 =?us-ascii?Q?INGsMAdD8DAMkkQjsBfVAGoLlxhWa2jm3FZgpKL8mSIxiUWgnmQnV2/4z1bi?=
 =?us-ascii?Q?7vEg8dHkOG+28Ksl5jdARPuD+3g/FybLbeJVkHCW9AMgiX1KBSuMFIkJNsLF?=
 =?us-ascii?Q?BdELv3pw9BcoQ/af+RvSxlo1GYsmH/vjxo76icOBwJqXP+/arKWDqUqckh/y?=
 =?us-ascii?Q?/L9DSlqIGynLbI1eLr1YMW036ZagSH7wKum9GginsizxX3zXrJNuWu0LSYrm?=
 =?us-ascii?Q?Uj7HYJ3oLceVeg8HlXHornFMfcfMxQsSMmoHRo3dbhl/9dGaCz7ajcOjCtbc?=
 =?us-ascii?Q?d7qztDs6+Tex+EYvuLd/Xq8kxcdj4gwsRbipMMB+4nO7IilZj7YbpCq+Bwgl?=
 =?us-ascii?Q?vuWwLswGRCSQTSvv2wFaxUUz0L3vmzQeOQEy5lT9iqsy8aexF4R48+XJu+a4?=
 =?us-ascii?Q?XzT/pskAW+ceH8MxHF02n0x+6pwtbjqFKu0OLuMz6XFeu7WXaTRlBNvcZSlg?=
 =?us-ascii?Q?+R1MWYjTXYuXhB1i9fFL0n94Mo3HD7H9MnAgxbxQIAgUHlUyL2u0FGs3AQWX?=
 =?us-ascii?Q?dCs8jclf5ILHz9F8bUKND5wSwkGDjW4eZsEEutWkq90cV517NWptFXwsgZX1?=
 =?us-ascii?Q?XtM1T4YUDYPAZVLkb4wkt0oep1/R2OggrrGesPefLeLXpGiA3ZKKL/6An8it?=
 =?us-ascii?Q?i9m/38/MBG8lTXMHlzwg5jMG6Bt7VeIEuEiyOQCKTfJnIGG3cAMP8D7ymnzV?=
 =?us-ascii?Q?MVDKW4DvVrTpUPI3hE257IWVsG0u3/obv4b+GCLY/CjShoyYlC/T/f8DcwJ/?=
 =?us-ascii?Q?WWRmFdXxVO1OoGLYqmeInSmfqymfIAuM37toVuo1oWi2pB55UFEGMGNY7070?=
 =?us-ascii?Q?WBD+bx6T+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868cb5e6-1264-428d-4081-08da19889b01
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:52:53.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUcNqaMRGBJlE+iSbxmXZWhOitAQiCaSjzz1hNKPHSUjRt5V5KpnW+j7K+9sv/6T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 04, 2022 at 04:50:53PM -0500, Bob Pearson wrote:
> In the tasklets (completer, responder, and requester) check the
> return value from rxe_get() to detect failures to get a reference.
> This only occurs if the qp has had its reference count drop to
> zero which indicates that it no longer should be used. This is
> in preparation to an upcoming change that will move the qp cleanup
> code to rxe_qp_cleanup().

These need some comments explaining how this is safe..

It looks to me like it works because the 0 ref keeps the memory alive
while a work queue triggers rxe_cleanup_task() (though who fences the
responder task?)

At least after the next patch, I'm a little unclear how this works
at this moment..

Jason
