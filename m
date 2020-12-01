Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15932CA429
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Dec 2020 14:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391155AbgLANo6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 08:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387932AbgLANo6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Dec 2020 08:44:58 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEE7C061A48
        for <linux-rdma@vger.kernel.org>; Tue,  1 Dec 2020 05:43:44 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so1203074qke.8
        for <linux-rdma@vger.kernel.org>; Tue, 01 Dec 2020 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4EnzSAXEWHTYsF6BPwz9L60+Z1H1pY6pU6MCWXt7avA=;
        b=VyJsSWHWhH5sYC5l7bZ/C++LBI8I2ZbC5v/+7kNCzjhhvoqcD1V9AGenqSP43ZNATx
         jRxmJQUadydf+zW1NCYeL45vGcTNwVDMtupqcQEToWFAA4xiNxI79PGf2EkIuwe4UJs5
         D9qeUbBYFWx5ZPiqpO9vts080kWbWfj05pjrY+KsVfbt8Pvmz2tF8LiW7ERdTofLAkkC
         ehyuLdZpI/fWnBvhPeKEmdSBvY4SLPqmfvhgMoE5ufHYWhlFdEUymGEZn490TLz6l898
         O42Pkxyg2eNihqFyR3FTcJ+zXGznwxU+Z6USjs85eUvkKBNTjTPCHaW4f20Grvm8hYSU
         UUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4EnzSAXEWHTYsF6BPwz9L60+Z1H1pY6pU6MCWXt7avA=;
        b=s8JbIV6NsOG4QtHZreVJ2N7Y38hmQ2yaotTPiJrROXs3xAsBrFx15CIDmJuC0C0TNn
         nKvXp2kcjek9BbF4WDGn5RbkjglSM10W9ABPsQA9R7NgrQ6TLTtSNXptSOzDIq+dNIFI
         F6K6GDF7nr4zzeMHEbhpltE16Rw++p8iihbiscmzADVgooPj0UcSWrpZo/rV36YEkG5v
         HZ7IyH7oiW2Y4DomzOTQSaf57MWDSaEmZp4M/am6ue0sKO+Giyz7+Uc4K8gahJq2uCZx
         BpL5O7ligjOKCZTVnsEh+v06yPEPve6xyjb9rqLCUuknxHGwU8mI4J4+JlLuR59yo5JY
         w/YA==
X-Gm-Message-State: AOAM531n1KjjOV6HvWY7vtvm/aDKewY/mDVvFWASERMRABkM64dMlMy6
        d5effV5AME3ZtbdxW/qEm7Y90g==
X-Google-Smtp-Source: ABdhPJyU0/kslN2z/KDH7YywWtRJapLqnK2o0oilXR0LM+1jsVd1c61SZpIZupgocy7UA0ywbiVkNQ==
X-Received: by 2002:a05:620a:1655:: with SMTP id c21mr2828950qko.127.1606830223577;
        Tue, 01 Dec 2020 05:43:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d12sm1953898qtp.77.2020.12.01.05.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:43:42 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kk5wT-004QZo-R8; Tue, 01 Dec 2020 09:43:41 -0400
Date:   Tue, 1 Dec 2020 09:43:41 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Move capability flags of QP and CQ to
 hns-abi.h
Message-ID: <20201201134341.GD5487@ziepe.ca>
References: <1606829024-51856-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606829024-51856-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 01, 2020 at 09:23:44PM +0800, Weihang Li wrote:
> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
> index 9ec85f7..2dd5fa07 100644
> +++ b/include/uapi/rdma/hns-abi.h
> @@ -43,6 +43,10 @@ struct hns_roce_ib_create_cq {
>  	__u32 reserved;
>  };
>  
> +enum hns_roce_cq_cap_flags {
> +	HNS_ROCE_CQ_FLAG_RECORD_DB = BIT(0),
> +};
> +
>  struct hns_roce_ib_create_cq_resp {
>  	__aligned_u64 cqn; /* Only 32 bits used, 64 for compat */
>  	__aligned_u64 cap_flags;
> @@ -69,6 +73,12 @@ struct hns_roce_ib_create_qp {
>  	__aligned_u64 sdb_addr;
>  };
>  
> +enum hns_roce_qp_cap_flags {
> +	HNS_ROCE_QP_CAP_RQ_RECORD_DB = BIT(0),
> +	HNS_ROCE_QP_CAP_SQ_RECORD_DB = BIT(1),
> +	HNS_ROCE_QP_CAP_OWNER_DB = BIT(2),
> +};

Don't use BIT in uapi headers

Jason
