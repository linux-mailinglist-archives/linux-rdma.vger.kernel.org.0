Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38EA188E15
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 20:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgCQTdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 15:33:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33756 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQTdv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 15:33:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so27265916wrd.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 12:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tGF1AP9wuTljWGrzhtbqei8g10fJ49+iakdT7NknjKE=;
        b=Zu12KXCXji2UaxnnFtO4tSm8i0rfw+sFNmehWZ+hS/yjKQWU7fbSmeglmyNuyl92QF
         aN9IuYYQzZhUSicDWEit8WusSQi7rQwTTD70iDmx7hC+tp4ghZlhC2JGYsh1vfZ9Ep0x
         SovqbJ9623+ju4DxX//7hr/EX9DJ97f0yG54v7qfIPRlq5z1fLOf0qLxYzdj5T4s/FLH
         rB3iUpHx9D0DnFVREpIrm7/RI/XkdgKGdKjfKms/QjqakKmYF4FpwVBijo11eiN0Vs5b
         k6xlgpvr77thP8b334nb4+PvwZJOMVIkVQgDlyazGSf3HuOA67Xho0p0WSXN591mrRME
         G9PA==
X-Gm-Message-State: ANhLgQ3LUBFkjbAmpFE9jGYym4jwFNvo5wsDO7iWcWMbl6RW0OJqKG7o
        geVaD3t3koBATJHfpFGvy4TXMc66
X-Google-Smtp-Source: ADFU+vtGc54xQl2qkaVng8B35498da2QRFht/t7nTlwt3sL7/sWk9Z5pE9snJjZqC5/ob4qcLVZK3Q==
X-Received: by 2002:adf:a4d2:: with SMTP id h18mr663061wrb.90.1584473629799;
        Tue, 17 Mar 2020 12:33:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:29c1:6aa4:fe4b:2f81? ([2601:647:4802:9070:29c1:6aa4:fe4b:2f81])
        by smtp.gmail.com with ESMTPSA id i4sm5914217wrm.32.2020.03.17.12.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 12:33:49 -0700 (PDT)
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
 <20200316162008.GA7001@chelsio.com> <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
 <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
 <20200317191743.GA22065@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
Date:   Tue, 17 Mar 2020 12:33:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200317191743.GA22065@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>>> For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think
>>>> that
>>>>> is a good idea as pretty much all RDMA block drivers rely on the
>>>>> DMA behavior above.  The answer is to bounce buffer the data in
>>>>> SoftiWARP / SoftRoCE.
>>>>
>>>> We already do, see nvme_alloc_ns.
>>>>
>>>>
>>>
>>> Krishna was getting the issue when testing TCP/NVMeF with -G
>>> during connect. That enables data digest and STABLE_WRITES
>>> I think. So to me it seems we don't get stable pages, but
>>> pages which are touched after handover to the provider.
>>
>> Non of the transports modifies the data at any point, both will
>> scan it to compute crc. So surely this is coming from the fs,
>> Krishna does this happen with xfs as well?
> Yes, but rare(took ~15min to recreate), whereas with ext3/4
> its almost immediate. Here is the error log for NVMe/TCP with xfs.

Thanks Krishna,

I assume that this makes the issue go away?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 11e10fe1760f..cc93e1949b2c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -889,7 +889,7 @@ static int nvme_tcp_try_send_data(struct 
nvme_tcp_request *req)
                         flags |= MSG_MORE;

                 /* can't zcopy slab pages */
-               if (unlikely(PageSlab(page))) {
+               if (unlikely(PageSlab(page)) || queue->data_digest) {
                         ret = sock_no_sendpage(queue->sock, page, 
offset, len,
                                         flags);
                 } else {
--
