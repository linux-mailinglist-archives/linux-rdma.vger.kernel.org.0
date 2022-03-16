Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6794DA6C8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 01:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352762AbiCPASy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 20:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346484AbiCPASx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 20:18:53 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2069.outbound.protection.outlook.com [40.107.100.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B14D636
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 17:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiiRAAyYyaTesH5Q3aE2eVMU0OLFQ2wRVwZUkoNxvu4HjShnFWDu4LcYzA87Pip6r3EmQRPYCdntHebmu2WSH/Y0NYcGu4km+blYQfvlwNNK0Gmwqu/u1UHZl1L4jGv2z9jwPj1ShoYmAyuhwAIwL4m1xBm/t6Fo9TmW6/7rE0s08TPZsVAgzUMvWI9V5B/nBbqAgMcC0EmfAEwPXkBQfTvljnGSCtdgUY9CP1gIL9oeu+wEyIQwVFvhN4h1/dQOd4vGh3A7CwmXYxYPP3wawylWphIXjZ+o4xEqC1XUgPCCrt2JhH+aHFpKUYfPAiTTO3irC85w06fhDVas4hcDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGVpewQycO9FhLP6MhaiKfWSNdg6KjvIYs/szdR7b7Y=;
 b=Vj1nTVTrsMV/kyUAxR6aGgXNLS4z6fymSwq+lRhXmOGnCbTLLdzjyODCsGOfiZ08CXoFlFOZlqsiMJyHEJiULk23rVuB5m+vwalscaCnxUH06ECVMh+X1YE6GeUnT8KGlQIByMCUKe/y2k0yXMcETrdTfDntDHP9lTfloJEp/ATvqRHcG04fgQ0MDpdFuHQGFZI3/2tJNgNzaSey22417DbaqdgDyB948zLbBMTTXREJgwtjMlpi4ZVToUlRhsUko5glXbrHrfh5j69d5OEk2tJToM94/ZXNl9I7aDdVvbgyOCERadRAS9AvXJblI8pX2oQV1sINy78/7LbM9IiMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGVpewQycO9FhLP6MhaiKfWSNdg6KjvIYs/szdR7b7Y=;
 b=G8OsBsPWUNMW4/yRF7ylQ6oCoFcRg8c1VLeMutYbH5KtrtD3UZxO6CCJF4lZ4Lje6wxPampI72vhgHxFzXn4nMimd81cytmjvgkB2BkvdrMwb4Q7OpA3+kIFxOwU84REUn4Kn3nE4+5KyqxIO01OuHl2VSzS6ne75/Hzl9pzhAlyEGjRmp230MZTSU2Cgsz/G018/rK5fvy8u+/pNzDdCgVYDnWHvhUe2DNyLsmmWUQAYIjuxnEhsshh8BWpd+DibcimN+q5NAEvMLn/7m8d6/pdiriqcW/vVtkkT0+sKGp78b0RnTUhawjizxvjwFizl315AwEtq5iCj0+detgU1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Wed, 16 Mar
 2022 00:17:38 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%9]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 00:17:38 +0000
Date:   Tue, 15 Mar 2022 21:17:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 11/13] RDMA/rxe: Add wait_for_completion to
 pool objects
Message-ID: <20220316001737.GW11336@nvidia.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220304000808.225811-12-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304000808.225811-12-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR01CA0046.prod.exchangelabs.com (2603:10b6:208:23f::15)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd3ae454-2910-42a8-8423-08da06e260f5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5772:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB57725F5B0F54D995D19C31A2C2119@DM4PR12MB5772.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhxR8/jAy60FyPHBxRrIMNiyomTNfr7hC2jwjTL6fcF+K4JLwbD+LctAT32rD551VsG/EqLUsbMvDWhbDsoEAhVNtrrsbxUjpRYi41Dko1/CGYBFMCav8lLHHXJgIvPaUw21p19km3R0qruqaRlhjfrpOPG3Mk2BDA2lPW57ES4y7W0G71S4MW1L8jwheivqM8tVKFof5ihShh+UxEDsfn3kM9uCRtrbh9p4c/rQ0qLatZsExwiQUcBFG8+hj0sUoblXh8pdI3S0bvqXwhgI23zP7eJeyy/DlemQOtmIaWLsfbYbVzf1z7wqfiVZ7c11X80VZjdK4dwsIYoP25YucJyeuNWIjg4rJD7xREHFLwS21b48wBDlhzlacCFbpOr6uk6ec1LVZg2zKFhaGNEPfr8L+mTxBSnOfUVskxl60OvSMO84UAqJIFyuwMZeBkkqmtY/UMWK8avWWxdemy1/CQu05w9+Vgl1UvW7aRxm9mFmj15Y5ZvzWWNgilRfxUtSTDpz7703zjdivU3m93jKws35IAUk9tZl0h6lf+Xk75EBEDMtRttJokWIJApNMNvlxwuQWiNP21xpMkQ/WRn7vl9liZdDi9jfG58r65BwUJ8eYsVXW/rxN4EWY1VdpZ4bYVVNMC7xoWMTQQWEw+7Wtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(83380400001)(8676002)(26005)(6916009)(4326008)(66946007)(66476007)(66556008)(36756003)(316002)(6486002)(6512007)(33656002)(2616005)(86362001)(5660300002)(8936002)(1076003)(38100700002)(2906002)(4744005)(6506007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AnpsRZdsN9GpxtOBAMcpZOJm+AUeVnnbVXOBWwI9+S9PwV0NzxgUxrjDyVhP?=
 =?us-ascii?Q?dwldVcJcYRfHb/t2JUfR/gZy+hXJX2gfdB9JbWJA1oQdU65Ymt0SVf7DzCDk?=
 =?us-ascii?Q?ukHY5Irwt+a7r0x7EwLTXYcGqtrZmDLjanyAIKXBrLIUX8ljlC1i6qxl6ER9?=
 =?us-ascii?Q?IOygJyZeLGJ2U82HgsUK4Awv18Ruasoq1ppuAgqT9nmAK5YKbobxyWhMQUl/?=
 =?us-ascii?Q?ddbzYlFD5nXQL6ff27DBjpkWzzALZoOPylxnIFIPzljkLT93Vco8S9nr06nA?=
 =?us-ascii?Q?9Da7/BHDnbKEr/WqvegPm8QKuJUyeDe6U/N8ljgf3IiMHaSQdR56Oku8dNMb?=
 =?us-ascii?Q?kWhi6/2n9TDZx/RlIjBtJ0Ry1LMmvJCdX5BlJfiiV/AdZjtm8k8rQ0mOfGuN?=
 =?us-ascii?Q?o51QAHEEuYEbeOjxZSCgqHV1bdQngbwXFHb/gHoVjXCLSwEwkOCjlzUsztLe?=
 =?us-ascii?Q?OyWvp1+1G6+hISc3tSeDvJ+Nb8Clehc69OfvS3Wv4999Fm9iA8U2/JkG84nN?=
 =?us-ascii?Q?nJl2oibEZpT3Tegu6bJdfzfV6ILzuEDEIj+cHvmwHpVYlsxloJRUyFNcOL3e?=
 =?us-ascii?Q?dRDk2i+XpH26rRCo8ODAF8Jwlr81qeUvzI1w9bsZqpY4eGBI06IZ2CI+KatO?=
 =?us-ascii?Q?kU5KIZDPjnctJ7dLJ3lnKsTBoY4/6xLoqF7mkL8RfBD4KM8nmz8Wc9BhWcxe?=
 =?us-ascii?Q?Bvk8PNKWDpV9e5HZmf2Yn0PBIUWEd72UjeKB7VgEJCP8vKiLCBR8+3mJuSsD?=
 =?us-ascii?Q?JMNadq3J5k/QYi/3L6ZHwjYDxqq57ezD+SOXxCDrqFF6+YZoXV0wB7zHIxPh?=
 =?us-ascii?Q?ebXRAsUg0AxfRR3a4V9fgTIYrLNzi3c8N9gzXQVVNuUY8KKtTn3pKKJ+NSNv?=
 =?us-ascii?Q?k4moERtluyNgCQPlJXmr+Wu8KzNOi+sxY5efPA2g1KDNt+6tQCpVI5DA2+w6?=
 =?us-ascii?Q?4sBlbETS3o22C36J615B9hIiPrUObw+D1GwMvzAYeawuZO790NDbG2J4BOSy?=
 =?us-ascii?Q?Gm7TvfxnFBxW2CNxY4Q5N2fySj6q1QPOzdl950UK8JHDnPT8v5CSJdMz20Da?=
 =?us-ascii?Q?k7whddx/bmEAywXB7a1hgVd9q0uLX+/iIfrKYy+fLazEhQ3xRsEWD6kR7f/v?=
 =?us-ascii?Q?UfeEcuhgd6dtlz+lgizFfoJdR3YGOR1CjcHyNtyNu2CW8juHiDTlZ2kpHf4m?=
 =?us-ascii?Q?u4H9xybfiJa1RPlf92VMUIfherxf10hCXfLKodeapn3UpeG3tN/gjxKNZL/n?=
 =?us-ascii?Q?3XFXCdgsbib6EHuOYuMhez1oJQZs6H5d2mP5l5lIO/epgz+ryKg+70cD3xFc?=
 =?us-ascii?Q?vi6RIW33fDNfVRuNefBKl0UG7p9T39Nwns3NHfOM9+sjcoX1ohpMnebIIppR?=
 =?us-ascii?Q?Xkt6DIUN+B34wcjGQls901Tto522TBI4UEYIBDca6R6WwRNti76Y3sK6q8Qe?=
 =?us-ascii?Q?vkyKdD235adOKlkOUiVFuHx79cbN3TvK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3ae454-2910-42a8-8423-08da06e260f5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 00:17:38.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBwoJsDGg7pE2KwD+DszMfZlBhMsfjLRy1OZW79yHlFTSHAYHVlqKItdMHF+5Sud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 03, 2022 at 06:08:07PM -0600, Bob Pearson wrote:
> Reference counting for object deletion can cause an object to
> wait for something else to happen before an object gets deleted.
> The destroy verbs can then return to rdma-core with the object still
> holding references. Adding wait_for_completion in this path
> prevents this.

Maybe call this rxe_pool_destroy() or something instead of wait

wait doesn't really convay to the reader tha the memory is free after
it returns

Jason
