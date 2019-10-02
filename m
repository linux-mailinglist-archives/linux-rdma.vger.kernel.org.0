Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86372C901C
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfJBRoC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 13:44:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36040 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBRoC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 13:44:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23so3732962pgk.3
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 10:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2UtS3aIABb7h9UOfHg+JzHaeYyT0/ZbNIN0TO4TZCa8=;
        b=RsIC8/l5vrqaKIMXRqLFZlPbjhfY3mTNuT27i91rsV2iRwhOAdY+d8COiaISVvytiW
         MzdcdEq0jE6jQna4rtT7avJip8NOyIkhRYyuY8ycRmyA8xgoaD4DIB8GeSec3D6qyGnu
         FrbcZrVSOJw7S/kWNuZUsayyuTvM6N3XBL2fmuk0nYX52P9fpTip+exL3XDa017KDdVN
         ExbhYLsa9aUarlOgHiDI041Qg6jKRqoj2Gvvkb2WDLPNhbshqwtQFeLaWLw9MsAvsSom
         fkoUyBFrnLdMEnIodVj7V/TrbpC//C89xr8TeeKlKGgIvMyWgXxYj0wbnjDTAEGIZtZ5
         4tWw==
X-Gm-Message-State: APjAAAW9GbLx0euGTOVgJlolofsy9qn0gcV0g2F6T5d4WQmkHP5lvtbI
        kSxmz8cgmABV8LPnRShPR78=
X-Google-Smtp-Source: APXvYqx0H8oKaqlUO1En0JV3CvRa+TgvdVyc34iuHYBQO1K0MYCFAB6dhUuImjg57Q4CzZm57Oo1IQ==
X-Received: by 2002:a63:465c:: with SMTP id v28mr5063273pgk.310.1570038241243;
        Wed, 02 Oct 2019 10:44:01 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id h2sm86968pfq.108.2019.10.02.10.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:44:00 -0700 (PDT)
Subject: Re: [PATCH 09/15] RDMA/srpt: Fix handling of SR-IOV and iWARP ports
To:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-10-bvanassche@acm.org>
 <20191002141451.GA17152@ziepe.ca>
 <cb5c838a-4a0e-7cac-cc0a-ae218b34d50f@acm.org>
 <20191002165100.GF17152@ziepe.ca> <20191002172416.GJ5855@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8518f1f1-1a1f-0157-b5cf-9b7f0fcfc7b9@acm.org>
Date:   Wed, 2 Oct 2019 10:43:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191002172416.GJ5855@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/2/19 10:24 AM, Leon Romanovsky wrote:
> On Wed, Oct 02, 2019 at 01:51:00PM -0300, Jason Gunthorpe wrote:
>> On Wed, Oct 02, 2019 at 08:21:45AM -0700, Bart Van Assche wrote:
>>> On 10/2/19 7:14 AM, Jason Gunthorpe wrote:
>>>> On Mon, Sep 30, 2019 at 04:17:01PM -0700, Bart Van Assche wrote:
>>>>> Management datagrams (MADs) are not supported by SR-IOV VFs nor by
>>>>> iWARP
>>>>
>>>> Really? This seems surprising to me..
>>>
>>> Hi Jason,
>>>
>>> Last time I checked the Mellanox drivers allow MADs to be sent over a
>>> SR-IOV VF but do not allow MADs to be received through such a VF.
>>
>> I think that is only true of mlx4, mlx5 allows receive, AFAIK
>>
>> I don't know if registering a mad agent fails though. Jack?
> 
> According to internal mlx5 specification, MAD is fully operational for
> every Virtual HCA used to connect such virtual devices to IBTA
> virtualization spec.
> 
>   "Each PCI function (PF or VF) represents a vHCA. Each vHCA virtual port
>    is mapped to an InfiniBand vport. The mapping is arbitrary and determined
>    by the device, as the InfiniBand management is agnostic to it (the
>    InfiniBand specification has no notion of hosts or PCI functions)."
> 
> Most probably the observed by Bart behaviour is related to the fact that
> vport0 has special meaning to allow legacy SMs to connect.

Hi Jason and Leon,

Is it essential that we figure out which HCAs support MADs for VFs or is 
it perhaps sufficient that I change the description of this patch such 
that it mentions that device management and MAD support is not 
guaranteed to be available?

Thanks,

Bart.

