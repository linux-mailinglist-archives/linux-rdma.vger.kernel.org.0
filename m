Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD2485CC0
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 01:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245683AbiAFACC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 19:02:02 -0500
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:23873
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239653AbiAFAB5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 19:01:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pj2eo/Kxe7J6yyPSnKeWwqIdnBht0/bAAK305wKxTyRbwxyPQUMNDmDNfvm7iubFnJacvLHca72J+5Y9AGuM99/q2darKgmHvAzHxv429NjC3SRoHaE+UadNbu35JYxp3qOcU5upZC77K1Si6dRUCjdfvs4NOIf7PLe9/jrPLFcnGEvyKUTqlMiPwy0URmTKBEElP59ELaQJsJMQrT6eukSpCo218H+OSk1DvJ5Y2FSLpJGJsV4Jx2QjjfnwIU7BRRR+4cjw2C3WG0B4jwvoYo2hxP41MRW9vy4BgPxyBuKXc7HR6y/J0Pw4s7hfciiDSF03rUMlo0xBGDfTgmkQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFmB4QlN7Jhq1Q4vu6i+/ygb62kXfRMTDg1fDCOzMGQ=;
 b=jPE4XhOT2D26c4FrGCgmJmO3fN9jaWuneSKTTpjdptJwL4rvMwHKTZtqvb0M24x447/+N0aCfLWFlpGijKjo80sTmlHPJBoR/rMgoeTIKJ5ewPgKTuZA5iSBevsiE19RWajOHuWdMW3YeKvorQOy33b8caeQBAX6DKF/pXiuoiNKA3ATMc6VveU4iYX4MJilc8o0BcrVZNXQJVZ6BgqPKlPp2LGR0Vz04cCK9F5wuyuGkuvDC4wjsxgI7Q7dlqdgFvZ5iALPoGBuATJg+uX2jMjYWZtHLQ213kP1ed1W/K5sM7VGEfNUwC8aaf/JAzF9eY6FgGDB1ED1VPdBvZYNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFmB4QlN7Jhq1Q4vu6i+/ygb62kXfRMTDg1fDCOzMGQ=;
 b=OIFFU6Kw828M+Jr1adQ5ekOqmbO5HhewXrF9GLEqCCTpI3ZNWZ6uZNIVOvB/j/XV/LtX5/VonHFrwoZA6hFWDK8HDpuZ9FLmGo7Bb5qnfT69C8pug1CWGQ1a6auC4V+r12EX2mCj1jDG1IK2l/S/1AGPf1wfZ63gx8sybnkp1MZ5wtLRDZ6KLEZ+6BFhHs8BJj2W8bl2Gsi4IVUZkCkJ/jwYu5HXcOtM844BhsMSWsPvGLOcaHitKxL5nZUgL1bZvt4Shp3xREGCSx8TctxgLV5SXN7hAy+hNXGoRxYmAlwmZmGl4A2CzcQkIqT0iWx6ujzBeOkRXdE1qz+bF9KVmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 00:01:55 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 00:01:55 +0000
Date:   Wed, 5 Jan 2022 20:01:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Tom Talpey <tom@talpey.com>,
        "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <20220106000153.GW2328285@nvidia.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
 <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
 <61CEA398.7090703@fujitsu.com>
 <61D4131D.5070700@fujitsu.com>
 <8c772721-2023-c9e4-ff28-151411253a7c@talpey.com>
 <61D4EDB6.7040504@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61D4EDB6.7040504@fujitsu.com>
X-ClientProxiedBy: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d84558fa-5dd7-43e1-d80d-08d9d0a7c04b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5176366551CFB428C20AC84AC24C9@BL1PR12MB5176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWIomMBdawJrsHIQzbUVq8a4koHJ7B9UszQxoNfBHAm8GKYmqssI999SgWg0DMAFhVudIpIEX4UjnytFcRRMwNkYCnFhxvbhPymzKxb1/ueJe/g/1AUOaZoVT1K96+f3irVt6El5uUVwhq7wnBR4cL4J04AKyUXHmsCiOzqAwoM2LSSi7s1GYePoV/owEjQPU8t8DUh8luf7q1rYbV3AANJWwOtMl1Z0Krba431leNS+1TvgwLmyNBl6jQzXbeptqkMDQlYRGY34C5WgDZcZqske3P33HBZF235WBuo1CubmeAlSB5KfUcj0nlU+NVy6aSWwLvh7tS1kCo9tj1bj658E078kq8AXEPlIXTVM+L6HDr/f9qtAz22/GliT5sYkt8TAtXYwdW3XryH7b1QaDXSdPgEcrAOkQT1haL1NB5K0840NmB+VsHQ3tOeompk/SXcKej3EhOUQjdQQuOoD3PuKjHOgIE3j5CnXCZkNr3/y25Joyo90EMH9Q1lVrQJpLZ5RkGxJf8CFHWerH49AXHlZvgWE1CJPLv0711s8rvafPHqLz0E2BYc/tS+iD25aK4+dFHczLxmSaImw9RxJC9UpbvWC7zX//8VBPG4oTnYETAl/0m/ruXZugeCqoKQM/9SdiKuKRm+nP69U9IWiPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6916009)(6506007)(316002)(6486002)(5660300002)(2616005)(8676002)(54906003)(38100700002)(86362001)(83380400001)(4326008)(36756003)(33656002)(6512007)(26005)(186003)(66476007)(508600001)(66556008)(66946007)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aaf7vEzewaCVHffaaiLVSZqRgICPrkHXGm4U0xmLktnWVR354A189K1malZw?=
 =?us-ascii?Q?dbxLsU7zm8REykeNpUApcyDl303zZIKwbevv/dgO6XgV/EMPhF8q0gx1clev?=
 =?us-ascii?Q?FOAT+mGWzmy1s8/Z28Gb2xiD94vJRC0/rjw6lqMtxU/ohr9e+t00sQZsYJZv?=
 =?us-ascii?Q?dwEGLrfQRBy4jPnjTjlWuWAkeFgC3jEOIhXRp5iRjCAxLXMls0zE5eUZJM4u?=
 =?us-ascii?Q?/r5l0jcUrHwgQu1ivHHTBgq4noh9j3/JLR6GEI75wL9Aa7IPJM6HyrsmCoW6?=
 =?us-ascii?Q?lQHkh9XdXhwuKK1USnISqMwEtCLnkuAu4XBlG2KN7bAIO4/IRD86M9yUU9Tc?=
 =?us-ascii?Q?8KlZdC81omdYOXcDKAtPMnIAXJQluLTdAFo/L2JiXlhyRt9FbFS0zOrOdwei?=
 =?us-ascii?Q?J0IK997BZv6OA3cX+rc2AqScX5zzS1ULMg/4OclWYpeuHHOuG0s7rdceX3WP?=
 =?us-ascii?Q?Ah8pr0MKuAduYKndlzdmMgWPI0sSUKnuzYCR7IgCkKpl3vU3l9exeEBJWuSB?=
 =?us-ascii?Q?+KO+TP/CtJULGMRDAryqTSbK64L6/HtZl0c3NGhtfTjVz4ZNUquPsp1IjR0H?=
 =?us-ascii?Q?buR5X0qkZSl1TLkVS1I5VoQ20vgc2dvsFPV/Ug0qqDkEI9OLbxwNBFvj/owz?=
 =?us-ascii?Q?o6iLM+oiNxnYBXJQJhDPyIOT9m7Ygu50mKgQWg70b7Am9caG0iTmgTHqUcdw?=
 =?us-ascii?Q?rIZEwBeMT50yHZjQNIONJ/6dBUxk3Qj7zooTE8XlzOlsJAf2oy16lYqh761S?=
 =?us-ascii?Q?h20IwrsRLJ4YFVwRcRP926Zn5yiSY3bM87MjjXqOu5sVbOvM3WaMYO2cdWBw?=
 =?us-ascii?Q?yLjO44lBAJhklj/mgSlbakxPYM+E0hlyOyKTtLqyKKMM5chfbekSIXVH5e+w?=
 =?us-ascii?Q?hPFjf5yO/wdSk7vAq6mPG8budzbwm+nquKHn3PAIFM5RTcx0/N5VsjNaLR0a?=
 =?us-ascii?Q?JhpjznxIg8sxTQuon5aPPV/8xR+qOQxIHgV7XXwvvNbjIzZ0WXs6maCdm/ta?=
 =?us-ascii?Q?UBV1vrHWmdgn6oofF9ZpbToRglNP1B1s1XKCdlLVIq2fZaVE79HKQF7zyLZA?=
 =?us-ascii?Q?JQndy8VtacSCd6PQIEwXEAGQN4/qJ/XnykRznpmBg2IQckwoVFfZJYACI+l8?=
 =?us-ascii?Q?oF0A8Z3eL3hyeUFt3aYz/LZ25UkFd22UxxNTRVxkVYbVkjh3NwC1eZUD8FDx?=
 =?us-ascii?Q?VFdEh1OwOrRBcL03lYibTSpQBmaWC+aSOETc2mYI/+lBljo3g6KaxsIe3Ulk?=
 =?us-ascii?Q?HUEvrjwqd5BFp+4xkeYSwr2hp69nDno/43KuRS/d5px+17/tlM66mzgC8CO+?=
 =?us-ascii?Q?wte9JOn9Dr68l6+JGg/sKIQqMYOPgRCxuMuIOqBolG+l8cXE/zasALLNF8TT?=
 =?us-ascii?Q?GL3UtsiYUclk1Swe+jl9IsBFg45n7qBEUM+AUd8THGEaxYb8xl1qKWUOfHxm?=
 =?us-ascii?Q?PFyS/PMsBw7mwYuKAyBFKJU2C17a3mjiGmhVTdGiuUq81kkZ7SD0Aw0ykTxJ?=
 =?us-ascii?Q?gDq2oYj/pzdMk8XxHXT+HKutsJQZILalBy15LiAXeUQfPpRPDJ638Kz4YceX?=
 =?us-ascii?Q?akEEqmNf7wowsGkjWN0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84558fa-5dd7-43e1-d80d-08d9d0a7c04b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 00:01:55.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdedeWm+P3HH342C4X12ohEvicozDwsZ74QDBrxGf1iW8ZCDvSPi4R6+HWHbhci+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 01:00:42AM +0000, yangx.jy@fujitsu.com wrote:

> 1) In kernel, current SoftRoCE copies the content of struct rdma to RETH 
> and copies the content of struct atomic to AtomicETH.
> 2) IBTA defines that RDMA Atomic Write uses RETH + payload.
> According to these two reasons, I perfer to tweak the existing struct rdma.

No this is basically meaningless

The wr struct is designed as a 'tagged union' where the op specified
which union is in effect.

It turns out that the op generally specifies the network headers as
well, but that is just a side effect.

> >> How about adding a member in struct rdma? for example:
> >> struct {
> >>       uint64_t    remote_addr;
> >>       uint32_t    rkey;
> >>       uint64_t    wr_value:
> >> } rdma;
> >
> > Yes, that's what Tomasz and I were suggesting - a new template for the
> > ATOMIC_WRITE request payload. The three fields are to be supplied by
> > the verb consumer when posting the work request.
> 
> OK, I will update the patch in this way.

We are not extending the ib_send_wr anymore anyhow.

You should implement new ops inside struct ibv_qp_ex as function
calls.

Jason
