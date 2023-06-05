Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD902722D11
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjFEQzS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 12:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjFEQzQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 12:55:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536B3D9
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 09:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwKM5MyLzYnC0MgbzQ7xuhPQcoi3Dczpp+FKssirqjl0oT2C1+pbIbvdQBJHJXnYRY74BlgDqNoyIMvjk0MpQ2X9MR7ZWcGjh87n+NNsKde7tSw8P21P+42Nceq6S2IWmmnl4Us4wtWJlnWZMSXQzbDOBEPBBUxCz3BUm85TeTi0Pq4qlwFSCuyEDvD2E5bW4pNP4TNxPJ8Bh7OBxhmWlW/ouNYTcmlS+WD2xvR4Dg6h8ZxSApp8VxMaLKAmUl2LnkFvgYr8ayG5OS63qj2LWHNA9N77ln8BZWmnwhpo3nZnIH6AJfj+Lmr5ekCMY+7YcIXBfz1ULNHZuRlUpAHR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wvnG6cPATIue7Y+L0BV8yDEAxUX2dvd6QR0s0FQp4s=;
 b=mtZv8MdRsGtL6G5+f41ToSPll3n9c6lk8BtcBlP3+cG24ZL8MTxaC2ArCUjgMsPUNINcDlFN8vI/DiDSprS4okH2BLUDhlDKONE/AAqRqPi7wQkeMH8PMm04iRxfGg90jHde0jZ0IzDhJX/ii8vXCCE+g9xSzYMqB0bMlInBM9976AfG9ccZHprcGZaoEdxmLkKhnyF4aTQ96gIG/+wB+GjaMg781mtYGsOv0Iv472jSrel3mqGjic1NHC/OcJQK+hmdq8YPjvVz/PBSPag/GvyJjpbYR3UGs3tqI9SYhmtoR45xCxmgLMF/P1v2z28PMnU5eBeP6OlutYVxeH/2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wvnG6cPATIue7Y+L0BV8yDEAxUX2dvd6QR0s0FQp4s=;
 b=f+pLh5eOj+6wei5eludBnl6uhFUf4FwyO0WnOllNB2JvzqZteQdJlAMlpB3AVOtUS3D23BHcO4X89OrM18oF+tdbsku8KuariuEoUTEP4rlSgNnL4yxISCffQhtsi4b9cFaT/gjjXZ8l2cgWnrNfBmNIm2wcm0tHTcR/IdlFdFcYiN/JjpnP0jLRLXeo5ERywk1LG+1neTHCYDeNVZrJ2Y6m/7LpkSUI5202Me5d2oZx4KW3/uQg7mZcoLp1unm7Dc2honuCX0zi/izg0m5I/Vwgl+HfJceSBxx27XfEfPE+Nd0wZrKVUVu1XbW7puW7YkDV/hoGBuG1ESYn3aneWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 16:55:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Mon, 5 Jun 2023
 16:55:12 +0000
Date:   Mon, 5 Jun 2023 13:55:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc 08/10] RDMA/uverbs: Restrict usage of privileged
 QKEYs
Message-ID: <ZH4TbQYnJx3Co31D@nvidia.com>
References: <cover.1685960567.git.leon@kernel.org>
 <c00c809ddafaaf87d6f6cb827978670989a511b3.1685960567.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c00c809ddafaaf87d6f6cb827978670989a511b3.1685960567.git.leon@kernel.org>
X-ClientProxiedBy: BYAPR08CA0068.namprd08.prod.outlook.com
 (2603:10b6:a03:117::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b77e85-77fb-4ee4-e8a8-08db65e5a0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZPTG/yI/g3+mDjXWxqN/1fZtiCzm1a5arz/4pvywu7aqc14On3yqzp6K6bRKyMJmVZfMkRfUlP3BhzBBkmxCwDGBaHJd32ll5hhAOTl52HGDMc+qsBmuE5+GLRA/EwpxvBegKaXRFVijV9ubV1SsNS1u4KghIj8QWVxSj8thHCS8dEjSgdwyNQrUQUqJqe8bJ2CJE1tSp4aHqelAtM7XjWr1Z9aTkWZV244dZtVNyZRJvRifafI9AxDyGdaOQp8WBmFne5+Ze1eoFlGrCXcaYrN6dnIMZifUDffCiYQGKYJVb/g+GHTu/5re3OVSVdLJmDdDotjL1qWZPpndep+grWJ9xr3anqZXprZ6YhdtEaDx3jaEfjrebxGEOhO9DEABIiNyUCiLsu5HDhYm9IFIHAVXkdSG/pGmv+qKV6BmnjzPU4siutI/ll2mblHH8CHFgaT1IyzSHCHvthKeRgh/9TTG33y9APuzc4aWNKBy2Xj/QcpLTvNkZRCZ366H4EVYBcnW6My5SfXUJwIwO55WbUym4aATG7MhyfWd+JoR6TNe0jp2gMeYInAS+/NESAV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(478600001)(8936002)(8676002)(66556008)(4326008)(66946007)(66476007)(6916009)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(6666004)(6486002)(26005)(6506007)(6512007)(86362001)(5660300002)(2906002)(4744005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mX+Yo0IXBh+sm9CcQayHma47Siq1UJBxwsW6Zhw2vMyO1he9J4nJu+/flkkp?=
 =?us-ascii?Q?bqZTXbfXL0780LswHIZoGhgebDEX+eoEb+vrcmLqljKjENLxPpNm1u57yvnu?=
 =?us-ascii?Q?ideSyPhOllTiZMEtBFESYiZXxecPbOje6V8q/UVaKT91Orbw0TRRwszOXJBM?=
 =?us-ascii?Q?h5Kvsa2r2bjfUHT7YtHD5Kq2X3nXPUWKi49CJTbxLMBKIp05MKhO3SjuxUxO?=
 =?us-ascii?Q?RsbkLWxtFgRU5/1IxEGoJ5x9DbsWXAXe39fyO4TYpYefR3zbrcN7QD/H55Hf?=
 =?us-ascii?Q?8kFSffH4KXvlpD88EBPwjqKKQRNe44B7JczWrFoqziRDuDX6Ql2w3DC5Xvpe?=
 =?us-ascii?Q?UfaigsjaPmlniVi+XJ4mzqhZ/FYfiq5Zo9JpHwcw4Za1TuSwTHiAi4zS6GYG?=
 =?us-ascii?Q?TVb1yFGy2JJ6IdvVzDs+CSIoJpa1BRLZyEJXiE6ypnDknQ1ridYna6XZHPuw?=
 =?us-ascii?Q?ynYBSoYsAAYFJTsvjAR6SNVE+USp3yGDqFXPUGXyxAZaIYYfk3AL1Hcnktn8?=
 =?us-ascii?Q?hQKmQNqLLD1LgiR63J0qG/naPsI/DHXk86GGB9RenUfJ0t82aKGavjZaPDyS?=
 =?us-ascii?Q?KgBW074E7s3G6PUFueoCN/FlS7SX1N445kavTFr2fBtPr5+uINXowQ5gzZ88?=
 =?us-ascii?Q?+IWiDRFyE/Ek2sUYRSJfJFALsrTpYRMiQK30RSOcgtzsfUw5XuUjopFSIDO/?=
 =?us-ascii?Q?R2E7F3DpmNsheowcwB9zlnatE2TMNu1UOni8AQv+gbX0rq/lXaKOPmefOErY?=
 =?us-ascii?Q?B7J1q81KZBZ5imZ246RoZOFKAvBQt2PiNxmp6q5U708XATNoPjRcf8nb9igb?=
 =?us-ascii?Q?oWnYb/6UDeb/bCzmEXrrC/C5eKvKt7oPLrlYQbD28NJppNSg6pmwWU7edFJH?=
 =?us-ascii?Q?ojrD57JFlSP2tRpHTAHi5ZDhZRWYXCDjQrQIfSXQHexduMcRqVJkQgZG52EU?=
 =?us-ascii?Q?YSGzN9PW14TkM1Sl93o8wUDva04uN9w40O/ksGDc8ktiAz9ZPbWCyYZbqAKo?=
 =?us-ascii?Q?jFSLrRt7OO/tUpDCL8TIkjfkeuEXTt151oaV5Eex4iVBwyy27oIooeMXtFjW?=
 =?us-ascii?Q?Gp6pvr1DOx+qraBnBx/DYg6gZDf/Ldx9NwvMjTuuwz5jh0AvvbcJp9h8n/aC?=
 =?us-ascii?Q?sgz25kOQ9NZQJNR9A0mYPtTHGbR0SxpNvPdigQ7+e0IAfYEbqWrxP28FOGEj?=
 =?us-ascii?Q?1qkC2CMtmfqEUQV7E62YSVIoyWokNUHzJxCUj2dNf+WDmL1DEzxK+I0Rsz6D?=
 =?us-ascii?Q?ISi5FJW+470H/r0R4EXPyDANnShUzEoRrnX09kQbOUkc8qmjDfBaKWX9pgr3?=
 =?us-ascii?Q?P9xbbET2K7Fe+d4cdpVqxnsSszdYJx2nTaI+mks2xkdN31eRP6WfmHNsvnIf?=
 =?us-ascii?Q?7W0zLDLtDj2hu873FdceIyPVrMa6/bpHOc5Gg0F85cI5S9LVSMPIxw9/2hmV?=
 =?us-ascii?Q?oWOe2IC2angiAdkI7wBc+Cv9XtlH3bJR1rwRqO6sijd4EUeeh0pKSbdgjg1G?=
 =?us-ascii?Q?RPllDnefrhvEIyfsU8+s8/fgMjt1QgUj3c65ijFB11b4gigrELT7qBqSAVFO?=
 =?us-ascii?Q?8Hx1/YldXhOFR+f/hBIvAMybF7E9x3qcrK4q31Ow?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b77e85-77fb-4ee4-e8a8-08db65e5a0a2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 16:55:12.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEO/YsNwlTo441AsmQ9+J9aZZD6zMUzRgh3aPiyePRp35fW2ejyfcBA2jJ4hjoGl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 05, 2023 at 01:33:24PM +0300, Leon Romanovsky wrote:
> From: Edward Srouji <edwards@nvidia.com>
> 
> According to the IB specification rel-1.6, section 3.5.3:
> "QKEYs with the most significant bit set are considered controlled
> QKEYs, and a HCA does not allow a consumer to arbitrarily specify a
> controlled QKEY."
> 
> Thus, block non-privileged users from setting such a QKEY.
> 
> Fixes: bc38a6abdd5a ("[PATCH] IB uverbs: core implementation")

cc: stable

Jason
