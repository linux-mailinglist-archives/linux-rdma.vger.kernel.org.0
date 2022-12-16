Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D835564F104
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Dec 2022 19:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiLPSek (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 13:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLPSej (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 13:34:39 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323966F483
        for <linux-rdma@vger.kernel.org>; Fri, 16 Dec 2022 10:34:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ksp0BsmT4VkdpFLVnEA46/1fVuzuQsEDy85AJ64duT1BSte+707O/9qs9wOxNv4B3NzrBcdiSfd41Spi3jwi6mqN9vNahbBeZWYsXctgjYPkwMRRVjwNtakGViLsULmT3s+GvOf5TzAsRRBkCGFP1D2MEW/5TwtDIaZK9jOmEVubyGEB+DBd4kGtbmbGu+0cxAMWp2030+8YqWE6jDzpco2dsZJB67GzP20Pt2lNtVYX3197xtOg90cIuxXCeH4KnJFk2Nms2MmUhFSfA4CxOh+qnlodwGjlMrD9mn/f6yqw0jVtn6xvn5uf28h18I+FTzdiLjpjnGoWdJj6E4WYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY4mTx1ObBW1rGF6rukOLt2NidcdTK4Ei4cmXBNwxuw=;
 b=gHUsSeSDiU9PKQ2v1TqWw9Qv6/6Z/UnYLFwZWliHhkP0TvQa/HN744MV5vD7LiuH5MmxG6D9zI5ZvwV6jz14kHcCKY4SOSiPK1cwuSyTR8hfYnvh3pPTbr4cWkaczXXYwGT9DbP73M7l7apwCrwee1TuhlQLL/gX5qe/Jklax3620vNuq3U8YLQMKimVgRMXuJ9yoiU1dsWkPch+Uqzvf4d8dihUs132J5owMjB9yNIfIKhdY9PLOKiIP66EtcIkt7LV9ofjcD+kTbckf3FjczWLoEsVIHw67GPc5R10LqJ5/VsJkRYe6RBsESqY2WlaRG99lDWINz+mynrSdPcw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY4mTx1ObBW1rGF6rukOLt2NidcdTK4Ei4cmXBNwxuw=;
 b=McivgACffIqjUfxTSCAl00kRKvAZZ5W5GcNXxRbrLftwavJdK/0VEN8p4TvXh1p+4KdRivJcldTO1U9nTRMbfFGQIWEz8ipEzx96xM6ribNGdUvj+GvatD7XrvZr6w66cQqBxTuJlcgrVR2q4V7pPAZabDKT+p4VB9xrLIAnYB6H1ZlcTYvCjBkvhyxcIkYI6mPmCV5pH9aaEpTUqm6td0EIw33swf48ImgL2pEDVq7ytQPVaXBoOoUGb4yhvO1FxV0aT7/oin1sho1iTFj/N5S2Qi9z48VVI4mTB5H93S8Z4eeeqTgTDHRF5ngU5pa1LPYdK4f1VyYO1LlxyC2Xmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by SJ0PR12MB5408.namprd12.prod.outlook.com (2603:10b6:a03:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 18:34:34 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::463f:4cb7:f39a:c4da]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::463f:4cb7:f39a:c4da%9]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 18:34:34 +0000
Date:   Fri, 16 Dec 2022 14:34:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        David.Laight@aculab.com
Subject: Re: [PATCH] RDMA/siw: Fix missing permission check in user buffer
 registration
Message-ID: <Y5y6OaG4+6kPt9O5@nvidia.com>
References: <20221216183209.21183-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216183209.21183-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: MN2PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:208:d4::29) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|SJ0PR12MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f2d6f5-da3e-4a88-5f7f-08dadf942ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4oLdD75J/F0dcz0YlbK5evhWF5R1cg1QAOOJRZHymaOtSfpyhXn0DRFtS1ZzKAUcLq8AmdfyfimM3qO7n2/txDctlZ0qRWI09ykJtphfL20rdCCHMQab67KidPhW6ae3ExhlFH2LDfPHEYMYhgewts1nKNH4FhziuuLR4UZMCAl/4kBaEwx8qAuEvR2py6na+mr/24BSjisHhdeOP8zo410BmmW06Kswgh+6zddRRqNuBeUb4gzfz89e/y2kR+nC1Q9dWnkttpxBfZHRDeYJwWu7svzVCEyOPTq9/QCCLyRbLq01+5ZRzK5meqC5FGwYmbve46lwDv+3gigSQ8aUwVuFbzoi0sgVwu/0/CcLvEVyZIo0wdKo1c62xKxjrenKG5qLoPIA3IoMCX/vdTTFMYCU7NtkdVNMeAaeU2FmfUJ445VtcubYMYsYMKX6YzSwHRnjNl+zImPnAbs0PpYSccz7Ax8frK85IpOpIEnP1xnOuKfdmxrtvkkkK4e1K8h62ZeaPK3Pm+iNBGjvV19OQUrkyeov1TJ9vNwUUgbmEHzuiRFaCU9E4u0Sb1r4qVKT009/pvaQDdBFFpZk5SdXiL+vlo1bZOncbmmCK1iMHizEvOjiXpM9dMX4LREWy8hNXAl8KFVNKqQvhj/iT8TLNZcdGjKaWuS4jaU94iv4PmaF8TKzuPZ2yqqly+p0hcO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(66556008)(4326008)(8676002)(66946007)(4744005)(41300700001)(5660300002)(66476007)(8936002)(36756003)(6916009)(6486002)(478600001)(316002)(2906002)(86362001)(186003)(6506007)(26005)(6512007)(2616005)(38100700002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UXOY9L9ruL6d5qxBtDUdE2RMoH1NiBjgjvqjgGATN1ZbNUr96pNE+nv7wuPY?=
 =?us-ascii?Q?7OJ5ygoty+EmijG7M/qPkkiE4GRSkFtTDTAkAyDVf8cA8Z9+3eOlZj5KwnYV?=
 =?us-ascii?Q?eW2sWr6Yab9Fn6yijMJ2NogUsNMiaqiSZ4tySAR+FhYdGyq8NaBlEMk9Z8Te?=
 =?us-ascii?Q?FV0oTA5rcoJJAgy9ONbq8Jvsdjr7zeFd57zdp6OB1al6hliqox02X2DdEg1Y?=
 =?us-ascii?Q?zR+H2Pi/Db0gR1Eb3fcBcG4S7sl3EeGSCVPB/AOTZTROMfObMyy690itHK/s?=
 =?us-ascii?Q?yWWi+AhuButXksSI3MyW35gQqqUFeO/ABlqB8fwc++rCAgOxWiCmKGKpvS7+?=
 =?us-ascii?Q?5D5sKWII40aUJkcB3t3yycN9CTE2R1YyLjZVPqWqWoHURp5OXfAeN2fwjAZA?=
 =?us-ascii?Q?mwcNGgSFfeoenMZbKdNCZV1w21JTlIFXf+QY73HwIG7jIak8VsI0du7dxR2C?=
 =?us-ascii?Q?wttCUcWfo3hLjCUfP0LLelA4z3+tCpuBvGza59HByUr2IRdSVoz4TKMfgSGy?=
 =?us-ascii?Q?VJfyEBChQp+5wI0E5Tc3j10FRG6kTosGDkGELhRHNsk8Aj12j02WoDd0R5PV?=
 =?us-ascii?Q?BlGCm64rY7qEQ0WTkH6u40PdmRc84/THW5SVkeX4q4kiQQEKDrLitxhtY9gA?=
 =?us-ascii?Q?Y/j21fbGLBABVv0hPxEuu1DMAPSY+ZetMI6P5bmKuzky6CE0y53XfNY+8Jnz?=
 =?us-ascii?Q?0HOsfFxqDLkpiTE7GLFGOLso9wzvbCgfGD8U/ibhVjSaG5MXhZFxo4FJJBw4?=
 =?us-ascii?Q?2AtdeW+rmOW9r1ufaJ3sXKYJeSuqw9sdg5RarXmV4PHhV86mqNorChlz34tl?=
 =?us-ascii?Q?S2XuzNrUFOlwiQov+QpwmUp5dwy+20PYaQKsa0y16XWegeD++HuXw34Sds6u?=
 =?us-ascii?Q?dg7PDC7wQ8+seFrUw8PVHPFDUwd32KSpzmvhYWNQ5DU49wb9prTKO/i6PdlK?=
 =?us-ascii?Q?BkhYVaA3PJDvVJn7QdlKIhJ43MqJi4UEFIuvJwoEgHEPyQepKq/9o2LdPmSS?=
 =?us-ascii?Q?ammcb0bk6kNREnG5NxVkuc2oahiQpGDRRIxW4Zjtj7Si+kprIppRwDnv9Vea?=
 =?us-ascii?Q?EXHMMA4R854fOiyhW4qeQ3oe/FdplVf4liqMu4ivpfo6car0XROuptA4YRHD?=
 =?us-ascii?Q?gE4ggq+sg4PhUT67wCBjIDinMqnA0qeK75aYYrXwJLFOyn6N8ESnoDMaHC2G?=
 =?us-ascii?Q?+7tF0GYrQpyMomELh6Drw03tcbBDom9FYSR35r4BmMx7RntaqjZSrhYwL+T0?=
 =?us-ascii?Q?Izh5tkl7KrtbG3lrEpfWLvcuIHAE3JLbZ2/qtg8uTjrobkiaXaOjigIEF5kA?=
 =?us-ascii?Q?OHCR72ypbZgZraWiMalQExZ6PKrSy9KOwQ+55I5KM9qc35ocUbbjppAbGax2?=
 =?us-ascii?Q?uXO65ZYhsSz+eWkBdd/stOwekenG030hdhEAvCqmBj9LfwCaCqe5wcG/vCqI?=
 =?us-ascii?Q?4By6yP/Vq8NlrHd7rJ5fvf7yRAvmNAwPjVRusfF2+SI70dkH9Yy5DkZUACNq?=
 =?us-ascii?Q?gtGSJU8LGB37JcM8S4AAlgOQpG0iMHrZ4+9uTOCc3uNW1+dgWcuRa06bsIr/?=
 =?us-ascii?Q?BalRQuqzgoGb7+z2JLwOpE0/R7ERK7UwPeliYke5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f2d6f5-da3e-4a88-5f7f-08dadf942ddf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 18:34:34.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9OEBeTruIMNCeLW9uNanIX9gJWzKbH1LLh7D1BiwxX36DnQn6UbrjzDokjFQvA4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 16, 2022 at 07:32:09PM +0100, Bernard Metzler wrote:
> User communication buffer registration lacks check of access
> rights for provided address range. Using pin_user_pages_fast()
> instead of pin_user_pages() during user page pinning implicitely
> introduces the necessary check. It furthermore tries to avoid
> grabbing the mmap_read_lock.

Huh? What access check?

Jason
