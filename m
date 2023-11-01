Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070E37DE601
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Nov 2023 19:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjKAS36 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Nov 2023 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjKAS36 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Nov 2023 14:29:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825BDDB
        for <linux-rdma@vger.kernel.org>; Wed,  1 Nov 2023 11:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZehMLK93Tp9evUgNdCGQ70kKeBooH0QjcAIACvUsU7a3Pn328p0ok+/Kc08/oBzb8/f5ra0Te05ZxaRSchpieeRiaHX1819HwaF1jw0Lsv9HZHyB+Z7egeQN65cvlTCmPcac3TZDs37PDwTtQ/bPVOTzLUxEKosVZh/z5uQvqRHnoYa4/XgF/9JFdRQ01zqdhoDd1kSSqXkZuKJzvae58D1Q1WVnRslc+9ex2ZrObV/XLOW1AgNrOqjua1UHyBdQPfgSEXPc2tT5s9r03F0wWLXsTKqUJPLU1m6+Dyyk59UjfKU9Xl+PBZKDjTEJqPTpXm+G5JrGZ8hdD2KXgQkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyraBnuOWmZ9VKueZvvYwMnDDQb21jS+uBl1CHNcTPA=;
 b=NzjKcqH/zvYcBg/gGaqxyM8zoEjROb6pzs1LFaIyrpg5xUKOkmX0lhU3uV7ma3rxdL4oClcwkfkZle2pUAgpkzfuWp8G8I85Ge4Ywa+AlZm2uQrbmk0pr7REoCmbDJKGu93JDXT6y2L1QxhRy4XkhTkHjDPTYtpuYl2bedj+nqsW/PUguj/3gRKxhob7viMHvJr1DJCLWtdHBRffGztReTFdbGc1ZNH0GSFbR48mTD9HfYAiby0yN3WENyTHKjvyZLDCXXM1Hk4So1OxkTsLXijRQO45ApqcrW68NwULNNnZPa5gLyh/BK51VZuiQgP+wERoBFuO9HX0lFxhN81j7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyraBnuOWmZ9VKueZvvYwMnDDQb21jS+uBl1CHNcTPA=;
 b=rdmf7na0lkTOBmstluRFLtz54LgGKfp0y0GdNf840clA5BAHNqgggSAhxc3wPwtyUU4768mSWQM4yPvClkwpg4ZQQKFzsPJuOoBBAM4Y2xybZPU+6yQiwxP1K19gzBFVfdQOn3IZ1rzohuIV3O2EtrkdsOJ41RRdu0H35+VGZj42wfH4gnJ7Zl0iDc7ZhlXAqYJf7u/3uAoINorJosdvmQw7ay0uWYoFQvpS7QepeS3YJ/BCE/w3l+7HgLrbSFDfbpl0mvUxcPJ55kCm9ds3+/4QNY/5CmXkOmwCnVCKNFyvgrGSB3tMmlDOz9gZMI2USNoRQtyp0oxy//es9dFoyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 18:29:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 18:29:50 +0000
Date:   Wed, 1 Nov 2023 15:29:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: rxe mcast
Message-ID: <20231101182949.GC1850209@nvidia.com>
References: <5b5d7549-1d1b-46ec-a6a3-baeaf4dfb179@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5d7549-1d1b-46ec-a6a3-baeaf4dfb179@gmail.com>
X-ClientProxiedBy: BL6PEPF0001641F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:f) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fa4fc2-3c6a-46c0-325a-08dbdb0888b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kkBxKPcDPBrDLxHUDMWmxeBP67iv7d1Y2VadAkNd+a6K/X2o36WNX//8cHbeifehOvqVFBXfquvN1yMAbNd3qslGjnk2rb6NdpJBWVkVdkykCHEgb8+EWPwIQXfeoy2CMHe311fj8aMYtpCqssXGQof1J4PZu0pUugflg9eoln6lTMNRTKTUrlRetPhuEb0BpCZXSsC6ickf4qomNTZpfe8RBgEHLPBGf0SZQfp5V15C9l2Q8zttMjTVCBwZWJtFy1+75UkWXFgoVlNfKSvf1oMqXbUEBFJGF2Z8Ogxo7VfaLE0jT5QX1QGlV1mx/N3aEhuF80OekmOFvNU9tX7ZERLGCihTOi8QEYAG/8g8ydMeJJGr7TjqPtjQaSgRMWC5weKNnggFfoW7fTVb5Ym4iqVbM64P/PHnoJmUkhwcZCLvHNqvrhLlu0Rxs30QfCcDZGD3K/29+eTbXz0Q+UR431geuAL5h+xfNXGmNE4Vll4nmlkbVjB1kcn4z4RD9c8znkUZ8tOgrLxzS5bODv69hu15AiEiDcmzBo8QBmz5UHIb1rjQ4b4OBu2i7nu1KrX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(8936002)(8676002)(7116003)(4326008)(5660300002)(66556008)(66946007)(66476007)(2906002)(478600001)(6486002)(316002)(83380400001)(6916009)(41300700001)(6506007)(2616005)(1076003)(26005)(3480700007)(86362001)(6512007)(33656002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+8rLgbpt59Q4uxNUx9ADz7Juu/eB+5QNm4nZDua6GRbSpfJZeNlh8T+2vm4?=
 =?us-ascii?Q?lxpgoRu5QyWsmG4gjrWhxUDYCS6KVIq+LaXVYzlHw03rvgUjsZ2hXOCSuTGU?=
 =?us-ascii?Q?hGt4VsGJoaJyK7/rebXr3F5hcmlHKrbfPalAmjWhfeQJLFjuc1FJXItcIZXf?=
 =?us-ascii?Q?v5py6m/wgIlux2XTglxPfAqV09WpRoPltMq1FmTCA4i60yR1JhaOKRyY/c16?=
 =?us-ascii?Q?nPWYcUWUjH/+D0cg17x4QeVk1FYnOtFrdS4wxCdCKDJ7MdaA/qgN+VKNKyd+?=
 =?us-ascii?Q?ZPQcP7vPkzxQvwB5fNA6esBDhBj1VMsocgJ+n0nxCUQ9WYNtW91PAIqQU164?=
 =?us-ascii?Q?FNB2ewSl4iSs82zIN67tQCOEe9nQpw9oS2iV44ptGrFEjpDKqk1Ue6MDg3AM?=
 =?us-ascii?Q?CHADLqxp2yaty4vxEjG+yy0eKPFmz+ErOqDrt8eMahVBbvYfwFZoqy53UYpt?=
 =?us-ascii?Q?HAtChv7lYL0ETTg/rC8g4CkejIGXsEtR4Z18bvTnBxUoxqy0Vzu8DrgAO3Aw?=
 =?us-ascii?Q?m2aN7S0OfKdKiGt0fOjnkKpgR9L4rmecInAhQQ7UfRyaLRQVJb7yGwIRw2pR?=
 =?us-ascii?Q?zSH3tpQFLkckOk90bZzMs5iaraP8ycJ9jl1edSDtwqVHxAOmjg6YViQ50a1w?=
 =?us-ascii?Q?oHUNwmb09BdYHcTLi2g/FQCqddEwmQfzsDiCRLqa80U4NheDM/RV6izVMgeT?=
 =?us-ascii?Q?/9BnTGR3Gtb78cZm8rRB/7or9/xfs5dA5ztk9vP08z108Y1EK83vQgetvuA+?=
 =?us-ascii?Q?+17T70kpHO5EyrcnlFR+vPODD/UJfGvNyrtkC7vhnsw8MoMzz1sr132d+CMP?=
 =?us-ascii?Q?VFraKyHdTjhosUNcixXHdiFPa9PBcfw+UYRJyQdJ/IA4w94tIXRui7bdz/ma?=
 =?us-ascii?Q?rzAWY+Ij02E5j5ucJKJ7cyFNjOSdy2ovOz4h0fbYs0DbkMroEZ68nCapXNEV?=
 =?us-ascii?Q?dBK+q7Ccy5o15IgV64A3DrxIWsDa7aNxluBQbxdOC8xPhJmKuGMG4PjFqDwC?=
 =?us-ascii?Q?iV+keHaaG8NZ7ycHOWst9vF9MjqKBxg1wxxlE+0Z+2fmi1vALE9uxICfJMy7?=
 =?us-ascii?Q?scfAOvEioDUTpu7HLoX+RG/gLcYI/rPlow9dUJII8mAUiY2FIQcKzBjgraEE?=
 =?us-ascii?Q?I68EOsMc7k8yCG4y5w1xmShNBg2OtFyHQuRjDivCgH04yXETmUD45QQCzdIA?=
 =?us-ascii?Q?F2U9ZUGN4i658QMxyKDEfuAgxWYT3+KVGviK7KSWmFr5Nde6ChRA9PMfctFW?=
 =?us-ascii?Q?JZ/bBdWv4CxZhaFDJxhohitRri14rt582Z0caG9zhL+qf5f9PBpEGdymxZD6?=
 =?us-ascii?Q?Oo81BtMUn/0nLqkToU1p5FAK6EcxXV/sFbSY/C4gph6HmvmRd0lBkQljd83X?=
 =?us-ascii?Q?kwdOlHyYKHunnZam4aYheNCspyYN4cIvs105gHJKiZttXO3YcsJbmzHKLUpo?=
 =?us-ascii?Q?puL4XGWN6CL/EjDeXFRfz9RigZu/+OCucd3xY+4hOAx/kNoFZMDTW5QT53Y4?=
 =?us-ascii?Q?dOhqTuaqVW0E9B4GgB19Si8i42318+sm5qjv4VNdSfXmhxg86ySuAH8H6U3u?=
 =?us-ascii?Q?W6K2fTKSVeDnJKNjLHPNkoue3rafJ4CK6Dx1BFQa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fa4fc2-3c6a-46c0-325a-08dbdb0888b6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 18:29:50.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJI/LvDc3F0dcudgVzb4lCdtNoYHnT+cH8ktAyMVL1tR3mOgraK6YUzD6wqWwZVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 01, 2023 at 01:07:28PM -0500, Bob Pearson wrote:
> Jason,
> 
> I wrote a test program to verify that multicast is working in rxe
> since there don't seem to be any pyverbs tests that actually test this.
> It turns out that it doesn't work for several reasons most of which
> I have fixed. But there is one that I can't figure out.
> 
> The rxe driver calls dev_mc_add() with a MAC address to add the
> multicast MAC address to the device which shows up when you type
> 'ip maddr'. But nothing comes through from the network to the driver.
> Wireshark does see the packets but they don't get to the IP or
> UDP layers in the netdev stack.

I think you also need to attach a multicast IP address to the RXE
socket ?

> So creating the IP mcast address seems critical to letting the
> netdev stack receive traffic.

Yes
 
> I tried creating a separate UDP socket bound to the mcast address
> but it doesn't seem to create the required IP address.

I don't think that is how you do it... There is a set sock opt thing
you need, IIRC. It has been a long time since I last wrote code for it

Check what iperf did and that will be the basic thing that has to be
cloned in the kernel

Jason
