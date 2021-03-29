Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A7234D75E
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 20:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhC2Sfc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 14:35:32 -0400
Received: from mail-eopbgr680043.outbound.protection.outlook.com ([40.107.68.43]:36229
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231612AbhC2SfX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 14:35:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blrZAIjhLJT2l4gBT0Q2f4bVJKxuuirc6fBeopdhTClbL+DBs/1r/+rLyT8QjKSf6W3P+icrZUyeDlXTE+wR68JPB8neNCulUOyW8f1BCffZE0VC9VVJoiZWzXfca2RVyAolD3YGQbDVQc9RGCn6fqGEbxzp41kpDV3beWeEt30nrbYr8dp4CvlIBEpNUi/CqiX32nN9Wl1kkeAjGHkBA7P35S9zrSCfvg6XRBxKxTyHhigPPOLcFfir/ZvLp+Z97JnNy23sIbGjXMITWokz2SRb48X3wOLMOnZxorBDB+zC8trkacAWdNsJR0KD6ULUtgNiE5g+QxK2p/RwuHRPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3jqz6GJe7Z0HV4yfg3mywILd+zm8trMeYnSmpADGt4=;
 b=G8fdLzeIIsGBcRCxXUiV1l67nygoz4/KY8lsG1C1spXNdtv7SAT/oYPw/EybJVEkSOC61v+8/EoY40nTBc03uespGtaUC5nyv8oLPy4QfpFtlkSHsGmBdmC9XUG0lPa5JA+aaFDk6DvaCA5U29jGNSLTGS8IAHRVpJBjYEd/9u8nNowEkcm/pN4McCVOEQ5U01XzFScgrlTo8/cuin0irfzk3AqAKMQbYOqlW6d2hNPAZy/pmszRb1nLqXAEOhWz2A75vOLfwbGmVMkGxJayW2MljJGDOni+GdU36eNkLIA8dTG6Ze+XWg1DKfbY6IsXUGdFGLQNFM/SzB6P4WIoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3jqz6GJe7Z0HV4yfg3mywILd+zm8trMeYnSmpADGt4=;
 b=H2c5hRUVk50xfk0QpLs3lquvNgdqVrzYdRjHi6Ncs9qYqaEpP+UqfYn6CJWMbr48dx+1cCHAP7u+wDzAYMbpM7NGmQo8DrWvSud7FfJlcYcNVOsBXeHTZd41GN29uF/kizZ5OWF7Rb4cxP6E/lka+dsUjy/0LcrlqoYH5WC8UHeEs9RxZVFitNB4m4nW6FtENHZWepwmS/p3BnAtif4kNyxSokeTU2dsbdFCQ6v6nneEZlazheHcRy1TaPorJLmas/i9uLniYfvyPgwkZDTygKlVNC+D31aEKPZV/h2Y0VBQPvuwa9AzuWmjxOnCsWTIbEMel0fAIFWGr67HPbFlqw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Mon, 29 Mar
 2021 18:35:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 18:35:21 +0000
Date:   Mon, 29 Mar 2021 15:35:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Mark Bloch <mbloch@nvidia.com>,
        linux-api@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Expose private query port
Message-ID: <20210329183519.GA1230305@nvidia.com>
References: <20210322093932.398466-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322093932.398466-1-leon@kernel.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31 via Frontend Transport; Mon, 29 Mar 2021 18:35:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lQwjP-005A5S-Hw; Mon, 29 Mar 2021 15:35:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9269ecd4-ae6f-4aa9-ae2d-08d8f2e168d0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB114776BD6B07A4EAB79D2835C27E9@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfNl40QAtDjMkO/F3aBvxyU+FHkLzI4Ls9OXGNFTpn6HbfCOzvEjKlkH7daw+v13phrG2pK63iOvbWGhBpWoP51XRVZSE7pScUEKkpsEwHxNFjgeNOWOGtbdAxM38twErFeWogF4JMrgVaRtBHoI0g80ECrcEFlHK7sy17PuAMPvMxxRDIm1lSz1+OoEF4BjAY8zRFlCFpSb+e3FyTOGw66di5R64WafOHKSHG3tqLoySL9Ym/2f801K7JmKafALGw46JZGIdqQSRYbVkLLR2t6Ysl3CttkKKsXSIfk6vB1HQWZKLM2ydZw9jfnDJZaUV3En/ZfSYmKcAG8rZ4rktfTlszFXK3b4aGDriVnt+WS1ygaqviTV7KcDjZnbqJlt6ygQEb6cKLSegx68TRGacoIMFohvwK9/0YgVBYgbZIN9xyy66EAnVQyYZgf5IXACP01r/8PFpzmBVfFAATbmJrkbLIc3QZTz5ToKqFjQjGtu8W7Nkhv76cF2tEj3M1U5yI0QQ14xStw3ijhrHAomoY/orH8cw8+c3y+5N6fbUf5dpjXSV5dEfhRsfydfdN4m35hhohBMyAHaj4TCvnv2Jod/vZGizM2IlvMH/3nd3p0mSVocp1J2IWCHwFCVsKRtN/3/XJJB7XCjwPttX/K80ewCeoNZWSKCKuVFGqt8nUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(9746002)(316002)(54906003)(9786002)(8936002)(5660300002)(478600001)(107886003)(1076003)(6916009)(26005)(186003)(4744005)(8676002)(66946007)(4326008)(2616005)(33656002)(86362001)(426003)(66476007)(66556008)(2906002)(38100700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wEZiTxFa2oW+1unXkn4V4L/pv+9sdSv0gak5RRvPrF0H6iQENm4pLfN81Fxm?=
 =?us-ascii?Q?u6X/QR54fVo4FTgI14bQxYtNutqUYnt5/d34DfoI+7NmA2v3n3gIG64Zltk9?=
 =?us-ascii?Q?lvoJds3ffbY7BRqBr/do+664ATutRUmqxR36FX4JooAmIwGt1ZrvoHzvbKHI?=
 =?us-ascii?Q?PYpg03nEEHg+dPZPQLs/dDZIK8anH1ZRm2Gc09KemOiZfhd/62v8bztm5Lhr?=
 =?us-ascii?Q?4yP3NfZlfOiONA0CLebHQf7u5NnIP1xH2pUT6wi0/0mE2ZM8zLhpgutrsfw3?=
 =?us-ascii?Q?pw4oHKkadUBsIFOSZ1Ks3bWCB5tOWUKdoBjbred44+LpLNtVmq6CdULI0GJr?=
 =?us-ascii?Q?jWVs6xhaH8oiqR8MiuyftHDp4BeG9+D/8bmAKpONfBPLMjeCQ2rDXd9e8Fs5?=
 =?us-ascii?Q?qb9t/ypGF2yjGQXSVIzdAIDNxkLO6ktsPQgh6xbvMWQF8nAiys60Y1e3PWf9?=
 =?us-ascii?Q?/vzW67nzASp9Mx11BLFe0/20HvgwOQyUGCCY6ADJ7j3bJFkqsXvahsRRSHgI?=
 =?us-ascii?Q?YXbwfkj4GmBEoJhHsGNoXxxTeDKZvFsiPlF5KJ0ckSYGgL/h2fkCdkhiUraz?=
 =?us-ascii?Q?czu0P+/x4gMz0Jzfi4RWRvXe/CHZl1jKtasxtoMON2x+HIP99Aax/83B4yH6?=
 =?us-ascii?Q?tZ2cRpHQtkU7XkDtVCPVXtvcETkFL4GQhroqef7YkKJ9vQ4NEPc7hkIIyFQF?=
 =?us-ascii?Q?Ff+uKEiA79krX0LdsoAxY1I2DhdOgC3o3VF074MUC9N3grYcFnCDxp/3cp+Y?=
 =?us-ascii?Q?FxI6dnqBrv9EjFoC4JAg3i0UydK2MmOjIoBFmZS86td2XYj9RTC9ig4aaWhJ?=
 =?us-ascii?Q?6ujuSHxcBaG7HBVPAyB7udn9xt02fyVVC4rgbzc2AEmQWVBO8JhOfvrs1d18?=
 =?us-ascii?Q?qOgV5KmKOJrxUS54nUCqf84Oc3E09E63irEcqvH69aKmL7DD92E1/CXkDsXy?=
 =?us-ascii?Q?+GTZ11DwiMKc/kkIFjRe5LC+8fQnF3n559k/dnIWme4EAQRfWp8Bzle7C5Uh?=
 =?us-ascii?Q?zukLweOS0AMMQdQPu3oNxgQbKO6S3SiF1bpgkDdfE2igVv1e8m9LXwG5gcTB?=
 =?us-ascii?Q?xEZXNkKbgeK4AXC/4xXzNN3TNmQZDlfpg0SrT6R7dgA56daQ4SZ0Rpz0yJ3t?=
 =?us-ascii?Q?bLBFYFfSBoiX3so/wvKr3bD83A4Nb+pWh5hojYm/vysSVDwa0Zqo3bewu7Jo?=
 =?us-ascii?Q?wDdDsdPyBXt9wf2ji+59JljELpEuSCgNbomaOTWGhaN3wsanF7Q89MKrAcxL?=
 =?us-ascii?Q?ObL34MbsiwkHdFkVkyxx/hJg6T3P0z+t6O0CXUoEaTrwwEYiSQ4FL8QMbFFs?=
 =?us-ascii?Q?cITQKz9KmphAj8aMBWvtp0V2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9269ecd4-ae6f-4aa9-ae2d-08d8f2e168d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 18:35:21.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaMEG0R0kHGMZDQVxjtH2YgQ0wIhSqj3HDFo7XsnxMH69gvtgLFvAAHQJj1cHhb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 11:39:32AM +0200, Leon Romanovsky wrote:
> +struct mlx5_ib_uapi_query_port {
> +	__u64 flags;
> +	__u16 vport;
> +	__u16 vport_vhca_id;
> +	__u16 esw_owner_vhca_id;
> +	__u16 rsvd0;
> +	__u64 vport_steering_icm_rx;
> +	__u64 vport_steering_icm_tx;

__aligned_u64 for all uapi structures

Jason
