Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F7150F36
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 19:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgBCSSg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 13:18:36 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:60769 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgBCSSg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 13:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580753916; x=1612289916;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nt20qzv26mXfHaDEx9nB7hfKVYfD/MwcDoH5fuWi6vI=;
  b=Y2YAshGDg9DscQKuXLZk5lWa+RC/y2ktCfRXsNrKdAmHQYSEmH9Skk6t
   yD0VFnMEUikeUjXJnxjwKgbuhujHXMxAXXJ/z40Xnoos28YUmiUgydPu4
   7I9cp5LUX6P/E/32+JE5/gGaD4lYFdzXnvt+sstVKPlU2JJ3gCPW4FRZx
   E=;
IronPort-SDR: jysj6/ElFpeAEFbGseAeGVL8PjotLKF7R1ptjxYMqCOABQsk7uLEZR7e+OHhe4sf2YlChkiM28
 TlMBN24SqFhA==
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="15390037"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 03 Feb 2020 18:18:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id D19C8A220F;
        Mon,  3 Feb 2020 18:18:32 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 3 Feb 2020 18:18:32 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.153) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 3 Feb 2020 18:18:28 +0000
Subject: Re: [PATCH v4] libibverbs: display gid type in ibv_devinfo
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     <linux-rdma@vger.kernel.org>, <jgg@mellanox.com>, <leon@kernel.org>
References: <1580745415-19744-1-git-send-email-devesh.sharma@broadcom.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <b9fc34ae-6da8-0d12-e069-cdbf9dc06e25@amazon.com>
Date:   Mon, 3 Feb 2020 20:18:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580745415-19744-1-git-send-email-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.153]
X-ClientProxiedBy: EX13D25UWB004.ant.amazon.com (10.43.161.180) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03/02/2020 17:56, Devesh Sharma wrote:
> diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> index a0e6f89..fc0699d 100644
> --- a/libibverbs/driver.h
> +++ b/libibverbs/driver.h
> @@ -84,6 +84,7 @@ enum verbs_qp_mask {
>  enum ibv_gid_type {
>  	IBV_GID_TYPE_IB_ROCE_V1,
>  	IBV_GID_TYPE_ROCE_V2,
> +	IBV_GID_TYPE_INVALID
>  };

I don't think that's right.
You're adding a new enum value to libibverbs, but it's not really
used/implemented there.
If devinfo needs an invalid GID value, make it local to that program.
