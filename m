Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E98153E75
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 07:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgBFGIX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 01:08:23 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:6624
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgBFGIW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Feb 2020 01:08:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ4THG6PGMSDlVrpfcW8+nhrVNDTaHNfz79JFCeh4S7MWNFpALh/4xGFQoxbeASIcAJkGp6h3mr7j79vxkScCQn45tjppwzgnyHgzLPNkhJSbacvmwJjyBmAOPuq+176yH6KlKmtGGaOIK4LSp02iXVPXF8qtEc8sFgPn3DmekRX72jKWUobs0VnGMqiu6uJGAQrtCvD+jUHvvtGGz6ULZdaIYaLhDiDokO37DNp34DHDzJfo9nqEa0wK6Bf4CzC5nzbmsSDQ4nOKYT7tZwqid/M6kdSGTexcbaLSyLyRC5sKbZRvar0hlkJp8GLd4HdYxQIoAYTRu1k8MI7mA8tcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjM+TizBrUk3JRUPfLlE/efrYobGOm5tau2ChYsfsAY=;
 b=OlB4o7ixe9V76LGzJze4E78SXE+3/pdLq+xV7mkl+Zf2Hvhl0OfDRy8ag/+CNAFt3VldHbcvVON1JRvgEmynu0bWvTAQPAbgMFbDb5vqwBWb+wO3vJLIL2bgRh61xB3NMOsJWUHPJ9/57Vr+YkwVzD5gr9MPOQAqvvwseo9xCeSNYDgRilrMYMg0LpYNEt09WJ0Ihy3fnfo4s6cmw77wQp0PyPLMM98kMuIPUjlUVI0XX8hrekt+vj/Aqa+YNTqq7Txlr4zXoPTv1oaOvMW+YByuZezteAz5hHVpIB2NmrwnM0L65LR730FXhdQv9DEAYbz5gFPQrlzmd+by/1bIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjM+TizBrUk3JRUPfLlE/efrYobGOm5tau2ChYsfsAY=;
 b=Rj+WHKheswYvAwKJhuH3djnn5ljAUoADwRlKS7ZJ9OttW4d5k8yv4Da057daPc+Tbpwd8y5INKxeROxVfxJhCMTdRSIVFMe3xDtN+4OuK4+vLx1qrkxt/K2TRY0TiVsGrEj5Wvf/bveyli+tEK7tllLx1upgzG2/dEfnidPite4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=markb@mellanox.com; 
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (10.170.238.143) by
 VI1PR05MB4784.eurprd05.prod.outlook.com (20.176.7.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Thu, 6 Feb 2020 06:08:18 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4f5:b09a:60c5:26f]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4f5:b09a:60c5:26f%7]) with mapi id 15.20.2686.034; Thu, 6 Feb 2020
 06:08:18 +0000
Subject: Re: [PATCH v7] libibverbs: display gid type in ibv_devinfo
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, leon@kernel.org
References: <1580967842-11220-1-git-send-email-devesh.sharma@broadcom.com>
From:   Mark Bloch <markb@mellanox.com>
Message-ID: <88498668-9723-9695-b4e7-3384dde76c36@mellanox.com>
Date:   Wed, 5 Feb 2020 22:08:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <1580967842-11220-1-git-send-email-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To VI1PR05MB3342.eurprd05.prod.outlook.com
 (2603:10a6:802:1d::15)
MIME-Version: 1.0
Received: from [192.168.1.33] (104.156.100.52) by BYAPR06CA0040.namprd06.prod.outlook.com (2603:10b6:a03:14b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Thu, 6 Feb 2020 06:08:17 +0000
X-Originating-IP: [104.156.100.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd0b97d6-6873-49cc-acdb-08d7aacaf5f0
X-MS-TrafficTypeDiagnostic: VI1PR05MB4784:|VI1PR05MB4784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB478483A1AC1DD29B0DE5F2BED21D0@VI1PR05MB4784.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(189003)(199004)(2616005)(16576012)(956004)(5660300002)(316002)(4326008)(81166006)(36756003)(2906002)(81156014)(8936002)(8676002)(52116002)(66476007)(66556008)(31686004)(86362001)(6666004)(53546011)(6486002)(478600001)(66946007)(16526019)(26005)(186003)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4784;H:VI1PR05MB3342.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJDppQb/nGFWRSaeja8UzGhLUJwxVXIdY87LiB3ueBrwxUXiEl6yKnTKZvrhe4zgNgbuZLVq4MTix8p5sNH+9a7FQ1lmMkOxxYph1+4NMSAbl6Fpitqubga5r7Sd9xA2lO/tssdGuYu6Wq10rvThTIb5y46LOBwnTzB2UH378Qj6BVqL6cgbaA9OBBi0I5+rhEh8ciYnNyUZ0DgnjwraV8rwkoDXqXGgPCm+/8D043BdkGk0iu5VneIoe3t/grg3gIeqwrZKjISp5Mvtt7pr+JvzZh6mwoqqLNz+1OWrwr5n029XDpTYNviOdjHWOgTfELYb+B0LWvzGz5UQ0PsHL+TUCeRn896AiFuHzLeKyaE83adq8ZvHF5o4cP4AQJOrwZVti6xB1R5DryKRAK/K+kjCE+lIr2463ZC4CkCfi1aB7z8tEUCvDoIIH/8c7FGT
X-MS-Exchange-AntiSpam-MessageData: 7cX2wKLQvATHzOgH7jEa+U6xGVXfNezNzz2E5/NtNJ1/yqKCHbLKhynAQhInB77Dw+UbZXB4xs9SgQbunQ+F4cW17FBD1MLhSJhSEVIHdfO1zDSUeyIVrbXoVuaKL2cxe1yjT2nn4zRNgR3g79PhbA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0b97d6-6873-49cc-acdb-08d7aacaf5f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:08:18.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVmqshMxihyZYVix/urTkUWWrz2VA3HsFo3sGpyU0i2l6XMDHn94q8miLteS/eoWru6vYUmdhTBDPIM0OuTqCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4784
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/5/2020 21:44, Devesh Sharma wrote:
> It becomes difficult to make out from the output of ibv_devinfo
> if a particular gid index is RoCE v2 or not.
> 
> Adding a string to the output of ibv_devinfo -v to display the
> gid type at the end of gid.
> 
> The output would look something like below:
> $ ibv_devinfo -v -d bnxt_re2
> hca_id: bnxt_re2
>  transport:             InfiniBand (0)
>  fw_ver:                216.0.220.0
>  node_guid:             b226:28ff:fed3:b0f0
>  sys_image_guid:        b226:28ff:fed3:b0f0
>   .
>   .
>   .
>   .
> 	phys_state:     LINK_UP (5)
> 	GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
> 	GID[  1]:       fe80::b226:28ff:fed3:b0f0, RoCE v2
> 	GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
> 	GID[  3]:       ::ffff:192.170.1.101, RoCE v2
> $
> $
> $
> 
> Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
> Reviewed-by: Leon Romanovsky <leon@kernel.org>
> Reviewed-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  libibverbs/examples/devinfo.c | 61 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
> index bf53eac..7e2015b 100644
> --- a/libibverbs/examples/devinfo.c
> +++ b/libibverbs/examples/devinfo.c
> @@ -40,6 +40,7 @@
>  #include <getopt.h>
>  #include <endian.h>
>  #include <inttypes.h>
> +#include <arpa/inet.h>
>  
>  #include <infiniband/verbs.h>
>  #include <infiniband/driver.h>
> @@ -162,12 +163,50 @@ static const char *vl_str(uint8_t vl_num)
>  	}
>  }
>  
> -static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tbl_len)
> +#define DEVINFO_INVALID_GID_TYPE	2
> +static const char *gid_type_str(enum ibv_gid_type type)
>  {
> +	switch (type) {
> +	case IBV_GID_TYPE_IB_ROCE_V1: return "IB/RoCE v1";

You call this function only if link layer is ethernet, why do you need the "IB/" part?



> +	case IBV_GID_TYPE_ROCE_V2: return "RoCE v2";
> +	default: return "Invalid gid type";
> +	}
> +}
> +
> +static void print_formated_gid(union ibv_gid *gid, int i,
> +			       enum ibv_gid_type type, int ll)
> +{
> +	char gid_str[INET6_ADDRSTRLEN] = {};
> +	char str[20] = {};
> +
> +	if (ll == IBV_LINK_LAYER_ETHERNET)
> +		sprintf(str, ", %s", gid_type_str(type));
> +
> +	if (type == IBV_GID_TYPE_IB_ROCE_V1)
> +		printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x%s\n",
> +		       i, gid->raw[0], gid->raw[1], gid->raw[2],
> +		       gid->raw[3], gid->raw[4], gid->raw[5], gid->raw[6],
> +		       gid->raw[7], gid->raw[8], gid->raw[9], gid->raw[10],
> +		       gid->raw[11], gid->raw[12], gid->raw[13], gid->raw[14],
> +		       gid->raw[15], str);
> +
> +	if (type == IBV_GID_TYPE_ROCE_V2) {
> +		inet_ntop(AF_INET6, gid->raw, gid_str, sizeof(gid_str));
> +		printf("\t\t\tGID[%3d]:\t\t%s%s\n", i, gid_str, str);
> +	}
> +}
> +
> +static int print_all_port_gids(struct ibv_context *ctx,
> +			       struct ibv_port_attr *port_attr,
> +			       uint8_t port_num)
> +{
> +	enum ibv_gid_type type;
>  	union ibv_gid gid;
> +	int tbl_len;
>  	int rc = 0;
>  	int i;
>  
> +	tbl_len = port_attr->gid_tbl_len;
>  	for (i = 0; i < tbl_len; i++) {
>  		rc = ibv_query_gid(ctx, port_num, i, &gid);
>  		if (rc) {
> @@ -175,17 +214,15 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
>  			       port_num, i);
>  			return rc;
>  		}
> +
> +		rc = ibv_query_gid_type(ctx, port_num, i, &type);

I really dislike this, what if in the future a new gid type will be added (I know, I know, what are
the chances :) )

old rdma-core won't display anything in that index (while today it displays anything as long
as the gid isn't a null gid).

Mark

> +		if (rc) {
> +			rc = 0;
> +			type = DEVINFO_INVALID_GID_TYPE;
> +		}
>  		if (!null_gid(&gid))
> -			printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x\n",
> -			       i,
> -			       gid.raw[ 0], gid.raw[ 1],
> -			       gid.raw[ 2], gid.raw[ 3],
> -			       gid.raw[ 4], gid.raw[ 5],
> -			       gid.raw[ 6], gid.raw[ 7],
> -			       gid.raw[ 8], gid.raw[ 9],
> -			       gid.raw[10], gid.raw[11],
> -			       gid.raw[12], gid.raw[13],
> -			       gid.raw[14], gid.raw[15]);
> +			print_formated_gid(&gid, i, type,
> +					   port_attr->link_layer);
>  	}
>  	return rc;
>  }
> @@ -614,7 +651,7 @@ static int print_hca_cap(struct ibv_device *ib_dev, uint8_t ib_port)
>  				printf("\t\t\tphys_state:\t\t%s (%d)\n",
>  				       port_phy_state_str(port_attr.phys_state), port_attr.phys_state);
>  
> -			if (print_all_port_gids(ctx, port, port_attr.gid_tbl_len))
> +			if (print_all_port_gids(ctx, &port_attr, port))
>  				goto cleanup;
>  		}
>  		printf("\n");
> 
