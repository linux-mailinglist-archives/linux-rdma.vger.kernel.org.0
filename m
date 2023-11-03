Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A406A7E053A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjKCPEi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjKCPEi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 11:04:38 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D1D49;
        Fri,  3 Nov 2023 08:04:35 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1cc0d0a0355so17860395ad.3;
        Fri, 03 Nov 2023 08:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699023875; x=1699628675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqsEhwQCgORTttRkJNMy0lsBkeGL10cvGzD/GgULHH4=;
        b=I/F1k0S9htvX0heUSEvR3enmyKicgyGY6TmaZNGbLr4Qvvd619F+OUQ8bA2Q0BCIKw
         bnASGBIGpoX3hWeYLzM09qgCKeG5UUTIkqdpT/h7A4aUVkirEpKTjI011OgX0KXs/ch1
         7Jn/0ql6iKJawFQMfmgpwKaJrnjpctnSXmCY/aRwdtoSiX4Q+vRvxRySPsM9q9h0UPxp
         1u7Y7OQeqC0co5B3sReNYhkeEVQZ1YYcmxzjwGqFI54ukyvje+en+yBVDcz+w1YhfQNn
         41w+mI6X6ReBKqt44h5Wcin3+jzfjW9DQgwiDvMa55dgdFcYYZqVOgzPQGxnxCuqZkNS
         d+rQ==
X-Gm-Message-State: AOJu0YwZinbbGNvYznMuN2C+SLRthQePxKoGvVSQUfLoh7QllVvmjAmL
        pYmLMNpeQCPb0SpFHfw/SHLI1XcRxOM=
X-Google-Smtp-Source: AGHT+IGlvjUEKYJa9z/Qsq09miVDvYjF7s5CNn9dvimUjD2PM9CO5yAHWtZjPm8WviqKkZO0t6TsZQ==
X-Received: by 2002:a17:902:cac1:b0:1ca:4092:7200 with SMTP id y1-20020a170902cac100b001ca40927200mr15951111pld.54.1699023875001;
        Fri, 03 Nov 2023 08:04:35 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c08500b001cc0e3a29a8sm1517612pld.89.2023.11.03.08.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 08:04:33 -0700 (PDT)
Message-ID: <d2ccef1e-2bea-4596-8787-8d2491ce0278@acm.org>
Date:   Fri, 3 Nov 2023 08:04:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V2 6/6] RDMA/rxe: Support PAGE_SIZE aligned MR
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, yi.zhang@redhat.com
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <20231103095549.490744-7-lizhijian@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231103095549.490744-7-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 11/3/23 02:55, Li Zhijian wrote:
> -	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
> +	for_each_sg(sgl, sg, sg_nents, i) {
> +		u64 dma_addr = sg_dma_address(sg) + sg_offset;
> +		unsigned int dma_len = sg_dma_len(sg) - sg_offset;
> +		u64 end_dma_addr = dma_addr + dma_len;
> +		u64 page_addr = dma_addr & PAGE_MASK;
> +
> +		if (sg_dma_len(sg) == 0) {
> +			rxe_dbg_mr(mr, "empty SGE\n");
> +			return -EINVAL;
> +		}
> +		do {
> +			int ret = rxe_store_page(mr, page_addr);
> +			if (ret)
> +				return ret;
> +
> +			page_addr += PAGE_SIZE;
> +		} while (page_addr < end_dma_addr);
> +		sg_offset = 0;
> +	}
> +
> +	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset_p, rxe_set_page);
>   }

Is this change necessary? There is already a loop in ib_sg_to_pages()
that splits SG entries that are larger than mr->page_size into entries
with size mr->page_size.

Bart.
