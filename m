Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B913F0996
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhHRQuK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 12:50:10 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:56929
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229780AbhHRQuI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 12:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6msYUFsHZbY7aTXoJIIg5pM58tqCcoPH6uPA+v9iGot7a++Ot++jj4Q5D8VfTAwBv8gdT6FZZeIrlejAL3sO0WYeaXWt3bMcM9cjSkYYdumKS1SAXC0YJnYryp1NFBA0U9t9NoDSdPRQ3XiUpyxtAdQ39JFCuPZsZzZX8X7AZOISxW0L95dhp3FNotaUJIZd0uWCRjW8JgjZsKSHeCZ6TI/gSS4cjy32ugrqcIMb+a3jMSyYlZZcDE01G/eicp9PewLdSNJYLM8fMOLHaomRUvZHfQsniBJDQKi/EasXiSy4RFGu03CbUEM65BzFPy7dsccorbspjfoeU2sd18Unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EwccWJSCM645fxW6tXYU5kHVOPpX5IQVwSm4P+Bx+8=;
 b=LejpeVTJtVlA77LiWdiYaRGNUWyzhRI2hieeccsr2NIrk3HvdTKvTiuUqdNPaMcP/a3AX6MriAjdR9FlpfNZeGgWM2tUAaskl1VM2KYWByP1jTo0qvFn+y7GF1KUgIfJmu3dtbfioyBmdJ6VZJu5jt5slWTppxrHNweEdKEiQWsorZ88CUO6wRQXHSODC4/3bLnEDysx6+dRnui5Ywy2SmvbEibssdBuh7qIIYyRBSszKwxa2lsAPi4sMhb4OMIMka/M5j2wyVwMk8kq2zHlUUfGHsaVxshtmDyrx5LUul82skjfKOXwd+f1LQwvut43RwFO1IaF1vEoxiXBbEFMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EwccWJSCM645fxW6tXYU5kHVOPpX5IQVwSm4P+Bx+8=;
 b=ieZC+s/gv+6rnck6ll1LQChlY4aDSsWEGfUUE5fKnIyfBpnyad4bZOmFnBTQL4Z+EO+OzLUBviBlnKF0PzRB2+p/9U37Lu9WgGlHnfG1LHpJ1RQU3LI7dJGifbcz5S/e0tyicrH1dL6sPEbUNFikW3bsYcGz6ElkgvUZvjDKC+bwP4cFhfaJkVG3p5GD3UeaSKoxRytvHKQLPr++1IfAOfCOM19KcZxvHvWRm4keU2+HGwABl0EiomYqjhnGEfQHXaMrfHN2yvXyiY2P8ZwfJr1xuIUOgAFkKfn9BZ0e/GwWaEh9dU2IH7qqn1Qx82WHCmKtfLix0ktoTTuS8PKPpA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 16:49:32 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 16:49:32 +0000
Date:   Wed, 18 Aug 2021 13:49:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier for
 doorbell optimization
Message-ID: <20210818164931.GC5673@nvidia.com>
References: <20210810115933.GB5158@nvidia.com>
 <20210813222549.739-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813222549.739-1-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: MN2PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:208:23d::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR06CA0006.namprd06.prod.outlook.com (2603:10b6:208:23d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 16:49:32 +0000
Received: from jgg by jggl with local (Exim 4.94)       (envelope-from <jgg@nvidia.com>)        id 1mGOkt-0001ir-6A; Wed, 18 Aug 2021 13:49:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d69b529-ab10-4d4e-6e34-08d962682705
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5158675B8807DC665BA4A445C2FF9@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFL4q0KAX5PH6HsjDxvuJGyhLn5Uw8D078uV5SOcKMUj6OuPwB0xbb64ZIF1YjescXoQMAWiVDxTeo0l1lglQE0QCfm7fIMsumDPdvHvrChVTENBtpzR1QYnXYoz98hWM5PVdgM06q+fWW+ka/TiuJ7e3SDeIdkrtvChBi3t1gqH7o4HMt4ksqdO+LAf43sqUTIZs7PHr/2YaXjB6LblMffEi3TWMIdGcWFN0Y+RUUjB/BzAVJpUydr+RT/1BF8eEoV8mC+gC5xmaB9j+4XEYHJxuKFUzF8ACay/9YiTF9gv3Pr40L9p6RpOzt4BiB039hUcsUb65ud8lS/q7UvxdAVfcQ0+GVvPmpgkmlS8mwJU7pACQIplivSu0F3hVn5oJadE+KXXS9reeR4/8VUJtTnB3JsQxTBD3CeLT+irrua/WNlsLocxkDi5sgoabUYHJYg4hypP2R1RKYFVeA6XxjR/BqPkiYL1/Bv2Plj67iR45NJU+QvZ39yTtruOMrzsNoVQqKYMconkzRzdG731g247/9o81uLD461LNDj4gvkppv5EawzEapsM6saAoOPKVT4u21ScZEurS+X1BkUZUnQ969kO+KWC+X6Wn20bqWG1R1rNHHVhxnjN+Tgt0jiKaZQWSq/OSlTeKSSvc9+Q9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(478600001)(9746002)(9786002)(1076003)(8676002)(186003)(2906002)(426003)(8936002)(4744005)(26005)(6916009)(86362001)(5660300002)(66556008)(316002)(33656002)(2616005)(83380400001)(36756003)(66476007)(66946007)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?or8a3fYRnbvzg6hVwsoXJA9mNahUOmnjehLtx53I2r5/s+Do6yADISz+0yd7?=
 =?us-ascii?Q?Sd3dLGzcRnkhwmYyhZOZ4a+XoywKyVb4rPsOHhEEwW0xPGMNVF3Xw2e3mp9t?=
 =?us-ascii?Q?06QLUxJDmSp9aDtEKJtN+PeFCOnBhlFjFICnoYABWOq14ewE6u25tJ+njucl?=
 =?us-ascii?Q?wTICBX4+Xgg+TJqeyJYEG7N/B+eUhEjuD85WUKgCwofR1ozp9ZtLmD2CK/mQ?=
 =?us-ascii?Q?UzfWG/lbeBgU9nS3GjS9Iv9dDMnA173AgrAs3b3VxcxDUGZYHgBQTqp4lFdN?=
 =?us-ascii?Q?uxVsrcoP2DskroPAmbX0uQ2pZxseKFJJW2inSSU6cU8lFuMkmEZP+v7gCWXC?=
 =?us-ascii?Q?fvgwjZhPtQiA+eNcwSed3p5LkFo3+APRtTF9QJqCHtLACqd5rtfyIBJQOwzr?=
 =?us-ascii?Q?OGAY/PrSYO/RM6B853ysN3aAWz9nQOQaT16e6odvdTTTNgcgP5kLEJLQABoJ?=
 =?us-ascii?Q?/rVqh7KSsYkm2iAiMkqARzc0O0P0e2u5bnz4zTDaGUbBfHqhTNu8Jq9hoJH6?=
 =?us-ascii?Q?ofXExfLY2dmR/OW5Oy2VErc4YGyHXhR+6WkwsK0TPhzLKXqDgwGj/yId+Mfb?=
 =?us-ascii?Q?QZHVNPUOLr5s7QXVIKr3f0kqZYVJwqNK+fbPHtt2D5gTum1ZDQ/9O2FsdRz9?=
 =?us-ascii?Q?LDIYWVDFNoEK7OKEdVErv1HF+Y4lWPCs7xKmZ8GnBE0eQ1Vu/0r7/KdVkN/X?=
 =?us-ascii?Q?Uz7lweLGhgPjKDEYVDEaXGPXOR5bcTM1vaVZTd5MzME5rjL17nvJ2FYO1k6y?=
 =?us-ascii?Q?TsaFVml04gFGR4Zt/lgGzP6qdA1F1pUxnN3j8nIEkYG58cll2MnqbaweqSXj?=
 =?us-ascii?Q?Ki491ocdJj3SRY3sQtMrvFev+IzoobHBNXKJeAmdLIx6wNrrPCt8i0wylikF?=
 =?us-ascii?Q?qH8BIT1M5d8MCmwKnribTiAKQzJoVAhReep/pQaWrIs5vZS04oVDpp2f0ye9?=
 =?us-ascii?Q?pkCNR977Dt6zxqAvd0+IcNyZ+FgtD8kL8MsXhvnBVPloQ6evc24/jxUodQJs?=
 =?us-ascii?Q?VUQ+VYXlGS1f2RqbXjduSU+e7fD7+/JSZGJbgO9AZO+fG2OC7fO48WEgUWkr?=
 =?us-ascii?Q?+ceP/fY79AieV7bB3aISYuJ21bsCps48TFyr/xPMVqLbyzmCZkuHr5PgKMg+?=
 =?us-ascii?Q?mthFTu8zA7wIa07Kddli6iXWS+VcJwlKZWOfFyfMT1+yiA24Ht4Ywuqgigfo?=
 =?us-ascii?Q?m0BM01zLPie4QooXUoYimW8sUMW5TDVQ/JUwKGMNvY5h6Qu0wuqupYm3TMBl?=
 =?us-ascii?Q?W1zmfXEvchU2xg2HfHbFpbKMZUl5QORQL5hRWT2MU24x4RUPYTb2vk077lVx?=
 =?us-ascii?Q?i3A3zfnCVU5VZnUTOnZ0dXzh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d69b529-ab10-4d4e-6e34-08d962682705
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 16:49:32.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWQ54j9XoHjdUMSZfWvaaXd/pfoERVt8CZwr7+U8uaQG8xvQtpqQtfsGLO3gKJ95
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 13, 2021 at 05:25:49PM -0500, Tatyana Nikolova wrote:
> >> 1.	Software writing the valid bit in the WQE.
> >> 2.	Software reading shadow memory (hw_tail) value.
> 
> > You are missing an ordered atomic on this read it looks like
> 
> Hi Jason,
> 
> Why do you think we need atomic ops in this case? We aren't trying
> to protect from multiple threads but CPU re-ordering of a write and
> a read.

Which is what the atomics will do.

Barriers are only appropriate when you can't add atomic markers to the
actual data that needs ordering.

Jason
