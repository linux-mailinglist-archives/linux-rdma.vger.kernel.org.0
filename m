Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86D93505C1
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 19:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhCaRum (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 13:50:42 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:53728
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234446AbhCaRuK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 13:50:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4Vah5Q+jyCHYBreQWi9xHutu1K1TpqZDT+o8fxhn53Wqeoth4j5VWjwsEd2LQnRXUM5CjXl/Vd+1pXE5TVpMDYuv8NAPB9kMEmwsLABgDQ1xNe9znqlSxa3CpDOXk7kNFeRQMrLzpZEOKX9i/9tYf3+0QSp4hYgeEMHK9VNbOeb/1adhpCSEXt8aRSORi+tivuLgf378EHTO+o2H8cLFjqV83EYKaD98Im3hVRhVjn7mVIBXRFobd2ghgDhkTT0NFN7UNGwtE9tJkJgFo5OW9WOrSIqCG4ND2iX2qNSKImXKGaG/ldCa9DrjcmoqcVlRTFLfAsZyUdPPLNJLlTSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7kZ50nSrFz1GmBvwrIXFMUocQbTyUjurYjqnAbfrBY=;
 b=G7cPUX8jC9rT0ZCraWRJ7R7l28TW9Mmnn/93G8EIo2bCeKm/EhtM5miCX+3GmvxKaCxwU3pYtoOsPQDvb97G4PLdPo8gY7LEvvmJ5/640ex0bp8McqVgqvFQ5fuO2bfeHgB7TfYpKzfnc1UzebMe1Bsh2vuaE3ERQ6pa+aZXfVGgDjy+WSPgFt09U2dI/XiJ+7WwUAri/MXLORezrLTn+665tFQADWSJq3LKFhN4V73SX9cb0ReQvd/xU4TU+yJAM/CMspGQDzMKi/nIK6uOQFDdx0KL9l87BT5ZaSU1HqMJoEhnZqXGGbTOYrQkMiDYdGIQprfBfEPIemvvUXm6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7kZ50nSrFz1GmBvwrIXFMUocQbTyUjurYjqnAbfrBY=;
 b=eL27XyDEu4K3uUCZd9vtSjtAxju9pxdazl5jrFUpGaH/YLYm6t6nlLcgiXb8X79EULhX9wjNyLSTclayZlzj+OjaTN0BqZGbwByaLf5o7wHtn5ji/EwY6budU0o6oODUHxtzV0FWPkH+l8fab1nUpUoGDOZQpjse579UaIs+gWR4w6ORgJctWr3A9ouLbPTGiuQzjYSFEcy7pOq9zu1EimIC0g/J/Wt68q6lEkZfls50aZz/rpd2zvCMJTdTOCEGVfqllnjSQSoxmCgW2+G4UTSo5fuOCkL9PA/g8PW3n0hG8XcCqYhEBi47sHmc6c1IIS2DrTus+yue/jPWpdg7iQ==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 31 Mar
 2021 17:50:09 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 17:50:08 +0000
Date:   Wed, 31 Mar 2021 14:50:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Parav Pandit <parav@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Message-ID: <20210331175006.GQ1463678@nvidia.com>
References: <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
 <20210331131525.GH1463678@nvidia.com>
 <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
 <20210331133518.GJ1463678@nvidia.com>
 <E76F07B9-F222-4D0E-889A-712502DE0376@oracle.com>
 <BY5PR12MB4322EB01D0A22E6806B6F195DC7C9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210331173514.GO1463678@nvidia.com>
 <2BA07D00-E144-4547-8F7F-77DB0C197706@oracle.com>
 <20210331173906.GP1463678@nvidia.com>
 <C55F49E9-900D-43F5-9430-E62249B801E4@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C55F49E9-900D-43F5-9430-E62249B801E4@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37)
 To BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Wed, 31 Mar 2021 17:50:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lReyk-006PMJ-VO; Wed, 31 Mar 2021 14:50:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 916f92df-1bd3-46e3-c65a-08d8f46d6cc9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2743FA3F0ED39CB55318B5A4C27C9@BYAPR12MB2743.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7vwTPmsuHMK0qa4hFLmSjRvpH5J9c2Okl/tGYvbyG+njZsTD8q2wiPZrAhvcxHUPu/0+WCtzCAyDlfa1DtY42vKQz5o9cSQrzfaMmcxygbZghJzqVmQnd2f8DouLYSEgjHVdho9sepyomJZdLnZDupCZXxpqj0pFLTMCsrFebie4khGtGvwKcc8WpEsUF+XTEP4yMWCqCF4K20t3OyXR46IwXmVWEoZKoMQTn5oi849IeNKu7hDKMDeitff/+6qu8wk/Pa+R1XnyaLXfbaIrHRTAyrK6khJq9I8Esfo7Mm0m6N8CAvfjRfACVSOotjbWfyp4AFCMp78P/03O7rhyXC6cHQjn7wI82A2DvzwGqMQUBY0EUalJBkHZAD2lJ/QjJWp/d2PwyrVo0sHO3pxNL7ZEw/6LOsv3UpPPCvDbNkZxEesJYGykWk6XvEv/9NICJvzK4Qpk6YmSe/mgpC0RcVavkI8fCFNSiQNz/3kaeWXk9GtUjcMmDPd6xLgPc7XKZIv3GLjQVPxhAQv8CwI0gl6aYln+AnvjbS2AEGs+SgRbVtppXxnJ1LfKFTyazgG9XaoF/8+1bnAmjyoIpJhUDTasTPn52ZaZ3Es/HR5vNUSzdBgjDGFPFV6zyRnG5DvUy55koTzy68u/QlI339w7iGeqEU6yu6AHOotM6qgo3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(66476007)(1076003)(478600001)(86362001)(2616005)(2906002)(186003)(6916009)(38100700001)(54906003)(36756003)(316002)(8936002)(426003)(9746002)(5660300002)(8676002)(9786002)(4744005)(4326008)(66946007)(26005)(33656002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9zv+mnEd3Fr0tfJwQqohB87NJHftiEWB+IyBO2BWVEQKtsK+QoJCd7BOafw4?=
 =?us-ascii?Q?AtUXUH+y5mJGdu3MDjrLpvIwlkN2Wp3M3jRMiWDiKl70awRZm13J1Gzwh4v/?=
 =?us-ascii?Q?xxFQfrHMMjXn6jkPMjVkBqIzM2oPaqsrYH9wYpWOWwUn0ELG+SlhOJusNquK?=
 =?us-ascii?Q?h4Ic/ew6jmvNeHhTPBZr2qVQiKGe15ag+VYO5WazEwF+jsCcDjNne5bH+4SI?=
 =?us-ascii?Q?bL1CEFSvZQbtgeLhq7Az5IxYf3ObcPMsVs0hkb4f93g9fY45aLs8s56HNk/0?=
 =?us-ascii?Q?z4mIVylaXxTanQTZzJHD7kCeII2pnayHilLHzSlNtJILm69GezWzWqKciEHY?=
 =?us-ascii?Q?E+MASbNRkwJv7XQ+rmtVJAqjGOJs0iOjyMV8jfbNk9u2Eyv5aTtgTjmyikFj?=
 =?us-ascii?Q?ke/0kN5Ar6rOXypxNVbU64EUIM5bvqgRH4fCE8L3zzoBlRndbNsVVEbsYY3e?=
 =?us-ascii?Q?c1NIA480+aWDWkVtc19EYzCfFf6GNP31V8W5bkGy08Jzv6WBVx47SljM4n17?=
 =?us-ascii?Q?C1mT884Eb/Q+cayHFrtVJ7IyHWft2mESU6fb2RPHwT94t7U3IHT55NZJovh1?=
 =?us-ascii?Q?xH7FsaFQ9d7Xduh6iJKrEFRonc8biHc9mY4nSdOsmeuyW7MhbOFRIlOwskc2?=
 =?us-ascii?Q?Mo/xIPmWx/XOpmEv4XMwDrQ5Q9FgyMRW84bc7XzRWd4f++DXxf/sswEdyyYu?=
 =?us-ascii?Q?di2c51eIMZsArCtly1mxvszLC4DBuf5WQhJj1QQ/jor1KOyeY09hece5modp?=
 =?us-ascii?Q?uRJ5dKjS9rzCK8GNqV06QNvWaVdkb7dQio7y1NVFFr7SQIE4sug9MP/EuL3a?=
 =?us-ascii?Q?fntiNUWbco/RorheW7PxR1P5zg7OicX2INvMAwiF+HZisp3qLS2yTEPRYlhh?=
 =?us-ascii?Q?cBmMzZnNp8zBVSbbTqKd4yM2LLRbXFmTETrSojIj/LuciNhRDZ5LcEDe4NKu?=
 =?us-ascii?Q?OtoS7wOIp6wZfk4Qgq9eihIw2UCHEgXx9UJXjPMD4i8nVjaYOUZVAt5s5hxC?=
 =?us-ascii?Q?xu652RRWRJkyhdB4aHAJstpinbq48KYvepjqmO2lR7ZyntuJt8E9gHt9/sYC?=
 =?us-ascii?Q?WD/nEuCrIAskETKb4rBSDivYUg+hntODswD3oOVFJzdKcj2uSy61wk9IfVKF?=
 =?us-ascii?Q?jR9yOZxjfbd8K9r47fRKknRL35leuKlU4YdJ8Fe7V3C9tu1RQ0QBAd5KOv8y?=
 =?us-ascii?Q?zPf5JC50gB3jaA1CJJ+lMinM/gdmUs52RWQM3+Ll3ti1YrVk/8ji0ebKdj31?=
 =?us-ascii?Q?vSOO+aao5S4qmFuNlUFLB1On7C9+MuL4YjCc3IW5qmdyHOdey6bY7iXxwu/g?=
 =?us-ascii?Q?QfUB8EfHb1LcNRjn11LF8X0T/juyrtNTbYH2l3ZSkl/v6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916f92df-1bd3-46e3-c65a-08d8f46d6cc9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 17:50:08.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTPKvPgOjloAHOzsM95wm95dVjdciqyNrbdy7SZ/9G9Voq8cXo48bcjAHydAhLVh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2743
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 05:45:30PM +0000, Haakon Bugge wrote:

> True. Local ACK Timeout is part of CM REQ. But that makes
> 2c1619edef61 ("IB/cma: Define option to set ack timeout and pack
> tos_set") fuzzy, as it claims in the commentary: "The timeout will
> affect the local side of the QP, it is not negotiated with remote
> side ..."

Hmm, is it intended to replace the CM provided local ack timeout on
the responder side?

It doesn't look like it copied into the MAD though, and the
qp_attr->timeout only looks like it is et for the IB_QPT_XRC_TGT case??

Very confusing indeed. Parav?

Jason
