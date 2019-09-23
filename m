Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2FBBA30
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 19:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbfIWRLK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 13:11:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41672 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732891AbfIWRLK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 13:11:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so9492638pfh.8
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 10:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EbHw7LY+MlMBXDkJZ+m2rigRGgYGCBYHumgjVs6DKv4=;
        b=A5dIFzjliDwEboQnSn88XNM+3vGfsZPExpuO5z+g1kHvhcjzK/u2lAMAilvZrlVOFJ
         HpQGU01UL1m/9vq4UiNHoSB4D1mexOOszQjZJO3ebIj9edtCbYL4YLAn5HStAqX0Sy2j
         gz/lJP70xIstvkKQMvuolUzC/vyvK+4wDDmRjM3F8ny4qPCY9qBeI8Phv8gF3DkEi7NS
         NJkMiehhfve7CAKzIcJKIRRdLXgy30e2KuK8zHBaTyKTKoVsQkHZO8JoaWhxvbTa21M+
         7HVhrjcnlctbSB+DYPNjPz15FvxwZpIhq1qUaoR2gkBaPXFGQaETUAX2bCA0Ze9VO2+D
         khGQ==
X-Gm-Message-State: APjAAAUC+/NoDA6s5Dwj0iTTDsN7AblGugo88sk0gaehCSE2ec7gS/AH
        0a5vj+LCxt0jkwD3l0Wg2tqiqvYu
X-Google-Smtp-Source: APXvYqy9pGE/mN5e1eIYXeSSgZf0rBbVHjOX1Ztbo+YT5hxGIQIgAQFSdwqci8sMN/8C255i/tvB3A==
X-Received: by 2002:a62:2ac9:: with SMTP id q192mr633525pfq.189.1569258669209;
        Mon, 23 Sep 2019 10:11:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f89sm11976383pje.20.2019.09.23.10.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 10:11:08 -0700 (PDT)
Subject: Re: [patch v4 2/2] RDMA/srp: calculate max_it_iu_size if remote
 max_it_iu length available
To:     Honggang LI <honli@redhat.com>, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
References: <20190923062940.12330-1-honli@redhat.com>
 <20190923062940.12330-2-honli@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f18a4e69-f58d-a179-6fc0-ec15fee80957@acm.org>
Date:   Mon, 23 Sep 2019 10:11:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923062940.12330-2-honli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/19 11:29 PM, Honggang LI wrote:
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index b829dab0df77..b3bf5d552de9 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -139,7 +139,7 @@ MODULE_PARM_DESC(use_imm_data,
>   
>   static unsigned int srp_max_imm_data = 8 * 1024;
>   module_param_named(max_imm_data, srp_max_imm_data, uint, 0644);
> -MODULE_PARM_DESC(max_imm_data, "Maximum immediate data size.");
> +MODULE_PARM_DESC(max_imm_data, "Maximum immediate data size if max_it_iu_size has not been specified.");
>   
>   static unsigned ch_count;
>   module_param(ch_count, uint, 0444);
> @@ -1362,15 +1362,23 @@ static void srp_terminate_io(struct srp_rport *rport)
>   }
>   
>   /* Calculate maximum initiator to target information unit length. */
> -static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data)
> +static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data,
> +				  uint32_t max_it_iu_size)
>   {
>   	uint32_t max_iu_len = sizeof(struct srp_cmd) + SRP_MAX_ADD_CDB_LEN +
>   		sizeof(struct srp_indirect_buf) +
>   		cmd_sg_cnt * sizeof(struct srp_direct_buf);
>   
> -	if (use_imm_data)
> -		max_iu_len = max(max_iu_len, SRP_IMM_DATA_OFFSET +
> -				 srp_max_imm_data);
> +	if (use_imm_data) {
> +		if (max_it_iu_size == 0) {
> +			max_iu_len = max(max_iu_len,
> +			   SRP_IMM_DATA_OFFSET + srp_max_imm_data);
> +		} else {
> +			max_iu_len = max_it_iu_size;
> +		}
> +	}
> +
> +	pr_debug("max_iu_len = %d\n", max_iu_len);
>   
>   	return max_iu_len;
>   }

Thinking further about this, this removes the ability for users to limit 
immediate data to a certain number of bytes. I think that's a step back. 
How about not modifying the description of max_imm_data and to use the 
following approach in srp_max_it_iu_len() for calculating max_iu_len?

uint32_t max_iu_len = sizeof(struct srp_cmd) + SRP_MAX_ADD_CDB_LEN +
		sizeof(struct srp_indirect_buf) +
		cmd_sg_cnt * sizeof(struct srp_direct_buf);
if (use_imm_data)
	max_iu_len = max(max_iu_len, SRP_IMM_DATA_OFFSET +
			 srp_max_imm_data);
if (max_it_iu_size)
	max_iu_len = min(max_iu_len, max_it_iu_size);

Thanks,

Bart.
