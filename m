Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21311C377C
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgEDLBh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 07:01:37 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18434 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEDLBh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 07:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588590096; x=1620126096;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=slo4m5Ux4VPBt4iDd/iK1jOK4D7lZcS1q5oYXx0YEVE=;
  b=gUSW6w82FFfwwRiMQC6M1wHIcPkRL24Bj1gX+2xeaVIUlKpFfhA8I+/s
   Yq7dvvUPqF7wgK4P4u2kF4LpE69xAzKCH04yThqAToJNtgTG2s+Lb7hf0
   b3dluWVq2yinuOanUkPVcHCkEewgrW16/5gLxVXkBIGxUhobxzV9xtjTE
   w=;
IronPort-SDR: XHVfoHYtLN8kngD/u0xdRsoHFNCW97Cy1eb58X0ariwSAaGHn4ROWNpahwjGdBLdGUH++4q02D
 RRpUB0+/0iCQ==
X-IronPort-AV: E=Sophos;i="5.73,351,1583193600"; 
   d="scan'208";a="41087127"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 04 May 2020 11:01:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id CBB5E2419A6;
        Mon,  4 May 2020 11:01:32 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 4 May 2020 11:01:32 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.194) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 4 May 2020 11:01:28 +0000
Subject: Re: [PATCH rdma-next] RDMA/ucma: Return stable IB device index as
 identifier
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
References: <20200430152939.77967-1-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <694f5565-acdd-0863-092c-b78409f1b9c3@amazon.com>
Date:   Mon, 4 May 2020 14:01:23 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430152939.77967-1-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.194]
X-ClientProxiedBy: EX13D15UWA003.ant.amazon.com (10.43.160.182) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30/04/2020 18:29, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The librdmacm uses node_guid as identifier to correlate between
> IB devices and CMA devices. However FW resets cause to such
> "connection" to be lost and require from the user to restart
> its application.
> 
> Extend UCMA to return IB device index, which is stable identifier.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
> index e545f2de1e13..14d48b462d91 100644
> --- a/include/uapi/rdma/rdma_user_cm.h
> +++ b/include/uapi/rdma/rdma_user_cm.h
> @@ -168,6 +168,7 @@ struct rdma_ucm_query_route_resp {
>  	__u32 num_paths;
>  	__u8 port_num;
>  	__u8 reserved[3];
> +	__u32 ibdev_index;
>  };
>  
>  struct rdma_ucm_query_addr_resp {
> @@ -179,6 +180,7 @@ struct rdma_ucm_query_addr_resp {
>  	__u16 dst_size;
>  	struct __kernel_sockaddr_storage src_addr;
>  	struct __kernel_sockaddr_storage dst_addr;
> +	__u32 ibdev_index;
>  };

Should both these structs size be aligned to 8 bytes?
