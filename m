Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A247E2E9
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 21:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfHATBX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 15:01:23 -0400
Received: from p3plsmtpa06-01.prod.phx3.secureserver.net ([173.201.192.102]:47875
        "EHLO p3plsmtpa06-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732059AbfHATBU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 15:01:20 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 15:01:20 EDT
Received: from [10.0.0.150] ([76.19.228.129])
        by :SMTPAUTH: with ESMTPSA
        id tGDBhmB1OAihHtGDBh4SEQ; Thu, 01 Aug 2019 11:54:02 -0700
Subject: Re: [PATCH for-rc] siw: MPA Reply handler tries to read beyond MPA
 message
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, krishn2@chelsio.com
References: <20190731103310.23199-1-krishna2@chelsio.com>
 <OF4DB6F345.7C76F976-ON00258449.00392FF3-00258449.003C1BFB@notes.na.collabserv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <8499b96a-48dd-1286-ea0f-e66be34afffa@talpey.com>
Date:   Thu, 1 Aug 2019 14:53:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <OF4DB6F345.7C76F976-ON00258449.00392FF3-00258449.003C1BFB@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFqGnNQwQkrPGAKnBwDDzlCBZgI50cWrYRF9FmTN8QZO/FBzp8pI3jcIDCmBlxpZ2WidPn+2WCDmDZB9gJ6DW9mfSD+t7IZX+a+fW88nWdUw9Dg9Ze/W
 MHmjMNetchkoe3D8xf/USlMj5eo5QoALVf85IfGjBlmM9nG7YfK9gdZJm1lfODuKotPt7pFV4Jieo7kvSmKZfMcXJLVsOXZf8DjTcKGgP9vddwPcPmTlgP/C
 hP36Wm8GUZt51iw0iGTPPAAOUX1c6IkOCBIp0fG0HbaB0ZVqiQgGihEWsdXATn2AjUvesb9G4UDY4HtpGKzosN56HKw6zp7Yh4EE+qozqLvTGZbhpf91HRWA
 sIc6W3NZ
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/1/2019 6:56 AM, Bernard Metzler wrote:
> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> 
>> To: jgg@ziepe.ca, bmt@zurich.ibm.com
>> From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> Date: 07/31/2019 12:34PM
>> Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
>> nirranjan@chelsio.com, krishn2@chelsio.com, "Krishnamraju Eraparaju"
>> <krishna2@chelsio.com>
>> Subject: [EXTERNAL] [PATCH for-rc] siw: MPA Reply handler tries to
>> read beyond MPA message
>>
>> while processing MPA Reply, SIW driver is trying to read extra 4
>> bytes
>> than what peer has advertised as private data length.
>>
>> If a FPDU data is received before even siw_recv_mpa_rr() completed
>> reading MPA reply, then ksock_recv() in siw_recv_mpa_rr() could also
>> read FPDU, if "size" is larger than advertised MPA reply length.
>>
>> 501 static int siw_recv_mpa_rr(struct siw_cep *cep)
>> 502 {
>>           .............
>> 572
>> 573         if (rcvd > to_rcv)
>> 574                 return -EPROTO;   <----- Failure here
>>
>> Looks like the intention here is to throw an ERROR if the received
>> data
>> is more than the total private data length advertised by the peer.
>> But
>> reading beyond MPA message causes siw_cm to generate
>> RDMA_CM_EVENT_CONNECT_ERROR event when TCP socket recv buffer is
>> already
>> queued with FPDU messages.
>>
>> Hence, this function should only read upto private data length.
>>
>> Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> ---
>> drivers/infiniband/sw/siw/siw_cm.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> b/drivers/infiniband/sw/siw/siw_cm.c
>> index a7cde98e73e8..8dc8cea2566c 100644
>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> @@ -559,13 +559,13 @@ static int siw_recv_mpa_rr(struct siw_cep *cep)
>> 	 * A private data buffer gets allocated if hdr->params.pd_len != 0.
>> 	 */
>> 	if (!cep->mpa.pdata) {
>> -		cep->mpa.pdata = kmalloc(pd_len + 4, GFP_KERNEL);
>> +		cep->mpa.pdata = kmalloc(pd_len, GFP_KERNEL);
>> 		if (!cep->mpa.pdata)
>> 			return -ENOMEM;
>> 	}
>> 	rcvd = ksock_recv(
>> 		s, cep->mpa.pdata + cep->mpa.bytes_rcvd - sizeof(struct mpa_rr),
>> -		to_rcv + 4, MSG_DONTWAIT);
>> +		to_rcv, MSG_DONTWAIT);
>>
>> 	if (rcvd < 0)
>> 		return rcvd;
>> -- 
>> 2.23.0.rc0
>>
>>
> 
> The intention of this code is to make sure the
> peer does not violates the MPA handshake rules.
> The initiator MUST NOT send extra data after its
> MPA request and before receiving the MPA reply.

I think this is true only for MPA v2. With MPA v1, the
initiator can begin sending immediately (before receiving
the MPA reply), because there is no actual negotiation at
the MPA layer.

With MPA v2, the negotiation exchange is required because
the type of the following message is predicated by the
"Enhanced mode" a|b|c|d flags present in the first 32 bits
of the private data buffer.

So, it seems to me that additional logic is needed here to
determine the MPA version, before sniffing additional octets
from the incoming stream?

Tom.


> So, for the MPA request case, this code is needed
> to check for protocol correctness.
> You are right for the MPA reply case - if we are
> _not_ in peer2peer mode, the peer can immediately
> start sending data in RDMA mode after its MPA Reply.
> So we shall add appropriate code to be more specific
> For an error, we are (1) processing an MPA Request,
> OR (2) processing an MPA Reply AND we are not expected
> to send an initial READ/WRITE/Send as negotiated with
> the peer (peer2peer mode MPA handshake).
> 
> Just removing this check would make siw more permissive,
> but to a point where peer MPA protocol errors are
> tolerated. I am not in favor of that level of
> forgiveness.
> 
> If possible, please provide an appropriate patch
> or (if it causes current issues with another peer
> iWarp implementation) just run in MPA peer2peer mode,
> where the current check is appropriate.
> Otherwise, I would provide an appropriate fix by Monday
> (I am still out of office this week).
> 
> 
> Many thanks and best regards,
> Bernard.
> 
> 
> 
