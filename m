Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB37F231C3B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2JkR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 05:40:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33489 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgG2JkQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 05:40:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id f18so20979601wrs.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jul 2020 02:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AyPGa/WgoViehzmWMRQ5pKF7x5HT6BnGmP+Ie3bX9+lGmU65Dj52nwm2ndfttWSzpt
         6NU/0YACE0xYsNwtXsBPDdyDyIJjZ7HH4wD5P1EaAzIb+LGDzV+EKv1ngD7Mt2OR1Ya9
         gndb8J3/QDFbnToxQwFWK76UrxY1ZFFFCMTAm7mz/boqDKsjyobxnw48ojygO8MQcP5/
         M5wYLTekw+BrbVvgI4Vfq37xjN5zllaGUN/k5RVp5l26CCI4jwi9rMCD1yoPqdX7MOhR
         ujtyOoIWYs1a/YeQYYCyuPmTH7WdlwcrQNM3Rhf1VxLCtZVGZt9YNmToze+Firw/mSh1
         043g==
X-Gm-Message-State: AOAM532P0OfkDVMmH4EEYSsFVztiFBl2KADgMhS/TYCj7einU3GBwwwz
        7BJ8z3bdI3pXsoMpeg48HGA=
X-Google-Smtp-Source: ABdhPJwgAIW6iRcYS6QjFT+eY56Og+nS9Oqmz35feet1w+R3UVrXpHxVHWEKrzUGH65Z7l6u45oarA==
X-Received: by 2002:a5d:514e:: with SMTP id u14mr28320515wrt.20.1596015614270;
        Wed, 29 Jul 2020 02:40:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8475:db3f:c2a2:c61c? ([2601:647:4802:9070:8475:db3f:c2a2:c61c])
        by smtp.gmail.com with ESMTPSA id j5sm4031534wmb.12.2020.07.29.02.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 02:40:13 -0700 (PDT)
Subject: Re: [PATCH 3/3] IB/srpt: use new shared CQ mechanism
To:     Max Gurtovoy <maxg@mellanox.com>, yaminf@mellanox.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, oren@mellanox.com, jgg@mellanox.com,
        idanb@mellanox.com
References: <20200722135629.49467-1-maxg@mellanox.com>
 <20200722135629.49467-3-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4291d77f-008a-49b8-7e96-7ff728eaf72a@grimberg.me>
Date:   Wed, 29 Jul 2020 02:40:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722135629.49467-3-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
