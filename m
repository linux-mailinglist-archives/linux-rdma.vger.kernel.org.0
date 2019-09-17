Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B54B5468
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfIQRkD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 13:40:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46711 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfIQRkD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 13:40:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so2552645pfg.13
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 10:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X6pLHoEC63Ehz2Z1FJkNPZGFPnEf67BsgVSdx83gAjY=;
        b=OgLfKNtNOnHOIBm+HffB/37WmhfB8KAw/PHF9dChWyxQBxQyCA2Zaew6TQXestzij8
         InmJJweTpwqcxkvtM827oFzUc2o3VZ1gf/R9ROv+npEEXi0L1WKQa0y3NIBJ7xGNISG+
         s/D0I6kAyZiTpGiHuVXu7BkSOa+XUf/4zOyd0DrtWXOVTZfX58CjzsSK9Oo97wNR5bJ2
         fpgksKycBYjzausbzG4oQdQY3L7FpUtJ8OGEGf12QjJgMBh6DANItNkvUoWVQ2iKEB0z
         tycY5yFBPGyTwvvnX7I28lkImy7gRLQcF+YzEk2dzizmAMWFOgn3RVhXYRz82nKcPtkj
         cSdw==
X-Gm-Message-State: APjAAAWyJPN7JA4uRv5+Qabu01B92ZXTHGPYXYi9J9/0SbCNYz94g9k9
        HXfYjTrjv1bebmmW5l1dMaw9c6Yi
X-Google-Smtp-Source: APXvYqyvcuzWlWYzUFvv63Ki6SnAN9uUGr/RXoUFmJSouF1BK9ypyRIQgKY2F6LaJt2YGhqq4MG0og==
X-Received: by 2002:a62:8142:: with SMTP id t63mr5572327pfd.246.1568742002130;
        Tue, 17 Sep 2019 10:40:02 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y28sm4989817pfq.48.2019.09.17.10.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 10:40:01 -0700 (PDT)
Subject: Re: [patch v2 2/2] RDMA/SRP: calculate max_it_iu_size if remote
 max_it_iu length available
To:     Honggang LI <honli@redhat.com>, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
References: <20190917032421.13000-1-honli@redhat.com>
 <20190917032421.13000-2-honli@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ba8ed403-b74e-dc6a-2c47-d4dc6f81fbdd@acm.org>
Date:   Tue, 17 Sep 2019 10:40:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917032421.13000-2-honli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/16/19 8:24 PM, Honggang LI wrote:
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 2eadb038b257..d8dee5900c08 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -76,6 +76,7 @@ static bool register_always = true;
>   static bool never_register;
>   static int topspin_workarounds = 1;
>   static uint32_t srp_opt_max_it_iu_size;
> +static unsigned int srp_max_imm_data;

Each SCSI host can represent a connection to another SRP target, and the 
max_it_iu_size parameter can differ per target. So I think this variable 
should be moved into struct srp_target_port instead of being global.

>   module_param(srp_sg_tablesize, uint, 0444);
>   MODULE_PARM_DESC(srp_sg_tablesize, "Deprecated name for cmd_sg_entries");
> @@ -138,9 +139,9 @@ module_param_named(use_imm_data, srp_use_imm_data, bool, 0644);
>   MODULE_PARM_DESC(use_imm_data,
>   		 "Whether or not to request permission to use immediate data during SRP login.");
>   
> -static unsigned int srp_max_imm_data = 8 * 1024;
> -module_param_named(max_imm_data, srp_max_imm_data, uint, 0644);
> -MODULE_PARM_DESC(max_imm_data, "Maximum immediate data size.");
> +static unsigned int srp_default_max_imm_data = 8 * 1024;
> +module_param_named(max_imm_data, srp_default_max_imm_data, uint, 0644);
> +MODULE_PARM_DESC(max_imm_data, "Default maximum immediate data size.");

This description might confuse users. How about keeping the name of the 
variable and the module parameter and changing its description into the 
following?

"Maximum immediate data size if max_it_iu_size has not been specified."

>   
>   static unsigned ch_count;
>   module_param(ch_count, uint, 0444);
> @@ -1369,9 +1370,19 @@ static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data)
>   		sizeof(struct srp_indirect_buf) +
>   		cmd_sg_cnt * sizeof(struct srp_direct_buf);
>   
> -	if (use_imm_data)
> -		max_iu_len = max(max_iu_len, SRP_IMM_DATA_OFFSET +
> -				 srp_max_imm_data);
> +	if (use_imm_data) {
> +		if (srp_opt_max_it_iu_size == 0) {
> +			srp_max_imm_data = srp_default_max_imm_data;
> +			max_iu_len = max(max_iu_len,
> +			   SRP_IMM_DATA_OFFSET + srp_max_imm_data);
> +		} else {
> +			srp_max_imm_data =
> +			   srp_opt_max_it_iu_size - SRP_IMM_DATA_OFFSET;

Please use as much of a line as possible. I think the recommended style 
in the Linux kernel is as follows:

			srp_max_imm_data = srp_opt_max_it_iu_size -
				SRP_IMM_DATA_OFFSET;

> @@ -3829,6 +3840,8 @@ static ssize_t srp_create_target(struct device *dev,
>   	if (ret < 0)
>   		goto put;
>   
> +	srp_opt_max_it_iu_size = 0;
> +

Static variables that are not initialized explicitly are initialized to 
zero. Since this initialization is redundant, please remove it.

Thanks,

Bart.
