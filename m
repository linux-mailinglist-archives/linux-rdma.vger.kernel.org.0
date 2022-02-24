Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA574C2095
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 01:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiBXA0k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 19:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbiBXA0j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 19:26:39 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6390865492
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 16:26:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNY4iKsHsv2uSh7XbQpDGN8CAYM2ygjTwGxZkqM5Aio6QXYoKukt9MNrezaMwaB0c6yOHDeMEhqnIR1Ta449Sm62+jov3qPjTVTwi6kPKPRnDOugJwZBAolGyo/FNhFoGna8pmmJ6ZeMxY6GgIBeW+sdyT8F3IeWIkRkp5GE77S1FxY2OHYfqmqfvXJA1ZQa+MnEmEvLF4seXlffyD8j+eI2dnACkLBVFPvaQfAwjAbYZlPd2wfOIjWwLj+CddTomPepY2rGv/6Kn7hb95nt4dayTYmjK+suXZATl0qou33YbHTD9jp3HtJcvdrK+bntk14WCzZ22c5EKfIL9+ax4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc7z1uuFgYhOY6WnIjgVksJiTuGQ2VeFhqQYKy0aLJM=;
 b=gUiWQD1ElZTuV6hZGEOi5EftFHOWq4wVl16TilcpkkL5R+6GP+W3hV9Fom/EARpLo3JUt+xDpRGQdcdK2AzRP9tbmZ0BDbXAbdN2ONumOiOYuTavBfuEc5ywEF65J49nEEcffvBaBRqdkM3cPKglhmkjY0n0jHR2hCTO5kCJ2vdwqOw5ELJAm1CSn+3Efpn4zyByXKii/Q0rOIKK4jUGm9wyq7Wo6DoMw1p1TPUhfhujKhdFS5MgzKyjG4mVW0lFf9a3I8i3tFdFXOowKvwJvhWcsRWDvJOOrsqvMK0pcXlqx5+1GsY4f8WBeVdrS1VXWyEv19DIRZczgpTZPY6fhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc7z1uuFgYhOY6WnIjgVksJiTuGQ2VeFhqQYKy0aLJM=;
 b=SQYXEHuUs2JVCpDR5SL85V+jLzZQSV8QYaVPiWRR/E/IyiwUJ6pL5IlOFO6/HAOW6jmcOtGsH4cnMvzKF83Oim1ZdddtcFoHOSbMKPfTOkl2FyXrsLBekGJPMwCKxTgkiJxtDZ8z/7CUVPs5YwKR9UMGeezJaUnKWAI6uQUgHuBGTGU04tch68tobyk5vOyoq+qd3/3gFwI1myupimzLwj9397kasLdLZw2+WAXCGURCYoMeQovzPgMvoZwHojlZrjGa1PF/aFTP4UnjIeUWRU6KeVYj2uHF43I8j7y+el/k1qgBXGVLau0JNKg5QCFhskywxqoeuWDCD8yvCybKvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR1201MB2477.namprd12.prod.outlook.com (2603:10b6:300:e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 24 Feb
 2022 00:26:07 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 00:26:07 +0000
Date:   Wed, 23 Feb 2022 20:26:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v13 for-next 5/6] RDMA/rxe: For mcast copy qp list to
 temp array
Message-ID: <20220224002606.GB409228@nvidia.com>
References: <20220223230706.50332-1-rpearsonhpe@gmail.com>
 <20220223230706.50332-6-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223230706.50332-6-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:160::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eb0d2e8-d3ea-46bb-edf8-08d9f72c4006
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2477:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB247787E983D8CA002E0C2B3DC23D9@MWHPR1201MB2477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdVwKmf1uwyiRpsvmTmflxybWL+p0hvML8jeM4EFHjGxmUuE7E1E0ArOfxTdiH6j00T9O3/FEqGHRsx/a48FIUn8fj3OkWKOCoJWjwzt3UYdd+6FUSyEqDUWywYtbg6auFK2NBN+HCzgHqbJ1NgTB8+9J4UCtQ5KlPkQZ1BKGsZ0Ddeicjj0EqQ3IVsR5LjDcc5oefLC+ppyChWvwaOyJWPvSy9ksr2X3v+et2LXyKz0EjabInJ3behlDUlW/ODgcoPlhUTsCQim/urzlN9ufottb35yj6urxUwa7bf7hu0+LFUAtehE78Up9sm55+QKMNmDsWhUtGj0OJu/eK3De+IhQJApG1qzwH+PlFPlez3BhS+WPjZKQTh/p54Gt0d/MaI1ZnrjajfiWLmi9NgyXwHY/FzVCWZRz7hXKTLbg00WK8SgS6yQS0zScI+Cl9w6pDtz2uIkWA6sKt2BdzM6A75YIPGMN7eRe3rYwOwuABc2Yhy+3WSJ4SPr5vbcbeNplXOIZ+hIzCKmRls9EGRUdzrWs02z7Vve05eUOD4xufrtADwWwhqVdvWx+dH5jzhEMM9rmoEkg4XgW6Qh/EVLHdxlofvWfJBovT+6wD+8dE2wNyBj6nl4jh6hPEwl/WCJUjdtLSRaGEbFoyHn45MzOXfSIBP788r89U+aBNmX0zpWt7fmvJ5BW9FZ6FD2b2I6Lrz8w6jxl424YBAOGBmQVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(316002)(4326008)(6512007)(66556008)(33656002)(2906002)(38100700002)(508600001)(66476007)(6506007)(8936002)(66946007)(8676002)(186003)(2616005)(86362001)(36756003)(1076003)(83380400001)(26005)(5660300002)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?om3tpRu+XMMWCu2rfGfggj/BgOQGGvsTL83GU/kCXCyELvfjtpvSPZ6jPbI2?=
 =?us-ascii?Q?bfGijfjuWZXZSUsAWTvIDfIHexIuGoDQzTW1J2PfSJdh78ZJxt+L3iCDk785?=
 =?us-ascii?Q?4BmlZ19veIH6JnVVUEPnPFsgqYoM9tSwNkT6AmeE8AYFxVACKM+apYr4pcwt?=
 =?us-ascii?Q?11Kzxz1OGAkgzxjOJREUTGHHRULyPaL0hryPn0HBWybXE2r8chPFtRrW5LfX?=
 =?us-ascii?Q?xiobrpzdkYBnE+beQaqtQd7q+T+MCUjiuGJD/BAy9xSogoFEuR7NAzfTtGVI?=
 =?us-ascii?Q?36Y1N8THJNxe+wh0IDp4c8kTsqqnQ4lA+c6OBBDsMSavOuFxUrJopfs40zg/?=
 =?us-ascii?Q?EPVgX2fz/EetDXCqkzr2cIA0EGvKMOqhE2GYx78OZRe21+r1UkFM7kE20TAo?=
 =?us-ascii?Q?ndmcNubuy7wjwNHiKPHzq81KU2iqtoK+Oun3n47gRGF5Uv3FQJ6oKkrF33/g?=
 =?us-ascii?Q?hFrK6jh09N+u3EbFlOUsRo8XoQHrlAIZy5Doszh8TVNecXgiOSp0+exzMcIV?=
 =?us-ascii?Q?vRKSUuMUae+qL0OezO+d0ZwPbf5JxEDvJXjFiVbEUe0S/C7yK1J23pOL6cNS?=
 =?us-ascii?Q?hdrvKLYQVxIVaKcJ2jCb51f3pFXASslv6eBGSeq1p9AURVLUwmo1PlT/wNVD?=
 =?us-ascii?Q?esyYDob/7TxOE3Wl7AxDaw3gNspYHgfHBlIXEq3X/9y04V1zXvRZo14mUs/v?=
 =?us-ascii?Q?ajQD9XSP73ySjbAAbAokoa9INYWWZKoumQKhmHcKX9R3rKzkxVjxREFsrnSh?=
 =?us-ascii?Q?1UpUowXaMuG7q+eI1kd/5xqiQBlkGC8MLlHQaKG3jIQ30Bto8TwQ4CG4ylFz?=
 =?us-ascii?Q?PFZlMJrVP9nAXG26EcHzVp1/JMO1smmFDC8FMzdUea5ySQVE71wlY336r6xc?=
 =?us-ascii?Q?qEsuLnQQerbb7ZSLaMdpAfiqrXuF0vq1a8zYvnDeAQFYyxqi3HJYzYmDuYux?=
 =?us-ascii?Q?LKidvfandtde30JmjB/Wh5X1XCG0kQuUatihWrXe98bTJyiKhQPBNdYvmfup?=
 =?us-ascii?Q?fGD6icMJ/0l7kAZX+tSQd99eLBOeWEqumD+e4nSn980Z+w7KELQMgKyw6zwR?=
 =?us-ascii?Q?D94Fdwz6do8qH+4StFBBy8KB0uYlhm3MgQ4XViEwcqLvPgQzcD/T6xAsiCnl?=
 =?us-ascii?Q?cCsr6mi0Q6KhfuGXJuHOoUB8YlEkNHM+ZqoQEM7FaNl3+H3Jf7yG7hpMBJjr?=
 =?us-ascii?Q?ydXBcYoI+BOuC8yA1FewfpwYTKAJ53Mp677V7pNR2FY6Cob7bHSwXDpp5uQc?=
 =?us-ascii?Q?pYIlDGPB4k6nQd37XA/s+DyaV+jg51R2oIRRY0phLOV1fY+swPuf3q+pDcdp?=
 =?us-ascii?Q?6iJgyCztlyEc8Xv+yvD+ypO+Ib2MDcRbpIlrr3AWItja/T00XrydsxjtONGJ?=
 =?us-ascii?Q?Lb5osRA7hoc5FGI3DUmJ6mN1+2r9gCCoxyzN/kQ1vuWI3Efq762CFFRXFMVP?=
 =?us-ascii?Q?7Ndq/QUxKnHuGP2WY3jZPlmZmv7lSVHyKkeKKGuZbeH7dgSp6xM8vm/6k8Dz?=
 =?us-ascii?Q?/fdGhEmswgeuDmk8MsMO6U2Od9tFCdZh247HnuItvLwYCTqdJTqyse8xOwrt?=
 =?us-ascii?Q?kQyCMoxnlM+Usi9qu/Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb0d2e8-d3ea-46bb-edf8-08d9f72c4006
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 00:26:07.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J958jI8pI+c2mf+gAAe2utqSzZM2VlFGrIr/EZuJBc6h22Edy2UCTn9lhEP6p9us
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2477
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 23, 2022 at 05:07:07PM -0600, Bob Pearson wrote:

> +	/* this is the current number of qp's attached to mcg plus a
> +	 * little room in case new qp's are attached between here
> +	 * and when we finish walking the qp list. If someone can
> +	 * attach more than 4 new qp's we will miss forwarding
> +	 * packets to those qp's. This is actually OK since UD is
> +	 * a unreliable service.
> +	 */
> +	nmax = atomic_read(&mcg->qp_num) + 4;
> +	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);

Check for allocation failure?

> +	n = 0;
>  	spin_lock_bh(&rxe->mcg_lock);
> -
> -	/* this is unreliable datagram service so we let
> -	 * failures to deliver a multicast packet to a
> -	 * single QP happen and just move on and try
> -	 * the rest of them on the list
> -	 */
>  	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
> -		qp = mca->qp;
> +		/* protect the qp pointers in the list */
> +		rxe_add_ref(mca->qp);
> +		qp_array[n++] = mca->qp;
> +		if (n == nmax)
> +			break;
> +	}
> +	spin_unlock_bh(&rxe->mcg_lock);

So the issue here is this needs to iterate over the list, but doesn't
want to hold a spinlock while it does the actions?

Perhaps the better pattern is switch the qp list to an xarray (and
delete the mca entirely), then you can use xa_for_each here and avoid
the allocation. The advantage of xarray is that iteration is
safely restartable, so the locks can be dropped.

xa_lock()
xa_for_each(...) {
   qp = mca->qp;
   rxe_add_ref(qp);
   xa_unlock();

   [.. stuff without lock ..]

   rxe_put_ref(qp)
   xa_lock();
}

This would eliminate the rxe_mca entirely as the qp can be stored
directly in the xarray.

In most cases I suppose a mcg will have a small number of QP so this
should be much faster than the linked list, and especially than the
allocation.

And when I write it like the above you can see the RCU failure you
mentioned before is just symptom of a larger bug, ie if RXE is doing
the above and replicating packets at the same instant that close
happens it will hit that WARN_ON as well since the qp ref is
temporarily elevated.

The only way to fully fix that bug is to properly wait for all
transient users of the QP to be finished before allowing the QP to be
destroyed.

But at least this version would make it not happen so reliably and
things can move on.

Jason
