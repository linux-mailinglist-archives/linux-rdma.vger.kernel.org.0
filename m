Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CB64B8F99
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 18:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiBPRpI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 12:45:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBPRpI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 12:45:08 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DC52B1010
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 09:44:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vqqpx7gp+5swPjjIHUgan+E4Km6pCX3WPj8WlE5inw79b+Kmt1C2Jg4VBoy5tSN/t7vya0U71qulziTHvbSZv+YencFaUYG1bpkPOZ2YB/VcHp1PiguwlD0H8CSgvvqZGqgEZyUvHM7giQWqwK+LB8KCwr7rlXa86NL7iCg/bdhwUSeqoP0IRbB2XhFPg0YUYXmRpHyblQfx4M4fMGdPpobD2Be/Cn2pHXU8bnvqcHdKrw8filgC/PB9OV4H1dNUcO5jkDiufLUsDb7dx239g5fuLaPi5Re+1qUEMKaarRLhxQNBC7hd2TnbmjnF68sXtrmaXY1DvpQf/OTGsBkSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xl1MrP6I+UbF0ysQhCNl/rB2gX6by5axEHcvAwZm04=;
 b=b7u8B77wO5H2qqsRRms/A9n1ARSRecAzOx/N0HZJFJXLj07rbCvS/uVr2tGPyDAFkbpR5QubYpltJex2/GgrQDlAlwEq7ruLVvby10iPXJoV0tnvbLYcCJcsTvHTZCe09qs5F2KZSnvrFmwtAJlCN55XG/A+LJrreTk9rYePVP6FqqPpe4YXNAGgpRjGlSlzuHhlDqILeZxS+V+Wi1SrNm5xqrQbX+KA4M3q4arCAPssrfm+u8xzhK1rlqnSf4P+RiaXu2bSsUM4/uMf35Gxku4E4TNW+vcsa6wCA0N5omoPPL40SQwvmtfsCvDm0IUWMooVMiEFYmO/e1UTM+pmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xl1MrP6I+UbF0ysQhCNl/rB2gX6by5axEHcvAwZm04=;
 b=rkSge+wIooZ0wRsqPfbSt0kC/xyrqwldqRUwM9rk1Om13eWpQR+f9zrULflgxOitLIFb7ndE8+B8xhVTTJyUVw2aZzmxlgQO3CGZ4OYX3Iumm/hoy+SFBZmjKJ9lNPglTv/RT4tRRbGwlAyyVMWyJo8eK3UBdP8HzAUOzsPCoSYLw3KYAEac+p0/zXJPYGQgOIjI/WlGZVSOedeaYtMsuObtmBF/95fVk3WbB4ZEiFvtHdKjceQ2/3rTe6qWc/d0DzhSjuw1t5Z9yN/0SlmkVJh+tcEUy+5HIXvsHn5b7+/QjRPe//+svoghrZDve0ndE3OUhImu7LVboFkqztjsCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1294.namprd12.prod.outlook.com (2603:10b6:300:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 17:44:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%5]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 17:44:52 +0000
Date:   Wed, 16 Feb 2022 13:44:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        guoqing.jiang@linux.dev, bvanassche@acm.org
Subject: Re: [PATCH for-next] RDMA/rxe: Revert changes from irqsave to bh
 locks
Message-ID: <20220216174451.GA1265489@nvidia.com>
References: <20220215194448.44369-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215194448.44369-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:32b::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e4a2354-f579-4d2e-4c35-08d9f1740940
X-MS-TrafficTypeDiagnostic: MWHPR12MB1294:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB129463036258193827C1983CC2359@MWHPR12MB1294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDXu1lKhRmbPp0s8KNdA7mKNMKbaUf2iOt0v0nHRNt8JwjFzpUjwMeb2xhuGEmhC2D1ww760seSA69rCotXfvRRiYwuZxUna15uj3JwHOO8jUOo2c0oCBnCeZeiimNR9qMRjAHbBMmkdMzwClCszqnE7lFf3UvmNQzi9BFl6OOoOBb03FLa/lVufETgN6TlvKwiKc73ifjy/zldLjSNxGOnpeSwXfu3l+E1XtccBYCgxHMHu9t9JR+qilnqzIakwJvXVZlFgcZyWm9yCXL4UKyISAJTF1COPOdmkCk9qyGFTIDE62UfyCvWi3aVT1DtBH7M0uMpb1+4vTta+qRSzPj4EmjPVe8Pw+B1EnzJ/rF8PWI0y/00jtZ2D59Zjs7VewhBUWsJ2xC8wPoNJMQj2TVDCbS6M3uOdi6Xp99tAajPf4KEmKz87/+zzbt7Nnw6oxM/Sia6qUnAiZ+QDjPIaxT1nupoXbiYn9m1UlR6golOPRiPqYlOY3IhaCsxQUytXpnMpTTy1/Pjyrzj2+04AGAgVfIXQNA4xCdGOUqK0tBpSF+I5cHN8VvmMPF3l00A5tfKLjkfVIxwYTPB0ff9NqY8MWIPVaaeom5f+f4s07fMpgd83Zyuc2GyR3ytaVogzbY4V+kQcfvNoumtZ3+yboQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(33656002)(508600001)(86362001)(66946007)(6916009)(316002)(6486002)(2616005)(26005)(6506007)(1076003)(186003)(36756003)(6512007)(83380400001)(8936002)(5660300002)(2906002)(38100700002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nDgoKrCFcOAsLJq92Sa9ASHN+j3q2VL0TK1nYRPpw+Rxs+af54nVGezDRktR?=
 =?us-ascii?Q?6tTI8jbGGeUTmOQTnIVNl87J/4T7xCYh1eLsGU2VTZ4igTl0a0vuNjo4zV+8?=
 =?us-ascii?Q?UYtn7NB/O1qZpx4mEGM1JKSVEVIQEJ+zFxZtz6jleDhq3sDl2L8t1w/UGODD?=
 =?us-ascii?Q?A5CjbL+k8Os5F6fQ+DEkaqjSS4ZYT6g3Rq+FFYLzm1OMtoTPBsd+9ArWo3bS?=
 =?us-ascii?Q?/LSdWpEH6/HQ6DwygKp/aAVbivMDoEefutZMpCU5kwIu1VutQ7CgjXJBoZ9D?=
 =?us-ascii?Q?TbUm2f5WUBxdnOGv3SOQ7FPL+E7gun241ZNU5Lu3RVv+eT6PnccGJqd9+a5/?=
 =?us-ascii?Q?AawCB3opgWK9dt1ES9Dt6tLtl09AJxW2bmRmGb/uLo9BQybeBp7AB1gQjoLH?=
 =?us-ascii?Q?ubV6xLYpMPJ5gMfy8BkFupn7jwG2NiMq0ZZqfqf6pNd/mTrzDWpJsqY+wXOu?=
 =?us-ascii?Q?wg2AzVdp5MSLhrB/AD3sO5zBrLSdWFzTK6GF8wG3DFZD7Bk9YDGqiTqR5UHV?=
 =?us-ascii?Q?ptpJBVwI6kqQTB/oM4oRowY7y4YaWU7eojhIAVcXxRF5D1D5uUQJBcmhST1+?=
 =?us-ascii?Q?j5Bw605sEHbdptk/T4iHhnPmC5FYBFtnSYf7tiRz39AnvLBOQ8FYUIVCPoen?=
 =?us-ascii?Q?/++ADgICBWQx3/9esVbsWtwpV9Q97EBXC4mPNxkPDfbfhnGVBw6b/IbUuz6n?=
 =?us-ascii?Q?XHQsTiUZnB4gkubSmqBCwizTGQ5mxjnSYc0XAZtZWRA6cZCnxClDfCSJE8vg?=
 =?us-ascii?Q?yG0g0vSy6UXrRW8aCzZBfq/tCEiR3P68UrmFzqbrS0P5/9NzMqQMsWJlUzBK?=
 =?us-ascii?Q?JWuNls0CLWqWp2SaW2LVOnZx6nXKm6j+j1SoisDWWyiz4ffFEQOErTYtpcl8?=
 =?us-ascii?Q?YveFk1LPKUKq3A+d3z9qfguwNq1top7ol11sQLfNMCK6ayK1D0GEstfQZhZH?=
 =?us-ascii?Q?d66+v4VQf/6ma4jCYl+djXybF+L729nGn7XZj0gNF6ZoRTGvPDxr/2oQEWrP?=
 =?us-ascii?Q?RpJRMQcze8k+QeqdCNIPKKiN6JwTx1LJOrvszhmoyiE0YHwTF+A+WNxVEvKy?=
 =?us-ascii?Q?QBELY6HAh+uaPkeImuqJRP/h3NOAArMwRFIjsh3Q7z47pqglzNNLdl6joGLH?=
 =?us-ascii?Q?lrF/nBxZzGGJSQsv17GuSfhuac10GBsOVFgBX1EH+Up/rSdv4HdFKxunDTqY?=
 =?us-ascii?Q?IC3v8mxF5ZmNRq7maw7xequU5SNM/iUIEXHX92LJNYoBTL0FgPOH8bAWUB1m?=
 =?us-ascii?Q?QnEIooOoEQktH7P1M4HUaPkVbcmr5PDIrNtI3Fj4IQ6QhxqF4BWem/vSXQSu?=
 =?us-ascii?Q?YdzChE4c6H1BzjtEtprU9RtXI1WBB61i0bmZEFemOFZJWLc/tsRuUdhPKDmc?=
 =?us-ascii?Q?dBQwfU5AxDHL4oXJ3jbzO8RffOFVF1yAbBe90q3+FaYvYRh1ynTNgfQ5c/Dm?=
 =?us-ascii?Q?w28TpS16b1wIJG9sqeTN6UxA7UJeJomwCfMY8lLybDUtJDwzBM4TqprWXyKX?=
 =?us-ascii?Q?1OaIdChyv8VWMJH+DHWw2x7vCioyy1IbjJdeVRARpNGAuETLoTteTHFbzal1?=
 =?us-ascii?Q?La0jmvyRgenH4g/GtMA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4a2354-f579-4d2e-4c35-08d9f1740940
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 17:44:52.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmK6jpbdlAZ1risX+V1sBLVLIxWsDTgjusToNCI09ATZrNlZqynpyW+PyMwa10as
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1294
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 01:44:49PM -0600, Bob Pearson wrote:
> A previous patch replaced all irqsave locks in rxe with bh locks.
> This ran into problems because rdmacm has a bad habit of
> calling rdma verbs APIs while disabling irqs. This is not allowed
> during spin_unlock_bh() causing programs that use rdmacm to fail.
> This patch reverts the changes to locks that had this problem or
> got dragged into the same mess. After this patch blktests/check -q srp
> now runs correctly.
> 
> This patch applies cleanly to current for-next
> 
> commit: 2f1b2820b546 ("Merge branch 'irdma_dscp' into rdma.git for-next")
> 
> Reported-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Fixes: 21adfa7a3c4e ("RDMA/rxe: Replace irqsave locks with bh locks")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c    | 20 +++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_mcast.c | 19 ++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_pool.c  | 30 ++++++++++++++++-----------
>  drivers/infiniband/sw/rxe/rxe_queue.c | 10 +++++----
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 11 +++++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 27 ++++++++++++++----------
>  6 files changed, 69 insertions(+), 48 deletions(-)

Applied to for-next, thanks

I also rebased the other patches I took on top of this, you should
probably check the wip branch

Jason
