Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF73CEDCF
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 22:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350720AbhGSTsE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 15:48:04 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:45928 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344259AbhGSRqe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jul 2021 13:46:34 -0400
Received: by mail-pj1-f50.google.com with SMTP id h6-20020a17090a6486b029017613554465so544151pjj.4
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 11:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UrF+oMQ1cKKpeHLPVr+ovRsUWbFTOWY4BeBKDzdfek=;
        b=bX+BbAUyH6GYbGa/fw/FGQjmP8h6lcPTYpLUNj6gZpvahWWxYhQBhA8QpKEdfoj2Kt
         zX5QnPskGmvMAaijOy5JGW1zrNgqbVgIba81q3CRuVz3slyUpiSs1jn7G+8Tl/ds1pk4
         vM17XxegiQs0V2jtr2lLqf466TG4K4BG0CNjHXdVOHFB12ylx6VS1iEfjlZ5uJkbK1PW
         yr+Wp2fiKasSr+Po64chKyv/quBZnHt+UaW5VPIxTmRD+7iVcovbeaoG6TGw5g7mZ1si
         lrvP9D13bDvAMYo2aEpgxXmXTmVY+hj5N5juJdS/MlUaj4ww2O0QSgxFwQTGsDjxZ5EO
         8PRw==
X-Gm-Message-State: AOAM532NTebVhZOxmRxAzafwQNWexqHC1r+/GGukrl2twpNju1PQCdgK
        twFISFQUiQrK6Gpki2MS/C8=
X-Google-Smtp-Source: ABdhPJxVaQxLScAioThaJBRv/NZkGxzPfxlXFrHHTNGXqKYIgG7rKDqmTNWtunoVPTqQYIOFxwBsuA==
X-Received: by 2002:a17:90a:2906:: with SMTP id g6mr25575681pjd.100.1626719233097;
        Mon, 19 Jul 2021 11:27:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2ce3:950:ff23:e549? ([2601:647:4802:9070:2ce3:950:ff23:e549])
        by smtp.gmail.com with ESMTPSA id w145sm9808681pfc.39.2021.07.19.11.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 11:27:12 -0700 (PDT)
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Chesnokov Gleb <Chesnokov.G@raidix.com>
Cc:     "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
 <20210719170911.GS543781@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e5e62cc4-500a-6e7b-8bea-9f86bd9c4d77@grimberg.me>
Date:   Mon, 19 Jul 2021 11:27:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719170911.GS543781@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> The iSCSI socket address does not change.  But the cma_id at the IB
>> layer, which is bound to the iSCSI socket, will change.  The problem
>> is that the new cma_id is trying to bind to a socket address that is
>> still bound to the old cma_id.  That is, before you bind a new
>> cma_id to a socket, you must first delete the old one.
> 
> So why is iser trying to rebind a listening socket to the same
> address? Isn't that the bug here? Just don't do that.

Hey Json,

Yes it is broken, IIRC it was meant to try and handle cases
where the address was restroed, but that needs to do is a periodic
attempt to repair (as bind is expected to fail). Similar to how
nvmet-rdma does this.

(I also have some vague memory that some bonding events mapped to this
cma event although the address was still available but that was a long
time ago so I'm not sure, and the change log says nothing about it...)
