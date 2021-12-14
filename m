Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F60D474A7B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 19:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhLNSJD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 13:09:03 -0500
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net ([173.201.193.107]:56060
        "EHLO p3plsmtpa08-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230205AbhLNSJC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 13:09:02 -0500
Received: from [192.168.0.100] ([98.118.115.249])
        by :SMTPAUTH: with ESMTPSA
        id xCEWmxHk13bRFxCEXmgLuZ; Tue, 14 Dec 2021 11:09:01 -0700
X-CMAE-Analysis: v=2.4 cv=M7OIlw8s c=1 sm=1 tr=0 ts=61b8ddbd
 a=T+zzzuy42cdAS+8Djmhmkg==:117 a=T+zzzuy42cdAS+8Djmhmkg==:17
 a=IkcTkHD0fZMA:10 a=OLL_FvSJAAAA:8 a=4G91KBac-zdFnW2vvykA:9 a=QEXdDO2ut3YA:10
 a=hElz_HbCIN8A:10 a=VbPY3t8NEt0A:10 a=oIrB72frpwYPwTMnlWqB:22
X-SECURESERVER-ACCT: tom@talpey.com
Message-ID: <22f9f724-380c-978c-fc4d-729006c12a5b@talpey.com>
Date:   Tue, 14 Dec 2021 13:09:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] RDMA/irdma: Make the source udp port vary
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     yanjun.zhu@linux.dev, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
References: <20211214054227.1071338-1-yanjun.zhu@linux.dev>
 <b80a409d-3404-75d2-449e-7b8f41296f26@talpey.com>
 <20211214172951.GI6467@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20211214172951.GI6467@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKFLPdY49vMk2WaMm39K8nahIlDSKs+jUukRb6zLXhoa9l98azqrLRUiW4IlnPXVlO5QJQM6vcz0afmsQFLpFmUIgK74pMvxv1u79sRxWKYDiKeOSATC
 26zDeQ9YxY9CJz0iqXxdTVZnC4rN2ldJdah9eJLQMgqzVY4eiEWMTl/02j3twRZHnhrls0QO42wvS5ZayfVKl5RByxO0V028CDlNfMeYVz9385zlxawCy/xG
 754uxg6lZLz+z8qYyTPpcrYC6ZJIKhkcoJeOoaGXada7PNTs2/g2bPrBAI2mWXheEhumlzTO8Y3CtkqGH8PX+nFHcclm9bD+jbcCSlDibWPMySzNb72dWvuH
 jQL8j3ef
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/14/2021 12:29 PM, Jason Gunthorpe wrote:
> On Tue, Dec 14, 2021 at 12:27:24PM -0500, Tom Talpey wrote:
>> On 12/14/2021 12:42 AM, yanjun.zhu@linux.dev wrote:
>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>
>>> Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
>>> get the source udp port number for a QP based on the local QPN. This
>>> provides a better spread of traffic across NIC RX queues.  The method in
>>> the commit d3c04a3a6870 ("IB/rxe: vary the source udp port for receive
>>> scaling") is stable. So it is also adopted in this commit.
>>>
>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>    drivers/infiniband/hw/irdma/verbs.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>>> index 102dc9342f2a..2697b40a539e 100644
>>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>>> @@ -690,6 +690,11 @@ static int irdma_cqp_create_qp_cmd(struct irdma_qp *iwqp)
>>>    	return status ? -ENOMEM : 0;
>>>    }
>>> +static inline u16 irdma_get_src_port(struct irdma_qp *iwqp)
>>> +{
>>> +	return 0xc000 + (hash_32_generic(iwqp->ibqp.qp_num, 14) & 0x3fff);
>>> +}
>>
>> How do you ensure the resulting port number is not already in use?
> 
> It doesn't matter, it is never used by anything, the receiver captures
> all data with the roce dport and ignores the sport

It still violates core networking addressing principles, and will
mightily confuse a network capture that's filtering on source ports.
Firewalls, ICMP, and similar fabric behaviors may also interfere.

SoftRoCE is forced to register/reserve the source port, isn't it?

Tom.
