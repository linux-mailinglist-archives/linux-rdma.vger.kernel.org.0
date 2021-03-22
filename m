Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BC7344F55
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 19:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCVS5T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCVS4t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 14:56:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE7C061574;
        Mon, 22 Mar 2021 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=a+h23y4CZs2Q/Y+VMIgW9qessV5LUwPgFk8iCgVrkLg=; b=oTlfQOE3DZhZ6dTqryZBfYgQb2
        lmo+crlqoYnqJcHrDg74Ly9P0dhNu22N9OtKkUQ2UeqXnAswbefYt3UyD3/iB3A5ErUAzy69z9vma
        n7z6HTSZYAuz8nZ/nprTeR+UPHhtUXhZVv72vocLz4UvKlQlKSDgu7eQelsZVwHB8QcT25Gw93v39
        IIP4bcE6sO93e0fI8h66Vx9F408fRCuu7Vh9c327FU2cwm37HfO81Jfu98d5RNxJSmxEDmDQ3enps
        tOclymLldRSFtJHSv7nNw72+afsGeNE6iGE0Iv7LscdzvH1LssH1jjo1s2acpJSPE2xK6T4DiMfsM
        os1VGEHA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPis-008wbS-JQ; Mon, 22 Mar 2021 18:56:32 +0000
Subject: Re: [PATCH] IB/hfi1: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210322062923.3306167-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <edfc7c19-df42-a854-7ffd-012a96f00ae7@infradead.org>
Date:   Mon, 22 Mar 2021 11:56:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322062923.3306167-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/21/21 11:29 PM, Bhaskar Chowdhury wrote:
> 
> s/struture/structure/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/iowait.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/iowait.h b/drivers/infiniband/hw/hfi1/iowait.h
> index d580aa17ae37..377e00a109c2 100644
> --- a/drivers/infiniband/hw/hfi1/iowait.h
> +++ b/drivers/infiniband/hw/hfi1/iowait.h
> @@ -321,7 +321,7 @@ static inline void iowait_drain_wakeup(struct iowait *wait)
>  /**
>   * iowait_get_txhead() - get packet off of iowait list
>   *
> - * @wait iowait_work struture
> + * @wait iowait_work structure

Also use correct kernel-doc syntax:

 * @wait: iowait_work structure

No sense in having to make multiple patches to the same line.

>   */
>  static inline struct sdma_txreq *iowait_get_txhead(struct iowait_work *wait)
>  {
> --


-- 
~Randy

