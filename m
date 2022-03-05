Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7924CE17D
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Mar 2022 01:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiCEAZx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Mar 2022 19:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiCEAZw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Mar 2022 19:25:52 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2041.outbound.protection.outlook.com [40.107.95.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4992AA2F18
        for <linux-rdma@vger.kernel.org>; Fri,  4 Mar 2022 16:25:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHRvEpf+OM++kHVVqJO34skxnDYSSc1azajluN6ftYDw6oUHskUYuZGZlidUQaMCwr2NIn7KK96GvTDnJdIqm6usW6lxTyHTynKZfubGQnvZT855aG3Ryj2hOiAAYdQ1UkqZerivE5R0rAkPhp7b5qYgglJjWgeNgAoZhORYzHjFWl5wKG1WIqxxJrrBUVr1VOxLqr0wfNfhVhHKCtPz9mSV7kd55BWSRQVWpxXXio8BN6fUwA2FcuBue23/YT2CP5lXWCr3TE8OMOyuYcD80O89ZEXmsaNY8hUoBS4p6Y5/XgxX0KIAkjeQBjL3U4Kr3NH80jGgZqelnrUNLoqqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHN4IWjrBMmbYqnX9b2ds0bGZLu0ExOgvAdMmMQ/+5M=;
 b=UucHlKwaUGHhQp/u96TD5ORV61ISjB/UNUDMK6bGadKwRsFrV042nxIjGap8AsLnieZVFcagwQw+0SzmJY5KtlxZZqTCkK4KRnRHDjO62X88tWXZ/o7zdvk4ObLphKx0dxPdHzPRF+rCOevR4ejKaR6dSv12TKt+KWvP2QHXfUJK8dx4gLRo6bKYrVXlm4eaHlnofAQcno0GYTNEfVZBFPJ0/r7tLNJfUNS/rfSrDJj7p4rA5ZARRlphWt/kQiosdKmmD3oB/mHg0wkLOUwXvFHclPX1vdH8wFX+p6tZUOOgMonWLO8Dp5TH6olOvQvEqFXYKo2OnOvkVCgheYl6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHN4IWjrBMmbYqnX9b2ds0bGZLu0ExOgvAdMmMQ/+5M=;
 b=Vs4B8YGnmBpvKWk0WSL97VQA7DndP4bzKK13DlMdsD9yUwt5Ss/RuNp7iFa6sqXxUNnbh4NQhOFbVwIZ3ExsNiqZ6RbzVsTLXcb4JOonv6bt7XFxHl0uRMXpk4TDLDE0ozHm1wKfADM+RFLeVxR7T4g9ec9C3coDzaa9p2+m3ilP0GuN3yM3CbFdsacFNH7ZGcTnYX8K0Qny461RAM/dHp9Qo1H4+wKMyTAmBn8XSY+mRH0WXTfYWDaCvgxq5ure+wbcBXdY3/xFjG0/UGWe7TeOHFXmUcMQsTmOA8NZu+Wkfu8ZrgVwI6hgwdsJ1q9AHy0wDjV1Vd/Df6dbEMV35w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sat, 5 Mar
 2022 00:25:00 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5038.017; Sat, 5 Mar 2022
 00:24:59 +0000
Date:   Fri, 4 Mar 2022 20:24:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     mike.marciniszyn@cornelisnetworks.com
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/hfi1: Allow larger MTU without AIP
Message-ID: <20220305002455.GA1248225@nvidia.com>
References: <1644348309-174874-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644348309-174874-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7551939c-703a-4354-7390-08d9fe3e93ae
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925AD31CB4BBCEBB4A121ECC2069@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjfrg49lCXyX676SNyzDtkea3+bIz0xtmeFUd2pPshET63+9GRj5fwWUFfM2av9VU5XTpHOksmSku10QvTO+bGXboDbkayarvHcSQJ7oT4guaoQiyicoSFP66aDpllLkvRGAtAnXA3n2x6D9Nqc6WdEEdmC/dEI30IOneO2kVzo2dkovtv6dMFtCSCUxm7cVWT1flVz+/3OGAncbPvBNTqKk2HFTDJSKJdx+q0zKXuGELJRmqMeDWCupoGuinVHcC9AnzNTx7rwpFAyJcpARvEK/Uin8/6XZpnUIqReI96WT74ZS7G5+ic7yE3BzuuU0fSmryLx3AuoaykqwgsHqB+0Ikowb8u7CIACxe5kE2ZvtcAa7P8NPvmJyWFQw+i74RPmDQiXrIR044hGAGSQvcyPxpMTvMnBCnnjZYqFYsYAiytPSqJJHAGdU3HsAOmDVR+isH6VkPV/Z12r2dQrG7YAC7vnv6+xjPCTE2PbxwywBHGxKSDVilLbICSqq0kkX2FO/OmzKHE16e+NB70YRh4ceGGoVzgCVC3XtEYJ97EBhuPCAu7ptuq+6d7uEEPSDSol8sTS7GAja8bQuRFfEifUzFrcsVQXJ5gwXjLsC6i3QBBiJ/op7id73B6cOQp5HCv0zTixU8Xbz9eQwibrGsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(8676002)(33656002)(38100700002)(4326008)(6666004)(66556008)(2906002)(6512007)(6506007)(36756003)(6486002)(8936002)(2616005)(83380400001)(508600001)(4744005)(86362001)(6916009)(5660300002)(186003)(26005)(1076003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qGhMLssmb6PjusWfctvXb5uI4qh0Y7k3ihj6Ceey4JS+6hsN4En3IMyyJjP+?=
 =?us-ascii?Q?HXDTAGhvQ71JCf/Hzwg1XGSDwVlJnjhteXEGurXbY+D41bfrgzCBBZVA08+8?=
 =?us-ascii?Q?LKRli5x8B/ys6VmN/q58a7JAemCibW0vCIRNxq9/+kaI+44nPNxM2+lgmfHY?=
 =?us-ascii?Q?HqbboyXteU+klcWmdbbIHfCWohlfXeT6I456bPMOEmNNX6j5iNZTKFCnkv/U?=
 =?us-ascii?Q?ANxRO8fUdB8qNUjInkYuy1S7mHPAwgCwVY8ESlr1ZMILfD7Mv6drtc5ys0jb?=
 =?us-ascii?Q?HtVDLYeJBbcHr9D/PfO+CtfBaYE4PY+krCyvf3DBkDrvrCv6YR41ANR6y9YO?=
 =?us-ascii?Q?Su85EmDg4M9T+c2pX2qXZotQ+PIbpXsjfPAHxj34NhrJB/qGYvUbXbvl2k09?=
 =?us-ascii?Q?+8TLQXLzHS9DNF+B/Giu2Di152/QoFuGTMKYAUavCAbpoOBRxFMGBszD4hvh?=
 =?us-ascii?Q?bR2oS2S9WnpRB0JOZgYJrkN9lUPcypn8pZqwJ2ptgoWwyVqWlocPvGThZe8d?=
 =?us-ascii?Q?WNICiQfYkDm02o/vnNEWu3GN3/4KCWKvHQ6HNlaNcq60Vye27fSGQvl/8jGv?=
 =?us-ascii?Q?l9ar47W7suu9oB2VLlwoEwIQaFDmZUEKSYErXyJMnzGLS2zQs78klkXsfdSP?=
 =?us-ascii?Q?ekfSvCw/UC7jbCX+noRa6QfhyvUJc0sb628XeTCgLKcJBPH63UALVEgbOg2u?=
 =?us-ascii?Q?qkCXVEc6lNtWV7no2AU5CMYjYh0pw8wTw7blG6oVluV6V3j5QpCN5idp2vmg?=
 =?us-ascii?Q?NzDH6XEMPkhhjevdzu2xQ4eRumOgnQwYF02R5GhUrslPKmlYS3eK1M/wSQ7x?=
 =?us-ascii?Q?wuOhHG+amewHqvfAKCOejOfjkqhzMhl2/F9rzkKlRTrGkpK2ZTRQdIS61dCq?=
 =?us-ascii?Q?NUn3ABUKP2yl3h1Y/hLp4A/5RcqaL4xJielgV/Hyht8KAj7tybgSvx4tCT0C?=
 =?us-ascii?Q?5ZG0Z3QLYuh+lV2eWho0UHjyWHtFNA6g8IB+gy51Y75aYKDEzWPNk/+rvz9C?=
 =?us-ascii?Q?Mei2UaRIBjSHltyvbgb5NbaXACbUtOUlnDJQ/QrAIre94tAjQPAvfQUCv0jF?=
 =?us-ascii?Q?uwtWvc8si+k4HPgLqY2HyKUhj4YlYaiHlQgZgW/nj0TtgTSse6RdZV7G7UG8?=
 =?us-ascii?Q?wwhsBxvCCyJuEioNuOwq83sK9OGoxBQTOCuxXBkrWGqvode4YhxVICMtlu2K?=
 =?us-ascii?Q?WtsJa/nisLOz4I9ll4+JMRW1VioG/zE6hEG2iZr52r+6wkInBrAH3/ALQRt+?=
 =?us-ascii?Q?/U2haX2Q5MvE6TKUf9MGjbazy8rSJ57N+E7AJ3iLqdQ5p0/t9SVn+Pdr3gZx?=
 =?us-ascii?Q?eyZ4LJ+i6eSkSc32ic3/PPtSwz0kA/y0IOVoHIZGkYWgI2ThLfIvDHFdMeEp?=
 =?us-ascii?Q?tmA49RCk1rxuPwfloFSxzqs7kd6uU4jUpfyu2EpszaJH0ooPeC/sGyNtCWbt?=
 =?us-ascii?Q?TujJJIU3kK1XTEyE+pu9mfaNhIaggjAG9FgxqwJLju/UqhhdiZV5q//ZS7gX?=
 =?us-ascii?Q?hM/KWW/yUrFEzSZSKUFpVgbZu1Yvhp8sjIzYKg3eog7ZAGxh3+on2nA8TrVU?=
 =?us-ascii?Q?fJQExARBVbSOaaLerok=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7551939c-703a-4354-7390-08d9fe3e93ae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 00:24:59.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKBNSh2Y0nPp9tObaQMDBd6726Mis8HMqBFGXauzWRpHGlBXa/8foeGFy9Uce5FO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 08, 2022 at 02:25:09PM -0500, mike.marciniszyn@cornelisnetworks.com wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> The AIP code signals the phys_mtu in the following query_port()
> fragment:
> 
> 	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
> 				ib_mtu_enum_to_int(props->max_mtu);
> 
> Using the largest MTU possible should not depend on AIP.
> 
> Fix by unconditionally using the hfi1_max_mtu value.
> 
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/verbs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
