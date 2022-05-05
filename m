Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CEA51B416
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 02:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiEEAKV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 20:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiEEAKL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 20:10:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D245717D
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 17:03:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTMgQxohqYsEGVUG7eFPFqb8vS9lBBzQKgPEEVINXvpYLPcIxJk2Hk0iVVKXNxuG4muRGeeQVy6fs7b2cQAY/bDhtL/5y3V+4QwtlJSvaqzWRuNUqEiLuRND6JsZEbxaIAK/HLjO0PkveRR7BV1TEmPEAVyZWyA/JkC+hmtvyUt64Vs38WQwNnrxOD7uKc2iFf0PREjsDuozlRqydE4YISQChJ0DN96A8V+pIZ2gnD8GV/731LbqiGDCXRhUPpIBgedvPNyHrPrSwZLQeNBG5YyOe2PG9GUad3AK9nJee2bfbYPlr3r1TzJx8bnnFn6CXjdgUcgiCzmTmZvjs5Isbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLbWOBuqbOmkPxj5aqofU+AFDweQcIk5o2QO5OttuOU=;
 b=Xo1uxjO48jJfx4AQxdQkE8m0PsSeNtrG/RX8xgrv2gneTDewJEZT+6mpibxFGD3gyuNm2jRwXNdPVpSMESoluNjfrIL0/QXvB1AD6wjX9wiFu/ZJTv3yjVQkqAE8DMe4kYx1cEu2Z9Jgex3c4GBRwdLZp4/xhjyPiLWfrIEW448tTBUGsD4P4h7pfnykqnOoBVGNI0VpkRYk9vNO76t1Ey/Ft0njsmb6MFLSt7NRJp6fUBlRZIUB4dEcKGIyLKtwWX1BWaSxz8H+o+a7YniSqhmuuiMGM1a75p7ngvuLaiN+2e/3U6ReZcdz7Lu1nmHKW+K2QV3OdMY2ZjBTJ3WTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLbWOBuqbOmkPxj5aqofU+AFDweQcIk5o2QO5OttuOU=;
 b=N0NWjjYslCgfaU22K5WKi0qbQryvD2gWvxopvK3CGJ2MdHgqWXjLE5+VKNySlZqyQ34nRgLBEWCNZaqwUPLpxgA48EZqaITOtuLWJ7twWOxjBTXDhrdqgQ3NQqomKvl6Ja9CbgtdJPptuUy4NWmvkX406XDZ9xwH1mTIhaoZ4Er+RXQQPirBdrbg+yZuR8NM3++OuYUcBrVy1rtYGWbZRzkKMKDHZcEiyYO1kzw5mk//y2V6KZwgyGyaKKhvPJI49NICMK2QXf3oU8eaXL/cuadaGexJRe+D9AyrmPlxqdMRJywsULWLlqc+VqvRg8TIuPgGZQWHxApzhi+S25/6Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN7PR12MB2833.namprd12.prod.outlook.com (2603:10b6:408:27::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Thu, 5 May
 2022 00:03:34 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::a090:8b53:715c:a961]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::a090:8b53:715c:a961%5]) with mapi id 15.20.5206.026; Thu, 5 May 2022
 00:03:34 +0000
Date:   Wed, 4 May 2022 21:03:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     leon@kernel.org, BMT@zurich.ibm.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Fix a condition race issue in MPA request
 processing
Message-ID: <20220505000333.GA201934@nvidia.com>
References: <d528d83466c44687f3872eadcb8c184528b2e2d4.1650526554.git.chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d528d83466c44687f3872eadcb8c184528b2e2d4.1650526554.git.chengyou@linux.alibaba.com>
X-ClientProxiedBy: MN2PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:208:d4::47) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dac40719-3dda-43f9-9136-08da2e2ab2a8
X-MS-TrafficTypeDiagnostic: BN7PR12MB2833:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB28336ADF20BDE8B67A799B0BC2C29@BN7PR12MB2833.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRR8C0jRbrghYV+vai8S6b9D/brez7iKE4wVpGjr7/JETg32JpPpVNrN/0iWLL1Jvz08yp2fQmyDHJQ/hWoP1bfzkFjEwspKOzJlMoLlsTQAiWPpbgV7J8yjE41RY302mycTeMgQzy5hxDCqJhRLDEGJVFI/dSyaWaVU+n1wP9v/ofhwxVrVHcyouztCG6bw6q1nOdM4NzUGlhCj2UVfzVvqIsbAOofNkKfFQAP7eBJSDOVr42hGFwCzi8JMG/2s+DzpHFvNE6y+7cylvuh736DQg+cDKWgozKLGMZd+Ldmj9ihpotYoL+ErGT0kGFlLZvcaaex3v1n7BUJe/2qmUSB2+kvVqlpluQq8/3O313oxy6W+zGYniF08pvQhTWj0/1zLksnAqdedUd7Sthw3KFdK1F/LoO6Lu2GsPSSImdYxUdLym9C0xsdpJUoJF/ryVmJAMrV/tIV6nACQ+8TLDSW4wNsWPdzsspJBWF/+PL/15dqRttO7u5lJpGtpFQ1nzQBkTX5sTVLlVYeVdeABIFmBc0jUdMjiuU6GNt7J9+xSFUEPX9NF4ntj1coWZ5RL0cwGfvamCvlVWJoszSiC9/BqDhyt9HyR4/wEasnyLfRdJ2oB7cSe7IvC8ChFBICIJ3XWPkTzOfxfW6IMZwmpcWm25DVnqBdl4InQ+/SgL0Fcdu82yGQVVxjqu8PWsJg0OB0jcxqVv5zemv5zCQJDLhv4VvkLAofOFmQ2zcEJl9VKrUawHcffLVe9CyG5Sqab7Aob7ct+F0/WzYE4jqRG8x5hEk8dpgkwVcN3xlQLAuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6916009)(6506007)(2616005)(8676002)(26005)(6512007)(1076003)(508600001)(83380400001)(4744005)(4326008)(316002)(66946007)(66476007)(8936002)(66556008)(5660300002)(36756003)(6486002)(86362001)(2906002)(966005)(33656002)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2W29vQiL5GEcwtdwvXbfyFI5YcJ8SlXZAWO2WW0ngHWeWj5s7LmZtVkQCLVx?=
 =?us-ascii?Q?wgWk4xvCAj7sUR9wBU2lre8zjmouW/AJOrC6xXUAydhUqsyAhH58YSZEG3xE?=
 =?us-ascii?Q?Q0O8RPTQoFjNlDowbQYZ0vQi6Jas4KNVKi3BGuzDw3UFdHqFAD0Zbi4QRrsn?=
 =?us-ascii?Q?Gki5uQFB2VkC2EDOsUd66IDhV5NMEcowO7rbDWdZXB3Vnf2yfFxZBtqdbZmd?=
 =?us-ascii?Q?5l1cDebXTf+nH1RwxceAtKe5l+CzyBD54bOSbtBK/c5qRL5uH0hEU5XHZMTL?=
 =?us-ascii?Q?nXJeyrUCDzMZZdwbyBtE0QiIM403p0+mVHUpaNTAg7wQHdeFyKKJMFtGv1Oy?=
 =?us-ascii?Q?00RJoKBbnPlJ+1zmi5LKvYPHTgEkmHIPThG8hWTCbwQ3tdRAygKi4cem68Kv?=
 =?us-ascii?Q?/6uhulufDeWoz4IC4kDq3kBEzauqY+u2UHf8ruskSoAQeVCENc0nidAL2uu0?=
 =?us-ascii?Q?9uGK6RZBhqeR7awymRYEFuKj0s66+GSFVN/ZcmfRDRm+edhOJmYPbQdnup1n?=
 =?us-ascii?Q?sxrNec5zE7qu/nq6FnZSkNz7wzMdu6LxHoWy1AdbeMbokDyKpmCY29VIafpZ?=
 =?us-ascii?Q?LC0YbIB1J2oGH6RM9h3OSq/jq/SpbHpq/YfgXvhUixz82ldAJCXmJA0HBz55?=
 =?us-ascii?Q?PTYkUt0fJKprqRUjFgv9iXSZo5ZFnRF3PpdMaGNvd4XCP/hGRP8tDKz3EWFv?=
 =?us-ascii?Q?bMqRMfla7ncwZFffhpYMwrFsqf+k01vucg0/WZDEu0bHeif1ftzXyayAEUtu?=
 =?us-ascii?Q?H8T3ak23eYgn4/11TbHnXDaPT9zbBFrkDdgD8qAxVt6nnCUJm6lNSePl1HBd?=
 =?us-ascii?Q?X/5BqcP5xWLFDsaovoD0Rn4iQ9fzO+7E2L+79jGE7xJxgw/oATN9MLAnEh/X?=
 =?us-ascii?Q?0b4u//t/fWYx8B+m4pIjRokBO33DwLux4FOlW7E1qFz/Vm02EBkGHiF+uios?=
 =?us-ascii?Q?C3sgQ5v+F1iPzRDYgeNM7vm0+foXpmD/APidus4kRjRt08trE5vt5mRUHqt5?=
 =?us-ascii?Q?n/flLSODn3R7ccXfZ7XuCFkeYvJNuQVXCIaL37FqxOD+37eN1brcKDfjrQal?=
 =?us-ascii?Q?sKGjmMEcotnR0dN+ULhq/daT+nTbJAqj69BP/dTun/iorM8+XekpKsY2nkvH?=
 =?us-ascii?Q?Co1hDgSPTkasNC31zJakOpAwpeMuGLvTW75E/aUDCokPKx6VakdTt/Tk6KAK?=
 =?us-ascii?Q?VkmJU7sn0WJFrD31sxmozDoJIughRXiQRmhSCk8CeOJv21QH8i1ixjOzcWpK?=
 =?us-ascii?Q?M/JJVjj9dlqcJPsqdXQgvDCQRE6Y9RCWQW/CP+U/FfPF5wkNgwtri/z/mglB?=
 =?us-ascii?Q?diVFLCtQJcQkpaXCJq9Y1/R8BaOgzdpPJ0WoM0LK3ZyMZJ61czTOywXBiB3R?=
 =?us-ascii?Q?vZNL76C/6GrvvUgsz8A4pE4IwnNvlpcF2MEBjIdrvqTCpx5Jsnu2i0zX+u2S?=
 =?us-ascii?Q?YcdBNTTS8sB8x+G1puLOuE7Hb+KPCC/wKm6GzLLLriwa++Fqy1AxPngntKIE?=
 =?us-ascii?Q?FMPXutu0nL1Ty3HLkkk6g/bcVqLj/R4vrJyfEAZx/2xvm+MtHPxhhdLqCQyT?=
 =?us-ascii?Q?sEHkDJ2uTTtwsRIfyQBXwnblViTq14vdaSxoLiXzZRUcD7lxExAJKYN4rMae?=
 =?us-ascii?Q?ulSSw5hiZVR5up9JtKFLABJrq8NXsoH+ziJ9aNOAAgsVUNoDIs7L316LqMqL?=
 =?us-ascii?Q?XZHwRON8ku8N+HNkmDpI+sC8eIar1oZ3UE33n9Ebr7bUapGp/Z9yMJDO7705?=
 =?us-ascii?Q?HUk0VMQZgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac40719-3dda-43f9-9136-08da2e2ab2a8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 00:03:34.8805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6hdVsbPmqChCPVLyS0FIJhqbYtfQl8tlOGDKEnTHzW3KnNvdrYmsNIStBUGWu+9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2833
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 24, 2022 at 04:01:03PM +0800, Cheng Xu wrote:
> The calling of siw_cm_upcall and detaching new_cep with its
> listen_cep should be atomistic semantics. Otherwise siw_reject
> may be called in a temporary state, e,g, siw_cm_upcall is called
> but the new_cep->listen_cep has not being cleared.
> 
> This will generate a WARN in dmesg, which reported in:
> https://lore.kernel.org/all/Yliu2ROIh0nLk5l0@bombadil.infradead.org/
> 
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason
