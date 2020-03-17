Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22361889BA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCQQED (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 12:04:03 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41047 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgCQQED (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 12:04:03 -0400
Received: by mail-pf1-f173.google.com with SMTP id z65so12187910pfz.8
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 09:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zaqmSU7pVQacdkrogINHa+leDGYLEH4AwcN6oMad/6c=;
        b=dL7E+pJKl6SMlnwtmKVw4MuNULkuYatN6OPWXQ6XtRMIhQz/VbyJJ9beVEBZps+yU8
         PBl/4YK2HCGhv14sAlljgXpWTon+MeXetBOPwaKmlZzD/NaDUE1n2w+C8a0OXShhKrV6
         /lzsXu8OGsVoWaP6On5YWn5l/H6+6VZPor6m0G0eNXZix1sVOcWoLEAKNbKt+rNaN9zj
         vBbi2WKK9d/fQqHRHh7JLCo0+iDwk8R3SJUVkHSHybrhxI2d8PD2bwYyhKN6ST0beEoJ
         s/e5ebqf0POVk2IEbJypOE0YfQ/3PtXEa4LrYNL2tUAQahYP+8CWVbJlBg7OsiCXDqKb
         iYXg==
X-Gm-Message-State: ANhLgQ2OlxTnHo+ylCacIdJ7K/yIeDXhOcSf/BbcYPb/5WG5x3E8meGG
        aQZoYNr9j86VeLIdlVcTcPk=
X-Google-Smtp-Source: ADFU+vs/2udCc4tTHwUfkYFVi59jpBl7zqx4RQRkghOcbVmJvmxBzJ6ZkSLewMeseYC5EqKZkOeWEA==
X-Received: by 2002:a63:be49:: with SMTP id g9mr5911104pgo.30.1584461040531;
        Tue, 17 Mar 2020 09:04:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:29c1:6aa4:fe4b:2f81? ([2601:647:4802:9070:29c1:6aa4:fe4b:2f81])
        by smtp.gmail.com with ESMTPSA id b133sm3239806pga.43.2020.03.17.09.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 09:03:59 -0700 (PDT)
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
To:     Christoph Hellwig <hch@lst.de>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <20200316162008.GA7001@chelsio.com>
 <20200317124533.GB12316@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
Date:   Tue, 17 Mar 2020 09:03:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200317124533.GB12316@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Mon, Mar 16, 2020 at 09:50:10PM +0530, Krishnamraju Eraparaju wrote:
>>
>> I'm seeing broken CRCs at NVMeF target while running the below program
>> at host. Here RDMA transport is SoftiWARP, but I'm also seeing the
>> same issue with NVMe/TCP aswell.
>>
>> It appears to me that the same buffer is being rewritten by the
>> application/ULP before getting the completion for the previous requests.
>> getting the completion for the previous requests. HW based
>> HW based trasports(like iw_cxgb4) are not showing this issue because
>> they copy/DMA and then compute the CRC on copied buffer.
> 
> For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think that
> is a good idea as pretty much all RDMA block drivers rely on the
> DMA behavior above.  The answer is to bounce buffer the data in
> SoftiWARP / SoftRoCE.

We already do, see nvme_alloc_ns.
