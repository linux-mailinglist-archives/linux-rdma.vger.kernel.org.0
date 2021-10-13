Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEE342C451
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 17:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhJMPCw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 11:02:52 -0400
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com ([40.107.244.78]:45729
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233837AbhJMPCv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 11:02:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+CdJc0aBKKprXOdWKcnChgbw48Q3oE5VM6g71FuP3y5Lc6ttVWoTxMKsFzLJYBu92Kr+CiEp8xwH1sePPPzgf5eMTMpMOzEyTFcRzNUxt5IzBwj2njtpI5UxGegAb3URIuGmxpkMf9+O9kpq5bzCogdKpj7uXO4meqgAyicc7HIDPxFkIHuJkm6Cf01x3pgRX3V32zZfa21TOxlqZw7FX88zcwagnRAmqRk5T+szrhIEm9xKoQL6dlyhamuWP2Jw008LgHJFlrBCOUft7Vs6LkOaSjoxb+2aAtp9vIKoN3HjhmUMTKLwrXe/AO5RXAaq71ggdRGAl/fs+kYbjhBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sS1L6dPhCcHck6mEPpf+9/MPxKS85EDi5FSPOGpqidc=;
 b=FKpvN/oZnHeoJxA3BmmZKlERWdx4jecqk55qgafgB3uU40huEKepfB6IbYDTbRIPs45EdNPnXZTTN3Zl5l6MyXpmr2L4cWq4GkuuLRDSaKrqVNW3X/1w++e+i9n7+RrxGk7U9qYxth61Gj91GHDf3y2dOD/WV6KVNLzg3WKkJFxOKS6L9oPSOdBSXejVJQpGwIea6dfqcmBYCSjPYzf9fUpi0sU1+izObVl88zGYybntesNYT1udfM40dXt+gjtDfC0YUDH1bjHaFboJPOd2AE0qcE/hz53PsIaUMg0nP8OALyI71jLQ0Fk/s9kkG6VNLJB3c7yk0VmpBWNCC7M2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS1L6dPhCcHck6mEPpf+9/MPxKS85EDi5FSPOGpqidc=;
 b=EwoCSYFyAo859A1xewCTveRfFQOv/sJOXqSuYayCLWO8OBpw2Vo6yBPMzaN0nZUSAZX8584dFXd8ajlbeAYXxKonVIuKfr9pn3D27qXQXV0Ic1fAR5mhTSt8380RiFHX77ESpGTtGXQUNBx7yN8hmP26JqH/cfh+wiYTSOhjdHCKDzcgCPrZf9IMn/7FOyumd08j75mPMwU4CT3kJdqsdEG0eLtKOXdLelKmIEcKCshUqhBnaNS/kK6GQlqcHXyaKGxtRkG8ZJxPmMbvGkgUWDOQDR89tVhRvCE//+e802ydMtSUz++dEpoda0Vu1kkvnmwVGzS/8muIEnE5XG9ifA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 15:00:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 15:00:47 +0000
Date:   Wed, 13 Oct 2021 12:00:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@nvidia.com>
Subject: Re: 10 more python test cases for rxe
Message-ID: <20211013150045.GG2744544@nvidia.com>
References: <34a9a53f-1f1f-bddb-0c8e-63ec5fbcd28e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34a9a53f-1f1f-bddb-0c8e-63ec5fbcd28e@gmail.com>
X-ClientProxiedBy: YT3PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:00:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mafkL-00EVki-BZ; Wed, 13 Oct 2021 12:00:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e3b5f9-ac6e-4996-ea0f-08d98e5a3cda
X-MS-TrafficTypeDiagnostic: BL1PR12MB5190:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5190AEABD79FFD51B5FA6210C2B79@BL1PR12MB5190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSWgjzF+waQFkOdJiT6UHG08JmM0eg+PiLM0k3144Eh/SEiFGNNjk1DMQjg7u8lQTMe1ECXEQQHVcPTHjV3cDDPyxb3JntZAS/mOMk0HUQgCrqrtW7kxh5XjgQpFyydROaOv/IOuENR8QLkc8IXFU8jzIQvpKfwhuu4eI51SstIooHRdcb8LWNZTUiu0qmhusrriXrqLwU2vWkIUbLIv+hYVW1bjGAVjoZoHH20h/1Z6rfgdOvB1HIJM6AxgbDIvBKjfu/mZ4fDlFWSTMbLDJIAcWaH0YbtLbHC5E5Mh7pqpasNxa0lSWq7nwdLxOuo33fHozlzD8R0PWiFx10wlPo2lvI2G0KVdFEOVd3DhKYd7aXy+Tzdq1YK6xCCurSw03ZYYR3tTVyzJ9lCR3p9cKtUag2Aa58XzA/co0IwX0b3RpspEpHi0+t/9DmRf85GwQmFnfGyqr5X0IjE62GZUJjnsBPxwAUMVCXsTzk7xrLjnIci10wLLPZ/Z1d8HQjpNVUPRBPKVUGhpMybtd5aIwXG5e8aYLBS+tuFWoBL9W7lMef6NFFWlTSq2g1mMmrARlDp3XAJwEMKskBcU01qpAkO/VFDRz9thOyIlwQof/O9Fwm8Fr48Ieh2slvf5KsBhsfg2wVzkU+oWc0yIcr7cXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(316002)(9746002)(38100700002)(66476007)(4326008)(1076003)(508600001)(2906002)(186003)(66556008)(33656002)(6916009)(66946007)(26005)(5660300002)(36756003)(8676002)(9786002)(2616005)(86362001)(426003)(54906003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GqblDv7UUzlDwYvEHUrPZc2w80CUSy9VA8hlP5Pm/H900SwyvQRz6qsa6Pfk?=
 =?us-ascii?Q?PKe6Lo3sVsxu8PtL/fbcrlQ9KCSHQaf3CKRUik+0rtPjwbeXaIzWZOlYU+V6?=
 =?us-ascii?Q?PRayPrge4YpZkY3cPYr1LKVDX+1NnL+SdJFAmK+0G7Ppme0XCa/H1IY2d4dr?=
 =?us-ascii?Q?x3z6uoZNx5C6NAVDkamIwxMyy3efN9LV5GrcbJv41+kEUIafRBY2QbJQPVOI?=
 =?us-ascii?Q?4htwM/UhFZrnZbVF9cad0+1XHw30CwQJvTiX2IEXx+3wa6Ogk8ZdzSCJXt7T?=
 =?us-ascii?Q?8cs0Oho23/GnYOXhGBun7iy9I3Spc+ObJPBbBmhxvKgZ4hBCnbsU1p2uv/u4?=
 =?us-ascii?Q?JGkS0+S8wN7eonsavbITbfCJM/eE+IzpilA0ZNVXOEbdHVJNjEYcuqZ4yWOC?=
 =?us-ascii?Q?4THJ9MyBRxClk6PGZkQD8L/+hxX+aRl5S8ehNoSRLWZ9KW2281zWII9pBW9O?=
 =?us-ascii?Q?kgDFc0nY9n69NiUa7IOQcswA12I1dg0u0Zhxzuzu+HXYkBr1iXbV6tu/TKW5?=
 =?us-ascii?Q?ImlHDaR5w4xw6IpGlCkPtP502UvEsl7f2HmNvWiRFDh0udYmQlWmeV5C68nl?=
 =?us-ascii?Q?dKb7Fpqdi16zUtJDl4K6PVGrxFT+3nrpOUbY3uHSXrO5Kzm1UN1X/FYcFCnz?=
 =?us-ascii?Q?vmDQW/G1Ro6P1IhjGmQuNff4vvNGjCEpQDMrOU1BNWhTnz8MA+QFTIrgm8B0?=
 =?us-ascii?Q?3EGUfkRdhMya3YimtLLknYeNqgf9rkp7u9NlckD2DJZXQm8wetKUCC0IZyxn?=
 =?us-ascii?Q?PkmzwhLjPJlB5lQLKafcCVwXj9Lh2pkOOfEEAH19gIbDDp+d1Chz3ocPX792?=
 =?us-ascii?Q?WlhE2UuR2BFncjtiywklDEUuMKIOx6rUy+DcuBmHJm7GR2FmiTfzPA/6OEZE?=
 =?us-ascii?Q?YJ8goM401PPcP0q1dDrzRxE0YX5aM5HEBaWRTN+xfQFJZ+xb9goJ0x/4iZl3?=
 =?us-ascii?Q?J61aHdhMTwhaJnkOs4vwFp+M1P11Hpc4/ZOF33OiGY5GU+YKyesJAaUn878A?=
 =?us-ascii?Q?nVB2nWQN09N0lRG+t1s5JqYBqvUHk7NLQQJ6uquHZbO2/h5ri5+IGxebz20b?=
 =?us-ascii?Q?FZJ0uNh1Cq+e/Kh9PZaSiJGUhjZpnbCm71fMlUTTPwsB4O38hvpc1q7pqgol?=
 =?us-ascii?Q?RSR1cUsofebALJ3eePCt8T2a40nfqgVfYLe52ZMlE6ADQ8/uFDdn7mnIcJHf?=
 =?us-ascii?Q?zVTApuXRGpIeG7AGfhdQI6D05zoOiqtTJsgQwDi+2Z0QFMGa+Esq6XhotJ9m?=
 =?us-ascii?Q?fXj0LTG6EMTr70Odp/mnhZuefGGk520BatMI1OR2teer++l+qZM20Ssa82tB?=
 =?us-ascii?Q?dc2tqUo31sNiStp89uIUgmIv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e3b5f9-ac6e-4996-ea0f-08d98e5a3cda
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:00:47.0578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1+aCH+S0l2QNHtrX4IdPYmCgGZfhwORtBWF9yMA1Rdiz7Q9iXqmeF5xg5VBzuqf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 13, 2021 at 09:43:28AM -0500, Bob Pearson wrote:
> Zhu,
> 
> There are about 10 test cases in the python suite that do not run for rxe because
> 
> 	... skipped "Device rxe0 doesn't have net interface"
> 
> Clearly this is wrong and I don't know how to address the root cause yet but the following
> hack where enp0s3 is the actual net device that rxe0 is based on in my case enables these
> test cases to run and it appears they all do.
> 
> diff --git a/tests/base.py b/tests/base.py
> 
> index 3460c546..d6fd29b8 100644
> 
> 
> +++ b/tests/base.py
> 
> @@ -240,10 +240,11 @@ class RDMATestCase(unittest.TestCase):
> 
>              if self.gid_type is not None and ctx.query_gid_type(port, idx) != \
> 
>                      self.gid_type:
> 
>                  continue
> 
> -            if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>
> -                self.args.append([dev, port, idx, None, None])
> 
> -                continue
> 
> -            net_name = self.get_net_name(dev)
> 
> +            #if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):

The pytests code is wrong - it should be querying the netdev through
the verbs APIs, not hacking in sysfs like this.

Jason
