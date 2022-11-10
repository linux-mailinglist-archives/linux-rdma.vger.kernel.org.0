Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718D9624AD9
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 20:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKJToR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 14:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKJToQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 14:44:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C31315717
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 11:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bksoIKhJSXaunWXDglJIyHDkTDOgLhRjrSo4G8GReohNxv68Vv/4+8JZJL47vJryHvA127bH3lRLRz29c2YxBfD7N7GDXkStSRYldmHedd3hbVdpccMFHEe8RRq2XqDgxThp/lcPqNWoHX2HjX7+YMsfXARbcHXraxRLfqnPx8Ho08zJ8Vf0LieX1tosBHxzSPcZ9xNwI+HKlBqPRq1jLJmjso7yGKxCS1oxNbRyXCSB7nFcAphovq1A9YKUJo+gz1GCdj/dB+E1MnsBSQqOnPnrUDaZWo8GAw0RdbVx8VEavSkziRiOGjn30Q1rSA7NcgoWQVcad3eq9gBotk9Vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Pd6Ckrvo6tTCHAIb+QrFcUTGSax7vpmDB9O7qXYn54=;
 b=LWCE/aXkBy9O+VBHP7Woqzxj8TMCBxM/35ClIdFBwOgXa0HzHhiq97IsASDzmUbrlUpzyTD04iwPTpOxRFmQIG5SMApz4uN6DiBX5JdvrwkNnQvW0OayjWUq/1YbhB9CLjD7mLFcEcO1B3YgDZ+PvEPR9gbeIvFv9+2jngH6h70tywJpEIkmf00G4fPntx2ZQoyrTEnCAlOJFd5OPS6aGbn6tXXHrf05KfFkscd5GET9NoHzkkoSOYIGoZnwpDgMBbA98PnqdY1kEf8y2ZcqOPkoQ3CTutmqiZAgkcUfXOPDpqYM77wtMcNNaeYEMgIo/8ptM2JwYvb65zBlQT+pqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Pd6Ckrvo6tTCHAIb+QrFcUTGSax7vpmDB9O7qXYn54=;
 b=BHqhNxT+KYAXQKy2+c4fWwAHLQUIK5el8cI1MkpqnXD5+GqzuOCHswqdAGPp0bc78a43iim0ibDixReLf7SD5ITt1+HUS0gjkQanBtyMMHS+y9mVkp76rpjI2hqLWI1XWq5dsxwzSYE0iu9gy4U1WWUyxZvPNyuP3WfonzNfUnS1Ewhf0pBpeAzQNTjK+oMVYrwMTBsIVHJlw+6+B/JYbtdA9V0zumTcOEN2kMsGeYb848VWthR4WYNk7Jf4nXbe2HuM5oIgtbu3a/gEVZC0cOJj2/oUu2lRdR/GcFKr/2HweJ/BXvnBQtUyDFqXzwtfe0VfwR7gR3JwbTYR+ZcpKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 19:44:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 19:44:14 +0000
Date:   Thu, 10 Nov 2022 15:44:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: rxe patches
Message-ID: <Y21Ujbxz+B56hMjY@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BLAPR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:208:36e::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 0205bd0c-dae6-42ea-b54a-08dac353f273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xSvDaPQz7VqH2hyRrE/sSIYVTYNPP4s+HH8r0rgLEN803/VTFnyimN7HtTAC18BfV+dO0PET0hv+usuLKPk/mn4GOOb+Lx159ZXxYpvebbF1lnz9wJCIs/bgW2XeHdP2OJJaZA/AP/ExkwT3qqs3Yyj/swh4ZLN4Jf4WILply9IBUUYBMzSR2TTzLt4B/v6lNv6X4T4ppr5IcNOD1flGtfqVQjU0S7lZXui9WaOAxVtxaxHWpmtLchLZpnTEAvrx+3fmWhOviIh4YApW0z4P1V6EQh0aPa9T7UjkAy38MfFYWFCzBkgapiCd8nWP5EeavHOprdd0L1rnB4yMb8cTYgm9T62fHmrk748Ywf/bA5ynFisHNKcy+M003LhDM4T/S+12QNNAmk+EhBPX0nVMcO/9P74MS7q8U7kLt/dx2hspPaHr2IQYQtKnUZMCs2K1jQeez5/v8uoFzrRDreFQP4ZZzWqVSHt3m7GRSGGxgaCWPhpzYOYBCYOCcpg0q9zmdK2Kh9DjAXqIHghE24y0HB466cJCJgSxSQusLCOpVf4cF343LSKk96Tb/5fPEQ17VrrroRjSZV0Qs1fbkwzXxmEUaoyGmKyHWsuhId4pWz7Kb9GXKABJsPwOTFurdflS+UwGwr/PFzclQX7rYdBBkLXhAIcH1QLIe0LMqXTlQffh/1iHxlqq/hqyhyzRqSp9gjksMAe8vFesCq3lW7fhuI9LouUMoh/6Ddc5fXi1Lln29fESdo+0xfZREfaRR80td9MnBtnJtOIjAawKhcVZjucy6DftVdF/mE+lDF5R0HiMMT6t1fBSmrDcwtOxzBbyT628C7eQzjl3m4K2PKeZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(8676002)(36756003)(66556008)(66476007)(7116003)(66946007)(316002)(110136005)(5660300002)(41300700001)(186003)(2616005)(38100700002)(4744005)(86362001)(8936002)(3480700007)(2906002)(478600001)(6486002)(966005)(26005)(6506007)(6512007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqQK1wc9vAtWKNrigXSO60iJGGZBz6njY9KB24inQ4myQCNCR4RqxqR+pYVP?=
 =?us-ascii?Q?kgCoATgfB5mDy+fNVPFvvaQXbVnH5iqTiceVheonFulv+wxrtJyFrkCYyOqs?=
 =?us-ascii?Q?sHol7Q67VUsxhYkvLxYTkEXCzoDaULWg+C8wM/RTVLHHIoOEHu9CTluONyZY?=
 =?us-ascii?Q?vq6F6tatHqnge+qMkimLTKT3FqTSqh5N6YZ9soP1MrMr7+H2zUWOhccNZh2o?=
 =?us-ascii?Q?x0iiFsiqf8aVLLMCZdqWBJhJ3/o5ZeDTTTmZd0xI7IgDGt2aMxbq18jnzLOS?=
 =?us-ascii?Q?PI6qQubpyTc/6kbLxj9zTibEJ3S8DShIzczn6xRO3oLySrIz21XUUG8jfXf+?=
 =?us-ascii?Q?xoGVulxRxGW2blC8ZKlABgwjixCZvy/92lvotvom06kf3Sq/ePz2J/gkGzIg?=
 =?us-ascii?Q?QioM1RZeDWJPSYgUbrWn8sib+dwm372xtutRwDNCIkF/JBpRAJFynmYCdvir?=
 =?us-ascii?Q?hCNX3T3XGC4BhdcB2n01ex1EMgFefcduN4gMx+3LdGPTYoJQgkgyCpGB0OTL?=
 =?us-ascii?Q?oxQH1+TDImjXfZI7kgRNe5KbFfpepGrn5H8lmhKePdbWEIoW4pd9U56sjz3d?=
 =?us-ascii?Q?ZrzgGAQL9eq1/QaBGIRgMFOGN8wUXBgcF9t84+f4LJvLFDb4I9YOPgoJecVo?=
 =?us-ascii?Q?nYRCLaOYQ50FcqGHkQwyzrnbgSnBMbrZiRf4OZvYvo6Dq+HQHsmpCsAlR1kX?=
 =?us-ascii?Q?K0rJxRbPGhvTF3ZIN31NZAHXfGIpnTLgG0soiylNRdBvcu6lpLeP+ezBiHug?=
 =?us-ascii?Q?mLmzQkSQgZL5lFuRqNLR3GN7xQCe+6r2qiOBr5nD8/7fk05pM49xbFZoZ7bU?=
 =?us-ascii?Q?IPAz5/rT0ARTgYLxN0p6FqywBn9ZONXeHjKY844tjRr1crIyGCTZ9ySxadk3?=
 =?us-ascii?Q?JWidKEH9mpC/3yfINgR3q6CvtdiDZEtSy2ePlmKM82z9LL1N2Yl9vJGV3PUy?=
 =?us-ascii?Q?xxqUXWRmYDioO13Pa6ftg9rwf65q+TGzoiufo13EthVlSCDOGlslUl0Ir72C?=
 =?us-ascii?Q?9yMx76+mD0bBw0RxxwYtl9/sw8T4OGBFsliXUe/bnnsloiPf7t8ikJb6RfZS?=
 =?us-ascii?Q?eKRtO3GIFDv181WYRgRQ3Q+JZ+9vMxYOq/H1pCnMsEQgiamguGrLrjPo7q36?=
 =?us-ascii?Q?INvLga8RTse6obqbKuJQhYBvd1mTa6ZcunwFRte7n+5rqoLbzzbflVbMI1Iq?=
 =?us-ascii?Q?rsPzlknv+wgK/yJ1BqHtICjDQC2j7bkqvjDlK/7lwhSZy775uxBhndjDcQhy?=
 =?us-ascii?Q?NmwKUAAVVMWR2bE1r911s9ETv9HOj25NYDXN/5urcAkhrV7qZH4M3cD1+rVQ?=
 =?us-ascii?Q?n9Xtz4ENzyNX3jXRAFCgr/KJ+FU36g5JMJl7IX1F2hk1ct9TvYEZAVWu+FWT?=
 =?us-ascii?Q?ouqw5qHd9uYANjryhdNEW7cXbtdxJfDrE7FG34tupqKDcLBEUPQYsfSHEE62?=
 =?us-ascii?Q?L4WIznliOUxgRHapqBHLYPeG/wAV9Jn3KhYMRWV4pT7EPbzY/sfJx4l3g0/z?=
 =?us-ascii?Q?G2HOgd41Bo9ek7L+/TLbWacyHAlRI1iuNDJ8PDK2gEafgxvKJBqFZHth94s4?=
 =?us-ascii?Q?tkQQmE53zC5/yS9EzEs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0205bd0c-dae6-42ea-b54a-08dac353f273
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 19:44:14.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NlakcY4Hp+LYF2KQLINtShOfZ/O9xiB8A7JB3qgotIrcVvfejI30+Jk4gQHkLNS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I am looking at the patchworks here:

https://patchwork.kernel.org/project/linux-rd

And all I see is a huge number of rxe patches with no Reviewed-bys.

I need all of you in the rxe community to start looking at these. At a
minimum group test these things. The changes are too big to expect me
to deeply understand rxe (which I do not) and somehow approve them.

If this does not improve I will probably propose Bob as the maintainer
of RXE and just take everything he sends, unreviewed by me.

Thanks,
Jason
