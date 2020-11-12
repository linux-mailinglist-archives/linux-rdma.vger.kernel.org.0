Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88D82B0C85
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgKLSZx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 13:25:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41614 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgKLSZw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 13:25:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id w11so3226171pll.8;
        Thu, 12 Nov 2020 10:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QvplDTvTZnay/C4NlrXwy3WiT/KqaqbHVC2O6qZP0hg=;
        b=BEVpDlTFXLoANApF0cRFqmy6gV0y/SJOBbHU7JX1BducnTiNzPyKnZL6YxAQCFSRML
         /fX64mGqyrtV1YtRE/vbR3T9/qOhLYT7foyzh7dTZn2YClS5E4Ad69R6udajOs/wgR37
         twn3NyQPNNTexniJcF6Pc4l/itV3Ffrca3doB+dDR84lCByL5We0Q2lozsA3/yMNo7/d
         Qg46WQQaYxRpb1kcxJnBfNumGL5QZuIWuCr/M2ZhrvmNm6EMLYbfIK3OJGGZk45TgCZ9
         +44SAc4W75EgIH/N5q8IH5fzxvQnk8vLPNQ2KEcNLrEMpdjXlS8XqU4CFbe6lr/BADdr
         5K0A==
X-Gm-Message-State: AOAM530pGKL1KvLQDwsfFB3sgm+Ola+ShLGXQoaW5WGLifqRAcM2+eD3
        MyF+zil4hGN1ye1Rbr9OjVCIcdjOb6Y=
X-Google-Smtp-Source: ABdhPJwmwJ9oyvDBaHX1IV3z0OBdcR8Y0E0H9te5SVdVx2RNM/0cqbEnX6LvSYcE87EuemmXdGKyxw==
X-Received: by 2002:a17:902:e788:b029:d6:dc69:80a8 with SMTP id cp8-20020a170902e788b02900d6dc6980a8mr881007plb.59.1605205551213;
        Thu, 12 Nov 2020 10:25:51 -0800 (PST)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id k6sm7162512pfd.169.2020.11.12.10.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 10:25:50 -0800 (PST)
Subject: Re: [PATCH] IB/srpt: Fix passing zero to 'PTR_ERR'
To:     Jason Gunthorpe <jgg@nvidia.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201112145443.17832-1-yuehaibing@huawei.com>
 <20201112172008.GA944848@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c73d9be0-0bd8-634a-e3d1-c81fe4c30482@acm.org>
Date:   Thu, 12 Nov 2020 10:25:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201112172008.GA944848@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/12/20 9:20 AM, Jason Gunthorpe wrote:
> I think it should be like this, Bart?
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 6017d525084a0c..80f9673956ced2 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2311,7 +2311,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   
>   	mutex_lock(&sport->port_guid_id.mutex);
>   	list_for_each_entry(stpg, &sport->port_guid_id.tpg_list, entry) {
> -		if (!IS_ERR_OR_NULL(ch->sess))
> +		if (ch->sess)
>   			break;
>   		ch->sess = target_setup_session(&stpg->tpg, tag_num,
>   						tag_size, TARGET_PROT_NORMAL,
> @@ -2321,12 +2321,12 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   
>   	mutex_lock(&sport->port_gid_id.mutex);
>   	list_for_each_entry(stpg, &sport->port_gid_id.tpg_list, entry) {
> -		if (!IS_ERR_OR_NULL(ch->sess))
> +		if (ch->sess)
>   			break;
>   		ch->sess = target_setup_session(&stpg->tpg, tag_num,
>   					tag_size, TARGET_PROT_NORMAL, i_port_id,
>   					ch, NULL);
> -		if (!IS_ERR_OR_NULL(ch->sess))
> +		if (ch->sess)
>   			break;
>   		/* Retry without leading "0x" */
>   		ch->sess = target_setup_session(&stpg->tpg, tag_num,
> @@ -2335,7 +2335,9 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   	}
>   	mutex_unlock(&sport->port_gid_id.mutex);
>   
> -	if (IS_ERR_OR_NULL(ch->sess)) {
> +	if (!ch->sess)
> +		ch->sess = ERR_PTR(-ENOENT);
> +	if (IS_ERR(ch->sess)) {
>   		WARN_ON_ONCE(ch->sess == NULL);
>   		ret = PTR_ERR(ch->sess);
>   		ch->sess = NULL;
> 

Hi Jason,

The ib_srpt driver accepts three different formats for the initiator 
ACL. Up to two of the three target_setup_session() calls will fail if 
the fifth argument of target_setup_session() does not use the format of 
the initiator ID in configfs. If the first or the second 
target_setup_session() call fails it is essential that later 
target_setup_session() calls happen. Hence the IS_ERR_OR_NULL(ch->sess) 
checks in the above loops.

In other words, I like YueHaibing's patch better.

Thanks,

Bart.
