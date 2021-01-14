Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5382F55F3
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbhANALD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 19:11:03 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:34170 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbhANAJ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jan 2021 19:09:29 -0500
Received: by mail-ej1-f44.google.com with SMTP id hs11so3336014ejc.1
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jan 2021 16:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BEc/ynuYhYRYyX1xQCovpvdjHU2NFS6BGDkmR3ScnrtnZsvAUqL7JCweYd3V8dELjz
         2YXuQdq47kT/oExiyqQvJCnC6JMhM4q8tXa314mXH/vUQlP2Ph+0PiG617qhJZkLf8ka
         qExlHVXaU4fHnd31D6E8Vwsdd6BgvfHQasqkLAUCwBKf9FDbaQQkh7tGIrRUBTLbCNkH
         XE65Gmh/GeB4MXGQCrFp8XkNo4oMElptQX8N2KnPunLNNCEKTD002WgmvyMmrlRGsX9n
         RHv2or84Np1qQ37unQamK8CeQore+G9SckuviqM6wKddHCkZALJyqUnbHrkA95/lPCyh
         diwg==
X-Gm-Message-State: AOAM533GnWvnQ9kKj/0pUbsjsWtBCVTgsNJsALOGQivLdaMwvwhjEyId
        F5FntoC/BGV9R58uKpXfmdgu0smko8s=
X-Google-Smtp-Source: ABdhPJxPaaZaY/8AjKU+IbPfi9qrTGZips6Iyb0OxIHvUhQ57B+3gCHlW7jE4uXGWavPW4QBbHSl2A==
X-Received: by 2002:adf:e512:: with SMTP id j18mr4937540wrm.52.1610582461996;
        Wed, 13 Jan 2021 16:01:01 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id l8sm7784575wrb.73.2021.01.13.16.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 16:01:01 -0800 (PST)
Subject: Re: [PATCH 2/4] IB/iser: protect iscsi_max_lun module param using
 callback
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        dledford@redhat.com, jgg@nvidia.com, leonro@nvidia.com
Cc:     oren@nvidia.com, nitzanc@nvidia.com, sergeygo@nvidia.com,
        ngottlieb@nvidia.com, Israel Rukshin <israelr@nvidia.com>
References: <20210111145754.56727-1-mgurtovoy@nvidia.com>
 <20210111145754.56727-3-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6bdd5de3-84c3-a80a-f477-9c46aadc7846@grimberg.me>
Date:   Wed, 13 Jan 2021 16:00:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111145754.56727-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
