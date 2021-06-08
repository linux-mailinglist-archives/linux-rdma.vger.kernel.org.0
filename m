Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3753A04F3
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 22:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFHULd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 16:11:33 -0400
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:35823
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232764AbhFHULc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 16:11:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6WYGMbm1SRT814aDk7MGuWN61sCHjuu3nZYzkvp+nUsMjg5W5dwQ7AMKr67EbmjoRu++xb2vu7twsSIW6xmgipQy1jXwzQmjf/otqmY2geidrVOlD5swPNBI+t0m5g9MFsft4jYGlVj8mMqKxvnv0EWBfSNXf70X4wvraDMUmstWs6H4xIgBYD2rTm4s0VaRGGFNpOjGrIhVyjl3B6zszbEyZ+FxO0P8+HDGOXLZCqfgveLhEoA7JmSfgGQ5nV3fCWR6sOxqq6+cAcnOmyHQuTOC/Y4ziHTAxxy9vVQSaXqex1/HTTQ2bmmGtfrFZu34Qw3Zl6ICORp3DzIb5msXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNu7B1ZuJLuunD4+5BQE0rHE9ly/WbKtKaD1KImqRB4=;
 b=OobvZZlj5Hx1Fl/xOiFc0eCZxYxY+z9J3+znnxrC+D0XUdyB3LNkNfsxkeEtYD9LP9u75wGyxO0IJXGc/1OMsOZU2OpSwp29NYnvEYTgKOhK+C4fv+xvqRmKP6kWeVcyclAdT/98w/Zn4sQs4Jp27hjD1ogAQMHYJGktJ1FHAEqgzN7mQB4Y3pltwuez0URypj6yJOsotMg2C76CM/1xgiNbqKN29CP+SWlzyS88AaAaddWa42WTkhDlAa6yN01m24lMBTRt70KCyNFJ3TFvIGM7UwyufDeZhq859OrT4s5PYoiXCx3H6eAfR7k1ULH+FKDkB+PTZ7ICpC/XI7YQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNu7B1ZuJLuunD4+5BQE0rHE9ly/WbKtKaD1KImqRB4=;
 b=PiAdCvLCmd5eyYr/WbasK7oR7YMjaBqXHMJcSlCFKhSh0HdZaRnQc31ErbSYOmukaaMu2wI9Umkk3KLUrA4031udN0jBMdagxCkvghRLKQf3IuxbgJqNdjlqUycDwXMujRTAZtoN+RiQMt7I1c2jVcBWJE6Oga0MpapAvS0ltdMeONFdPneprWzzwGY7grHFHYc42nslYGkoTtfdVn3w3OmzzgcXgHNYAma8GPZfehK7uEvcAnCRzx6cwJDabOY6EVVQ+L5ncX+z1rjG6eeYO7SWTI/oVdTO3qmbLG/MCDRwMTGMSWShiUtbmDq4EaoM56dRU5cMm3ix6Z+1uoHuTg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 8 Jun
 2021 20:09:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 20:09:36 +0000
Date:   Tue, 8 Jun 2021 17:09:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA: Verify port when creating flow rule
Message-ID: <20210608200935.GA992630@nvidia.com>
References: <07ddc8516a0e53e54e3cf5cbbff19cac6cda3d82.1623129061.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ddc8516a0e53e54e3cf5cbbff19cac6cda3d82.1623129061.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0211.namprd13.prod.outlook.com (2603:10b6:208:2bf::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.11 via Frontend Transport; Tue, 8 Jun 2021 20:09:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqi2Z-004AGZ-Lf; Tue, 08 Jun 2021 17:09:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ea360ce-d59d-4934-38f2-08d92ab956eb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5046C5D648C1ED31FAC66D5AC2379@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +z44nIS2hSU6N59XH+fudBa93d3I0h8dX5hgb5RVqjFcGWb3LKexBQhC2SJVRLv4svBkocXHaCqtrkpAPM0z8lLFdGOdnFJsUe5l8UghIU/O38KPWKN7kiN0DoHpdr2+bJLXGvELvcUGheN3ONJAEeLuVkWTELZ4cmfL7r2bipAJEQXvlGHY/Q5Vqm+uIq8/S2B1a/8kRBeCu+6uU0MvoKYOi2U39ivLtLR/pogjIFFsZzKeSU1xHPA9s3PFmdcL/mdGuSqoAJBK6PLV+H1bsEy1iAERI5MmvK8yvr+21ZYmYjw+SgKgUY39TaAHutT/uRVuqZwU8oiP/qlJ7zMN967aiTPXPJf01T+2L2DbTvpH2on7Uly3w2Y/ItYF6pN6ekP9tqQEgop3ggOgpM75WxKOwA/6bl6OyH9k1uWwK+JzUibVRDwNhvIxySf5iYRmEzeygphdGpX35FaMhxHHSzIrisiKHaEhjwTt8ARwTUPOdNgWgIxcvCNXVYxY7QCNk20JaFlCk3XEKH0Zk4kgumlRQyue3GKdz6Y98RltiOAuZSFrUl3+Dy20k399JC42tsz4PCkt+L/B8E+Y3QE3uSxiIcvnCn4j1F8AcjiKzqVCfomPmrNTzd4IlOfzuMCZWach/Vxy2EzuRnhZlw+DqYmK/4hHMy2joz/k23bM6EI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(36756003)(8936002)(186003)(478600001)(26005)(2906002)(1076003)(33656002)(66476007)(66556008)(4326008)(8676002)(54906003)(426003)(2616005)(66946007)(86362001)(107886003)(5660300002)(316002)(4744005)(38100700002)(9786002)(9746002)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GfSjrs09DeXo2LEviBi2fDeEp4YQllMcnxfphpq7npm30uexD4UZIcHrIZHR?=
 =?us-ascii?Q?hUnJhpO7J9CQFiznCO3C5XfdXPTGl052L5JmZ9BxDjvPotVRvLISdE26LqUq?=
 =?us-ascii?Q?6VHABF9BMPVdhixYfpvN549Xmw3iohSOyB17IvSPGUyljAYbB/tiKJOJXMy1?=
 =?us-ascii?Q?/DY2WCg2j9Hja1/aXd1AUU2M51cIMnD80tNW0guoXxUkWvHSLNbbma3NmAzC?=
 =?us-ascii?Q?dQ2+m8sm/R3/dlAwIqAGSEUD/ISEfky70YJbJq9GC0Nqb6MX65fvrLtkv9Mq?=
 =?us-ascii?Q?CUe2rZDYdUCbFzfEn7U20bqqZCp3rvDFoVhC4UweRDmNtOPTLXuh4HAlZCRq?=
 =?us-ascii?Q?mvXdw0I78xB/P+RFH0sNhsgczJgu98L+QngZa/Ad297Q3wLFJQ+lA1guBoYV?=
 =?us-ascii?Q?IrH3E9su5F0jxoWvnjiiLzA2TbBhm5X8K33V5lAMFWVKuytkpYyeMfMedLi8?=
 =?us-ascii?Q?zKTEgxpX1UuPgZdwv4GhQG1pN1jxebuCFEpcMPA6eueuG4EzmAvmEXr7CbAk?=
 =?us-ascii?Q?eCGKtEZR7eDcpydWPkBWXEbgfdtfzsd4GN3HSMhsclJLmeiKcAHU+i3T4N8s?=
 =?us-ascii?Q?sUeRe0qqZD+VXwtc6RXKUW0TX4+Djy+tsaABeN8JlbRavmhZAEwCUMImlkEE?=
 =?us-ascii?Q?50dfmXRDzV1DrvzNhcy8ZW2dWwaHjjbDYfcYc5Vk0qTcJUpjd2Usi81SJEDS?=
 =?us-ascii?Q?/CbPcTV4b4AEgSaDfnSHMbyt0h47ZMsAOHLd3jVO6zolJjsUiNxIyx0/rVhM?=
 =?us-ascii?Q?H7SPgZ8HtcRrAgVahort07BKXJNtLaT63iWIYOm2AHhnlLlzES0Brr1alBbB?=
 =?us-ascii?Q?khfGzHJ//LPJ9xvBPbGR2O8fdEP9fbvqJSCgLM+lDDnjiPZr12kC9gVkoHwC?=
 =?us-ascii?Q?KOsg72mppwJKaOZ5xoWaS12QEgk0cjp2QhZlg4iSHKJf3abCgKK/Q5KBfOR1?=
 =?us-ascii?Q?UpU+V88VR2lCvQfxah7UWt6nIQCbwvihNJfXBmk/n2ETGploeebmLoyP4kSJ?=
 =?us-ascii?Q?ZlunR9akng96qAoVVXc8F7OIFfPp657dZf4KMIOYyeAZ6sBhWslaJS7M6PKG?=
 =?us-ascii?Q?/tXU2Ha0LW1Bcq0a6MvJyR8i6F1HbrYOU/46LyIA03htd9RI+shW1a/XgVBo?=
 =?us-ascii?Q?RKN0VdS2vEP+Eg+bovJ6cFm/oLY4jkJzkuBpmFBI9fk6/ToCZ4lPGs94SBSu?=
 =?us-ascii?Q?ba7Pu6pDKmoysBhidg0CGgldF9/xMTnsg/m+4W+cMKjAlYFobY46KGmR3x+t?=
 =?us-ascii?Q?NuM2D6QiSLS9jj5WVrNkwa93HBF2zeyIeIqvmwWYtuKAEL0QvV/mPOfmgekT?=
 =?us-ascii?Q?VZAHzbRTZs+j4yFdMpCyX4lK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea360ce-d59d-4934-38f2-08d92ab956eb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 20:09:36.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdGxFJ3CFYsjr4wo8220DxFqCYkhoEnHR+b4RiJJEx4yNGx97wCsxpUIM1TDNS+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 08:12:24AM +0300, Leon Romanovsky wrote:
> @@ -3198,6 +3199,13 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
>  	if (err)
>  		return err;
>  
> +	ucontext = ib_uverbs_get_ucontext(attrs);
> +	if (IS_ERR(ucontext))
> +		return PTR_ERR(ucontext);

ib_uverbs_get_ucontext() should only be used by methods that don't
have a uboject, this one does so it should be using uobj->context
instead

It looks like this can be moved down to after the uobject is allocated

Jason
