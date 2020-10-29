Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0024D29E4F6
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 08:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbgJ2HuQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 03:50:16 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37647 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbgJ2HuM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Oct 2020 03:50:12 -0400
Received: by mail-qv1-f65.google.com with SMTP id t6so988562qvz.4;
        Thu, 29 Oct 2020 00:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yqg+o2x8wEt3Y68WATyiWS7Sn8d2BNP9I/fdxD8geAs=;
        b=twYnHTR9rmg8ml4ge94ai0C0JFIzrP6h2DJW7T4LoUZ1Ur3BZ0hS1S9MnKIswzqADp
         1Dvx5PwIGrSuiIBPqogqv1PaD2/+dPpyWynPC7/tpH/aTH53/LFCo5V7HGRnTaXoCaZc
         0YgHkKPWgBysh2oME+ejvjq7rD/U7CXOO8gDfc/qm5fy4MJEpcwdEolo/uR8SmmA17lz
         H9kEgfI1PHMVUmJc8ommrigl7aRo44Guj/5w+D1x2XArlJOBvdDydDWqZq6r2P6vqxdJ
         l/16J1l/Lx0ZeYzq9g9hMX5tKJIQBwzNsVPXSQGVospygjdbIUqv2KvpaLFzn3susZis
         du8g==
X-Gm-Message-State: AOAM531sKEu3OPOvGVhscxMlX5da6Uo5hhqcaX8UktQc+f/2GQCmwJbj
        iy5w+41BoMFxeEIpIigqzhcOFuph1hiFcA==
X-Google-Smtp-Source: ABdhPJwP+nU94CiNN8KLh+68/4zmrLaRKeXk2TAtiUKVkEHpbzCna1VJFpvRBksZGoYZV+T/N9X4WQ==
X-Received: by 2002:a62:2ec1:0:b029:155:3b11:b45b with SMTP id u184-20020a622ec10000b02901553b11b45bmr2144506pfu.43.1603942322316;
        Wed, 28 Oct 2020 20:32:02 -0700 (PDT)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id f21sm1005747pfn.173.2020.10.28.20.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 20:32:00 -0700 (PDT)
Subject: Re: [PATCH rdma-next v2] IB/srpt: Fix memory leak in srpt_add_one
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20201028065051.112430-1-leon@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <620b6f78-c3e2-a9ab-5942-36cc2b7fe32e@acm.org>
Date:   Wed, 28 Oct 2020 20:31:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201028065051.112430-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/27/20 11:50 PM, Leon Romanovsky wrote:
> Failure in srpt_refresh_port() for the second port will leave MAD
> registered for the first one, however, the srpt_add_one() will be
> marked as "failed" and SRPT will leak resources for that registered
> but not used and released first port.
> 
> Unregister the MAD agent for all ports in case of failure.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
