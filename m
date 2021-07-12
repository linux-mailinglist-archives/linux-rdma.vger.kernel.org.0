Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74033C6251
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 20:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhGLSGk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 14:06:40 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:26578
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234933AbhGLSGj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 14:06:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYuTxKLsk01GDXQYvzw3zvStRPXFU7sQngB1FPCcB9t04f9Lyx88JyNQEJWjOdKQgPr2JahQvowT0qvaLIjUwg5j2iPRkqHTK2Mhq/LfdmsxtbCZSxuWi3HoWejyBqZniwocD3I84BQkUV5YYsLYTmwuLp9VX6IZJsql3QhidMVevZCSx98OLqbIIlFBhpCT95qp1tJ8Byp4pENqZQffiIOKSGrJ4gPOPgMgV/qglFqnfQq9VNZ/IFYsII1IkJ88Ds+Lzf+llGUU2Kjgoh7zl4QtEnR6cTqPedj38PaWdrVnKBht9MBUMMU9XY0irPI/jXt2a5pCkmaQ7hQFai3zdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TmXEyBP8xbucAQoGnbsNzJPOsHJVnpaAHBzIGNcg0w=;
 b=DhEz2Bryw6XQTfqypLfPDtJQt207f0ipFtQeP2CCNXO9ekvmR9hwDK5TTkGkSTvlxmWKhtjZxPRO+TmKNX8KRE0ZAPHPsoUseHGJERo2dlWlnJ3b0iJhwSGMYoVFS7IuNULqNQOuog+LOPluzaBr1IBQIdBnAEYekS50VAR0/EBmXXRLipPC+bzqClt2cyILxIJuYLgW6nu1D916e09tj7ENqC82SBEsK633uV6YdY3vTvX9ruYxnxGuzOHZUm/rzDi0owfLzNv8cCvHjeQYHiEIom7ZJMuB9nOnLM6NRgCtHUMfFOs0hNTo+Me8bM/y0JyghQ55Q2j+wnUSaQsoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TmXEyBP8xbucAQoGnbsNzJPOsHJVnpaAHBzIGNcg0w=;
 b=pkQ1H3pT2RB+gjKBMiqybOfCm93jhiGZQ6jwal8dSmhc/LsexGThRyaXaRVCnIkdjHljjOrc5dAblfPOoHWeKlLzsC+DTey/pfvXKaig8x18kqqapNnCv3m7Xfft9BBWECVPeIGLVW8QLyLL7PiiRV5gkCzm/bpVp/ou8qrXyK52eUYF84LOgbKIjJVHL16uWfPTeTQuz9AXaPaSQZaFellDmjZedJi4k+B8UbRs8fZTWTKq8Q4+aUYdeMMjcmsI3EDqNUBlDey3RGpAodlTFhTuoPiThjLyL+hMYYruWPXN3VW3BO4FZ2OUxN71iCH1nhoi4C59klDgZlPmvGj4Ww==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5553.namprd12.prod.outlook.com (2603:10b6:208:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Mon, 12 Jul
 2021 18:03:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 18:03:49 +0000
Date:   Mon, 12 Jul 2021 15:03:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: make spdxcheck.py happy
Message-ID: <20210712180347.GA266283@nvidia.com>
References: <20210701104127.1877-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701104127.1877-1-lukas.bulwahn@gmail.com>
X-ClientProxiedBy: CH2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:610:60::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR14CA0020.namprd14.prod.outlook.com (2603:10b6:610:60::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Mon, 12 Jul 2021 18:03:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m30HT-0017Hn-QA; Mon, 12 Jul 2021 15:03:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd0d674-9ded-4b72-0c0f-08d9455f6650
X-MS-TrafficTypeDiagnostic: BL0PR12MB5553:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55539BD31D7E9285C84259DBC2159@BL0PR12MB5553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3orTgCqI9uLu2AgkoPkR673+ihk/Pwh6soNjNYumaZ0P+Bkd5JBnWNPT36jJyCb8LzdsnQHZMl27u3FA+jE2BNYMpyoGqr1q7PAfYja2bCDwcXZnn1ees4laM92LDzWZPwK/QgDXoiC1IvJGT8mgXdV7dQMMMZYLq2QWajrB3k3LTG/tKDhzKUIcqYPaeuCKU/ehZc+NSc/li4HzktbGLvSfuPbiLuRLYPJ1i2wObInLfj4kgC94KRgtTxF6V103MkF3H4/5q7sje3xP6GJDwQFWuNt1+mQJW0govfkVQm+Ic8G5meuuija99W4UwlDAUj6qtOZB5OIbxVtnMDhG9OhUmiQUV1ShDwyi/GCTEPLyyeuzHQi62Dbab+oDG1DUYVifGaj6meQyzjyQB4YNDUUnUudYI8LF32+8itaTRVugMe0N3oFrhWVR77WRQOSg85EmuNXO+Rln7jsQ94Gx2jK1yhdR/8jJ5fUVIsE1Vb7lUtiOkz4wS1nEjJf46lPSvzhRMDcX5RvWtp401bnAOP3iEUyNHmmfG2lDdvy/7RWmIZN/vj/X7yFYzZt+5JR8rCK6/ELz5E88/s58nEMwc5gAj8OdHT1BaCTISYFXFLFj6BO+8kII+4+pMFNdlrlMiTjoQbUGyNa1UfSbbB7RfzPkOt/y5BR6XfkpP+fMHgmrvOpOGmnObLpHZfcatJt7U44Y1NAljD5Hw8ebImQoWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8936002)(83380400001)(316002)(9746002)(4326008)(9786002)(2906002)(186003)(54906003)(26005)(2616005)(33656002)(38100700002)(478600001)(1076003)(66946007)(66476007)(66556008)(8676002)(426003)(5660300002)(4744005)(6916009)(86362001)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Me9E+5kwNijYj3SDqEZ0SsSINuCVhn2UHjZYLg/EwcOYLjHqSCRZ3wM5kkdJ?=
 =?us-ascii?Q?vgCudF0UbV9QePU7pPHLgZ+qGeR7v3bujyCHPo1XuJ/KRhPvUw1c68RmsZAD?=
 =?us-ascii?Q?D1DMdccuGARt1L+b/I6JmX3vDY6qmbxDDqUEb94YlnB6K0VL1qEIjbZGxH66?=
 =?us-ascii?Q?fjhEk43GsfvYIbTyOLPAWS6UImkUzQBeVGdJZ3hRgwV92aCws0Y5lFVW5x5Z?=
 =?us-ascii?Q?okfCZsSdTktYiBkSZ6WHpBTJ1txNm4E3KVZwLansgtUgTtJlWCkDzkvzksWT?=
 =?us-ascii?Q?EZ2gTbbToxmzReH5w9ybVOet7I+MopGRSwvpljpP35cfOVXBvTSsNDf3Sf9p?=
 =?us-ascii?Q?cBolgzOdI2WkfzPe2H3UJn1qn+0Rrny7bS7FpaZMBGeRtilZ35SPyRDK2kKN?=
 =?us-ascii?Q?J941kEAsNXwpmq3zwFHzeRCh4iJytxbBbVlw4wxXqQevTlgFoG/ucw/6nM7R?=
 =?us-ascii?Q?sIFEsU3h0yeWYw7FO9ZeivPXw+gKTg0z4Lm0YZrhYv7pkPBjwTBVkVa07Ftc?=
 =?us-ascii?Q?UZv7DhC2qa2LUr9FUdoa8/MgjCOgFswZYSC5o8dt69IYwf8HVtntgTnuYfFp?=
 =?us-ascii?Q?QE7B3didgVeeXTrfVXt+BcoWvSkCgLo42uZ94V4vu+qFDKTTQpwmBBEZlvKJ?=
 =?us-ascii?Q?P0p19RuLig11UlSlokzn5hS++T/P1GNl0zNgdGhedxoVYeXpkRo+U6s9NpFV?=
 =?us-ascii?Q?oKxzZOPTyBzgWJf2EfjUx5IcITNOvUN3W5fKnI4bmiZtP4KJNVijB/B9j7WJ?=
 =?us-ascii?Q?GmEn5nmCKsqLnFUpZGIOF3/0heWLlwpJPi8iOnWE7XRcXMjDnYKwMyTVFHMy?=
 =?us-ascii?Q?q6Gtgw9OWGr7Wh3/TEv9faGu/iS/5CzAuj9jiZjSOweHY0ySISMuhlHGTMAO?=
 =?us-ascii?Q?nNsJDzRqHlfDf7zjLiPs06JaCBn1AHcp0s3pxb9Blc0JLKsJIA1HpbpRi3Vl?=
 =?us-ascii?Q?rKyvd45qocojqSqIw99BLZ1IsfloShhyA6a5BJ++bdKtBuGzrUNCukAlCY+a?=
 =?us-ascii?Q?5W2FIkkBIr6PeufdCmFAOgRznc+FS5ttL8+5fiXUQmmmwAYeicWRt3fXpZxq?=
 =?us-ascii?Q?UYLJLUJbOyghKmi7Vv+eEnfwYGnd36pQOPZBl84zH2GEV1VumpY5JpLIhV0d?=
 =?us-ascii?Q?geIWyj4x+DYXeGKSCTmwqAT+T7wHl76LYBEnDiLm0uG0n7cJsUNRV7tUlI5F?=
 =?us-ascii?Q?GBf0ZfY1E1VRwlRm3r05iKjBqiFgZFZ6zb/9ArZlEwnvzWsnTvL6iRNMo3lh?=
 =?us-ascii?Q?qVoLp/xEKlZWHyXNlELLfdZkhYJj7Bg3f/kJmMYbTfgUT5bGNQWd6R+T82bQ?=
 =?us-ascii?Q?xBmM0OolbCCPYTvORB5Npbxu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd0d674-9ded-4b72-0c0f-08d9455f6650
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 18:03:49.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDU3MULsaCdD+bk53HWxQI0ZZ9c6vEb1RE650X9J+tbo6dPLwNi4KDWKG2/NfMHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5553
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 01, 2021 at 12:41:27PM +0200, Lukas Bulwahn wrote:
> Commit 48d6b3336a9f ("RDMA/irdma: Add ABI definitions") adds
> ./include/uapi/rdma/irdma-abi.h with an additional unneeded closing
> bracket at the end of the SPDX-License-Identifier line.
> 
> Hence, ./scripts/spdxcheck.py complains:
> 
>   include/uapi/rdma/irdma-abi.h: 1:77 Syntax error: )
> 
> Remove that closing bracket to make spdxcheck.py happy.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Acked-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
> applies cleanly on next-20210701
> 
> Mustafa, Shiraz, please ack.
> Jason, please pick this minor non-urgent patch into your rdma tree.

Applied to for-rc

Thanks,
Jason
