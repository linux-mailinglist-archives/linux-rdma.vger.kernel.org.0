Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A1F1DAB59
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgETHDs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 03:03:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42808 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgETHDr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 May 2020 03:03:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id s8so1947235wrt.9
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 00:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZPc5ccpQI5KCCfE5qJz82YbEHJvEzrU+dzj5tF5X3no=;
        b=j0p/gdcz5WMnvvRI+lYvxsLPzwW3V5lgyjhwCVUlmJxNZfVlvfSmPVLUiRArm5pAwX
         5jOKr2RF20Vo1Wad1dHDxSaB5cEHtqbxlf9CZxsy9GoDPtq5QeaTzqNcus1ph9R9I/Ys
         rzu4Rwy/5K/6N3CCNzFS4r0jI3SQe9w/WhU5YkWh25jbGpVoGSUBX61MIVxqH1wEU8Or
         90+ItLFOFS1wluhkPe6PhCrae+6fdXnX5N78VpbSsN6OPz92xiCrhAvIqH9BTgfVdVTX
         a0k11GuIjNkzJHbOIlubUQeJIAUCxbnsOPtRl4qYZ+P1MJWyYj5eIoziSgwzM4iPxQSo
         ICTA==
X-Gm-Message-State: AOAM531XPdIUCll1LAtBxXfcArS9yHLJRntYw09YvzQH39lDcSRN4ImJ
        Gqp+bDmhYTu4ZxVVj3xUFjrobxHNGL4=
X-Google-Smtp-Source: ABdhPJw1RB0bq5RBdbpfXUEWRrgj51MKMsES0GyrpHJsTKQ7R0qkDBumGriKQCai60hr1uStv1S5zQ==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr2747612wrv.155.1589958224791;
        Wed, 20 May 2020 00:03:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:91e2:91f6:e321:5d4d? ([2601:647:4802:9070:91e2:91f6:e321:5d4d])
        by smtp.gmail.com with ESMTPSA id c25sm1989235wmb.44.2020.05.20.00.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 00:03:43 -0700 (PDT)
Subject: Re: [PATCH V3 0/4] Introducing RDMA shared CQ pool
To:     Yamin Friedman <yaminf@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c4cf1cd2-e125-705c-24cf-168c36fc3b90@grimberg.me>
Date:   Wed, 20 May 2020 00:03:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> This is the fourth re-incarnation of the CQ pool patches proposed
> by Sagi and Christoph. I have started with the patches that Sagi last
> submitted and built the CQ pool as a new API for acquiring shared CQs.
> 
> The main change from Sagi's last proposal is that I have simplified the
> method that ULP drivers interact with the CQ pool. Instead of calling
> ib_alloc_cq they now call ib_cq_pool_get but use the CQ in the same manner
> that they did before. This allows for a much easier transition to using
> shared CQs by the ULP and makes it easier to deal with IB_POLL_DIRECT
> contexts. Certain types of actions on CQs have been prevented on shared
> CQs in order to prevent one user from harming another.
> 
> Our ULPs often want to make smart decisions on completion vector
> affinitization when using multiple completion queues spread on
> multiple cpu cores. We can see examples for this in iser, srp, nvme-rdma.

Yamin, didn't you promise to adjust other ulps as well in the next post?
