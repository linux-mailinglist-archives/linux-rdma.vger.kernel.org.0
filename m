Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB56B547C
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 19:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfIQRpB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 13:45:01 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:44372 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfIQRpB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 13:45:01 -0400
Received: by mail-pg1-f177.google.com with SMTP id i18so2378569pgl.11
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 10:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HVnMvuAcNUeiiG/Jh0OqC0ibr5NjRyirsuRp5FbnS6o=;
        b=bzz+zxZqmOZuSaYGxHZW+pLsEHOBH6o1MmqtYt2XPTOiKlgegodxSAZPSmwZ44mIxj
         Smo55mmscoWM02XOsgitiBrd08EIn+5pnK7xVFkPupVl021Nx7Ot1PpSBSs5EzZUboDB
         yWPa4a894zQ16stxrY9TccqcmWX38e1IcZvnx8wxVG8mCAugcEDBcZHcdC0J1wFS5eC+
         P35dokB5sJNJXJYhLQ86JJvcZSqb/sEfabqGE27+nQR52s+YaKeZKGTA5N40UsXCzz3a
         UPQ7WBwH6f7rETL8jt/8wawEdVkyuUi2QxbrE+/KQJWW53xr2NRT3crPjrkfKUIRIT7y
         YMBQ==
X-Gm-Message-State: APjAAAUTFlxjq7/hykBCS5S9XRN015fJsVIA5LQZbEbKVJTUgA8cEUH7
        hXwpHisFZBnkigThY0HRL5cWlWG4
X-Google-Smtp-Source: APXvYqzVg8zhfBRC5zCWdtiNlW1Jg4pwaTjovdovaOL48OWTcdkOkZfaka9VLIE44jRhBsBuramKjQ==
X-Received: by 2002:a17:90a:7782:: with SMTP id v2mr5930720pjk.3.1568742298372;
        Tue, 17 Sep 2019 10:44:58 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 64sm3476192pfx.31.2019.09.17.10.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 10:44:57 -0700 (PDT)
Subject: Re: [patch v2 1/2] IB/srp: Add parse function for maximum initiator
 to target IU size
To:     Honggang LI <honli@redhat.com>, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
References: <20190917032421.13000-1-honli@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b9a8596d-1d6e-5a90-cc8f-1b52dc33b7c5@acm.org>
Date:   Tue, 17 Sep 2019 10:44:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917032421.13000-1-honli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/16/19 8:24 PM, Honggang LI wrote:
> In case the SRPT modules, which include the in-tree 'ib_srpt.ko'
> module, do not support SRP-2 'immediate data' feature, the default
> maximum initiator to target IU size is significantly samller than
                                                        ^^^^^^^
                                                        smaller?
> 8260. For 'ib_srpt.ko' module, which built from source before
> [2], the default maximum initiator to target IU is 2116.
[ ... ]
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index b5960351bec0..2eadb038b257 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -75,6 +75,7 @@ static bool prefer_fr = true;
>   static bool register_always = true;
>   static bool never_register;
>   static int topspin_workarounds = 1;
> +static uint32_t srp_opt_max_it_iu_size;

Each SCSI host can represent a connection to another SRP target, and the 
max_it_iu_size parameter can differ per target. So I think this variable 
should be moved into struct srp_target_port instead of being global. See 
also srp_max_it_iu_len().

Thanks,

Bart.
