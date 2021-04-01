Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E954351EB3
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbhDASpf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:45:35 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:49377
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237434AbhDASiq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 14:38:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIIIHS7HZN/IPBQgu3+F69Uk87j54RL+Vn0CFAoBJTC5kt0/8sXkXUrnZxM5JZcjRSspto6ULzYNxeq117JaEq2andiZ15vpcoEW1XLJTvhi9VFncLehqGrWHTwFTZYuYX8dqNBTdGtIEXn56Wz67kK7ZWN8b+TRIubmjp2Jidfj1QgTP94Y/t7QQ8ym2a7QJyDTBBzunU9fYcD/iE7CPTDbTR3gYsFgitmb9zRLptbGJRZ+kEcBSJ/wN4TL4kBnjk9X2KQ90UcK1XFHIIy8szeQFiOTYrCjjgsP107FLV7mDLGV90bG8BAq3K6eI+7WPxqw1Aj127FzfIDOBGM+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShMBM945pSstYEyehAc2F4AMwSIpFPx6VZXIC3j8AWA=;
 b=HHLn2DXZeuiRycDqmFz0zmg+mr1wRtQenF7uPzFtzehQbsf8Zau3N9A1DPI3BKeBhxtNQuuiNiZ3PMCfVOgYS0cQvXqD17nBLx7bPjbJ3NA+yU5CpWPuvEM/jEApcI9rFo44pLmYf1JV0hbvdJ/rL6dSgvDT+U8nppwpJQG4ZESV35BFrVBiBeRWi6EgtPEtztC+Ok3NImPUCmpY2RZo20TvPR25/n/b1ifwYml1W1KS5XpgDtJ8LU6whTl6+IhkuysOeUeGrqKBvR1UF9EbN9eOeKNOzHef+YZ7T7jlEacNJpF0nsYUKFQVgPlFbH5+cnfo7OjHyer050NJC79tFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShMBM945pSstYEyehAc2F4AMwSIpFPx6VZXIC3j8AWA=;
 b=aJVqn0o4CglJ+2XMEsAj+xw5W0M40M1BDQ4k/2ipIPN7lBHUJOkpQKxvsbE7LBDj3dVQjJa/xHWqVzNskc7Z65iDeaDn5UUZUjKg4LPe3UjTheU4SiOpLFF/kpaioYkL/AtfQi4246F5Lu/SJAG6+BC5QiXim2zrl972CsjBtZttC8y4ZpY1BoDh+Ik5rv6vI40HcbDh/iejye7I3TNb1EMFKHLtPNoxe1Dpc3SUTIXNyKZwNS1vv0YFpp6Ew2DZlaN+2DKZUfnC80Y/QG7X08gLvDabksxCeGJTMLaE4TLI1ytDw7AeRXaosxtunIWMMHXh92gtxs04yaP7hcz9eg==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 18:38:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 18:38:27 +0000
Date:   Thu, 1 Apr 2021 15:38:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>
Subject: Re: [PATCH for-next 06/22] RDMA/rtrs-clt: Break if one sess is
 connected in rtrs_clt_is_connected
Message-ID: <20210401183825.GB1645857@nvidia.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
 <20210325153308.1214057-7-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325153308.1214057-7-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:208:15e::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR17CA0015.namprd17.prod.outlook.com (2603:10b6:208:15e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Thu, 1 Apr 2021 18:38:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS2D3-006uCy-JZ; Thu, 01 Apr 2021 15:38:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81315a75-fb03-4fec-afe7-08d8f53d5692
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB351458006CAFEA047FCC6C22C27B9@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbJ8ByT22QO2PGR+ZY9sewclATMy08EGFZ9c5308MD9pJ68M/puQHNzSoPPl9dxubovDUigJWhwBbqr1TP40RhaHcfY1QorQBFqLw9gkiqxEV/a6rFMwh+EDYdZsIaMVJfYmvR4x0qPT/NS6YHwIp3LjZWKjQGxOCbzb3jv5LLHFHliZ3eJOaEHItxV2bigE9vIgSUkQk/qdIdIWMG31PvPKYaS2xTl6jABexmCuES1XUHHMy/1LcJtVeVON8fq08Csr14qLKMZxm78+JFXvMeX2ZVjdzdCWkdQgDqiqlOozDPjzC9FgzF/2Syizmmm6Z5VUlKXj7jK/4fSyS2zF5CinsfnjYQ7/ifl4lKQ++wxr2sv1s1o0yOdljqGxBThDeYlPiIAMv6DyQrWtn4i+4YbsVcbrUH8s1/jW3XuTj736egpi6x5rzCjt6zHfvGgqjJ0eLPabIthJ8Wn28BdFvI8gunTbFWtuyfkTqJwhVihUWGXdTrWCUXSEQHdVHIE8JKrbaJH6vaSXk7HGwwntfORXEuuqX+Wvc5p1sZIAc3FAo6WDml0A2tOG4KyWqaKmkvcfSeD4ljjjBrF5kz1VY5eYHmTfHuxKnlbiy//ckrblXpmnkUzwmmtmfoLM4iHWdl+MwgAgQ1dc86AL2KmenwhHheL7x9B0ZNEMUKrJcXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(86362001)(8676002)(6916009)(8936002)(83380400001)(9746002)(9786002)(36756003)(2906002)(38100700001)(26005)(66476007)(5660300002)(33656002)(7416002)(66946007)(316002)(478600001)(66556008)(54906003)(186003)(4326008)(2616005)(1076003)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KE4N4QRPI7g2GqLqjWgPRw073lXhTpb7sxwcgAqJF8jXJU2Kcv7XHvtcDGkp?=
 =?us-ascii?Q?1gXANJ1lEeTwHrLTTqmCT9N/DmrjsxoPfGLjcoCNWew+drunFy4jLUE+kFG+?=
 =?us-ascii?Q?De3VWDWJgI5Juv68w3m6xol5mA6F31zCHJTnEgLkGplxlHrrpoYcWiEPUDPE?=
 =?us-ascii?Q?XyoWtjQtRTGJEyFi0DRXBWpB9tz2J17unyqASiyOUA9JoplS60LNdCoVeWQt?=
 =?us-ascii?Q?J06cKo3tdKL1ZYRlG9l2yo9APM76ZqAPgVw5XMRjERrq/n3JCsLKbqBLLsWD?=
 =?us-ascii?Q?qPHmAnBaZpwYVQL+xm7iNKnk5lKg1GDKkBQOkRUs8PEt5bkCnVIILGUDpDzm?=
 =?us-ascii?Q?kGysXtxYY1sS8T7Iq+nNULrJre05LvzRQBFYwymVjFi5JjwlEDktrg+YD+h1?=
 =?us-ascii?Q?544EUaStHrwIJsUkZ0tvAMvTPiz4H2kiyxfSbxitpYULk61lS/E+00aAvWpf?=
 =?us-ascii?Q?yZmVYcEtpPAQzvyppd19zs43yDQtDYpMNrnOCJFPHGQEHUltDrYXEuY3j3oX?=
 =?us-ascii?Q?+H7fMl/X1jQ2bC5O/m3FcJq33+YWIoR3/63jN/hMWoCq9s651MIPJFMEH4uE?=
 =?us-ascii?Q?o9Sy2hx2S604IkjR0L6GUGFwiC/q/I9wDYfJWcHQtmvmzPneRYoShbtRRS9V?=
 =?us-ascii?Q?67nt9A+KbOnHnEEBqGwaaS2T8uvVgS+w3MdxWhzcfsNujj0/lyHXlrSbqMGH?=
 =?us-ascii?Q?hXDRkM7dRs5xtmhYjW9+WtEJl37qIS+jwxWcNVlvX9WkJQtSPjwgFxFMeDeh?=
 =?us-ascii?Q?/Whw0nGexL6DNSk1tLcimpEnVe3Y44zH4IseXgrUV/bi1Ja8/MnatTedTnGE?=
 =?us-ascii?Q?lttRPjM4tn2+27SZfIjhJ2XmYZ32CBX9E6S5i4+1dlKrqqbZ90vDiaDJdSRB?=
 =?us-ascii?Q?G2hB7VFvlkjThVNzze2S7Ljyk03HDBikREtoO4ULzxm6t/9THWT4d+4w+lAE?=
 =?us-ascii?Q?TE0z656XyI2sifOv9eoAUQD0cHG4w0tRTTvPmTGonQfaRxHZg4+sajKP6NVb?=
 =?us-ascii?Q?UNWEihLimROaJ62zfWaXfuva/gS1fCB2ykgFhwlNZrPo9NYB9iPAji9jut/k?=
 =?us-ascii?Q?hyZHJiMMEFdyaLeok2jsakytp2/yoglZNwqnFTi3R/POiLosOXdmIBpqV0r4?=
 =?us-ascii?Q?VfRYHl7I/iESO5+772yL6WmK/NrV+r3OYUlQhNbCRdfgDKkk9VLrEb05AUix?=
 =?us-ascii?Q?oBnDPydIgKavBcJ3RYxk1IM9ru59TCGYDbm7W3WD/MI/7tNjEvV5vLHoDaEr?=
 =?us-ascii?Q?RcV2iUepqrdZXDitqyQxXwQkDJtx3khDSCeI8BX5/U9IbpeZnDpKq/pExDQW?=
 =?us-ascii?Q?e3Q9M8JtpyKNVHxoArV9PoM46DKsgnniDq7AagPHYX1BNA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81315a75-fb03-4fec-afe7-08d8f53d5692
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 18:38:27.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2af7a6rRhzpOLhCvFTiujqG1RVmy9Frk6Bvy+j++9p1TOn4UFMvmqqlkDjc3I5cj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 04:32:52PM +0100, Gioh Kim wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> No need to continue the loop if one sess is connected.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
> Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
>  .../fault-injection/rtrs-fault-injection.rst         | 12 ++++++------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c               |  5 ++++-
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/fault-injection/rtrs-fault-injection.rst b/Documentation/fault-injection/rtrs-fault-injection.rst
> index 775a223fef09..65ffe26ece67 100644
> +++ b/Documentation/fault-injection/rtrs-fault-injection.rst
> @@ -17,10 +17,10 @@ Example 1: Inject an error into request processing of rtrs-client
>  
>  Generate an error on one session of rtrs-client::
> -   
> -  echo 100 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/probability 
> -  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/times 
> -  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/fail-request 
> +
> +  echo 100 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/probability
> +  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/times
> +  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/fail-request
>    dd if=/dev/rnbd0 of=./dd bs=1k count=10
>  
>  Expected Result::
> @@ -72,12 +72,12 @@ Example 2: rtrs-server does not send ACK to the heart-beat of rtrs-client
>    echo 100 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/probability 
>    echo 5 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/times 
>    echo 1 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/fail-hb-ack
> -   
> +
>  Expected Result::
>  
>    If rtrs-server does not send ACK more than 5 times, rtrs-client tries reconnection.
>  
>  Check how many times rtrs-client did reconnection::
>  
> -  cat /sys/devices/virtual/rtrs-client/bla/paths/ip\:192.168.122.142@ip\:192.168.122.130/stats/reconnects 
> +  cat /sys/devices/virtual/rtrs-client/bla/paths/ip\:192.168.122.142@ip\:192.168.122.130/stats/reconnects
>    1 0

Why is all of this in this patch?

> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 4f7690137e42..bfb5be5481e7 100644
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -51,7 +51,10 @@ static inline bool rtrs_clt_is_connected(const struct rtrs_clt *clt)
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry)
> -		connected |= READ_ONCE(sess->state) == RTRS_CLT_CONNECTED;
> +		if (READ_ONCE(sess->state) == RTRS_CLT_CONNECTED) {
> +			connected = true;
> +			break;
> +		}
>  	rcu_read_unlock();

I assume this is the intended change? rebase error?

Jason
