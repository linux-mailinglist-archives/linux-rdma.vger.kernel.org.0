Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5123364DC
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfFETkL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:40:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35268 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFETkL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:40:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id y6so15466120oix.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 12:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JJAp0a57XMFZfHENoCWNzpv4sh8UX3zaATXcm+JRWpo=;
        b=F42Bq7ifi/DBTTwr4kLAUKiAizljFsFiWgPLoMViUAPg0wljYaEIYDGbClFKTz/9Gf
         5Tty6ov1IXUlekpZ7n33d/f3V+2NGX3oxDWgsu2SWsPBwDc4OcKYiO+SvRWe4LArLo8Z
         VD48QbahBC80ZuWlz3HSid8vQam/oR9xA/ii5U5+N2qQGp5BCXuRp7IuvCg6wcMiUNe9
         lBCXU7YfZZ99VflEOIKRVOSsIs3KglWiC4LSSOuaoCVJCpN/2JhuQuiV9YJZA7HwV1m6
         NDkmVyGy/ThIACgTbRRGun75UOY+K/9ZEWBEztZHCdAP7MTvfX9vFZ1ULk9yrQLmtFlY
         pt0A==
X-Gm-Message-State: APjAAAVrhkXOhKcveuvAClC2um8PZtHY0Z19Aqlk/mrywyLfzMjiYBHF
        Mn8E9/fl8+Ame6sberKM444=
X-Google-Smtp-Source: APXvYqxshxmOBkBiAk+sUfl6G+P8SXW/4CgpNn1pOnkCSsz7Wq/JmtVfmajp63MDsRU7iYpunw6S/g==
X-Received: by 2002:aca:5e87:: with SMTP id s129mr9643493oib.95.1559763610915;
        Wed, 05 Jun 2019 12:40:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id m129sm8523974oif.13.2019.06.05.12.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:40:10 -0700 (PDT)
Subject: Re: [PATCH 15/20] RDMA/core: Validate signature handover device cap
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-16-git-send-email-maxg@mellanox.com>
 <4780f87f-98ba-9432-2de9-352bdf8bf5a0@grimberg.me>
Message-ID: <a69a134b-d0a5-3144-142e-2050ce935037@grimberg.me>
Date:   Wed, 5 Jun 2019 12:40:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4780f87f-98ba-9432-2de9-352bdf8bf5a0@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> -    if (qp_init_attr->rwq_ind_tbl &&
>> -        (qp_init_attr->recv_cq ||
>> -        qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
>> -        qp_init_attr->cap.max_recv_sge))
>> +    if ((qp_init_attr->rwq_ind_tbl &&
>> +         (qp_init_attr->recv_cq ||
>> +          qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
>> +          qp_init_attr->cap.max_recv_sge)) ||
>> +        ((qp_init_attr->create_flags & IB_QP_CREATE_SIGNATURE_EN) &&
>> +         !(device->attrs.device_cap_flags & 
>> IB_DEVICE_SIGNATURE_HANDOVER)))
> 
> Wouldn't it make sense to also change the qp create flag and the device
> cap to be PI_EN/PI_HANDOVER while we're at it?

Or INTEGRITY_EN/INTEGRITY_HANDOVER?
