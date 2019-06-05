Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1836857
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 01:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFEXvm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 19:51:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44414 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEXvl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 19:51:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so261248otl.11
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 16:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QlK5ovcMeTnGDqTPAenwg/EvRZP8y+ilFLdD9Wj3Fkg=;
        b=piscJ+lvW+2W3uzA6GOpBF2w0M1rq7uK4ZO3fEaOoE9frtZCr52JcmR3XRLlCEsSQ6
         hrgGz42E3XpS93UleICiSRyfK7C3275yZrHe4fpm9IPPrffYgfoyayNpcpbuuvtuICDz
         +OjhW2T+hqmNCbjzGag6Oyqdy90kprDOliwuMVCIJNkCIlQNOIRxNCHAQqgDuERf3XfL
         NNZ8cW7joFPXZaH4T7DPnvW3pTRPnCPxzqLTiKtCWD6w+8VBlRerUjvmu/0n1QnkClIQ
         nsCF/l5D8z4gYLkRe5jJI/YHX09y5KszSD8cQT3KLKF7o8OjfbuMDlvRBuI1KLnfcsfw
         1qWA==
X-Gm-Message-State: APjAAAVZx8fv0a0XBg41wynF0c9ZmGCwU/v/WV8tRknEboK7eO2qAw+9
        UqJ3fIt5GQ0kgpAEWEyrpYw=
X-Google-Smtp-Source: APXvYqxZdzY1HFKl17qhIz1pu8v8VUamn68cfy4ZnXENOn+MWmylqiq5UDegHGWnihaSZ63YRB9KSA==
X-Received: by 2002:a9d:5616:: with SMTP id e22mr6020456oti.218.1559778701106;
        Wed, 05 Jun 2019 16:51:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l1sm73087otr.19.2019.06.05.16.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 16:51:40 -0700 (PDT)
Subject: Re: [PATCH 18/20] RDMA/mlx5: Improve PI handover performance
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-19-git-send-email-maxg@mellanox.com>
 <b3055107-a91a-a62b-a642-82d14fe3209b@grimberg.me>
 <11c5be7b-05c1-29aa-b407-a4a2655ea288@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cd290591-66f8-6665-90b7-0eb4b4d7ffb4@grimberg.me>
Date:   Wed, 5 Jun 2019 16:51:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <11c5be7b-05c1-29aa-b407-a4a2655ea288@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> You just doubled the number of resources (mrs+page_vectors) allocated
>> for a performance optimization (25% in large writes). I'm asking myself
>> if that is that acceptable? We tend to allocate a lot of those (not to
>> mention the target side).
> 
> We're using same amount of mkey's as before (sig + data + meta mkeys vs. 
> sig + internal_klm + internal_mtt mkey).

But each mkey has twice of mtt/klm space..

> And we save their invalidations (of the internal mkeys).

Those are not resources.

> 
>>
>> I'm not sure what is the correct answer here, I'm just wandering if this
>> is what we want to do. We have seen people bound by the max_mrs
>> limitation before, and this is making it worse (at least for the pi 
>> case).
> 
> it's not (see above). The limitation of mkeys is mostly with older HCA's 
> that are not signature capable.

Its also sw mr page_vec/sgl... But that is less of a concern as well I 
guess.
