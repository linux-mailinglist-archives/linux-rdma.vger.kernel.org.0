Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15B523E292
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Aug 2020 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgHFTvV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Aug 2020 15:51:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33728 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTvS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Aug 2020 15:51:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so27529652pgf.0
        for <linux-rdma@vger.kernel.org>; Thu, 06 Aug 2020 12:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wTmlz5vFMY0R0bZ5rxsydoVfsMQCTTXBvaFVql/cs4=;
        b=csaY3sBLvvdNKpFhZr6O9pnUMEJMoIm/lT92HIQncHIMtnJcrcM6ymbtlA/ProOq/B
         kg9FuXIbz1F38nuvgneG4XMbpD/NApJ0ADlIekMhaNQDGkEainjJh5hwPMgbnwDg38Q8
         6m5uGv7nSIFyyA9CDOwqd/zEz75pWa/o5QHeotKO2IIh/yzJgCG/aC5AS0OCdhnOOPqs
         pApk1awXQJgvVgXqifuW5xqwaSHhKRiiMEawzo1OuhfVimg44rBXtuz+Uk7Pgu3OIkCi
         ry+wY/ho6Av1SBZa968hhGPZA/3j1QHYfKIDTA7XmrzKzoop+q3kpXLvwvIPQFSDspDq
         hiYw==
X-Gm-Message-State: AOAM531xx8zbFOraxiwqGk3+WeTxiy7V+BT4It9mpaihNcEKaWAZ3CZw
        M4C5JLZgNpZRSw2OVsMDKf0=
X-Google-Smtp-Source: ABdhPJzrHe3OsKLomCzElEm8SHCkklZcRQw751KbzXj+XhIRQilwoLEBIht3WkAVOCeod1sf5RArVg==
X-Received: by 2002:aa7:9e4e:: with SMTP id z14mr10041044pfq.60.1596743477781;
        Thu, 06 Aug 2020 12:51:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a? ([2601:647:4802:9070:d88d:857c:b14c:519a])
        by smtp.gmail.com with ESMTPSA id cv3sm8368633pjb.45.2020.08.06.12.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 12:51:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
To:     Leon Romanovsky <leonro@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com, jgg@mellanox.com,
        dledford@redhat.com, oren@mellanox.com
References: <20200805121231.166162-1-maxg@mellanox.com>
 <20200805131644.GJ4432@unreal>
 <3777c9d9-1d36-f8e0-624f-aa633fd517ab@mellanox.com>
 <20200805160601.GL4432@unreal>
 <6cd8d78e-3017-696b-508c-73c3c8b92802@mellanox.com>
 <20200805163738.GM4432@unreal>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5364b857-fb44-78ab-85e9-d0e6700ae7c1@grimberg.me>
Date:   Thu, 6 Aug 2020 12:51:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805163738.GM4432@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> I reviewed this patch and didn't find any justification for performance
> claim, can you please provide us numbers before/after so we will be able
> to decide based on reliable data? It will help us to review our drivers
> and improve them even more.

I don't see any reason to find evidence in justification here. It's a
fastpath call, which is unlikely to fail, and these macros are
considered common practice.

There is no reason to make Max to go and quantify a micro-optimization.
