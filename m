Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5594F188A89
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgCQQjm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 12:39:42 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:36321 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQQjm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 12:39:42 -0400
Received: by mail-pf1-f176.google.com with SMTP id i13so12265228pfe.3
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 09:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D8YKEpilntC6PLM52SDOesP+siUQz9f0pY/yd7M7yZs=;
        b=A57G8hkqxrkbqYyx9GFfE4eCZSosNbkj4zP9uX6NGFYL+AtDuutXTRWR/z+bSHnRet
         eRHBDaz908LNaQIZeCffAHEYCxnAmCZVvjz7ilmLIKEJI/rkrfJ6RTVUkOfcUOZcNtjL
         fFQc1p+LNYwPa0/Jo5pNzbro5jgzBIQvKpKGYsmP0IiUjXjePAGtAkmYiSTOODi6AYgz
         bnv/xV65MtwA/8YYF+pDS47n9FiUw62ygZ1qW3WWL3omiT+Nwn+sMrll26ORS7iSixxl
         /PxmTNTzNL3Iq7Q0gdaWXQVnGHkUv0Sk3BsGlxqkk0FjQYPiwUMeTK7Y10aKnJzSJp//
         4QOA==
X-Gm-Message-State: ANhLgQ26T/pKCHpYBQzj2xJrjOitbZzuocInU4xLLaql+X+LHgGkNYVQ
        Hwo6EV+BzX/8gKmgOLrBTvHa7aCB
X-Google-Smtp-Source: ADFU+vst0PWpw3o8HeyxJqN6Qrl1fz4MuzhJCYFQDBvMYy9P+adoxekZihnV7W1X+NAW65fpg/EWjg==
X-Received: by 2002:aa7:9839:: with SMTP id q25mr6161796pfl.2.1584463180925;
        Tue, 17 Mar 2020 09:39:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:29c1:6aa4:fe4b:2f81? ([2601:647:4802:9070:29c1:6aa4:fe4b:2f81])
        by smtp.gmail.com with ESMTPSA id 189sm3795672pfw.203.2020.03.17.09.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 09:39:40 -0700 (PDT)
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
 <20200316162008.GA7001@chelsio.com> <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
Date:   Tue, 17 Mar 2020 09:39:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think
>> that
>>> is a good idea as pretty much all RDMA block drivers rely on the
>>> DMA behavior above.  The answer is to bounce buffer the data in
>>> SoftiWARP / SoftRoCE.
>>
>> We already do, see nvme_alloc_ns.
>>
>>
> 
> Krishna was getting the issue when testing TCP/NVMeF with -G
> during connect. That enables data digest and STABLE_WRITES
> I think. So to me it seems we don't get stable pages, but
> pages which are touched after handover to the provider.

Non of the transports modifies the data at any point, both will
scan it to compute crc. So surely this is coming from the fs,
Krishna does this happen with xfs as well?
