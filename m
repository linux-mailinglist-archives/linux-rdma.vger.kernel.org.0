Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2170C46E8CF
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 14:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhLINL7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 08:11:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237559AbhLINL6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 08:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639055305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igePiCAnnM/E+OTV8/OUnmXoD7Rv+G1QhGP97ZRcaHw=;
        b=XnGcYHg/p+VB6Z21PcHHkm+qS66kyd4hIOium+GJtM2toTqYeiLhyvUusonm4zMo+L7Ifh
        RUGu3KWGQiQ3Oax3/uWL1+qxDUxbyugjdz7kmxK0LUXRv512xoT+Kr+E4kTyg9oJMhZtD+
        IwftvVfjIUx+HN2JbMXmTlWU5uxPCQ0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-QSLQXquRNZigLu6MhfCr2w-1; Thu, 09 Dec 2021 08:08:24 -0500
X-MC-Unique: QSLQXquRNZigLu6MhfCr2w-1
Received: by mail-ot1-f70.google.com with SMTP id z33-20020a9d24a4000000b00579320f89ecso1995061ota.12
        for <linux-rdma@vger.kernel.org>; Thu, 09 Dec 2021 05:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=igePiCAnnM/E+OTV8/OUnmXoD7Rv+G1QhGP97ZRcaHw=;
        b=S3TQFYo73xe+cmBY73KT7awwFX4M+cIerw9sB0rxbHPA8CRNhcCr+rkLe2koSo2H4l
         t7mWI75xQRyr+aAt3lK8vidcnUExx2hHOLxSQHlVlwjhEOpmFkmqvdz1EjCkrzMM9/AO
         xQ8RSQrJ0e9sWloWVA/ZlyLlZDZT5+n879UcY//ZR54g4G+v6xbnExQtEMQJ8WXbQCCD
         xdost46+KY82Bi0xmnKAdby8ZalwQp/OQXuD1b+BMAMLGLqoPmqEpepVMFFLQOnPMb1n
         duu2qc3uJ7xoO33u841rZj68tyCnFTPurkDePjT03T1K8QGYr8YY0VCCQ4Im5X7oItM5
         Aqrw==
X-Gm-Message-State: AOAM532g72aMSn5/b1e/Tr6nRcS0OpsrPeIFqhTq2HfvmEboYyCKuTQS
        Ea8m87AVL/L6CI9U0ODVoMU8MzrsOS4Npt/dKVBamFvrE+BNG1ZvC01+O5VMHuZG6wy8yqGaSa8
        yl63MHHXSXK+3Njn3S+729g==
X-Received: by 2002:a05:6830:25c2:: with SMTP id d2mr4992178otu.51.1639055302522;
        Thu, 09 Dec 2021 05:08:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOj8FG/2Pi1yxHBQAtiwFCtadHfrnS7LQSpnfphMhrmZpTQZwxCg7xbh8KQssGLtGweF1EXw==
X-Received: by 2002:a05:6830:25c2:: with SMTP id d2mr4992158otu.51.1639055302337;
        Thu, 09 Dec 2021 05:08:22 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n6sm1016113otj.78.2021.12.09.05.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 05:08:22 -0800 (PST)
Subject: Re: [PATCH] drivers:ocrdma:remove unneeded variable
To:     cgel.zte@gmail.com, selvin.xavier@broadcom.com
Cc:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        dennis.dalessandro@cornelisnetworks.com, galpress@amazon.com,
        chi.minghao@zte.com.cn, mbloch@nvidia.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
References: <20211209015206.409528-1-chi.minghao@zte.com.cn>
From:   Tom Rix <trix@redhat.com>
Message-ID: <260ff018-bf5b-07da-6988-c65c04f5bcb5@redhat.com>
Date:   Thu, 9 Dec 2021 05:08:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211209015206.409528-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/8/21 5:52 PM, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>
>
> return value form directly instead of
form
> taking this in another redundant variable.

Clean this message up.

Maybe just 'Return status directly from function called.'

Change itself looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

>
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
> ---
>   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index 735123d0e9ec..3bfbf4ec040d 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -1844,12 +1844,10 @@ int ocrdma_modify_srq(struct ib_srq *ibsrq,
>   
>   int ocrdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr)
>   {
> -	int status;
>   	struct ocrdma_srq *srq;
>   
>   	srq = get_ocrdma_srq(ibsrq);
> -	status = ocrdma_mbx_query_srq(srq, srq_attr);
> -	return status;
> +	return ocrdma_mbx_query_srq(srq, srq_attr);
>   }
>   
>   int ocrdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
> @@ -1960,7 +1958,6 @@ static int ocrdma_build_inline_sges(struct ocrdma_qp *qp,
>   static int ocrdma_build_send(struct ocrdma_qp *qp, struct ocrdma_hdr_wqe *hdr,
>   			     const struct ib_send_wr *wr)
>   {
> -	int status;
>   	struct ocrdma_sge *sge;
>   	u32 wqe_size = sizeof(*hdr);
>   
> @@ -1972,8 +1969,7 @@ static int ocrdma_build_send(struct ocrdma_qp *qp, struct ocrdma_hdr_wqe *hdr,
>   		sge = (struct ocrdma_sge *)(hdr + 1);
>   	}
>   
> -	status = ocrdma_build_inline_sges(qp, hdr, sge, wr, wqe_size);
> -	return status;
> +	return ocrdma_build_inline_sges(qp, hdr, sge, wr, wqe_size);
>   }
>   
>   static int ocrdma_build_write(struct ocrdma_qp *qp, struct ocrdma_hdr_wqe *hdr,

