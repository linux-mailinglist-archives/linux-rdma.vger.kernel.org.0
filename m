Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C6B738CD1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjFURMl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 13:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjFURMk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 13:12:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B277A129
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 10:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjWnudYWvVTi1cXur+bZ64MA2wKGuRXLkLleJahL+jiGbqKcepJcuikYk+a4fM8csjxCz51B6YmiWjJFxMahOk8Dz95xu+n4iReYbLufE5S9X2/fYtCv5rRpxO9ojDHC2xGcmVSnyc33WrKaRXzTgGaRC33TROgGVPclon/aDpiPKHZTwC6bb3KdxAoCPnKrq5NXt9nPaoun1ovHgaXHn16zBpDuOa/8AVIG4x/d3UJehMncaH9KGz5prywZPF+fDag1gAOCfjT8i2YqZ/eHZhrt3pLsYSneGtmecGX0sOKjvMKiMfOPVAR3VPAgRJPFOrAU/ZScQwe3hkHti//f6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wd60xM6lG9xrgNRh4D0xHlS9b7PPNTMxcvUADa3HjtM=;
 b=lLyhv+zcUsXMdt3PZAf2eM1XCE78vRZUxqXJW6+kPCxH0dyZns+pDpYfg+sa2jCnrwoEPePQYDLKqu/etGmqKa71lipTrIsEvQEWi6e7Qu2YwUPUtKFjKCbLhnA2m6i58/Av+t8KVrCqq2bkzD73c/SiiG4WIpw0+0PTr14lN+LeRJyf3eKZjOnl2qnS71aVkFWCHgL6zwK8M/OtoLisOVDFH6N97VUnCjPzoVaY3gJGr+q8VHZa8zS6uE01QVH0kI7OaiRxWuiLWg7uXKhuIaxO7+15BsHW+E5POYrJIE3g785wwcS/1YJ2aoQKhQTUmcBax6E4BYC4mcFHKwwi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd60xM6lG9xrgNRh4D0xHlS9b7PPNTMxcvUADa3HjtM=;
 b=mLfDqDjJe+HyqDIEjjxtPF87kWLrNG3vtHAHpwxG840onhVd/iMWR1yKWtK3mBY81j/MDfd5JbTXNnQBem1ksEOgUJqPbL8bKRUhVAhW5IrtYOex4neWiw2VtgKzuXkD8NVLe3qq2VyOtvFxN2FCH9DjbenLOeO40pb7zZsdN6k01K86a63XSC0EDlDPYHLZbu9zbURzfVeFk+SXtiRLmT5El3GxWFR3BMUkJiF7L0gaKzT0ShsxQ+Ev55hy8Hazy2oDZ0B6IBaTZrKR1GzazRFjlmusXMk77dSA3Wis9srEIfLflQAQk2GSnQWKpwIJS9/qzEZNlD+CaNC0FQ3o1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 17:12:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Wed, 21 Jun 2023
 17:12:37 +0000
Date:   Wed, 21 Jun 2023 14:12:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v6 for-next 0/7] RDMA/bnxt_re: driver update for
 supporting low latency push
Message-ID: <ZJMvg97sV9p3bFpU@nvidia.com>
References: <1686679943-17117-1-git-send-email-selvin.xavier@broadcom.com>
 <ZJMsLUfPFUZ97hfq@nvidia.com>
 <CA+sbYW2ymd9cVKZLO-V0mcijjqsZunHjmGyhFDHbCBJMtF+O0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW2ymd9cVKZLO-V0mcijjqsZunHjmGyhFDHbCBJMtF+O0A@mail.gmail.com>
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aaeec63-02c4-4bae-89db-08db727ab620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k195xEKozKqtbL6CQc+WHXbzc7rGcPchtHm34O2ebu3HQPd4T0nCJwOpzn5ubtYaW6BChcZrSl6MOyCOcBDx6ciJW0P0pV7/7LOquS8P3e44f95Eu5BIy4qDTnNq9jSHVN4pl9znH6LNBsmVFt84u6csTqoEjcRQY9ySGXagCxJwY6e5Glar8KpmjgE1xzcK3XVa151XVpev1Wqwso+g1Se0Q4nD7Krp3bmuQ5giG15QHdwMEGkEq5SNs7NSJItjKObkdehxBXPiU16b2al3oUHTu5AB+JiQLTsNCx3pLturxkNpvdJXHHd0ZJdRojwZdCXV/hstCP8/Vu8cHN/EAvZBCVSf30iLzBetOteGr7E4ApoihHW4LMd+U1d54dgC5EKzDbpqmz8O2mKwr4xydsurSZYNTgWRrzVLoT5VGzxGFZogYXu1UeurBOw78fOvZPRXvo7HbnnuAON3+IrAW9DW2Arp2ppsFurHg5e+79Hecaunl3URhhJxoQyWG2F3Y9IDmZJiXyu3HJfEuNSlC4/fY09D8ORS+BvCLI9N3YAr72qG6PiUYgySPI47D56zHkkm6lzNj2PMRvYjoq4m1GlN1eAbBeWF8w65FI9dl/7KxNuT+veFdjVOWHRtU7AwUdZz6wJB+aqYZgAjOprQX4NB8JxBQmONhiTQm05cDplniNhY3XwX5H5EO+WL0K1L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(41300700001)(8936002)(8676002)(6506007)(38100700002)(478600001)(2616005)(83380400001)(26005)(966005)(6512007)(186003)(53546011)(6486002)(86362001)(36756003)(316002)(4326008)(6916009)(66556008)(66946007)(66476007)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU1DMUNXUlF1LzQxM3RIQWJPaUVpT2t1ZVE4Qms2NlVDQkROZkk0eDVNU2ps?=
 =?utf-8?B?V0IvTmo1UUVXbVBEaFAxMVVzdHFCV09MWlNZRzlnVE1wYW5yNVBEYnJaSUx1?=
 =?utf-8?B?UndXWDRsZVFiSkUwM1ZZc3ljTkcySm0rVkQvTDJka29Sa29SQzRhL3NRQ0tj?=
 =?utf-8?B?eFZ3eVREc3h2WWcxWFZXV2ZKM2piYUZQSFRLdFNJK1p3QTFlSjdmTXdVeGxZ?=
 =?utf-8?B?b1NDMkdCa3RkbmNENm41M0VHSnJrNHUzZ2VmZWt3eGQ5QjY2SG5rMk12Lzhk?=
 =?utf-8?B?RWNDWW5YZTB1Tno5enlPZEMvejB6ZDFIV2lidTlibEUwWWwrcjY5NmlqTUtR?=
 =?utf-8?B?TytxOUQ1STVwWk0ycU9uMVRYL25XYVpuNG5IQzBFdURNOGhXRFFVbmFuMkY5?=
 =?utf-8?B?cG5WWVhwQ2hpQkVuaUErcUpncjZZakpvT0pkd3ZmdU5vbzlXTWtVam9MWmZm?=
 =?utf-8?B?cThsS2xhWWw2NWZRVXIyaytYOW9qRy9ydjgxTm8vYnNycUFZQm53N1NRd1Ur?=
 =?utf-8?B?YStueTdTRzR2ZnltWlh5T0VPa2dsYWNCQ1Ntd1dWZkZpZ08yenR5OStuQ1RK?=
 =?utf-8?B?TnkvTS9MQ0svNU96VnVZOTRmN29JT0RNM05RdW5tbHBhakNKQ2hJTC9QRjlX?=
 =?utf-8?B?WnlOSUhPUEZGN1ZpRExhUnU4N0I2djQwSmxmbTVVSmV6azh5MFkxV2JyUDFU?=
 =?utf-8?B?Z1ZFVVdUVnI1WUtmRWh2YzVVaVMwL210dk9SeEdONEd0LzBadVRmaXREV1NP?=
 =?utf-8?B?YkpYL3NsMW1UaHpITWdqRFlDdUVtTHo1SEZ4N0gzS1VHbzhIVnlXdGpINUtv?=
 =?utf-8?B?Y0JOUWhRbks1bU9WQVpVU1RkNk5iaElCWE41dTNqNXpIS1lrTTBiL1lKWCtW?=
 =?utf-8?B?S0cwbGhZT2UzT3FVN1c5L1dBWEpwOVh3bndabjZrQ21sU3JyV3pJRkZyRUV1?=
 =?utf-8?B?VmcwSFh5eGZqRm8yd0VuamRTanhKTERDaEwxRW9lU2R0VExaaXI4R2Nwck5k?=
 =?utf-8?B?V0dMM1dQRUZUam1iME9WQm50RlN4K3JUeTAwd0RIYnZ5eXJpcHpPQ0RNdlFq?=
 =?utf-8?B?MWxmR2txbkI5QytZUWhtVENYd3VuMmp0Yjc5TlBXYVlOTktFVjJmQ1pwbVJw?=
 =?utf-8?B?ZGVFRjNxWEJ2YkhYMHY1M0lHb01ZUGQ3TWlzTk11TXRndC9hcWtFcDlxMHhr?=
 =?utf-8?B?dThHN0hoWjloaEVoeUIxL3FmTHJnY3NxcFA5SktKaWdvcXFyVGhYakZ2UVhq?=
 =?utf-8?B?MEJtNmdGV2h0bVp4R3dQZmV3UXdIOENWTmlLUHVuOThGc0YwNUpiN3hPZFo5?=
 =?utf-8?B?ZEVUT05qYUtpaHNuM3BxaU1hNE1tbkZ0ZEdGYXUrQmJmWldZcDdvdmNUcGJH?=
 =?utf-8?B?a3p5bXp4ZUVheUdYR2wvTjd1dEtPMEtPM2t0S2FRTUM1Mmw2NEIyVTNjUGxN?=
 =?utf-8?B?WFBnbjlQMVg0aUdWQlViTks1NExsQmsxRU1vQWN2ZVpKcUhGaEl0Y1gvV3Zl?=
 =?utf-8?B?L3J0M21FdUNnbVZJd0RudUpjT1oxRS9zbVFPNFNYbm1WZGpuQTBoVllTQnNP?=
 =?utf-8?B?cmd6bjJMamwwVXNiOUVxZlpraXVyY21MamNkeGFNaVlEd0dYRzNrQXRWRWFk?=
 =?utf-8?B?a3lsS3d5UGE4YWZUSXlNQ2tCUTJtV1hjUzZXY0pqRzR1UFk4TnV4aVJLN2xz?=
 =?utf-8?B?dkZtV24wMFR6bkNzQW95aE1GS1FYQ1BhODVWTXlGNW1rRGFzak5tRGU2OHQ5?=
 =?utf-8?B?ZkVEenFsV2dmWmtBNEh4TXNjK0NoTWlLNFYxYnFKdkFWT2llV2FyaWl4K1Zj?=
 =?utf-8?B?NSt4RVpJL1hyZVFXNnJIN2llMHpNMDgwaWs4Nk9idUpSQlJxUzdiYTRtbXlj?=
 =?utf-8?B?S2VaK1hsTDQrTEsvbkltVTZxT3VtUDhRV09GSlJMWEZQQkY2YnlwYnI1UUFm?=
 =?utf-8?B?aTlkdXFITFhOVXJOTUh0YSs1VmRUbHZQTDBySEQxZTUzWjNtdndLMDNkaVpE?=
 =?utf-8?B?SWZSM2pxdWpaR0FOOWNUSW85RE1BRStDelFrSnVTOHN3VVczSGdZOEpGbmFl?=
 =?utf-8?B?VFhkV0pPQXFMdXU4dEJPK1JGbmxnK0ZPamxLL1FIclhHS2d2eS90OFRrUTZl?=
 =?utf-8?Q?9xOFocVBMgRMwqiNwxNR21hRo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaeec63-02c4-4bae-89db-08db727ab620
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:12:37.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsUUb5w6liv7k0Bw06FdIpTVGfTe4NrnJQwJ0SSXjhabOb7+kTYWc0oLAOAnuiQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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

On Wed, Jun 21, 2023 at 10:33:45PM +0530, Selvin Xavier wrote:
> On Wed, Jun 21, 2023 at 10:28 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Jun 13, 2023 at 11:12:16AM -0700, Selvin Xavier wrote:
> > > The series aims to add support for Low latency push path in
> > > some of the bnxt devices. The low latency implementation is
> > > supported only for the user applications. Also, the code
> > > is modified to use  common mmap helper functions exported
> > > by IB core.
> > >
> > > User library changes are in the pull request
> > > https://github.com/linux-rdma/rdma-core/pull/1321
> > >
> > > Please review and apply
> >
> > It gets compile warnings:
> >
> > ../drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:322:18: warning: variable 'opcode' is uninitialized when used here [-Wuninitialized]
> >         crsqe->opcode = opcode;
> >                         ^~~~~~
> > ../drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:288:11: note: initialize the variable 'opcode' to silence this warning
> >         u8 opcode;
> >                  ^
> >                   = '\0'
> >
> Hi Jason,
>  Leon already fixed this. This was introduced by the last series that
> got merged.
> https://lore.kernel.org/r/6ad1e44be2b560986da6fdc6b68da606413e9026.1686644105.git.leonro@nvidia.com

Oh, some patches got misplaced, I fixed it up..

Okay, applied to for-next

Thanks,
Jason
