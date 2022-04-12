Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3F4FE3C3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 16:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350480AbiDLOaY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiDLOaX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 10:30:23 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3025E759
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyO0AVKG8tpR6H6IySLohelNkjUBAwZml3fYpg6G6FvH2l4LF7J8koCkXFsIMKeWIhS/dT9hm7Jbfe1oTDDZS2pNJp5XO3rE8+Jc7Cd8s+2t4GxaAVNtf/U06aO9wuR27tzoI15IPVFR79eMBobPXJBRpLP9gMqjpi8XNlNGmVrLiSCEjqIRTvMxPit/dXtX7dbtHeLNVlbYNxb8WWRgfQKJQ6fCvLJHmKcgI+uq60V758UZc2dukC7ugeQJfoYaODiwlKHH5bt0DePpW8O11QBQ5LgL4KiZGTscjzMjaMoAVjtY3zQHMANAzhLDDf9ISlVBNt9Mr/zgEKUR+7tpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivu3AArFsrA8dIfHag3K0QRZ0Dy1ZYmLITs2QFig7Hk=;
 b=J3V+kDgK2h0GOJ24uqUGMQDBvPJJZO1MA2p/wO2Xdz+LPCbReNjat90iJwIMKL1WElLk7Af1p38j6gXfO3ISOofEy+q56svc/Ry3b5n3hHmYBBltEvocNzio2VTxTI3XjNjDX/w6ceNJGuFlKV/aZB5qy8R4lHU51bL8752VhC03gn5akFTPfiZm3OExqgomaYOUMj6/o58tIibotftbQIuDWsr+2bsRvxuVi9oiMPXiLupzz3DKULXV7+kcZiCRRpoOc2BVgOt+ngG2iAVWjqjGCqC0/S6+3IMwlKP3t6OvzpUaxIBHdSzNAIPgD3G+nOefbGOvpTh6BYiUdl32kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivu3AArFsrA8dIfHag3K0QRZ0Dy1ZYmLITs2QFig7Hk=;
 b=JTgR0yEex9XRsTkem8UIUcsMSBWylHwG7qOHPo+R3zq1kDEga/g0BiND+y6ql+wif5fp07W6Duh5nqoJCLPJwjaoBZarkEjAMNJSbgHzXbPhtB2LjEMzSiFpHneOZYCEwbjqxYoBebawf4Mz0W2hThCP+Oxzgy5ak9xwtef1SQMNslONOEPGgVcFaWO402veXhV2UaSEoRNyGeVBc2X+u1OBoy49GoW/gDVCT19dWg6GeRA9M5g85p/fh4rNbPLtZal08TmvC9nlpHBMSvrSbJwPSAGAVzfvFNGMAO8b69ozPkgt4DUTJwU88bJtgq6Ugdf0We2tHLBdUarSijXynA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 14:28:01 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38%8]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 14:28:01 +0000
Date:   Tue, 12 Apr 2022 11:27:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "Replace mr by rkey in responder
 resources"
Message-ID: <20220412142759.GA215668@nvidia.com>
References: <20220411030647.20011-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411030647.20011-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:207:3c::20) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5659924d-0c63-4da6-5af3-08da1c90a5f0
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5661:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5661A683DD74519912CD781AC2ED9@SJ0PR12MB5661.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TU0FqjD8aDx8dk1BR7lg1iY8dsc92gglO3IWrN0cLBiKeBE56HBM4kQ2jvTVwtaO9IAuKkK8LY2Em887lcsvlyAkRS7UxQXWWt7eD4HrDGmC/Ob5WWNc/dSVKN3IhPCt2lWM70QFNcT4UfgGVV2qoDO9ysGoIjFxrAcAHlnZzsZ90Xx/mccj2OH5sPV+T0mAALYmQppwcDA2mK5xzARJVXGSop6J7vpMqbDzRuUbiNOmtV7+yNgne8oltKuLsqTcCJtg4PdVqfuOhKKTxifScvLa5CzF/X47C+LTCHdFpScvVNYweEb2jv9Cn/3mA94TuHCxs6WwuwPi9P30sVadDTcVMR9JkcfcRXWRg+REaJKj6xnMMTVggDNPeoYvSIvFKTdq0ki8YbKdzXk1TKN3SCJTv7NOr9HSGmMQ4BVjc4mBu0tgtXR3/mEbb+iShLQ1L87gaoGtUEuiM2jDFUNU0pfxNG09dS+CdtkXTMUwcEZI9DkDkEYArTJ/PNd3FFGI0KJdzTrZKVV7Nve98H2BFBcoIWnmrYAbP0dh81vdmjzC7dz7ROdxnZ+R28SZJUDSohEWlD9Q5pDBQ8JQXYQOayqefZL/dyCc65UVo9jLbqB5tTj8inDGDhTQQr16zzN2JXPrS7GCbur39lpUeTiRNvOyJX3T5QZBzroU5KkyIzsErPy05ypXBLf3pQBisLHV/NTsGV6nCW7DPk7rFrHYAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(83380400001)(316002)(6486002)(33656002)(26005)(186003)(38100700002)(8936002)(508600001)(36756003)(5660300002)(1076003)(6512007)(66556008)(4744005)(66476007)(66946007)(2616005)(86362001)(2906002)(6506007)(8676002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?thiuNmQT5dlEi7DXhChi4tNeB7TLNV5U/d1bFMMlLBDLzoxNpA3unVGuAb77?=
 =?us-ascii?Q?6XV93T91pm7bFKLFz2X/JuFWVbfjRe5rOF1ISipv8/wN88hwTNmM4dTJN1y+?=
 =?us-ascii?Q?1a10+E4T+6wdM3Hol00FVkYvZtfp044Q5K1KnKsW7v829kUBvJkQNxm+a183?=
 =?us-ascii?Q?PvxwtbxWOJhHZcp89A7E0HgW8+P/MccLSFgQYaIdJm1wSNK1h+ujntSdsuSi?=
 =?us-ascii?Q?MkFq4gsrDvesWxnrfbHv32yn3qql4mjPXhL6OMUkzBdjOm/2SJ03EyVDHKNG?=
 =?us-ascii?Q?dB/khzL1zAiaFXlkKsz+xFDlSKFT6u0+080otSNnmWu+A4ZavNDv/kE8f55P?=
 =?us-ascii?Q?OZpZEb7HPHwN1kF0K8HFHzJ2gvtmO4cA/51gM8a8EpjVfCbaRl+zoEw2AVDK?=
 =?us-ascii?Q?fXMzb+25zvlhoXg6Msk2Q5XGN5wvYv3Su2GFhGrh9jtKzL3ag4mUlTgK9O4c?=
 =?us-ascii?Q?IXG+sfz8C0UiZukhjneRMtuUVHAM/qHhzsY6O44vDdoLgOibXHmr3q4GLCwq?=
 =?us-ascii?Q?VPUYDuwhcePdJBVEWc6a1LVxP5gRxRJ7LdgYBp/Z27XWxAZa0iXbBPTtfDNT?=
 =?us-ascii?Q?UJ+eerhGS6fRJRzAZIR/WMtQMRzSgFuHwCZZkvGXKHCa2CU76ofyffoTBfWP?=
 =?us-ascii?Q?6ThijDTm+vqqKx6J/EQs9H8XqQVbUvswOagL/rhBp0ylmqAiMTyYR2bFUdzt?=
 =?us-ascii?Q?tYjMEcJGzaH/sHSwSCp8q3e9NNoGWogDgcWSkFGOkaDy3KS4QGyPqsl8B8z+?=
 =?us-ascii?Q?yXj8z2f3W1RA719l0Ym5OD8xM8/kOw58wOMykW3qPSZw7Ikm4N0FaDGyCjGc?=
 =?us-ascii?Q?qIqusxeQYi6J9llPeQJbsqhrd1SieDJwfZuiucrT/ilr9TVrbKAFhBtbNQ64?=
 =?us-ascii?Q?oATparEP1tRW48bgtAOARwgXR8xr9w3ODRoPrLUxfnYltbv7pAf39nfazmJX?=
 =?us-ascii?Q?Pj1m9Jq5mSLebUc9Am/Nv2AqxeWOLg85PnghhaJIqal7UNrfEkYKP3anK4x2?=
 =?us-ascii?Q?1+8XROGXQTRkZRY6H9EPesdwzrgPw8uNuQHUGoruSSrqNq9PiNWcAhT8Ql7M?=
 =?us-ascii?Q?DVmyxMBzmyvWUdF9e+5pwMPxcn55KeYc8cQDHoY0WK1HZovIph4cZiVrYN6P?=
 =?us-ascii?Q?/320Q9o7HJNar/SmAPk1PCeqkfh4GzZQeMiwnDzYg8lk+DPeXWsVzqL6iR+c?=
 =?us-ascii?Q?lVULqNporTQ6D08M4cuDGpMtE9KFlYoYff24ToSCAM58EHOuVbucgcFPkFNc?=
 =?us-ascii?Q?dGrO1oJny/v2TlpVdMV9YnuA4z2Jati2nyKDyVMzTRJX20lDVOSqvDVkmJ9n?=
 =?us-ascii?Q?oxRD33Y3i7nGSdMLi9uRvZw4Q0lDZUfYla3e0IjATRXNZZ/KuWHPVdYr+jhB?=
 =?us-ascii?Q?GkcoBsx9eonk6gWLDOCBdbhkbSexU8yslAytowtZcq6jq50WAer3RtM2fBVJ?=
 =?us-ascii?Q?njnGuZm31h17rwJtKOKpDSR7Ns8uoYlRq6yidXWzS0aH1419sp8KocDHngb7?=
 =?us-ascii?Q?dkQkh2VTuN4mcxUpN0EWr62GI7PbU050wn8NuYBLUa8KLABmD3p0Vg3jlXhP?=
 =?us-ascii?Q?1hSijLGGc+aTPs9h3ttuci05KxFP4KfaMwwenNEN1GvaZeyX0vf6u2yfSAH5?=
 =?us-ascii?Q?LLqcZyv9pdVcNim05LTmrh4OoAnBno1lpcEcZC3YIQTUhfkOxGWguumPZ52B?=
 =?us-ascii?Q?0dlaA5AyLpoSWOxx0niVMpzfBDfl3TbWRq3z0V+PVutH+uiuutHjSOgPGhI/?=
 =?us-ascii?Q?rDx5kFVrBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5659924d-0c63-4da6-5af3-08da1c90a5f0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 14:28:01.3250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDmX0KK6UloKgVB0sX3/0Ke8jiSDU+ae2iHKWyDqBCXiS6AZH8YSydxXc5eHp5XP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 10, 2022 at 10:06:48PM -0500, Bob Pearson wrote:
> The referenced commit generates a reference counting error if
> the the rkey has the same index but the wrong key. In this
> case the reference taken by rxe_pool_get_index() is not dropped.
> 
> Drop the reference if the keys don't match in rxe_recheck_mr().
> Check that the mw and mr are still valid.
> 
> Fixes: 8a1a0be894da0 ("RDMA/rxe: Replace mr by rkey in responder resources")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Applied to for-rc, thanks

Jason
