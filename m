Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC6648B6D
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Dec 2022 00:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLIXnW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 18:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLIXnV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 18:43:21 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183A25C74;
        Fri,  9 Dec 2022 15:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsgtMsHl+Ln8CCL8qBEkB58dwkgG+7ca7gvXxSWrM8A8hoSCB5P+KkVk8na4/cOWFtc+qTzKvATxZg5fhJQqfpT5c2QHU+ph26dKwN/rklg03aKo42qIUKFSYypHmP/R+DvBXDpxaAahdBTwlUHyfI4ImpRJMvqn26Y1hId1dAYCtlp3Xvx+ke52e4iNlhly/DG3rYHqnK0i8vTec5Ctam1WUxIAydPWddK4IiIVXsgpftSEedQiBgYjP6zNFf3SFetbSl3ReFdcHD6zYy8ccHOEB1tRRX0Z/NXUt4TutRFjsEitEf4syWRALZhDz7lLKpzBAV13UodkxFbsyQldZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFuJ5fEivsc5AiOhUJjN0ifRkuSlbOHvi89ou23lApk=;
 b=JpCwCXc1xfjgdMR90zDxUlxBLrOLrKEM4lr44iIASICmN467FyGvMiaOGaPDCaMhfMy63uzJCWSwC9LPhHnFByKpStKah+wqpYHWve/pI3EsCoYt5smI56mc0Qy30eYtUVgFWjOaEH2yg7m8Q8V3sH0INZ/5OMir1Xdjp+AkmzafAoq3pXRTNqZR3+8UO60zxRj5AqgTpjQdQsjdcNXfHJw0hhWIr50J9UGI/QexviYlea05ySd4Sxv55sSlhDSBNYpb4Ef7Z4jvbXMAz3NA4y/4Vyb6eB0ILFQmmtsRL9auHl8c98uemTp6tPTOsIfHGxRrGzkp+gMQELISjpP+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFuJ5fEivsc5AiOhUJjN0ifRkuSlbOHvi89ou23lApk=;
 b=WvC0BIVClKY+3cVuKbjlIX9k4P9nE5U59d785M06Yw+rnl+6Dg/7u5jrQDZKcGjshqd4tQiilTrlPsbf5qnP2yB/zjTFI7xoABlnmmYL0ja8cVRgUEGwJ2RdO+V6Uld94EMS6ovpbqNcHAsUEyLv72wEVwOZfq+dwb7Jan/W1lsriOtzdrFQr7kSlmCKz9V25f2cp/AcwtUBu0Z8vVODoVWYSl8lxQKx59Y9U4efJeDdq70KRQYIWLMLQeAUkLb3CiEMi0+nHqSHgTVGIxIwO266QuNZw9OsXw35+ucNSAMc/pu2odcI0f7DjSxikRRs2R64e0RDr9uxlcC/tEm2bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 23:43:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 23:43:19 +0000
Date:   Fri, 9 Dec 2022 19:43:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, tom@talpey.com,
        tomasz.gromadzki@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org,
        Wenpeng Liang <liangwenpeng@huawei.com>
Subject: Re: [for-next PATCH 00/10] RDMA/rxe: Add RDMA FLUSH operation
Message-ID: <Y5PIFcdo5JaazXe+@nvidia.com>
References: <20221206130201.30986-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206130201.30986-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: BL0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:91::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af3f4c1-c525-4cd1-7adf-08dada3f266b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sG6nBtp2vx2ZEgOenZOfsbtoHfV5fgHsV+d9K79RV25Nnz0YIwdcvYw85Cs18toEKIdUVn/BsrcYouxwSjXaLfGpAEh/cwaGgeDhNjq6JJtIAQdzWd13w/sGxeymjLJihdPgm/vey2KbL+acZ2TCqjD/ld40h7DNtpUc6P6NLS9gXeUkLCn3Ggpzh019AcEY6XALAYMe5NrIVm7yiOLzW+A2057G4Oz+i8PzOXyP12E587fDQ1rTNNnv2LoY9+gWmCZJ1UD5EcZWj6Vh5lGuCgkLl25XAIxgliL6ur2BlWptyK3klJOS+1HSI/nvADH7yJ9ciGsuVNUKt5IPOEi3kEIN9NCEHzpd6B9H+IeM0mtqQV1SMaNndfynuYDYvq4x3hm6HVb1cyDypDj27iIUnUG2Lmt4gYysga/Qd2oTM6BnmRo/eaNrSaaWFx0sqTFnCB27ibky3yv0hCASTMYe4wCGb9pMI+Eqgukk+pfpBPrv+bC1oPfCBQBNRHFWkid+o/2WBE1W0OfgZET0bOw9KUA93gQWb3mLCGuK1lEE33fqI3zMIRhSxoPBWgfd75FDyXH3Cl5vlEcbbcFNWqb1qebfdcjLE7lXHo2vh+UmPpyOMI67In5w9I0tb0OszGE2FVr6I2I5LIYxrO/JwtPF4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(83380400001)(4744005)(54906003)(86362001)(186003)(4326008)(8936002)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6506007)(6512007)(26005)(2616005)(6916009)(6486002)(316002)(8676002)(38100700002)(66556008)(66476007)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SEQ21pwxiqmdzPbJ5tJRGmB1SPNtDJl006cVkGuTCr14u6OAQedsOfsPAf52?=
 =?us-ascii?Q?1FyqaofwPHDy4NyIotsInpQwNDLb2WALkDTI8zYbSjUhtIo2irfTSZ6ZqBoR?=
 =?us-ascii?Q?gj8eprRpJJTG84Bg3ldpughQwko90lKy4t+HX2u3aJg/BeWoLUrs6gP62eI2?=
 =?us-ascii?Q?n9WQMtlCmokuD+XHf+YGAk/L2p1Qn4OhsXoWAZLA3zfpF2xkorqPyWqpy2mA?=
 =?us-ascii?Q?xaFlwaGmSllN6BHbCHvCj0BsIDVQ5fcanCPsQDuZ72z44qGZ1oFbgYh6qlgd?=
 =?us-ascii?Q?usM00N4vNQx16IZyWpCqs5Kfc02azPGQSsxQfe7+DkfnhYix1eqUxRa3xK2I?=
 =?us-ascii?Q?ar/URMR7LR54Iwop8Aa+/Kwx9bLNeziFPQnqLUX7h3YZkkm6WkXI4QF2eFCk?=
 =?us-ascii?Q?+cN++T/LNoxFUijQHXTycM7BTx2JsHNcuJAEVw6JACRpZP4VmaU2ScRBwSqR?=
 =?us-ascii?Q?fCugVIbKnJh1HL6AElrY+4GoGkUF5aW+YxtmdMkIhvlKtz8mH9w6fTLnD+zo?=
 =?us-ascii?Q?zptiEzovW4yvz7Fuc8gtJMFRXf3/nGKBQfOfsgZ4i5tPOCL9pJ2l6dexjJIV?=
 =?us-ascii?Q?wqaUumUo/LxpAgya7vgebpJd2cWXiUcXa8yVvENNKNorGkECTI5qLToqLAGb?=
 =?us-ascii?Q?X911YGRH1Mm1iAFJQulUmIvubsUMXOpcvnHoIGtoW5bXIcCqLzmMw7I/p6MD?=
 =?us-ascii?Q?1w/WAv1bq1zmgmTXE5ENQO7CCmjift2bms2UOibh2hysLVQ6+mJcrOlppvP+?=
 =?us-ascii?Q?hEkxxym1F8mlZAyPJnAJxCuxauz33oBJbLstESZ7QmQ/epTMyWGXpQreYK0J?=
 =?us-ascii?Q?pfoTWbrwcSPc6tC0inB39ar9KYaPXyr2H1vx+MmaSGYKiZEGLyYFLv9dDkgN?=
 =?us-ascii?Q?AmBn6Ru6tXloW6HkExrWj9kC0G5T4hV8PByC0w31Zh6NGmLaG9PYuETPZoXL?=
 =?us-ascii?Q?Xuxp+G3TBIvsEzlgoFPEvrwBgpRhONaqQC4v2R0lTQofp3NRaO6xGMfeVY9y?=
 =?us-ascii?Q?OvnPup2C/pSBtkWsQLSikCkJcVqLUW8uKe6n6MewSKvC0sORLOU1wQXl/SId?=
 =?us-ascii?Q?4+zkwyhmNqjmXsjKjLDnp3c2ZKXFYCYaTgEa59iaKqwsBd+WLcYOA/NoJOLL?=
 =?us-ascii?Q?Vp3OEgOycbvabCxJgZN4rtfildrcaFi5TerkJfqbysoNLb7lJwesCWaKoojR?=
 =?us-ascii?Q?hqMlCDvVRWTncknVrXVzOofqanRIYTpLWLZg2+ol+x/82mxk2elDCw1IMzW6?=
 =?us-ascii?Q?XZq6JCko1ggnUH+cHydltpO0nzSrzPwwjvsOlbfWPjDllhrAg2/6LRX1+iMs?=
 =?us-ascii?Q?6R4HcH+G12dsKbT7lQG+S2/Oyk6Su0O/5C3fhb16Db6X5WfWiRUrN7+Xs9EO?=
 =?us-ascii?Q?rn8zgIEdQNb8AEZWZXnNDEIYteskHfThgOI9RHd6hzQB1dG5fXojHrFYszIR?=
 =?us-ascii?Q?LwcWQ43Xndskk1ubVRe3tJVR6WBIw5AVXiczvJaY4yGWoX9OT5hAjkK/HH4t?=
 =?us-ascii?Q?yJfNLoAVQkPvi9jiBZOi+NT8C9K4RxO6vu/0uzbXPhlexhizxCBAHVwmIlHj?=
 =?us-ascii?Q?bnF8JZlytwEJ2rio0ZI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af3f4c1-c525-4cd1-7adf-08dada3f266b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 23:43:19.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PLbMvRZnX4lXgRN5AH5Z0BMRkxE1q8YnfGn+sX/HYjQaP7GT5w/C3ig1y72qjCm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 06, 2022 at 09:01:51PM +0800, Li Zhijian wrote:

> Li Zhijian (10):
>   RDMA: Extend RDMA user ABI to support flush
>   RDMA: Extend RDMA kernel verbs ABI to support flush
>   RDMA/rxe: Extend rxe user ABI to support flush
>   RDMA/rxe: Allow registering persistent flag for pmem MR only
>   RDMA/rxe: Extend rxe packet format to support flush
>   RDMA/rxe: Implement RC RDMA FLUSH service in requester side
>   RDMA/rxe: Implement flush execution in responder side
>   RDMA/rxe: Implement flush completion
>   RDMA/cm: Make QP FLUSHABLE for supported device
>   RDMA/rxe: Enable RDMA FLUSH capability for rxe device

Applied to for-next, thanks

Jason
