Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D76B2F55ED
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 02:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbhANAEu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 19:04:50 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45852 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbhANADs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jan 2021 19:03:48 -0500
Received: by mail-wr1-f44.google.com with SMTP id d26so3930792wrb.12
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jan 2021 16:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bK/MIgp0L35JfdblndDSFeOW4VNsRDzEzUMt+LnYVUbmou9sGKUUHA1MJ9sZD/U0MV
         uOV53FuMMSlsiFiBFckHiOc6MjCAHDBLtWKdfj+JTL6rJmMiIhyfWbfMfMDel8gfsPde
         8CPYk946eGjE05dOl2MfC3ORnP5ARrvTLirWiDLACXmgUNdDTqAWcsyw2Ok3k03/S145
         djm7Xp4U5mgXUfCGAJQxKYp4hTUGDQZUgDNC5fqPhep5jW6a3nQZsWUpl7sxfcpY7imQ
         NAkHhsqGpQQHHPqPBcEZxV8CW1hplTdITu/9pKtGnw5ZJIJR/MEuNp64189CQ6Ud2CBO
         +gwg==
X-Gm-Message-State: AOAM530UdglVz+lVBqIermrCcTaxDAY1EjHuGKHR2aWjm04CBG6xd173
        Yx1EbsgGYCEDvbZDYO2Yjxb7RLUUF0I=
X-Google-Smtp-Source: ABdhPJzznXRm+3vrzXktWXDk+vgnCO5I6ESDPnh5lyhacb8FT//+SG82+RBscUjrSrFo2dfuqNcIjQ==
X-Received: by 2002:adf:e348:: with SMTP id n8mr5078120wrj.148.1610582585286;
        Wed, 13 Jan 2021 16:03:05 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id r15sm5985168wrq.1.2021.01.13.16.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 16:03:04 -0800 (PST)
Subject: Re: [PATCH 4/4] IB/iser: simplify prot_caps setting
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        dledford@redhat.com, jgg@nvidia.com, leonro@nvidia.com
Cc:     oren@nvidia.com, nitzanc@nvidia.com, sergeygo@nvidia.com,
        ngottlieb@nvidia.com, Israel Rukshin <israelr@nvidia.com>
References: <20210111145754.56727-1-mgurtovoy@nvidia.com>
 <20210111145754.56727-5-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <64ce6b21-be63-9bfc-ceac-34b552d733c1@grimberg.me>
Date:   Wed, 13 Jan 2021 16:03:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111145754.56727-5-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
