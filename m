Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF052EDF6
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbiETOTA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 10:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiETOS7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 10:18:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FCB15EA77;
        Fri, 20 May 2022 07:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gncEIe3CHnCpWaYYhY3s1sRFxM9bY0MS2ksLosPQxGfHNniiD37Fvo+YXoTf5Oo0/m8X53/+02E9kYmTExuiIvPMN6iVkymoSMxgH6GfhMvvd1oku11TM5FDswa21YwvtotP63xwBiqC+IR5qdtYh+cTP7AIICG+Us1zyjS+Zz2flsW8dwIj954T5hgA6XTLjr9EU8kxo/A5eMrj8fxCmnd2TcolxIYtC559vN1dmIYc3nB8oMVypap8FlyZyhuoO2MhkZnDmOm1J3I1LYMbhO4dbjeto0zAKivX1yAxQp5XZghQvOsZ9CuvjGdVoUUJAh5ocli8BNqCQ9YMvsXEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYuACj/Gaa7L5AO+PZ3z4uIdcVsFJaCBVTj7s7UlST4=;
 b=MoyiX/UE/aNxJX4aHQQLWanb+S8KbwQM7iN0mg/Z5n9coaFUIgRWVIIHAkZKtRW/uMGdNwTO9JN8QpgIV5QuYGCtYE2ThnzCdUJZfUMtwHTce3nsP7I3+/Wq66i8z9/OQyTeJFoA1kKl9zX9vA7GdVXok++unRt/cjzQn2KMuUexdPLUjatC9s6WhFK83anUoGZznrA9U2sRz6D2amppfwiHFgm1KvZhjeabLOKMnZtf9zHVYcpi18Tbfu/tljhlJxJ6PKnGht3WMhfI650RQ3vycfxyn0az1FDtzkcJbSQYWE1Wkn1geu6ujeB+ZbaBC7mvVA4z/8QoyANqS+dcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYuACj/Gaa7L5AO+PZ3z4uIdcVsFJaCBVTj7s7UlST4=;
 b=ZqNodVA7d9bCkSo+AF+iSInNUQNclubPtTVSf101UVf+zvYppLWlJXuEsVV6Dkg06RFw9OI9JOfq+JsC2Z7921uSmKPRVZ4SfAX4bWmUbyMR8aRcA3k2fYKhIUlHsCSd09pIQub+IsQpZhgjf9vJ7pZHZG1i6B2CJocQ8ousTPjCNcg94h1zkJX96eCTNhpdjuKcPWgtnxtyv+r8lUzYl7ATHx59QcoRDcuRlnFpCOu4WHkUL5S2v7rog5EUL8J6TUj7kP1UJ3HEZ53CSFsXa1H2fdlKQO6a546812AHaof28KdUfGZiNbzg51izghdIl19xWqD6GlTE+sUKq5L/Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1132.namprd12.prod.outlook.com (2603:10b6:3:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 14:18:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 14:18:54 +0000
Date:   Fri, 20 May 2022 11:18:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        target-devel@vger.kernel.org
Subject: Re: [PATCH] IB/isert: Avoid flush_scheduled_work() usage
Message-ID: <20220520141852.GA2296837@nvidia.com>
References: <fbe5e9a8-0110-0c22-b7d6-74d53948d042@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbe5e9a8-0110-0c22-b7d6-74d53948d042@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: MN2PR14CA0015.namprd14.prod.outlook.com
 (2603:10b6:208:23e::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d5be95-1c63-4883-b0f4-08da3a6bab9e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1132:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1132B4A7A37E00A95F74DE59C2D39@DM5PR12MB1132.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4SLXtc1yX2vyIwN84n0Wb4C1wmv1ZWpe4aDNS3SEqIFj3SS6Y+pMyZqLlyGGp14TzghYAHeRv/O5tfsKNR4zLgR2eemYL/7NwNLqOCopaC2+6wzvOSBjhABQGekeY1Bq34dvz8RO6GTgVg5zQbZcCRB/5oOUusPQ4Co3lDKAS8Jiq9Ko11a8Di1NjCWRLyIEhz0l1+pi3Pphip14ael9uDaIJYaaGNtfAaUjPcJbibaDa/GVMPd/AZra01KrBwh0m8McV7AWzmJavshJYdQS2DoeXdlWZUL9f/hLAAMumUTVLmemdhmn7ba0Hxk8LL1Fhe7bM8hzTLuaBBOW2PfKPSnnENVztJKKsWTGBmwfLygUr/lrAdq+lUX9b9VvqPxTHIbMy8Wmf04DHwidk6BCh0x3S7zIOrK/diP88+rmXX7hBqHVZgZFPyYna/9RRcLCbXcNdC7qxNtSiXy2eLkMFLVLfsSEWqe4DdsLsLuzGMKS8E5wB0npDOIeBQ1CV40HSEKviiZTwG+jKQA8rHKwh45elo169a0Cl1M3ljiehqe2fFp/PWf5FVRAcsW5PfxAh//KpjCBN4z9uUhmnkqIyZJcyRFOW/FjxEEjTFnhLZNWgbdXIrRlI6ZEtVhKoI8xnVcaljSElxvmkbAOXBWjZozUBgjjc/EzDCQKZJmFFu35XT9ocxqo+PC8W9XjxI0dwMIWUeCUgWk2pXcTWL2Ubk0eEePPqj8bYgzEPvoRCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(4744005)(2906002)(38100700002)(86362001)(6916009)(54906003)(26005)(8676002)(6506007)(186003)(316002)(1076003)(966005)(6486002)(508600001)(2616005)(36756003)(66556008)(66946007)(83380400001)(4326008)(66476007)(33656002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eFL0IgsAgZWZhUQ0l+kFHgQBuS6vqtl0FnILwBs1pB6cq0ZI3ZoEwUIUoSrk?=
 =?us-ascii?Q?cHWjIM1yj9pzZn/iIcFfGP4BxMLw1UHvYpU4lXGu+pjCoSJb2yIhRXYRyT5j?=
 =?us-ascii?Q?Uukqh/Ys3ZFQrmLTTM0Fj0yEaMikmNyD7M22yGQVHDAcLUNjtVhLRMYdIYOq?=
 =?us-ascii?Q?3grFMpr2Jax2852c6LTUsomEawuQitMjQqC+SaqPdt1EcV0VzyZkZTipkzSa?=
 =?us-ascii?Q?VNOuXX71NBxjHFg1Lj0Ll2EwOo1FES5ossDt1faJJiremxbG4oC+SpX8Ql8K?=
 =?us-ascii?Q?+oBGS/j+62o/4juZPrZv6ngoG/IvJorLExa2ZIVccyX7ZSrW366XlkHW4vnd?=
 =?us-ascii?Q?hvBF2IsSdJNjMBpc1kCXKz8ANH8MUpVxAc96xBchMPxYd25sYgYwroS+hccd?=
 =?us-ascii?Q?ZuKXr78H5k79KPAu3e9nfTszhCH10RkNN1HQGhnYzWsdBb3pcANZ/7omV27e?=
 =?us-ascii?Q?nVxGJS/VJAn8OW8IU2uVpqSKK+98f7e7iFFo18SlGKKUcE3sAcuPzT/c9ngD?=
 =?us-ascii?Q?PPYJJH/BLWt8KCbtMPhieNWGU+0gw5YbTr4byCPpSlVVFidQNyaqyP3AFAgA?=
 =?us-ascii?Q?AqjU3Nfowpwh302QLesbliowufZEmMq0q2hJ7QV55zjAMiqNebCup1WQ2lhI?=
 =?us-ascii?Q?uSJiz1KDUQ1rmjg2hU68WGlkA6HHqeHESqrRremA2hlIpSrIE4Bif1MOakce?=
 =?us-ascii?Q?zFRnOJRrC2k7bTPbEfVZgzcvWnWFWuoB+jE8PlD/ZsArMRarufPPXl0dUpO6?=
 =?us-ascii?Q?R6sDfHVgNiREy2Q2/XTm6l9dN5LL1L8lPHQuxEUaNseeKOXtBfopoRhMPTKq?=
 =?us-ascii?Q?jEkqTJiO7tCC4+1iZhQngWTimHmGN4ivllROztFt8sEbx3Nmya/Wm9YproQL?=
 =?us-ascii?Q?abOO+3Mf/kR6F0OCg19aoDlq/f0Ai6VTBAzDq/06oWBMRFMS+/Gw5qkvBACo?=
 =?us-ascii?Q?kGr5XGZ9S0rUfm5qa/kp5ExrBmkvzXnhhVXoqSVhL0qqUAxGsbqCS1nckTZD?=
 =?us-ascii?Q?Q6X6THFNsQHkXLJ7qHUga20bM71i2ckn7JHwsH8AH36KsEbph315v+4uf43o?=
 =?us-ascii?Q?kG6rhh/qca5Ovg7hvmEun/j/fiaNmI35Il8ExFLgbGFt4+f9S5Ppdz/WSEK5?=
 =?us-ascii?Q?WFeohzhgqtVanoURoRnRXFYayMFP5FI/SkE9OFabNymSUk9S5ukw4eKH34N8?=
 =?us-ascii?Q?vjbS4BFkGLhaWKg0VT9nyW7FDPTemyoXbZGbK5w2qEOZhyLyR8iKXIv4XKH0?=
 =?us-ascii?Q?f3CVcoFD9LS+DDuYpWVAI+gJ4EN4/U0szSMa8fyFEWaqPtIQ+Uaz6GeH982P?=
 =?us-ascii?Q?WF7hzHc1BPB/G9/ldikvLmNEj5Sj8s1paV6KZIc3/771zaRHXdqqxhlUXfpM?=
 =?us-ascii?Q?XMJGrEG2EdghabLxQmubqD2lrAsVg39o2piVI+crv6EH+FMly8Ojs6t/cy1t?=
 =?us-ascii?Q?cHTqAnXKDYKA1A76lTelRg9JHBzuCvGvFuikXF74EuCRuwb1fVN1aBaQYFeN?=
 =?us-ascii?Q?C3KlM7JfspJRPEdqN0ZjtPFHhbEg1vPeRdnTQmxe/FP27/6QMqVo5Fq/8/x5?=
 =?us-ascii?Q?SZvMS5NkbWJoRixTtJxjmFFd3yR7zU7pHcS2rN+ryFOWXOlDEyBJox9wtgWl?=
 =?us-ascii?Q?DnxeRBl42o9Kw5SD5iyznyyeHvs4kyzkYl9NuFw5o2wU8U7I1E6WKO6Olybl?=
 =?us-ascii?Q?HTPOYtpTFLoYYfMsF0B9uoioJgHYER7ObPLw2HvRwn73yOZMkNlpNRVQPYBH?=
 =?us-ascii?Q?SO1u6QoCRg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d5be95-1c63-4883-b0f4-08da3a6bab9e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 14:18:54.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtR5juRljFT9AiNzqDLQeB/5lck8pUn3tH8/o9PQEoye+fqSXYEVdi/LSzbrRFoy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1132
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 05, 2022 at 03:07:25PM +0900, Tetsuo Handa wrote:
> Flushing system-wide workqueues is dangerous and will be forbidden.
> Replace system_wq with local isert_login_wq.
> 
> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Note: This patch is only compile tested.
> 
>  drivers/infiniband/ulp/isert/ib_isert.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
