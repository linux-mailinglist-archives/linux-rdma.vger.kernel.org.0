Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F011A200903
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgFSMuM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 08:50:12 -0400
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:54245
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731869AbgFSMuK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Jun 2020 08:50:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzfipxBTuW2qHOBtlC/VKEnshxp/ChsgcZ7kGc1tbwJP4atSpRurZtMFjHvjovjiTV+8HQz44UXbIWGmH3vFmkWRG3+HNIJcJyo7yWyNAN2Wn/FCo/qdMPX1zV3lJBcFZadBJmQ5aJjiJy1tm7OtSbDRH8EEKMOPL42d3RbmL6Cygp0Lr8TNEAVuq+agZfiWRc1tyEr58ffL8w8ywBzqTdHUGfV7/fPKTI0gww7nTl6cPX76zpZazW49NccQ7sNwV8ICb4YNavj8rrXy3Kk9uAA5FV6vp98qF++SKojGwkoVdzsG6k5QSmYTSDwmQ7MN+8niTCTTB4HSTTv8TQS62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NklI0DHRiVLgNp4HmMpAEJJAVyV20VT4y7utBkiJlR4=;
 b=Yi+J6UFRNI1o+OSXh7E+dmz/K3IvbkdTfBSJjcuugRYZvkc8fWZyRAYg+BZZjK2p8RmlYjEOaKZ0VaelqfX+FXhrM2XCrlREgHKr/pbFdTKXQGRGYCJuF0Pvi2MkOdM2RVna51LKiky/SsFs2TjUcmgjfGy72sxXVq/OxLgP3aUkaOFCoXw6o6oOTaVlSDjwKkq8CnN3m2q3fx0FmFucvaO/sE+osN2bEDhahDgeydFeITa6RPxrB7AA5qvSYtwo0gT/1RuXPbx3ravt+j4hXyo99T0OdVnlmeBwCxeA2bVjaIL2/4mqMOEQ8LToAsBUsxQA+XEvILvJZwWfQvzMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NklI0DHRiVLgNp4HmMpAEJJAVyV20VT4y7utBkiJlR4=;
 b=TW4qwZHDiN1aZLJ03jwaTS8F84gUpCVW2GhRU0b8UanOD2ONzK7iV8S9xIVjJ6PkdJsLxHJXe7jk7tHPzmmk6A1gzh8sBIYLCEVqJV+0Gf+PLqBG2jcRI6dNzfSYTSuUeGR2QQr9solImJPPYOI7goqFH/tTtDJY36AavRnB3Lg=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB3262.eurprd05.prod.outlook.com (2603:10a6:802:19::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:50:07 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 12:50:07 +0000
Date:   Fri, 19 Jun 2020 09:50:03 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, maorg@mellanox.com
Subject: Re: [PATCH rdma-core 10/13] mlx5: Implement the import/unimport MR
 verbs
Message-ID: <20200619125003.GW65026@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-11-git-send-email-yishaih@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592379956-7043-11-git-send-email-yishaih@mellanox.com>
X-ClientProxiedBy: BL1PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:208:257::11) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:257::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.11 via Frontend Transport; Fri, 19 Jun 2020 12:50:07 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jmGT5-00Al7L-S7; Fri, 19 Jun 2020 09:50:03 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7655f583-833d-404c-8362-08d8144f4b48
X-MS-TrafficTypeDiagnostic: VI1PR05MB3262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB3262B4DB750C8F4BA9C940DFCF980@VI1PR05MB3262.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ki0/cIZ+9J5q1ArwS0mnHehjHmOucvq80lFBNLQ8tzwcWOfjMAGV1iq64ZO+a8WB05UpW0NDtAkohYKOvhvYASL/6ikhgUaoje/z9CeZxQBtk2r+l2PuUPzZMNH8Gw4Y1yz7BX3oqa72Fhb5ebWAjEumB7OL5A/4sXrssLs+gGeEyckBxLn8YxqoGIK+NUU9Ismh9rYTNu8jXUBXer2j2k9KdXxz916aCY70R6wj2QhRm/HoYd8uDjEpWMdFBzzcRi+BCaNGq+p4HRcRv1bPA2F1IbMMp42oRZHRJXXl9WrCF45at1ER6h3xT75aq9Gm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(316002)(36756003)(2906002)(37006003)(107886003)(5660300002)(4326008)(8936002)(1076003)(86362001)(6862004)(26005)(426003)(6636002)(9786002)(9746002)(2616005)(66556008)(66476007)(33656002)(8676002)(66946007)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Onlbl/T4XqC0JgE6RG9KB47o3DHLhG2RAGjdS5a37cp+X9myMt2Zov4yOc99vNV3UmVdk+Y+HsK5I2/MJ3XiUefEmrniUc+mwkXmPFc2MkzvujKbTf6nNzLTAyAzicStEN7TuTH/MDc3W3AvJbTMHnGXDULdCfS9yJarPsRN27KSPYPYSOPMWbHf8/VsS+i5ojnpdrPh+eyCQxanEzipXYhpV6+Vqjwa4bVBBmFCLpvpERbdOT1x60yH+Bg1UOXSs858o9h82Vc0BXQeZC5SSiR8lNX4TUq1yl/UF/4OWurmJt259Mx0BzKN/TClVJSOx876tmFjtAa8/BHRjUny4LJWK6umnnhJNeCKr9Aa6qIpcAEu/sk2netuiTtRPwxALpQPLuEPJFUtGbFZP/d4eTmGnrurPBJZAeE1Ary53Q6+3JDkbJWEJhRN2w5ilJdrAYz1o9Cfic/tWocdwbmiQZlYKahUteRYlH/skf9ykLI=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7655f583-833d-404c-8362-08d8144f4b48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:50:07.3129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WInmLezkTK/uLCAALp7UGkbNfO8O8ebnTAVuzXCcImQmn7FUSdzgjBG/DtEZvDtdTeuL6nHFweuTRR7gFD0wsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3262
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 10:45:53AM +0300, Yishai Hadas wrote:
> Implement the import/unimport MR verbs based on their definition as
> described in the man page.
> 
> It uses the query MR KABI to retrieve the original MR properties based
> on its given handle.
> 
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
>  libibverbs/cmd_mr.c          | 35 +++++++++++++++++++++++++++++++++++
>  libibverbs/driver.h          |  3 +++
>  libibverbs/libibverbs.map.in |  1 +
>  providers/mlx5/mlx5.c        |  2 ++
>  providers/mlx5/mlx5.h        |  3 +++
>  providers/mlx5/verbs.c       | 24 ++++++++++++++++++++++++
>  6 files changed, 68 insertions(+)
> 
> diff --git a/libibverbs/cmd_mr.c b/libibverbs/cmd_mr.c
> index cb729b6..6984948 100644
> +++ b/libibverbs/cmd_mr.c
> @@ -85,3 +85,38 @@ int ibv_cmd_dereg_mr(struct verbs_mr *vmr)
>  		return ret;
>  	return 0;
>  }
> +
> +int ibv_cmd_query_mr(struct ibv_pd *pd, struct verbs_mr *vmr,
> +		     uint32_t mr_handle)
> +{
> +	DECLARE_FBCMD_BUFFER(cmd, UVERBS_OBJECT_MR,
> +			     UVERBS_METHOD_QUERY_MR,
> +			     5, NULL);
> +	struct ibv_mr *mr = &vmr->ibv_mr;
> +	uint64_t iova;
> +	int ret;
> +
> +	fill_attr_in_obj(cmd, UVERBS_ATTR_QUERY_MR_HANDLE, mr_handle);
> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LKEY,
> +			  &mr->lkey);
> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_RKEY,
> +			  &mr->rkey);
> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
> +			  &mr->length);
> +	/* The iova may be used down the road, let's have it ready from kernel */
> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_IOVA,
> +			  &iova);

There isn't much reason to fill the attribute here..

Jason
