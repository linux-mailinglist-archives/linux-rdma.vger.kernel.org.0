Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D30037CE2F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 19:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhELRDg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 13:03:36 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:51824 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbhELQPV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 12:15:21 -0400
Received: by mail-pj1-f42.google.com with SMTP id k5so4197996pjj.1
        for <linux-rdma@vger.kernel.org>; Wed, 12 May 2021 09:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7PcZ4OA9VLB05I8vuEMVpELWUm55hCKbKjpjARuWgY=;
        b=NO7B9C4CCNoU8VYdT9hoHSQMqhkLrhMFPmJ3MIKawmx2WaRXChiP5WIUmXTrVAfCvA
         JCIwg7aHrWzXFdCPgbSKMqewR2s1c7DNuLmVqq42s5hadfn9dLcw5iOpboBIOfVv372w
         qJIcKWLu5NPDpt0/JemdznGCb2Edl8RlwPvkKm95u85hLM5Z1iM5psKuEj3ij/3jy1sq
         N08j+H+xmEx+TK7rfeBnI/VflAzBjBIotH+Dr0oQtPs2TxmGAEmeKW+AwBAX4z8IjpP4
         Sim3oQevBDzyJliRvoNuscjy7nB96smN08P0+yPy/vO6S4IGFzDT6HCItwd7XAl31pKw
         hHnw==
X-Gm-Message-State: AOAM5322xK5dtg/hF5EmUeA9azPjADmMcRG75crnpp7hqocAoFPNyL+k
        jEq3Es9CrJ/ytP5O5l9QL0o=
X-Google-Smtp-Source: ABdhPJy4ySZhO3sRTjPnwttCG83YI+S/x37Iog3447hvEAal6Nuh6FuBXUp7fiSZKBs0VHky5a67PQ==
X-Received: by 2002:a17:90a:df08:: with SMTP id gp8mr41156054pjb.199.1620836052884;
        Wed, 12 May 2021 09:14:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:993e:1516:b2ba:76fe? ([2601:647:4000:d7:993e:1516:b2ba:76fe])
        by smtp.gmail.com with ESMTPSA id p15sm238155pfn.197.2021.05.12.09.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 09:14:12 -0700 (PDT)
Subject: Re: [PATCH 4/5] RDMA/srp: Fix a recently introduced memory leak
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-5-bvanassche@acm.org>
 <e7e0bb73-4bcc-61f7-1db8-67a676150a26@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <84dd1e27-2143-32a7-0535-cfbe4fdc65cc@acm.org>
Date:   Wed, 12 May 2021 09:14:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <e7e0bb73-4bcc-61f7-1db8-67a676150a26@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/12/21 1:15 AM, Max Gurtovoy wrote:
> maybe we can remove the local mr_list variable while we're here ?
> 
> otherwise,
> 
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Hi Max,

I will remove the mr_list variable if I have to repost this patch series.

Thanks,

Bart.


