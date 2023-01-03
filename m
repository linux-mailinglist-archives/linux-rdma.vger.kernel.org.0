Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DFE65C0D0
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jan 2023 14:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjACN3L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 08:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjACN3K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 08:29:10 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB16B10FE2
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 05:29:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+sO6XKwASZJUZ0xK2RXH66sp29tTyxcmUpCrMJxl3QdEaH8pO4LIP/suE7NM12JE/Kj2BOvAb2/cPKQC/VvJVnLRYvdrZGu6WB545cKd32ea6tEg66bAVna3WXmD1hBvyp9Imp0q9aVTGO3BslprCAMLFW4uumRpKmQkno7gYk6Ob3bifhqblUHTwCfg4E9Ey0jauaygQpJ5u7rrQgwqj37UOGbQcZimVrxG4z71ZlONFfxL0ZeGMZyugtSpz2rJxzCKcTIuVTc27AMPHfTRbQq9MA1sNrLAKm6BQSnmD6yyGqujIqZQN0RziKoacBCeJbMgGkVmrrYo8uPcK9aJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nqv9Ksn6OfqeecWAtuw0l4e8m/FsS1O/pxVUk21hD10=;
 b=TBjAmIyBlRHFBYkjaiKKNwcWP8IVpVUjb0w3AithcZ1Emkw0di45Q2aV+Hdwcmq1B4SUxXHlU1fgbrH4lrSuPAwhvRkNB7jWt+9Cm4xbMkq4G4cCJSqBWbiIEZLnXnc/jVXC5e/R7/h5LNvdCwnCtOYitxwOUpTQzQ4Wa7ipem9qaWqM/yNdi1PIN6fwrH/caMAVmtwENsRnj/0P+/jNuDa5OLTahCIFk1Z0nib1+RrrAL4Qph2Bpmf9wVVLEO1PemDu23AysdL95EYieUnBiPXL+/Oyjy0rNs7TTQvPKM5gB83wzGxQmFADU02sJ9HZq2V+CtY7YLgFQUg9tcx+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nqv9Ksn6OfqeecWAtuw0l4e8m/FsS1O/pxVUk21hD10=;
 b=g21RkrFnhvEhHIxnR3PwOCUIcfyiWDUT9UiFbZwgddJyC4rypsbZUgwIg0cjehN2nvsHUXaSjOcOUkNsvi6oW/puadDfbXJV5m1v6reDHplX0d8HiDbkcQb5D9fijPoGOmhA/a+RZ84+sTKtDsvkMyHZQpyoc3HNoXfBU4HfQqW0AwsYPXdlz9Wax6sbRxZlzRKYUSLDuUaRhEbVUrb7owxw3W752T1BtDDwgh6FAChbP8JNvool4znKWMdQdVdK1iuyHcWEEehUW7idQIC3A4A6p4QcKY9w/5XM8E3syrFg9kgOFtU5RjAfnsDWG/yidlr5xT0GWJRfr0O7vYOpYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 13:29:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 13:29:07 +0000
Date:   Tue, 3 Jan 2023 09:29:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yonatan Nachum <ynachum@amazon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, mrgolin@amazon.com
Subject: Re: [PATCH for-rc] RDMA: Fix ib block iterator counter overflow
Message-ID: <Y7Qto2TWsSQyB51x@nvidia.com>
References: <20230102160317.89851-1-ynachum@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102160317.89851-1-ynachum@amazon.com>
X-ClientProxiedBy: BL1P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: e171509d-272f-42c7-7709-08daed8e7dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zf/AwaqeUb11XGIxC91g5twJ+YoSKO6O5Pzxg3zctuEYfDFNcYPzxYMIig62TUlbrakQsVh1PJoSty0U+n9Fkh4x3aMS3dKeFy96bV54BzqgScXa9RnW9ssmLBjXEn8KOhQwOhZpG9ymD4+nXXUmw3qauYiE8khysAa0LwVa7aizjC/A1i5RWHjV9LM1JKwTWgrOF9k2anESzyJgyEsoNXNU/FKgEjJd0CT6WKftU531koqgnVBR5EnqvuRz3TpzwdpxpJwMgqK+xgOyUPkIRq17ioFqbV8BUSM8V44Y0Zfl9esPEEI4W+Ygp5kFbZxxM05PlLjGw6KH9JrJUE/SQZkKcvu+ndVeMfrsVeesPBRIRQJ1lolODyRSbBV6TjWoJzcBP6oJEOrdvrgmlOJdQzztwgicX7tqgWiLyEqe2+W1narqe+STJXwhmvmavZIfoD6lZlhp5MtkpZ2vcM2MjNH8c2E1gG88aU+7b4f68KaGMW6fWrWF5lHlURYv9M7bbrpopuE9zuDy7SWC+jSDRSXWag/GcX5SXzh9Pfphl4La0BbfuwF2usER/pewlq0JTylT98Hj2AS2wlp96mTcWJzyJ3n84rDKs1nF3WSnRslDCEYI+DO2EXkcvpfKDmrFXj0ZCuVG23k6uW44gSXJicariJdkY52UmTC1QZyW9Z3PKboM/iIlGXDJkgJN0MatxhbplEKSTl0y1cosehlYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(4744005)(5660300002)(316002)(41300700001)(6916009)(2906002)(66476007)(66556008)(4326008)(8676002)(8936002)(66946007)(6486002)(478600001)(36756003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(86362001)(38100700002)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JkCtK3zGbctvHI0Wm4YDv40lJj4yIojHxN3DdhYpUIaygVCmE7rNZbD5a4I0?=
 =?us-ascii?Q?o57WvuXHrppe531jE0/iNI4+m26aLh5xNv/P7ZUj8VcjDyrCGRyEDtxfAlC7?=
 =?us-ascii?Q?Qa+xk9RcPB6c2r7qrLCWOMeqR665Sta67C/tjv954JnknoJyBE2zmSpb3WEL?=
 =?us-ascii?Q?yltjukno0op8RsWGg5GRCDsRLAXzI3oxuWyYZvp3DN86NGoUM8TnHEaravlw?=
 =?us-ascii?Q?/m5SNW0f2YwdN+C0GX0NgJvxzKD4YeDZ/tUd/dw27tIZkCRyXD5cjNudg0QL?=
 =?us-ascii?Q?b/GYiBvL1NcK83vK+9qi5y7H2u/hnuWmYsvlHwQOkZteBmGoAznOIclqFYC1?=
 =?us-ascii?Q?ZVW75h3YfUIA6UVoO6/TX3kJdBvbM7my6nvFhhEd7fySe1Us1QpjjsTP0byV?=
 =?us-ascii?Q?zt+x3YX94Zv5k1DXwRIjsP+NWiiBQV3YwZWgiLm3jrw6zRYSLEUUsmrMx7+c?=
 =?us-ascii?Q?TmjWIpNkRrCxnf/Kg8UgW+C+Y/LBcbpqV94mRTYaEC0I9s7Wtf7ba1mhtK8O?=
 =?us-ascii?Q?uTMyX96S92Pxrpbj8LEweeAVpL5aM0VBcwRl6mLqRr7UjfzfykZ2IZbjaW4I?=
 =?us-ascii?Q?teHfJAt5PpEMS78X+8VEBB4lQp8xRGMFbNdCQdAgjMwn7IYJ6pXUdc69muWT?=
 =?us-ascii?Q?v/winCeJcHY7phvEnxaHcy4luVYw7zUNB/0nDRsKLYiNebJhJqxMwtaMijWq?=
 =?us-ascii?Q?enYgEi4TYiPsnWE7+GF8WCMctIx+M6YiuTEoxeFM40tR0eI6FxA5I6G3CcRq?=
 =?us-ascii?Q?hcczyxdxDec0xegQxONuUIuHj1VPEYoXLw3TSA0R1knzsfrZ7UoDeyE/xQTW?=
 =?us-ascii?Q?sx4lkCkdB29BEI70iJgfOlAJU5JjYisJ0Jt18yAOXAt+ZchTLqnEvFH3E23C?=
 =?us-ascii?Q?gFwn2jdqe5KjPfkpJMNA3LBaF7cvyWAlFdCGpflAfIoZoE3YGKiWcsGceChw?=
 =?us-ascii?Q?6oVDp5feM7htoOrA143L+Uij1H3JpUGLdfvzrzdi/FyoR0ylU6edWjRelkEK?=
 =?us-ascii?Q?MRUjUVQW4RGxOeXbcQMMwnL5/Hqin93hENwdkBlj3FQu8YyHBkpJYi4xCv9n?=
 =?us-ascii?Q?kutyoB9Pg6t7kJtSKyMlGNSMmaSlAjneoncLOBcMQW+OYgTDct24VL0GqPoR?=
 =?us-ascii?Q?APXAMF0uo7m9KKHCvqO95tKfpG9quZiwJzcrKln0Hs0SRXYBft94Fi8T3iXn?=
 =?us-ascii?Q?OtToijFp/rQcJ9VybdWRO1ZipUVgq/85BchBCWY8Ze/Ck8MVqwdp+vlJKioU?=
 =?us-ascii?Q?XFUeLI0n3wFUpwvG00YHNJiwY1auykAAYAR9uW3X6B/0zI8e1EeTDAau6LmE?=
 =?us-ascii?Q?dmnfCO+s8j6sWVRz/o1Sis5A3qw8FY47WEkA5CnnIBIN3xrU7bmBptF2oe6r?=
 =?us-ascii?Q?04iYp0BFdI4kT2CaxuRFDw1EhQoq01yi0qKGfJfK9nTMIgobwKICQC/wP85w?=
 =?us-ascii?Q?B8pXCM2ALfJPnHNOquWCIvU71LO3Gkva9h6gnomxCC6Hkufpb+acbsSj9NQ6?=
 =?us-ascii?Q?pLjcHvMWnCWO9BzLHzFeP0ty1u7m7qA6JC6gRNSI8Pz59ofVGVAWS0moIGOc?=
 =?us-ascii?Q?NiFGjVN1147EcRXfEK2f5X/8IhiO7PHP8NpDRR2K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e171509d-272f-42c7-7709-08daed8e7dd1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 13:29:07.9158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1YZ2Gr9dMhVjCtdLfZWvftNNFcYj873W09woyMlDKd9VTkJa7xTeFDXlZG4EzPF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 02, 2023 at 06:03:17PM +0200, Yonatan Nachum wrote:
> When registering a new DMA MR after selecting the best aligned page size
> for it, we iterate over the given sglist to split each entry to smaller,
> aligned to the selected page size, DMA blocks.
> 
> In given circumstances where the sg entry and page size fit certain sizes
> and the sg entry is not aligned to the selected page size, the total size
> of the aligned pages we need to cover the sg entry is >= 4GB.

Huh? The max length of a scatterlist element is unsigned int:

struct scatterlist {
	unsigned long	page_link;
	unsigned int	offset;
	unsigned int	length;

The problem is the construction of the end of iteration test:

	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
	biter->__sg_advance += BIT_ULL(biter->__pg_bit) - block_offset;

	if (biter->__sg_advance >= sg_dma_len(biter->__sg)) {

This should be reworked so it doesn't increment until it knows it is
OK and leave the types alone.

Jason
