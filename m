Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6E3F9949
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 14:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhH0M7m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 08:59:42 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:18213
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S231271AbhH0M7m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Aug 2021 08:59:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1822uIuaR783LXGOqnq0kHnrdU/+vCECIfjzKm16jBk/eO4RybEaTFI1DlYKGZxiLqy8C9kP3pHDa4gA8oK/MS41F1QUMuyGhzShrdkBhDdhhDFx0SblTxEFyzJYEEsQXfsBuLhNq+oU1FpkwVWCmHXfL/Zugb6qzk1GdfEaRsuRGE6BuiCt2m8erD2CNuDBK7memEYIBi0PnlzBJ71DN8JItqL4zLpjEaU8VStc50PFhWUbkpIO3DnnLAU0iNIOIpdzCjcCkIeYTHo0MzA5Pv/KXlgZUep1P5KVzUdpiapHuSzl0PlWSKgOunZNsEOSF4uGPJRObPjtANDQm3a/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP6BFvb1+xYTIt5KCWdSQExraJoGo9G7YEyi3zNVR1U=;
 b=ixfELWtpJJkzlpfavMsfox+hI1xyaH9uFbEI/n15EISxSIx+0qStiJAx8kI4ZLBhRnJxmbJURJ2aTJmWwrrpq69x5M3GNXzAPgJAkDoLTmBIt7kv2oMczHFZkiQpfPxJdnHS56zpVOlakH2yv7XS1wu/jXHzrWCNzbwOcqxF43xFpyY2MVZ4ylvvBwQgfyaA1ptHypWhWxZn+RM94K2GjP8c2/k8Ka8JsaRimT+LIU4ITHkz6KSTzeguL0yZpg1fHiv0TA3NHzWxBdxuKlDOm02YTs+TDD5jYuhhmxP5UwCvFNDTInGtXrCMifft+ge3hQB3RIX/wIIDM0KcWaLXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP6BFvb1+xYTIt5KCWdSQExraJoGo9G7YEyi3zNVR1U=;
 b=U97Lqrto3jYByriTwE2367p/g5lCGvQ6eOo5jyzx7oCSxXBRtcPK2GW1tMSibIok6u14xALGZmCVFsZ7hqmvKXSyg07wYAYmLTI+5vzXZ5dotWsIj1K8ev1wf2XlxUgGhPvK94WbcvWIzdXmbJTY2IGyoK2ganFBe2WBzxRKtNOms2R2uvWlCUkmuU1f5KpwQ432tRCd4jlYNKe+ZWLzPFKKvAX/GQMFLMiy8n90MDBUDRama7MlH2KtZOH4RWpOyUrwZ9VosXkIPkq+iDB8qr3ZdAL90cy1FXZ3cjr//o6BVuW+gJGiYgM6RCrb0B0t+4uwToSlXUm397oqL7PWmg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Fri, 27 Aug 2021 12:58:51 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52%9]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 12:58:51 +0000
Date:   Fri, 27 Aug 2021 09:58:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 0/2] Let RDMA-core manage certain objects
Message-ID: <20210827125849.GA1354288@nvidia.com>
References: <20210729223010.31007-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729223010.31007-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::18) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 12:58:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mJbRZ-005gKL-Ql; Fri, 27 Aug 2021 09:58:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4a5a27d-64cd-419c-3a2f-08d9695a6ab7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5231:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5231E75448BBEA614DC4BD47C2C89@DM4PR12MB5231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbTvV676HDWIycZ1Bo9xD+jcW0f/SwzF9ygKATZuxER9rur9Ly1idNyxU0+got4rlTN9iDPFesr6Ra6W9y4qt/HKLCP7aFFuJLgjI1OmOXKrhziW+ZZ17s55i7quKMdvghhO2JVBm58i9nZX2wiJgTpBDXzIy7G/zjZZXXYJWWvbX+5TLBiymxN8xKn37pKcvpdvYutDdLA+DYzLS+tpRBxeiFCuA7ZRxITzIFVA1tpRo3rM3brE/D/iOGAzmoGz8PYvp3KfV1OSDApf9ocfGiIohnnBZrcxcvowQ5MDhG13Hx9sBMA3Z1yNgh2p4j/PL1tvmJj+HD5Mg3/h6OMrf9k7JpKWWhcrkywkdiK+jp8+0q5OVIm/hN7rIDMem4GkREomUu7CHymOtUGSZaSrU+RnughDCO2rDczfrx3ab2vISMBaV/Jc87teb4idhNYZBGLAz1uurN/oPiG7CYk9x4t0Mj3Xzda5QLbaL63ID0szDkXHgtLqFiD92NtvEH5FlUWl4UhyWbXOy2g9e/vgYGvp7KNLC71mDr2Jffv8g9kAUGQVsBh6ylIUWrdOQxPYjTCkWIJcKmIRkT0mgGvVLwVbIMv4VmBHSfouZAZt6PRXaDW6qQ+aBBlJr7fFIsye+kLJW6Z6AnQURqkzYsIDSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(6916009)(9786002)(9746002)(4744005)(426003)(38100700002)(86362001)(2906002)(66946007)(4326008)(36756003)(5660300002)(26005)(2616005)(508600001)(8936002)(8676002)(1076003)(33656002)(66476007)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AlZBT0IuLc+pgKHBnOeDhXAnRFo9cVSx9klpQA6lvMa4Hv40gAMNjrb9dTGh?=
 =?us-ascii?Q?uv+zNZmrmVbrWmTfdXUTKRCWFd1+dYEVOlc9kjKA3+YaKzrarYEYKx+OjoAT?=
 =?us-ascii?Q?GnfAu/GcKbIE9CaoIYfB0BmqtruQe/i1cU0POYCB+pMjIZsyX3mH55g+dhMX?=
 =?us-ascii?Q?BxK2p4QHEsJKFAZcWboDUfE0QcLtcRvPuJ0CKTnuvTZlvwwTpJqPc6hCQqf5?=
 =?us-ascii?Q?znBDadMq9hk++2ZgUSJt9wq5tfL+xTeQkl0TfGWXYCi7RUY0WMEW/BILp65D?=
 =?us-ascii?Q?PllHGccgCe79/LMgSpjVieasVefW4PRFs9Y6iuCXYPgINisgXA/0kZr2xVMG?=
 =?us-ascii?Q?aXslPelLzsNoL6buTZWV+w+0QHaIK4VQmL67Z8ONKoILTjz8xZW5VWBhg6au?=
 =?us-ascii?Q?0N1j3l9vjrwLYbHpciA+eEUYne1pGSu5THzuDnDshZMs7L1P+xM6+KXLr5ez?=
 =?us-ascii?Q?n2SuOj4WRE0pke/89TLArm7zPVmVza6F4yNX1+qhZ2LrlF+9safreusFMZVd?=
 =?us-ascii?Q?GRx5nyiY6mopjB4M54SnMZz5t3/OdP/q4oKbB5A2VACP8rZzZfdGQHWIkuL/?=
 =?us-ascii?Q?u8YaNCB6LHJuucnw1GNJpzIs2mzCSJ3R1fhh8CAo5vQp5gUHHEoUX44t7Db/?=
 =?us-ascii?Q?/o5pc5bwnlqNVsp7yyYGYC/zjH387F7F/53xQpMSY739JNe/+JOJpV5G9xAL?=
 =?us-ascii?Q?DHnxyPCk6iepURRoDBZQzzDYCxp7/jEwoNZnPmKyR22fpkMpv4aS3NXfrx51?=
 =?us-ascii?Q?qM4DoqLgQtBWj4+HLB7/Vtt47Wq1BaCs7I/B/9K1i8PX5/XXQLUuUypZZAeD?=
 =?us-ascii?Q?f+tpD6RdFT9SqPMqpkP8Sv9pl0QsNcC7UiizsTO05/DWEhENF6+BnwLlLAN5?=
 =?us-ascii?Q?NOOIeT295wVyf027X4SiQcE9PnkLRcaIubNsrm7euSsA/FW6vymUmr+mZfDq?=
 =?us-ascii?Q?HsGfCrA6wEg7rjkmBX+A1/EGTY6g8tnW3QynLXT2wvjyHUnzb2AEBkkAnzYl?=
 =?us-ascii?Q?CzBykD5tGokJBFmLPM1PocCYMK8vGWNZ/mTBiiDvUWyaKve9MsEsrAPxQvk8?=
 =?us-ascii?Q?vlRiM7nfLJTcJoMJhuD5wmD8FgnwKv0T8sjYDPBblS/ZZ8frXQ/x4lXGbXl0?=
 =?us-ascii?Q?doQGOY+4jVXiqJRYvdRYRhgr3t9kcUKQwy09gRh4nLVtMsnq6whhSFdDVCwJ?=
 =?us-ascii?Q?magbtw/LkVC5jSDjMdgQ66PK/OUTLUSLGcQTTspVg12TSSIQFeS1UzCVlVvd?=
 =?us-ascii?Q?anQNry1S2oLBRGdIkVP6vyZjObs21hBonB0UchqfdlHYIMZz7BABVeufzTdn?=
 =?us-ascii?Q?eP87NtXiRqfoGURRAg4TIovI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a5a27d-64cd-419c-3a2f-08d9695a6ab7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 12:58:51.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+TmzzZMoXhiTOu8iE1hoikhWAVgqBto1VwT5L/aV+9eV3TD8h3rcd4yLcaqUB1M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 05:30:09PM -0500, Bob Pearson wrote:
> The rxe driver duplicates work already done by rdma core. These patches
> simplify the rxe driver removing the duplicate effort. The first patch
> was already released. Version 2 adds a second patch.
> 
> These two patches should be applied after V2 "Three rxe bug fixes"
> patches and V3 "Replace AV by AH in UD sends" patches applied to
> the current for-next branch.
> 
> Bob Pearson (2):
>   RDMA/rxe: Let rdma-core manage PDs
>   RDMA/rxe: Let rdma-core manage CQs and SRQs

It seems OK, but please rebase and resend this once rxe is fixed and
5.15-rc1 comes out

Jason
