Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A6D6C7F89
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 15:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCXOJp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 10:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCXOJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 10:09:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C31BB
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 07:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvpQRRUOAEankDmarjZGYlJzjTCjPJIu4AKYwiPyZH3CrV/JDjJKkqt1cy+3Y6tnk1ATVFRYdjDK2sYuadzhsUYUnSJrU1PC/sfmAV4wPBWsdemsPLem/+jxrvMeti0IhTx4lFJU0T/NTYL4mAh+1M0m8Zr2RJCnr8KAvP2yVW5PxBpkyNgX27CsCxMPffGId83RyhPaSlJHAe7ZciDeN2qvW1FbKSyK6t+35k+8z7T091niPt1zoRdOnh9IP216K0DPTdcRw/gUJ9n98NXFXACATqupjRLL4/dfq9tNqFEEN1eVj9MqtKLZ+X+oFTE3Uj/ogcXPHO5HACXhzwZsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVLUAmSVtq9ZJ2wH3FVg49He4CJXcCDXuqTnEStDjjI=;
 b=XIMjkkPoht2+J1341tjWoOPAtRm7DpEPz5Mu9ir952ULtwdIxomu6bxUC8mrECQfNT8XpEJsgEUAEHbO3oIhEfoVg70b8lwHL3KLjwj3MYyqeI22coLnR3I3ED0P+unIYLZC2TXTDcKaQhxpebQyG2yzfJN69ZlZ4kjjw2s5lGKMYREXQy5bv9GZoQ0I8/Gu7pm7Sh+sB/+I401Nc0J29hbhrOmBKK8VSASK5b8WwEIZojzAfkaFXYUCDrCMcla8BpXZ/kV0mTyszXIdnHmFwNznaGFRFCquJM6QmyTeZ3V97rxRSoHTsJW91K2KF8V61ETfZ0+B6GMJeXYJqzIA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVLUAmSVtq9ZJ2wH3FVg49He4CJXcCDXuqTnEStDjjI=;
 b=haup3x21btZIiZoXhlkmNEqkVnADXRv35Kt+qwbn9RBY0mJTMCOBx6/g4gXq0MWyl/f4V0Y1yRSyRLBUihhquS3tjQo6sEQs+ByZpiqdZgPBfyxR/MCjIS/5PudbvNWOIEqrRl8V2U1D3cKot62rqwohXntn2tOQmpD4NirlL8j7IFqx9QPTNWtxUOswm4JSQUj18BVz/wtCLS0z8K7B/2tDlIJiqZsSwpAwz07FU/SEJe3ZmThEZcvkfTjfm+JH5b8mcHJnvKJMIsZ857guJ/ZqCU+IPf1oGWLecGtjtZqK+MzbODZvUhJfgZs36nZODx7m/qK0mmkLOWWmdUw8cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 14:09:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 14:09:41 +0000
Date:   Fri, 24 Mar 2023 11:09:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, jhack@hpe.com, linux-rdma@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH for-next v4 0/4] Add error logging to rxe
Message-ID: <ZB2vIyDXniDEgbFR@nvidia.com>
References: <20230303221623.8053-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303221623.8053-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: YT3PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: f144d9e8-8239-41c5-e061-08db2c716918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0eq/5YhVHIPn1ZLJ2eghauSpiJOyVKqV32IYXEbaA1tODHd1UIPrwMlIhwZMVv3CN7XhIoSHAMo9YRk1Ni962mloN8N5/edhxZHmbV6TInpFK7UfhZiCLgX2HeMg2OmUhtUWuW1zH6D7CCv0p+l+FqDhD+lE0Frvt+V3CXTxRxFqgsKHAt3E7y6zhEowJOpzeHxHfMz6eQRLkRxGJ/GKPhJCGpmf5rwWqhrODjOLs1lq/RcHj9zYvxrTflZYQs47SAsPQDjlxF+10PDcQY5pXXCh+C0Xhs7YxoHpRaH8EU4/duAKEp2NeMYauHXEWB/WumdVYeqFBv63AKUHJBJYtEnBIcJBZ/uJIVGaBG0eJ/ancq59z3hDHvKoD/sEMMEe400TMr7Yp7wrzxlIOjgHnRIdjooLHKi1AsJaDW0lu1wtga4VKbbhqUR983ppJdpdVj+xBcn3eIAOzqbl2es8GtRpQQdBh6Z6rd8re6Z6ztd3EzIU/MpjhmQfEGMA3ZmR2WD4IvVx/E0gjnJ3Y7hC9xK4IH8sL2OvMtaUnaOCKNobS2towyWTm9ffBdd/VUE4Vs9O85SWLmeRXT2K4P28kV8zQaTIr7MaeRNw/JJ2Sug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199018)(66556008)(66476007)(6916009)(4326008)(66946007)(8676002)(5660300002)(41300700001)(6506007)(8936002)(26005)(6512007)(186003)(316002)(478600001)(2616005)(966005)(6486002)(36756003)(83380400001)(86362001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x9Kk/T73Qr5+V6cbBNFR+2NjPFD52cQ193AUec7xz3hyK1fXhRjH7JJLBdy7?=
 =?us-ascii?Q?uOfS4vquv5eJURBRmuND+4HzDZnazB4i/btSLx56Q3uLL3LYl5u4dovFAbOY?=
 =?us-ascii?Q?0voCAbjuKk6k7uPFJDWPrvHEQEAOfllQlNWG9TS+8tF2hXvd9LwoJwJ/l5Vy?=
 =?us-ascii?Q?oxAR1BPJ+odPISQUfv2tI8Xj1COgMAPAMVqtx8MYDUQNsGCT5hlOBz9Xa1vt?=
 =?us-ascii?Q?FxeJx5RkFrS2oaSatYN1hFy84ZHLWt/qlnet1FtQlTUct+9nhZI0z9RnbAiI?=
 =?us-ascii?Q?gC1m+byrVeBKLm8JBc3I+PB5Quc4jQ0xg2dXrdfW79jIrQ9vhT7YDoDopomg?=
 =?us-ascii?Q?3LTVOtfZczlpbDajyTnwsmmkLhKN3Ef4cGIb6ENmipjkk9rOW9Ec+XFTm5EF?=
 =?us-ascii?Q?yJSHFIF0r1/IXu0Vtp1pG+uZqGhMWyJe/Zu/8S6f9x16ayxe4R8waK2kqm4S?=
 =?us-ascii?Q?rxwRaX6ZmCLVSvgoad/SasaZMBXQxxH3cA/ai7oOY5t21LtqXo+0obhb5CAK?=
 =?us-ascii?Q?2DPrLIa2Ny3FvWjZ5j35SpQU1O//fYDNdRd0GecOyrMloEKVgMVA/UGBGWkE?=
 =?us-ascii?Q?BDMxOZ/DKcTXda5jna0+UbYPtCET4wOhlevw9IgCwSZZlDKoYrCjlxVoQMOT?=
 =?us-ascii?Q?MJnl7VOZO4cXcC+nsHt9TlheqnJJbNE1rTkUYSXXhq4/ecu1dcE+X05b3z8w?=
 =?us-ascii?Q?VGbiE5sbhsgmNKDsKrFSfbFKUnYaaQT5Rvj0OVrxAFmSWtdZP3REmLJc2sqQ?=
 =?us-ascii?Q?Z5rMDZaFQMmbC4AKlTqWHVuT0F4bOCzr/BtGOfWA1ah5eQ38/BtvpBvi5qUJ?=
 =?us-ascii?Q?MLtKe0l8esoZgIIW55hYT+FCECNgsKbrmy5qm6+XjlnLBjxHpnQwVH2xrgLA?=
 =?us-ascii?Q?/V4HUKkgjP6MxIikQILWLshoPMywmVlGp50Op+Qx8kvtMHpk5yTMAXvLQj+v?=
 =?us-ascii?Q?a2mF+L0o6GBoNQ9ki/nHBvOZiy20Cmen/zJuhH5AbmJlZl3BxjHI0R8sLAdO?=
 =?us-ascii?Q?COtXxoOTkM1+jzpk95O79mRqUTHOlmOABBnWs+k8jbyd+lbX3w1UujW9akMW?=
 =?us-ascii?Q?ts76zQJQatWze87nCWUCZ5XZWd1m4civ2+XgBAI6SpR+e1T+v7HsWEdzYOWe?=
 =?us-ascii?Q?QF8lMqn/phsBWp2qQjDxhLcbeN3xfylrneEbpTCEBmmrBZrNlp9/R0OEJLZ8?=
 =?us-ascii?Q?GgmDm9ptWvaMRMi4UgRf5N5d7cHyAGNkw0d8q6Oj8krNvY8hxcLmnKEvFPgI?=
 =?us-ascii?Q?UtLlj8Ushwy8utKkHV56szlt7GFvku8heHu8QU/BOVCoP5Jj56wG856/bRf1?=
 =?us-ascii?Q?rkiP3BK5SdekGOvka6b0+SzgDMtQkgv6FHyQ82DktYR+cf9MuiNc0+IKKL0H?=
 =?us-ascii?Q?97RdEPCOwmKK+Paqsqg/a7ezOjwxr/lA+M51xoJhbbKGFJYmzEfhdxRV/xrm?=
 =?us-ascii?Q?d6ju82mZOCz3u0dvh+aRZl2oFK1ixsiFeK7G1XXC+7MxSNTHJKLnDqlJJdvT?=
 =?us-ascii?Q?IEvW7yUwRR6cquFoHKINu0eCBPAMoGgMm27p5WRIYAXpsqMwGEcHPA8kJq23?=
 =?us-ascii?Q?bsojfImaYuIu+9oVwXn/slJML8ZNl+ToMyu64xQK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f144d9e8-8239-41c5-e061-08db2c716918
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:09:41.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5qcKRoXlKiO4XKgizgnm7lP48LBrhGxYE2ZJiVqGeJNTfmFhEvd36J5iiqszjRF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 03, 2023 at 04:16:20PM -0600, Bob Pearson wrote:
> Primarily to make debugging more efficient, log message types
> are added and error logging messages are added to the verbs API
> to rxe driver with the goal that each error reported up to
> rdma-core will generate at least one message with additional
> details and internal errors restricted to debug messages which can
> be dynamically turned on.
> 
> v4:
>   Removed a mistaken WARN_ON at line 750 in rxe_verbs.c. This was
>   hidden by a later fix that covered the error.
> 
> v3:
>   Corrected a debug message referring to err before err was set in
>   patch 4/4.
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302250056.mgmG5a52-lkp@intel.com/
> 
> v2:
>   This set of four patches was split off an earlier series called
>   "RDMA/rxe: Correct qp reference counting" since it is not really
>   related.
> 
> Bob Pearson (4):
>   RDMA/rxe: Replace exists by rxe in rxe.c
>   RDMA/rxe: Change rxe_dbg to rxe_dbg_dev
>   RDMA/rxe: Extend dbg log messages to err and info
>   RDMA/rxe: Add error messages

Applied to for-next, thanks

Jason
