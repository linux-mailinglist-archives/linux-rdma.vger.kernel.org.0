Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E0B3D2439
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 15:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhGVMXg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 08:23:36 -0400
Received: from mail-dm6nam08on2074.outbound.protection.outlook.com ([40.107.102.74]:7745
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232089AbhGVMWW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Jul 2021 08:22:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TorF91PZiuuQcrNCL+VY8zFM6pbgZSNwCAkswjMQ8qLVB+ovPL56PJg/CTfHukeQD+P6jc1Qq/ItsaK9Gq3gjA/+DcNcg21VjHdvAXzck9yqGJVS7+5vHr8o49T/TVK9yhNwx+qEtPnt6K+nfgF+fXbug/rIvMwBH+t0KaV9uDrFTFJqeb5w0kLPJb2dwa+aKSNJipcU067hRO/mX2uBpifsND4mrTuV8QTplsiPJ3GHvltUW/UUCYMtzVdAsWlTuAoOKiVDZlBuUjU2jQDxbyL28YwA9hMb8yc6A57JSSYcR3/BO/2KKiRH0WACAarHoBD1kY3+nOrS1WM7K6cQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWGWontdgdnmDADs+RnuL2gRNeu0Z28vOFDJnEvVJ5I=;
 b=CJVh2Z1WRwuCIQlLGlEev/03ri+W5Wob5qGeybAOJIl3QfABhLHuT7/AS97nLlmYkZA6UAHI34JYyXBOJihFkOVE2cb46I5V72a+El4HnUDDrJis8SxB8R7RKqVOEE9x12plZmCrRvTGBinaufPcq13WfKKBS0YEkAbg31D3QKd5zH2MwTGHbDJB6PnYRwKirfTnMZQhsAqePA/r93JphNQSrI/9Wz4iR4I+EXiNYsyt81ODS0+LG1jxCBD2caO7NvFbM1dtcnPd5BpiMPzNPDxMfRngd0f+1AX17t3ZLqrpi0hQoLVSCi1W4hpsvaHuNIpCTpgA/mYFNtLW353tpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWGWontdgdnmDADs+RnuL2gRNeu0Z28vOFDJnEvVJ5I=;
 b=WYfTFTLolDqgdmxkvig32/vkpVndTDhvmSu1F8Ub3BRUkQTJW0RBgvGMC/NQsKjaX3jTCIyTmtmW9AGoeZs5qWtsUrS8rWxwGlRyC9hBJx+cIYd04bPS6r1OSS1GBEByUJO1BqKZ4/nLA62jVcBLovVrMeQgzr2ddYWKVQuKFOfFGOuzEiBogK182Ipsfopv4ZXq9nzy+KEKMZkaimG805yL6ByYCWbTqwaH4lscQIWcRjvC+LFqYz6Pjdn+oRp0rlPv405MJKyWhcl0reRd+jf1MZpsnhoC+tRmZ4AL+JRzYLauy4wRt9+dRkvSuh/wGl+PnTpGtLoVe/wlvZPFXw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Thu, 22 Jul
 2021 13:02:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4352.026; Thu, 22 Jul 2021
 13:02:33 +0000
Date:   Thu, 22 Jul 2021 10:02:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dakshaja Uppalapati <dakshaja@chelsio.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, bharat@chelsio.com
Subject: Re: [PATCH for-rc] iw_cxgb4: Fix refcount underflow while destroying
 cqs.
Message-ID: <20210722130231.GI1117491@nvidia.com>
References: <1626866515-17895-1-git-send-email-dakshaja@chelsio.com>
 <YPkhhDkvYY2JVM+6@unreal>
 <20210722120607.GE1117491@nvidia.com>
 <YPlrQ1Uu+OXxRJBF@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPlrQ1Uu+OXxRJBF@unreal>
X-ClientProxiedBy: MN2PR19CA0067.namprd19.prod.outlook.com
 (2603:10b6:208:19b::44) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0067.namprd19.prod.outlook.com (2603:10b6:208:19b::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Thu, 22 Jul 2021 13:02:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m6YLP-006DUG-K6; Thu, 22 Jul 2021 10:02:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dde7418-2b33-4451-eeb7-08d94d10f822
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5238DBF7C08AF190174542C4C2E49@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5fqTrzQAvbEK3wWPWV9CAQ+x7nkJW3Gh41nOMdfn7QDEjHgfAryph2mqj1u9pcUDpTtbqcQ982CyW7l2SDrTPQd5NiMhkvFhbvSqsa+bOJ0tKXi//xibYDkWmQ9L+b/Y+TO6ODnldRF/nOk4mZTJMKQlRNU/WEtSF9QaIGhKzfLfA2xdBacibXwFUNGtSfu73YWwWJNB39HvVkcnbzXXu7zSWmV5gvpMGsAbZNSeuI8IdKrqvhA4i2dsIVWcVHkFYKhU8Ql0m6Doy0rIN6IXwF+wUz/eVyMTAfr7TYRuJXyBQPFjVMpugiGamlasEeyLJ+Vf7ej+hQzP0uuvo+tU441CpauG8TWhD4qt4q+jXsO03kWL3b6B0cM6ahA8/vhzr+7T1T3B/cTqYTNsbZlOAY9/H2eS+tXdPPr99IAOAc5JjNnKxMdokeqllftvrh56F3ZByD6VzMgxc2/ttIRrTppUr1pelzl9FzczqKpy6uppXU7dxXfADAL9rkmrNHsr2EttievWOUl0G2AerB09UKvT7CNr116x4Ib8RIqG5B6Tg+tXYHRq6+uq7/oX45yLWatCd/FUqfqrmr4GdE42UFGMzxVO5Yg5DF2pkDM5z56rwliemX/rUIsLz/EvhpnNWVjCbkTh+GXCJ+to5yHhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6916009)(4326008)(36756003)(186003)(316002)(86362001)(9746002)(9786002)(4744005)(33656002)(1076003)(66556008)(66476007)(66946007)(426003)(2906002)(2616005)(508600001)(8936002)(26005)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R/SDVNbHzn0Am3VjxgiryG6Q2ko5ET8cnA6Z+WUMHHEYa46GddhoHPy7bmFN?=
 =?us-ascii?Q?r8aG/4dZwJRfwY4AThwZdshikBIxmeAaI3KJZzBISAGQn1eZm3qzmJK+4Duk?=
 =?us-ascii?Q?LUeM0lEiEV7LpkALN1ZNA2OT/DmSXzlK+xI+2TYkQPUIZnDadR6r1pavIcz+?=
 =?us-ascii?Q?kWThEyX9Uxm8Y3XlPuPQHgdk6OSERDohyuYkuH1CuFzmiwtJ+k1uh3Mwfbgs?=
 =?us-ascii?Q?uN3yO+c+ImM+C5EkzpArr9ZT8AmVAHEhz4JQpACzsEiYmdfwCvC3RoCKqRi3?=
 =?us-ascii?Q?HdpmAqhM7b1amVAPGk7lM/v7RDRwY8pnuMFko6dZdoD7pmBJma8g7TFQgw18?=
 =?us-ascii?Q?kgAmFLzVCaWnwfJVDi4tVs6emfKYDjQztx4S3PQp39vstLYibxvhjtWOMeVE?=
 =?us-ascii?Q?z4mEsF9B93qbpTWHKAiXDwaUUPqjX1Hhq1zLQU+wSHjr0uM4t6zKnCBZT+1l?=
 =?us-ascii?Q?WkeJfmk2AU4tVbgLgncl/8m3MXPmrimn1aU+CtbF7pbStPlAUc8GyYegKYbq?=
 =?us-ascii?Q?EpaKst9BdTLz5N4NRvwHFumlu4UDq0xd1q+Jn7G/96grNkgHSOiiifo8zMOh?=
 =?us-ascii?Q?oSi6kSB89ukHofApc87coI490VpZplcPg3l0wf9t+kEj8iXUf2HNtAxaG4fw?=
 =?us-ascii?Q?vxoG3R2LYWShb0qX0r11ua3xaazUoHK9Pj6tBW0zQI79BhVbFdrt21ylnGRk?=
 =?us-ascii?Q?T+y5VyfPbiGtVR9tN7xqLrSNKrw0v0Th1jml0wlByHb79aaKAykyKgyYRczE?=
 =?us-ascii?Q?XH5vqfiwLY5gkn0SdSmcoguC8JuKJha6oNKb6Tdm1W+zn6keyZWOfP1umIls?=
 =?us-ascii?Q?plvhB3ZfO2WDMW+h49FccKR6nfCc1B7NwV6rI3YXePskKBd5lB6wWYAJeke2?=
 =?us-ascii?Q?GxGXFx4VnknmovdbFTdgwFvl2dL2o1ST0+FQA2/iy3jJZbBrlP0xVrffrwbY?=
 =?us-ascii?Q?56lcLDh5ytQKdBn/bmbh6h5jeuf/rOyv/GXZxpx0u1v6xapFAZlmaaqWmf1T?=
 =?us-ascii?Q?3MDGKjV/BxnYiKx0xxuoFfMkEDeZ8+Od1id3rzDreCZqsG+GBPw01Wt7EKCz?=
 =?us-ascii?Q?73RlrRNGETdtRL/r5Dr3FT7VD3vldLkdWHqwi1T4uMJtq4lwUGh6nFrLtK6D?=
 =?us-ascii?Q?6cUSa2+jPZFcn+sKznAvzrmTXFkwP+ux4VSdSnwh0zIvvAU9sjsRrYQCSOKi?=
 =?us-ascii?Q?/KptaZYiJGgykyouma8FgTt25P2KsacFogYOdoer4LBaHP7TY9WUknPxI8Xz?=
 =?us-ascii?Q?maUeOv16KSnH774egTODQRAWLhgqyqDRBHMR8uObByi4thDAYeaz2xN5nit4?=
 =?us-ascii?Q?YJeNbivV81Ekin9EauaKs8NO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dde7418-2b33-4451-eeb7-08d94d10f822
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 13:02:32.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EUcVWia/JRP1spYWKNEAz3wGqe9ZVQ45A8tM0r+ONE2adZ4O+791cmhlyPzrP/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 03:57:39PM +0300, Leon Romanovsky wrote:

> We are talking about two different issues that this refcount_read patch pointed.
> You are focused on wrong usage of completion, I saw useless compare of
> refcount_t with 0 that can't be.

It can be zero. Anything that does refcount_dec_and_test() can make
the refcount be zero.

The issue here is that refcount_dec() cannot make the refcount zero as
it is improper use of the API.

Jason
