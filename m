Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACE72A6B63
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKDRG5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 12:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgKDRG5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 12:06:57 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B844C0613D3
        for <linux-rdma@vger.kernel.org>; Wed,  4 Nov 2020 09:06:57 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id w145so17220455oie.9
        for <linux-rdma@vger.kernel.org>; Wed, 04 Nov 2020 09:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VzTLjkoNm/RdWOjobsidL8J+o3Q4uPEunA42l6dCsjI=;
        b=orwZFP0Q6DmGPZMvuw5vTVLEnav20+6dfAcTqLz+4zBSLDvrlVFMgLZsoPZWkTHsr4
         Ueu73zKVjynZsQ5XMmtIM+XeErI3qB5AVwV6JIE7090tlY7TaZdI2UaiDNqYPeQLcNNR
         VB243u0vQwD/Dni+s/8bLKtMWMbXUf2up3Z3ayzulreZRkckSrCsUZz7LcmibXA5Mgvf
         jTQD4C9t6qhLRuptLHHC35xBoVNOXYHDAvFF5sCF6QsNqXVQ0eMTRm30SkQBUy6fBfTS
         +SiaReLNgoanVbbzHtfz4V8Asnflu4mhZP33LQyEiB3a60WnYhJVWRJZMnKkQMTkQ+oO
         8ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VzTLjkoNm/RdWOjobsidL8J+o3Q4uPEunA42l6dCsjI=;
        b=RGF2ydsun/+32rbdGcsI4ByK+0c9chxkMikPuEpjCvUULb6pBfjq2qg3d/ZDNHW0sQ
         JD4KNEy5CzIIeEpGK+pXmYy9jdp8ru0IXEqDqE2hsAGuXd9ht+XNi/O88qiIm+IMRLnP
         fn0v5NPsxgLAIt+CuadYXLxSwgX8Wnv+GCTPd7m9pczuu7hLkzcLFPejkVneL3ijs6xs
         9QeTu9/DfigDJ2FY7ntWTXxkanbDGhN4YsacezZdOraZZID3/+XVPtpGf6TDzewEFOe8
         d16ADm+hPGYtH33ySSlM2N8S6jZUJpH/2KED8UfnqylEuEGQswbs0HdAXk60sqvP/fDp
         DUOA==
X-Gm-Message-State: AOAM533NKoFDbqCALyAlozOHHtQCTPgndgLzJ3RVZmjlfuJ1/m3KCJ0U
        yzJVhnliPxeK/idB7CtmHksn0gWL05g=
X-Google-Smtp-Source: ABdhPJyZA7MAl88Rp7cRFJlfULQ2cM08ER0+2pPnS3C6uzfNZGFUwTTXo6KseoYkbBjg6hniN3bodQ==
X-Received: by 2002:a05:6808:98f:: with SMTP id a15mr3236748oic.102.1604509616389;
        Wed, 04 Nov 2020 09:06:56 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:1c77:3258:9ca4:99ae? (2603-8081-140c-1a00-1c77-3258-9ca4-99ae.res6.spectrum.com. [2603:8081:140c:1a00:1c77:3258:9ca4:99ae])
        by smtp.gmail.com with ESMTPSA id f34sm599923otb.34.2020.11.04.09.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 09:06:55 -0800 (PST)
Subject: Re: pyverbs test regression
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
 <OFB1D10315.3DD6DADF-ON00258616.004C490E-00258616.004C4915@notes.na.collabserv.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <ddac88a4-4a79-2685-d28d-301614a58644@gmail.com>
Date:   Wed, 4 Nov 2020 11:06:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <OFB1D10315.3DD6DADF-ON00258616.004C490E-00258616.004C4915@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/4/20 7:53 AM, Bernard Metzler wrote:
> -----"Bob Pearson" <rpearsonhpe@gmail.com> wrote: -----
> 
>> To: "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky"
>> <leon@kernel.org>
>> From: "Bob Pearson" <rpearsonhpe@gmail.com>
>> Date: 11/04/2020 12:55AM
>> Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
>> Subject: [EXTERNAL] pyverbs test regression
>>
>> Since 5.10 some of the pyverbs tests are skipping with the warning
>> 	"Device rxe_0 doesn't have net interface"
>>
>> These occur in tests/test_rdmacm.py. As far as I can tell the error
>> occurs in
>>
>> RDMATestCase _add_gids_per_port after the following
>>
>> 	    if not
>> os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>>                self.args.append([dev, port, idx, None])
>>                continue
>>
>> In fact there is no such path which means it never finds an ip_addr
>> for the device.
>>
>> Did something change here? Do other RDMA devices have
>> /sys/class/infiniband/XXX/device/net?
>>
> 
> Hmm, with 5.10.0-rc1, I still see it for both rdma_rxe and siw. 
> 

Bernard,

	The script I use to setup the rxe device is

export LD_LIBRARY_PATH=/home/rpearson/src/rdma-core/build/lib/
sudo ip link set dev enp6s0 mtu 4500
sudo ip addr add dev enp6s0 scope link fe80::b62e:99ff:fef9:fa2e/64
sudo rdma link add rxe_0 type rxe netdev enp6s0

	After running this the rxe device is functional but I get

rpearson$ ls /sys/class/infiniband/rxe_0
fw_ver     node_guid  parent  power      sys_image_guid
node_desc  node_type  ports   subsystem  uevent

	with no 'device'. How are you seeing 'device'? We should be running the same bits.

Bob
