Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEE945725F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 17:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhKSQK0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 11:10:26 -0500
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:36822
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232454AbhKSQKX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 11:10:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhECy2FySfPC70MmHoDNBwJJtlJ+E+yV/rgqBWEa2upSb6hcnVDAeFj8ftzflKQPzk63dAqfwWFP8s1Ta8JkYDkznXfKtpZQCVyXaBa57+G46bMaZzI0s8BWEokFFHxinSYHr3c2q1bGAWSn+KJXpPjpqbf86dvlsvVJiIoqerVOdtXd0CT0+sWnKxDYevFW2qZN0kC6DAweLWKUPPCaWJZJrL0hfdlvGHbs7UuHhER5td6aL7uEJsd+I31eoJcknWzoTLjJdqv57wAvS8ezFyfC4E1yfSnT2HrUbC4OXdp8jcFMDYCjsWwPYhY9///1R1AUYHHdp/4aAYzqjt8PJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzS/Ouh3uINCtWJsyAdwz/HMUAGYGnZPIkhL2cn3F8w=;
 b=f9DAmRRsHpJDF57PmvoIHpvJUUYPckjiOFa6UCps5sHQJ8vs5VnyMfW6INhXTu59C2TZ27q0d3MvuAzFWbi3D9QHxarL+iJu1Vy8ByHCZOp+3L9T8fzrCpAyWoAz7+Mff2QhYps2I7o1UiqkMKL7n/n33AlYaX00xPRdkaXZe2YNvm+A4L/N1uSwC5y8nuPnS0Xgtw+EMHembK3FKxyEb9fhTs9HxYjw0gTqI+IBBhbNt/aB0faHvcn17IDKjKpSfcyxiCPDYU5GhrBjZ6zJBVG9V1/AwgP9cVreGOBjNhsjXeoZbtqDwntJ18wl5hO0SLyRCzO2dZSdeolPbXzWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzS/Ouh3uINCtWJsyAdwz/HMUAGYGnZPIkhL2cn3F8w=;
 b=AeMij+kjpIThAfIG67LfG9QCpqzESJ/shO/lTDfiU4YO04zqaFJTvsYSz4wYF1hwhJvdBDmCgDUbcTZkj9TFAc7eabVYRwhnIr4+aHS3uCnoLHfJjZFWeEzQSLsU1MHSDj2sU6iBbURX2hGlk5xJFBSmUBatz/e4cZ2mTaA0Qjbzvs3FAL4S5KwnW9hGRBqrfMhwKPRYuX28L/w60gOV6Yz4EeQmy1Cxu1h0lJTHFlmsnW1Ap9+0yWNavfW60Mr9heipHWxZ4DkwEQzWHAFMCW8g9ITwgGgyzX8mS4Vv7LD3WqE5i/JXEltCmRp+KBAxEn0S8O8eqv2NTUYX7QQajg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Fri, 19 Nov
 2021 16:07:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 16:07:20 +0000
Date:   Fri, 19 Nov 2021 12:07:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Upinder Malhi <umalhi@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA: clean up usnic_ib_alloc_pd()
Message-ID: <20211119160718.GA2940618@nvidia.com>
References: <20211118113924.GH1147@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118113924.GH1147@kili>
X-ClientProxiedBy: BL0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:207:3c::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:207:3c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend Transport; Fri, 19 Nov 2021 16:07:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo6Q2-00CL04-UD; Fri, 19 Nov 2021 12:07:18 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b70d152-b21b-442c-0ed4-08d9ab76aa0f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5255A927E3C9071238675245C29C9@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GoavdoumhdYsuY/O88BVDUUKLRZ7gvGuHwCy/Bn0kRatlyLz9DFJ3jYVSQ0Jzc1hcHjt/eMagzKeCnvCo8AxLPognM+v+j0F4zDwbiYJ9Q1dYoSjuYLr7QgWlFZrslvLdorTguCfN+jq9KWPcrI4ooTGwUKxBc4yeI7Qt7UHrcaKqMYWJzpmxP6u1QD7he9JFUZ8HXXSQVoH8c+gbdn1ZMFKqXI0UIEUTJAqTHM+ONBZFYkyCcutHsbE2HLveo7bWf8MZ7n2/dl01NlB2GTeSKZcz16gtfweYcb53QhSwzu/4C+1RSZIbhxR1NT6t9rqw2ysrSk507F/lb2PXuCjrmtYcd858Tk///bSKMXzj/OCkEP8gbD6aFkdSu8TwsusZY1uWdpz100TT8L0Gp5HFX5C3ZvxT1UUnMoHOJCQoeSna/yqeHEb66lx/ne10J/5W04QeOWRnsYDjjKFW4PDUhez4RqoFpQIMW/faaM/ZD2T1YLhVlaCNu0lKO+UUWYxMI2e/kQWDSmMOZjmr3gnshv0bFgQdJqjvAlZCVkusDI6RJKPVWmM3PzzoRwGAOh3pjqPrlt/wIqXHNTSaF68M5E9UqafYTpKTjEPmrUgMh/Ey/UIKc6y7jy8E84zeMsh59CI8rO+0CROk0yLQvnTFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(66556008)(6916009)(8936002)(33656002)(66946007)(26005)(2906002)(54906003)(9746002)(66476007)(4744005)(9786002)(1076003)(2616005)(4326008)(186003)(316002)(8676002)(426003)(5660300002)(86362001)(36756003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vi0YQYdNkKW7PMwVof6YPsrLcpd+GZ9/wIlzp4wTqq7t31EQqRU3IM5zdvvl?=
 =?us-ascii?Q?Ev2z1d9mfsMgUPRcHZgNRS5258U06ID3lC0/XTOO+8uWKuV3e3BxZXDrpvzz?=
 =?us-ascii?Q?01es2Td0rvqRFpKS4hlI9I9VIqavnIPC3U8y4Nvbjn8DSoHxUGq8PubLxV5z?=
 =?us-ascii?Q?o+uTd4+uoV3/5k9MTi2vV4xyqsT+FiLS4dF3v8FIKnYw9NfrvTqyYFysvbOQ?=
 =?us-ascii?Q?snLv0HvRRtehDksQWpLrBsFQMEgJCXAxt3C8nrAnp9VNgcmsRC9ZzKx+vUsF?=
 =?us-ascii?Q?K1yWUtS4dSF7eL/EIckiVDI+7x+WfeqFjUAnC05tu3I5WlcJEjyYfZmDW5dB?=
 =?us-ascii?Q?NIORZ/NE400Ck0/zogH2US3eUcnFXYQmw/mpEHKno4MW5fY7Vkt0MRntE/Bx?=
 =?us-ascii?Q?qpYRRKM6G/sqIl/xIXDqLQO7k536gGgY1zsj2xv8pby59NkZR+lMaQXDvpqa?=
 =?us-ascii?Q?PV0eVKSJ8SKgqzPBkKy1i3D0eK+ROjKr7Y9aXZI07+9kQTZwDJKs4rsFMcqq?=
 =?us-ascii?Q?LbdBsxqj+OsgE7mTgZHvjhObki+jxRRM2JkZ4+ok6R5fMxdqwvY/eHV86T3Q?=
 =?us-ascii?Q?bjSlxMXYEM/TAtNtZQfvvMySFOFcp+nJnXrKmXXEV057Qxa1Tu21R4/aJUdV?=
 =?us-ascii?Q?9jSlTaX+dQwHxaBuSB8lwsiriX/UGrb/FEtz2o+SoBLAtx+30PBP7/sTre/4?=
 =?us-ascii?Q?y24eEiu7GwWUQqaUBD0IQ8BssiP26L09X3azN5u7tLL679kA3xivw10YYW4z?=
 =?us-ascii?Q?NhtFSX96bgDifxv7+aW3M69ff4nst1GXuFz3FWiD6kuHtrSNh1MtEyvNcMlX?=
 =?us-ascii?Q?LGQ10e2yl6KFMleiDqOxiRVR23AfGtzO2gOZqY7plgT0qWwqSCDfDfMCFUoA?=
 =?us-ascii?Q?zYnT6Nm/4wWLi7Eu69zVoKEYMNqlusuiM8u5iEf3qYFpkTF1W2x3dxLYjWg6?=
 =?us-ascii?Q?WUcqrf1LytNErUmQ+mxO8juKC+bEHh6p6Ast5tbK8aQNQ+Pd9kLtoml274oN?=
 =?us-ascii?Q?aDKZ9esM5TIblz1QR+DW2gYc8QS68dPIZF0GZMt729vGIgorDdw1tXk1tKpD?=
 =?us-ascii?Q?s6naQQpL5n1REgkzRWsxeyOx3sa9LbpNEv6NPsDghSDYYofSohGDr+pt5aMg?=
 =?us-ascii?Q?DeiI0vjRkwJzUrETk2DGjrbmfDDT2BE6JEzIT5fMhFrmqNwDopIYdCUk8kCt?=
 =?us-ascii?Q?a8KXg2AntpgMrhIKOTZBbZafFOLkbCUR1CdF5ICMTu4O8RY6jQmXp/tnlalD?=
 =?us-ascii?Q?SEfcOz+X/6UP8wx27P/usaktHkgngmUXU3efkPMbjBKm2z07D1rQiNTBTomi?=
 =?us-ascii?Q?owQKiF+SSEXFuCcc6hCen598+iCZLNBd/LsdfEG48gxq70o2HEpvnanYVQeu?=
 =?us-ascii?Q?LkNp6zvHWuMIyQnp8PO0Y/sySUJgDr92N/LQsjpXqm/PyPNm/ICgYpoZKsuO?=
 =?us-ascii?Q?P6AKonuIXBlNrvfTGPOfI5WmrN7rpTEL0f7HJ+RB1wu4AW1EUpGVSek+xRPJ?=
 =?us-ascii?Q?leaKolukgCeUNWfklz/7sTmKVimrWcZ3PIS0v51dgAoip5d70VVO/G2iLKiT?=
 =?us-ascii?Q?XUZ8DezZxr/pm5aFdzQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b70d152-b21b-442c-0ed4-08d9ab76aa0f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 16:07:20.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZ1SeLBorG6JXG5iUlzcRwovpj9QPIv8l8XFy1vDPaH9RMHSdPQATCR9pdQT8XES
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 18, 2021 at 02:39:24PM +0300, Dan Carpenter wrote:
> Remove the unnecessary "umem_pd" variable.  And usnic_uiom_alloc_pd()
> never returns NULL so remove the NULL check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
