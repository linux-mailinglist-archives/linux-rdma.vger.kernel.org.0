Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5837642A939
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhJLQTr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 12:19:47 -0400
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81]:31232
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229495AbhJLQTr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 12:19:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmTBTyEKfY3v2oL5juk6HMuNhieDlT97SxvHwa7mcLiG5ZwnKSDAF8mrIot8/VG2pS3JX52UHeRvuKjOiuyPRRGOf/hOUpJ+flCNr1A+4gSC6lrsIT+T2zEAF0paxup2+MmGzU9qmvN/Sf+DLnPmV8KqxtLo8bKN/CDo2S2ufbrcfDp5nz8qRfY46H4L+nzFYwBQxoR9JQ1kYXgLNmuQIH4eCjjyOM81yfViX9JLPkA/LFvlx1s3JhOUofzfePc+xqeySn/SmTyeyYR4Hods7joVWDSddOFPZb3i7qjYgejyrA5/eshrjCFfClOZ4k+SfMmFS4oQd97XGfRtYiG7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhUNRX6oi7jYPZZ9vmKR4M4DZn/IQ6nwNUVzI6+icms=;
 b=N3kdudREfdkE17hA7G4lE1xA5OkpYlq0O7f+jiQgTIYYgfcWahWjngwNjCTFdeI1zjx8m+IIB9CTUNedyCtosd21ttpd0QvgQ5/zI0S4e1RFcrfVuXppuL9r+fhqgMR1h/dfAvSBzkYZLZEMhHcEsAegzk0EPQ66bKL5ZoeSXOtI9TojmWQSEmlC+bOj4ya0gmmUQHwlqGhZ7sGAJyzWEwU5Z9//hW9MQR+m0Y12ynO8f3iQDq+VhAZv2uBPyy3fwrQ6H/BconQOI4VckpRwriBSkINhRAoKX7FKKr93WviQ5NKeDBJWvsh6puc9GgaFl94Db+AK8mZbcCKC4vKQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhUNRX6oi7jYPZZ9vmKR4M4DZn/IQ6nwNUVzI6+icms=;
 b=aV/DQeSP/Q8KWnEhClEX7yko1ZEXaYp7XaoewFCjVP1GrFwjuyMDXB3asestuMjKWjoFNF2opnmvPdjBgIWMMvS2XUcG1H+BSuAOT9AkeqAhQuenN597lwEraHdU6qYjOn/Lhi2i6/67NSTcX/aao1nb0YQkcrKRhObUigaIAv4o4KEGOi8u9TUz9K9ndwA/QUixGeJ4bLcpbEaQIP2TPVRnR1Y4NnMchZA8DelOYco+L/ZasV3716DSd9X3sEFcfFMFSzXe2/Wnxpr2NsstYPleSsE5k/dbhbvriEo7k1+ge/ZiEy8B6vYWddi5s+sC9P9TG0uUN78wE4sw+NK6ow==
Authentication-Results: linux.dev; dkim=none (message not signed)
 header.d=none;linux.dev; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Tue, 12 Oct
 2021 16:17:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.014; Tue, 12 Oct 2021
 16:17:44 +0000
Date:   Tue, 12 Oct 2021 13:17:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org, leonro@nvidia.com
Subject: Re: [PATCH 0/4] Do some cleanups
Message-ID: <20211012161743.GB3377370@nvidia.com>
References: <20211010004110.3842-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010004110.3842-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: MN2PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:208:fc::45) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR02CA0032.namprd02.prod.outlook.com (2603:10b6:208:fc::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 16:17:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1maKTH-00EAd9-35; Tue, 12 Oct 2021 13:17:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c40809b-ba5d-478e-beb1-08d98d9bd2b2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5302B2D512564AB158829677C2B69@BL1PR12MB5302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nilXPmHqSwiK8qzGBFlUCdFGsApvfeWZxxueCiXOiAew5MUzpRMJXZqUF+gaFfBqH22AXgIXBqxrAVVKF8YBmGJVlQBG4UNSMwhYnzwzWILYM3znSEdDKsyv7t70wLYWYGROlpJKXdI03BtmUZDHuLHReV8d+x4xjqAWl9b25AL9Xp6RZF2E2itPwBYZbJK7J9wEZ9Xa25NlTsUAYCinjR2gxLgOK4xACsh7NXGN9hqKjqG8acVXA+eQxJOhDVqX9Fzcavj4hWeFu5KXmn5zstQ13RPjt7rKjQk/mbPrsdqGSV9IIIbPWroqTKcONTbNkVpEVoma6RyOx4l5cuOHenOlSPWORfBElH2XTTeo9Jnt4V0vmyUYDDldSYdFPD3DaSJUEZFlRPw4QNZ/K90E17/ECqjs/vHI4uMBDQNyuo2Qrqn7z+/nESXUoM+1fm2AHcETkwlAju+jLt15iXAk9pggnUh3nnlXKnX6lYFNpR4c906oYzNbikrSWj/6KTowIV2AsPEpcqDZOnFDz8o3OCifX6LJQ9ZhnCUXYl5HIbwSUwT3jpARQUA4em9TAB1rko31nPnrqIFkbpHFR36RI/MWoj031U78u3dvDEKqgfGtSx6alsF5AYI/GeHpCIk3ty3OkdUJWcbKjLtLn04cRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(6916009)(66946007)(316002)(508600001)(2616005)(33656002)(86362001)(186003)(36756003)(26005)(38100700002)(8676002)(9786002)(107886003)(2906002)(9746002)(4326008)(4744005)(8936002)(66556008)(5660300002)(1076003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xVna+vLjOMih3vRvmKM8sFW4onU6BngBHcpIY2kxU3BGX15zLAg5eWQnr/UE?=
 =?us-ascii?Q?M/kdkSrkSi+WRxQ7tfd5BuN80qfqFUE6SP4IUe/i5vMIoXt6darTAFfvyhpY?=
 =?us-ascii?Q?UzgHtCcz0qhibNQmdWCWc+AjCWQbXMI7Mgf1Yo+rxooLy2zEVWHe7KyR1PlF?=
 =?us-ascii?Q?oJw+szIYX5CsfKVOCkYiuQqOlGNoGbvmcovAD+4aS4Z8ZGQPQeO/Tgyp3ZpO?=
 =?us-ascii?Q?bGigTV7i6dxkgpb2kQ2BbFDxD/5boHBZynOJmJl37jX9mukMdUHizTpzZWAs?=
 =?us-ascii?Q?PLlxBPhiyMSRt10PWHkOth/2xsAnrPmRLV/d+ZVsA4XdHAPElU0tzoXJt0fI?=
 =?us-ascii?Q?cfXgfa7Kb44gb1HbJggcksfggZ9DXDV+0XFMF4oepAeCyinQh+1uuqBs+kVc?=
 =?us-ascii?Q?4MAh+nOV2TJfgX9ySeGiybSAGjtvjTMKwzcdKzbyiIJLaVbl73CJlzU+lOqz?=
 =?us-ascii?Q?yQ8eEt1bZt+WtVBfNYvSkVsLbJeqH86x/1hcW4zYq23M5SODBv9sg33TggRG?=
 =?us-ascii?Q?3cOV47u7r0yPxg32Toq4nMH6uKV7tSd3NX2lwdF0t/GIuagCXJM2LGzt09mG?=
 =?us-ascii?Q?mljRak8PItQPyBfq/QHFyF7sjbhd7XM3atYldU5BpSwzkYZ8rEtYc8/Wxokm?=
 =?us-ascii?Q?4J/VCqu0nlde5Y0uWEmX+LYKJ8hYeDBYqB25ApKypt3CbEFjVchV6Pj0IN9g?=
 =?us-ascii?Q?ud0v0FWqtFBYCfRmW5bm71hOO2OSwdq8i44evkgMXzttVpT1iExbkapayFkR?=
 =?us-ascii?Q?ERzqzGelb4+kkiqCyNAdnApgC9kkOEh1BaMw5iEObja4PcXFZsMBUG9tky3m?=
 =?us-ascii?Q?1eUj4n3n/iin6czKLCtrKRXHdGQacM1MPsib0PKIPAAVDJPJem3kxHUyqokE?=
 =?us-ascii?Q?WNU1GYOwvLvxvkxffWfG0g8uTVeRO774d+rGlWgE6LZMxIKjYMzPC3NvZpTn?=
 =?us-ascii?Q?gHFwD1mbKFItZBuxsGjce1gnzkmycLEpTnW9cEi3EhTISd0JuKNaT5vVDMH3?=
 =?us-ascii?Q?CCjhXCcjYJZ9rshiDAVlYys2ZJFlMIoHjKQTWQe0G9fAQl6M6y18FjHyRK4e?=
 =?us-ascii?Q?vThQqbwHj6etOZ/aH3xo7TzwbyiN5z8yGf7s+mPcA/pD3MLGLkQc0uvojjbG?=
 =?us-ascii?Q?3tioy5aokiYsC/KA8o+j6pqN/bsL8wcXCWPAub0w586Z0ahydrJDgiuXnqzM?=
 =?us-ascii?Q?4ixtgbSnmfX/npkjwkSaXNoAD32HL8fJlYAhxevFKCHZ3KdGG0omMeNsg16B?=
 =?us-ascii?Q?lJnybndupX7HF5KY2y+SJkc9T9AdZyi2Dt3ZFtCmo7+iHYGFUM0iIOfiA/8Y?=
 =?us-ascii?Q?h+CgR1HeI5LdtOhJJeduRXeoZSUfpOh9KLIjedWTmQPyIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c40809b-ba5d-478e-beb1-08d98d9bd2b2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 16:17:44.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QW0BQb6MwcwOBjkuRlSWBSwvIjwRJ0Xkxsv9jZWZS+j/HKyF9djpBDUvQU4Kanlc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 09, 2021 at 08:41:06PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Some functions are not used. So these functions are removed.
> 
> Zhu Yanjun (4):
>   RDMA/irdma: compat the uk.c file
>   RDMA/irdma: compat the ctrl.c
>   RDMA/irdma: compat the utils.c file
>   RDMA/irdma: compat the file

Applied to for-next, thanks

Jason
