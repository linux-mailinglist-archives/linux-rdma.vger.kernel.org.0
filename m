Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC633678C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 00:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFEWfB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 18:35:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40439 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEWfA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 18:35:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id x24so133767otp.7
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 15:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xPQgQiiN8tXs1Mn731eijk9wSTnSqxaWqrRJKQ/rN9A=;
        b=j/iO3jDQkcr5ABFNkT37MNt0HIqU/x7QUrtDAMkv4p9vb19gt5GvNcIsv8W0IEHS4Q
         AdFlBKtduStcaIhwMK62AO+bkSmyRFq7Y6v4Ro/pQN5Mqjqxa687vNwlcba2xm1/3n8L
         BCMeTpaO0L49MoBUnbNyZwYxvd6SGarH5nWVyL0afhidciWV9lzeeolynDTxwP5aB4v1
         4uWuw4CChhbKhPdpexFZkjWs0VI8dYCFKDdr9XDkH/3z0nkmDgEBiSajuLnBqH7efF1I
         aH0bnwip5LyXKK3Pt1ji9y8PFIApaLyDdCJBeNPxA2wcOlav8y8LfdsJQDmvFOeo5I97
         Hdcg==
X-Gm-Message-State: APjAAAUU3DqDBFpRN0Ym5/vWtx++nB9RRo1jBkdvhiQAhudykK7NFCux
        nGkAD1MzyzYf75WpIKu7DKA=
X-Google-Smtp-Source: APXvYqxdu9u4R0w8YlPrwxbnM+HaKPHxpW9xg5rwzzsbQ85eAdgzDdIKILDisnEKmJ0A4y9rzdHWhA==
X-Received: by 2002:a9d:7408:: with SMTP id n8mr11900708otk.324.1559774100351;
        Wed, 05 Jun 2019 15:35:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id x21sm9463otk.4.2019.06.05.15.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:34:59 -0700 (PDT)
Subject: Re: [PATCH 15/20] RDMA/core: Validate signature handover device cap
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-16-git-send-email-maxg@mellanox.com>
 <4780f87f-98ba-9432-2de9-352bdf8bf5a0@grimberg.me>
 <a69a134b-d0a5-3144-142e-2050ce935037@grimberg.me>
 <45f75d84-0616-8516-c482-65cbab7b8557@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9c01b0e9-a07a-fdcc-0e89-fbdf1f83974f@grimberg.me>
Date:   Wed, 5 Jun 2019 15:34:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <45f75d84-0616-8516-c482-65cbab7b8557@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>> -    if (qp_init_attr->rwq_ind_tbl &&
>>>> -        (qp_init_attr->recv_cq ||
>>>> -        qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
>>>> -        qp_init_attr->cap.max_recv_sge))
>>>> +    if ((qp_init_attr->rwq_ind_tbl &&
>>>> +         (qp_init_attr->recv_cq ||
>>>> +          qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
>>>> +          qp_init_attr->cap.max_recv_sge)) ||
>>>> +        ((qp_init_attr->create_flags & IB_QP_CREATE_SIGNATURE_EN) &&
>>>> +         !(device->attrs.device_cap_flags & 
>>>> IB_DEVICE_SIGNATURE_HANDOVER)))
>>>
>>> Wouldn't it make sense to also change the qp create flag and the device
>>> cap to be PI_EN/PI_HANDOVER while we're at it?
> 
> We're already standing on 20 patches in this series, so if Jason will 
> agree I'll do this renaming in a separate commit or we can stay with the 
> current naming.

This is a good chance to clean the naming here. Ideally we can also
cleanup the naming on the call-sites and get rid of the signature
name everywhere (since we ended up doing only the pi subset), but that 
indeed can be a followup.

This can come as a separate patch.
