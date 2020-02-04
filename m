Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB4151AF2
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 14:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgBDNIR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 08:08:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgBDNIR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 08:08:17 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5132084E;
        Tue,  4 Feb 2020 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580821695;
        bh=/ODGq8tpY1Db9vh/EeRRku2507WJOe1O2MYaHTrh+3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hbexVBsRyQm3+Wgb+5IvX9AIzkkggG9E1j1QjD9Wt2e9mYtGF8/yinl0wSwIVnyFE
         uaIt6fyo6jbEyi+RKbFpq0AmN5sjs9M4jORxeQ1DXS9CmWUn9tsLAY9Fz3irPjZCEG
         77+GRh/eSEbBqoicn4n3mTxd2fJ5uNC+kVH5NoUY=
Date:   Tue, 4 Feb 2020 15:08:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, jgg@mellanox.com
Subject: Re: [PATCH v6] libibverbs: display gid type in ibv_devinfo
Message-ID: <20200204130812.GW414821@unreal>
References: <1580809644-5979-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580809644-5979-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 04:47:24AM -0500, Devesh Sharma wrote:
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
> 	GID[  1]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
> 	GID[  1]:       fe80::b226:28ff:fed3:b0f0
> 	GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
> 	GID[  3]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2
> 	GID[  3]:       ::ffff:192.170.1.101
> $
> $
> $
>
> Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
> Reviewed-by: Leon Romanovsky <leon@kernel.org>

At least with my ROB tag, you was too fast :)

> Reviewed-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  libibverbs/examples/devinfo.c | 60 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 12 deletions(-)
>
> diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
> index bf53eac..83acc22 100644
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
> @@ -162,12 +163,49 @@ static const char *vl_str(uint8_t vl_num)
>  	}
>  }
>
> -static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tbl_len)
> +#define DEVINFO_INVALID_GID_TYPE	2
> +static const char *gid_type_str(enum ibv_gid_type type)
>  {
> +	switch (type) {
> +	case IBV_GID_TYPE_IB_ROCE_V1: return "IB/RoCE v1";
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
> +	if (ll == IBV_LINK_LAYER_ETHERNET) {
> +		sprintf(str, ", %s", gid_type_str(type));
> +		printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x%s\n",
> +		       i, gid->raw[0], gid->raw[1], gid->raw[2],
> +		       gid->raw[3], gid->raw[4], gid->raw[5], gid->raw[6],
> +		       gid->raw[7], gid->raw[8], gid->raw[9], gid->raw[10],
> +		       gid->raw[11], gid->raw[12], gid->raw[13], gid->raw[14],
> +		       gid->raw[15], str);
> +	}
> +
> +	if (type == IBV_GID_TYPE_ROCE_V2) {
> +		inet_ntop(AF_INET6, gid->raw, gid_str, sizeof(gid_str));
> +		printf("\t\t\tGID[%3d]:\t\t%s\n", i, gid_str);
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
> @@ -175,17 +213,15 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
>  			       port_num, i);
>  			return rc;
>  		}
> +
> +		rc = ibv_query_gid_type(ctx, port_num, i, &type);
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
> @@ -614,7 +650,7 @@ static int print_hca_cap(struct ibv_device *ib_dev, uint8_t ib_port)
>  				printf("\t\t\tphys_state:\t\t%s (%d)\n",
>  				       port_phy_state_str(port_attr.phys_state), port_attr.phys_state);
>
> -			if (print_all_port_gids(ctx, port, port_attr.gid_tbl_len))
> +			if (print_all_port_gids(ctx, &port_attr, port))
>  				goto cleanup;
>  		}
>  		printf("\n");
> --
> 1.8.3.1
>
