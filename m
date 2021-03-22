Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678DC344F1E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 19:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhCVSwb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCVSwH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 14:52:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D882FC061574;
        Mon, 22 Mar 2021 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=oWj9OjR21OBz+NE1PYcZOGVjbuY4HqJqJnb2evjB0mo=; b=bvf8CNrcU0QzDAFVdkPE01zkOJ
        bLCykWrZU/Ng4sfp/YKgC4LsSS3fh6ruLNyv6QLZ5WQMUJgLojtGoEojvJ+nQJ57pn4t9zbaGKz5D
        Sa12uLDgPHpD8QAjUrZraAgf1QJHOw0t6pTST3ec56x08kJRSERVc4mDZS6B3OEP1Ze24fAuMa0hL
        D7xKx6oPu2fsvoJZtEFehSX3vxwP93/jb+aGZMr3jSxgPjB2Nr/zRQQ91QwHTtV8o82tlC20HpH6q
        h46MaTudp2zyMvXimLPy2Yo0+pjVJEch/bIhJsq343E+cTdP7Md9KOsUB1xqieDr0+P3IoiR36r8q
        Uj3Fm7GA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPeQ-008wMC-4J; Mon, 22 Mar 2021 18:51:48 +0000
Subject: Re: [PATCH] RDMA: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210322064322.3933985-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f6c16b94-72cd-c727-2490-689ffaa821f3@infradead.org>
Date:   Mon, 22 Mar 2021 11:51:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322064322.3933985-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/21/21 11:43 PM, Bhaskar Chowdhury wrote:
> 
> s/struture/structure/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  include/rdma/rdma_vt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
> index 9fd217b24916..d6611f2dd6a5 100644
> --- a/include/rdma/rdma_vt.h
> +++ b/include/rdma/rdma_vt.h
> @@ -245,7 +245,7 @@ struct rvt_driver_provided {
>  	void * (*qp_priv_alloc)(struct rvt_dev_info *rdi, struct rvt_qp *qp);
> 
>  	/*
> -	 * Init a struture allocated with qp_priv_alloc(). This should be
> +	 * Init a structure allocated with qp_priv_alloc(). This should be
>  	 * called after all qp fields have been initialized in rdmavt.
>  	 */
>  	int (*qp_priv_init)(struct rvt_dev_info *rdi, struct rvt_qp *qp,
> --
> 2.31.0
> 


-- 
~Randy

