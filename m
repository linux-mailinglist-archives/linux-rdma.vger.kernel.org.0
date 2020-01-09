Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877401355EB
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 10:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgAIJiP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 04:38:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39971 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbgAIJiO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 04:38:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so6474695ljk.7
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jan 2020 01:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gcQepeyN8a6junsMRn+7ni8VGHABXKHWE7W1EIdhZfs=;
        b=owlLCQXLOttB/ajmIM/Pc71l01CpbIpJgFMAPVBrOQkVsK91jbtivfmyySrGcn0l5x
         5DIXsgLprVyhnkPlyij4lEvW0/ZKkpiktqph26M4EJx2nCUkPv3ATPtbKOgXOng8UdUa
         CRg2kEyD+wfiljYgu57wLpw3j+f6fuZv1Js+bNa/VclcH7L4LbaFu2s8XypcfrwEVdWl
         aIZRvQ2fbPM+VJRiT7AZyF4KUwCsLeGI93YiyIVot6/okdT/HyXtJo56De+nsMhW6VWq
         flTesu2g9ezPk8H/BQYN6MEfTRcnx5zVsC+LFjlMAbFebD3vrXNnDncErGD2XhZMknb1
         PjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gcQepeyN8a6junsMRn+7ni8VGHABXKHWE7W1EIdhZfs=;
        b=j3wnJiJt15na7Drp+Y3fN0mCrc5bM2dNmy7bbxil6sKWoH0G40PtPFJ6I8T3Yg1fpY
         tXzH6EFi1p+ZcL9KpPBWew10l+31sztAmW4ccM9Pt1oRo4d7CzUIvcBF3+SwkdA89Ixn
         kmg8NCyZLCu1XI1qSddPOQ8S2pzBEv6KzEHQvZMdbZa3Wv1aC4YZHrcm6XR/jujyoqRT
         K9+m6lXuVmLclvao9p19xAXG/6K6BnddYmsQZm3blFRiV+jpB/nK1HBbt4xskr07sPfK
         1IL0iWYafo+NFKEZ3239IRl5gyFa1IRmwqiqzz4XM2JwKvTS20qfeiahPFsm91UMjY9f
         SA4w==
X-Gm-Message-State: APjAAAXz8+iNSm3OkKyUP/ZgLuWyIKv5tA9fhQ3xb31ENLBRRoI9fMfU
        +0rlep0ZMl8P73HrR1lcbrtGWQ==
X-Google-Smtp-Source: APXvYqxDJMnX64C1vg8pg4K5D3CklsaMkELPgUFRUawQLQol3vZoCWl9QdvyNDGFoZrt79WRuuzBGg==
X-Received: by 2002:a2e:88c4:: with SMTP id a4mr5761257ljk.174.1578562692487;
        Thu, 09 Jan 2020 01:38:12 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:42d7:1b7d:a8a2:6efa:9cbd:1aee? ([2a00:1fa0:42d7:1b7d:a8a2:6efa:9cbd:1aee])
        by smtp.gmail.com with ESMTPSA id a21sm2779568lfg.44.2020.01.09.01.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 01:38:11 -0800 (PST)
Subject: Re: [PATCH rdma-next 08/10] RDMA/uverbs: Add new relaxed ordering
 memory region access flag
To:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        jgg@mellanox.com, dledford@redhat.com
Cc:     saeedm@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com,
        netdev@vger.kernel.org
References: <1578506740-22188-1-git-send-email-yishaih@mellanox.com>
 <1578506740-22188-9-git-send-email-yishaih@mellanox.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1a3a3132-67a3-15ba-805f-0eb1c42e78e6@cogentembedded.com>
Date:   Thu, 9 Jan 2020 12:38:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578506740-22188-9-git-send-email-yishaih@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 08.01.2020 21:05, Yishai Hadas wrote:

> From: Michael Guralnik <michaelgur@mellanox.com>
> 
> Adding new relaxed ordering access flag for memory regions.
> Using memory regions with relaxed ordeing set can enhance performance.

   Ordering. :-)

> This access flag is handled in a best-effort manner, drivers should
> ignore if they don't support setting relaxed ordering.
> 
> Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
[...]

MBR, Sergei
