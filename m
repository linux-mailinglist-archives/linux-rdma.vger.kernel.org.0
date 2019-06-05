Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89B93678D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 00:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFEWge (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 18:36:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41147 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEWge (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 18:36:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id 107so131219otj.8
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 15:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n7nfmwxvHWEhoJaHRE0S/8iPAIFqjFAjkPMpK+J8sAo=;
        b=UBIgcvVWRICh/jVCAjGqDXmYwNM0+WcoQybehvpGPnejdkL7wYlnWfQeRWUo7ThWTA
         9NkXQWNECvx/rl4tHUwaoUvDSyX2C3S3FVA9SU/kpJWwMNZ5hFSWCURmF6z42WbnaJTW
         +CJ5qhYPKlGobgVw1+H8VcL+r2HGkQ5DTxwXul7xxJS49D+Oq2iceo9tQZJrqH5kHGRN
         mpbwTsGRlqgV+R+eq941izOHVJxsIXPhv6BZ+7MEmBxhmHxsgVl3aJSX1/xzUoZqPhbO
         whSuAKSI55yW19AhaTRDdBZ58gzeg2hQtzGpX3VP/Os2LsJAWaco7+8Y8dPPTQATmXkZ
         MNfg==
X-Gm-Message-State: APjAAAW9ZerKWhXxHsVbc2ZDww23gEjZFtTFQHKD4zrafs1yCuNciHl/
        RQTXSRu5n8rk1s7gE6u2vJQ=
X-Google-Smtp-Source: APXvYqxu/jTTZHVgLRKXr1c4JWxH1BWrGZy0uHZcukcRUhoTv91i9heUjnAJmyKa1n0UGOeM8Ixzog==
X-Received: by 2002:a9d:8:: with SMTP id 8mr10354900ota.169.1559774193196;
        Wed, 05 Jun 2019 15:36:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id b25sm7101987otq.65.2019.06.05.15.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:36:32 -0700 (PDT)
Subject: Re: [PATCH 07/20] RDMA/mlx5: Add attr for max number page list length
 for PI operation
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-8-git-send-email-maxg@mellanox.com>
 <257e556b-f248-0847-b7ed-23fb29d04a40@grimberg.me>
 <b3cd3b0f-f155-62ff-57a4-6ef07aac0932@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4af20dd5-f83c-cab3-fe81-65d50fba5dae@grimberg.me>
Date:   Wed, 5 Jun 2019 15:36:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b3cd3b0f-f155-62ff-57a4-6ef07aac0932@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> + props->max_pi_fast_reg_page_list_len =
>>> +        props->max_fast_reg_page_list_len / 2;
>>
>> is it page_list_len or sg_list_len? Also need to document that
>> both data and meta sges need to fit in this (and not respectively)
> 
> 
> in iSER:
> 
> 
>   if (iser_conn->ib_conn.pi_support)
>                  max_num_sg = attr->max_pi_fast_reg_page_list_len;
>          else
>                  max_num_sg = attr->max_fast_reg_page_list_len;
> 
> 
> so max_pi_fast_reg_page_list_len is the length of *each* list in case we 
> do PI (not the sum of the 2 lists length), the same way as 
> max_fast_reg_page_list_len is the length of the list in the non-PI case.

OK, I thought it was related to the fact that we use klms which are
twice the size of mtts.
