Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DF271F0E2
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 19:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjFARgo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 13:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFARgn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 13:36:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF97F2
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 10:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz0F+txv0oEQ8YFJnx5s+AOD17ANfvlPWzCPeRt25iP8buRz1yomJnj/fZwxx9gM2dxfR8Jas05KxlR3wfCut/lWK0tGEfLGjY3rkP3Xqy39bJ8jWHgawgSBhTHPYN/jh7DyCP4A1ToQZbdpJpD0AAIslyi/SjYAXCQHD0brbnpKyaTkCXQ6hcRgY/ih4BjEibRpUaz7cvMJjkRJlKfMG521mV+/FQihq34KwKCvlRtUkj0O9verY9c4AHFaiHCWOEOTN6eqnhJYZdBNDfJaJk9i8rIhr5oYqqEcLTJYD5iauZlIuNiaOHyzFerDMmAVLDP9PuXrXkYo3Icvvus1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8WcBdn9X6azuaEh1+7StIkgppGoqIJh2BFZtsTdcFs=;
 b=nAN5o68mAzOW4lStqjMMuGdZaPt6bEJDRKYqE2Bdf6/vM1h4ODQ3HcY3FOJoq1/bl3djSn5sM+ykz5BcHMNR8ofV/XT/8eD4Uz89bnV4Hz3W6HS3Fma1E2vtL4H5bATTALSy+lLPe7qu+jpFB/HcRXk4fka8lUMD6HE0SkUrrBtHNoMmLBmP3K8GXq3vgo7wbbxb+MeFa11Ry0WqHiAYTspk6oRaKzPDGcC/HKvQeMtfMXcB6R9Wvj/HTTshvkg4KTSI0iulFprAVPPmOZgECEKc9xdr9kE9q0/mhWRzmeBwtTK2JavYTBZMLU1z60mqxChnuZXNYJ170bR8++s7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8WcBdn9X6azuaEh1+7StIkgppGoqIJh2BFZtsTdcFs=;
 b=oX8rlkDIQkl98WhZLrsKpH2E+cBDpy+FxxymZRwk3b5fdB8iLW8VTa0Ie+N2yoHri1j5NuyJQWla35arZFI4cMYEr/66MhE3xIyEV9QTWeDdbwdfhxZ8zCeHcsfJpXj0xDP9coopTvaL7Nr5X7wMyTleA8JNFmT21IxxC+0+bENAeifIQGSZQAuPnXwyqdKia36WzQCQYkkCO/0+w+ico1d2gBSyg6sAXn0svG17iTXocIc7PeQU7XIJYHEYugFFbJqqj2zUtQJYBw1pe4yvvngkxde54NpDWpiC72Ih1LRoC8q+4Hc8aVHjE7OJFHuYnYSTEVlAMXCbz2HWJ52jDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 17:36:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 17:36:39 +0000
Date:   Thu, 1 Jun 2023 14:36:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Cc:     selvin.xavier@broadcom.com, leon@kernel.org, sagi@grimberg.me,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/3] IB/isert Bug fixes in ib_isert
Message-ID: <ZHjXJMDWif75kbJC@nvidia.com>
References: <20230601094220.64810-1-saravanan.vajravel@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601094220.64810-1-saravanan.vajravel@broadcom.com>
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 9960c0f3-c2b2-4e54-1dfa-08db62c6c19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7CpHVRzuiBRJIyocVlWfWKUWy1syYXgWuKKRDyAdmGxlbGT06+BlsLItOPmt8AWsj4FSMZdxqr2JVwIqr5/Ir2+fCkhcluq4sTK53vV9352H85sloWV81NnWsEQbO9fmeoNI/Tppk4IYFbdbEKKQULKCYerakSN/x7aYG18UBSQp9/1OUz4n1alzbJESaQcsrT7fZ2Ww/40QhFxhN+Vs3H45ZI4Fz1bHyaLxpB6OoltlRo3xJj/8IQGgmsOjW3iAyWUo9/Q61QEYWw2SuGusQ5DEsgWDFh7+X5A2nvUpmheOHOCzYnz2SycPPcBMlAGXDgoNlY2QZ8HP2RKe0FnG0bhfQ3lpUPzdHhYTu/IIGa8vV5b0h7nVwy1Wjy/FaSLMPKOnUr87gHOKeyGrF1DBQZFXrWTALR5MpxffOav1XQyU+3OUBFh46Ztk2NnlkLLE3/v7B+9HN0S5uvexut2k7RZI4cOMTv4qQfbBxWskgEp2+fR86pXxAvPQNwaomNRLd3X/DSV0lI9zBvCwEfiumthAWSsCZl4N91vma5IT5OeFJVM8z6yn2APZAzhUy/y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(4326008)(478600001)(66946007)(6916009)(66556008)(316002)(66476007)(6512007)(2616005)(26005)(6506007)(6666004)(4744005)(8676002)(41300700001)(2906002)(5660300002)(8936002)(186003)(83380400001)(38100700002)(36756003)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NGW4T+YsNpYo8yfmxGnHONddN0AoY/1zrm9jXeMK9dQME6X6gNBtHy2CT1Ms?=
 =?us-ascii?Q?7lzItaCgcljWEP2EKG/2fCGgntj4lTh6CWCo6FgVm31BTFVyi5otUyRrSlD1?=
 =?us-ascii?Q?IV2tgeLYWnODXID9sXxtnqD74zkCKkVgFk797/B4HihmX+sZxYPxzlo50qX+?=
 =?us-ascii?Q?tvG7hg9F3VKaARjMVKAXroDDAOqG5VnoWDxdL0tojKVdN77YJSjYoL1krWw9?=
 =?us-ascii?Q?OQEghch9cSe5XSvqhupq9Z+PcZWG8rzoCYiy8JnwOZzUHt8SJvTaLNsmtPEp?=
 =?us-ascii?Q?1qHWEgXgnBmmxbEEblwrBjqx1+WgX4V04lw3WrzruZ3/lCOONyWy8GXAm02J?=
 =?us-ascii?Q?RSn6D4SY/RUaxt9AmIXBuVf6U8lXUz7aagU/+CFq4pBwaoGj7caGLtrAXGcP?=
 =?us-ascii?Q?ESu+cP06IE29FoSBVT3Sy30ngmoMyiPLn2BuZXV6Jz/k2w87JrZJavXqrfPP?=
 =?us-ascii?Q?0UBrHnWvAiCoVkePEM2lwvSNmGHBsk2TQPevJFQRSQr2SaizS0qg0VMLBoMT?=
 =?us-ascii?Q?xrdNAlrO0DcBzAO4q1EYcMUlUOyEXEchqPESfiCRQYNz3Z8gGmk6rVas+k0E?=
 =?us-ascii?Q?BDtKnmmIkCYCoN8FHLPj0b+4mfeqbVupZF+eRSGLUUR7tmLu6UzHhp5HRlYY?=
 =?us-ascii?Q?/yYZH7sZPkoJ8zD/+ZI0jOwG0HO+JfPkC6D62Q7Hdr5f0KWK3RFdbghOeKah?=
 =?us-ascii?Q?3+91J51h1UE51/6JR22QFdrhNO6JtzH4G7eOunMP/Hgij0WcbmjfRkVZ45Sv?=
 =?us-ascii?Q?AARfBWbpOo00t67cMX0Lgdsxbs6XPQb+KL/ZDsZxsg44kdwQFuZpuwJ1U1iq?=
 =?us-ascii?Q?c7Wjy+8pOAG0IZjy1BvEOEZ4IBKkjTW4pK2haBGVAn6R77b3U03vrF4ovuv5?=
 =?us-ascii?Q?jdKlH/jnZkFMDxhCyjNWIQ4ANkp5+8gNSvMmz4BsClkn7KpCeDUlmREeoe/Y?=
 =?us-ascii?Q?yJMCBOptqY4t2gzCEQyt9xXzOO1Kwyb+r2kfom15H2VcWc/A8eFj9h3Zkp9E?=
 =?us-ascii?Q?copNBuNr1xIUKQLDiGsZAIZyuQ8oRd2uzKgT2p2ZvrltCZlEfirasZfusXS0?=
 =?us-ascii?Q?inAhZQFj47hPYV59mrSXppYI/gibGKCDN+LEUq11Y6dDBBluTHmauV+Uwl58?=
 =?us-ascii?Q?XpPh1Odtu3k0QtDS3K4E1NgFAUNtJsLBV+GTNi4KRu2aNHCy1tzJ99oGA++U?=
 =?us-ascii?Q?AZ/MRGMtIjB+4CofLCrrY9sJ2pjSu/EMr+ouuie7D2x3/0RrVNdYbIumt3KP?=
 =?us-ascii?Q?xocGfEYan1z2Ilxm84Uts+pM5FB2RqlLBTEVwI5QSWioD7yBjueJrzgA/Gzl?=
 =?us-ascii?Q?4KrugpjPHErvE3Lyl8BpDRXGXR0huQHPGLy4vuOQ0S9xbOKlOTQMUr+O0A7J?=
 =?us-ascii?Q?MJJ7z4xtN34lGTDrIPbdR6xw00qs/f3zixXuKH+JBI8BtRGyM1UqV3iCSYOz?=
 =?us-ascii?Q?eLhfROm2CChDWNOhv/JBWCCRdYd7d2keVVSA3PH5X4DOjDO3BmWXz8thjUIP?=
 =?us-ascii?Q?g3JfjH6cJAxmdeeEOJR+iDtBGrdocqSVHO85Cta4SD/LyDSxjrCbvhkgnJen?=
 =?us-ascii?Q?v669BgawMTfirSZ5NvVxBNPyN8ttc0Yk6Lq39tcz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9960c0f3-c2b2-4e54-1dfa-08db62c6c19a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:36:39.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwxA9WQZsxC7VBBhemw8Rp0EIKoC005DK4OzU1EWIA1cFdAwgKBoTsIcgXggs2t8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 01, 2023 at 02:42:17AM -0700, Saravanan Vajravel wrote:
> Bug fixes for generic issues in ib_isert, found during connect/release
> of bunch of isert connections
> 
> Saravanan Vajravel (3):
>   IB/isert: Fix dead lock in ib_isert
>   IB/isert: Fix possible list corruption in CMA handler
>   IB/isert: Fix incorrect release of isert connextion

These all need fixes lines

Jason

