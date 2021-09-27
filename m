Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F69419F03
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 21:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhI0TUt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 15:20:49 -0400
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:39969
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236331AbhI0TUs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 15:20:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwpM+67PP89ZUpD6xuUK0bZobhnhPPjz1nV2BnEO7SYuOJqhHxTSWtUw0UM9YWpOVwoTNVOVdZSfQNXM0JI369zzz7DPR+cQaN5GmrbQzx4GWJT3aW6cCtlaWCwH87CBNRXfG92RWG873A8UkmiRjVe4v6MwhJNTVXokX3i/nojSSycsvo1nBHP5rP84rVA730AT2Yr8mOz6H/oosf4nt2qeYZNCRzfy5oeE2uHnj5LxEM0z3Ht9K2cE8XqlRsbRFuK2YX82XGDSBzcsQQyi8aiE0cF95qW5ipVEEsn56bTEeCklkIFDOvekO7RhDsaJQaY9p/9sdFNNcbfLBK0MsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DVLUqf1WJ8Lyv+Jtd+0+CPItGbjFnIFb8tK/zjVgjM8=;
 b=MZLNDyn5Zuh84LccQvo57fkyjsnyt6yLysxT34ou3nZTabeUHwqE5xtsKuJGAz8AwaG6g5AGxirKL79wEUbqDIrvkQiHSAxWA+lCIJFj6gekKCrMnMKK66Fc9Z2/f3AVea7O4SJABR5sH2kCha0rDKobhFo6B1mXeTGplqEH04fG0JbOKa+oiICrB5z3bQQcVhde8PnfnkZdw480qcRa/sJndj98BmM9cARQWqcbLtJAV8bBvrchws0edVOymzkJ5B0PEIQJu1Nq53viJyLAEHkTETLM3NHAX7A3b8++6reVErw8l4+2jKJ7Kk99OVkEBCAEHKgLEMjR4Q8GrmaWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVLUqf1WJ8Lyv+Jtd+0+CPItGbjFnIFb8tK/zjVgjM8=;
 b=U4/HyH7vPvve6OxgyQzvZxn/E0zM2fISVH/hBHbfSsAbR1SWRtd26IPYwrsApA7HntELHHxMA1QIHE+jj88P0Q869RzktnqB+gtbF5bLOp7NuSNm3qJYT4ZhoGblnfS64DAP2yK+B91U94Vmx18oAiNyqOtK4OFcUB2pyZ4sgjfvjBUomFiKof7OqvaQX0SCurlS7UZtzKYa4iL+vR8cCGVGnqCERS4qtoOnzBnIG2HEonKZNvmev/UfzseOAS1gYkmh7Zwo317IULoLB0rB0zg97EJKVVmT4MvPAET8dDvbgack6KfKO/+bSOcjeHGSH7vr0r5HbZ+x4dVaMRRK0Q==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 19:19:09 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 19:19:09 +0000
Date:   Mon, 27 Sep 2021 16:19:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Rao Shoaib <Rao.Shoaib@oracle.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/rxe: Bump up default maximum values used via
 uverbs
Message-ID: <20210927191907.GA1582097@nvidia.com>
References: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
X-ClientProxiedBy: BLAPR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:208:32a::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0093.namprd03.prod.outlook.com (2603:10b6:208:32a::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Mon, 27 Sep 2021 19:19:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mUw9b-006dbi-WE; Mon, 27 Sep 2021 16:19:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feb4aa63-8d89-4dc3-fc0e-08d981ebae55
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5222450F849D0DB2F1C040D0C2A79@BL1PR12MB5222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJ7y4Zv7bLl1DFQi4e7wyxxcKKhrJLIWzOa52xoFCMbLzXqWzeQ/RNqp9furjr7mUc2BTDwPlELQ2cj7i9c+JFhkLjBCjBxaijGazH8QtOlpdvIOKWP5EEW3l9ZqiFuzSNW4jsOaJQeIoEpxlI6FaC0sku1F5dx0V8wOI3gKdO3Faoqt3+o6XyTIn4aBrm5tr63XZfr4Jo3MeJE8SCds4DCqOYrHBb3jXKUlo2/PNv/Y65LlCdHwIuaA+t3Q83kWhVDtQqKmKjGgsZSONpKljxJxGiBBgQErkVosgS6tvTH/UpzEpQscIgkfWb2iwchFm2GW1dZrhlUFyCtMh9FTyrWwZjsFfSW42pazZvLklKVoeAliv3bh9qC26+Bn4uN4AupGtazvZfusoNxkX/11jP757i+/54jmE0uMqcznRF0smj4xk6RuY5IsqRze0TUU56SfJuuaWdr2i18Y724+3NmO09AmcBarFWAuaAzjqoNWjTvqK3ZvW65xpzDrsd9hWsJCPk+dy0QvJWgYORuCy6Zn2EN22UqFwHdlHSpeiP2IAzVDL5eg4YrmIPqBaMfPgIqusJ3tdzFOPk2Ly5/yVGDfHPrC25qvueHVMLci0VjbS1YT8jGI7eUstysrqmQIZh8JbiUJ4Pfh8uXLQKNo+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(5660300002)(110136005)(36756003)(4744005)(426003)(316002)(9746002)(2906002)(26005)(83380400001)(66476007)(4326008)(38100700002)(1076003)(186003)(66946007)(8676002)(66556008)(8936002)(2616005)(86362001)(9786002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ekDczOfLrDAZwWS4GZoRK2pNQIcC6/9nW5IeehP+EoibSA8f+twWjySpROD9?=
 =?us-ascii?Q?kCNlblSXRnQGQsofcBFwVDPIp275BncsGRKPFFcrdVLhoFHZH6RHOu2sEgsx?=
 =?us-ascii?Q?2j08al1k8UrMAYqA/CqNfRU7wCKDVO0tK9o4D0payojf3c+9Jv2Jtl1lnQgR?=
 =?us-ascii?Q?m6Unq2D0bULRda8khb5FQrCBMyLCaYU1USwUzb9gXcp5Lj4vlWFaqdUDHEwx?=
 =?us-ascii?Q?asJMs7xLggapCEoBv3N+b0P8eEP8d8asdAdssaLtPQLNkDFau8BySHYhIJgF?=
 =?us-ascii?Q?hV2tmNbbSdK2ywhVvDOaz/x9qNRnqVJyfgjO91w0dqGrNnFsGkbIajZ7PU/7?=
 =?us-ascii?Q?L9E2Ekw+oDX5vxVYvbyGVVs4iIlqJBlytlBmqRlSRqFuTTtmInP3tQANa02c?=
 =?us-ascii?Q?WbKwidN0VMGLqtIedRdKNyg0mKJ4Dg5mRoszwF3ExkBdo73UCwR1M9Hs+ZsY?=
 =?us-ascii?Q?8sOH8nhFVmLNwGfaOa8zteEIOJczkcvJ6lNh9ii5IYSDAUrfk+wX/4kWwz6V?=
 =?us-ascii?Q?C/tK/i80rPi98WnlirLjplgIofRCI8vWEWbVwFS9ZU+XTX65zWJtXj+SfmB7?=
 =?us-ascii?Q?p2el1U7ZZuFPvlAx07Chs8dnTxIWSFP+QQd9pLYJFa9MdZdd29s4Sox2Zvv1?=
 =?us-ascii?Q?3oRFDkGaJSVHRJxoKuz47rqNBoQllOEuhnYueXBCb5d7lANWSVgDJCnlOkbi?=
 =?us-ascii?Q?NAUXl4+vPepWJ0Gg2bnr4wvJ0oIDwI5bhGExItOC0nhw04b4dnXzUWZUKogC?=
 =?us-ascii?Q?e2n/t4+cjuJ9v9qTWOsA7V8VAtIH4KvONRWAa4+f+g2BV3J8fVDQA0bReSYx?=
 =?us-ascii?Q?ZfiDKaQqv1AH3fiO/cs5h2I+B2tu4h5gWgI4xcJ+zFdduILjB8rXspk6bfCW?=
 =?us-ascii?Q?UlJNVnSSyUJIYJai4RwI/3lGr7zavNJFPjCOk01Rvw20gV9oBuLw+SOhBYLF?=
 =?us-ascii?Q?QcTOJnzvCGo39ntHgobxLYRf5zf7AKa6BpE8/MtK8GdsWLw5YsALP8bveURS?=
 =?us-ascii?Q?ptxisooMpvr4EkMbH8jHbmN5j4i1fVd8dYk7DSUereyvJ/3N3PvB+S99vnFc?=
 =?us-ascii?Q?gKLjvoAmnIwD4uhTxsHjYwwJn2SKWsa/M3p/Ph2+bZyx9ENhdoGaiNwZ8p2x?=
 =?us-ascii?Q?WrMWHLbvg/AKGjgRF6DlQfbPJFM0hbgvoChf2L/aQajarrdETskLZw+dassl?=
 =?us-ascii?Q?bXLxtL4nUMJL4oPKeEoGvRk7u4m8w94cfaolvYCkU3c0up8WmKqJ71Wuls9Y?=
 =?us-ascii?Q?96REk5LQyEhbGXOhbJkpbXUtZQaGNGaSYjkrnOXrBAWn/xejbQRbQStlBUOI?=
 =?us-ascii?Q?/u0IJWADamOqQf/9rYkYLxUK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb4aa63-8d89-4dc3-fc0e-08d981ebae55
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 19:19:09.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgC1D9TYfh7O43KS1kKSjCle2wNMbuBDpeXN8n+lX0pFl1FI+3XbVn1Wj+MBbWlL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 14, 2021 at 06:12:20PM -0700, Rao Shoaib wrote:
> In our internal testing we have found that
> default maximum values are too small.
> Ideally there should be no limits, but since
> maximum values are reported via ibv_query_device,
> we have to return some value. So, the default
> maximums have been changed to large values.
> 
> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> ---
> 
> Resubmitting the patch after applying Bob's latest patches and testing
> using via rping.
> 
>  drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
>  1 file changed, 16 insertions(+), 14 deletions(-)

So are we good with this? Bob? Zhu?

> -	RXE_MAX_MR_INDEX		= 0x00010000,
> +	RXE_MAX_MR_INDEX		= DEFAULT_MAX_VALUE,
> +	RXE_MAX_MR			= DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,

Bob, were you saying this was what needed to be bigger to pass
blktests??

Jason
