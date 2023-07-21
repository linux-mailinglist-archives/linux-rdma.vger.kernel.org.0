Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00FF75D348
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 21:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjGUTI6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjGUTI5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 15:08:57 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBAC1BF4
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 12:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcSuvumIB1H11o977KdvPBEgvTO+27XdchEMPzcA2nYIJj4P2WUtJcRnDxx31X71re8gzcTm86rBgnbtIi28TAlEWOwyvi01H+0jetERSUQ9XYPmgP4q5nz1YMplY7WtbxI8RH4aRzDutskpBXh0ENk4lR0NdQhrwp0elUArjROJrlvvIFMTh+oMcdqql2gdUHhEWMBY89bueAJFw2v8IsIjDxfmT84YEbCCvyuzV5RSeXMoh0kasovy3jBL5v43QIoSjwgWVTn0a7UrSRHfTuq3Se0d0euLIozxbBL0JkRlqCx1SDW0KyKzhdlc8jjn8yfDC2vJQotLr9qQuNHp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ss+BoInh+xKeNgGfGKaXWyTa2gF6BZDuI7qRe8xYiE=;
 b=DLvJ+NXlg7dDrgCgnBZHBNu5tQCDDuuyBNI5lddNTRqwJks2CrILhigrRn5MI/IHUaVGracuZwO8RiRKPJZbTz5em40sjcmEvRx3S0+7jBVzfyzq8rMLWYUhqjxdCUlty4bset8fbQG1xvk6ruO61tRUPsDCfnuvuk1c+9oG8PJnCg6a13JKQkFYxVrAmvxflyq0+fnOU65OmCFdd4HDoh9NrE6KPHXgyT+9CJPN1iNlljHT5dygiQD8NF1FY+wrbamJ3nivAk/VGi4sySbq+TcWS2fLDG63Ue+G6pKsFbPu1Lghd/uvC1R6qHMMjEEab/jlO3xn87BYmAIXzaC/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ss+BoInh+xKeNgGfGKaXWyTa2gF6BZDuI7qRe8xYiE=;
 b=EwiE3Q60PR0VXOMoUaw0zMNAsPTOzE50JSc9OpRyWljs3bDTTVU5dVxmPBeAlJ5MxO+BFJ2sSCfL4BgMZ7sK1BOQI+adBiis2XT0YomsRAz2zyml5zhSmHO8c0NIzHHdEC6xVpT+9LtSCd69/too00ESfoZN/JnudluAl57/cEPOcQ1VA+gC1iiMwzfQGkKttM4DyYSn3voltNZda55D0QuRalkYaAr0vWQg9ws08kJnAPVy75brcVZ4LsIgTPiEg9fPE1sMEs9/CJd4Fnitgsx8XCFxGr3zqRTQTkH1+nuTqljQ8e0bFciJ3Kl+z00Fv2C+KkZXGOuNcjtHGQKyMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 19:08:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 19:08:53 +0000
Date:   Fri, 21 Jul 2023 16:08:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <cel@kernel.org>
Cc:     leon@kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Handle ARPHRD_NONE devices for siw
Message-ID: <ZLrXwqE7xXiEF37D@nvidia.com>
References: <168960662017.3007.17697555924773191374.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168960662017.3007.17697555924773191374.stgit@manet.1015granger.net>
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b7c830-aa0e-4059-8087-08db8a1decc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GY8a0OCtxCXdctBJ1J78rdLFckIku/opO1BPJdRy08B26hOXvc02Ka2GZQJJ910r/bTcz93mqMHBS+wEeNT25PoZtQtHg8//nodvsJelvBTiyupD55L52aTJSkvcz6qNgjWKAjUuxtTUXhb8DlvK31cNWvkxChbJvssDbCs37zzS1ZXr3JU9spE3ljLigvnk7QdtKnyYsngygRhREXZh66Wbtz879ywDEfV3NVtl5P/jeF9xIhrUhNNnF5L+XvvWkTGe0I5PK0q9yRNj9JkEdTNyNiXGYKpeLq9Bsz2NHtk+VGTEXDTnybmN6AVsaulMoVLLdQkoKPuiQfoz9Obe7KSc1TQqyi13XvxiLGny5xAfwXkhsGJ6iYmwCdBzvgpRHq7UUIlfHGHiZfVYD025Rbo29w2IjPezlT71JnQ1Mp2miBXKjKHPk9l4Skf+Dx5FMqdlthjpUtLkQyyp1mIGF8OIcGT168v3D5S1JsS4YfgNRQnEJ1WoArRQJlVTcKTksr+8oP15Z5TcYTPq2Mp5OdvvywcrzA24X5/16mf2qUnr0y7qcnMdTQBwXhX1Uqsw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(8676002)(5660300002)(6506007)(41300700001)(186003)(26005)(8936002)(86362001)(38100700002)(54906003)(83380400001)(6486002)(6512007)(66556008)(66476007)(6916009)(66946007)(316002)(4326008)(2906002)(478600001)(36756003)(4744005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KBoxZqWK6pPIl7z7ucbq3nMO5cHMPYkYEMZIxjq0OSeRLoWTba1WIBO0lMir?=
 =?us-ascii?Q?/k3WpfQWhyhKmQrIdAWPmuoCnCok/dV9Uuu0lsyG3b1/HoHMg13fKKzXFCrr?=
 =?us-ascii?Q?9pEbMeZc0phHWUjYsJt6sHhad9IJo74HHGXgmabmoyz0aeo/q/fj4nzUBbLf?=
 =?us-ascii?Q?4PjOVKs0ZgagbvdBrtCgbZlEu2aAGSpVutJYC6MLvf3psLk/xqngZ34sQP09?=
 =?us-ascii?Q?QzHtVOIZwwjGTuq+wNp1IQHZ7VdH6gKFwOqeoo/WnMlcW+WLeS3HHyiWRZ5Q?=
 =?us-ascii?Q?DjHK6pDjgDZyIJ7sWodVLkQnnNDh2N2pGqjmAzc9FJhATQv4tNzbiCY/Ujkh?=
 =?us-ascii?Q?kKLJkbYDVriZ9NUQ9QpHG89rL3JpBKwQzjtDBt8rDyIp3MCVHfCcc4SR2bOg?=
 =?us-ascii?Q?eowS/GKiaBuCVjPbGdTjSvskg7CjWjTAU5gF7ZDP30A2SkRcSHYWVT5kzor8?=
 =?us-ascii?Q?Abs93iejsis2VV8S71/eDsm18TsNQRChKC240xBqW9w+ToFzub93d4t9vsmG?=
 =?us-ascii?Q?LZS+op2feL/o4MhH4kS7EhKQsOBakFD9BYK90gvUW67lAnWwladEuJAYXSEp?=
 =?us-ascii?Q?tDX583+oAOuRwqhkWNk1wM0aP8zVcqfLT6adJQHzR1rjLBaD6vow0f7E1d8l?=
 =?us-ascii?Q?+c23MwHWy74bP0N0cQCyKYuVdl/8oHl5r8AAxh6qudfQk4B2T4odm6QTDeXm?=
 =?us-ascii?Q?LnjCK3vSRLG6j3vtfT7kxGCDhof91gY5/6MX6X9VbY+PoZL+r7lLC0zrb46W?=
 =?us-ascii?Q?JtKl+KstFpfLXpAqB9KhBpmE7It3/g0IAUd1BsktTcJMA+MxTY15913u7D+r?=
 =?us-ascii?Q?br7S/PTpUGp5RJuLQ5u83xE3zt/pq9hmu5LudpYMZY5Z58Ij7ywLTXXPtDiS?=
 =?us-ascii?Q?HwsaMPkcaq09YZFjfzfaGO6CuoMvgFQApyvGifEauxR8YGZkWwIm3uv6EowY?=
 =?us-ascii?Q?GVdbeGQyo7Jsx/eAHgy92QTVWBxioGlqc8ETMVxglOCDUzHTkvXb9/PGlbOi?=
 =?us-ascii?Q?6Pb9s6ZzjbVfnaN07PtYQ6OpBKX/7GCocss/PG640aiSvmcUAlSLG/dRAmIw?=
 =?us-ascii?Q?6f7nyAjx0oeOsVlR+NzTqEXAFWkbj7LTGl50vXi6oUlmPJV1ZX1+LmS2GaXA?=
 =?us-ascii?Q?UHzm4fAo9IKYJx+uVxZulwfro5pwJ1W6XbncGHEpeepleR4dq1XvhBAvXXRF?=
 =?us-ascii?Q?M/h5OMtIE4b1LddZm/TsHYFb5xXiMXTThggqVDtPLx7fOU/WNvtJ2MJXy7kR?=
 =?us-ascii?Q?kurXp74/OggsKXhQcS7lYIMoG4ZP2YrrSzHM63LXhO6RDPjsnnM5M1DFJklW?=
 =?us-ascii?Q?sMYrJqoGx6eydFr7sUjCuKoGLpsDVCtTKrhiPi8W6WGhPUuVJ9oQdH9U7atZ?=
 =?us-ascii?Q?ud4krfuOyxCjVQQI7naAbAnmpMavKBnmG6N6cDf24Bepf8ShWRPo0IWSEbZe?=
 =?us-ascii?Q?rKxp/o9kYtU045DalcPaVqkAwJm6fCQ43PzOYfYqcPfNwgtr7Tla0zQhnwwi?=
 =?us-ascii?Q?iGxZoSAjhChYb8AGo0MU4MFuhmYm98JIY3z+280T89id/nJsYjKqVmzU8T4S?=
 =?us-ascii?Q?tvO1ytEJDhamgC5mm3+i+kc8huXeewYC4ZuSF0+w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b7c830-aa0e-4059-8087-08db8a1decc5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 19:08:53.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Daww/tCkcTikIC2ltlCs2BQM9yjRZGygRHXrAf+VbKNVM06CDZsxnSCaIMyPkVoA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 17, 2023 at 11:12:05AM -0400, Chuck Lever wrote:
> Here's a series that implements support for siw on tunnel devices,
> based on suggestions from Jason Gunthorpe and Tom Talpey.
> 
> 
> Changes since v5:
> - Refine comment in cma_validate_port()
> 
> Changes since v4:
> - Address review comments from Tom Talpey
> 
> Changes since v3:
> - Clean up RCU dereference in cma_validate_port()
> 
> Changes since v2:
> - Split into multiple patches
> - Pre-initialize gid_attr::ndev for iWARP devices
> 
> ---
> 
> Chuck Lever (4):
>       RDMA/siw: Fabricate a GID on tun and loopback devices
>       RDMA/core: Set gid_attr.ndev for iWARP devices
>       RDMA/cma: Deduplicate error flow in cma_validate_port()
>       RDMA/cma: Avoid GID lookups on iWARP devices

Applied to for-next, thanks

Jason
