Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC634C7256
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 18:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiB1RP6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 12:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiB1RP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 12:15:58 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7FD70CE0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 09:15:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz/qJCRMwNkyf/uk9UlWFMPBzge6hwh/NGRB8zLUtSpr2jf7hiSlo3qoM+X5k8RrME3z2CZ0cqB8aPrT6jDrSGFBPVflXUDKzvM4xS9b3hgYHhjTM28h2dX4M2JAGsatvi1M8k4m3CsuPMg+dVEF8Ookj/do6jGB6TeQmQQsXz+x5Sm083GwbUtDHFW08VOlpEPJr9kkU1NIySaXgFKMPqQ+/qeD3aXwgLTaAfwY1rzWehUaypbLB0H10yOPA3RNeQyluZtSONG/ty2eEQYvvjkJlDeK6okEvqH7msNMVtWQV5DQmOm2Rty7HbyvexbPU+f2bCIeUioqh76QXF5U2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs1LUCc6sJ7d3RfJBIwCkWcnwyE6wZnyK5/hLG2I0bg=;
 b=R4i3mSuRzHEojG9BQt8ExMDKT/gB0mlWfdQJVWIoGBbybjFVW9HIeumktHMaF50YGJ3qTz1BhkChts91tqNvVuV4nt3NiY7LJRuybPeQejFgcA6RdoB95IEzGJC6wYxpKFCuN3ZDv35HdxUFC0KMrahKJonwrqE1OF+Cai1P/oSICf9rUXYOAHLRz0kDAmBX9cwPs8yjgBFTJSVy9iVyG8pjgNPzasuKSbLHjlTIT9FbVvT6C9U9ETjcalgxiCY7po67xK+T5vjZm8rgdeVfUsjQ8Y+1kd65qaXCpt3Akpo9rVmQqi7fAe27CUNz47bvedYFCg5YW17N/Og8WEbTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs1LUCc6sJ7d3RfJBIwCkWcnwyE6wZnyK5/hLG2I0bg=;
 b=VdWhLSu3HMnnsBJpTrsZScUZ4OkV/JOVUNWKL07Tzm6cbdUiVuZlKtOWfDsCmHYlBI/0ZyxD0d7sMfaU3cLDKG9HQcQ3WsGs05Pgp5DDNxqtWyeWhxJGfU5a13NJD5fipFQpuRj2O5emU4aRW75CvUevQdX8FIc815/VoCSCbnVwBFbNaJQEOs2+nvYQEXucr6iATl8fU7B7sNadFBCuHSJzFQjwRNPdoRjQDUE06MBqCLEh3BvPtkCpalIdt8Z1MV3TsSILhfEj/gWwSi/p/ZYbLOBw/kOhIvKYKRRvg+qK6eE9KiiY2FNk+AhW+ONmHFHZDF3WwZwXe8xbY0m9VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB4788.namprd12.prod.outlook.com (2603:10b6:408:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 17:15:17 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 17:15:17 +0000
Date:   Mon, 28 Feb 2022 13:15:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v10 01/11] RDMA/rxe: Reverse the sense of
 RXE_POOL_NO_ALLOC
Message-ID: <20220228171516.GA605207@nvidia.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
 <20220225195750.37802-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225195750.37802-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:208:238::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63c105d4-8dc7-4537-b0f0-08d9fadde45b
X-MS-TrafficTypeDiagnostic: BN8PR12MB4788:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4788DDB989FC32A8F8C5F173C2019@BN8PR12MB4788.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfZ5BjQt5HN/38kPOAPqyPC8br1fUlhNHRc1jF9QO7lXbMe7BSd4iznGvdZZg25dxsmmo6cyfl77WYsjZ2POVXY34bRYWpmlg6OoLc6UQEX6FrtXKDU3t3DXQN4CAVJO2o7MRv5WTUpd2OlVyupjkCD2MhgI6MEP4rASPTdKVJvbkdzYWdz1x3ehuYB9//OX3JubKE2+tYiNNehorjmExfvbWJ2oZq9LbkIhYjBjGi3DxFWWqQ5Be72EV0Ilt9QkImd9/3DMArRlinYmZJ7NOcdLRbqB45mh2PFxowNcuOYbPrDUvX7SByApuroctXIRlr/9Y+ooCzqXjLfZtUptR6V31bNhaj6NkVFxfAvxPEOf81HTUGT/2SOz+dJ1w6TPB1HltrEDvQC+xjEhSbE2zTbNHRQuhlqpxBGQYhBRCdSOnLnMVMkvsk3OG/gv+L+Mzz63sVzKf0xAezUWOZq9EG4gWp5ouEJ5Bz+VtHLhzyBtmf14KNc9ZmGkzpgzoy2jHBy9yyjBLzZvp/UjlvY4IZ2mJS7k0CGVPQj2wJotB33GNJTDAX3U+mgcFk1Baz48H3q4aB/9w8pmuLRGvWu4pP8HW94rGnNuIPalfgLVY0wzj7t1q6L5n2UNJDQZiY5Vfpvw3tsx1ypXUAQ6JL1N08SIS/VEDwh03hM2WZz7XAPpe3LDHKWq5c4SFZHwfr+MZ8OE49Cd+ZlusOqVmKEPvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(66476007)(4326008)(8676002)(86362001)(186003)(6506007)(1076003)(2616005)(26005)(36756003)(6916009)(316002)(6512007)(33656002)(6486002)(8936002)(4744005)(38100700002)(5660300002)(2906002)(508600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cikgXMwObTY8rDZy2njUHzt0OMx07ZKwf6uSYwbu8l82S8PtJGf9Lz8N+vk?=
 =?us-ascii?Q?1/Yc687u+Z5cBxQwfs8TuHuW0OqhORp6FMGwptQgsDnH47UQzlTmnn+46C8w?=
 =?us-ascii?Q?0bTL548YCNYyjGNyg4ubWlROg+GMxPRd/bavPdaMOA8Dq4GpboeFRQCd/zqX?=
 =?us-ascii?Q?LkiW0HyzrE8vydt1aC2i1VmrCtvXbyCSUrFo88sz9Xw/2pH1DTRZkYL/cGOo?=
 =?us-ascii?Q?VpdTbEqPIO9u6O3yBfkfYtfrwcCj1EIYC38bOfXRseXVa0LVW55zf12MG4Fe?=
 =?us-ascii?Q?hBPGCAavqkYPrLFpWDnzBBxkeMun+VBw5EjnQcLqssk/Z0x5bDnRZhlbfyb0?=
 =?us-ascii?Q?frVIVEkBZ4q6wCRo7+A75T6GjxVm3FHLDsFSs+PsURR6mR7/Uuq8xVpHbyPg?=
 =?us-ascii?Q?VKTZcfU5nxmUuGR+/CzX7YwShU2fFBSuJaIyY0NhIOtB3VTDzMuBnP5JSeoD?=
 =?us-ascii?Q?ZvCWclaC+KLVMDHSi9JYTv/79hIObmgnGVcsF2JnhHaSgOHKrTB/O3occWEU?=
 =?us-ascii?Q?iol1KEWAASuIFDeJxxYq5rNJQNcITljISdEE2msl4fDLAncB4cn6l4j/Rnwo?=
 =?us-ascii?Q?/oWxrsuivG+/BB1uZ62piJrjNlAlNlfynUNrNQX4CTxskGPMNVPODf+Gp2yJ?=
 =?us-ascii?Q?FIiABBT8aqgWmYlifbfdNGHL8UI4YAFPp7ZVYUeJoUT/zXAk2EvWpBkXZQbc?=
 =?us-ascii?Q?qtgplElQkzupFQAVCRCL7dnwR48PUmvYeCO1exKSKuOkXymx46FXvX6njx5H?=
 =?us-ascii?Q?DE4ZqgFgUOurSYAqxc+ZOOqxP51i+eDxrJfuDsNzWabXpobMN9O0GJMokULZ?=
 =?us-ascii?Q?Z6qC9Ch+vvq7zOh96USvp4eA7FePv7a9Z9TMm8NpL779ASRDR7Tfh/1kfk7u?=
 =?us-ascii?Q?/f1sPXNBe47jZQzhRPwwfNY2cjpktPwK14LALHJmY3EEVbA3MkNiWeOQP5aa?=
 =?us-ascii?Q?9cpSGJiKl6VdcaEQ/fzLsnh3XrpnOCc1RFxR4mPo9jWSdBHnzgWbTwaptVS2?=
 =?us-ascii?Q?0+7MfAvH4eF+wELEkHASaDAETbFbkS8oitXyn1LaX7fM4Q5qjlGS1eg8C+RW?=
 =?us-ascii?Q?FKnUdlXvw+FoATGwISRZGkBaqE1/i0xg18CWrZtgki02Nrty1pqTWPT8ipEp?=
 =?us-ascii?Q?JeykvLsvE+J9c0x/xbvfO+ILxv407GA3f9uYQ3aN3dHOW/ZtrLztMvEUeZAq?=
 =?us-ascii?Q?OC83JRAePNlpdrfF210YnU4bUJX7CIvkiXCw0aDSLzd85iJLI2muKFek/pOj?=
 =?us-ascii?Q?ZQTB8F36mjkELiiVtmqhQmz+/xrEMwUZa0dDxSIgM3wPFy9dmEsrrBySd7bj?=
 =?us-ascii?Q?nl+4+3F3kwHlmlJ5SdLUL17nkLsA2RBKxNuf0yfXTSkHv7w3c0PaIB/Gnc2V?=
 =?us-ascii?Q?1CXBdJg/fCkp7IqDJnXbP+pSLa+lH733K9sz1dY86IU9qAZp8g9P/dobbeom?=
 =?us-ascii?Q?m2PPbPEb58qpfiw3o4OqoEWNeLxAH/Mxuvp6tKEbU68EF0jMiXpgdlwKA0p4?=
 =?us-ascii?Q?HrrIyV1uMJwtKtO9D3tuMXorA+YSrGB39u1YjtY/iEPq6yDOoEGX7qTuUb0u?=
 =?us-ascii?Q?ASObeeU9UccLNha9rv0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c105d4-8dc7-4537-b0f0-08d9fadde45b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 17:15:17.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc2xGrFE8kEyoJKSbDBmthaX0EdFdZ7pe6gjJRKcnWbLarmZ+VaNtJACvTW3WC9T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4788
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 01:57:41PM -0600, Bob Pearson wrote:
> @@ -264,6 +261,12 @@ void *rxe_alloc(struct rxe_pool *pool)
>  	struct rxe_pool_elem *elem;
>  	void *obj;
>  
> +	if (!(pool->flags & RXE_POOL_ALLOC)) {
> +		pr_warn_once("%s: Pool %s must call rxe_add_to_pool\n",
> +				__func__, pool->name);

Just make these

if (WARN_ON(!(pool->flags & RXE_POOL_ALLOC)))
   return NULL;

Jason
