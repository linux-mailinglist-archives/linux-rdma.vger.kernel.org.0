Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5064D3D07C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404494AbfFKPLK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 11:11:10 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:59404
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404488AbfFKPLK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 11:11:10 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id aiQWh78jCZelWaiQXhc3yI; Tue, 11 Jun 2019 08:11:09 -0700
Subject: Re: receive side CRC computation in siw.
To:     Bernard Metzler <BMT@zurich.ibm.com>, linux-rdma@vger.kernel.org
References: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
Date:   Tue, 11 Jun 2019 11:11:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF7NRUYvMJo5l6JatjC5JnfId2U1QrN4gvobiZ2ltIi/Oc68eu/B4ua6PZqjOWpGCNST04ZZDuPccihtphOiU/pb1+Nhf471vyrisQ2tTv1MKsx5YI/e
 kqt8D3UGGsDYl1MFDXcW3wn2etWkLMCwBgL7i6bzAImIPkpYKuJu0xQtVRsVXFghxtUkviGPktEjW5sZ+t3uPMMyK7HtkrFLKPA=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/11/2019 9:21 AM, Bernard Metzler wrote:
> Hi all,
> 
> If enabled for siw, during receive operation, a crc32c over
> header and data is being generated and checked. So far, siw
> was generating that CRC from the content of the just written
> target buffer. What kept me busy last weekend were spurious
> CRC errors, if running qperf. I finally found the application
> is constantly writing the target buffer while data are placed
> concurrently, which sometimes races with the CRC computation
> for that buffer, and yields a broken CRC.

Well, that's a clear bug in the application, assuming siw has
not yet delivered a send completion for the operation using
the buffer. This is a basic Verbs API contract.

> siw uses skb_copy_bits() to move the data. I now added an
> extra round of skb walking via __skb_checksum() in front of
> it, which resolves the issue. Unfortunately, performance
> significantly drops with that (some 30% or worse compared
> to generating the CRC from a linear buffer).
> 
> To preserve performance for kernel clients, I propose
> checksumming the data before the copy only for user
> land applications, and leave it as is for kernel clients.
> I am not aware of kernel clients which are constantly
> reading/writing a target buffer to detect it has been written.

This, too, is an invalid application. The RDMA provider is free
to write the target buffer at any time. Many implementations
take full advantage of this by placing received RDMA Writes
in memory prior to validating their packets' checksum(s). If
there is a mismatch, retries are initiated. The realtime
contents of the buffers, prior to a completion, are undefined.

Tom.

> I also checked other kernel code using skb_copy_bits(),
> which also needs to checksum the received data. Those code
> (such as nvme tcp) also does the CRC on the linear buffer
> after data receive.
> 
> The best solution might be to fold the CRC into the
> skb_copy_bits() function itself. That being something we
> might propose later?
> 
> Thoughts?
> 
> 
> Many thanks,
> Bernard.
> 
> 
> 
