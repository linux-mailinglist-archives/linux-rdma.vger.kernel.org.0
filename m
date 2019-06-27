Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71812584BE
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF0Oqj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 10:46:39 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:3879 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfF0Oqj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jun 2019 10:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1561646798; x=1593182798;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SN/gUAzQ8Ww77H20ovBk9WMBXogDUTRW+1L1OLwS468=;
  b=R17VwcvgiF6OlD9L4lYQUoMTvaAActYD+2K4/Th7KQ1gXjsV50qjmIrs
   OOalF11n10+4U6MHvcH1uszJmXZnFeql7Rkh9A8vWCQ9Itv2jLhr/qxKK
   p6f3WIGIjMdsgn/T3XrAwSAGAcinnplHcdkpiV7jObWtpDF10/wrBRizi
   U=;
X-IronPort-AV: E=Sophos;i="5.62,424,1554768000"; 
   d="scan'208";a="813095848"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-3714e498.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 27 Jun 2019 14:46:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-3714e498.us-west-2.amazon.com (Postfix) with ESMTPS id BC571A1DD7;
        Thu, 27 Jun 2019 14:46:35 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 27 Jun 2019 14:46:35 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.65) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 27 Jun 2019 14:46:31 +0000
Subject: Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
To:     Michal Kalderon <michal.kalderon@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <leon@kernel.org>, <sleybo@amazon.com>,
        <ariel.elior@marvell.com>
CC:     <linux-rdma@vger.kernel.org>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2933b9d9-7b54-78a3-ba1f-e47c354b154e@amazon.com>
Date:   Thu, 27 Jun 2019 17:46:25 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627135825.4924-2-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D18UWC004.ant.amazon.com (10.43.162.77) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/06/2019 16:58, Michal Kalderon wrote:
> +/*
> + * Note this locking scheme cannot support removal of entries, except during
> + * ucontext destruction when the core code guarentees no concurrency.
> + */
> +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void *obj,
> +				u64 address, u64 length, u8 mmap_flag)
> +{
> +	struct rdma_user_mmap_entry *entry;
> +	int err;
> +
> +	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return RDMA_USER_MMAP_INVALID;
> +
> +	entry->obj = obj;
> +	entry->address = address;
> +	entry->length = length;
> +	entry->mmap_flag = mmap_flag;
> +
> +	xa_lock(&ucontext->mmap_xa);
> +	entry->mmap_page = ucontext->mmap_xa_page;
> +	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);

Hi Michal,
I fixed this part to handle mmap_xa_page overflow:
7a5834e456f7 ("RDMA/efa: Handle mmap insertions overflow")

> +	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
> +			  GFP_KERNEL);
> +	xa_unlock(&ucontext->mmap_xa);
> +	if (err) {
> +		kfree(entry);
> +		return RDMA_USER_MMAP_INVALID;
> +	}
> +
> +	ibdev_dbg(ucontext->device,
> +		  "mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] inserted\n",
> +		  entry->obj, entry->address, entry->length,
> +		  rdma_user_mmap_get_key(entry));
> +
> +	return rdma_user_mmap_get_key(entry);
> +}
> +EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
