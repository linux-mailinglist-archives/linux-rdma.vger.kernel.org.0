Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB71B35E93D
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 00:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhDMWrt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 18:47:49 -0400
Received: from mail-bn8nam08on2067.outbound.protection.outlook.com ([40.107.100.67]:63361
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347590AbhDMWrq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 18:47:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h74IbYuaomAF50eu/4K0TkW8+RibbkC/jfHjhtPiAjvfdvB8dvPaWj+fIHIwNWdbT74UMUg9CHFxyMZp5FNVmOORxyzUper5pisliJoSnJaOcQqedSrTHmutJ+xprWRl3DR5R7u7s/PeyA2LuKem5vA8vo3XewqkXY/dk4wjUc028D1pdEoZqhPi8kw7ZR/qc7cZG9XIGCP08fPpsK1EBUbBdEp71YMpT6LQUFrNI2z8Emdm18sJL56aJ/HIxSCli3dLxFnRLhYB6SLINxY+QPp6VGw0slfX5oVOHowTP2BXT+lIcpz/hQSu5I5c8PMWCa5YycWuE7j/+ZB1hhhaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNtJZfY2IzhAtRx+qalXCAXbko7wNfSqlmh+GF0QOtw=;
 b=N8zYNGzhc5XPysDTYkRGD/WMlPp6+prRAIH2Cyrq46cc+YhtoRJ9EwWQDKjTyyOcmfKToCec+idlfJquQkZnzQnM9ilcYA+s36aD6OqTCXameudmgzawNnec82Iwp9dczeZVUqA831tfPtyx4ayizOVZtL7YSiB4j7CjOyFV8VUqsgQ4rkIgBbiX5ZdwpDLHPS8pNUT0l6GlJ4N5ArCTzszGV5BdAfeHnMUxAAk7nQQzkII/6HbiEUuA2DHhQA7QtTIVfMQjcs3DEy2bB6Du7Y2vHI2n3vZGIEsb/h28IQXTHfHhQAEvAFD7x8t64riAdCTGf79fK87U/HKWnF+k2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNtJZfY2IzhAtRx+qalXCAXbko7wNfSqlmh+GF0QOtw=;
 b=DHTLhY5KQ/Q0mn/s9ZTCMPBwogdWOH5AxohUIL53d0v9PaCoYNXtMsrQ9r66jfWipaZDkF/F0EsCYRhO9Z9uWsJS+RZ2PkphrsiZs+aPjmI+qMdgPdgyTEKX8oWdZxKMqEJzJDEc7tIoRJdk9WgfNYUcUMkHhyoHgnB+nWR2l5cFW9i757JiY+YYWnQ9XvLSjWRoHBv4FRlGJTqMv2CyQie9jALSFHLX24+hl0Af5PspDIUUYQBFxUVrqw8pCQeADOze1/pLGvIzCqMTShVpp+XJgwDqEwN17SCx6w+ye2776GUvmTGAn8kXP/+y3YByPqHIVoX6e44rj5p6MTFCnw==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 13 Apr
 2021 22:47:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 22:47:25 +0000
Date:   Tue, 13 Apr 2021 19:47:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: Re: [PATCHv3 for-next 0/4] New multipath policy for RTRS client
Message-ID: <20210413224723.GA1370930@nvidia.com>
References: <20210407113444.150961-1-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407113444.150961-1-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0180.namprd13.prod.outlook.com (2603:10b6:208:2bd::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Tue, 13 Apr 2021 22:47:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWRoZ-005kfQ-Jk; Tue, 13 Apr 2021 19:47:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d31a8017-721a-495d-4f40-08d8fece1b47
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:
X-Microsoft-Antispam-PRVS: <DM5PR12MB133740827D224513D5CCB9F4C24F9@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xphgNbo9E99EbtmFFNGdvVmWByi8IbchNTtYyJ6Gsy4U2SijU0Kbpl+29g/wZqQogJ9+BJzPj7NkJ5qpfnlbaBaxwYJ9GoiDgRewQsGoIia8WvkwlXwj3G4oIhJx1ns3OEufP5bN5TMgqqT0lRqs9KrYhHGF9mbZ2OhGYgIlwrWQA14KpKImRROWOOKYYgE/NQxMnis3FLrBpf+TD5jxRrtDfVGBSsKgnjE40RtubEUS/rTtY87u0RDDjcp9jPHf/CP3ikKfwZ7/WGr+rGmxDYb9LoJNJBrAzxtrct57jO2PLaJoeRIu+ljJFfc84cJIyzRo06dRt7uaEZrdefHjpYHlc7PgU17VKCr9x1HxgI48KlwSkiK4u9qUhJe4uiKjMamrZW4ksRvovX/Y5/doOOsyxkfy4Sh0eDOE6TGayt4YY1px7RvJIJGM5KAod9WawoKPw3rcLMgfZgaKOVFLgBxXhTCLrgi/CskI30JrRBvalh2nF5jo9sXym8TiRMkI12mfC5ZcmRrSIFuTekRLbahydMozH1RQKAsMlOQY7+RB1ejKclzDFmwpFv3yAEHcodHTUwmH5A/QC/Wizv5fpmuR9hIjxMoJFuE3nhzCkcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(5660300002)(8936002)(8676002)(66946007)(2906002)(9786002)(66476007)(2616005)(26005)(9746002)(33656002)(1076003)(38100700002)(316002)(66556008)(426003)(36756003)(186003)(83380400001)(478600001)(6916009)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dETNjeYQYn0BhmDDJ671RlTjdgFn4MTSUcy9MpoR8behEY36f8PfhB2oC99C?=
 =?us-ascii?Q?pQQLiGzRk4Y0iw+6HtMk4YR6z7L2gC67PYTJ5ySNsu0AkJCFK6vVlN9kp8bd?=
 =?us-ascii?Q?+LPuiHQBVPso6vq7ZyFy6foWbYBfsWfa7ynYFj/MBoOFG24i/ZK778J/oNq+?=
 =?us-ascii?Q?Y3c9e/NDxaVyUjRrCvWZigFuKFzt6MdN2xzJYk6Sa2Jsex1ydGVLgztv8LBD?=
 =?us-ascii?Q?MWF/JRTB2eahPGwwo0LXuy6PKxBkUXQkmnSZUTBEk3BHa5QxtqBMCbeagzFn?=
 =?us-ascii?Q?r0fVp49a6afIWIGoIYnW3p1SOVwHFSFCD3L4tZyTW0wJxfn2mkFybZdCsAT7?=
 =?us-ascii?Q?WOFOhK3+ZQBS9NtIhT6+kIxoOBm+R3e4K43g2b4me5cVNiAzJrKNspLcTWlJ?=
 =?us-ascii?Q?pfRD/GR6s07jJi049F2JdT26FXz9rOlkubd1myghxiesc8e1qNEAKVs1GOFN?=
 =?us-ascii?Q?OQMik/IF6eg0bzntm0fapHgUK53nQcVlgQ3NNsmqR2gSLlOEs9IhSE3C9AX/?=
 =?us-ascii?Q?Am4txV/p4h0jGMe8Q6nhd3f5E7UVqQr9wPpfFAwc0LgYlm+MHXHAiP1iBuIK?=
 =?us-ascii?Q?jOVRDgwEl+1Y5FKKB1+uzUxsvd108LzfTyB4kqwV+yXbAEASjfcqde6ujZBi?=
 =?us-ascii?Q?sg6ACUuqi618F85Cb4gsXKcY7tP9SZREUPmWFaSSJxjfH9R/lJOeqljUBTFX?=
 =?us-ascii?Q?6QunmUhdmzbT90AXiYGYEkQ01t6/snXg5IgiZj9hyS3VHy/jYHUkevPia2Ds?=
 =?us-ascii?Q?aEFchv9xbDGl32VnAySC3BBn7vvof+iLRlhOchjIMy5BUJXbuIpexemRBmDZ?=
 =?us-ascii?Q?NUNCyPdBwLKN4H7PxSbMJFghciIZ8K1DHhfTesQF/Wk7W/frziWOeMEeER3D?=
 =?us-ascii?Q?rpeSBoeEsSGF+NIodLT7hB9036eKEH7QUB9B+ttev9NvreLzdPupBcCjYFPa?=
 =?us-ascii?Q?XvBDoIVrpItoWLa03QbveLZMvEx6HrNdCRw5Ld0sls2PkAUHEmcx+43PpzcO?=
 =?us-ascii?Q?h3Nju0yxBrHpqLeuZbUn6sfX1FAL4QHWmpr3Seu5KqouRSt9Wa0EBcmu2YAQ?=
 =?us-ascii?Q?2kG1qXvEqcD9YhvSeW3ZOcIaTZEUXpHSOcLi0ktXbiAQA4SgSzgpb0YB1ZUO?=
 =?us-ascii?Q?URJBcZlequp+Vf9rJbeIz2jqd7bD50Co+jRpVSzz8zRztNCw47GRJaVfH5EL?=
 =?us-ascii?Q?FiJ5+dP0DUjVU5Q0F1ntGdHT1MbwaLcG1QC//7YJeglt3PEzsMJD5BUJ+cMx?=
 =?us-ascii?Q?+GfuvD1QssXzuHQGxKaJInXCFiN1WAVpL30GwOXacMsmnXqr2gfvtbnDb63+?=
 =?us-ascii?Q?fJR5P7qfliVHNrtpk2mso6iocVbY/uc7g6Ud43P35Zravw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31a8017-721a-495d-4f40-08d8fece1b47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 22:47:25.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlTrGRm4iz0iro5Zl5NYb14MGXLYuz+4sVtEBUEzPWOTGXdEdey1gkKwDHEnv/aP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 07, 2021 at 01:34:40PM +0200, Gioh Kim wrote:
> This patch set introduces new multipath policy 'min-latency'.
> The latency is a time calculated by the heart-beat messages. Whenever
> the client sends heart-beat message, it checks the time gap between
> sending the heart-beat message and receiving the ACK. So this value
> can be changed regularly.
> If client has multi-path, it can send IO via a path having the least
> latency.
> 
> V3->V2: use sysfs_emit instead of scnprintf
> V2->V1: use sysfs_emit instead of sprintf
> 
> Gioh Kim (3):
>   RDMA/rtrs-clt: Add a minimum latency multipath policy
>   RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
>   Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy

Applied to for-next, thanks

Please be mindful about the subjects, rdma subject start with a
capital letter after the tag

> Md Haris Iqbal (1):
>   RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its
>     stats

This one was replaced by that other patch

Jason
