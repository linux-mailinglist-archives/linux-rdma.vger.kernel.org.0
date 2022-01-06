Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9215485D4E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 01:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbiAFAkM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 19:40:12 -0500
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:11073
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343879AbiAFAkJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 19:40:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzDKLGTFIRGsA53sACcVlCVXDvQSBvuLeWEGlbmDM8jehpkZL8XzX7wOrNtEkxCpUg7L7W/dKzI1nQZcoQgdrjI1b/dp9x3hViuMvtpdtg621mRhVGg7FL3I+BLTSvF4Z9aCX+ceG7ifnKHvO6+ycanWTiRcUZzlu/oyKyg8wT5rM+qyTGU9msdPjOl+4Thqoq+bOWZZMSveHWySpI5aUc4OH2yFOYQ+1WewrTSOdctFF0CcBgzeN113FqsfYuUzZNFdkaVtH+HtkReILyxHXNwzrlqhR8oC4BtwoeO/ECHWFq2RW7rxif3QZ6mlFp8b6aMApSYAvr84OTP3la3zgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+9NYVReebDOFL71JXwH7GMyWLmvFRrHvl7KgK/OOnk=;
 b=mYPBJlxI1vdoPYNI8LA+MxHS9FqAraftk0XKxIhvYdnBlyHm0v3BACBdY2TES+NfZUat6cmsfM+5Qx4MMWshMX3y+KOvH2dRteBdpu9e/qpKPjAelJ3JUN+OwcgEl0i+y0cEO4CbFm1KvhNmYoICKywoO972ojMOgxJR3Boo9+sFfkJybQf+W2hh3V6JAiJCQJRk+1D34+NDO5nlmbNpfr/r3n9iqUjQY4rF9J1SojWuFmwYetcNZ4PLuNB4+n+EMB85gc2QLeVowDbnBteoZa6erJAlx3A+oWtMHyONjhaCT8VVnFuT/4KpOfAUrDzq+tC01lHOAXzLWNvPEEl75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+9NYVReebDOFL71JXwH7GMyWLmvFRrHvl7KgK/OOnk=;
 b=pg6QRDGLu/mxfNrhg+k3FBamZ8PaOt21Q0PIfIid3YlT4anlZrD4QiXRjUsX8+LfFUHZG6f03nz+XcLifyqiy31sqGbIgWVQUGoZlAhm4HoCvivBv/6jq4FJE9CxOVFVLx9WdAOLLXSprIqiQ1aDOLMVFDj3Qx4jMgmso8OrC93nT8Pc2d6WO9+zB2aoOFYlTeaFksaBM4zVoF4ZYZipPxbO28IvfDYxLg7GzNI1KhEhdDTI0eyX5eh7MyqBOtVhmXXsozOrbexY1Qw/C84YWiEmdxB+A/eklAbeE45n4fLfNYWSsXuZXDqtSdLtIaSKgT1R+qItLnPn1rpjl1KmDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 00:40:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 00:40:08 +0000
Date:   Wed, 5 Jan 2022 20:40:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev,
        rpearsonhpe@gmail.com
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Message-ID: <20220106004005.GA2913243@nvidia.com>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81eb59ba-3b0a-4b9b-b9f1-08d9d0ad16c8
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5539BE270B8D414D7CEEDBF9C24C9@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuU3mHECsAmZt/O3LhyRivD7S/AOwRwE91fmm+XcxkRU+PaCTwATixuBO7Ue4XwPdY2wLx7PiDI3l5C53+7EFHJlvQ+KFhMeIPRSccH9uYiaeMzpSKJpRwsBxSnvv1jhq1plTjGFIGu16REd7vrv31btMgs55/mDFGqpXawkfwNiuShamfE2DOAPLnDgJ9G1qdpqefy9UD01/VqWLzHtzLGpMwTOM785Ch6lUEPHlFCKU1F8oIZv/zuv3740IB5ssc94y4IbZa99B8D6XJ8wKDy/1XJI4qHxZrWBnyzaaaLBYDXNtXlMYBTGUI/iSTQPUDbcnGSZffkQz4ZO9Wkw4scFN5D2P96W4zjR+4yje/NF0NYpMdDDhybcs64hUE2JcMH449nXqCt59fdruVmKNs9asM1a9EOSlPyZ53KXvyAMR8hxKYuEyfLGc/w1ykFKemgOS72eTbaBsH65tq1sloYILZImNB1fxkm3tGtAKfhAy8Hp9pR4uo+z2bQjX3AsAiIocmgAUoDiLBEdDxA+nmB2tNl20/VK8grtmSbUbcM6+d+X8UwxIn1QNBtbvZr+I1EzIe8LM28/STLL32SDHMideOokMzIIMFKaYSIYNEN+0uR8knk51ubQacRg5JTrKUaK1zDiKYSB2QuYwwxGPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(2616005)(6486002)(2906002)(6666004)(1076003)(86362001)(66946007)(6916009)(6512007)(66476007)(66556008)(36756003)(5660300002)(508600001)(186003)(38100700002)(33656002)(4326008)(8676002)(45080400002)(6506007)(83380400001)(8936002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ppJON4pOAkjL8gY9MOpOunwfbqZUuEM1t7/tnEJFtu0AWW8x0nNdSTCZjcs?=
 =?us-ascii?Q?ust+b8qpDdggXnzMUHhdJMZJ/z6oTNFakfPgGXVrsTrJDXOJIa/eyRvHqRz9?=
 =?us-ascii?Q?HAlrzDWLmUHWUqiEP0O9fUoojr9BNNvveGYhvplw67lNlMzIyShVm2VSRGyb?=
 =?us-ascii?Q?IaWt0zF4Ed6s85zLqVtfwIMQ4dIWiJPwZ4kLUfOSumCKS8OTdHAOsGR/Y7LK?=
 =?us-ascii?Q?RHD7WSLMCLtYsnxvflnRAfEzdml9LHHqYl28ukklmRoUVoo7MIvUKA+4ptZB?=
 =?us-ascii?Q?SYRlX58A0iU8ozO0Hh3o3KBPGfmoN5XeOvXboIV3Im/JDXMjjc560KMfaW2v?=
 =?us-ascii?Q?ULjFKqvVTiUldlKKMsDNkalxdeuLmVFptlTvbMtPLzMPuSUT8SQdFLbouFI4?=
 =?us-ascii?Q?bk7yFwvSPOOuRLvr6KBgBJnED9qPLHYSzUZNYKIW8N2GI1SG8YqAytoxXGpe?=
 =?us-ascii?Q?lTPBnHmB5YlALJEzpv5Povej92MVqNXb7spbAjpvlvTM598WOV8W+X/pMDWf?=
 =?us-ascii?Q?6WZTTeCDejGn6z8yf5Cu7ZL0r7BFa5izThFHmtE5MkeUx/rmG/iA/V4Hkhay?=
 =?us-ascii?Q?xUnz0xBReLQryqBgcjzcjipKYLyp+hQ5t8JxnN7VWiQJcy6MkH0hWkDEDdrf?=
 =?us-ascii?Q?K9yqRkT9zchA8qhgp4UpD8Z2qK6Z5n1d77RYXbd6NCI1SUHYMyfKOg5M/W/K?=
 =?us-ascii?Q?QYIP4USGKnJsdg+fC3O0yc/vk5WRZD5U2w7iTNBn7H3VoSyETnHzPNkgaE/t?=
 =?us-ascii?Q?YMrf09au6EWmhUEUuz+nAgI8EwssE5vDyfrGCzcZGiZjgUmYh82nxVJCAAyI?=
 =?us-ascii?Q?m38J1wy0Zs153gZzFz3tPpJXnrDJrqknvSXwR2Qg3oxUnsB7fUMb7VBq2+2h?=
 =?us-ascii?Q?otJmvGTRAdj7R4cK7wS5j7Gyk0NznG89fEZv649XnNMNz3WqUliU8k5dd6+z?=
 =?us-ascii?Q?pR4Y9eNLjRHzX6PQkXXcBsiMy7Ft3odfA4uxR3HFZSXbjp+yJ/5bw+/IrSQo?=
 =?us-ascii?Q?9J0rKyKyhjpmy1EkYk2xqBwmt/MvyH3ynUs7QNa4Lcxzjw055RJMyG53FUdh?=
 =?us-ascii?Q?HbeUodP7bj0gBfFC3V2fkziDoas7kaGU3Qu7n+PpXYso5n0nR3d6/STc1jYt?=
 =?us-ascii?Q?Nn5+EAFERnBdbI23jQBrNeBBFHX+xEowQxAEE3YUeqoLZ17kSkFZBFaFfxYG?=
 =?us-ascii?Q?/75n6xa5UteHo6A+yQJQSb2I8jTtpP4Gi9HuFb2k6zxualyHc9DkDE6q26ID?=
 =?us-ascii?Q?tCxZFY4QqkChOe4ZntLkS3vqRzSdQ0+5b5K0Sz/qey9bYr2x5H/KiHUQUxjf?=
 =?us-ascii?Q?wb+L+PmewWcVKRc/8IghRv63k5wrsi77Q7S5ES/vyqKl2odxJckAR/mlw2o8?=
 =?us-ascii?Q?vrDJvmOAUCiuXBwnf4VuupNbKghzu+HJZ9ikEbM5hl6ZT1pq451pOxDA9TKv?=
 =?us-ascii?Q?m5J7bTgT/cWhmNZ+zm1cO98WDjVu01+VZ5R7c49wVXum1Ply7FICwSJZfRR3?=
 =?us-ascii?Q?HwcwUSCMG7IIXD07TsLLzknJQvPjzzg2WhJ5w+TnWCH5dRLg/II1yw0q1tW5?=
 =?us-ascii?Q?EwXDTgA5/1P0RJZX8BE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81eb59ba-3b0a-4b9b-b9f1-08d9d0ad16c8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 00:40:08.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqK2UYv+dHA0Bw+92V1rBPwCXibVWlxzmCKGVJEtu1MQUIv/CIM9JOG92EdE11Q1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 29, 2021 at 11:44:38AM +0800, Xiao Yang wrote:
> It's wrong to check the last packet by RXE_COMP_MASK because the flag
> is to indicate if responder needs to generate a completion.
> 
> Fixes: 9fcd67d1772c ("IB/rxe: increment msn only when completing a request")
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Bob/Zhu is this OK?

> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index e8f435fa6e4d..380934e38923 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -814,6 +814,10 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>  			return RESPST_ERR_INVALIDATE_RKEY;
>  	}
>  
> +	if (pkt->mask & RXE_END_MASK)
> +		/* We successfully processed this new request. */
> +		qp->resp.msn++;
> +
>  	/* next expected psn, read handles this separately */
>  	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
>  	qp->resp.ack_psn = qp->resp.psn;
> @@ -821,11 +825,9 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>  	qp->resp.opcode = pkt->opcode;
>  	qp->resp.status = IB_WC_SUCCESS;
>  
> -	if (pkt->mask & RXE_COMP_MASK) {
> -		/* We successfully processed this new request. */
> -		qp->resp.msn++;
> +	if (pkt->mask & RXE_COMP_MASK)
>  		return RESPST_COMPLETE;
> -	} else if (qp_type(qp) == IB_QPT_RC)
> +	else if (qp_type(qp) == IB_QPT_RC)
>  		return RESPST_ACKNOWLEDGE;
>  	else
>  		return RESPST_CLEANUP;
> -- 
> 2.25.1
> 
> 
> 
