Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F8D230E86
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbgG1PyW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 11:54:22 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:42093 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbgG1PyV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 11:54:21 -0400
Received: by mail-pg1-f173.google.com with SMTP id m22so12095727pgv.9
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 08:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PuvyQKl6IN0K1xUvFJPL3tjF90uWhHuXGiow6Yt5hho=;
        b=hG5erN3FuQ9HhxaH4r8x3lyFMwPKPm0Ze8H3eruzcU56qf5rQnrASMjJhEuYECvnIv
         H3JHDbK/2yO5lJBkDMsaks9Dzu9NRa4HmogxolN7CfwjwoGY9zLIRof0bLLg/HojGf+N
         YJoMbdhRLOq+O8l02DLlV8/ukVIKoUBF7pGMXR6VobaVzXyO/JYRezXVsU2Us6PWvtRv
         sDDoagLbSvRWM4ld4TfpmvP/n7ZiN58OFBa5d/+K8LsABnOop4KRobdi9LpWyO1kiqPi
         Sa4So/4ZfFmpm16HLDNfB9r6PoH/th8SPIQjYAra4iZAv/ophSqfAs5A0JacPAoXDoDG
         BP1A==
X-Gm-Message-State: AOAM531kz6CKWPfC7VyROdlDr/fI0u+rx2bdYSMP6p5CrEGrYeX7yHuI
        w6yu4iCxRTIVq/Ec+ml3rLYUHiKw
X-Google-Smtp-Source: ABdhPJwVx0Wnxh6BshbpWcWLGDPZ6R+UDvlrm/5lFjVEdYxP8IrhsUvn6yYDelqKjFg6Y0Vh8E/wiQ==
X-Received: by 2002:aa7:988c:: with SMTP id r12mr24796197pfl.194.1595951660726;
        Tue, 28 Jul 2020 08:54:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe? ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
        by smtp.gmail.com with ESMTPSA id n12sm6783846pfj.99.2020.07.28.08.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 08:54:20 -0700 (PDT)
Subject: Re: Hang at NVME Host caused by Controller reset
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        bharat@chelsio.com
References: <20200727181944.GA5484@chelsio.com>
 <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
 <20200728115904.GA5508@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
Date:   Tue, 28 Jul 2020 08:54:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728115904.GA5508@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/28/20 4:59 AM, Krishnamraju Eraparaju wrote:
> Sagi,
> With the given patch, I am no more seeing the freeze_queue_wait hang
> issue, but I am seeing another hang issue:

The trace suggest that you are not running with multipath right?

I think you need the patch:
[PATCH] nvme-fabrics: allow to queue requests for live queues

You can find it in linux-nvme
