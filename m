Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5582D39EA56
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFGXsC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 19:48:02 -0400
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:35532
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230254AbhFGXsB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 19:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmPMZUXg+uOKx/keRDTywcSFDSNHRJRt4LAf0eDfW1DvMoHyAY+5DZpG20vG1TM67SV5Uq7kw1gsMkuPoyU9Q+F8EgWIL1m1ZejAO63ScdBucy2SpPALDxgy6CPwQVosTovDxHJn6dK9k5UKv+s3fa/3hUQ8vnbUK+br40UsUWBTNx/VHVAEo8vZzstLGEnFiDgojmpCmeBZzAhMD3UOiD+aVWJXspnYKHA8A9BCNFbKn7+kOywFztHueMBXSuXx3uDpB0jMMZzgbQI0FTcj2WJvoEYbgibJaen8BPh0Ra2hc6BUVHW0BYFjfXzP89800qw3pXTvjxHQbL4eajF6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYQ5vM+dPuElsrkdt/Xqo8YBFk7W12T5Z8AFp9nsqys=;
 b=GVqjam/ERsUqZoa7Cy5Sq/iDH5vj5F9PlEloQg+Pq/8G97LDMI1aYFQXoLNWADW60EUa1o255NFXOo01a/3Jwx7cipKUyVAbhw+aIdZhD5UkpAuRI81g/ETe2eO2EVgYtHsSUOLHPIKhV2N0XUM35HEeD5gwwhuwsOtH7dHhnw37f62aCneC9RKWkpKc482HzK5+azGPGbfGkIi0LpUeJz8dta5/uBkclStXDsdSVjJmZIbaTMqvVM+xI8J78mt0Ha/ZOXcohMhHwyjyDn3rMWMeOL++nFtk4oDWcjNrqP0NrBeQ0iTkjiHpI6xuhyJKSvCiDE2X+bg1dQEPQY1SaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYQ5vM+dPuElsrkdt/Xqo8YBFk7W12T5Z8AFp9nsqys=;
 b=AHLuPkW1erzc9SBqOEgYixddgZoq87vk8xpr8S83A1P01DIsuUUryDoILaS2F1Qcd+U8urPX4NhjApHv8OwSPLTnjeOzZT/Voo9S9Kz4RDeqDKjDOydLvDH49aeh+PgCKLJKogOqr7LeiOzxFgrnIdoJU0tdl5D8nlh+B03E0GRdoShIXELDXsnwKbgXUzkNICjykzjDDZEDmqiftYBcalhsWDuQOsTkaUp46YqTpTaasFrIqVtROhNS99DRHB2NvZlKYc7yYZnb5kqk51D7ccriefKNozy3e2HoRRtem0sA2uEYckf/Jz7yJrNJ64pW9kU0az2EIDqSfuTmCnQW4Q==
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 23:46:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 23:46:08 +0000
Date:   Mon, 7 Jun 2021 20:46:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/irdma: remove redundant initialization of
 variable val
Message-ID: <20210607234607.GC840331@nvidia.com>
References: <20210605131347.26293-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605131347.26293-1-colin.king@canonical.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0307.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0307.namprd13.prod.outlook.com (2603:10b6:208:2c1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Mon, 7 Jun 2021 23:46:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqOwZ-003WdM-TE; Mon, 07 Jun 2021 20:46:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa98681b-c71f-4854-04e1-08d92a0e6c6d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53495F1B07090FA016D8CF5EC2389@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCVP1lqtTSnZqwvedTGpV49DdOMQlYRtJYkC7ALEc6sd/p+qmYtVSInBgXdeXjdLRdPjcRru15RSXUWhRd6BLcn1eKUWM1Rtra/pQnQ6FiJ31KBcknjanGYJ1/OJemqUzOp+NBvVelGtCA+cDSXxNWDbg7L7ZCwzL5m+WiksX5Y/q+skVBp8zSY9cpaQNh3Xr8fH5146UqzZykqDFFhPzngxsLIP8JMeW/d6Lz3Ils7Tv1Cj+vv+d1cy9g4XqCMFqj66LTMd34ZidwtOkQBmtJxptvWxH267aqGmvsNrosFmifPbltVxFwvLWFw839W62LgCUTrEOVbM3ciMVNsfOxUlw0/F7VkRe5Sr2nRGmiIlLOshwg3wAkt2jPklQfeHIJyWItnS8DOV33FTH4RkZdyxnC/D/NV/r+DsugBASRp9HIz0vyV0nRG0UJKFc8z/2zQpEQbkdd+yPXIflEs6bANOKGBlWfr8zbJIKmsl2QlAfyeQFfOpB+WXkLjn+q4hWDUalhkHpWFYqcVC1C3IncNA8EV0ij4KqOp31WSBWSUa/y9faKCMLJyKzCz6mNNYtY6wSVSOMawz/AXERsfcdlV0OQ1DbNJQy3SZBtpy9HQVb6TrJ9geNwf/joXKy4c2JGWQlCTtovYiemfrpL08QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(66946007)(426003)(54906003)(5660300002)(4326008)(38100700002)(186003)(83380400001)(9746002)(9786002)(6916009)(1076003)(4744005)(66476007)(8676002)(33656002)(2616005)(66556008)(36756003)(316002)(26005)(2906002)(8936002)(86362001)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PCvSKopHkyds/aGCpK+fQNiobIUfWmSc15Go+Fx4bx9F830nSZ9O0ru1xdFc?=
 =?us-ascii?Q?ZXiGsqJvgQsO75hxcO5UrL5JI2RB6MWDN0fNXDlNi4Ty90P4bUgaU/mYGN3+?=
 =?us-ascii?Q?WuLYT390NiheeWPYK62nbjLl5uBqV2MdmREaP6iWvQ97QDaNXQlqxeLaWqrf?=
 =?us-ascii?Q?5AhsjjyvVgudnSE7HABpL/lHZ8niifdwPFrA95XLXVm203DSVuQnS7VekxVZ?=
 =?us-ascii?Q?5QM9Ri+59f+VnuV7y8tA23eH2y3zmmr/xWSIb7qqJQjC0/RkTUlbwNfRWM80?=
 =?us-ascii?Q?2hMJMU71xEpDszhOPZDrCrVEVREHJh2lEXDy1g5X3i+Fg611QLa9glEJW5z0?=
 =?us-ascii?Q?JHAT0db34s8WvICAkwYy2aKlOzgwG3rofBxdZCKyb9mVI9+MFz2WcNVadGGk?=
 =?us-ascii?Q?cbPPzNKpjLw81cs4QpZM8OGJl8WDhtGiU1dCmJlqvlftmBuK3Wb3fdIAuI/0?=
 =?us-ascii?Q?wURHeMlTzLBc1l3/59iqAdy+4SrJvxMdmTTyhIvrTiekPyJK4SU2VEVG3E3x?=
 =?us-ascii?Q?eWMpLC9TP6itXDT1UMt+IsfRfJwr505ksPvGHNXx7DcrlioTxsRyxMtLkNEo?=
 =?us-ascii?Q?KYGdLPV56Yg5hUxXZD1x3PZpFQGKNhHzKarDgpO5FwyJfNaadXXxr9vphNJS?=
 =?us-ascii?Q?mYHuuLq7AgvxfLbIrjo2KVnlk/bHkB/jJeihuPBQFdELxSji99olXe2YmdGx?=
 =?us-ascii?Q?N0Iu8cJF9Vlof1D+PyOr5/bdoOphzxfgP0YE91iQcCKBdsqEHF4/KJUdCIYN?=
 =?us-ascii?Q?8+lYwhO9rzElT7GD95wcLibzJ/VVdXie+hDsV29SY1hUVtCCgDJQe8j6geXZ?=
 =?us-ascii?Q?lewMaxZnuorP25qUrpeD4IEB81OY207/rs6ijBbVWS+Ys8tMiDOT8p45nPJE?=
 =?us-ascii?Q?5stSKFqOLVqHrhpvs4lKdknk9zddhOG5j1iu/4whoq8Tz7JRBIJEZQ0O3iDq?=
 =?us-ascii?Q?JVBKXKf24ZkaZJ4EL0RTrY0B1ZN4N5sYbyif3za/diMj1zynFA7yFMA3JGM6?=
 =?us-ascii?Q?Upl0oE7RbSwvEwY1Y2RbBJ6yfyfSSa2r2CRgArqdTh9iykHuqZY7ueUraSJT?=
 =?us-ascii?Q?w2dd5nz11cmDkASos36PSvvBxdE1xD9G+YtMYxr6Pd7DtfiYaau4gBTigr8J?=
 =?us-ascii?Q?c8YX+73JLDAEAdxKfcmq8QWmDaDNuS7PwjC57qzdxvrwyDj1A29o1ORcADEa?=
 =?us-ascii?Q?sVNqxWq8YZyOoiWaZ/pBLo6HRSFLERoW3MxMni4VtT/LFz+91M2EOi6kqMcn?=
 =?us-ascii?Q?de/9jYphg8t8GC14+U0mD4+25Id22AY5ZFuSLEvYou5sttAt397AppNtY7xQ?=
 =?us-ascii?Q?oUST2/yy0VCvbxlBN1Mrn+zq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa98681b-c71f-4854-04e1-08d92a0e6c6d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 23:46:08.7952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkL8p3iFJ6v7m2quX1qOhlW9xfmsXzeY1WjPV33OJu4BvFPtcKSLzf1K4QHljFqm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 05, 2021 at 02:13:47PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable val is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
