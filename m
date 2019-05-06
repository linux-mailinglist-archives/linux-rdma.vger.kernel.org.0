Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7214607
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfEFIVJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 04:21:09 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:23418 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfEFIVJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 04:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557130868; x=1588666868;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dUA/H1WR22qy6HKz6jjH/B1RKpS2aRmldXBtGVsGjVY=;
  b=bkD2lW0uKVixBEX1WeRhGzkgVWWds5Rj/mlvNZn3n3XLxHQQRbrcsibr
   JyjUn3Y7zaWlJbVe+VQL5fFg1075iEpusn+dhIAEVJTKy7lp3Omo0KiTy
   O7rLYDHfGndFXfpYr4Ll06FKwHV1d3NjilZrIZd1VtEp1mBJKvxv9OXGQ
   c=;
X-IronPort-AV: E=Sophos;i="5.60,437,1549929600"; 
   d="scan'208";a="803050259"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 May 2019 08:21:01 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x468KrtK024539
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 6 May 2019 08:21:00 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 May 2019 08:21:00 +0000
Received: from [10.218.62.23] (10.43.161.10) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 6 May
 2019 08:20:57 +0000
Subject: Re: [PATCH v8 11/12] SIW debugging
To:     Bernard Metzler <bmt@zurich.ibm.com>, <linux-rdma@vger.kernel.org>
CC:     Bernard Metzler <bmt@rims.zurich.ibm.com>
References: <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-12-bmt@zurich.ibm.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3385c1dd-25f3-faed-e424-d3998c7b38f5@amazon.com>
Date:   Mon, 6 May 2019 11:20:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426131852.30142-12-bmt@zurich.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.10]
X-ClientProxiedBy: EX13D10UWA004.ant.amazon.com (10.43.160.64) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 26-Apr-19 16:18, Bernard Metzler wrote:
> diff --git a/drivers/infiniband/sw/siw/siw_debug.h b/drivers/infiniband/sw/siw/siw_debug.h
> new file mode 100644
> index 000000000000..2cfe7ce68428
> --- /dev/null
> +++ b/drivers/infiniband/sw/siw/siw_debug.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
> +
> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
> +/* Copyright (c) 2008-2019, IBM Corporation */
> +
> +#ifndef _SIW_DEBUG_H
> +#define _SIW_DEBUG_H
> +
> +#define siw_dbg(ddev, fmt, ...)                                                \
> +	dev_dbg(&(ddev)->base_dev.dev, "cpu%2d %s: " fmt, smp_processor_id(),  \
> +		__func__, ##__VA_ARGS__)
> +

The ibdev_* print functions are now merged, you can start using them instead of
dev_* prints.
