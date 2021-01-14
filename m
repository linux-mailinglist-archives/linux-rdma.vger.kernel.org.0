Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F712F55F2
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbhANAJV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 19:09:21 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52291 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbhANAHz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jan 2021 19:07:55 -0500
Received: by mail-wm1-f43.google.com with SMTP id a6so3094492wmc.2
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jan 2021 16:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IULFnkKDK5duevCPVrFGpADnEfUXVuv6tD2bADwMylZK/8coWtnQSBjdcjxu0aps2N
         1s8VnmQ2vLHq7DD5MJ3wlXHxEMHjQwyTB3bYaxeziPNyuK/cOt5EIiyiJOU248hBcOYe
         Uz4Uo9YLVcj1DxGAZZWQRpLJKEUzKs1bSdCmN+Q7JIw0eAyXp+hiAZA0oQ6bq9mAVqpo
         Du99pzFJVM6Xs9jZ84FiOfoglTQIhIgWI3EuECAskgLioG9afpNB36MkvOzsqyCpYu5X
         jGgP47Wmxjrpvi2BonKswWXpHHZ/4b/1A5LA0tveu82xqcI/y2FbxDVecim1ExFQj5bU
         NJqA==
X-Gm-Message-State: AOAM532Ss/rfyytlbFDVvHXuV7gtYH6/0UsMogPopoqNgYlWxKdeD6ix
        aJ+8/nJUrrB/6ns/+mlC10UOWMjUcN8=
X-Google-Smtp-Source: ABdhPJwTv/8XVgMOVK3w9eFoQvd443a+lXlxdLN6uu20K02V2U6j+5gIc9+tZjO2+ELXU19mC+B0Xg==
X-Received: by 2002:a7b:c3d6:: with SMTP id t22mr1438706wmj.134.1610582833361;
        Wed, 13 Jan 2021 16:07:13 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id b133sm5628135wme.33.2021.01.13.16.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 16:07:12 -0800 (PST)
Subject: Re: [PATCH 2/3] IB/isert: remove unneeded semicolon
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        dledford@redhat.com, jgg@nvidia.com, leonro@nvidia.com
Cc:     oren@nvidia.com, Israel Rukshin <israelr@nvidia.com>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
 <20210110111903.486681-2-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3178aa17-5b28-b8c7-1ba9-eeb8b3525476@grimberg.me>
Date:   Wed, 13 Jan 2021 16:07:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210110111903.486681-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
