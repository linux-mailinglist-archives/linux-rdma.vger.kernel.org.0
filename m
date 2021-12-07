Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3820B46C39F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 20:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhLGTcF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 14:32:05 -0500
Received: from mail-sn1anam02on2087.outbound.protection.outlook.com ([40.107.96.87]:64304
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235422AbhLGTb7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 14:31:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlAb+npWtikRMl2234EwCXhYpcnC5TCmSltOV2U+74ymOqUFygyeOsTcHKHx58uWsHG0U/Rws5tHJwbqh6PeshnrjRo2+GV3YRAneEBVJ7M2wtFOPQDtxDSA0P+OPBOK7/R0AnxS4yxDd03BHhIUueMe7HWIbbQA00ojtN2k7qouH8dYwvt4J+sRuE34TmdSIF2f2rIX6sY3q2k9zRCg0SdKpLkhOupgtEBHV9NwXXmk9LPPjxcZnPIJK8DlUmqWeTZsS0gMh2RsZmEegU7WGobcuovJIrokgLzKH4Zp9k6cRo1dT7w3A4+kb4hnkMartax2fMvgTaH18H2cF5Mkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzLnO5LrgLIX++6q87lomIwNymd023R8ufhvcT+kOv0=;
 b=j4bmZiOR/lgKAAzYuCAjMNQokTXLzFE+xIdmlM7ml7SFUWgktfJ3R+pOYJB89B55ZAIcD9ju9o1Ur81pDZDWTUxgoFIK+xA3bg2xCDSOHH23h2gu5UHDydvSmobNNWiDPEUf0aOCeXeO8HaNqTL0hBIvpIZowvlow3CBDAmTGn2vhvndl3WVTLqMr4IrUS70ewr9QB+7WAhA8R8FbV+jwtR7A4/AIaX7NwuooPmBIqlG/Q26f4wWeU8wXF9Ii5fL6e0mlAN8CCCxUznFdlEOHLoNb1uzTXW2Wkal+mIWA78ftqKY9p1QD+2psAqm1ClPyfw/IKvl6BrygcQL60VCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzLnO5LrgLIX++6q87lomIwNymd023R8ufhvcT+kOv0=;
 b=jNmkaKxdmmA3Oq6lQZ4Z4tqCn02XEux+O10fH2JI7SHEgWZ0l8L9tCURNAcIG2YjS8t8ckzYLxIzDwc9Glq0yDwS7jNHNGNRB0njT6Qh1xxjwOBzOEDHIsMfWDfn81v4E9AwH71NdwTxHhOMrBAOVxic1+w2RRStW42kE3NHzKaq/Ar+i1hW2la5SXyPzLV8BE9q2yKrhn15s9MSgnoWSNNUCNRg1cEREcH1EZbACAwMmNoOnOBnsr870BdpDHezzznOdeN/vKuxCBbugFd/0JsZ5nhIEsvQHm97mTbQqgSxqP6ugvCAWvSxRnOIKLyYomUHxyOZwQO9bjJAT4HVmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 19:28:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:28:26 +0000
Date:   Tue, 7 Dec 2021 15:28:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH for-next v6 8/8] RDMA/rxe: Add wait for completion to obj
 destruct
Message-ID: <20211207192824.GJ6385@nvidia.com>
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
 <20211206211242.15528-9-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206211242.15528-9-rpearsonhpe@gmail.com>
X-ClientProxiedBy: CH2PR14CA0009.namprd14.prod.outlook.com
 (2603:10b6:610:60::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:610:60::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 19:28:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mug8W-000Wer-DA; Tue, 07 Dec 2021 15:28:24 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83ddb1d3-1df6-4b7c-84fc-08d9b9b7bd85
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB503192B5F37AF399A2B54199C26E9@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRTeEWkccpXIbRMAF0ZLioDofOfCJEFxph9OF3LuWM4Ci4jG/ocP75JNPXyyliLxxM2CYd9XLblDACQ+yuwTlbaWKNTsfnNpXFB5KE4W+75K3uRrlIg8wy0u5sArU6N3RS+IF1CUHQV2EnUNtmDRLD8s0zLoQHWTM3ZFXMNHFMTnYosh/MjfRxIFUMqmm5GU1m6OIITzPqZA65PQhjUu54Xp9UYblH31ZTWL/1qwgfo8O9+9Gqg/S93m8RQR0dNxmTKAgx3+f+JRaB9sbRQIeLi/0nFvB/2T7ffqq0y7PjGN7ou+HZRPZUmDEV6rP4tiVNX59knStg4pFX8rQZ8wAAqsWvRz6+KMVgWfXSNh/nxVhmfr1TRY++yrXTjroQl0efA/hb2rd1MNOg+CfxA1FYYwiUO+Yrq7w+uHN3rzPhsRXRxTXNS7gMQSlEyYeTHUTk7zU8yEnM51E3yeuA23vYSkiRhj3ZFf85PUtHMjwvjXsDc2AxZ1lMkvjMOmMche5dyi+bZe/mWP7l9JnCQBuSYXmbUHCd1fGTHglfzDLkMzcMzoFFaTg+8IW0+PNrZ27UFXYaJWcMd84b4xK1EgW4RYVAdhumrzz6D8jZnJ3nGPAyPpT3LJm3ftsEcVrRiSDTOmgLDpKUdulZrP0aDKTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(83380400001)(316002)(8936002)(66946007)(186003)(1076003)(426003)(26005)(33656002)(4326008)(5660300002)(508600001)(38100700002)(2616005)(9746002)(86362001)(8676002)(9786002)(2906002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+XfDZc+RzXdJcTDX8AR6J3VlOKUSfN04UTOtEbyS/hbsOK1FOnmYGDEsNEd7?=
 =?us-ascii?Q?IvGLFAxpIYce/ZhpP6buCpxhohLoGPpjy+UEAUBEe+NNZ04o6dZbdpIbRwin?=
 =?us-ascii?Q?sW8OuPZZwMUKQSWfG0/iGlIS6E3r1GexVfiAP79Et9JDG1/97RJ86yoiiiil?=
 =?us-ascii?Q?OkhwHwn7cTXPmiKYv/vDWRV09Vv5jOsM19jE69ZzUSiLnm8/I8nHJTw2Fe7U?=
 =?us-ascii?Q?DUId3aiMmcR0VbfH3I7OZLtXrdZJaX9wjbh+Erp7fczeSVZ7GTgFJrfv90De?=
 =?us-ascii?Q?tyBYMlRIT+nVrx6sLHhERDH2ZcjDOmxGEuCxLjNs+a1+cOpsrMIOQJGI11Eg?=
 =?us-ascii?Q?krwk2lASts9zS8HBQouTO/g3OoGZRFOo8Bv0VY7N+1cq4czExKA98cpOyN4e?=
 =?us-ascii?Q?FyxSaUwwPcbF9OVQHyDsdNSbPIv+qKVG5FU742Sogt+eiVCfwohoJzuJYfFC?=
 =?us-ascii?Q?fsID9KDfK48ObTNRwToDTmvKTf8AblVqx9tQOp7JhE4pD6Rn5a1VVDXb3yGk?=
 =?us-ascii?Q?AUW13GJtpipIx5wvnuE4DtetY6shM/SGXXHfotOexjaD+4QY/l3oJER+vD2o?=
 =?us-ascii?Q?iIj5uSoloKYQgz4sR3Q60AYWeYCMhX3hZLa3q3vbvfhP0QlMrtKxkw8pTnJE?=
 =?us-ascii?Q?6TV1b7YXLdPCuvd3Itr5JhtFR9eKfI8pg6iiwLYa0b2fTYsMHq8rDKkUoX6O?=
 =?us-ascii?Q?KbTOP3/B6rmpIoW0j83TY0mvnDb3e4lLfoeDsCbpRRq+4xQYz+3H/7Bsx/c/?=
 =?us-ascii?Q?GkVVz9uiWob9ZbY+YQ8E/fK6UWDQGZ4Q4EciavulOrMtFfu5oKP17eUZPdIV?=
 =?us-ascii?Q?G0SRYv4cjxAwCA6CdmSVp17Enyv8V80s+Tp9908XdyNgATKCeqJjcQY7J9LU?=
 =?us-ascii?Q?/S+OBHPFYnsGr4cP+4nUzKJtenHfiwB0tZ+fyAFEQaPkA4ElJgI0IyZg6WMX?=
 =?us-ascii?Q?XFRbigigjPsjFxba5dEpL/MLTBYy6TexsHSNVBZPpXvi2Hab7gPhCnuQmbR9?=
 =?us-ascii?Q?xt45+KQbkO1j3PlOvBVRqVtg3+w7FWsegQsKEKvJymvrl+NWW6+ilnAUHHqd?=
 =?us-ascii?Q?QsgvYx/F/lneE29y/1yFFDHNz9Sqxl3re8OesmnrSal0bNfHrK9Wcs1hQt6u?=
 =?us-ascii?Q?Idz7pM4MlHlruOdMtkcNVkAa1lW2w293yNNpBSqFRXmsA17XFwK+cqe6Lw91?=
 =?us-ascii?Q?fjGu2wwIQ3Phrl15gDzi6Xjxv12qtP6Slxhu/fx7/EYQrU569ZZV0LuKY03o?=
 =?us-ascii?Q?5MTquYPIGt4jPSZhG9vJ00NkNCOzqe+dnvgAnbcmNtuL7loS8sNL4HMe+msY?=
 =?us-ascii?Q?vG78aX2opx1YsDWCcgbPzmtljPPkvFXX8k7m4oSIEr+Odx5QV0t2moNCGCPb?=
 =?us-ascii?Q?yJBoDuw3Dh6/mYr1vmUevnc7yFbllPsfkIX2x7nHOtzuuuxCYANJr/jdDzNE?=
 =?us-ascii?Q?MtR0sufvE4WaD36ebrLjt0ZehDgQFleSOl1JQJq4A4eSZV3aqhbPS2rnaFqm?=
 =?us-ascii?Q?29xlnwt8FmQ1DZwTwOqeS/84vzCmSgn9zpMCLPjIAuRV+/U6G8d5sqguLt38?=
 =?us-ascii?Q?+wBxnKG64qkh5YiJmao=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ddb1d3-1df6-4b7c-84fc-08d9b9b7bd85
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:28:26.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aulW8yngbUamfSbAjilZGLw0B0zl2XeMFomGT0OuzX0drfBDpT0bv6/QlF9rDr0A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 03:12:43PM -0600, Bob Pearson wrote:
> This patch adds code to wait until pending activity on RDMA objects has
> completed before freeing or returning to rdma-core where the object may
> be freed.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> v6
>   Corrected incorrect comment before __rxe_fini()
>   Added a #define for complete timeout value.
>   Changed type of __rxe_fini to int to return value from wait_for_completion.
>  drivers/infiniband/sw/rxe/rxe_comp.c  |  4 +-
>  drivers/infiniband/sw/rxe/rxe_mcast.c |  4 ++
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +
>  drivers/infiniband/sw/rxe/rxe_mw.c    | 14 +++--
>  drivers/infiniband/sw/rxe/rxe_pool.c  | 31 +++++++++-
>  drivers/infiniband/sw/rxe/rxe_pool.h  |  4 ++
>  drivers/infiniband/sw/rxe/rxe_recv.c  |  4 +-
>  drivers/infiniband/sw/rxe/rxe_req.c   | 11 ++--
>  drivers/infiniband/sw/rxe/rxe_resp.c  |  6 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 84 ++++++++++++++++++++-------
>  10 files changed, 126 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index f363fe3fa414..a2bb66f320fa 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -562,7 +562,9 @@ int rxe_completer(void *arg)
>  	enum comp_state state;
>  	int ret = 0;
>  
> -	rxe_add_ref(qp);
> +	/* check qp pointer still valid */
> +	if (!rxe_add_ref(qp))
> +		return -EAGAIN;

This doesn't make sense..

If this already has a pointer to QP then it must already have a ref
and add_ref cannot fail.

The kref_get_unless_zero() is a special case for something like a
container where it is possible for the container to hold a 0 ref item
in it.

The scheme you have makes that impossible because the container lock
is held around the kref == 0 and list_del, so you never need
unless_zero.

The optimization is to not hold the lock around the kref_get, allow
the container to have a 0 ref until the release reaches list_del, and
then lock and list_del. The reader side then needs the unless_zero

But the ONLY place unless_zero should be used is in a situation like
that, and we should never see other failable refcount tests without
some other clear explanation why the qp pointer with a 0 ref is not
freed. The above doesn't qualify.

Further 

+static inline bool __rxe_add_ref(struct rxe_pool_elem *elem)
+{
+       return kref_get_unless_zero(&elem->ref_cnt);
+}

Just serves to defeat refcount debugging which checks that it is
impossible for a 0 ref to be incr'd which is proof of a use after free
when refcounts are implemetned properly.

So I don't know what this is all about here but it needs some fixing..

Jason
