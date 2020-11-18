Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA032B7DC0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 13:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKRMoU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 07:44:20 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18243 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKRMoU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 07:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605703460; x=1637239460;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=aHRVIk+7aOzryGfSsZgnW4/sNkfMioXeKu5JEiebpo0=;
  b=fQ4F2i5P/IxAGoAUCCc9zitjjqlWaT4cEs3QiSaUP4PRmkT1IXLJyhHx
   +g2J5qVxJU9bc5o3cc6s8beilBJT5985ixHYAJmy7eJLjHQ2g0xKMJ1vn
   cj1VLwzpnFSMKOc3PyH6ufyYWTDrPWD8DZ3Gv9mXJNCjbOj1KP1O7F3zs
   U=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="96604955"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 18 Nov 2020 12:44:08 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 46141A205E;
        Wed, 18 Nov 2020 12:44:07 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.59) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 12:44:03 +0000
Subject: Re: [PATCH 2/9] verbs: Add ibv_cmd_query_device_any()
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <2-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <bdb30557-27fa-3ea4-39a9-4bdb136ff798@amazon.com>
Date:   Wed, 18 Nov 2020 14:43:57 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <2-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.59]
X-ClientProxiedBy: EX13D30UWC001.ant.amazon.com (10.43.162.128) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16/11/2020 22:23, Jason Gunthorpe wrote:
> This implements all the query_device command flows under a single call.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  libibverbs/cmd_device.c      | 155 +++++++++++++++++++++++++++++++++++
>  libibverbs/driver.h          |   5 ++
>  libibverbs/libibverbs.map.in |   1 +
>  3 files changed, 161 insertions(+)
> 
> diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
> index 6c8e01ec9866a9..0019784ee779c1 100644
> --- a/libibverbs/cmd_device.c
> +++ b/libibverbs/cmd_device.c
> @@ -35,6 +35,7 @@
>  #include <stdlib.h>
>  #include <dirent.h>
>  #include <infiniband/cmd_write.h>
> +#include <util/util.h>
>  
>  #include <net/if.h>
>  
> @@ -516,3 +517,157 @@ ssize_t _ibv_query_gid_table(struct ibv_context *context,
>  
>  	return num_entries;
>  }
> +
> +int ibv_cmd_query_device_any(struct ibv_context *context,
> +			     const struct ibv_query_device_ex_input *input,
> +			     struct ibv_device_attr_ex *attr, size_t attr_size,
> +			     struct ib_uverbs_ex_query_device_resp *resp,
> +			     size_t *resp_size)
> +{
> +	struct ib_uverbs_ex_query_device_resp internal_resp;
> +	size_t internal_resp_size;
> +	int err;
> +
> +	if (input && input->comp_mask)
> +		return EINVAL;
> +	if (attr_size < sizeof(attr->orig_attr))
> +		return EINVAL;
> +
> +	if (!resp) {
> +		resp = &internal_resp;
> +		internal_resp_size = sizeof(internal_resp);
> +		resp_size = &internal_resp_size;
> +	}
> +	memset(attr, 0, attr_size);
> +	memset(resp, 0, *resp_size);
> +
> +	if (attr_size > sizeof(attr->orig_attr)) {
> +		struct ibv_query_device_ex cmd = {};
> +
> +		err = execute_cmd_write_ex(context,
> +					   IB_USER_VERBS_EX_CMD_QUERY_DEVICE,
> +					   &cmd, sizeof(cmd), resp, *resp_size);
> +		if (err) {
> +			if (err != EOPNOTSUPP)

Are you sure about that?
I think older kernels return ENOSYS.
