Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32F31D598B
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOS7N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 May 2020 14:59:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43278 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOS7M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 May 2020 14:59:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id v63so1390742pfb.10
        for <linux-rdma@vger.kernel.org>; Fri, 15 May 2020 11:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mi5Ws44klMsvwo3CXUUcYlZmMrtEbS+s6JeKUbgdKy8=;
        b=aeE9HVeamx0uSODXnynh732GhC+LE/iZyBsHkg6Rh176gQCk1HUuSuYPUo0VYi9cZm
         DPh9213B5fXyl+zuIkw4gRRnMWpjX2LBMQSv2CVC2PKkmiU5D4nKD5c1MBArRu1uoh/r
         0D1RtlVYcj4/fHkJWh+pDyTBDUmAC8jW7/KMDTzVs9olZtig+0hy1mIAvhMFOmU0USOh
         aXu38EwhMzPmu3mssBn+crQy2oKxxm6IpB5NRohTym845yacSo5oE3gSKcFd61mB1c60
         wzMgWMss7Kl7KPDDtOLYVJs13gpgSRf7Spoys3xvEkOzlXVy0zBamaXfv7EHyen1hcjm
         pgqg==
X-Gm-Message-State: AOAM533q18+yEd7yz3g+uiXD8IKuuGRs8sh/Gp0a1v5jYgskO/2W4L72
        +QgALg+bHVirPakvugOUzyg=
X-Google-Smtp-Source: ABdhPJwMf2AdxczEVooecug/YGI9DTrFhWE/ySbOMve0uH5pntGFb0Z7Hdjyq5ojmkLT8Tr3rClg7A==
X-Received: by 2002:a63:175c:: with SMTP id 28mr4234619pgx.44.1589569152231;
        Fri, 15 May 2020 11:59:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c811:dd1c:fe2d:bd2c? ([2601:647:4802:9070:c811:dd1c:fe2d:bd2c])
        by smtp.gmail.com with ESMTPSA id k6sm2088899pju.44.2020.05.15.11.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 11:59:11 -0700 (PDT)
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Tom Talpey <tom@talpey.com>, santosh.shilimkar@oracle.com,
        Aron Silverton <aron.silverton@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     bvanassche@acm.org, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
 <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
 <479add48-6fdb-f925-c3b9-699c6aa4cfbf@grimberg.me>
 <0ea6349f-1915-3493-3bd7-0bc8086c5b66@oracle.com>
 <75f2cbe4-3a62-9b0e-93c7-fb076bf318bf@talpey.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <53ac195c-dccd-3d30-9e11-f1389dc8332d@grimberg.me>
Date:   Fri, 15 May 2020 11:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <75f2cbe4-3a62-9b0e-93c7-fb076bf318bf@talpey.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> It's not only the fmr_pools. The FMR API operates on a page granularity,
> so a sub-page registration, or a non-page-aligned one, ends up exposing
> data outside the buffer. This is done silently, and is a significant
> vulnerability for most upper layers.

You're right Tom, I forgot about that...
I guess I'd vote to remove it altogether then...
