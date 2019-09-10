Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5624AEFFC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 18:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436809AbfIJQx1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 12:53:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46797 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436760AbfIJQx1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Sep 2019 12:53:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id x7so11682303oie.13
        for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2019 09:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f6iE1c6CXUGncD8Q4Pu/U5EESbOs15rh39kVxVhwmyo=;
        b=DZCA6s/d9IRX3Q/Rpav8obDu79GKInMA21A23V+H5YWalY/yxRevy6J252nWlNIjxW
         616Lg83rDCuupimm92r6/Q6+ojIwHgJRBFR5DEGQ9sKcIMvL7VvToE/Z+s9XgkcJYULS
         dNzNT2i1sV0YmCiJouH/kDmoaCSgM46MLorKAVWdKRmgYMKy0bFTrFktymIE+IGA/qhW
         fUb8Np4H3uoZhJDN23ETrZ49XwutCsYcDyVv+hpjsB4jojrydilG6be98Ole+YyG9xTy
         cVjkcr6mdgvpZhoHvpArK5zKDE/sO8+2Q2ZWl/YgfT+shmIqZiflsH7+/xP5raS6EX1A
         G+Bg==
X-Gm-Message-State: APjAAAWn0SivhktPAIJQ7H5spK9WNQa0IKdtbOUnKKxhawTiAHsOlS9c
        NLqat1x8vsjbIdm1ifZfVi4=
X-Google-Smtp-Source: APXvYqxxS2F41kvbTuXur19PvWEmylOyj3O3TRljXxP90nkWonwHShh4LxBqgnEzD6G3kEMle86cKg==
X-Received: by 2002:aca:5697:: with SMTP id k145mr384138oib.101.1568134405178;
        Tue, 10 Sep 2019 09:53:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l4sm1461017oia.51.2019.09.10.09.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 09:53:24 -0700 (PDT)
Subject: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on iw_rem_ref
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20190904212531.6488-1-sagi@grimberg.me>
 <20190910111759.GA5472@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
Date:   Tue, 10 Sep 2019 09:53:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910111759.GA5472@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> This may be the final put on a qp and result in freeing
>> resourcesand should not be done with interrupts disabled.
> 
> Hi Sagi,
> 
> Few things to consider in fixing this completely:
>    - there are some other places where iw_rem_ref() should be called
>      after spinlock critical section. eg: in cm_close_handler(),
> iw_cm_connect(),...
>    - Any modifications to "cm_id_priv" should be done with in spinlock
>      critical section, modifying cm_id_priv->qp outside spinlocks, even
> with atomic xchg(), might be error prone.
>    - the structure "siw_base_qp" is getting freed in siw_destroy_qp(),
>      but it should be done at the end of siw_free_qp().

Not sure why you say that, at the end of this function ->qp will be null
anyways...

>    
> I am about to finish writing a patch that cover all the above issues.
> Will test it and submit here by EOD.

Sure, you take it. Just stumbled on it so thought I'd go ahead and send
a patch...
