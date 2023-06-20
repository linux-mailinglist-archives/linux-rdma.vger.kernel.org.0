Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DD9736F02
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjFTOpP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 10:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjFTOpF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 10:45:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A43172C
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 07:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rv8eOY1d3DjoccLsp5ACMlca3h2SKtNWJjl8FdjVAkt7IKper0ImHXBhSi245C7O1UTCMsNiiU7lZZYJxS+x7FKAFlDf3VB0a6qdtR2PPw8B7/pK6E8BOorCA3pxtnvZuThBfzZz7+w8fp6zxdQqbz3jdmJR9ahdabGU5VftVrK2jHR8mVS9If9AnOmu6nDT0FSyXBSyMWAfuyp9wkaWqOlgZr13vWvkSrtywTa/L8sM5gIAWgGriBeqboajDVsh86nTDkDQz/5OjBI7n6sNlnigJLSAkAzqjbgM+XFkO3ESQyozFMsuLCBjsISGkn8V4C/AlSpyT1HMCka8rGNPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPIHuhukxk7jAf5wQ9c1m0L0rdedPj80gQZng5A7XZk=;
 b=PeunXlLV8gJgHy9sJq9hOYvIeLipLiRFNgt+Jd4U1LxJyobgvcX8AlEymBrzOUEXoE6oZ6DQT/KfEEhGEQjms4fqRNK82nwz18OlJMC3VgLhqu1HsG2NMflJd/N2Q1MLb4QLYdSMwHLHQmj6DBzZu89AsiXp4z1WNxrMF+2i6VK8x3zee6cdNPzNNMMKTbIFPcV43n+Evq7Le7Qtl9bNSYve+4oRCqnytfXUDkhelnMQMdPTPANYhMGT/VjxUbD9Ro/+gw/B1M247Z1hz5bQovgzEEUl0l1BYGi7bV4Zw5o0/8KTeDASqo93gAe3c1l5m0VgIYZ3Xa3BtFSKRrTkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPIHuhukxk7jAf5wQ9c1m0L0rdedPj80gQZng5A7XZk=;
 b=STlr7vUMZN1vn+R0FItEOpfvsjTubppu9nFGeeB1vulD0lvBDype0oqqAm0rOnfObwVmuRgAI33XX4FRkYWE/UvAtoKLX6N1uBSD5LfOP/LCU0wN3fCxEnhI7IxvMt+IZNhV7pfpoJpq4X9MrKaslOC/ZNZCGMHh9ngPxbxSOU/LJqX137ZMlgvJDrBtD4FLoSyhuNaT1Pr2ZNvaFj+2xsAli7A7TGUORwZ7y8ijWIh2zTPHGY544ynHfdsfSVY0+HZUg4DGERMGmMCuEF4jNijIxeXJBGbH/0X03rI6FQeexlPySx0CHTxDQreibqIyrhrxONmXJxUyEa4AGPseNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 14:45:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 14:45:01 +0000
Date:   Tue, 20 Jun 2023 11:44:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 for-next] RDMA/rxe: Fixes mr access supported list
Message-ID: <ZJG7a85CSnrkBlIQ@nvidia.com>
References: <20230613171654.19334-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613171654.19334-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: YT2PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 21893cd1-546a-4c50-9a6d-08db719ced5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8OZs9wOhCEXbyVvLB++kJuzlhNkG4Q5inBT2fJEUpUSj1yGN0q24jy7dUEQ0wos5Clvs0MsB2Wf6v4OMSjM9F7I1Qq/56BhlH35BfFSvk2UmvhzdLnhZ+wcynhaRQ6ktq+h1Uyra0QJ83IjHykqQipgp9j7ggZEdTtu2Lru7h4yclqb5+8b7mZtSgvZ2X9ZfOljOWI/uWzoUMuVXQcJBEOmMgStv5CAJGsOtHNEvF0FNT85UexC4M9ihW2T3aqvrAPTNk9+gl3rjl7qY4BQ9qZia/KFwViPEzKiXUMztuezDWUPtgHiXEtQ0Ob/RhtT/69iLlSCpVmzKu1Jq+sBqU1vM9Zt3vHQMNRBu+b2k5rGwmeB+8J+QeJbymf9YiGm25OHMIyPSldfpAJSpaVprcoeWmTVd8s0P7UWmK8BA3C6tX54IZ3qrfOf+KhG4aS1VMZE5pd5RCTAt4bP/WXVPTzzcOFpWCLWoDfL+w8hCR+kjBFaYwv3LpZdnNRI7l0XvYEFFNbqGvRgJHHOJAYBY7oeqCtdNer+gHjUCA7Ns9YcuB+K6mP7nntkAtoqsoK95ni04PYPG1PeFruHQAiyQEAgDlKMk4hdPHuTIrul15Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(4326008)(478600001)(6506007)(6512007)(26005)(6486002)(186003)(966005)(36756003)(2906002)(8676002)(41300700001)(8936002)(66946007)(6916009)(66556008)(66476007)(316002)(5660300002)(83380400001)(38100700002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZmYHRjNb8WbLo2iNHHejLFiQZSiqIoaCG/K0AGb0oY0gCj1IgsdcCjrJ2K2l?=
 =?us-ascii?Q?2kM6u8gcb0DsaDytaY/o/PlIEgzD3X9f7lVAeZ1w5MmNtYC4zUZ5MSnXi5Bo?=
 =?us-ascii?Q?bgoZNGmUkw4J126iWZqtV98IVa0ZvyORs1uSwoCbetzK+7wsZCRdBbg2++fV?=
 =?us-ascii?Q?eh76AkEXDmvqb72QGIbMmcqXrEGIDzuqR9/3/9N9KEN7GpzdtvihfnwRRaDJ?=
 =?us-ascii?Q?e0nK2ncV3a2sh6HRv1STvjtETjeeVpsjF3T29Q/vDph90ZKfxD1Y62/Hhdcq?=
 =?us-ascii?Q?qZKgOL2sPiLWyDocpwEK9TAvhZ9H0JmCBwY34P+xiq5q6monfeSMAPfXNM2P?=
 =?us-ascii?Q?OaB5saNzBrkowjS7XUWHa/ob+3hWIFZDlR3Fi6VKqk9Tjl2HP6lZRGvoPDGP?=
 =?us-ascii?Q?RnRqnBlj8NOtkAk7T/v+8+9XuOInCd9kVJyXhzNjl7MDTHp9MdGkZsllYtUo?=
 =?us-ascii?Q?MuhNKhbTKDxC4NIYL7HV+NQ1qrAiv+lAiGEofNJsWU6p0dykTlyd+mxUHPIT?=
 =?us-ascii?Q?nTrRuxVRlbDWapiKOfsD027xggW8QhXhMhQU2/FWaKEfQYosQe7rRd8Ghn/O?=
 =?us-ascii?Q?aDYLcBcslf3cXiT2VJoE7O5vwruZ/kxhpCWlpRdhXYBYQK2C1mgfX3hRIZOh?=
 =?us-ascii?Q?OyW61qify34ZsfdTXVXR82sc5sVNM3KhP/TAcq3Mn5d8LU7BcbGRzZkpP7pI?=
 =?us-ascii?Q?D9pezj8sHSJSz4lB7Iw55y8EaF+ezE1AflByr77T8J1zmArw/E2WHN9FbXgx?=
 =?us-ascii?Q?r5N9pjnyotQClUBEFEUqSvl9eDnuOj88PPk4FPEHWbLpugiGOo51BJrSOhxD?=
 =?us-ascii?Q?3wKRbR6koOBpGnINI/gI0WYKHDgjRps1XVf31EENkVW5DXQIi4kHhVC5GEey?=
 =?us-ascii?Q?LjvsVblBUGeR144Tu2eCCACwF48VTc+Gb8yUgfX74glwYbdY63Gg3Lw7ezl6?=
 =?us-ascii?Q?Oa9Tga/39ftWMN2M8RytKQvP/tznwwiVEKdgeggeaXz9JXePiX2rQ53mtGlG?=
 =?us-ascii?Q?uOea+T1hUksYheWdTEM4lUoj7pT3nvgqYsWZg9AIh5ZZt191hyiPUWksNcaU?=
 =?us-ascii?Q?Mus/uO3hTo5JSCuyMqHDxd6OKgbgT7TkJwKWN+zE485HunnzSt+zqb7YuvoS?=
 =?us-ascii?Q?5M6ShNg9W56/bTzHJgPLFS4frem/NG2AeVxi4QCMW9wqmj24b3HLoomwqUCf?=
 =?us-ascii?Q?HLE/jAfxnhqKsz7juNqdQia7qVX6hmmGTHPJmReZ3Fl4zKsDSP9IevX3rF2I?=
 =?us-ascii?Q?sFEXKebkoIVCzAzX8/UZ08gTFN60+VDCRRUakpT4lZdqQoBLZ4EY9nkGWheE?=
 =?us-ascii?Q?7nG4KFfwd72pcntZB+XUbLHzkqtxc75njP3n2oh0h0yV1Mu1UHQCplS3FXWI?=
 =?us-ascii?Q?S1IbdsYQI6enl+L8U2V0gTc/3aq9z06UtegGJRfBS1wJd98RkXWPSs39fHll?=
 =?us-ascii?Q?rBBc3QlhId5cH+8ft3EKC89aKB+14ByOGuxmXYvT9JdNeJQSfx2UDkjsqYei?=
 =?us-ascii?Q?srM5t9HT0fVZVj1NTJCf6LkdnsQmaKVT1BNfhlbGAucjcIm2v7M+jOpJeRZ7?=
 =?us-ascii?Q?uy5eGQaiUm9sCk+UWrz5nbr3jcKIQ6ZkPxuPOgiw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21893cd1-546a-4c50-9a6d-08db719ced5a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:45:01.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1EC86MsMAXFnA67enUG42ZCSQl8vT2zP+T+tIJZyd6vh4Q5O8ku2t6GP+n1WPsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
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

On Tue, Jun 13, 2023 at 12:16:55PM -0500, Bob Pearson wrote:
> A recent patch incorrectly did not include IB_ACCESS_RELAXED_ORDERING
> in the list of supported access flags for the rxe driver. The driver
> actually does nothing related to relaxed ordering but it causes no
> problems to include it as supported but with no effect. This change
> caused ib_send_bw and friends to not run correctly.
> 
> The correct approach is for the driver to allow any of the optional
> access flags and otherwise ignore them. This patch adds
> IB_ACCESS_OPTIONAL to the list of rxe supported flags.
> 
> Link: https://lore.kernel.org/linux-rdma/ZIifmHzwnvn3YVbI@nvidia.com/raw
> Fixes: 02ed253770fb ("RDMA/rxe: Introduce rxe access supported flags")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2: Changed the target to for-next since the error is not currently in
>     for-rc. Replaced IB_ACCESS_RELAXED_ORDERING by IB_ACCESS_OPTIONAL
>     per a suggestion by Jason Gunthorpe.
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason
