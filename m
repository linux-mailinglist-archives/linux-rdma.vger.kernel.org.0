Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D963BB94F5
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbfITQLL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 12:11:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46444 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbfITQLL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 12:11:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so3377696plr.13
        for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2019 09:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gNmaaOrQ/5n7q12Jj7gAM2AIafOeouak6Nm6TWzsNb8=;
        b=Gc1fuYYC6dWpAyk//qK9G89enZO97IsJDueiHmC3cAJ5ssjQ5b5YRahUqytjlaoPpD
         QtZyQo4QSjp9mScevu1RWaFOMGMyl787UYjDXWlHtA/qG/5Whll9/4PeYmWPXzHcfZpu
         oyV90d+Hge3w8PI6l3DegKqKaFsU35aSr/3eDXg5X/HUd2g2v/qqgfN/WcFj7tc21LBM
         z0NZx1nscd4+Lo+RROcrFhaceF/M//gCDuGbwYGyCjaT6X5anyIrqYZ0DXZxDtx/XapM
         xJYL5GlmkUQZYypk92z1r/C0wCPIuojLIwArMG41zOWdtphQyuUGVRs5pZGlKfHFa8rs
         4yTA==
X-Gm-Message-State: APjAAAXFyNbqIzWkgSyHOzajMz3Ki1YLNjjIt4Pyh04CKjrgc/3xT8fB
        CKj0Iv8h1u2txAfltbPSMgdR6ee7
X-Google-Smtp-Source: APXvYqwaUQakn3ysA95iA/QPNwsocXAvoQGlwKDJo7SjL2pBDtUVd0wFCAVSGEwS2wKKwShzbJfvSg==
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3mr17146249plz.139.1568995868930;
        Fri, 20 Sep 2019 09:11:08 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm8147492pga.92.2019.09.20.09.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:11:07 -0700 (PDT)
Subject: Re: [patch v3 1/2] RDMA/srp: Add parse function for maximum initiator
 to target IU size
To:     Honggang LI <honli@redhat.com>, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
References: <20190919035032.31373-1-honli@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8f15fcfa-d0d8-e04b-8202-0cc56fa75941@acm.org>
Date:   Fri, 20 Sep 2019 09:11:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919035032.31373-1-honli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/18/19 8:50 PM, Honggang LI wrote:
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index b5960351bec0..b829dab0df77 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -3411,6 +3411,7 @@ enum {
>   	SRP_OPT_IP_SRC		= 1 << 15,
>   	SRP_OPT_IP_DEST		= 1 << 16,
>   	SRP_OPT_TARGET_CAN_QUEUE= 1 << 17,
> +	SRP_OPT_MAX_IT_IU_SIZE  = 1 << 18,
>   };
>   
>   static unsigned int srp_opt_mandatory[] = {
> @@ -3443,6 +3444,7 @@ static const match_table_t srp_opt_tokens = {
>   	{ SRP_OPT_QUEUE_SIZE,		"queue_size=%d"		},
>   	{ SRP_OPT_IP_SRC,		"src=%s"		},
>   	{ SRP_OPT_IP_DEST,		"dest=%s"		},
> +	{ SRP_OPT_MAX_IT_IU_SIZE,	"max_it_iu_size=%d"	},
>   	{ SRP_OPT_ERR,			NULL 			}
>   };
>   
> @@ -3736,6 +3738,14 @@ static int srp_parse_options(struct net *net, const char *buf,
>   			target->tl_retry_count = token;
>   			break;
>   
> +		case SRP_OPT_MAX_IT_IU_SIZE:
> +			if (match_int(args, &token) || token < 0) {
> +				pr_warn("bad maximum initiator to target IU size '%s'\n", p);
> +				goto out;
> +			}
> +			target->max_it_iu_size = token;
> +			break;
> +
>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in target creation request\n",
>   				p);
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
> index b2861cd2087a..105b2bc6aa2f 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.h
> +++ b/drivers/infiniband/ulp/srp/ib_srp.h
> @@ -209,6 +209,7 @@ struct srp_target_port {
>   	u32			ch_count;
>   	u32			lkey;
>   	enum srp_target_state	state;
> +	uint32_t		max_it_iu_size;
>   	unsigned int		cmd_sg_cnt;
>   	unsigned int		indirect_size;
>   	bool			allow_ext_sg;
> 

Something I forgot to mention last time: since this patch adds a new 
login parameter Documentation/ABI/stable/sysfs-driver-ib_srp should be 
updated. I don't have a strong opinion about whether that should happen 
through a separate patch or not. Since the code changes look fine to me:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
