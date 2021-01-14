Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79E32F56B6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 02:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbhANBwA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 20:52:00 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:37475 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbhANAJS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jan 2021 19:09:18 -0500
Received: by mail-wr1-f42.google.com with SMTP id v15so290378wrx.4
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jan 2021 16:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/GCgNA51WuXbHuVgatrvFPHJcyg7zuGxdJstK5KiOo4=;
        b=j9NE2k2R+RQADDMRpOLyzja+T01EFv1OoXY20VmEZVDiBjUI9WCZaHln8WrTcZ7c5S
         c7T0KTyHjHGz4GvMG5X2LMuN3E8nrhsTaXje4/S+cNV2PDDnKEai8/uyGw4Cx5M+PHFk
         9xzWbXDVzfH79h2Pl7gzrNCX+KuIccg87D3a5NkHOiR0rOBILQG7W/GdQpDzBAUkDNty
         wjAsNATYLuVUJqIuO1LB8ccvwHzTNmR+stpii8PF5/mxlI6pJHNd3ZhtnB39mn9Fg0AV
         s870JYwNjLV/ijmr6ekeBzAQGaKd/x5u8hULngYmdXtqTc6dnQ8N043gn+xDySC17HPd
         A95Q==
X-Gm-Message-State: AOAM530Rn/KTCi/dg5EypmRbRA5Phd+Sgq4PrUPTot1OfPrX8xxYLWb4
        cgHjtKA6JpQRltWUFTVGvNM=
X-Google-Smtp-Source: ABdhPJzDK435sYmFZZH6vQaMH2TnjIE9PsgH0F9PdCYt6rUAlss8JEVttlU8xNArIGbhIkkYrquslQ==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr5109642wrx.170.1610582912641;
        Wed, 13 Jan 2021 16:08:32 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id j59sm7166094wrj.13.2021.01.13.16.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 16:08:32 -0800 (PST)
Subject: Re: [PATCH 3/3] IB/isert: simplify signature cap check
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        dledford@redhat.com, jgg@nvidia.com, leonro@nvidia.com
Cc:     oren@nvidia.com, Israel Rukshin <israelr@nvidia.com>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
 <20210110111903.486681-3-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ea24823d-c1e9-d40f-866b-6671a13c08ad@grimberg.me>
Date:   Wed, 13 Jan 2021 16:08:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210110111903.486681-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Use if/else clause instead of "condition ? val1 : val2" to make the code
> cleaner and simpler.

Not sure what is cleaner and simpler for a simple condition, but I don't
mind either way...

Acked-by: Sagi Grimberg <sagi@grimberg.me>
