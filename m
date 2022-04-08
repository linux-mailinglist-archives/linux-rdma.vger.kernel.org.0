Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DFD4F9BE9
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiDHRoz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 13:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiDHRoz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 13:44:55 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248E72A715
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 10:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIcsAJPEJkGkAr6K6h/QY4ckwtWrjpkFw5l62+RRAsDsgab4BXhAEhthXZgPbQajPMZGEG5KZJJofTzPAE4n/t+DhT5f8iejSWZg7S68xamnBiYQgYVfl1p8nvXURVUT4A3KvHNU3ex2W9m1tRGQv8brZ9n2vS+cMw7xpyEWpIIFqp1aEaGwPGEauqdjaeocH+bcJEJTiLvOTYU5Sx8APGRJzS+rSbB9g4IAbVjXT+MmrQb6+7/vLT7zPE+VHL8UWWH4NcN/rBvOX5Nqyz77LdU9PBhHo67EyYPguSvzWiVs5HRF/MDbg10lfi524yfKBhL5j5KWKWXCQfIXaUR7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0VaG6K4QEq+LzSBRfGhpu8exDvTkdMCugg/aaIcFjc=;
 b=eJl2DDB/mHUadgQD4W8haW9endECfwcjdHebqOSTOsUxts9gy4yKT+5kASuoAZAXyeanm7HvUb6J+wGpQY5euwdSQ4tjnNshN0kHKWxKoMyNXBWMWmp88cxLwuxx+A7GQN9DWGxDjojFdANknq7K8ILv68NxRiibS3HPNj9/GFi/+MlyrBIyxvnbSaqh7rxlDumk8IGpN6eoZSLN5x5JH8lMmG9A62VK+wRQ0nKRAAVUmvbJPYKYxi4LmCXO4XxmMxQrxnGPqKk7vjE6q00YowV62kXmA3Mp4oU17RSMyjrlhJJOgv8WoEE5srp3fL7B2B32uYN9UhDE5X4EJ21gLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0VaG6K4QEq+LzSBRfGhpu8exDvTkdMCugg/aaIcFjc=;
 b=qMdHMxdRiF7p5Jx0QxZ371BQN7tuCRSyVf3dKLWF21PLbwDYnnNP5Wui6zbH2qkeQzlriphS+dGI+ngok+ur8C4EjX3yZhr7WFSuSXbb4oQ7gP90GO768RGYviHXCoumRkfFGZx8H6Pfr22mC+u0JAhR+2Cx0Esec+HSs6XuvbtSey42PkviaGooawCoJIYHoXJbVZl/NjdOjdVhfVy4Ve8p4e4CIumi0Wv/NryTuvr3CUCeUETaOygkpMk232ady/1hlJY4yiLq4MUtY3hh3KFDqE69F/t1bWc27oEISQiFSIUUk1W9gIYkvE+BCekXWgDEXuKHzLG0P3F4PQnghw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1289.namprd12.prod.outlook.com (2603:10b6:3:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:42:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 17:42:46 +0000
Date:   Fri, 8 Apr 2022 14:42:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Remove mc_grp_pool from struct rxe_dev
Message-ID: <20220408174245.GB3644319@nvidia.com>
References: <20220407184849.14359-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407184849.14359-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:208:120::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3e917bf-d586-40d7-1f20-08da19873131
X-MS-TrafficTypeDiagnostic: DM5PR12MB1289:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12898E3669EA1F40B7B8D0D5C2E99@DM5PR12MB1289.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4WQOIW0SHTQtIpKACZMnF53UnWZBflRlI87jjcRgTI5aEsVhnOQFPrwiGrht2S8ZmnOZNKDGKwbdonbkluhkc15FNYNdqctLeLXbp5u6T3v7l8X18rDUf6YScva7AlKQg9o+CqytWE3eiF6R0psbrv07thdKU1V7mBkd1ocdnN2YbfUeDJD3P/tc69WUuJEFCoNrcsV9+rtmehWq254asOlSwKBUCOWplNwBeKf8KW7FqT9IQlbiJz4S5tCm4O/kH7StD2K9K0kIiF975EbeajXGy52lTf38y5Df3qSskur7BTESqfDZccXspyfvKFAKGHlenodV3qotjzafrWwrrXj50HM6bLGi/WcFW9Oxx7HrCEGBXYJiPRm/AFbe5nqcambOwXUPp6u/cz9nT4JT+kBwS3WE16E0VA4/HYLDHmIrkitFcS2Sq/8YFG/wKHixL/7SmM8deTeCbUIEknBweREF6tNBcPK9dcvJIhG5x09yAOmErdYjKWkyNPkb1wh9R7bA2XKMn60nhTA89GlBE0qyL1Uc5NSomUwTpkeASWpOTYWdN9nBxIe+uxQxDNhUgLBB6093CkSg4jdLIDp/Bp7Wa3NkYQuiD/gKcfeGEr7g389BDjXQDSS6LC3qFWhPICYL53ZEznNM+02EoPm69g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(8936002)(83380400001)(4744005)(6486002)(508600001)(2906002)(86362001)(5660300002)(316002)(36756003)(66476007)(66556008)(8676002)(2616005)(66946007)(4326008)(6512007)(6916009)(26005)(186003)(6506007)(1076003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rYJ+IORnZvun7O2irAxgJDLUWa7qJw4jjaNSAh5B+JKLW77iY4If8kgPkYXG?=
 =?us-ascii?Q?DiewCE6cnIH+DUlgMn1tRiw+GbllqZST8we2/F73p+F/g45fWS9IvRq8sGmU?=
 =?us-ascii?Q?F8NzoOXumcu+9o7cR5tHujAskpeqPc1GCemfJ4VPOXQQB7j4Hq0GRdY3k/xK?=
 =?us-ascii?Q?ftHfgpRTppRNgqkRdmnsdxryn/iS8Q4wgQa2223DjxW4wsXK+WieDGkDxslQ?=
 =?us-ascii?Q?VnZpfNvK1khAhCsqLpxUGBKNe8LoPIakce7N2g8PfGM+n0aqyjlCOj6F/8L1?=
 =?us-ascii?Q?v+H8qxFIFwOII4bty3PX+hIDaWrCPY7TgflvyMQbEzBwoTSsdaM3GWgwZNRD?=
 =?us-ascii?Q?P/SnaoUXVZqlwmslxCftYDQDZZjwjdeBZZx+rf5h4z4LAKfad5/bP83/EtKS?=
 =?us-ascii?Q?TreWtM2am4sD4cgcbW810yJALupovBsog+Lhnm9tMpP4ctiP+aEttNfmrxfF?=
 =?us-ascii?Q?B09JMTOylJb6gfqisTTB4kPdbmtnuBwTdar+RZBnnhm5uj9FbIVemq/9w5tu?=
 =?us-ascii?Q?UFLlfna5+tU38AY+vj1LZ2BFTkT4NnobRM7lhmn/HKML7+SM1NR0ZHqEu0+K?=
 =?us-ascii?Q?hOTpvFKkLMGWGG/sxHPvSDrCYI46dNp4y/gbZWKAUHaJLEalqSjgYnWnp1yn?=
 =?us-ascii?Q?6OAbVTigz69SuEA7Ww44S1tD4EdQKAa+3ERKrUymW2QtRTXnRYOn3z5nVf/B?=
 =?us-ascii?Q?MlyvmMifMuvZ5f8qJdidZHoz4R9P77lDoL3YfVpe/HDRJtVAJUNVddt62bJ4?=
 =?us-ascii?Q?e5pl6A0CmKXZjBKNOFeiCwjTQ5DcIud9pFApHYLE1V2E5WwxleJkQChxIGsm?=
 =?us-ascii?Q?FSM2ercDHInideEGNu2nc2f2IvYeZBfgEfefVIxbx7hk6bbEvtbNAGXnBXXv?=
 =?us-ascii?Q?WnxNxiXicBUoRMCM/SWfBhJWQKv/RhVd7EhGYjnRBGIkymb6Q+PE+UicQNdt?=
 =?us-ascii?Q?y+t4I7dCtps6xmsfwX/p7gtjbC3ungWV2aI0GZFDH7pYYDbtMJxoef3wsBFM?=
 =?us-ascii?Q?vqUEvwhrmhZrWV9Z+Paa9GXyW8qHeLBIwqurC/pyxWCFDtMKiO90+pVgUnNB?=
 =?us-ascii?Q?A/o/oI+ZoTH7yPsYkuZuSmFky+WRs43ppkul3wf4TOfZIA3QWzSIp9RyE4wA?=
 =?us-ascii?Q?l0yVBKKgy91PfFhDCFKPwj6I++RYWbUcyasvDWa3oq3hbEcHfQ0MpdjDhTHN?=
 =?us-ascii?Q?59aUqpFXp92vYC1I+sAbo/2KsDQBC/cbmzaymuschLAHW3te3Qhjdd4+t9ya?=
 =?us-ascii?Q?dRLujEvB2AG+T+EtuYGaPlnVO67Vtzp6S9Rs0/GKGTMke3mEIhlDWQ1dbR24?=
 =?us-ascii?Q?Dn3PIfRHHHTIDGO3CJ9GaUpOmgMHsaYfLR/Xyr4vJWf5USX2BoLgHu7i7JGw?=
 =?us-ascii?Q?wXAQt73hEtwuFvWBzTFqiqF6hpWb9Vgd7GiiBT4yrDq5+QbTXRHJ+fChAeAR?=
 =?us-ascii?Q?HoLDa5DR4Nv60yfHqbzfJmS9XJPA1xiu7aX8va8WpM9FtCcZlF+WgjnZL4tQ?=
 =?us-ascii?Q?H3/qXlV/iQ3Z6yturtJBi46Hzdkpl+VkUDmkAbYDaVldDRRclUHsiso1Y0bV?=
 =?us-ascii?Q?kAiocK7Nxjw8w+/A0Vxi8GWFrsUio4ZYp/MwQxKVGi4Qt/dcFPkJ+WTCzf9E?=
 =?us-ascii?Q?PQ0IgiUqkAD7Jw2Yw5OczgsuIvwA1rv2rxXzYZ19tIVR3Iqv+pIa+K/RbgtR?=
 =?us-ascii?Q?FnIvF9G9phgBU7g2RV0H+ZuJUIJNiQrpnwf8w8yIuAzcFzg0oIwyrRJEUNlI?=
 =?us-ascii?Q?sKF1btQE+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e917bf-d586-40d7-1f20-08da19873131
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:42:46.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZHd/6X6GSXPTbeM+cm2ETOS+NHEGGniwgkhvhFF3GxdsdURMf9Zw08auLoEL9ER
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1289
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

On Thu, Apr 07, 2022 at 01:48:50PM -0500, Bob Pearson wrote:
> Remove struct rxe_dev mc_grp_pool field. This field is no longer used.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
