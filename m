Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F912F56BD
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 02:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbhANBwp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 20:52:45 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35244 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbhANADm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jan 2021 19:03:42 -0500
Received: by mail-wm1-f49.google.com with SMTP id e25so3183946wme.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jan 2021 16:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=sOxOgC+0fZ+ZpsSjw+MI3EMwWrwzlqmWY/hjwZGasSiWSruSTVU5msiyo6AzEPn4+M
         IBA/i4PreOm6f2WnYm5StU2N+g81z26Cs9S/3wmmB5EhIJLM06cxOyKqNDlJZAQxqKN5
         l9SEwV+qRlth1+qJTePG7NiSSjKfr56QbLwbqkNRyL0zgyhoHC98qdzWzz8/Yw3YIo5l
         814dlWSyLZKOKKlnH8hlr5WHlFiYhrVG5CO0/G8UzmlnW8Asho7YxLcgDRnUcapyEtAe
         S4x6nPrUXcsJSsVySF41bIOHIi097UflP0YNzYq7PMVzpH5EriP93tF0TyqTxqO0qfaM
         FYSQ==
X-Gm-Message-State: AOAM53277J1HloF3ESPSN8Uf5GSJ4VCYgYVFO5uD9Ey/InkEQWoCOixZ
        +zvsi5yVs8DLFfQHN7oc6zk=
X-Google-Smtp-Source: ABdhPJz2AZrJ6xR+Rj5z1xpgnGalMDJZFek9617jcDEsLuGobW5CI/YMv7AFcRumDICnMRG9DSi9ow==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr1387151wmb.153.1610582554525;
        Wed, 13 Jan 2021 16:02:34 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id z15sm5907523wrv.67.2021.01.13.16.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 16:02:34 -0800 (PST)
Subject: Re: [PATCH 3/4] IB/iser: enforce iser_max_sectors to be greater than
 0
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        dledford@redhat.com, jgg@nvidia.com, leonro@nvidia.com
Cc:     oren@nvidia.com, nitzanc@nvidia.com, sergeygo@nvidia.com,
        ngottlieb@nvidia.com, Israel Rukshin <israelr@nvidia.com>
References: <20210111145754.56727-1-mgurtovoy@nvidia.com>
 <20210111145754.56727-4-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <46be9e66-e25e-98f5-6aaf-19f9c0187315@grimberg.me>
Date:   Wed, 13 Jan 2021 16:02:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111145754.56727-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
