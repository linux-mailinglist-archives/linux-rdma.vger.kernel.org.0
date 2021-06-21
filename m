Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F411B3AF42B
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhFUSHA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 14:07:00 -0400
Received: from mail-sn1anam02on2088.outbound.protection.outlook.com ([40.107.96.88]:53427
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233965AbhFUSEW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 14:04:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efuDMTxRzxyc4kGa7UB7YL6FD7x8jJSzw3jNRN6BuJ1yAkzJHe+UkYkDIm/yB8YNOlBaGfocidyh9xiHKwRt/8Q9TJGSltDniYstlksLa+YB+ka4LZ9J/5rD7eY22gdMweXq1r2fk/vhroZFelnbm8aWXMyuInmTGo/NdDcuCmSKiGS/23t1iO1Y1OBRgB2LXjoBbIOERO9O5RuAcRn/l1sN7jJXdKIjif/Gyz/qp5ajRnoZZ3Lxa2bKok19G8uB6FJY0DWZl7dbMweaPVfzHwXtkUkAS6/SUspjQPF1po39bm58Rp8+D0oWGzaPWQA23rZ8Z/mVroiuZM9qH9283A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZjcHsDq2DmoNdXHcwvuFD3Qvzf8qtKVB9NAc2hVQHA=;
 b=eYNPjHaFzOZmFihICTHdfbdXI24EVlEVdkCpaUNJpGDe8PaCIHmgLDlX68owECx92837KFbTHzRItSP1M9FcbEk9XUmH+jRGUC9Z/4VVqfdmNxadM0mpr4EzFxRp2TjLpf6p6M/CTaq7WvWGB9n7u9MtTYxGS79yBngcdtl6BfA34tGr/NVbM/0otQ4PuVvrp5RTIKAErPxJfhQt9xv5PkTWhExQvjJpMMwNaN71OnVmOtFKl1zMk2hsFj6wKeq1Vy2n7wytjo4cOX0EH8UFXI6WNdGRyxLt02olmI2oCj/ECuCXghvmRMQUgpmE22fXcbksVLLXp2trBt5/kQZTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZjcHsDq2DmoNdXHcwvuFD3Qvzf8qtKVB9NAc2hVQHA=;
 b=pM34ZHA4P+PjtWgBTpzbbcfgl3uKjmeCSMVt+OdehMGq/c9xywD0irKXjaJEU7c6925sRCH7a6uYzKGJlk0hIYYkV5XoQ2V3GssXOI+x3iedwh680V8HjQZilteKxSSWkJE27oyO4dDrc+TrMSZJbSeThTj+Gz0o4ZjILUylYH4v9S+iLHX+T5m8kJr1feUQocPgoLE4L8SxWA91C9EX4eusEZLKKE2fCSwAcPvO3zy/L3A2l4FBHNW19rGnwcHOgYkjYm42+rAtH3ISS8ZjzVjx52eKh7BZXvd3JIYPDyKVeTSqQS+fCwYgg6T2fqyM9wdIQ9i3CJYNkb5UgWd59g==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 18:02:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 18:02:06 +0000
Date:   Mon, 21 Jun 2021 15:02:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Message-ID: <20210621180205.GA2332110@nvidia.com>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:208:234::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:208:234::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Mon, 21 Jun 2021 18:02:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvOFJ-009mhO-8v; Mon, 21 Jun 2021 15:02:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a2a5532-2e05-4c61-ebeb-08d934deae64
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5505C7A799788BC188B44E5CC20A9@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dKFglOvrEQIN8zyx82ACkII27vQQIXF6f8FUba59w+PsviIwAcfeZKMRc9WGUlWooZ8vjrQrdgmL0z2leciOqjzpA+n4u/NlSX7tFhdHpUFO8LPSHME+HorNJ/MWfabka7W0fG6b+irED++YdocbUw/96IFvCuXIu9KF1pf112/ilTtmzTuVyqu86S2lIsIRfNaUK+06pt9Q5aG8rPNsBAPpUP8rlCZxNz9m4/6yBiGB0fgIQy7Q78mG+XbsJ+aLXQtLQ4SzAFoZFpwPNNIlngoriVKPSMqJzYQ6scz0lSH087Ww1VoAixu4vlg3KJRR2GFkcxGaA+Oi+3Sn5bH9fup5vUI+gpvvjZrg01l40eGXVmWiNhhoBfZ3UgnX4rmfdSFlzBIdSoYewE1fQGU77x9wJIcTnJcejeaZgocluNBLsVo+OksZwYtaQI9rwnXNlVTRwvLdyZ2BxqRtyXK0NoOqQle+QQRIRdd1t6TDPVCAlCIYlC/dXkbeWpGbxkmLLsBAMjl8v2NBzG86/rSmHQNYogfwOwTobNCErTpkMYYC8UVPbEY2q9ZmTp8qN1YovEyf9mVSpQybSFPpK/EbWdRft12JljdurDEMmypKGgsnsRxsAuG70uo5cAxoe3X3WJcHcQQlCZ8s1Iv3AvILTUzckJoMe/Gp64RqABzwCNo+Vmd8Q7J2SeE9n6LgyZ14wcr94hPBXGB+pc/bdUs/Fc+jAA9XyJDI0Wgl5NcAPPP5eQywi9llVQdCwWWyviI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(107886003)(2906002)(38100700002)(966005)(7416002)(5660300002)(8676002)(2616005)(83380400001)(186003)(26005)(4326008)(66946007)(8936002)(36756003)(86362001)(316002)(54906003)(9746002)(6916009)(426003)(478600001)(66476007)(9786002)(1076003)(66556008)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JHi+LAJ6Bgj+Y5O+i8yTqqLjUTtM4fKuSeytWZxGuIE27wnRAuUUKQuge3+1?=
 =?us-ascii?Q?h2EsJJidsJt+jwGm/KaG5qzRAkmWQTp2yqoPsNn+IvjLoIx6TDEkosN4f5m2?=
 =?us-ascii?Q?AW+Yfgnh/d3hUbCp0PkjQyakFSGEW6/mj4V57d8pNN4YGttjyz0DANdBtOZl?=
 =?us-ascii?Q?IJcY5FW1ZutVYuh/dev/2MK1eULxWjPr3qGE96H+U/ELl5Ch8TOSkRthQMb1?=
 =?us-ascii?Q?uu5Ml8ZIyI/8jQ2UmfLZuLUgICq6pq5EJvB9RK7Pij0K6qiGaR7AqDM+inO8?=
 =?us-ascii?Q?+1Ux8r3QrahHslylSTX9MX3LcuzgfQXjb9F/PDxWisdIy3qHK1mg2+Jg54ot?=
 =?us-ascii?Q?kInZAfJ00hnb/g3mzEkZ78nTyZLCpF0BRCJVpEA9s0P7WQduj/quSsNrM+0S?=
 =?us-ascii?Q?be/YRVNxvT1m52tLCI41YPuxmcl7L2TlzI+mcUwPc9/c37bxAyfRJ+cQ+4H+?=
 =?us-ascii?Q?CF3DhaADIjdxq3ZwhQPfX4xbFeBMuol9OtuGaUqyo9LW9/cdIdCn7od8cWi1?=
 =?us-ascii?Q?ok/QkoTMp/7ugMOOo2M0LmcAxvvjEvOZnlfVXIpSjGOz0EKdaxA05DFzTyPl?=
 =?us-ascii?Q?5exTb1W3nJJ+miU7XA61f7J7NVTMDKSz4xZhdV7CtHO2yGf+v6WxHnhLVbXC?=
 =?us-ascii?Q?WS0Z3SP3a9MIVcTEK+HzKW0gbxm9dtLUsq5WCpzze8G4JNeVz7K351FSV0gz?=
 =?us-ascii?Q?e2otZQJcDPb1bBHF4qHnS9r8fMASo4jIyWE4j9VMuf2TfUzPf0GGLeL1i+Ri?=
 =?us-ascii?Q?C2hrvB7yrMnjPbeEwLAjs9MpGjc/8+X1kYV1kuaOR4LbJcB5mOVbbGp0j0sP?=
 =?us-ascii?Q?8t8JKrn3bvBaotcwEL46XsVFW10Qg7/sNfIdzzryZjwst++cAMMiyEjThb6a?=
 =?us-ascii?Q?+yQAjXkL03efv7esLzVSl4S6w2+O43U71wK7zPm/MtTT3Gv8by9P/XGVgMW0?=
 =?us-ascii?Q?W3QX96pVJ4efBmYj8k2+4dcAjSF/HVluIgVm1iYlcFwzRrkOewQWWUCx4ZYE?=
 =?us-ascii?Q?Vl0zrOpF/MRGlBV7n8Kn4LiaZ0aC5coDSwT0TEwvFKfvaNhvjs3sNvqySx98?=
 =?us-ascii?Q?Iw7C4+KJeCYa6JDBVXi0Nay6ElaX09gROvOWiHBBbli1nURXV1cH8RtBn4qJ?=
 =?us-ascii?Q?JCDI6FQ9Q0jRpHbPaafUPRKfNZQWFz2s9wy4xN0zMyv8bbjA8TfOTMEjJkpm?=
 =?us-ascii?Q?wtVBO7lOpl1lsDFwn71CfUQODngcvXPNixUar8MY5ylvLdSo/akBKsWrcnIq?=
 =?us-ascii?Q?GCprlFSjKmisqeJPAWlzt2eXciAQStuB/PehNfz5CLjuyaQiH9HzigsUDqwj?=
 =?us-ascii?Q?+5dVmRa8WR99TpzpUbIgo92u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2a5532-2e05-4c61-ebeb-08d934deae64
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 18:02:06.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ws5L9cuPc8V6rqVFDv04SQ9a5gJlQ2mzPzA22ymjOO1Mb6SJfoHc/1dpih1Qf0OL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 02:05:03PM +0300, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Relaxed Ordering is a capability that can only benefit users that support
> it. All kernel ULPs should support Relaxed Ordering, as they are designed
> to read data only after observing the CQE and use the DMA API correctly.
> 
> Hence, implicitly enable Relaxed Ordering by default for kernel ULPs.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v2:
>  * Dropped IB/core patch and set RO implicitly in mlx5 exactly like in
>    eth side of mlx5 driver.
> v1: https://lore.kernel.org/lkml/cover.1621505111.git.leonro@nvidia.com
>  * Enabled by default RO in IB/core instead of changing all users
> v0: https://lore.kernel.org/lkml/20210405052404.213889-1-leon@kernel.org
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 10 ++++++----
>  drivers/infiniband/hw/mlx5/wr.c |  5 ++++-
>  2 files changed, 10 insertions(+), 5 deletions(-)

Applied to for-next, with the extra comment, thanks

Someone is working on dis-entangling the access flags? It took a long
time to sort out that this mess in wr.c actually does have a
distinct user/kernel call chain too..

Jason
