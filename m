Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C240D15030E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 10:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgBCJNi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 04:13:38 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:12378 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgBCJNi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 04:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580721217; x=1612257217;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aNOxkZbLuFknecRKUiJZ9exwWtIkfMGuwGWFkOSktAY=;
  b=IHZjNuGHtnUI3nA69DJN5UWK5d9XUAekuV4CLXHX282go5Jr2YxMLQYW
   xBvfi/bxSqLERAI2z4MvaVZ0DNAoiVN7EayyCDR7XBcdYCZpR3gI+2X2R
   xt8vaSZ5hA4Fd+Y7KgQIHG7Q+MMMu1NTzHzbHsIt7tIhwdajCj21+tYaF
   s=;
IronPort-SDR: K8z865lpVr8g9mR5OepCgLwCvmzdUmqd4Tskx2NlrhNo1H5pj9uq3h7wmlT/KcIKKG5VJciLPO
 GMmUmUwiE1lg==
X-IronPort-AV: E=Sophos;i="5.70,397,1574121600"; 
   d="scan'208";a="15292086"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 03 Feb 2020 09:13:36 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id A6147A23E4;
        Mon,  3 Feb 2020 09:13:34 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 3 Feb 2020 09:13:33 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.133) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 3 Feb 2020 09:13:31 +0000
Subject: Re: [PATCH v3] rdma-core/libibverbs: display gid type in ibv_devinfo
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     <linux-rdma@vger.kernel.org>, <jgg@mellanox.com>, <leon@kernel.org>
References: <1580708846-10851-1-git-send-email-devesh.sharma@broadcom.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <65ab8a55-2155-cf1e-fcd8-b87fc7360a36@amazon.com>
Date:   Mon, 3 Feb 2020 11:13:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580708846-10851-1-git-send-email-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.133]
X-ClientProxiedBy: EX13D39UWB003.ant.amazon.com (10.43.161.215) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03/02/2020 7:47, Devesh Sharma wrote:
> It becomes difficult to make out from the output of ibv_devinfo
> if a particular gid index is RoCE v2 or not.
> 
> Adding a string to the output of ibv_devinfo -v to display the
> gid type at the end of gid.
> 
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  libibverbs/examples/devinfo.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
> index bf53eac..bbaed8c 100644
> --- a/libibverbs/examples/devinfo.c
> +++ b/libibverbs/examples/devinfo.c
> @@ -162,8 +162,18 @@ static const char *vl_str(uint8_t vl_num)
>  	}
>  }
>  
> +static const char *gid_type_str(enum ibv_gid_type type)
> +{
> +	switch (type) {
> +	case 0: return "IB/RoCE v1";
> +	case 1: return "RoCE v2";
> +	default: return "invalid value";
> +	}
> +}

Why hard code the enum values? Use IBV_GID_TYPE_IB_ROCE_V1 and IBV_GID_TYPE_ROCE_V2.
