Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FD57E8115
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Nov 2023 19:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjKJSXq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Nov 2023 13:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbjKJSW6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Nov 2023 13:22:58 -0500
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6E76BA
        for <linux-rdma@vger.kernel.org>; Thu,  9 Nov 2023 22:37:26 -0800 (PST)
Message-ID: <e606de53-b22f-f347-a71e-7b8a3cfb915a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699598244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LGPWCmKqqvPDyTRbCkg7lwwewbDEEId6M0m973HN6o=;
        b=b6ZS8wTBbmCnyO9RBtWIPDIS8SdMOeFMXjPy5cioWegj1L4WBXjTzi3QFA8kp4TiWPLLvr
        pXRrHCq813OhMrpIfb/D3abWE6HNzDiniI9Pr+CHNhob9Sp3CWszr2RJ2lVO3gfDCj0jNB
        UJt5ZW9OQmZFJbQh7tac9pwDcHOTXds=
Date:   Fri, 10 Nov 2023 14:37:09 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2] RDMA/siw: Use ib_umem_get() to pin user pages
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, leon@kernel.org, max7255@meta.com,
        dennis.dalessandro@cornelisnetworks.com, benve@cisco.com,
        vadim.fedorenko@linux.dev
References: <20231104075643.195186-1-bmt@zurich.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20231104075643.195186-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On 11/4/23 15:56, Bernard Metzler wrote:
> Abandon siw private code to pin user pages during user
> memory registration, but use ib_umem_get() instead.
> This will help maintaining the driver in case of changes
> to the memory subsystem.
>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
> v1 -> v2: remove RLIMIT memlock check logic, now done in ib_umem_get()
> ---

Looks good, Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

...

> +	for (i = 0; num_pages > 0; i++) {
>   		int nents = min_t(int, num_pages, PAGES_PER_CHUNK);
>   		struct page **plist =
>   			kcalloc(nents, sizeof(struct page *), GFP_KERNEL);
>   
>   		if (!plist) {
>   			rv = -ENOMEM;
> -			goto out_sem_up;
> +			goto err_out;
>   		}
>   		umem->page_chunk[i].plist = plist;

One off topic question, why two dimensional list is needed for siw umem?
Thanks in advance.

Guoqing
